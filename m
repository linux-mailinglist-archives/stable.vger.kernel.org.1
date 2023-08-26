Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DD37898DA
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 21:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjHZT60 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 15:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjHZT5y (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 15:57:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246B4D8
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 12:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1AAB615F8
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 19:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA642C433C7;
        Sat, 26 Aug 2023 19:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693079871;
        bh=GoQl3ahbdtoLt4WZqI81N9OPEE4PKNNd96ICoyF+/Z8=;
        h=Subject:To:Cc:From:Date:From;
        b=ASa3/+25U863nT+lEDcCSLLwyIwn3fMzm74yS4iNCV7rA3pVPNfCRBAPDdPk9YQhB
         s9/43CM+lSjmJQS26/4ahl1Pquu3oGzYVPl0Vo3FmmZuae/fcWwV77By5uG/PxxxfR
         MY9BuADyUVUmlsSBpzAEhPctwrrqHNJIb97cfI/I=
Subject: FAILED: patch "[PATCH] NFSv4: Fix dropped lock for racing OPEN and delegation return" failed to apply to 4.19-stable tree
To:     bcodding@redhat.com, trond.myklebust@hammerspace.com,
        trondmy@hammerspace.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 26 Aug 2023 21:57:13 +0200
Message-ID: <2023082613-lilac-overpower-64a2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 1cbc11aaa01f80577b67ae02c73ee781112125fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082613-lilac-overpower-64a2@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

1cbc11aaa01f ("NFSv4: Fix dropped lock for racing OPEN and delegation return")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1cbc11aaa01f80577b67ae02c73ee781112125fd Mon Sep 17 00:00:00 2001
From: Benjamin Coddington <bcodding@redhat.com>
Date: Fri, 30 Jun 2023 09:18:13 -0400
Subject: [PATCH] NFSv4: Fix dropped lock for racing OPEN and delegation return

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

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e1a886b58354..4604e9f3d1b0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7181,8 +7181,15 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
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

