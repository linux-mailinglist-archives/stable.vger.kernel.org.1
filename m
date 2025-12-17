Return-Path: <stable+bounces-202807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB44CC7956
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB6D6302FA2C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C38B3451C8;
	Wed, 17 Dec 2025 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gajEwQbT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539603446D0;
	Wed, 17 Dec 2025 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765974021; cv=none; b=o1S1BWdNMgi0gvoq+gO4uFD8W3Q4KjnAqi3pk0mUwCQMYG8j1PzYA3K82BU97TlkYPFAmrBi7Y6O8zVRxultoTo4/B+XTPJpwYnMrz0C6XxZNcw6eYFCwFgFBWvgkLHfnTeR/5n9O126jXG2AblA4sYouPmFwDCQ5ViVIpFEpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765974021; c=relaxed/simple;
	bh=v5SRw/Iy7HqDUG20Rjb0WNCKrKvx8A006sQeVmtD+Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b33HWl2oecuTGp5wtHpD214+XW2UwEUjS3ftQ/51CfLp75OTEjPaXnqUv09OOBxeGRC8W2CJZev1XJbf85osV3wB/5+GNHiRT9bv00swlFpuHqqHufARm4KseVWPSry7v8Qtzq4zQzF4dt+i170yCYwbCCkIiZJw+9UTcIkVhgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gajEwQbT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765974019; x=1797510019;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v5SRw/Iy7HqDUG20Rjb0WNCKrKvx8A006sQeVmtD+Kw=;
  b=gajEwQbT5JdJ8dhM7uQsXqP7792LD8u5VBih4KRfCAZC4FiXFnd6i3b9
   aQKE/jObccYY21JeqMC1VlwCD1kLw0+bGQUK0lEObKjnbMg7msSAgE296
   /fHHu2oxKHvdq3Ww0vcPJ0oEvpNKMB+mU9ZLPKv43CgG/7KqBpPBYXuuj
   7qSVAbwZkmq39XVvxyfhDlq9f2An6xVjzheAjEpt2ng0WhKOU4LX9KCwe
   69rjeO0LIulEmDHSflIEN7ElNVp/VPrxM1qsKHYUJHAUZFaTWNO3I+A/+
   8rH06r6FFZhsDJr93izFqvSjWyhsnlqPDyx4UUzDQfulD3aNll3250Oa1
   Q==;
X-CSE-ConnectionGUID: 3rWh3BsTR7S1iOTctDxfgQ==
X-CSE-MsgGUID: 5L/IJMMDT926rRrdN+TFZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="67793161"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="67793161"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 04:20:19 -0800
X-CSE-ConnectionGUID: WzUBklTFTX+oH+j4YPTfJA==
X-CSE-MsgGUID: 61ZwU37CQrCJStf06K/snQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="203390448"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.187]) ([10.245.246.187])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 04:20:16 -0800
Message-ID: <27404fce-b371-4003-b44b-a468572cf76d@linux.intel.com>
Date: Wed, 17 Dec 2025 14:20:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
 kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
 stable@vger.kernel.org, niranjan.hy@ti.com, ckeepax@opensource.cirrus.com,
 sbinding@opensource.cirrus.com
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
 <6e97293c-71c1-40a8-8eba-4e2feda1e6ea@sirena.org.uk>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <6e97293c-71c1-40a8-8eba-4e2feda1e6ea@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/12/2025 14:16, Mark Brown wrote:
> On Wed, Dec 17, 2025 at 02:06:23PM +0200, Peter Ujfalusi wrote:
>> In 'normal' controls the mc->min is the minimum value the register can
>> have, the mc->max is the maximum (the steps between are max - min).
> 
> Have you seen:
> 
>   https://lore.kernel.org/r/20251216134938.788625-1-sbinding@opensource.cirrus.com

No, I tried to look for possible fixes for this, but have not found it.

I think my one liner is a bit simpler with the same result, but I'll let
people decide which is better (and test on Cirrus side)

-- 
Péter


