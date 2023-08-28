Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A208578ADC0
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjH1Kui (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjH1KuJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AF7CC6
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C42363874
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B35C433C7;
        Mon, 28 Aug 2023 10:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219787;
        bh=cOmNiqVv5dKYUSPPUlk/l2j+W2SFSVjCbrK8nsCR+Ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZcrwq0bG1t+8dWuC2lJGg1S+NRe+7/033xkTSKa5ISo+BZAUgBqPQBfwJ5xKtpnv
         M7idSzCFDeWrpTgQsVo5/h1VusftSdVCFuWRyvLnTUpiceXqm5crIhW9/xMR+S+ok/
         Vo4IuqZifEfDplPxThX+rxu/oFc9o8MADvV0iO+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Trond Myklebust <trondmy@hammerspace.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.10 43/84] NFSv4: Fix dropped lock for racing OPEN and delegation return
Date:   Mon, 28 Aug 2023 12:14:00 +0200
Message-ID: <20230828101150.723572183@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
References: <20230828101149.146126827@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Coddington <bcodding@redhat.com>

commit 1cbc11aaa01f80577b67ae02c73ee781112125fd upstream.

Commmit f5ea16137a3f ("NFSv4: Retry LOCK on OLD_STATEID during delegation
return") attempted to solve this problem by using nfs4's generic async error
handling, but introduced a regression where v4.0 lock recovery would hang.
The additional complexity introduced by overloading that error handling is
not necessary for this case.  This patch expects that commit to be
reverted.

The problem as originally explained in the above commit is:

    There's a small window where a LOCK sent during a delegation return can
    race with another OPEN on client, but the open stateid has not yet been
    updated.  In this case, the client doesn't handle the OLD_STATEID error
    from the server and will lose this lock, emitting:
    "NFS: nfs4_handle_delegation_recall_error: unhandled error -10024".

Fix this by using the old_stateid refresh helpers if the server replies
with OLD_STATEID.

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4proc.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7046,8 +7046,15 @@ static void nfs4_lock_done(struct rpc_ta
 		} else if (!nfs4_update_lock_stateid(lsp, &data->res.stateid))
 			goto out_restart;
 		break;
-	case -NFS4ERR_BAD_STATEID:
 	case -NFS4ERR_OLD_STATEID:
+		if (data->arg.new_lock_owner != 0 &&
+			nfs4_refresh_open_old_stateid(&data->arg.open_stateid,
+					lsp->ls_state))
+			goto out_restart;
+		if (nfs4_refresh_lock_old_stateid(&data->arg.lock_stateid, lsp))
+			goto out_restart;
+		fallthrough;
+	case -NFS4ERR_BAD_STATEID:
 	case -NFS4ERR_STALE_STATEID:
 	case -NFS4ERR_EXPIRED:
 		if (data->arg.new_lock_owner != 0) {


