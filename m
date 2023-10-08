Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E327BCFDD
	for <lists+stable@lfdr.de>; Sun,  8 Oct 2023 21:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbjJHToF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 8 Oct 2023 15:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbjJHToF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Oct 2023 15:44:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CD5B3
        for <stable@vger.kernel.org>; Sun,  8 Oct 2023 12:44:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF4CC433C9;
        Sun,  8 Oct 2023 19:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696794243;
        bh=1oErtrPdk++P9fvzbqUjyrxzvxUoUbJb4y65CeSCRBo=;
        h=Subject:To:Cc:From:Date:From;
        b=0v7x+tziYYH2wW2hHMJiuqWy7Flcu2UACovxiJ/lCX1SMgIN2prikuE/42i9qxzmu
         J76rOuK71dOlCW3M/mREPmleRbMwCa3Z+hzkazXFSoGZoN7QIKqpZx/uD574qe4tMj
         pAX6pWUuZEzzcpTNvRdPW+GmHDIlFT1PvSFT/i/0=
Subject: FAILED: patch "[PATCH] ksmbd: fix race condition from parallel smb2 logoff requests" failed to apply to 5.15-stable tree
To:     linkinjeon@kernel.org, rootlab@huawei.com, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 08 Oct 2023 21:43:49 +0200
Message-ID: <2023100849-celibacy-urchin-788f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7ca9da7d873ee8024e9548d3366101c2b6843eab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100849-celibacy-urchin-788f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

7ca9da7d873e ("ksmbd: fix race condition from parallel smb2 logoff requests")
e2b76ab8b5c9 ("ksmbd: add support for read compound")
e202a1e8634b ("ksmbd: no response from compound read")
7b7d709ef7cf ("ksmbd: add missing compound request handing in some commands")
81a94b27847f ("ksmbd: use kvzalloc instead of kvmalloc")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
30210947a343 ("ksmbd: fix racy issue under cocurrent smb2 tree disconnect")
abcc506a9a71 ("ksmbd: fix racy issue from smb2 close and logoff with multichannel")
ea174a918939 ("ksmbd: destroy expired sessions")
f5c779b7ddbd ("ksmbd: fix racy issue from session setup and logoff")
74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
34e8ccf9ce24 ("ksmbd: set NegotiateContextCount once instead of every inc")
42bc6793e452 ("Merge tag 'pull-lock_rename_child' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs into ksmbd-for-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ca9da7d873ee8024e9548d3366101c2b6843eab Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 4 Oct 2023 18:30:14 +0900
Subject: [PATCH] ksmbd: fix race condition from parallel smb2 logoff requests

If parallel smb2 logoff requests come in before closing door, running
request count becomes more than 1 even though connection status is set to
KSMBD_SESS_NEED_RECONNECT. It can't get condition true, and sleep forever.
This patch fix race condition problem by returning error if connection
status was already set to KSMBD_SESS_NEED_RECONNECT.

Reported-by: luosili <rootlab@huawei.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b9d6e8e451ba..e774c9855f7f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2164,17 +2164,17 @@ int smb2_session_logoff(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "request\n");
 
-	sess_id = le64_to_cpu(req->hdr.SessionId);
-
-	rsp->StructureSize = cpu_to_le16(4);
-	err = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_logoff_rsp));
-	if (err) {
-		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+	ksmbd_conn_lock(conn);
+	if (!ksmbd_conn_good(conn)) {
+		ksmbd_conn_unlock(conn);
+		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
 		smb2_set_err_rsp(work);
-		return err;
+		return -ENOENT;
 	}
-
+	sess_id = le64_to_cpu(req->hdr.SessionId);
 	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_RECONNECT);
+	ksmbd_conn_unlock(conn);
+
 	ksmbd_close_session_fds(work);
 	ksmbd_conn_wait_idle(conn, sess_id);
 
@@ -2196,6 +2196,14 @@ int smb2_session_logoff(struct ksmbd_work *work)
 	ksmbd_free_user(sess->user);
 	sess->user = NULL;
 	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_NEGOTIATE);
+
+	rsp->StructureSize = cpu_to_le16(4);
+	err = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_logoff_rsp));
+	if (err) {
+		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+		smb2_set_err_rsp(work);
+		return err;
+	}
 	return 0;
 }
 

