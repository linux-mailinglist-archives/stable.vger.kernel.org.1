Return-Path: <stable+bounces-70362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6C960BF2
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2A1B27417
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 13:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7A51C2DA1;
	Tue, 27 Aug 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQlpP6m2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A51B3F2B;
	Tue, 27 Aug 2024 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764992; cv=none; b=orF4utPohrEG6B+0YYwUcTlaoT29NpIfEr4s8bq7dA3VN/JaZEXAmuZkzNaO7o3wXL9VjP7PAasWMaw+IMOO5Q/SKxxjQRreDfLznQv6t97jcmZ06U/u9PfzJt6ms9eyMoKTgwELCiFxbRfYOX2tXVBcyaRSMWXUIbMfCgztPEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764992; c=relaxed/simple;
	bh=/XHD34zdbgNKnwIhTxPsqd8L8PA1QTTE3R3kDc/VBow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNQ1a9pNAF3qvnYX+N06+PHMDFiS2dYsbL1GWqvYn3p+015JQZYSM7/chjy8JY2mmyIhjl6+L5KZIsvv7owdAJLffmKMi7Jky6z2ROCvAsWMrDlgKIIJ0+BcwA1fhwo2+Xr7U+KIsOuvG9I05kachfo+9b5nI8mqaKDv/YDEvyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQlpP6m2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764991; x=1756300991;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/XHD34zdbgNKnwIhTxPsqd8L8PA1QTTE3R3kDc/VBow=;
  b=QQlpP6m2JV10r+2s7r1aK3ah12qq3tGDvdrjxiUkZ71kvRn4sTnl71NZ
   8zWJY+Fr019dul5Sb+xa0tmA1147gMnrA2hSRZzEpl4TZpryW+3Owkf4I
   9/o0/5/bqY1bGY+E/9/vmtqHrRVjDMfp8d9DSkDseiDeZ7jlV8W0ZCBWl
   MBfrhtLesDnGmG2lUMPSl9AT38bi3ewh+BjI3zDjT5w+cVWAKRW7VYdQS
   OQk3Zos31P4TynsZR2evNxg79lsR/zSZYVX5PLNKhDQcJjkrXGv+BVg8i
   CsKQg21+WvIRiM0azjAZEd9z7EM733DdrhMF3SsoU7werFz/CzvvM6OM+
   Q==;
X-CSE-ConnectionGUID: LE3eBBc8Su+2tdBnEkaTTA==
X-CSE-MsgGUID: gTJuDDGRRQuanKshbEK30A==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="27007646"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="27007646"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:23:10 -0700
X-CSE-ConnectionGUID: 2+kkYFxRTWWEScD1jnqVfA==
X-CSE-MsgGUID: 9TZQOzOmRoipbcWlZN9pvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63032821"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:23:07 -0700
Message-ID: <1e9cd9d1-17c8-4603-ab95-d6996c5b4eca@linux.intel.com>
Date: Tue, 27 Aug 2024 15:23:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for stable 0/2] ASoC: topology: Fix loading topology issue
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>, tiwai@suse.com,
 perex@perex.cz, lgirdwood@gmail.com,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Vitaly Chikunov <vt@altlinux.org>, Mark Brown <broonie@kernel.org>
References: <20240814140657.2369433-1-amadeuszx.slawinski@linux.intel.com>
 <2024082729-subatomic-anemia-003d@gregkh>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <2024082729-subatomic-anemia-003d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/27/2024 3:11 PM, Greg Kroah-Hartman wrote:
> On Wed, Aug 14, 2024 at 04:06:55PM +0200, Amadeusz Sławiński wrote:
>> Commit 97ab304ecd95 ("ASoC: topology: Fix references to freed memory")
>> is a problematic fix for issue in topology loading code, which was
>> cherry-picked to stable. It was later corrected in
>> 0298f51652be ("ASoC: topology: Fix route memory corruption"), however to
>> apply cleanly e0e7bc2cbee9 ("ASoC: topology: Clean up route loading")
>> also needs to be applied.
>>
>> Link: https://lore.kernel.org/linux-sound/ZrwUCnrtKQ61LWFS@sashalap/T/#mbfd273adf86fe93b208721f1437d36e5d2a9aa19
> 
> You need to put the git ids in the patches directly do we have a clue
> what to do.
> 
> Also, what tree(s) do you need/want these in?
> 
> Please fix up and resend.
> 

I've already send v2 and as far as I know it was merged.

Here is link to v2:
https://lore.kernel.org/linux-sound/2024081442-thimble-widget-e370@gregkh/T/#t

