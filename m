Return-Path: <stable+bounces-202857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA28BCC8324
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AAF23006FF6
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B64F3A3EE1;
	Wed, 17 Dec 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTD769er"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9C3355053;
	Wed, 17 Dec 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981876; cv=none; b=MWrmH98CkrHUScoL45gfOSAVD/e5Slw4mAQYQwCNFGj5aPqdK5pdImhX3z5ApivdyQmSm6PykkzwkZ/L95UorXG8eCa8qaISrrIpq2UPAKsS49r4q7aW8AR+8wy9F+Y7Ij9GhGlvCjacND57lmjl3AdqaJy2Mmb5SmPQa6QTUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981876; c=relaxed/simple;
	bh=PymflYNKcYw8mup+B634nitgOaXLqkons7eEUJsdoU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpdUI/ZzzDtBYy6iY6sywQnwhl0/LbOtUsS1gcXwXnx0covWu1HXrC60eSI5Iv7Ql9hssdMeW+0yj/QklKOFJbmsplVmacQyzqSEN3PZZM4oAMqJe3Q8oCmFyggBFdA5JKQ2mTy5DspUjASYsQsnDjUxJFNHUenphFWYD48PQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTD769er; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765981874; x=1797517874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PymflYNKcYw8mup+B634nitgOaXLqkons7eEUJsdoU8=;
  b=lTD769ergwh9UA66JfYUI1xHmsA/RXH8L4+z3i8GJ1S9eGomxWvsTrEW
   cdPp6UH3n3Cl2NPn7OatcAdAMVuw8DObMgmpa/BG2FJwLaPfxlptIhu/A
   Yskeid6y4L+pMfe6dtJfXcdWRYhokxfoHbFFVsrozvNH8J/EaT+W8AdRm
   /hDAhSjX5VSINOFbYhVB80SGro7YQJkltcl6Xk4N/RrHJGNMB7rZwFuek
   BrC5EFH1+oMEDXFgLKN92l9ip5uoYpJ0E9gbPrCbxd0ZYO4n5nch1J6Mg
   wPKeYxXGlDNKkCSicEUWDQjud0AhIkOjHpzboVaw8auw1WSgU+vNBGtMO
   A==;
X-CSE-ConnectionGUID: 4en4XGi7SMWbcLgy0eO+iw==
X-CSE-MsgGUID: hNzexgjIT0u6TlR9tIS3Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="85507257"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="85507257"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:31:13 -0800
X-CSE-ConnectionGUID: W7FK7oBzQYem9+4BPjjBZA==
X-CSE-MsgGUID: 461iDD4oTqCbrl4wpQQxUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="197933322"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.187]) ([10.245.246.187])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:31:11 -0800
Message-ID: <a367ee5f-c46f-470f-976c-011ac9cfc55b@linux.intel.com>
Date: Wed, 17 Dec 2025 16:31:37 +0200
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
 <a7038077-2dfd-4a14-b38f-09a5ed3713be@linux.intel.com>
 <aUKzQCIF6DvVRRUJ@opensource.cirrus.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <aUKzQCIF6DvVRRUJ@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/12/2025 15:42, Charles Keepax wrote:
> On Wed, Dec 17, 2025 at 03:13:45PM +0200, Péter Ujfalusi wrote:
>> On 17/12/2025 14:47, Charles Keepax wrote:
>>> On Wed, Dec 17, 2025 at 02:06:23PM +0200, Peter Ujfalusi wrote:
>>>>  sound/soc/soc-ops.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
>>>> index ce86978c158d..6a18c56a9746 100644
>>>> --- a/sound/soc/soc-ops.c
>>>> +++ b/sound/soc/soc-ops.c
>>>> @@ -148,7 +148,7 @@ static int soc_mixer_reg_to_ctl(struct soc_mixer_control *mc, unsigned int reg_v
>>>>  	if (mc->sign_bit)
>>>>  		val = sign_extend32(val, mc->sign_bit);
>>>>  
>>>> -	val = clamp(val, mc->min, mc->max);
>>>> +	val = clamp(val, mc->min, mc->min + max);
>>>
>>> This won't work, for an SX control it is perfectly valid for
>>> the value read from the register to be smaller than the minimum
>>> value specified in the control.
>>
>> Hrm, so an SX control returns sort of rand() and the value have no
>> correlation to min or max?
> 
> lol, yes exactly :-) arn't they great
> 
>> The value can wrap at any random value to 0 and continue from 0 up to
>> some value, which is the max?
> 
> Mostly correct, not any random value it wraps at the mask.
> 
>> How this is in practice for the cs42l43' Headphone Digital Volume?
>> SOC_DOUBLE_SX_TLV("Headphone Digital Volume", CS42L43_HPPATHVOL,
>> 	  CS42L43_AMP3_PATH_VOL_SHIFT, CS42L43_AMP4_PATH_VOL_SHIFT,
>> 	  0x11B, 229, cs42l43_headphone_tlv),
>>
>> min=283
>> max=229
>> shifts: 0 and 16
>> masks are 0x1ff
>>
>> if you step 229 from 283 then you reach 0x1ff, this is the max the mask
>> can cover.
> 
> Not quite your maths is off by one, 229 + 283 = 512 = 0x200,
> which is then &ed with the mask to get 0x0. Which on the cs42l43
> headphones a value of 0x0->0dB. Stepping 1 back from that would
> give you 0x1FF->-0.5dB.
> 
>>> I often think of it in terms of a 2's compliement number
>>> with an implicit sign bit.
>>
>> I see, but why???
> 
> Mostly because hardware people love to wind me up, I assume. But
> more seriously, imagine an 4-bit signed number volume control
> with 5 values:
> 
> 0xE -> -2 -> -2dB
> 0xF -> -1 -> -1dB
> 0x0 ->  0 -> 0dB
> 0x1 ->  1 -> 1dB
> 0x2 ->  2 -> 2dB
> 
> Super, a very sensible control, but wait being a good hardware
> engineer you realise you don't need 4 bits to represent 5 values
> you can get away with 3 bits for that and save like 2 gates
> resulting in an ice cream and a plaque from your manager. So
> you drop the sign bit giving you:
> 
> 0x6 -> -2dB
> 0x7 -> -1dB
> 0x0 -> 0dB
> 0x1 -> 1dB
> 0x2 -> 2dB

I must say, wow.
Being a SW guy I would probably done this differently:
0x0 -> -2dB
0x1 -> -1dB
0x2 -> 0dB
0x3 -> 1dB
0x4 -> 2dB

> This then results in an SX control with a minimum of 0x6 and a
> mask of 0x7.

then the comment at info() is hard to match still.

static const DECLARE_TLV_DB_RANGE(sx_thing,
	6, 7, TLV_DB_SCALE_ITEM(-2000, -1000, 0),
	0, 2, TLV_DB_SCALE_ITEM(0, 1000, 0)
};

is sort of the same, no?

Thanks for the explanation, fascinating!

-- 
Péter


