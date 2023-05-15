Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA697038D8
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244447AbjEORfb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244489AbjEORfJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892F715607
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05C4261EEF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF01CC4339C;
        Mon, 15 May 2023 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171987;
        bh=vl+moLX2PUd01Hhe6ZpxAD8Crz/zCowVUH3ljoOjytg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBI2TDiiYMXv0+EdvCPTPKna+Ay0OLfi6MBNIbAdGxgGDoN02Lov4oOWrpuEDEurQ
         pMX4VekmRmneH4tjkxZPmCJQknDZCnozRwZlag5rXA5ycmbBBLU6BJvTllZuRzz6HR
         a9KdW8p9F/ObpkWkHPPTqTFEJRN715ZDx5SM31ao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ziwei Xie <zw.xie@high-flyer.cn>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 110/134] ksmbd: set RSS capable in FSCTL_QUERY_NETWORK_INTERFACE_INFO
Date:   Mon, 15 May 2023 18:29:47 +0200
Message-Id: <20230515161706.781489695@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit a58b45a4dbfd0bf2ebb157789da4d8e6368afb1b ]

Set RSS capable in FSCTL_QUERY_NETWORK_INTERFACE_INFO if netdev has
multi tx queues. And add ksmbd_compare_user() to avoid racy condition
issue in ksmbd_free_user(). because windows client is simultaneously used
to send session setup requests for multichannel connection.

Tested-by: Ziwei Xie <zw.xie@high-flyer.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 7b4323373d84 ("ksmbd: fix deadlock in ksmbd_find_crypto_ctx()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/mgmt/user_config.c | 10 ++++++++++
 fs/ksmbd/mgmt/user_config.h |  1 +
 fs/ksmbd/smb2pdu.c          | 15 ++++++++++-----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/mgmt/user_config.c b/fs/ksmbd/mgmt/user_config.c
index 1019d3677d553..279d00feff216 100644
--- a/fs/ksmbd/mgmt/user_config.c
+++ b/fs/ksmbd/mgmt/user_config.c
@@ -67,3 +67,13 @@ int ksmbd_anonymous_user(struct ksmbd_user *user)
 		return 1;
 	return 0;
 }
+
+bool ksmbd_compare_user(struct ksmbd_user *u1, struct ksmbd_user *u2)
+{
+	if (strcmp(u1->name, u2->name))
+		return false;
+	if (memcmp(u1->passkey, u2->passkey, u1->passkey_sz))
+		return false;
+
+	return true;
+}
diff --git a/fs/ksmbd/mgmt/user_config.h b/fs/ksmbd/mgmt/user_config.h
index aff80b0295790..6a44109617f14 100644
--- a/fs/ksmbd/mgmt/user_config.h
+++ b/fs/ksmbd/mgmt/user_config.h
@@ -64,4 +64,5 @@ struct ksmbd_user *ksmbd_login_user(const char *account);
 struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp);
 void ksmbd_free_user(struct ksmbd_user *user);
 int ksmbd_anonymous_user(struct ksmbd_user *user);
+bool ksmbd_compare_user(struct ksmbd_user *u1, struct ksmbd_user *u2);
 #endif /* __USER_CONFIG_MANAGEMENT_H__ */
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 22d9fcb5f7ca4..c8c2b326ee042 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1463,10 +1463,16 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 			ksmbd_free_user(user);
 			return 0;
 		}
-		ksmbd_free_user(sess->user);
+
+		if (!ksmbd_compare_user(sess->user, user)) {
+			ksmbd_free_user(user);
+			return -EPERM;
+		}
+		ksmbd_free_user(user);
+	} else {
+		sess->user = user;
 	}
 
-	sess->user = user;
 	if (user_guest(sess->user)) {
 		rsp->SessionFlags = SMB2_SESSION_FLAG_IS_GUEST_LE;
 	} else {
@@ -2071,9 +2077,6 @@ int smb2_session_logoff(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "request\n");
 
-	/* Got a valid session, set connection state */
-	WARN_ON(sess->conn != conn);
-
 	/* setting CifsExiting here may race with start_tcp_sess */
 	ksmbd_conn_set_need_reconnect(work);
 	ksmbd_close_session_fds(work);
@@ -7302,6 +7305,8 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 		nii_rsp->IfIndex = cpu_to_le32(netdev->ifindex);
 
 		nii_rsp->Capability = 0;
+		if (netdev->real_num_tx_queues > 1)
+			nii_rsp->Capability |= cpu_to_le32(RSS_CAPABLE);
 		if (ksmbd_rdma_capable_netdev(netdev))
 			nii_rsp->Capability |= cpu_to_le32(RDMA_CAPABLE);
 
-- 
2.39.2



