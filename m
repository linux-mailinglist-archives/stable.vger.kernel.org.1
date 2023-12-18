Return-Path: <stable+bounces-7648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A303817585
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57EB1F24132
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5015D754;
	Mon, 18 Dec 2023 15:36:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B965FF1E
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3536cd414so27049905ad.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913781; x=1703518581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyH0RUe1yNBqq6JlXS7B2EAYg8h6ToU0reXi35y52P4=;
        b=ecjF3YuslX2v0Cg4BsJoTEhAZ6bOLWXbNF1FpPG6BoaS2kbDEoUTiSBeqvRiFuDcfq
         6kwUaCcwBRSm5LmSiMauqJNPoaInFAw6xtPKSk4LU8VQSSWJMZB2VOmO+HEKbXLSviEk
         ty39h9UnSUI7CMnvd+gE3UnchUVu4s/yRzTGfuP1fDvtGSzXJonu8D4oKu6rJeJe3ihv
         7NPz1GLBDuq0y3kTUEYqrS1YztgqcFxoF/rQz3fiR6Phge7X09gWzNhm3gZeHWJX62SP
         SmHcsjQh5YJyJsTFt8Yo5k6laKTJ8/X0gaCzMf/HAJyUCV3Svx+16qxUCJ1YYChpTCzY
         p7Sg==
X-Gm-Message-State: AOJu0YwrzNHPJAXezIUVhb992YaujCENDjPGcAtfw6gZf6l3tSG25Jms
	GQIXzuoHAwtfFybhSV3H6Io=
X-Google-Smtp-Source: AGHT+IHEhk4fIvN9S8kRCwf1Db4+3sfmFeArJBhh5eax+5/f6ZmM9jWUF3l/9qvU+SmQ6aegcRN1Hg==
X-Received: by 2002:a17:90a:de01:b0:286:c00f:b622 with SMTP id m1-20020a17090ade0100b00286c00fb622mr10358438pjv.41.1702913780290;
        Mon, 18 Dec 2023 07:36:20 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:19 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 019/154] ksmbd: smbd: create MR pool
Date: Tue, 19 Dec 2023 00:32:39 +0900
Message-Id: <20231218153454.8090-20-linkinjeon@kernel.org>
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

[ Upstream commit c9f189271cff85d5d735e25dfa4bc95952ec12d8 ]

Create a memory region pool because rdma_rw_ctx_init()
uses memory registration if memory registration yields
better performance than using multiple SGE entries.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index ba2d3d286017..5901c4a2ece1 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -434,6 +434,7 @@ static void free_transport(struct smb_direct_transport *t)
 
 	if (t->qp) {
 		ib_drain_qp(t->qp);
+		ib_mr_pool_destroy(t->qp, &t->qp->rdma_mrs);
 		ib_destroy_qp(t->qp);
 	}
 
@@ -1714,7 +1715,9 @@ static int smb_direct_init_params(struct smb_direct_transport *t,
 	cap->max_send_sge = SMB_DIRECT_MAX_SEND_SGES;
 	cap->max_recv_sge = SMB_DIRECT_MAX_RECV_SGES;
 	cap->max_inline_data = 0;
-	cap->max_rdma_ctxs = 0;
+	cap->max_rdma_ctxs =
+		rdma_rw_mr_factor(device, t->cm_id->port_num, max_pages) *
+		smb_direct_max_outstanding_rw_ops;
 	return 0;
 }
 
@@ -1796,6 +1799,7 @@ static int smb_direct_create_qpair(struct smb_direct_transport *t,
 {
 	int ret;
 	struct ib_qp_init_attr qp_attr;
+	int pages_per_rw;
 
 	t->pd = ib_alloc_pd(t->cm_id->device, 0);
 	if (IS_ERR(t->pd)) {
@@ -1843,6 +1847,23 @@ static int smb_direct_create_qpair(struct smb_direct_transport *t,
 	t->qp = t->cm_id->qp;
 	t->cm_id->event_handler = smb_direct_cm_handler;
 
+	pages_per_rw = DIV_ROUND_UP(t->max_rdma_rw_size, PAGE_SIZE) + 1;
+	if (pages_per_rw > t->cm_id->device->attrs.max_sgl_rd) {
+		int pages_per_mr, mr_count;
+
+		pages_per_mr = min_t(int, pages_per_rw,
+				     t->cm_id->device->attrs.max_fast_reg_page_list_len);
+		mr_count = DIV_ROUND_UP(pages_per_rw, pages_per_mr) *
+			atomic_read(&t->rw_avail_ops);
+		ret = ib_mr_pool_init(t->qp, &t->qp->rdma_mrs, mr_count,
+				      IB_MR_TYPE_MEM_REG, pages_per_mr, 0);
+		if (ret) {
+			pr_err("failed to init mr pool count %d pages %d\n",
+			       mr_count, pages_per_mr);
+			goto err;
+		}
+	}
+
 	return 0;
 err:
 	if (t->qp) {
-- 
2.25.1


