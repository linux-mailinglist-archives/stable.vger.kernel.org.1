Return-Path: <stable+bounces-181490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D12B95EB0
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D553A8F4C
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 13:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25A8324B01;
	Tue, 23 Sep 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKb1qztN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D432340D
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632417; cv=none; b=SyufiNwfQovIe4Okq7jCfF2QIQgoDCsR/mBysW7wQ1croJLGBrLAiNMFA08mcOPKT6p8yFJqcOyALochEOl/8X8L1pe0FOtcC/IeZy84IlXixD8U7moIM3A4HiRuvLBAnVI3EoXO/m8Jkq/NPSNimdY/obuGfOfrqcje0+xXHR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632417; c=relaxed/simple;
	bh=fpgqG3PPMbLAJYHf4nYwntPFHa09JCf1vAbUPv7WyK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIhCOlFSoAIjWgzJ7ZcoxB2VLgygt5jYo6FGbNEdylZ51ScfX3oRn2+dRLOUbFdABckYg5NS/wt1h8Qhc6NTx5dkuT3MpE0/hUJI5610TZrNePI29MC/ZGtre1fRgMhHrpwmnAtR+1Tr7b83wFVVkAQfBga21zPK1zVWvX3JSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKb1qztN; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso3886363a12.3
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 06:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758632414; x=1759237214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh5SwzIzASTLhVaTpXrHPJRdBlRjDqtp1v+iQDlbfos=;
        b=QKb1qztNBsVv64+uUomfinPRzxWdml6FUnZQIp71Kmq9PLESlRpIdTjV2vm7xeMHBk
         85vsJ/eGIsFErbUSnG0IBAIehA9RZdQRs7g9y7WyXxITRjh4DNgMA0oo/jTaKgis6qVB
         g7Ngxbvy4I2FtYLe5+nxJWfmaAGL7NnB5T6r9Y9T8bTeXBFpg6VO5x/RPGjKHD9Hjgtz
         zqnIu9sBSHV4epFaW4Eekc6uV4yjnmTCa5alBrpasj1U0IZ/eZ2d/vzIQ/G8HX0S12iy
         5iBw+NdMirdPf168dvna9M+VoTUc+r2V1248smyNT10s/9J+jJ+potbqQkbXSHIdYnDP
         KQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632414; x=1759237214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nh5SwzIzASTLhVaTpXrHPJRdBlRjDqtp1v+iQDlbfos=;
        b=mhFYInK9evmPDJsHOLWYfnXNlu+r6fBHX7O2ayD67f7LKgzizXQLWHDaAp07govnsA
         A3AgU8RU4E0UNQKAGhD6waPnUUf7z2RY9JEUrHUSbNPH3MGSILko90KERyEsH3DjWePE
         9ypZuZ3F0jet3PdV9VBJ1NKzxy8StMu2zSB+H3f3yVRRVaIAkXbOQvGZgcY0NfzfaKKr
         MZn4naWLFrg1aSZK/60xLZeMYTy56xpd47qXrLJ2RsIRYNqrI757zYXeY1MZst/IQNwg
         BbGh+U6Z2R/KZFDrIjMYq1prwniU/EFyOlZNnEGBNJbrChC8QlhtKjekN+gKXdxYk9c1
         IKiw==
X-Gm-Message-State: AOJu0Yx81xIslPSQLPZOnsjHIJMp/pwzE1iPZ7vsMiHGMFoh1dNTRMp7
	K7ygTGXFEV5dk5U5W+v9+Eb4t7VsJD6lk5FZCTqICN1Zqh0S71IUQsPR
X-Gm-Gg: ASbGnctpyksWlMb23zhd55LxyKipPYop9KybK2GSlKk1ms8s4sVxpka9XPHTjwC9Uvs
	VTHJvJ8ApJpVcqbSiCb1C+h1ve6A7zl4pN6lJf6OALz8eDYyhfgyZo4bnxDXeUFYRf1EvytFIZl
	11pQze/XyHlJ/stpUyvSGlV+/A5kVlVOLQMjoBwdP1u4NBNwMQEUoNlRthvEfhWuFnOs6NZ7dki
	fcxEFBrQLfttOhH/HFmi3704828bDANEI8spx/enctK3Ohv0VlxXgc6gSf/AJLpk92F9WEyNs6a
	44NU2oIVzPjlEgJxx8JfOv9BRECmEz7SQrvabsExIbgXvhKCJgOB9y9WRvksXDtR4NCiOY1R82L
	yUX6QunmOy0wnk4hfGnAEzhsHhxVCF1CsWA==
X-Google-Smtp-Source: AGHT+IEVwoSV/1C7G9K+WLOLmPwik9m4PPFJYbHnIWzyucU6AzZaAx84ogTIVfkz9b6BwPzEVvys1w==
X-Received: by 2002:a17:90b:3a8a:b0:32b:c9fc:8aa2 with SMTP id 98e67ed59e1d1-332a96fd4c8mr3170726a91.20.1758632413614;
        Tue, 23 Sep 2025 06:00:13 -0700 (PDT)
Received: from lgs.. ([2408:8418:1100:9530:4f2e:20bc:b03d:e78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed273f557sm19059243a91.15.2025.09.23.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:00:13 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Santosh Sivaraj <santosh@fossix.org>,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] nvdimm: ndtest: Return -ENOMEM if devm_kcalloc() fails in ndtest_probe()
Date: Tue, 23 Sep 2025 20:59:53 +0800
Message-ID: <20250923125953.1859373-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kcalloc() may fail. ndtest_probe() allocates three DMA address
arrays (dcr_dma, label_dma, dimm_dma) and later unconditionally uses
them in ndtest_nvdimm_init(), which can lead to a NULL pointer
dereference under low-memory conditions.

Check all three allocations and return -ENOMEM if any allocation fails.
Do not emit an extra error message since the allocator already warns on
allocation failure.

Fixes: 9399ab61ad82 ("ndtest: Add dimms to the two buses")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
Changes in v2:
- Drop pr_err() on allocation failure; only NULL-check and return -ENOMEM.
- No other changes.
---
 tools/testing/nvdimm/test/ndtest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 68a064ce598c..abdbe0c1cb63 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -855,6 +855,9 @@ static int ndtest_probe(struct platform_device *pdev)
 	p->dimm_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
 				  sizeof(dma_addr_t), GFP_KERNEL);
 
+	if (!p->dcr_dma || !p->label_dma || !p->dimm_dma)
+		return -ENOMEM;
+
 	rc = ndtest_nvdimm_init(p);
 	if (rc)
 		goto err;
-- 
2.43.0


