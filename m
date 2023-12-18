Return-Path: <stable+bounces-7745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B08F817615
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FC1B2425C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137F974E03;
	Mon, 18 Dec 2023 15:41:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C228374092
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b3dd5b242so1241655a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914095; x=1703518895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuX5t2Q0hEemzmndDApMuk/jIRDjqvginoGMIWffaLE=;
        b=w26VK/faRm/7YIwp3tQ1IhtomQWwtJIXmbc8J/Tmi7Oy69VxQ1aVI/jths0Ua0ICAx
         utGhBTMD8l6EUW2hPjXfbAbbSD1NRgMSpxYji+cuAKSo5i4k43mh19Plq3sl+zvuirUW
         0nJ0W6D2dYDycBxi+vF6GN7/sBwhM/wHvsXAoVLbDMEHC3B0k6nra+ic2Rjzy+c3Q9tw
         qoYcw34yijqi7Lte6IhckRx0fV2Xd0WqC8l2/NvFa7k5FvAxQZleKlwkT1dPFtWjwx3a
         U5qh2s3oGl63sk0poGq3PAmwhawtmgG331GvxK7QPII7XJZfhZmBD1T2aJvIOLOJtYbt
         ZgBw==
X-Gm-Message-State: AOJu0YxlQ/6a5I4Xhy1zciduNS4iLTmgtcxEOdLmECsXafcH2Okij1SP
	ZqlMD8TpxWp/HQ3eiJQiyb8=
X-Google-Smtp-Source: AGHT+IEyUQviImQK928PFpdxLqiJ7WtaaKUEbSRtVeFCI6nnykTvDWdGxTqBmo+Ca1zN57r42Xc5Cw==
X-Received: by 2002:a17:90a:d78a:b0:28b:a173:36ca with SMTP id z10-20020a17090ad78a00b0028ba17336camr539175pju.53.1702914094504;
        Mon, 18 Dec 2023 07:41:34 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:34 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 116/154] ksmbd: validate session id and tree id in compound request
Date: Tue, 19 Dec 2023 00:34:16 +0900
Message-Id: <20231218153454.8090-117-linkinjeon@kernel.org>
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

[ Upstream commit 3df0411e132ee74a87aa13142dfd2b190275332e ]

`smb2_get_msg()` in smb2_get_ksmbd_tcon() and smb2_check_user_session()
will always return the first request smb2 header in a compound request.
if `SMB2_TREE_CONNECT_HE` is the first command in compound request, will
return 0, i.e. The tree id check is skipped.
This patch use ksmbd_req_buf_next() to get current command in compound.

Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21506
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 870b0fc9d2f3..27c86f2de393 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -87,9 +87,9 @@ struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn
  */
 int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 {
-	struct smb2_hdr *req_hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *req_hdr = ksmbd_req_buf_next(work);
 	unsigned int cmd = le16_to_cpu(req_hdr->Command);
-	int tree_id;
+	unsigned int tree_id;
 
 	if (cmd == SMB2_TREE_CONNECT_HE ||
 	    cmd ==  SMB2_CANCEL_HE ||
@@ -114,7 +114,7 @@ int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 			pr_err("The first operation in the compound does not have tcon\n");
 			return -EINVAL;
 		}
-		if (work->tcon->id != tree_id) {
+		if (tree_id != UINT_MAX && work->tcon->id != tree_id) {
 			pr_err("tree id(%u) is different with id(%u) in first operation\n",
 					tree_id, work->tcon->id);
 			return -EINVAL;
@@ -560,9 +560,9 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
  */
 int smb2_check_user_session(struct ksmbd_work *work)
 {
-	struct smb2_hdr *req_hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *req_hdr = ksmbd_req_buf_next(work);
 	struct ksmbd_conn *conn = work->conn;
-	unsigned int cmd = conn->ops->get_cmd_val(work);
+	unsigned int cmd = le16_to_cpu(req_hdr->Command);
 	unsigned long long sess_id;
 
 	/*
@@ -588,7 +588,7 @@ int smb2_check_user_session(struct ksmbd_work *work)
 			pr_err("The first operation in the compound does not have sess\n");
 			return -EINVAL;
 		}
-		if (work->sess->id != sess_id) {
+		if (sess_id != ULLONG_MAX && work->sess->id != sess_id) {
 			pr_err("session id(%llu) is different with the first operation(%lld)\n",
 					sess_id, work->sess->id);
 			return -EINVAL;
-- 
2.25.1


