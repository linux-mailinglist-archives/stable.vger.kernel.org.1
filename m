Return-Path: <stable+bounces-181612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85034B9AB6E
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 17:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A302A1364
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0D33148D5;
	Wed, 24 Sep 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yzljfjh+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA13148CE;
	Wed, 24 Sep 2025 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728075; cv=none; b=UOe1Z9K4HtbSTbb3H5O1YDGZJbqCAHEA0MqGy0+3Y9eomVSmdC7sOfKnwXsPyqEINEIZOLhl2z3n/upppWYT7FTLgpS5tdfubQfbCffBApitktpNGsq2xgcRPNeazT8UmgmEYBq9MAeab5TABiLwuFXbkjOPPQVE/3k3S2vltUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728075; c=relaxed/simple;
	bh=wxPjznd3Mk72Y0HMGgxizVz3V7feCsOOYY3Ap7k4Ml4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCfpvZKXLkHIVHOFAj+v5LXqklktYBLJRLEIyLoAeHyPdhFyVTX944tVfh3AHHJpUuaYyoyhzcOjprxeTWp/0o39JLn6ctrVHoSe0U/UJMWRv3By/ULRe2T+lYSjbCYM2RZKXuFnvIJGQ27nDeR0nuKamHKD7ZgqkaQovdkNPyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yzljfjh+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758728073; x=1790264073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wxPjznd3Mk72Y0HMGgxizVz3V7feCsOOYY3Ap7k4Ml4=;
  b=Yzljfjh+gQmZg/Rvc+I5yydhs2pfcEqCSscGDXcjuYOq6k1uxY7Wui6c
   29vk0X+w8mevcVcGnA2iMi0/xB204xNR3Tn7DnUwssB2mww+i/7sDjVt3
   xYIi8KhWnBPWU3MXIs9+5BX2RGDRciwcY1AXiuA5XwBdDPDBefVMExD0U
   XWbpQni3I1iUmK8ebKnO9u3ZqxY4owrdly2chfxhz4QBbOEtw/UoaEuT1
   VTD9397YHaRMEaQg/qmqYiuA7+Mx8K3S81OTIVO2aQlTDPH1WsOsKRetu
   W709yoLlYX+rpyK7pRkWWnLjZ0ij+6VJxkf2VghvEgKdHXce9djA/vTEz
   A==;
X-CSE-ConnectionGUID: WlaiVsFISFa+0EyJA7hO7w==
X-CSE-MsgGUID: SqeyfEU1Q3y2+7FVLhA8AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="63657304"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="63657304"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 08:34:32 -0700
X-CSE-ConnectionGUID: a078IQKxT/aol6KoHAiYvQ==
X-CSE-MsgGUID: 9pHK2N6nRhmENOQyBRy5WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="177503430"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.218]) ([10.125.108.218])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 08:34:31 -0700
Message-ID: <0116557c-3b60-441e-8976-ebce1a658a01@intel.com>
Date: Wed, 24 Sep 2025 08:34:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvdimm: ndtest: Return -ENOMEM if devm_kcalloc() fails
 in ndtest_probe()
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Santosh Sivaraj <santosh@fossix.org>, nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250923125953.1859373-1-lgs201920130244@gmail.com>
 <767ef629-519c-431d-9a89-224ceabf22be@intel.com>
 <aNLsXewwa0LXcRUk@aschofie-mobl2.lan>
 <CANUHTR9X2=VPHPY8r++SqHZu-+i7GGP7sqbGUnAx+M89iiYS4A@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CANUHTR9X2=VPHPY8r++SqHZu-+i7GGP7sqbGUnAx+M89iiYS4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/24/25 12:42 AM, Guangshuo Li wrote:
