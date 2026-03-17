Return-Path: <stable+bounces-225895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOU2IvtEuWmK+QEAu9opvQ
	(envelope-from <stable+bounces-225895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:11:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 049C92A9999
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 266743014656
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2CA3B6C0F;
	Tue, 17 Mar 2026 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6r/fEY4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81E3AE1A4;
	Tue, 17 Mar 2026 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749236; cv=none; b=YJUyBX+THGq31dyKZ3cdY9t9PyS3emw2GFQusUDEoBTWoMlPYP7TrN1f86wnk/hMN1toktaRNbJRg9RfT3K9K7rxKRpVaMf4WmTzCLTvjQJsKoQZGv51lpJXrAcuV8s1FCxIyf7EUmZc5d0UId/iD07FwSDBWgXZ11fGvniCGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749236; c=relaxed/simple;
	bh=MofP6O6IVw3gCnduOReXuNUX8X20SYq/F3OC7gCCtfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JclU82cShDwxwpSxlZxXGVhly3i7R0Qgj0OaDh1ael1BjK5Uu/2nOAHaq3zGhcT59ELqGNrAph9v94JoYpg9pxIJdGE4v41FcvTyme2N+CThxkL3yrx5Cl6yXPP8h+hf8Cieet7Fu9EOhAvd7QuJfPZ8QzPAxNGtNnTBw4rrNz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6r/fEY4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773749235; x=1805285235;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MofP6O6IVw3gCnduOReXuNUX8X20SYq/F3OC7gCCtfs=;
  b=I6r/fEY4KG5AvqS8Xo8nO88oUTNOxZFCqVo7zIoDIAuXRKYOjI5jZ9Re
   lqmtq6mAd0DuEn2Z1qQ/dM7SGGDMa0wSdhfoPa6hNq4XUBWtm/4vjHqiP
   3hlOWCkUXG+EsJFRWWirsABuW16ENQd7s0S7+UN6Pp+4th15yG4JfBj2W
   2aVhaZcCqP3NwynO16sQS2X2g5oB0HMCPHmqEw7kXVTn9/gZS0ySt1clW
   SahU83Ka3D+PWd7ccfGp/zee7aH70OUM7VqocUwIguU2YVW0++ua2wPUb
   +jVqeudYgkC/gj4U4nKDZ3ZfnCOvBN2S3kEpDa3w5cPzUBivF8euokzM0
   g==;
X-CSE-ConnectionGUID: CkavdfKFQ32PKIVEZo/dGw==
X-CSE-MsgGUID: iB9xW9wHRjOUj2VRB/N9Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="86251929"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86251929"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 05:07:14 -0700
X-CSE-ConnectionGUID: FNHVAggETXeT8xThxKsejw==
X-CSE-MsgGUID: u9UEoAGzTYmGig4VGHhnWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="260154414"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.245.84]) ([10.245.245.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 05:07:12 -0700
Message-ID: <f6a22c54-1b91-4013-a774-b56d921cdb67@linux.intel.com>
Date: Tue, 17 Mar 2026 14:07:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs42l43-jack: Remove manual pm_runtime get/put from
 tip_sense_work
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, david.rhodes@cirrus.com,
 rf@opensource.cirrus.com, linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20260316124924.31047-1-peter.ujfalusi@linux.intel.com>
 <abgTWxI1Q9M1o+ka@opensource.cirrus.com>
 <d5353ee4-1a3f-43a6-93ed-5127d666ad0b@linux.intel.com>
 <abgyboHV1jaWDUul@opensource.cirrus.com>
 <f461ba8a-4208-4dfa-aa70-e2c85ec2050a@linux.intel.com>
 <abk+o6ZpLRt86K+M@opensource.cirrus.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <abk+o6ZpLRt86K+M@opensource.cirrus.com>
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
	TAGGED_FROM(0.00)[bounces-225895-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 049C92A9999
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 17/03/2026 13:44, Charles Keepax wrote:
> On Tue, Mar 17, 2026 at 08:21:12AM +0200, Péter Ujfalusi wrote:
>> On 16/03/2026 18:40, Charles Keepax wrote:
>>> On Mon, Mar 16, 2026 at 04:37:28PM +0200, Péter Ujfalusi wrote:
>>>> On 16/03/2026 16:27, Charles Keepax wrote:
>>>>> On Mon, Mar 16, 2026 at 02:49:24PM +0200, Peter Ujfalusi wrote:
>>>  1) The one already in the code.
>>>  2) Stop the host from reseting the codec.
>>
>> The issue with 1 (how it is atm) is that it is done in a completely
>> wrong place. I think the cs42l43 can be used with other than Intel MTL,
>> let's say Qualcomm or AMD?
>> If there is a workaround needed for something on the platform, it has to
>> be done in the platform code.
> 
> There is probably a discussion to be had here, its far from clear
> to me this is the wrong place to do this. Generally the codec
> controls when the codec wants to mark itself as runtime active.
> For example on our phone devices where far more of the chip
> powered down in runtime suspend having a jack in would always
> keep the device powered up so the button detect could run,
> as the lowest power states disabled that.

I see, what about this:
if the inserted accessory is CS42L43_JACK_HEADSET (SND_JACK_HEADSET)
then do one more pm_runtime_get() to allow the button presses to be handled?
This would allow the laptop to hit lower power state if a headphone is
connected, headphones do not have buttons as they don't have mic ring.

The jack_plugged would be renamed as jack_is_headset or something and
drop the rpm on jack removal for headset ( and on module remove).

> It is also appears the specification doesn't prohibit issuing
> a bus reset when coming out of a mode 0 clock stop (which seems
> bonkers to me, given literally the only difference between that
> and a mode 1 clock stop is that the mode 1 clock stop resets the
> device). But without the specification prohibiting this then
> the device can't rely on the host not to do it, so doing this
> could be required on any platform.
> 
> I can however see the argument that it would be nice to only
> force the codec out of runtime suspend on platforms where this is
> necessary but its not obvious to me what the sensible mechanism
> would be.
> 
> Thanks,
> Charles

-- 
Péter


