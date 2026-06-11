Return-Path: <stable+bounces-262648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3oouCOiBKmqJrQMAu9opvQ
	(envelope-from <stable+bounces-262648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 11:37:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F7D670758
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 11:37:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ldQ+n31G;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262648-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262648-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76157320BB1C
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7193BCD0E;
	Thu, 11 Jun 2026 09:33:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476B43BA235;
	Thu, 11 Jun 2026 09:33:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170425; cv=none; b=sexisG3Y4gmK9cuiHfjuIi9Dhh3JMWvvpUBm7SwKEP/fomd+j7KwJywAHRUMGebZ5szw3ZTFnALfbwd2CXh+SljPjBuHZJD56JIqx5QibHy3lkY/1WJPe7qy/1Z00wlehe8WMfLxFyOu1OiUvl4yUQNz8lNwy8yzIrgu5po6UyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170425; c=relaxed/simple;
	bh=qOCCFlc+PSyf1avdq3ICE35rnneoH7tC3PkRXdj2zcI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fd+VxuIXyzo7uPD8+ObeogSHhOw8Psk1hzZUBVvTEI8ScmxwWrPT1YU2OvISeFqy3DDbFP9rwYodvzRNRYC4+ETMDA9zDdp7f8JQNPfIsUP5bmX4KEjWFnOIV78HBZqk8994sgWIdq6b6NlTq6iph1JmgupF50GxDZDZvPFen6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldQ+n31G; arc=none smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781170424; x=1812706424;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=qOCCFlc+PSyf1avdq3ICE35rnneoH7tC3PkRXdj2zcI=;
  b=ldQ+n31GgVZFPgtvc6UGdf/SYRiduxToyf8bjMSjdbArwgq8z83lo+r1
   1gDL4CizTb8bpAFVTvCMdHjTAKQY272wwGVorgpAzXjwY+vra84ZtN3AB
   Czg+i9Yw0RaKaiqVk+wfDgKiiLCm1BD9MNaX0+SvJb9MReApHODLm1uxy
   Eqig+9uQbAVOHGCdPEiQW7w4zOek0wh+3AYhMKxKK7OESSajKM3uXDw9a
   +O8bwMuldfv7Y1CYJmLWmTlVEhdD5cCgP4dbTyiWZKbXHfC6znyJPvpWM
   +IyAYETqmPbBtfg+rlBJS7kfNHwgqTyYtsTwVnrnwHpm6Mwu9K9yK9YLV
   g==;
X-CSE-ConnectionGUID: G2olyCWYSmiMlkNqDVa5DA==
X-CSE-MsgGUID: 2GU4A7v4S7mFTYFXvFhWEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92543609"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="92543609"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:33:44 -0700
X-CSE-ConnectionGUID: IFfu+EXtSfq6SIViYZWVpA==
X-CSE-MsgGUID: YEEHzjp7TKmCkXnMGfQFpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="243988556"
Received: from carterle-desk.ger.corp.intel.com (HELO [10.245.246.63]) ([10.245.246.63])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:33:41 -0700
Message-ID: <ec0d51a0-a31d-4c06-92f6-e38c408884b9@linux.intel.com>
Date: Thu, 11 Jun 2026 12:33:50 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/hdmi: disable KAE for Intel Panther Lake
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: Alexander Kaplan <alexander.kaplan@sms-medipool.de>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 stable@vger.kernel.org, "Shankar, Uma" <uma.shankar@intel.com>
References: <20260610174834.6301-1-alexander.kaplan@sms-medipool.de>
 <5e05e954-338c-4a87-8a60-1fd2bd6bb8ce@linux.intel.com>
Content-Language: en-US
In-Reply-To: <5e05e954-338c-4a87-8a60-1fd2bd6bb8ce@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262648-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alexander.kaplan@sms-medipool.de,m:tiwai@suse.com,m:linux-sound@vger.kernel.org,m:perex@perex.cz,m:kai.vehmanen@linux.intel.com,m:pierre-louis.bossart@linux.dev,m:stable@vger.kernel.org,m:uma.shankar@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,vger.kernel.org:from_smtp,gitlab.freedesktop.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57F7D670758



On 11/06/2026 12:08, Péter Ujfalusi wrote:
> My setup is: laptop HDMI -> SYNIC HDMI audio extractor -> HDMI KVM ->
> monitor w/o speakers.
> I use the extractor to grab the audio and it is clean every time I play
> audio to HDMI.

Just to rule out iffy equipment on my side, I have connected the PTL
laptop to my Denon AVR both in SOF and legacy HDA mode. I cannot hear
any issue regarding to audio on my 5.1 speaker set.

> Can this be somehow related to the DP-to-HDMI converter? Have you tested
> that with other machine?
> Or a combination of xe2+DP-to-HDMI?
> 
> Ccing Uma for display side
>> This may also fix the silent Dolby TrueHD passthrough on Battlemage
>> reported in
>> https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7515.
>> Battlemage uses the same keep-alive code path and TrueHD passthrough
>> is the same first-multichannel-stream pattern, but I could not test
>> that hardware.
>>
>> Workaround for affected systems without this patch:
>> snd_hda_codec_intelhdmi.enable_silent_stream=0.
>>
>>  sound/hda/codecs/hdmi/intelhdmi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/hda/codecs/hdmi/intelhdmi.c b/sound/hda/codecs/hdmi/intelhdmi.c
>> index 6a7882544a..52997caae9 100644
>> --- a/sound/hda/codecs/hdmi/intelhdmi.c
>> +++ b/sound/hda/codecs/hdmi/intelhdmi.c
>> @@ -791,7 +791,7 @@ static const struct hda_device_id snd_hda_id_intelhdmi[] = {
>>  	HDA_CODEC_ID_MODEL(0x8086281e, "Battlemage HDMI",	MODEL_ADLP),
>>  	HDA_CODEC_ID_MODEL(0x8086281f, "Raptor Lake P HDMI",	MODEL_ADLP),
>>  	HDA_CODEC_ID_MODEL(0x80862820, "Lunar Lake HDMI",	MODEL_ADLP),
>> -	HDA_CODEC_ID_MODEL(0x80862822, "Panther Lake HDMI",	MODEL_ADLP),
>> +	HDA_CODEC_ID_MODEL(0x80862822, "Panther Lake HDMI",	MODEL_TGL),
>>  	HDA_CODEC_ID_MODEL(0x80862823, "Wildcat Lake HDMI",	MODEL_ADLP),
>>  	HDA_CODEC_ID_MODEL(0x80862824, "Nova Lake HDMI",	MODEL_ADLP),
>>  	HDA_CODEC_ID_MODEL(0x80862882, "Valleyview2 HDMI",	MODEL_BYT),
> 

-- 
Péter


