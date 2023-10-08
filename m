Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844517BCFDB
	for <lists+stable@lfdr.de>; Sun,  8 Oct 2023 21:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbjJHToA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 8 Oct 2023 15:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344551AbjJHToA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Oct 2023 15:44:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E16B3
        for <stable@vger.kernel.org>; Sun,  8 Oct 2023 12:43:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99214C433C7;
        Sun,  8 Oct 2023 19:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696794237;
        bh=qzVyob1bUFDQBpEWhRqzczoJEnkiUXFnJ6svqD5imtw=;
        h=Subject:To:Cc:From:Date:From;
        b=sVTylHCF8g5oK95nUYVPmeqNBTB3rJlgPUyNRoIZpZjVB6K1yXaJG8ouLOH37Rprb
         At00hIK5avfVNye3QylsZfiE7+R70I/oH38G68rwEIjh5I3aIeJOrzyy7dvhDbjeZX
         UmuSL1FmqI0Mm5OfA9k10pdFVs/XTJvRaFBs9tPE=
Subject: FAILED: patch "[PATCH] ksmbd: fix race condition from parallel smb2 logoff requests" failed to apply to 6.5-stable tree
To:     linkinjeon@kernel.org, rootlab@huawei.com, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 08 Oct 2023 21:43:48 +0200
Message-ID: <2023100847-hatless-limpness-7ec6@gregkh>
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


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 7ca9da7d873ee8024e9548d3366101c2b6843eab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100847-hatless-limpness-7ec6@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

7ca9da7d873e ("ksmbd: fix race condition from parallel smb2 logoff requests")
e2b76ab8b5c9 ("ksmbd: add support for read compound")

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
 

