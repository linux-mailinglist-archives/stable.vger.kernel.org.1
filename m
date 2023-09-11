Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A5F79B743
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359669AbjIKWSU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239798AbjIKO3E (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:29:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB771F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:28:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C03C433C8;
        Mon, 11 Sep 2023 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442539;
        bh=9fqjBwv2LBwO4nIds1qbI4+GaoStwo+5qp+YVqfuzpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=va0/RCq2kLSzNnh17BqCg508vk95mDuOCY8UV6S3VZq/VIx6dykb3lKslOTb+pW7F
         K+f/28QNRVs2kGp1nHOOzLyNkJ8Y702e3WsaLG718IWjPRy7N38jUCddAVo9J6W0K/
         sVUS6gTDRjrX1FpjPU2NeL4i+2QuetFG4cQjN4lQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Winston Wen <wentao@uniontech.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 025/737] cifs: fix charset issue in reconnection
Date:   Mon, 11 Sep 2023 15:38:04 +0200
Message-ID: <20230911134651.082226690@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Winston Wen <wentao@uniontech.com>

[ Upstream commit a43f95fdd39490f7b156fd126f1e90ec2d5553f1 ]

We need to specify charset, like "iocharset=utf-8", in mount options for
Chinese path if the nls_default don't support it, such as iso8859-1, the
default value for CONFIG_NLS_DEFAULT.

But now in reconnection the nls_default is used, instead of the one we
specified and used in mount, and this can lead to mount failure.

Signed-off-by: Winston Wen <wentao@uniontech.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h | 1 +
 fs/smb/client/cifssmb.c  | 3 +--
 fs/smb/client/connect.c  | 5 +++++
 fs/smb/client/misc.c     | 1 +
 fs/smb/client/smb2pdu.c  | 3 +--
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index ca2da713c5fe9..87c6ce54c72d0 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1062,6 +1062,7 @@ struct cifs_ses {
 	unsigned long chans_need_reconnect;
 	/* ========= end: protected by chan_lock ======== */
 	struct cifs_ses *dfs_root_ses;
+	struct nls_table *local_nls;
 };
 
 static inline bool
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index a0c4e9874b010..a49f95ea7cf6f 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -129,7 +129,7 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	}
 	spin_unlock(&server->srv_lock);
 
-	nls_codepage = load_nls_default();
+	nls_codepage = ses->local_nls;
 
 	/*
 	 * need to prevent multiple threads trying to simultaneously
@@ -200,7 +200,6 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 		rc = -EAGAIN;
 	}
 
-	unload_nls(nls_codepage);
 	return rc;
 }
 
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 853209268f507..e965196e4f746 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1837,6 +1837,10 @@ static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 			    CIFS_MAX_PASSWORD_LEN))
 			return 0;
 	}
+
+	if (strcmp(ctx->local_nls->charset, ses->local_nls->charset))
+		return 0;
+
 	return 1;
 }
 
@@ -2280,6 +2284,7 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 
 	ses->sectype = ctx->sectype;
 	ses->sign = ctx->sign;
+	ses->local_nls = load_nls(ctx->local_nls->charset);
 
 	/* add server as first channel */
 	spin_lock(&ses->chan_lock);
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 70dbfe6584f9e..d7e85d9a26553 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -95,6 +95,7 @@ sesInfoFree(struct cifs_ses *buf_to_free)
 		return;
 	}
 
+	unload_nls(buf_to_free->local_nls);
 	atomic_dec(&sesInfoAllocCount);
 	kfree(buf_to_free->serverOS);
 	kfree(buf_to_free->serverDomain);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index e04766fe6f803..a457f07f820dc 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -242,7 +242,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	}
 	spin_unlock(&server->srv_lock);
 
-	nls_codepage = load_nls_default();
+	nls_codepage = ses->local_nls;
 
 	/*
 	 * need to prevent multiple threads trying to simultaneously
@@ -324,7 +324,6 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		rc = -EAGAIN;
 	}
 failed:
-	unload_nls(nls_codepage);
 	return rc;
 }
 
-- 
2.40.1



