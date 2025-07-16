Return-Path: <stable+bounces-163123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A478FB0746F
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 13:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70333AA513
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 11:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A492F3C19;
	Wed, 16 Jul 2025 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOnfc5Mj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267722F3C10;
	Wed, 16 Jul 2025 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664516; cv=none; b=dDHduUsYtTmQstBxZ+upzRGeW8hTBLb0NhXOuaFEMvuQ6fGrZiwE4/ctsyRhUEZiurKuK55SiKknHEbgZB3MHfduRTfKjgvZFr2w6j9uKwVh1mN5G65nP6pYXAxocQ4CAjdKT6/jmDBTW8EmNcFKDKoC9mj2GjAmUDG0sm2ERkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664516; c=relaxed/simple;
	bh=POXyRLgqrEMUmyxlEmPHw+8L6pGtwyvwpmhvVLmvIko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1IZ/lPRnksQ46NzKouaOf0muR42VBj/9pjGOT6vzoFLgtxzWU9jQslPjP5XpZ/juYAJEdHnQRGseHhcmE2dhO6nCGkxkLydkoTdUB7FqKyVfECgCWcB/nAdVHGkZg9I9Lf6ofLuYH2B8XgIxlAolvCjW42U1dL9yrR0piGHlzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOnfc5Mj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0e0271d82so1155092166b.3;
        Wed, 16 Jul 2025 04:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752664513; x=1753269313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2SOYl/XQMHOmwrX5JSsna52LJMbkh+N5xjV/ETx76A=;
        b=LOnfc5Mj4xb5ngWxHVH6lGqy7j33sH2sqLiLm50XIF8+AARCwlLGhfWBGyiQAsuPAm
         dfnyx56sG76QaciCW2GriIPikstSYOEeWCayJUzuJTTQ5v9CXL5x3YUVyrsnC57MJY9u
         5/ymwUWQmP+QlJXzvG8+XWzKhNFKM89VE52tBgs4xyeoMYM9tbpZvc66TC+1O4pwFcDH
         U2COw5ARZWgRsdywt14stHHEqFW8Ci6rC6Xkphw+NWpjp2QoG6m03/XAz5BWCNZyVk8e
         kKfHrkeBQHYggY2jl51loT7aiFUh9yi/qpiy6y+YXxFPacREwVlAZiV+bEahv0hhQYnn
         wW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752664513; x=1753269313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2SOYl/XQMHOmwrX5JSsna52LJMbkh+N5xjV/ETx76A=;
        b=qTt02XUrmZlT80IDBH05pVA0AOukwRjUI5kD1SMl+mVfSSXnXFOUFDMUigTKli9Bcn
         9LgUrJia0HCyPORrTvP4bck9AmZjykOxf3dS35RWhkeNcQcDe50AQJyIrhVEujD3wH2G
         mPSAH31efyVSI+CMGQkF6ed0EkWvtXfxxsOFmTKk4wssybTp+SzkxFP4BMsFsnvfDPqw
         FwHCIuPR5ow9gap/BqpBQDMbH6Ml71rlYpizRpW8B9VtmSZXubM7Ujd0jO7ExgkSSaoH
         d+vlP6MWFkKn1T3F+V4pwEprr04EQvtiLh1xlRWgU2j7EgKi4cpoAnmr5C4hoCtzJyq/
         LxYg==
X-Forwarded-Encrypted: i=1; AJvYcCVSLtGELUWVvVH210XJmmsHwze5OPYldjj67LKcR63D0Y4Gc67lh2iK7gbNc0pVjKKzppmjLK2f@vger.kernel.org, AJvYcCVrlUZp3Q5VY0HDw1RR6k+tad2WbWzEDqPt7eWzuptgkMyrBeY5htQlqwHJ8UTZg3GBNWOy3xAa6jfXliQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPZ2xGY8iB66ha/suKffd3X2uZ30FaQdHAeq5lYf+fmh7JYRqP
	CrI6jvu0pImrpNbJK8rBL+r4ujNRx8Dyq5itMoQF+jLMtWXU1olpMgrn
X-Gm-Gg: ASbGnctdmjM5dq0UDZh4l1bEB1mCNnJeFBdJUMnMy+AjRNT4X2Dsxn47JGWExeuwI59
	PUmrHobIaxtV13BSk5n6zqY0zQOy5ZTqwnIppLXgyF0pxZgsHI83ipTj7VQYZRpPPyes1usSjZm
	FeLBndPIq9dbGHADTFKyfn4RfsuV3SP3MdGdG2Z54xSl5iqX570q8Yj1X5vuEwAucsW6gwlCJUh
	sK5PxPKi70rHsXGEVJcV5cxk3gTWC88h5xYCm1j/Fqy4A904d04aB/TirduLajLm4kQBpV9ivgk
	N4zBQ7+tPNw2DKGsGNbkol1GVm+rHlUdg9QQS4POW8kasyMJt87kmxliA5a2y9K61t37fjKPlR8
	dXW0ASbggcYAU/3QOPAR3zd4+aHVaJiPbrzpUxXPbm/WsDtkLqNnJuFTcREQ=
