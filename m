Return-Path: <stable+bounces-202809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A59CC7A8B
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B54C5305D996
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C89B344031;
	Wed, 17 Dec 2025 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nm8R4Dyn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59D340A57;
	Wed, 17 Dec 2025 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765974897; cv=none; b=dMBCafhVN+2kGnIee/AlZreaMemknd0yP5jZa3G3PiBFVfagNRP2kRj4KxZoThMct8Ot12bFyjyD9FtqHsTY5Vkpu3fA2ZsEgaf+JORypPB3V6VUHPDlOoiY9PBWL2CuLbPlk+APauF5Yb6wbU3kayUvJF3BybUyPlusjmtYEA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765974897; c=relaxed/simple;
	bh=sQJByiv3GWtlxavS9OQvwVmr7YB9biT6HQQXWcKKotU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+EkMHpdnxt3Br+vTedGV2Er7nQZdzzRTaUWhE0p/roHov4c6ChEbf1VcXaczeEuce0P6suM7VLzhLrfgZdqXS/9dii9226S6I1jVvfFlRAlQO7bwpdE3VJiXj+J/k5PxoRW2sDjpJ0XU2yWCdhPHiJ6ZJy7j/iMLcYqmU/TYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nm8R4Dyn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765974895; x=1797510895;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sQJByiv3GWtlxavS9OQvwVmr7YB9biT6HQQXWcKKotU=;
  b=nm8R4DynfIANk3T7camWmQEox6BUNPFZe6SgVpoO6KJWHQR0W9q5bXhF
   pPZDLFs+1wonZ9796t4wfe+w+OOs6+gVbkABQLdkLtn6k7eXVahcrUAHr
   ojRNAFtJvmT2Ps26s82kM+hmlY1SPLksoRV6O9DMgZSwHkfU6mltTuVZ/
   NVIR+dNbFu+feMXvOT5riKBOghCVew1HqDwAajOM9/3ziv4g91i4VYn/S
   AxQHCMAyLCtCD+LGKYB7N/M6QC56MlmHkiChEDB8g+Z4ecgsDPlc/WWEd
   gNzAcNTqPaTX7+/W9biCPJNYwDzaPltGadjBDEi6cq7FhCGc0fbJ0+8N8
   w==;
X-CSE-ConnectionGUID: X/x/JRytS0+1fCkxLXfC5g==
X-CSE-MsgGUID: iSq5gdVeQBOmNDdektsv/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="85327358"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="85327358"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 04:34:53 -0800
X-CSE-ConnectionGUID: 6sHsbYuCS9KmaPKsTuctXw==
X-CSE-MsgGUID: zwmJ6yVeTDSGX4hxg6Dojg==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.187]) ([10.245.246.187])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 04:34:50 -0800
Message-ID: <329a3007-de85-41c6-9b63-ca79e3bfbdef@linux.intel.com>
Date: Wed, 17 Dec 2025 14:35:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] ASoC: SOF: ipc4-topology: Correct the allocation
 size for bytes controls
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 seppo.ingalsuo@linux.intel.com, stable@vger.kernel.org
References: <20251215142516.11298-1-peter.ujfalusi@linux.intel.com>
 <20251215142516.11298-3-peter.ujfalusi@linux.intel.com>
 <652a147c-2012-469f-b0e0-c73a1385cacb@sirena.org.uk>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <652a147c-2012-469f-b0e0-c73a1385cacb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/12/2025 14:04, Mark Brown wrote:
> On Mon, Dec 15, 2025 at 04:25:10PM +0200, Peter Ujfalusi wrote:
> 
>> Fixes: a062c8899fed ("ASoC: SOF: ipc4-topology: add byte kcontrol support")
> 
> Commit: d80b24e6a5a1 ("ASoC: SOF: ipc4-topology: Correct the allocation size for bytes controls")
> 	Fixes tag: Fixes: a062c8899fed ("ASoC: SOF: ipc4-topology: add byte kcontrol support")
> 	Has these problem(s):
> 		- Subject does not match target commit subject
> 		  Just use
> 			git log -1 --format='Fixes: %h ("%s")'
> 
> a062c8899fed is "ASoC: SOF: ipc4-control: Add support for bytes control
> get and put".

uh, oh, the correct tag for this should have been:
Fixes: a382082ff74b ("ASoC: SOF: ipc4-topology: Add support for TPLG_CTL_BYTES")

but the SHA in tag is also fine as that is the point when this code is first used.

Should I resend the series?

-- 
Péter


