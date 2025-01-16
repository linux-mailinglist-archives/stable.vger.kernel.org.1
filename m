Return-Path: <stable+bounces-109288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD6CA13E13
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 16:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1C716B206
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3850822B8D9;
	Thu, 16 Jan 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBi6FGOZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2E22BAB7;
	Thu, 16 Jan 2025 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042280; cv=none; b=ASIvCRFURfUwRlN9jS6hjxSu+3t5CPMPjLIfNLDcbBpl2vSFLIaJqS327f1+cZFrR9ajrpTfRy8L0YAI90M77dzAjGdECBxxDlsV+m9oFbIXM3FvLlBh1a7wW7UzwHy6GM9+36Dol8nvKFjJhQnffZYbDzNgwgqGRXRwGeiZEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042280; c=relaxed/simple;
	bh=9rzhZQZ8LC//4VRBaWlrG+BtsnENotusOXh7L0ZGNMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxOHFdcguxiqq8BmnkRf+kT2hUYtHfzo5On5Kf59PA9FWlpemsuoNDE4CbQ94+vQ2dB2e2l5IKuW0d+LmvCjovihiUoJeBFo79/fk9JDDRdU0y6vYBkWJKzYcMwUifHdqMQR45xShUwCG+kqtcNjLi6Ki4jqF9aGn0FiFRnGBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBi6FGOZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737042278; x=1768578278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9rzhZQZ8LC//4VRBaWlrG+BtsnENotusOXh7L0ZGNMg=;
  b=CBi6FGOZXsAQq2KfKAEB7hDgMrl2vtf1fksl4z5dyDQddZaBHKXXn9qx
   NwgANx8bjzloQIt4ahCNkx/Y3F12ODVN4T4iknKUPk8YDzGBHzRl3+1PR
   CKAhzb1VwNs/MqMRWMoBZhmCYl8BybBwQdjTJVFDV8Vw4L7btwmg3BNig
   2/wLwGbM/2ydoRv6YxEpIXhnroYk4s29zZwjS5/adcOEE1V8VYD/x6MR7
   8sfdET96O3T5Y4rHF7kCOIu0IPgwo64g5HQ0idCFFjyNeGcPuP1TV30AM
   cKC3LyF6nPJk3Y9URXaZ5nnRDdOWe34bG9PaSPTL4FBYQjcIrxDYKWTXB
   w==;
X-CSE-ConnectionGUID: qKbKljMeRBSYKO+GusG4Cw==
X-CSE-MsgGUID: H2clPAPjR4Ky1Z6tGjRqXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="54981295"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="54981295"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:44:38 -0800
X-CSE-ConnectionGUID: xwgRM87GTSa6mfFMnA4lbw==
X-CSE-MsgGUID: 1KyErYCmScSpFqo0VXSf2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110648730"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.109.66]) ([10.125.109.66])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:44:36 -0800
Message-ID: <a8b2695d-7bdc-4da0-883d-5a73a7c553ff@intel.com>
Date: Thu, 16 Jan 2025 08:44:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntb: use 64-bit arithmetic for the MSI doorbell mask
To: Fedor Pchelkin <pchelkin@ispras.ru>, Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <allenbh@gmail.com>, Logan Gunthorpe <logang@deltatee.com>,
 ntb@lists.linux.dev, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20250115182817.24445-1-pchelkin@ispras.ru>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250115182817.24445-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/25 11:28 AM, Fedor Pchelkin wrote:
> msi_db_mask is of type 'u64', still the standard 'int' arithmetic is
> performed to compute its value.
> 
> While most of the ntb_hw drivers actually don't utilize the higher 32
> bits of the doorbell mask now, this may be the case for Switchtec - see
> switchtec_ntb_init_db().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE static
> analysis tool.
> 
> Fixes: 2b0569b3b7e6 ("NTB: Add MSI interrupt support to ntb_transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

LGTM. Should be using the BIT() macro to begin with. 

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/ntb/ntb_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index a22ea4a4b202..4f775c3e218f 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1353,7 +1353,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  	qp_count = ilog2(qp_bitmap);
>  	if (nt->use_msi) {
>  		qp_count -= 1;
> -		nt->msi_db_mask = 1 << qp_count;
> +		nt->msi_db_mask = BIT_ULL(qp_count);
>  		ntb_db_clear_mask(ndev, nt->msi_db_mask);
>  	}
>  


