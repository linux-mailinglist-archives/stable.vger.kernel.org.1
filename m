Return-Path: <stable+bounces-127442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6382CA797A0
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DAD16657C
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C5719D897;
	Wed,  2 Apr 2025 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp2CyWj+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40174288DA
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629114; cv=none; b=Yd5A89F0sKQH0oXBQnkJQ1SoMiEusK1IVcSbTsSTUeW7vlZNYVqicMm/AkYrKU8N9xPtTGsqy9yZB/XAGP0x9odBk8BKKvMBtDvjhDexxVtlq2dpbQPrqGVBTt3K/9CRMVV0IXg1e6QnN3aNVTQFDOU4reCzhvEGa4q7c0FLFnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629114; c=relaxed/simple;
	bh=G/kK2D8kDdkaqdiQcqzgisNYoiiit69jc/l+ENJMid4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1UzRtYuqS27L8d9i5kvnl63VYrAnS5T4Ps64OfGpCbcNtHgAApaqPr/+ToSDXTXjcrsZV/mmvetLpS9EQhs1L2iar0v3oYHnFc8jsTP8g7IoxSmD8O2dOVTVXeUhh7gsZnCYvNbSXCzdNz0yzf5/JWGqyl7zW2SXbvqBsQVwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp2CyWj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DBCC4CEDD;
	Wed,  2 Apr 2025 21:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743629113;
	bh=G/kK2D8kDdkaqdiQcqzgisNYoiiit69jc/l+ENJMid4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qp2CyWj+s69WCDV4iPsz1pVTmGcJX4pr6kvdGBWd4zLpF2Lz9JL6urgKP8D8bzlwT
	 GqOU3mB1KrZS2K2MMu0g10dYRC2N1/duPAHHURO63wT41w2LpdzRrShtjCbN1b5bYY
	 qx8Rmd8AbZpwdsoobxSN5u6uNxXkOtFoa5DDuEOQtinq1/4JaNvW2PQ+azUCfHq8ss
	 rvZP/WhJIVBi9LC1S73cvp+Woi3Nna8h35IcVmkEKZ7XG0JSuE9oCiqoSB+qoo1GcK
	 SvEHK/TSbkiUXqIJR3ac8oZtAlSTckqDCp0DV7vw56ttCn04sMAE3fytgU8c6dS8wt
	 sap9o9urMhppQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Liu <Feng.Liu3@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] i2c: dev: check return value when calling dev_set_name()
Date: Wed,  2 Apr 2025 17:25:09 -0400
Message-Id: <20250402123137-ab9b03396cc51ce5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250402061645.1194002-1-Feng.Liu3@windriver.com>
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

The upstream commit SHA1 provided is correct: 993eb48fa199b5f476df8204e652eff63dd19361

WARNING: Author mismatch between patch and upstream commit:
Backport author: Feng Liu<Feng.Liu3@windriver.com>
Commit author: Andy Shevchenko<andriy.shevchenko@linux.intel.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: 2f345bb14ad4)

Note: The patch differs from the upstream commit:
---
1:  993eb48fa199b ! 1:  011fada4599a5 i2c: dev: check return value when calling dev_set_name()
    @@ Metadata
      ## Commit message ##
         i2c: dev: check return value when calling dev_set_name()
     
    +    [ Upstream commit 993eb48fa199b5f476df8204e652eff63dd19361 ]
    +
         If dev_set_name() fails, the dev_name() is null, check the return
         value of dev_set_name() to avoid the null-ptr-deref.
     
         Fixes: 1413ef638aba ("i2c: dev: Fix the race between the release of i2c_dev and cdev")
         Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
         Signed-off-by: Wolfram Sang <wsa@kernel.org>
    +    Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
      ## drivers/i2c/i2c-dev.c ##
     @@ drivers/i2c/i2c-dev.c: static int i2cdev_attach_adapter(struct device *dev, void *dummy)
    @@ drivers/i2c/i2c-dev.c: static int i2cdev_attach_adapter(struct device *dev, void
     +	if (res)
     +		goto err_put_i2c_dev;
      
    - 	pr_debug("adapter [%s] registered as minor %d\n", adap->name, adap->nr);
    + 	pr_debug("i2c-dev: adapter [%s] registered as minor %d\n",
    + 		 adap->name, adap->nr);
      	return 0;
     +
     +err_put_i2c_dev:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

