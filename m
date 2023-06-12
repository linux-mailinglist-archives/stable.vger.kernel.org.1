Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36D972B823
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 08:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjFLGfA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 02:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjFLGet (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 02:34:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CA51717
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 23:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D4A661F91
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 06:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFA2C433D2;
        Mon, 12 Jun 2023 06:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686551239;
        bh=bygE85h9KYcNqUg72GSGqDuDJfHaYqHV6bmzobl7ohY=;
        h=Subject:To:Cc:From:Date:From;
        b=qlA6M8QPf138/DufkBAHwgUn8YzR76WhJxu5MdKZ8/H4ZH91AHJHiAvifFmCrxIXa
         uUf2o/BI5AWoZ/EwyNz/2F1L7ilLuBVkDQrFgvxKEJ++I5iS9OSnXdvmr24RUtfG5o
         CBJqPxN3ww1HPzJG7bksokd/mQGhigapfIVboT1E=
Subject: FAILED: patch "[PATCH] ksmbd: fix out-of-bound read in deassemble_neg_contexts()" failed to apply to 5.15-stable tree
To:     linkinjeon@kernel.org, cc85nod@gmail.com, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 08:27:16 +0200
Message-ID: <2023061216-striking-darkened-f7a5@gregkh>
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
git cherry-pick -x f1a411873c85b642f13b01f21b534c2bab81fc1b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061216-striking-darkened-f7a5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f1a411873c85b642f13b01f21b534c2bab81fc1b Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 28 May 2023 00:23:09 +0900
Subject: [PATCH] ksmbd: fix out-of-bound read in deassemble_neg_contexts()

The check in the beginning is
`clen + sizeof(struct smb2_neg_context) <= len_of_ctxts`,
but in the end of loop, `len_of_ctxts` will subtract
`((clen + 7) & ~0x7) + sizeof(struct smb2_neg_context)`, which causes
integer underflow when clen does the 8 alignment. We should use
`(clen + 7) & ~0x7` in the check to avoid underflow from happening.

Then there are some variables that need to be declared unsigned
instead of signed.

[   11.671070] BUG: KASAN: slab-out-of-bounds in smb2_handle_negotiate+0x799/0x1610
[   11.671533] Read of size 2 at addr ffff888005e86cf2 by task kworker/0:0/7
...
[   11.673383] Call Trace:
[   11.673541]  <TASK>
[   11.673679]  dump_stack_lvl+0x33/0x50
[   11.673913]  print_report+0xcc/0x620
[   11.674671]  kasan_report+0xae/0xe0
[   11.675171]  kasan_check_range+0x35/0x1b0
[   11.675412]  smb2_handle_negotiate+0x799/0x1610
[   11.676217]  ksmbd_smb_negotiate_common+0x526/0x770
[   11.676795]  handle_ksmbd_work+0x274/0x810
...

Cc: stable@vger.kernel.org
Signed-off-by: Chih-Yen Chang <cc85nod@gmail.com>
Tested-by: Chih-Yen Chang <cc85nod@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 7a81541de602..25c0ba04c59d 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -963,13 +963,13 @@ static void decode_sign_cap_ctxt(struct ksmbd_conn *conn,
 
 static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 				      struct smb2_negotiate_req *req,
-				      int len_of_smb)
+				      unsigned int len_of_smb)
 {
 	/* +4 is to account for the RFC1001 len field */
 	struct smb2_neg_context *pctx = (struct smb2_neg_context *)req;
 	int i = 0, len_of_ctxts;
-	int offset = le32_to_cpu(req->NegotiateContextOffset);
-	int neg_ctxt_cnt = le16_to_cpu(req->NegotiateContextCount);
+	unsigned int offset = le32_to_cpu(req->NegotiateContextOffset);
+	unsigned int neg_ctxt_cnt = le16_to_cpu(req->NegotiateContextCount);
 	__le32 status = STATUS_INVALID_PARAMETER;
 
 	ksmbd_debug(SMB, "decoding %d negotiate contexts\n", neg_ctxt_cnt);
@@ -983,7 +983,7 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 	while (i++ < neg_ctxt_cnt) {
 		int clen, ctxt_len;
 
-		if (len_of_ctxts < sizeof(struct smb2_neg_context))
+		if (len_of_ctxts < (int)sizeof(struct smb2_neg_context))
 			break;
 
 		pctx = (struct smb2_neg_context *)((char *)pctx + offset);
@@ -1038,9 +1038,8 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 		}
 
 		/* offsets must be 8 byte aligned */
-		clen = (clen + 7) & ~0x7;
-		offset = clen + sizeof(struct smb2_neg_context);
-		len_of_ctxts -= clen + sizeof(struct smb2_neg_context);
+		offset = (ctxt_len + 7) & ~0x7;
+		len_of_ctxts -= offset;
 	}
 	return status;
 }

