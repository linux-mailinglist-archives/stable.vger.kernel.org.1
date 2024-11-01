Return-Path: <stable+bounces-89486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97AE9B915C
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 13:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816941F2181F
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DAD19D891;
	Fri,  1 Nov 2024 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvpJApGA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A0199E94;
	Fri,  1 Nov 2024 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465692; cv=none; b=FvRJpyzTIQzrHiYVyA+wDYoqY91f1JG0PyAr26hJhnYMhX79dNaA4fYR3ZheG3wWvCF1/cfwA6YrN8B3VGKtv0gIjpZhfBiPILYsaWiLpyVB8MPlQeQxLe84zQTI8X+xEMHC+tgzN4wZO2YSLFS0RHOj9SC/YC8JdsERqMsOvxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465692; c=relaxed/simple;
	bh=o+rpjDR9EHS4Y2S7TjYaEvnjSQNr/2grg1NqLnGbsCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sq6CUaJCSj4MuqAW9JXpMlwu+2c3Ih3+F+YJ/SNqW/cL+8zS3ETfDahtWJhdgJC5so+HypggI0lIx8tNAc3DKGNEvE0sODK5MBqvI8H4GpkI7ykt4el9h1FDGzu1Mf51mER12ZrpJAxcImWlOJp8bz7DFOccNZ+SnsH7Vjt8yD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvpJApGA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730465691; x=1762001691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o+rpjDR9EHS4Y2S7TjYaEvnjSQNr/2grg1NqLnGbsCA=;
  b=dvpJApGATsSKnLKxFM9e77NvR6wbFpYZBqvnLN6miLleeQG0z8YXXipW
   YIkZ2+b9+E6OSjnFGv1odxF3KGCehPutvGIg4WC51ZpVsP4+PnnHTvTdw
   JV0iXRcrUkVGlk4GB69+a1T3V4e6qxCyO9mHPOWxbTbRo34rfsYD9GY8C
   Ifn0wncO/yCGRYjRAbP/pQ1hMsUZT2vksgWIsESZ8b0Is0FsFFU7Tkg4/
   diHkiNyRGzDFkIWpJ8lYeub269uZORAuU1K0Ifj7tXRYQrNt74YWLzbV7
   biPeLooNlxv/V/yvQueBnPUqegMaHPWMEbbM7GMBke7bBNsl/uJ/jEyVV
   w==;
X-CSE-ConnectionGUID: 6l4c9SWCQ7yy7ppOMD3wXw==
X-CSE-MsgGUID: z8uf0DvZSRytGZg5VjaWWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33918109"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33918109"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 05:54:50 -0700
X-CSE-ConnectionGUID: cMQEf6TkR922wQpveQzeVA==
X-CSE-MsgGUID: j57iuj3JR2yFGXUJvCkHIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="82640785"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa007.fm.intel.com with ESMTP; 01 Nov 2024 05:54:47 -0700
Message-ID: <80d98097-9187-41a7-9d6b-7b9d6aeaa304@linux.intel.com>
Date: Fri, 1 Nov 2024 14:57:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] xhci: Combine two if statements for Etron xHCI
 host
To: Kuangyi Chiang <ki.chiang65@gmail.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241028025337.6372-1-ki.chiang65@gmail.com>
 <20241028025337.6372-2-ki.chiang65@gmail.com>
 <bceb89ce-7a4b-4447-8bd6-3129a37bfdb3@linux.intel.com>
 <CAHN5xi2B5CcCKEsdQf1X7HD=8ZBAW66PefmO0ajvGCNdPOc-PA@mail.gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <CAHN5xi2B5CcCKEsdQf1X7HD=8ZBAW66PefmO0ajvGCNdPOc-PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1.11.2024 4.30, Kuangyi Chiang wrote:
> Hi,
> 
> I noticed that one of the patches in your queue has a typo:
> 
> Commit 3456904e4bce ("xhci: pci: Use standard pattern for device IDs")
> 
> The Etron xHC device names are EJ168 and EJ188, not J168 and J188.

Thanks for reporting, now fixed

-Mathias


