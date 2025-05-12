Return-Path: <stable+bounces-143856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E0EAB422B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9826160243
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05792BEC5D;
	Mon, 12 May 2025 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckaCkEMy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1AE2BEC55
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073131; cv=none; b=dNv6O5jqTXXa3YJ4alQ/K2y2t/rxE+CHaOg6wiGfAUZGetP9WmbTVTQdVNvGj+sISq03+FVEbr2uRbgII9AY55XNHuc04Zyh/HQVhEjzOjQx18LCFO2G8TB+ehuSxPNNy/8RyyLGxUPqrJ5oCJBE5r/rBRuX5irUN7P24Gc9Jpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073131; c=relaxed/simple;
	bh=GEoE8VF9HBhXTGwwcydCLuizNsdyG/TfcdwpRbd9qc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHIdsh3czyRx0AlQkBFIUMlzXyRNzYgOQYczgkQOFg7QkzxZa0gFDegFcLfXu3zVAP22vz91cODrKOPbyayaBe7UY4uJIQUfx9rHQzw2cMMiIWnHPlTlbMvgPgE80QNKDU8HkMZbOM+Lb1kibf05THRaPnUyaJfDGyKydB0mjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckaCkEMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BCAC4CEEF;
	Mon, 12 May 2025 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073131;
	bh=GEoE8VF9HBhXTGwwcydCLuizNsdyG/TfcdwpRbd9qc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckaCkEMy6UwoGj9T7k5o5YyAv64D7XFafEoKhT1mQdialfjyYkUiVBr5zzExbFDJ6
	 KTdVUfpfc+dUpQvn69krLMzGxqkv+QZu6LuKfsMVQct+Q5pLPQPxVxolw3efIKAkMX
	 vrWwy8iVXmli9YTco2NUDGylNeJYnpKeKMu+wQUoUrXHf8QNLVhCITcjDpBLi0PEvj
	 szMjASGIXh88aYu0j6ZRMVIjB8KQkKdaMLX8Dmqj2cbFf6vLN0ls0PV7ZyKx2fZWUj
	 UJNcqiGGxZfJh5sQRwW09nSBms4JTL6NB/B5UIykK2s72SUp4m5QiJxoySxBeSldYS
	 ITKYESMmGVYyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] nvme: apple: fix device reference counting
Date: Mon, 12 May 2025 14:05:26 -0400
Message-Id: <20250511210241-99d8b8041e61aa49@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509083216.1281489-1-bin.lan.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: b9ecbfa45516182cd062fecd286db7907ba84210

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Keith Busch<kbusch@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: f7d9a18572fc)

Note: The patch differs from the upstream commit:
---
1:  b9ecbfa455161 ! 1:  66a0d9b8ca96a nvme: apple: fix device reference counting
    @@ Metadata
      ## Commit message ##
         nvme: apple: fix device reference counting
     
    +    [ Upstream commit b9ecbfa45516182cd062fecd286db7907ba84210 ]
    +
         Drivers must call nvme_uninit_ctrl after a successful nvme_init_ctrl.
         Split the allocation side out to make the error handling boundary easier
         to navigate. The apple driver had been doing this wrong, leaking the
    @@ Commit message
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
         Signed-off-by: Keith Busch <kbusch@kernel.org>
    +    [Minor context change fixed.]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/nvme/host/apple.c ##
     @@ drivers/nvme/host/apple.c: static void devm_apple_nvme_mempool_destroy(void *data)
    @@ drivers/nvme/host/apple.c: static int apple_nvme_probe(struct platform_device *p
     +	if (IS_ERR(anv))
     +		return PTR_ERR(anv);
     +
    - 	anv->ctrl.admin_q = blk_mq_alloc_queue(&anv->admin_tagset, NULL, NULL);
    + 	anv->ctrl.admin_q = blk_mq_init_queue(&anv->admin_tagset);
      	if (IS_ERR(anv->ctrl.admin_q)) {
      		ret = -ENOMEM;
     -		goto put_dev;
    @@ drivers/nvme/host/apple.c: static int apple_nvme_probe(struct platform_device *p
     +		goto out_uninit_ctrl;
      	}
      
    + 	if (!blk_get_queue(anv->ctrl.admin_q)) {
    +@@ drivers/nvme/host/apple.c: static int apple_nvme_probe(struct platform_device *pdev)
    + 		blk_mq_destroy_queue(anv->ctrl.admin_q);
    + 		anv->ctrl.admin_q = NULL;
    + 		ret = -ENODEV;
    +-		goto put_dev;
    ++		goto out_uninit_ctrl;
    + 	}
    + 
      	nvme_reset_ctrl(&anv->ctrl);
     @@ drivers/nvme/host/apple.c: static int apple_nvme_probe(struct platform_device *pdev)
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