> Hi Alison, Dave, and all,
> 
> Thanks for the feedback. I’ve adopted your suggestions. Below is what I plan to take in v3.
> 
> -       p->dcr_dma = devm_kcalloc(&p->pdev.dev <http://pdev.dev>, NUM_DCR,
> -                                 sizeof(dma_addr_t), GFP_KERNEL);
> -       p->label_dma = devm_kcalloc(&p->pdev.dev <http://pdev.dev>, NUM_DCR,
> -                                   sizeof(dma_addr_t), GFP_KERNEL);
> -       p->dimm_dma = devm_kcalloc(&p->pdev.dev <http://pdev.dev>, NUM_DCR,
> -                                  sizeof(dma_addr_t), GFP_KERNEL);
> 
> +       p->dcr_dma = devm_kcalloc(&p->pdev.dev <http://pdev.dev>, NUM_DCR,
> +                                 sizeof(dma_addr_t), GFP_KERNEL);
> +       if (!p->dcr_dma) {
> +               rc = -ENOMEM;
> +               goto err;
> +       }
> +
> +       p->label_dma = devm_kcalloc(&p->pdev.dev <http://pdev.dev>, NUM_DCR,
> +                                   sizeof(dma_addr_t), GFP_KERNEL);
> +       if (!p->label_dma) {
> +               rc = -ENOMEM;
> +               goto err;
> +       }
> +
> +       p->dimm_dma = devm_kcalloc(&p->pdev.dev <http://pdev.dev>, NUM_DCR,
> +                                  sizeof(dma_addr_t), GFP_KERNEL);
> +       if (!p->dimm_dma) {
> +               rc = -ENOMEM;
> +               goto err;
> +       }

You'll need to create new goto labels because you'll have to free previously allocated memory in the error path. Diff below is uncompiled and untested.

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 68a064ce598c..49d326819ea9 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -841,6 +841,7 @@ static void ndtest_remove(struct platform_device *pdev)

 static int ndtest_probe(struct platform_device *pdev)
 {
+       struct device *dev = &pdev->dev;
        struct ndtest_priv *p;
        int rc;

@@ -848,12 +849,23 @@ static int ndtest_probe(struct platform_device *pdev)
        if (ndtest_bus_register(p))
                return -ENOMEM;

-       p->dcr_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
-                                sizeof(dma_addr_t), GFP_KERNEL);
-       p->label_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
-                                  sizeof(dma_addr_t), GFP_KERNEL);
-       p->dimm_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
-                                 sizeof(dma_addr_t), GFP_KERNEL);
+       p->dcr_dma = devm_kcalloc(dev, NUM_DCR, sizeof(dma_addr_t), GFP_KERNEL);
+       if (!p->dcr_dma)
+               return -ENOMEM;
+
+       p->label_dma = devm_kcalloc(dev, NUM_DCR, sizeof(dma_addr_t),
+                                   GFP_KERNEL);
+       if (!p->label_dma) {
+               rc = -ENOMEM;
+               goto err_label_dma;
+       }
+
+       p->dimm_dma = devm_kcalloc(dev, NUM_DCR, sizeof(dma_addr_t),
+                                  GFP_KERNEL);
+       if (!p->dimm_dma) {
+               rc = -ENOMEM;
+               goto err_dimm_dma;
+       }

        rc = ndtest_nvdimm_init(p);
        if (rc)
@@ -863,7 +875,7 @@ static int ndtest_probe(struct platform_device *pdev)
        if (rc)
                goto err;

-       rc = devm_add_action_or_reset(&pdev->dev, put_dimms, p);
+       rc = devm_add_action_or_reset(dev, put_dimms, p);
        if (rc)
                goto err;
@@ -872,6 +884,11 @@ static int ndtest_probe(struct platform_device *pdev)
        return 0;

 err:
+       devm_kfree(dev, p->dimm_dma);
+err_dimm_dma:
+       devm_kfree(dev, p->label_dma);
+err_label_dma:
+       devm_kfree(dev, p->dcr_dma);
        pr_err("%s:%d Failed nvdimm init\n", __func__, __LINE__);
        return rc;
 }

> 
> If this looks good, I’ll send v3 accordingly. Also, if you’re comfortable with the changes, may I add your Reviewed-by tags?

Please don't add review tags until they are given.

> 
> Best regards,
> Guangshuo


