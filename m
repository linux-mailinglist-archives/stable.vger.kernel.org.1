Return-Path: <stable+bounces-202829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65986CC7C98
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D0F3302C4E4
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1405F3612DF;
	Wed, 17 Dec 2025 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVuOBzWs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE735E549;
	Wed, 17 Dec 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765977203; cv=none; b=AMzDSh+h10A94U/fRQLQNS5Z8OR9ulofvYLbbV08x9J5dfYZDYwkH066NJ4/L9ZyyIut1FbY9HThEqOugrj+2ZVsYg5SYe1KHnVtVbx+Syc9U1ty0k/mQX8RslfHnEwPJsfpHhcLgq9eJrOlAhhNlVF8xNdWhI0adDp8PwLLrvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765977203; c=relaxed/simple;
	bh=tSv6Of/KX32L/VhoylIdl3hqC7tOsk3YVZYTTyUICyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZEg68muWIyFETk9L8E3KggkGYF6LZ5mDMcCojJ7xdFEp2tlWiU3fZf7vbC2zg6rnfANCETr+TPrR6czfA1pNTMD//ov4R2pr7YrgMpKvw6DpZewKpYCLTlQh6zomKHq60X9MNLNlevU+c6hFx+8Oz2rdPfRoAx8HAMxpQFsdlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVuOBzWs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765977202; x=1797513202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tSv6Of/KX32L/VhoylIdl3hqC7tOsk3YVZYTTyUICyM=;
  b=UVuOBzWsDHIlsQkmO/omO3YwQ/yQcofKUuv5DVSAfsbsi3y4oTEd+CF/
   eoaazDxdhe7/Dc/hE7Tu249j5mr2zvh48UnQIlvqSYrTwKQ0iUKRu0H6O
   3M79VdOORtQIAE0oJgrGXL8x/K5/JzW07j2gHpgtrygoXLehh6qAKJW9S
   7wir3e45VP5/uAH1c5JKeF2v6sohRc5GVRQOlN0NUW0N5Hk7RGOhPgVpt
   1ttyvp5U3ZGvbU4CAJ9HcWzAD5WBulJFwbwl+NENI6MmbMWmrnuyIMxan
   LtUNnf72DYj/vb1GgUu3318HLd4RPSG73KliHzl3GzIEICrhKynm3Dp0G
   Q==;
X-CSE-ConnectionGUID: dbFb+ZQ2QfGYYkXNQbM9CQ==
X-CSE-MsgGUID: hQHMpXkEQmmSB+g1KNQOHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67852087"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67852087"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 05:13:21 -0800
X-CSE-ConnectionGUID: +ECf8BSTQKa6TzA8bA3nTg==
X-CSE-MsgGUID: NsJMt7khRAi+39CkRwks1g==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.187]) ([10.245.246.187])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 05:13:19 -0800
Message-ID: <a7038077-2dfd-4a14-b38f-09a5ed3713be@linux.intel.com>
Date: Wed, 17 Dec 2025 15:13:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-sound@vger.kernel.org,
 kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
 stable@vger.kernel.org, niranjan.hy@ti.com
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
 <aUKmcpUzUac5Dmfq@opensource.cirrus.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <aUKmcpUzUac5Dmfq@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/12/2025 14:47, Charles Keepax wrote:
> On Wed, Dec 17, 2025 at 02:06:23PM +0200, Peter Ujfalusi wrote:
>>  sound/soc/soc-ops.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
>> index ce86978c158d..6a18c56a9746 100644
>> --- a/sound/soc/soc-ops.c
>> +++ b/sound/soc/soc-ops.c
>> @@ -148,7 +148,7 @@ static int soc_mixer_reg_to_ctl(struct soc_mixer_control *mc, unsigned int reg_v
>>  	if (mc->sign_bit)
>>  		val = sign_extend32(val, mc->sign_bit);
>>  
>> -	val = clamp(val, mc->min, mc->max);
>> +	val = clamp(val, mc->min, mc->min + max);
> 
> This won't work, for an SX control it is perfectly valid for
> the value read from the register to be smaller than the minimum
> value specified in the control.

Hrm, so an SX control returns sort of rand() and the value have no
correlation to min or max?

The info() gives this explanation:
SX TLV controls have a range that represents both positive and negative
values either side of zero but without a sign bit. min is the minimum
register value, max is the number of steps.

which kind of makes some sense, but really fuzzy.
> The minimum value gives the register value that equates to the
> smallest possible control value.

right, so min is min, OK

> From there the values increase
> but the register field can overflow and end up lower than the
> min.

smaller value than min is then bigger than min, right?
The value can wrap at any random value to 0 and continue from 0 up to
some value, which is the max?
max (which is the number of steps) = vrap_point-min + some_value (where
the value is likely less than min, but not specified)

How this is in practice for the cs42l43' Headphone Digital Volume?
SOC_DOUBLE_SX_TLV("Headphone Digital Volume", CS42L43_HPPATHVOL,
	  CS42L43_AMP3_PATH_VOL_SHIFT, CS42L43_AMP4_PATH_VOL_SHIFT,
	  0x11B, 229, cs42l43_headphone_tlv),

min=283
max=229
shifts: 0 and 16
masks are 0x1ff

if you step 229 from 283 then you reach 0x1ff, this is the max the mask
can cover.

> I often think of it in terms of a 2's compliement number
> with an implicit sign bit.

I see, but why???

> 
> Thanks,
> Charles

-- 
Péter


