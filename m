Return-Path: <stable+bounces-8125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AA681A4A6
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475BE28C4DD
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD54487B0;
	Wed, 20 Dec 2023 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PdS5IGY5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271EC487A3;
	Wed, 20 Dec 2023 16:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAAEC433C7;
	Wed, 20 Dec 2023 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088983;
	bh=+RZsJeBD2cZvIhcnPgpI4i6HzkykeEdDpx6dUJnXaQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PdS5IGY5sPjvJ6o2QwkFyc8VXSsFKqZAv0J3yc8tf41kheJZu36kgLf121N836R3y
	 hMyKKlJp8DWHmXm8auU+a0YIbV2orxvACfr4Qlhq2shjeZec0qXpa7lu2LIbEq83FH
	 E4sDEHMH9l8UteZ323eHakbe4pztEByYtBQCtV34=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chih-Yen Chang <cc85nod@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 098/159] ksmbd: fix out-of-bound read in deassemble_neg_contexts()
Date: Wed, 20 Dec 2023 17:09:23 +0100
Message-ID: <20231220160935.923558970@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit f1a411873c85b642f13b01f21b534c2bab81fc1b ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -997,13 +997,13 @@ static void decode_sign_cap_ctxt(struct
 
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
@@ -1017,7 +1017,7 @@ static __le32 deassemble_neg_contexts(st
 	while (i++ < neg_ctxt_cnt) {
 		int clen, ctxt_len;
 
-		if (len_of_ctxts < sizeof(struct smb2_neg_context))
+		if (len_of_ctxts < (int)sizeof(struct smb2_neg_context))
 			break;
 
 		pctx = (struct smb2_neg_context *)((char *)pctx + offset);
@@ -1072,9 +1072,8 @@ static __le32 deassemble_neg_contexts(st
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



