Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4AF72B85D
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 08:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjFLG5N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 02:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLG5M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 02:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B88BC7
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 23:52:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ABCE61FAD
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 06:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D80C433D2;
        Mon, 12 Jun 2023 06:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686552156;
        bh=D2KNWN68p1M7RfkGyHJ7EXiAuw7D9HkJNBLzqisHLXM=;
        h=Subject:To:Cc:From:Date:From;
        b=zM6zzUON97QcXdg1op6tSFMfWwNvgacyELhbu0gE1qyEGxSFHPK9Vfd2QAhA4eLw1
         gzsblbWKw17PyyA0GxQeuNji5hG3pW2WaVNJikrCM+ziBzaQAFgSBQqrzVK+nWTx0Q
         UX0wj3BlnNSPBneu8csuYnCdKHS6wj5FvScm7fD8=
Subject: FAILED: patch "[PATCH] ksmbd: check the validation of pdu_size in" failed to apply to 5.15-stable tree
To:     linkinjeon@kernel.org, cc85nod@gmail.com, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 08:42:34 +0200
Message-ID: <2023061233-omnivore-cardigan-93f8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
git cherry-pick -x 368ba06881c395f1c9a7ba22203cf8d78b4addc0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061233-omnivore-cardigan-93f8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 368ba06881c395f1c9a7ba22203cf8d78b4addc0 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 30 May 2023 23:10:31 +0900
Subject: [PATCH] ksmbd: check the validation of pdu_size in
 ksmbd_conn_handler_loop

The length field of netbios header must be greater than the SMB header
sizes(smb1 or smb2 header), otherwise the packet is an invalid SMB packet.

If `pdu_size` is 0, ksmbd allocates a 4 bytes chunk to `conn->request_buf`.
In the function `get_smb2_cmd_val` ksmbd will read cmd from
`rcv_hdr->Command`, which is `conn->request_buf + 12`, causing the KASAN
detector to print the following error message:

[    7.205018] BUG: KASAN: slab-out-of-bounds in get_smb2_cmd_val+0x45/0x60
[    7.205423] Read of size 2 at addr ffff8880062d8b50 by task ksmbd:42632/248
...
[    7.207125]  <TASK>
[    7.209191]  get_smb2_cmd_val+0x45/0x60
[    7.209426]  ksmbd_conn_enqueue_request+0x3a/0x100
[    7.209712]  ksmbd_server_process_request+0x72/0x160
[    7.210295]  ksmbd_conn_handler_loop+0x30c/0x550
[    7.212280]  kthread+0x160/0x190
[    7.212762]  ret_from_fork+0x1f/0x30
[    7.212981]  </TASK>

Cc: stable@vger.kernel.org
Reported-by: Chih-Yen Chang <cc85nod@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 4882a812ea86..e11d4a1e63d7 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -294,6 +294,9 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 	return true;
 }
 
+#define SMB1_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb_hdr))
+#define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr) + 4)
+
 /**
  * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
  * @p:		connection instance
@@ -350,6 +353,9 @@ int ksmbd_conn_handler_loop(void *p)
 		if (pdu_size > MAX_STREAM_PROT_LEN)
 			break;
 
+		if (pdu_size < SMB1_MIN_SUPPORTED_HEADER_SIZE)
+			break;
+
 		/* 4 for rfc1002 length field */
 		/* 1 for implied bcc[0] */
 		size = pdu_size + 4 + 1;
@@ -377,6 +383,12 @@ int ksmbd_conn_handler_loop(void *p)
 			continue;
 		}
 
+		if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
+		    SMB2_PROTO_NUMBER) {
+			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
+				break;
+		}
+
 		if (!default_conn_ops.process_fn) {
 			pr_err("No connection request callback\n");
 			break;

