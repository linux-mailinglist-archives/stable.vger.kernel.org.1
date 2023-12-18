Return-Path: <stable+bounces-7727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD328175F9
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D65B238CE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92E47204A;
	Mon, 18 Dec 2023 15:40:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE4842385
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b4563a03aso810530a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914039; x=1703518839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaVme4x1JzWucLWvJ+/IjgDKmL34flrE2DG+w6ZOMkg=;
        b=myGQIG+WumFILZmrmrE+x8go7CcYzp98BCn+wJ4/PnjZB5PT0PegZ7c/k5isWIpPgf
         mQLnhihcMPzFlUSx3zZdTRCR5sDWk3cDI186zCIKYtSI0Q9Khm/C0b0kc1loyiRjR643
         2T4wmGhIkhHmlgD1QsFsp/Hke8RdcFeeDApZKrsDlbHon29FXHqOOuaEurJzSnVPe59e
         KLJtq+nYmP6Q0Ckqd9+ced5Cj0I/DmbVgLvMXdHC7zlu922EZs3R8miPtjapyxFPpGMU
         OmifUVCSeaOr7ygUjEDGNuYhmWMHoqqCG0/MbRVhw61QrldtO5LMs/zLUGEUoELgYPlW
         5z1Q==
X-Gm-Message-State: AOJu0YzRRu/PS8PljQhJQ/bsjIP+KxuKaxv3YPgV3K+HS3T1eW2X1UTT
	AShklYU9XFuMUBz7zLtepFA=
X-Google-Smtp-Source: AGHT+IELv6NMMyA3Pd6MsFeOJg3I2acvaxvQXqnxeJPgp348jTEJz4tZaiWAcEgAY5bgJKTkcN/E9Q==
X-Received: by 2002:a17:90a:4f05:b0:28b:9618:5f04 with SMTP id p5-20020a17090a4f0500b0028b96185f04mr633204pjh.20.1702914038278;
        Mon, 18 Dec 2023 07:40:38 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:37 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Chih-Yen Chang <cc85nod@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 099/154] ksmbd: fix out-of-bound read in parse_lease_state()
Date: Tue, 19 Dec 2023 00:33:59 +0900
Message-Id: <20231218153454.8090-100-linkinjeon@kernel.org>
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

[ Upstream commit fc6c6a3c324c1b3e93a03d0cfa3749c781f23de0 ]

This bug is in parse_lease_state, and it is caused by the missing check
of `struct create_context`. When the ksmbd traverses the create_contexts,
it doesn't check if the field of `NameOffset` and `Next` is valid,
The KASAN message is following:

[    6.664323] BUG: KASAN: slab-out-of-bounds in parse_lease_state+0x7d/0x280
[    6.664738] Read of size 2 at addr ffff888005c08988 by task kworker/0:3/103
...
[    6.666644] Call Trace:
[    6.666796]  <TASK>
[    6.666933]  dump_stack_lvl+0x33/0x50
[    6.667167]  print_report+0xcc/0x620
[    6.667903]  kasan_report+0xae/0xe0
[    6.668374]  kasan_check_range+0x35/0x1b0
[    6.668621]  parse_lease_state+0x7d/0x280
[    6.668868]  smb2_open+0xbe8/0x4420
[    6.675137]  handle_ksmbd_work+0x282/0x820

Use smb2_find_context_vals() to find smb2 create request lease context.
smb2_find_context_vals validate create context fields.

Cc: stable@vger.kernel.org
Reported-by: Chih-Yen Chang <cc85nod@gmail.com>
Tested-by: Chih-Yen Chang <cc85nod@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/oplock.c | 66 +++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 42 deletions(-)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 28c7f2193fb3..e2fb4631f8f7 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1415,56 +1415,38 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
  */
 struct lease_ctx_info *parse_lease_state(void *open_req)
 {
-	char *data_offset;
 	struct create_context *cc;
-	unsigned int next = 0;
-	char *name;
-	bool found = false;
 	struct smb2_create_req *req = (struct smb2_create_req *)open_req;
-	struct lease_ctx_info *lreq = kzalloc(sizeof(struct lease_ctx_info),
-		GFP_KERNEL);
+	struct lease_ctx_info *lreq;
+
+	cc = smb2_find_context_vals(req, SMB2_CREATE_REQUEST_LEASE, 4);
+	if (IS_ERR_OR_NULL(cc))
+		return NULL;
+
+	lreq = kzalloc(sizeof(struct lease_ctx_info), GFP_KERNEL);
 	if (!lreq)
 		return NULL;
 
-	data_offset = (char *)req + le32_to_cpu(req->CreateContextsOffset);
-	cc = (struct create_context *)data_offset;
-	do {
-		cc = (struct create_context *)((char *)cc + next);
-		name = le16_to_cpu(cc->NameOffset) + (char *)cc;
-		if (le16_to_cpu(cc->NameLength) != 4 ||
-		    strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
-			next = le32_to_cpu(cc->Next);
-			continue;
-		}
-		found = true;
-		break;
-	} while (next != 0);
+	if (sizeof(struct lease_context_v2) == le32_to_cpu(cc->DataLength)) {
+		struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
-	if (found) {
-		if (sizeof(struct lease_context_v2) == le32_to_cpu(cc->DataLength)) {
-			struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
-
-			memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-			lreq->req_state = lc->lcontext.LeaseState;
-			lreq->flags = lc->lcontext.LeaseFlags;
-			lreq->duration = lc->lcontext.LeaseDuration;
-			memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
-			       SMB2_LEASE_KEY_SIZE);
-			lreq->version = 2;
-		} else {
-			struct create_lease *lc = (struct create_lease *)cc;
+		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
+		lreq->req_state = lc->lcontext.LeaseState;
+		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->duration = lc->lcontext.LeaseDuration;
+		memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
+				SMB2_LEASE_KEY_SIZE);
+		lreq->version = 2;
+	} else {
+		struct create_lease *lc = (struct create_lease *)cc;
 
-			memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-			lreq->req_state = lc->lcontext.LeaseState;
-			lreq->flags = lc->lcontext.LeaseFlags;
-			lreq->duration = lc->lcontext.LeaseDuration;
-			lreq->version = 1;
-		}
-		return lreq;
+		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
+		lreq->req_state = lc->lcontext.LeaseState;
+		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->duration = lc->lcontext.LeaseDuration;
+		lreq->version = 1;
 	}
-
-	kfree(lreq);
-	return NULL;
+	return lreq;
 }
 
 /**
-- 
2.25.1


