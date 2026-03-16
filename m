Return-Path: <stable+bounces-225567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHHnKkoWuGl/YwEAu9opvQ
	(envelope-from <stable+bounces-225567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:40:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D3629B8D6
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A212C301ECC6
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA78829B20D;
	Mon, 16 Mar 2026 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZITZBwQv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0561E511;
	Mon, 16 Mar 2026 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671836; cv=none; b=Mk1Cdl71fUPPENKFWQdPQtqGXUWgtxvGSD0j2fGGd5mu5t6dShyPDtZrbJHSrUrAUtUov3cfUs0/EwhoZy4cIPud6rS+pzF9hG+n9E4ysyZu8TCiheWhfDuBGwo/TBq/VEi9yWl5c6Oas2Ku2Sp5z/+DsMNANaxhNrsmcdOjT6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671836; c=relaxed/simple;
	bh=74v6NDydt6az4QsLHrQuZPD12oghWeI3uJouhMrdHsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSVTtDJMEcoVw8dqHH/+MrybIVVUexlg+E6B/cSXlXs7P9DXX5X0Kqb2pWH7cZSuVMSOKXC6bNQQdulIC2Vt/IauYHoJCS1Q9AeQo3o75wxIeyhbjziWUXFkn9v+9mrd5+FZMTGhQ5qh8wVlDwBDvfrmmNqEL53LhXNDrJnGn2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZITZBwQv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773671835; x=1805207835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=74v6NDydt6az4QsLHrQuZPD12oghWeI3uJouhMrdHsY=;
  b=ZITZBwQvqnXRGIu9T/iJymZHhHyLlxFoVSsAeMjkSxr/YWL+NWlV75Tu
   IEhh5Cb0WHPtln1ybJW4KaA706kH0VwlTDvqKLOn36jtSklM3PUhrIx+l
   Hqz20JSjMAy2CJK1kRKvoj597UaeRbja02nZtRq1HT1qPnNcjS8yKDshi
   +ubRxafw40+zIyu/5lkSxoeCqjzPpkmQNF4kEBXmQI59AOYEYjbdtoqNh
   1sSYp7jLRoZ3J9nmHLumklAPbcz2WzQAlLWh5UCvUOYcuWslvUE2OCxw0
   bbpR8Ze7L8/LWwdLcJRj9IZ5CFVB7EIbLDZ8o+57sLfilOIUEzdhXyghu
   A==;
X-CSE-ConnectionGUID: P2aUOZLgRxWzgKSYzMKv6A==
X-CSE-MsgGUID: 3CqEYjnARtmm4jHwte/Ltw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74874891"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74874891"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:37:15 -0700
X-CSE-ConnectionGUID: KpRHgULAQsCumIeriir+Og==
X-CSE-MsgGUID: 7NB741r9TrObAepMbvHpRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221191490"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.184]) ([10.245.244.184])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:37:14 -0700
Message-ID: <d5353ee4-1a3f-43a6-93ed-5127d666ad0b@linux.intel.com>
Date: Mon, 16 Mar 2026 16:37:28 +0200
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
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <abgTWxI1Q9M1o+ka@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,cirrus.com,opensource.cirrus.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225567-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 13D3629B8D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 16/03/2026 16:27, Charles Keepax wrote:
> On Mon, Mar 16, 2026 at 02:49:24PM +0200, Peter Ujfalusi wrote:
>> When a jack is inserted the forced pm_runtime_get() will keep the codec,
>> soundwire bus and it's parent active as long as the jack is connected.
>> This makes for example the DSP and firmware booted up on Intel platforms.
>>
>> If the module is removed while the jack is connected we will also have
>> unbalanced runtime PM state.
>>
>> Without the manual get/put, the button detection still works correctly and
>> the system can reach lower power state while the jack is connected like
>> in the case when there is no jack connected.
>>
>> Fixes: fc918cbe874e ("ASoC: cs42l43: Add support for the cs42l43")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>> ---
>>  sound/soc/codecs/cs42l43-jack.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/sound/soc/codecs/cs42l43-jack.c b/sound/soc/codecs/cs42l43-jack.c
>> index 3e04e6897b14..d90a13a55845 100644
>> --- a/sound/soc/codecs/cs42l43-jack.c
>> +++ b/sound/soc/codecs/cs42l43-jack.c
>> @@ -756,10 +756,8 @@ void cs42l43_tip_sense_work(struct work_struct *work)
>>  	ring = (sts >> CS42L43_RINGSENSE_PLUG_DB_STS_SHIFT) & CS42L43_JACK_PRESENT;
>>  
>>  	if (tip == CS42L43_JACK_PRESENT) {
>> -		if (cs42l43->sdw && !priv->jack_present) {
>> +		if (cs42l43->sdw && !priv->jack_present)
>>  			priv->jack_present = true;
>> -			pm_runtime_get(priv->dev);
>> -		}
> 
> Hmm... yes, I have this feeling this was in here for a reason I
> should probably have left a comment here. I somewhat agree it
> looks a bit mad with fresh eyes. The variable is also only used
> for tracking this pm_runtime_get so you can drop the jack_present
> variable from the struct as well, if we take the patch forward.

That was my thinking as well, but then when the headset buttons did
worked after the patch on an idle system (ARL laptop) then I thought
that this might no longer be needed?

Fwiw, I have been banging my head on why the DSP is not suspending ever
on the laptop and the system is not hitting lower C state because of
this when I had some spare time and studied the code and then removed
the jack and boom, the DSP suspended right away :o

> Best I can come up with was it was some interaction with the
> Intel host's doing a bus reset when coming out of clock stop. I
> think that might have caused something important to get
> clobbered in some situations. But anyway will do some testing and
> thinking and report back.

Sure, but draining battery when the jack is connected is not a great
added feature of a codec driver.
The type-Cs are on the other side of the laptop, so taping the jack and
power together is not a workable solution - to disconnect jack if power
is removed ;)

It would be great if you can find the reason for forcing the system up
if jack is connected.
Even then there is the issue of unbalance in runtime get on module
removal when the jack is connected...

-- 
Péter


