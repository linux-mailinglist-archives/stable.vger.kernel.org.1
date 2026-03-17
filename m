Return-Path: <stable+bounces-225793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNklNX4huWkrrwEAu9opvQ
	(envelope-from <stable+bounces-225793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:40:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B92A6FD2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F20DF308A262
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555B2371870;
	Tue, 17 Mar 2026 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tki/MLDm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBAB36403A;
	Tue, 17 Mar 2026 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740157; cv=none; b=p+/a86JHbETw2GNGCph5Bv0s6dHp/dAozUlL+TLG+R9h3n9+ESvwekDUCL/CPq7uVUpzE0sDM5JYWxbje3Qs+Oeml77G8cj5/cWJckoW29xfwigswL1QXz/v+jdAUZDRaAy4DOkv6/H5y5FKWKJCvbZUzNeA9ByHD22Sl5uLEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740157; c=relaxed/simple;
	bh=Cbam5VeCO/ojGKHwR+cqnhU85wH7U0QC+4f29gAj8Ao=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bVWnU1yOG9xS0Rfbxwt+WaAKveBD/5sEONQk2ro48OfC9j2OlUnwoV6B5hJ/hGU7fIOBlctiIWJHZWw69FEvHb/CyMXU9ioXOT5xlioJk/IVH6iWWI7UkyTcRby42GU1jLZFkamf2rBHMrj5T7bqfLRX/U0Io+jId25eaLuUWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tki/MLDm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773740156; x=1805276156;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Cbam5VeCO/ojGKHwR+cqnhU85wH7U0QC+4f29gAj8Ao=;
  b=Tki/MLDmSKRigR8fBxYnB5W3JN0O8VEnU3eiSPOveRmwUomy/vPX0ziJ
   LgMHcSYJUAS1aiqrEOe5PZYpgcbEhRMdO38HvvUQSMwEfuyyd3kDdUz0m
   bWWM2ZtN453WlgtJHQKBjknvmRWUbf2jNNW/UQq5Wfo93Rrzaa5Z0NKNq
   GSee/Z0NreBKOdDttCVzWxdABu1pD8KzZCiIc2YyecXbmrdg8f/0s9bEA
   yLEWQDZC0M5B5ggxiSh+KcXJP/+SPbi/8LP9u45bN1SYXi/rN++FiAIpT
   GUxAX96K10+WA1D/ja8L896eSTPzkKfXY4IB0sQdijy3+iKBKJh9P+PGM
   g==;
X-CSE-ConnectionGUID: 1jo88ZPyS+O3x7WQK79vRA==
X-CSE-MsgGUID: 5Y6E93DeR4eTKqKkQeLVFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="92151355"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="92151355"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 02:35:56 -0700
X-CSE-ConnectionGUID: 1c4kpNNzSbSevDHDeNoL7w==
X-CSE-MsgGUID: w1dbyMljRUi8f4p6yv1dTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221442270"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.245.84]) ([10.245.245.84])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 02:35:54 -0700
Message-ID: <aeb25088-6ed0-4011-9804-40d9b285dff9@linux.intel.com>
Date: Tue, 17 Mar 2026 11:36:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs42l43-jack: Remove manual pm_runtime get/put from
 tip_sense_work
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, david.rhodes@cirrus.com,
 rf@opensource.cirrus.com, linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20260316124924.31047-1-peter.ujfalusi@linux.intel.com>
 <abgTWxI1Q9M1o+ka@opensource.cirrus.com>
 <d5353ee4-1a3f-43a6-93ed-5127d666ad0b@linux.intel.com>
 <abgyboHV1jaWDUul@opensource.cirrus.com>
 <f461ba8a-4208-4dfa-aa70-e2c85ec2050a@linux.intel.com>
 <52c48bf9-7fee-4c87-bf06-a9a7ebc8536f@linux.intel.com>
Content-Language: en-US
In-Reply-To: <52c48bf9-7fee-4c87-bf06-a9a7ebc8536f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,cirrus.com,opensource.cirrus.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225793-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 5D8B92A6FD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 17/03/2026 11:11, Péter Ujfalusi wrote:
> 
> 
> On 17/03/2026 08:21, Péter Ujfalusi wrote:
>>> Fundamentally reseting a device right before checking what state
>>> it was in is always going to be hard, so would be awesome if you
>>> could have a look at how much of a problem removing that bus
>>> reset would be.
>>
>> I'm still not sure if I get the whole picture, but by the hints it looks
>> like that on systems with cs42l43 we cannot suspend the DSP since the
>> codec cannot be suspended?
>> What is the difference between detecting the jack insert compared to
>> detecting the jack removal and/or the HS button detection?
>> Under the hood it is the same soundwire wake event then do what needs to
>> be done to read the cause of the event, right?
>> So, why it is OK to suspend the DSP when the jack is not inserted and it
>> is not OK if it is inserted?
> 
> Using UI shows what you might be referring to.

no need for UI, evtest also shows it.

> with the codec powered on and pressing the button:
> snd_soc_cs42l43:cs42l43_button_press: cs42l43-codec cs42l43-codec:
> Detected button 0 at 8 Ohms
> ...
> snd_soc_cs42l43:cs42l43_button_release: cs42l43-codec cs42l43-codec:
> Button release IRQ

Event: time 1773739467.877146, type 1 (EV_KEY), code 164 (KEY_PLAYPAUSE), value 1
Event: time 1773739467.877146, -------------- SYN_REPORT ------------
Event: time 1773739468.040281, type 1 (EV_KEY), code 164 (KEY_PLAYPAUSE), value 0
Event: time 1773739468.040281, -------------- SYN_REPORT ------------

> 
> when the codec and DSP suspends when audio is idle:
> snd_soc_cs42l43:cs42l43_stop_button_detect: cs42l43-codec cs42l43-codec:
> Stop button detect
> ...
> snd_soc_cs42l43:cs42l43_start_button_detect: cs42l43-codec
> cs42l43-codec: Start button detect
> ...
> snd_soc_cs42l43:cs42l43_button_press: cs42l43-codec cs42l43-codec:
> Button ignored due to bias sense
> ...
> snd_soc_cs42l43:cs42l43_button_release: cs42l43-codec cs42l43-codec:
> Button release IRQ

Event: time 1773739475.147018, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 0
Event: time 1773739475.147018, type 5 (EV_SW), code 4 (SW_MICROPHONE_INSERT), value 0
Event: time 1773739475.147018, type 5 (EV_SW), code 7 (SW_JACK_PHYSICAL_INSERT), value 0
Event: time 1773739475.147018, -------------- SYN_REPORT ------------
Event: time 1773739476.220776, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 1
Event: time 1773739476.220776, type 5 (EV_SW), code 4 (SW_MICROPHONE_INSERT), value 1
Event: time 1773739476.220776, type 5 (EV_SW), code 7 (SW_JACK_PHYSICAL_INSERT), value 1
Event: time 1773739476.220776, -------------- SYN_REPORT ------------


> 
> and the first button press is ignored  - which wakes the DSP, soundwire
> and codec up
> 
> So yes, there seams to be an issue with the headset button handling here.

To note: on another MTL laptop with codec from different vendor I see the same thing.
On LNL laptop (different codec) this works correctly.

> 
>>
>>>> Even then there is the issue of unbalance in runtime get on module
>>>> removal when the jack is connected...
>>>
>>> Yeah that is a good spot, if we stick with the current code I
>>> will get that fixed up.
>>>
>>> Thanks,
>>> Charles
>>
> 

-- 
Péter


