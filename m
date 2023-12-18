Return-Path: <stable+bounces-7658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E028175A6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8371B1F20F9E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74FE7608C;
	Mon, 18 Dec 2023 15:36:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17175760B2
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cd54e5fbb2so1073490a12.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913816; x=1703518616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YE493zWQsnfcX4DnOZ2gO1oivB7dQhll3Qzsw9AyGg=;
        b=CK6Oz092wyJd47KD2nq88kY/d2EKh0OIcG+7B9Rk8c/yJRrAyTt30Ueco19xv9sBG3
         9QUjsu4HzoW8fU+zmBYefpdn+T48p5qmN6mKCF6bxU/aprNxPTDtL08zd6DidVFOXlTv
         E4kJmV0iVsS6s9B2HmSC31ZcMH5REV03i6c1J8FNFXGJOQyBtjW5Wo+pNSej87wPImpW
         x6yc7OgZH53uDU1sfwmdIZz+EqlBAS2l5BNYZaRLHiiNozeB6P8d+TVAhHLlazzqi5t9
         pC9SNwORn3X1/dybjQflq88XOumUZiQ5HDTBeeq+pdEr8ORQG/mvIcj0GZ/8/eQ14HaR
         5qtA==
X-Gm-Message-State: AOJu0Yx5cy1f8EWXpLag00LaBkACtjb4eHNK6ca9sWr5yuQg+RQsB25D
	5XHpy86OZuwCXqx59uZ1rII=
X-Google-Smtp-Source: AGHT+IGHHes1NiUCU1w0eSChxTwGjXf9cKSF6ubpXw4busf+hC1sGw/2Wja24kh0gZQ12U3cQACS+Q==
X-Received: by 2002:a17:90b:4b01:b0:28a:e9cc:51d9 with SMTP id lx1-20020a17090b4b0100b0028ae9cc51d9mr3454183pjb.18.1702913816328;
        Mon, 18 Dec 2023 07:36:56 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:55 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Jakob Koschel <jakobkoschel@gmail.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 029/154] ksmbd: replace usage of found with dedicated list iterator variable
Date: Tue, 19 Dec 2023 00:32:49 +0900
Message-Id: <20231218153454.8090-30-linkinjeon@kernel.org>
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

From: Jakob Koschel <jakobkoschel@gmail.com>

[ Upstream commit edf5f0548fbb77e20b898460dc25281b0f4d974d ]

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index a5fc7b7fd590..2dc67809a2c7 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6691,8 +6691,7 @@ int smb2_cancel(struct ksmbd_work *work)
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 	struct smb2_hdr *chdr;
-	struct ksmbd_work *cancel_work = NULL;
-	int canceled = 0;
+	struct ksmbd_work *cancel_work = NULL, *iter;
 	struct list_head *command_list;
 
 	ksmbd_debug(SMB, "smb2 cancel called on mid %llu, async flags 0x%x\n",
@@ -6702,11 +6701,11 @@ int smb2_cancel(struct ksmbd_work *work)
 		command_list = &conn->async_requests;
 
 		spin_lock(&conn->request_lock);
-		list_for_each_entry(cancel_work, command_list,
+		list_for_each_entry(iter, command_list,
 				    async_request_entry) {
-			chdr = smb2_get_msg(cancel_work->request_buf);
+			chdr = smb2_get_msg(iter->request_buf);
 
-			if (cancel_work->async_id !=
+			if (iter->async_id !=
 			    le64_to_cpu(hdr->Id.AsyncId))
 				continue;
 
@@ -6714,7 +6713,7 @@ int smb2_cancel(struct ksmbd_work *work)
 				    "smb2 with AsyncId %llu cancelled command = 0x%x\n",
 				    le64_to_cpu(hdr->Id.AsyncId),
 				    le16_to_cpu(chdr->Command));
-			canceled = 1;
+			cancel_work = iter;
 			break;
 		}
 		spin_unlock(&conn->request_lock);
@@ -6722,24 +6721,24 @@ int smb2_cancel(struct ksmbd_work *work)
 		command_list = &conn->requests;
 
 		spin_lock(&conn->request_lock);
-		list_for_each_entry(cancel_work, command_list, request_entry) {
-			chdr = smb2_get_msg(cancel_work->request_buf);
+		list_for_each_entry(iter, command_list, request_entry) {
+			chdr = smb2_get_msg(iter->request_buf);
 
 			if (chdr->MessageId != hdr->MessageId ||
-			    cancel_work == work)
+			    iter == work)
 				continue;
 
 			ksmbd_debug(SMB,
 				    "smb2 with mid %llu cancelled command = 0x%x\n",
 				    le64_to_cpu(hdr->MessageId),
 				    le16_to_cpu(chdr->Command));
-			canceled = 1;
+			cancel_work = iter;
 			break;
 		}
 		spin_unlock(&conn->request_lock);
 	}
 
-	if (canceled) {
+	if (cancel_work) {
 		cancel_work->state = KSMBD_WORK_CANCELLED;
 		if (cancel_work->cancel_fn)
 			cancel_work->cancel_fn(cancel_work->cancel_argv);
-- 
2.25.1


