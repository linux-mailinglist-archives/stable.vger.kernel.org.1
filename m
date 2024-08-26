Return-Path: <stable+bounces-70153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DE095EE49
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D7FB2287B
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93E8146593;
	Mon, 26 Aug 2024 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGAI2jN0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90702E414;
	Mon, 26 Aug 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667409; cv=none; b=QpjjkhC787tbsiPxcKzeBITDjGwZ4obZEych4ig12LMXrdIuTNI9RGZFncDXWaJgMiGRqqdL+JoVPyOBYAszXpsBhO6ambzb8q8aj/rrP5J6kYoP2we18RYRv4wvxsVR3NyGldBIuxMXqafXGn/gHbz0Jytm7ZEpR6+EaCSzuFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667409; c=relaxed/simple;
	bh=s/mlalkLPncv8zb+gxPeAG4H30+mUKO0o7jjrS/xTFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZ+XmAWI3nJjojt00zDcPBwh1C1Y7TRbh+fFTk421JgcpFJqfqGwoBzh1zbg0KlgmS4i5NdwbW/5PsSd3yfIL5SV1+D40G6X5kAIlVUpMLarrNSpwt60YeXNsFTFvNnrM3GzjcLSP0djjn6E8lkkamWMI4GQXbvRRPSyszcj0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGAI2jN0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724667408; x=1756203408;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s/mlalkLPncv8zb+gxPeAG4H30+mUKO0o7jjrS/xTFE=;
  b=YGAI2jN0gCpKlEFfSGk3c/6F+JvVSAQ3EsNp2V4p46cEos98CjbOvIrL
   R/GbbHoJ2FaNHVhlBuqHU00Ea71nBEAVcVwAd88/1dwCGSlz45vcRr1Kc
   3wzQBuuSKPClQ0BTWm9/0DkbpCoxFhbOCXKdjwn7wh7uDKfkRTjnYJUWz
   F58+3xDiBjJxMzQ6+3uNNfXZwO4PgwwvYiy/3UQmwOG+IIsM/lSiu7ggH
   iy1FwnttEpXbz5ZBkntKR6b3HJegNsZ/LeLlei7NBVFWSupK2ESH04miW
   qu7MXP9BeVQ6hNMWsjltBYRi1gzFX2XNoDd9JniHlTX6rdik5oL85/heH
   g==;
X-CSE-ConnectionGUID: 6kY8azfCTnagIgfkjl1c4Q==
X-CSE-MsgGUID: iC1qSvv2T7KjneAvLlB5/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="26958882"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="26958882"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:16:47 -0700
X-CSE-ConnectionGUID: qiuDoSOWRZm66UGurmcwRw==
X-CSE-MsgGUID: SMrORHslRt29RE1wq9cdvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62160977"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:16:42 -0700
Message-ID: <7164bfde-3c43-495f-8e1f-83b998ff17e2@intel.com>
Date: Mon, 26 Aug 2024 13:16:37 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc : fix for check cqe halt.
To: Seunghwan Baek <sh8267.baek@samsung.com>, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, ritesh.list@gmail.com,
 quic_asutoshd@quicinc.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com,
 dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com,
 cw9316.lee@samsung.com, wkon.kim@samsung.com, stable@vger.kernel.org
References: <CGME20240826091726epcas1p19797d2dd890feef6f9c4b83e9156341a@epcas1p1.samsung.com>
 <20240826091703.14631-1-sh8267.baek@samsung.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240826091703.14631-1-sh8267.baek@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/08/24 12:17, Seunghwan Baek wrote:

The subject starts with "[Patch 2/2]" but is there another patch?
Did you mean "[Patch v2] ..."?

> To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
> bit. At this time, we need to check with &, not &&. Therefore, code to> check whether cqe is in halt state is modified to cqhci_halted, which has
> already been implemented.

Doesn't compile:

drivers/mmc/host/cqhci-core.c: In function ‘__cqhci_enable’:
drivers/mmc/host/cqhci-core.c:285:13: error: implicit declaration of function ‘cqhci_halted’; did you mean ‘cqhci_writel’? [-Werror=implicit-function-declaration]
  285 |         if (cqhci_halted(cq_host))
      |             ^~~~~~~~~~~~
      |             cqhci_writel
drivers/mmc/host/cqhci-core.c: At top level:
drivers/mmc/host/cqhci-core.c:956:13: error: conflicting types for ‘cqhci_halted’; have ‘bool(struct cqhci_host *)’ {aka ‘_Bool(struct cqhci_host *)’}
  956 | static bool cqhci_halted(struct cqhci_host *cq_host)
      |             ^~~~~~~~~~~~
drivers/mmc/host/cqhci-core.c:285:13: note: previous implicit declaration of ‘cqhci_halted’ with type ‘int()’
  285 |         if (cqhci_halted(cq_host))
      |             ^~~~~~~~~~~~
cc1: all warnings being treated as errors

Not only should it compile, but you must test it!

Probably better to make 2 patches:
1. Just the fix, cc stable i.e.

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index c14d7251d0bb..a02da26a1efd 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 		mmc->cqe_on = true;
 		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
-		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
+		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}

2. Tidy up, no cc stable

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index a02da26a1efd..178277d90c31 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -33,6 +33,11 @@ struct cqhci_slot {
 #define CQHCI_HOST_OTHER	BIT(4)
 };
 
+static bool cqhci_halted(struct cqhci_host *cq_host)
+{
+	return cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT;
+}
+
 static inline u8 *get_desc(struct cqhci_host *cq_host, u8 tag)
 {
 	return cq_host->desc_base + (tag * cq_host->slot_sz);
@@ -282,7 +287,7 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 
 	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
 
-	if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
+	if (cqhci_halted(cq_host))
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 
 	mmc->cqe_on = true;
@@ -617,7 +622,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 		mmc->cqe_on = true;
 		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
-		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
+		if (cqhci_halted(cq_host)) {
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}
@@ -953,11 +958,6 @@ static bool cqhci_clear_all_tasks(struct mmc_host *mmc, unsigned int timeout)
 	return ret;
 }
 
-static bool cqhci_halted(struct cqhci_host *cq_host)
-{
-	return cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT;
-}
-
 static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;



> 
> Fixes: 0653300224a6 ("mmc: cqhci: rename cqhci.c to cqhci-core.c")

Fixes tag should be the commit that introduced the code, not one
that moved it.  In this case, it has been there since the beginning:

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")

Looks like the offending code kinda worked which explains why it
wasn't noticed sooner.

> Cc: stable@vger.kernel.org
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
> ---
>  drivers/mmc/host/cqhci-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index c14d7251d0bb..3d5bcb92c78e 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -282,7 +282,7 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>  
>  	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>  
> -	if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
> +	if (cqhci_halted(cq_host))
>  		cqhci_writel(cq_host, 0, CQHCI_CTL);
>  
>  	mmc->cqe_on = true;
> @@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  		cqhci_writel(cq_host, 0, CQHCI_CTL);
>  		mmc->cqe_on = true;
>  		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
> -		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
> +		if (cqhci_halted(cq_host)) {
>  			pr_err("%s: cqhci: CQE failed to exit halt state\n",
>  			       mmc_hostname(mmc));
>  		}


