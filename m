Return-Path: <stable+bounces-73949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1C1970CDF
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 07:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D881C219F4
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 05:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1336A36B11;
	Mon,  9 Sep 2024 05:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1tlQ2as"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC4AB658
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 05:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725858951; cv=none; b=arWA4WalUs2edi3qOenkFydqfGuDxbEv2ZapOMpS9F4IxVN/FWlXSidL8f3U2EQI9kKONM/TRga+hX3Wh6P2Jnx5668oSsCKIjiiScZvHz9/l4DM2kZ+xkJ2LZ8PNKpQpnOuZnbIxSnraA5Wo27cQl8GEUaUrNivoh2upf5Zhoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725858951; c=relaxed/simple;
	bh=Pi7lMcAJ6NHHPYazzY/pYpIUxUQj0YE90gQ8SZqVG94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHITP3hzhqElZ0+oXxEllIzNUXWurHqiFGsRIZtX13Jfqd3ur/tfhQ2oS943dwBSA7SdKnvhEoVja5iZ5ZLXqVDDam9xRw7aLzXebitvaly8+yfPdrt0+A8fBiW6FOf79mBKCz4MeWwDlitNMKtmiGWYUWtBLLGHlRReCVUce/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1tlQ2as; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725858950; x=1757394950;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pi7lMcAJ6NHHPYazzY/pYpIUxUQj0YE90gQ8SZqVG94=;
  b=S1tlQ2asmYzfQfk3Dr6XDomNMeirB8BBa8QZh4SfLsxLf8BBHIyVUJyU
   5vRbXI01Pk9lL94zH3ZBVpb/GpxMcxcmNU2IojZiwA+N2OJhV8rZ7kg51
   t6/5GYkd3z0SBk5CL5hduJUNz/OqTse3pyauY+oueyvkSa+c5WUPYMnR3
   +aN4axdhKZS1et8fDh2M+ze41Xvd6g/0vpSTRMIAFSsvV/n2S2C7XUKOL
   zyaBN37d7B/ww8cFWxrvnf34eiBmOogIAcMZKDbYLypcyjes5TJ/aJj9Q
   BbIG/4259KH58gOgV0ZKNvo6o4hPZ1CbQW7XLxVegWu8kSOmd/2eeGVIO
   w==;
X-CSE-ConnectionGUID: lK0/xfOuSxihs1PGVdyt9g==
X-CSE-MsgGUID: 1hGAJMF+QouD3Jgkgyp0OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28413709"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="28413709"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 22:15:49 -0700
X-CSE-ConnectionGUID: SfcSWHf2SZGwvx7R3WpIiw==
X-CSE-MsgGUID: +rFdvdgeQYmklRD1tzUoGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66862676"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.96.163])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 22:15:47 -0700
Message-ID: <d1d85600-1d80-438d-be24-14c51ec3e576@intel.com>
Date: Mon, 9 Sep 2024 08:15:41 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] mmc: cqhci: Fix checking of CQHCI_HALT
 state" failed to apply to 5.10-stable tree
To: gregkh@linuxfoundation.org, sh8267.baek@samsung.com,
 ritesh.list@gmail.com, ulf.hansson@linaro.org
Cc: stable@vger.kernel.org
References: <2024090852-importer-unadorned-f55b@gregkh>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <2024090852-importer-unadorned-f55b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/09/24 14:28, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x aea62c744a9ae2a8247c54ec42138405216414da

The file name changed from cqhci.c to cqhci-core.c but git 2.43.0
seems to handle it:

$ git version
git version 2.43.0
$ git log --oneline | head -1
b57d01c66f40 Linux 5.10.225
$ git cherry-pick -x aea62c744a9ae2a8247c54ec42138405216414da
Auto-merging drivers/mmc/host/cqhci.c
[detached HEAD dd4085252f0d] mmc: cqhci: Fix checking of CQHCI_HALT state
 Author: Seunghwan Baek <sh8267.baek@samsung.com>
 Date: Thu Aug 29 15:18:22 2024 +0900
 1 file changed, 1 insertion(+), 1 deletion(-)

> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090852-importer-unadorned-f55b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
> 
> Possible dependencies:
> 
> aea62c744a9a ("mmc: cqhci: Fix checking of CQHCI_HALT state")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From aea62c744a9ae2a8247c54ec42138405216414da Mon Sep 17 00:00:00 2001
> From: Seunghwan Baek <sh8267.baek@samsung.com>
> Date: Thu, 29 Aug 2024 15:18:22 +0900
> Subject: [PATCH] mmc: cqhci: Fix checking of CQHCI_HALT state
> 
> To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
> bit. At this time, we need to check with &, not &&.
> 
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
> Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Link: https://lore.kernel.org/r/20240829061823.3718-2-sh8267.baek@samsung.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
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
> 


