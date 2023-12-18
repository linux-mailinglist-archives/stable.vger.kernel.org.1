Return-Path: <stable+bounces-7726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D48218175F7
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5099CB23B3E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696847204C;
	Mon, 18 Dec 2023 15:40:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B07144D
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28b48f70766so731772a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914035; x=1703518835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C92nyoe8+swD4PzMbt1A1bnfmTvwqwHg1cv4Ih9pdhY=;
        b=k/Yi5SAogsvVF8NzGS1eJsrzf464cy9Uzoc+S/B10+DoHl6MMyEzGFq7bCCAcsvI55
         rldq/DAmGUH3W9rCq8l0GzwGC7WfKCJsRrEhPHj2/kozpWcZRgFxeVM7lYD2C6PDIENY
         JqaigwpSz1AgfDoxw1hSk0m2vR97obhO6V0aYJwRY55WNnl1SPqhWn4JGX+oAaGZpwc9
         u/YMLQgoCOBjfpxuQE1cj+r1UzcslmdOVefot1ehv6VTfRsUZ33qVfmTGgHThtOHUdVc
         EU92LvSImAEkE+qz7ZJBaIPWODqRQrL4dVDEwEDqkJayvoenxj3JBXCiH2ZqjLoi6XsC
         Lrwg==
X-Gm-Message-State: AOJu0YwCbS9nRUeDUjjH0dpYVwaOCHPttnAZ2cDbG+AnPFY3YlFf2cMd
	vEJiGA6I6Szdfz7dil7OOEw=
X-Google-Smtp-Source: AGHT+IGLOH2YuIppcUnuCgGJajDapjtOFcFZS9rk9CG/DUBhg9BO17M+5UXRJnzv+bev0F6yFEd/Qg==
X-Received: by 2002:a17:90b:4ac8:b0:28b:4a30:cf42 with SMTP id mh8-20020a17090b4ac800b0028b4a30cf42mr824530pjb.38.1702914035206;
        Mon, 18 Dec 2023 07:40:35 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:34 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Chih-Yen Chang <cc85nod@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 098/154] ksmbd: fix out-of-bound read in deassemble_neg_contexts()
Date: Tue, 19 Dec 2023 00:33:58 +0900
Message-Id: <20231218153454.8090-99-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/ksmbd/smb2pdu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 62bcc440ad31..d25d3a046a7f 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -997,13 +997,13 @@ static void decode_sign_cap_ctxt(struct ksmbd_conn *conn,
 
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
@@ -1017,7 +1017,7 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 	while (i++ < neg_ctxt_cnt) {
 		int clen, ctxt_len;
 
-		if (len_of_ctxts < sizeof(struct smb2_neg_context))
+		if (len_of_ctxts < (int)sizeof(struct smb2_neg_context))
 			break;
 
 		pctx = (struct smb2_neg_context *)((char *)pctx + offset);
@@ -1072,9 +1072,8 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
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
-- 
2.25.1