X-Google-Smtp-Source: AGHT+IHuaG9Q4KyyDlobEdm53aQS309RTLX1FnzlLthLLXD+3Rs1MJYH27z7J7Sc4zrPCnLs0uM4Hw==
X-Received: by 2002:a17:907:d847:b0:ae0:a1c2:262e with SMTP id a640c23a62f3a-ae9c9b3e228mr272402366b.50.1752664513185;
        Wed, 16 Jul 2025 04:15:13 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([185.144.39.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dee16sm1175217766b.152.2025.07.16.04.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:15:12 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] nvmet: pci-epf: Do not complete commands twice if nvmet_req_init() fails
Date: Wed, 16 Jul 2025 13:15:03 +0200
Message-Id: <20250716111503.26054-2-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716111503.26054-1-rick.wertenbroek@gmail.com>
References: <20250716111503.26054-1-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have nvmet_req_init() and req->execute() complete failed commands.

Description of the problem:
nvmet_req_init() calls __nvmet_req_complete() internally upon failure,
e.g., unsupported opcode, which calls the "queue_response" callback,
this results in nvmet_pci_epf_queue_response() being called, which will
call nvmet_pci_epf_complete_iod() if data_len is 0 or if dma_dir is
different from DMA_TO_DEVICE. This results in a double completion as
nvmet_pci_epf_exec_iod_work() also calls nvmet_pci_epf_complete_iod()
when nvmet_req_init() fails.

Steps to reproduce:
On the host send a command with an unsupported opcode with nvme-cli,
For example the admin command "security receive"
$ sudo nvme security-recv /dev/nvme0n1 -n1 -x4096

This triggers a double completion as nvmet_req_init() fails and
nvmet_pci_epf_queue_response() is called, here iod->dma_dir is still
in the default state of "DMA_NONE" as set by default in
nvmet_pci_epf_alloc_iod(), so nvmet_pci_epf_complete_iod() is called.
Because nvmet_req_init() failed nvmet_pci_epf_complete_iod() is also
called in nvmet_pci_epf_exec_iod_work() leading to a double completion.
This not only sends two completions to the host but also corrupts the
state of the PCI NVMe target leading to kernel oops.

This patch lets nvmet_req_init() and req->execute() complete all failed
commands, and removes the double completion case in
nvmet_pci_epf_exec_iod_work() therefore fixing the edge cases where
double completions occurred.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
---
 drivers/nvme/target/pci-epf.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index a4295a5b8d28..9cd470938463 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1242,8 +1242,11 @@ static void nvmet_pci_epf_queue_response(struct nvmet_req *req)
 
 	iod->status = le16_to_cpu(req->cqe->status) >> 1;
 
-	/* If we have no data to transfer, directly complete the command. */
-	if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
+	/*
+	 * If the command failed or we have no data to transfer, complete
+	 * the command immediately.
+	 */
+	if (iod->status || !iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
 		nvmet_pci_epf_complete_iod(iod);
 		return;
 	}
@@ -1604,8 +1607,13 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 		goto complete;
 	}
 
+	/*
+	 * If nvmet_req_init() fails (e.g., unsupported opcode) it will call
+	 * __nvmet_req_complete() internally which will call
+	 * nvmet_pci_epf_queue_response() and will complete the command directly.
+	 */
 	if (!nvmet_req_init(req, &iod->sq->nvme_sq, &nvmet_pci_epf_fabrics_ops))
-		goto complete;
+		return;
 
 	iod->data_len = nvmet_req_transfer_len(req);
 	if (iod->data_len) {
@@ -1643,10 +1651,11 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 
 	wait_for_completion(&iod->done);
 
-	if (iod->status == NVME_SC_SUCCESS) {
-		WARN_ON_ONCE(!iod->data_len || iod->dma_dir != DMA_TO_DEVICE);
-		nvmet_pci_epf_transfer_iod_data(iod);
-	}
+	if (iod->status != NVME_SC_SUCCESS)
+		return;
+
+	WARN_ON_ONCE(!iod->data_len || iod->dma_dir != DMA_TO_DEVICE);
+	nvmet_pci_epf_transfer_iod_data(iod);
 
 complete:
 	nvmet_pci_epf_complete_iod(iod);
-- 
2.25.1


