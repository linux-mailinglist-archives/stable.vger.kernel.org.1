Return-Path: <stable+bounces-7670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7088175B2
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2729B24607
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9F849888;
	Mon, 18 Dec 2023 15:37:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B54FF80
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c6ce4dffb5so970798a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913854; x=1703518654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTHRtV7tvuEK7Pw/J5DNAGEHQI7Tut+JspXc3cmewUE=;
        b=Qei7N1rGronquBBF18xrlOaRyAXiuLVfs37lL4PTxaWMYE6tYUaG54NY60h/uvywDt
         DFAjLRwXQu9vew3FCG33xHdRvwQxhnFhGQkAta732SvHFL7ONresrPi+YjH93i4Fn3Xo
         fDU+jL6fOO0ngx8m3bvWy1QJsJSsKkLLpyuj7PonKUzzyH/k+zTl/qIVEKYgFPYnFZ/3
         xpMSzcS4nr2iYnRUCD2Y7+ZfGBtWqy9/QtjcijDYvR9w5t58/kG955yKUG+csW63x9X2
         1Tx2icevGP5W2JOSRowL96CFbXJaA72Dx/tTflPHfWc/J1rL2F44P3ABipbjx6Vj65ID
         PbTw==
X-Gm-Message-State: AOJu0Yyg1rSxw9SCFj1YFanxHyjczCQeYp7iCRLlt8QPLWTda1ARHB8c
	2aM3ilrBFJari0JJ+3lXQ3s=
X-Google-Smtp-Source: AGHT+IFyB4yRNf+mgqKAbiTrxFUl+lxOv4w4zfQ3NU4XLWEvUTN45B89eHqlBDfJRRB9QPm4/KT2aw==
X-Received: by 2002:a17:90a:9f91:b0:28b:8956:79b2 with SMTP id o17-20020a17090a9f9100b0028b895679b2mr631794pjp.7.1702913854134;
        Mon, 18 Dec 2023 07:37:34 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:33 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 041/154] ksmbd: smbd: relax the count of sges required
Date: Tue, 19 Dec 2023 00:33:01 +0900
Message-Id: <20231218153454.8090-42-linkinjeon@kernel.org>
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

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit 621433b7e25d6d42e5f75bd8c4a62d6c7251511b ]

Remove the condition that the count of sges
must be greater than or equal to
SMB_DIRECT_MAX_SEND_SGES(8).
Because ksmbd needs sges only for SMB direct
header, SMB2 transform header, SMB2 response,
and optional payload.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 6c127fabdc56..ab12ec537015 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -1711,11 +1711,11 @@ static int smb_direct_init_params(struct smb_direct_transport *t,
 	int max_send_sges, max_rw_wrs, max_send_wrs;
 	unsigned int max_sge_per_wr, wrs_per_credit;
 
-	/* need 2 more sge. because a SMB_DIRECT header will be mapped,
-	 * and maybe a send buffer could be not page aligned.
+	/* need 3 more sge. because a SMB_DIRECT header, SMB2 header,
+	 * SMB2 response could be mapped.
 	 */
 	t->max_send_size = smb_direct_max_send_size;
-	max_send_sges = DIV_ROUND_UP(t->max_send_size, PAGE_SIZE) + 2;
+	max_send_sges = DIV_ROUND_UP(t->max_send_size, PAGE_SIZE) + 3;
 	if (max_send_sges > SMB_DIRECT_MAX_SEND_SGES) {
 		pr_err("max_send_size %d is too large\n", t->max_send_size);
 		return -EINVAL;
@@ -1736,6 +1736,8 @@ static int smb_direct_init_params(struct smb_direct_transport *t,
 
 	max_sge_per_wr = min_t(unsigned int, device->attrs.max_send_sge,
 			       device->attrs.max_sge_rd);
+	max_sge_per_wr = max_t(unsigned int, max_sge_per_wr,
+			       max_send_sges);
 	wrs_per_credit = max_t(unsigned int, 4,
 			       DIV_ROUND_UP(t->pages_per_rw_credit,
 					    max_sge_per_wr) + 1);
@@ -1760,11 +1762,6 @@ static int smb_direct_init_params(struct smb_direct_transport *t,
 		return -EINVAL;
 	}
 
-	if (device->attrs.max_send_sge < SMB_DIRECT_MAX_SEND_SGES) {
-		pr_err("warning: device max_send_sge = %d too small\n",
-		       device->attrs.max_send_sge);
-		return -EINVAL;
-	}
 	if (device->attrs.max_recv_sge < SMB_DIRECT_MAX_RECV_SGES) {
 		pr_err("warning: device max_recv_sge = %d too small\n",
 		       device->attrs.max_recv_sge);
-- 
2.25.1


