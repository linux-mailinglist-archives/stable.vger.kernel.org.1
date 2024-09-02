Return-Path: <stable+bounces-72711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EE39684A7
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 12:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19401F2232E
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BDB146D78;
	Mon,  2 Sep 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pb+rmYci"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE91420B6;
	Mon,  2 Sep 2024 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272914; cv=none; b=CqkhZyXK5S1v4j+ia5OurSt1bfRlzqGW53/j0SNuWtSqmaSgaOTlAbOSbD9q7Jsmm9L0P5EQfbjc7or+WGjB6Ym6+l+g0Ary34RDhztfZWVvM7fpkeh/mAcSlqoW/kafrm3dpESetmIWxwCdYFD20+xI43GPL6Rbd7n05YoMGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272914; c=relaxed/simple;
	bh=o49/VfeHx/55xDTE8RkgShWImK7IhvTHRkQEAshuhMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dgck9h4XUy4F6Yw6dtCaNpuHRnWWdYPtUB4AhjdOyGgwzv61C9jE5KD4PIdtmXD6fnpDaOcDLfW2RTb5oo1GsRnYfT1IMI9H5kfxSsaWgqu+le7kcekwegEo/dvgkNOnA+oeSfWe1ypWqYM0ed1odWdt2KaISrSffatf34ZbFe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pb+rmYci; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725272913; x=1756808913;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o49/VfeHx/55xDTE8RkgShWImK7IhvTHRkQEAshuhMk=;
  b=Pb+rmYcirWJr8dMR2aXc6AG0UoP0dLKMnujbf1eaMg0gBd1UstjzzDNR
   GG/ue6OUnR5uB9VQgnSualFi6OEqTAGj60bmqUzKa4MeKwMHrTvBzFv7k
   UF8SBzVY8TGDqIF+CESajSN7E9TqswEXslzUQxZRnZ76Gj9cd5Od+7WeX
   WOwLAJAIYkKAFvkDqgD5o/arweuOSA1pBffoQE9CAxNc7TV6oKZFRuBP+
   3V9nPoAbTih9yZ6qxlzZkilc2SuI5u1GPDXlw0W4Hel8k5yuAfgrDjD2b
   o79h8x4y5Dcgj7VF96Hfwbyq/14oj0mMgrQ52vrRuHmYdC7D9EJUUkNKr
   A==;
X-CSE-ConnectionGUID: Hl1mh1rMRR+GyU1LsGEGZQ==
X-CSE-MsgGUID: ULn6hUKpTXK0rrbecOMWsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="35212552"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="35212552"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:28:31 -0700
X-CSE-ConnectionGUID: Wc7OZ2yRTDCpjdhgK2f/gg==
X-CSE-MsgGUID: n9tgonAsSpu3UO8zxaXCnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64574120"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:28:25 -0700
Message-ID: <f348f927-ada2-4c85-93e9-e2c3a99df33a@intel.com>
Date: Mon, 2 Sep 2024 13:27:31 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mmc: cqhci: Fix checking of CQHCI_HALT state
To: Seunghwan Baek <sh8267.baek@samsung.com>, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, ritesh.list@gmail.com,
 quic_asutoshd@quicinc.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com,
 dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com,
 cw9316.lee@samsung.com, wkon.kim@samsung.com, stable@vger.kernel.org
References: <20240829061823.3718-1-sh8267.baek@samsung.com>
 <CGME20240829061840epcas1p4ceeaea9b00a34cae0c2e82652be0d0ee@epcas1p4.samsung.com>
 <20240829061823.3718-2-sh8267.baek@samsung.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240829061823.3718-2-sh8267.baek@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/08/24 09:18, Seunghwan Baek wrote:
> To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
> bit. At this time, we need to check with &, not &&.
> 
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/cqhci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index c14d7251d0bb..a02da26a1efd 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  		cqhci_writel(cq_host, 0, CQHCI_CTL);
>  		mmc->cqe_on = true;
>  		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
> -		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
> +		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
>  			pr_err("%s: cqhci: CQE failed to exit halt state\n",
>  			       mmc_hostname(mmc));
>  		}


