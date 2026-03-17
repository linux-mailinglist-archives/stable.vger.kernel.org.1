Return-Path: <stable+bounces-225746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VADuBNLyuGncmAEAu9opvQ
	(envelope-from <stable+bounces-225746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:21:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E822A4414
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8BB83020D7E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 06:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C326637C921;
	Tue, 17 Mar 2026 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kK2ApgL/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9201AB6F1;
	Tue, 17 Mar 2026 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728459; cv=none; b=EsPXCxyYmeZ+IIhwYXSuoVzOcA59LGR+Jf7jTv94TPenjJPPzsqp5IiRfA1sFbsOD7HaAJKVI1iu+sZsgj59kURdVgPrXaYCN3PSlT2CbPwgXATMmgpY5czOg57JQ4FQB0AfYFeZBts/hjrgelYcvpkwEXcL1GXD6IKcrIiexSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728459; c=relaxed/simple;
	bh=q+j0EbMadPH45t5+VTGG6ns6hRrs1mCvuIV3+4vfP9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJnjEpXvCIL77j0KFv+4TPYGy7/KbmWRoMFoUca1BT+NwFJ+wnjVibKiD4d8utpljYrG5fTZ0BI04q78Bt9HL2V2oi53dFioFcKtvhG0L7oG1/drOsEYoxGY5aFLCJL6NAcdyxTOtpiYkW0PV6WsI0k716JYpWEd22Gt1ISSHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kK2ApgL/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773728457; x=1805264457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q+j0EbMadPH45t5+VTGG6ns6hRrs1mCvuIV3+4vfP9g=;
  b=kK2ApgL/SqYInNyglq4BCFr7pOlzWLGBUv9InV3TAAxRR5xzcCCaCM6F
   gcYbs/EkPNxDUMOHRrKoQ02pkCwt317QzviY6PfcmKDI2qb1vua8zl4tj
   bQAphAgzzgjCFPR9O3kb8l53ixDxQl7EWwxK7VweN0r80ztcDu0qZkGGA
   HHEkCA0ly7wsRP5TLD/qkbbVzck3tlZPe2J+doCUBJz3iWQNiJjwLA7Sc
   JIiUuRO5hEtx5U6ycmczlOGMN0U27GBX3OS+tgBuCD3wvgnaO8fSZ6fm5
   cYSZhDW4zmhcBzgRCcOwTUX+Iqr/EFnjppRqcKclEMMqeoxMehg9XNrVe
   Q==;
X-CSE-ConnectionGUID: sSZAT0a3Q3ySVIJrUpRBUQ==
X-CSE-MsgGUID: QQwOi3JxSBOznvxUb9GqKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85380028"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85380028"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 23:20:57 -0700
X-CSE-ConnectionGUID: aY/zPPtoQfKmFesAMh1zxw==
X-CSE-MsgGUID: BknHtRLKTNmDlyj2fdWMmw==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.245.84]) ([10.245.245.84])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 23:20:55 -0700
Message-ID: <f461ba8a-4208-4dfa-aa70-e2c85ec2050a@linux.intel.com>
Date: Tue, 17 Mar 2026 08:21:12 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <abgyboHV1jaWDUul@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,cirrus.com,opensource.cirrus.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225746-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 63E822A4414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 16/03/2026 18:40, Charles Keepax wrote:
> On Mon, Mar 16, 2026 at 04:37:28PM +0200, Péter Ujfalusi wrote:
>> On 16/03/2026 16:27, Charles Keepax wrote:
>>> On Mon, Mar 16, 2026 at 02:49:24PM +0200, Peter Ujfalusi wrote:
>>> Hmm... yes, I have this feeling this was in here for a reason I
>>> should probably have left a comment here. I somewhat agree it
>>> looks a bit mad with fresh eyes. The variable is also only used
>>> for tracking this pm_runtime_get so you can drop the jack_present
>>> variable from the struct as well, if we take the patch forward.
>>
>> That was my thinking as well, but then when the headset buttons did
>> worked after the patch on an idle system (ARL laptop) then I thought
>> that this might no longer be needed?
> 
> Hmm... are you sure that was working? Tried removing it (on
> MTL here) and I see quite a few issues.

Yes, it is working on ARL (which is MTL in this regards).
There are several
soundwire_intel soundwire_intel.link.0: Slave status change: 0x2000000
soundwire_intel soundwire_intel.link.0: Slave status change: 0x4000000

back and forth, but the button press got handled fine.

Note 1: the same status change sequence happens when I plug the headset.
Note 2: the same status change sequence happens if I play audio to the
headset and then press the buttons
Note 3: without this patch I see the same status change churn when the
headset is plugged and button is pressed.

>> Fwiw, I have been banging my head on why the DSP is not suspending ever
>> on the laptop and the system is not hitting lower C state because of
>> this when I had some spare time and studied the code and then removed
>> the jack and boom, the DSP suspended right away :o
> 
> Apologies for that :-)

None of the other laptops that I have did similar thing, only this with
cs42l43, all others allows the DSP to suspend while headset is connected.

>> Sure, but draining battery when the jack is connected is not a great
>> added feature of a codec driver.
>> The type-Cs are on the other side of the laptop, so taping the jack and
>> power together is not a workable solution - to disconnect jack if power
>> is removed ;)
> 
> I am not sure there are many other solutions. I will burn a few
> cycles investigating here, but I suspect its going to come down
> to a choice of two solutions:
> 
>  1) The one already in the code.
>  2) Stop the host from reseting the codec.

The issue with 1 (how it is atm) is that it is done in a completely
wrong place. I think the cs42l43 can be used with other than Intel MTL,
let's say Qualcomm or AMD?
If there is a workaround needed for something on the platform, it has to
be done in the platform code.

> Fundamentally reseting a device right before checking what state
> it was in is always going to be hard, so would be awesome if you
> could have a look at how much of a problem removing that bus
> reset would be.

I'm still not sure if I get the whole picture, but by the hints it looks
like that on systems with cs42l43 we cannot suspend the DSP since the
codec cannot be suspended?
What is the difference between detecting the jack insert compared to
detecting the jack removal and/or the HS button detection?
Under the hood it is the same soundwire wake event then do what needs to
be done to read the cause of the event, right?
So, why it is OK to suspend the DSP when the jack is not inserted and it
is not OK if it is inserted?

>> Even then there is the issue of unbalance in runtime get on module
>> removal when the jack is connected...
> 
> Yeah that is a good spot, if we stick with the current code I
> will get that fixed up.
> 
> Thanks,
> Charles

-- 
Péter


