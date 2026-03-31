Return-Path: <stable+bounces-231319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MYABchXy2leGgYAu9opvQ
	(envelope-from <stable+bounces-231319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:12:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3212364070
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F3933043FA9
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1683936D51F;
	Tue, 31 Mar 2026 05:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2LAYgPp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A936C5A1;
	Tue, 31 Mar 2026 05:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933933; cv=none; b=r9N77yyT2m4mqabaCmE8Hckoh36mBo92OsLJ/Iew3po6S/hhF+YRYFe6r/1kMfgMielV8rO/0E1iaZx27/ql/LxV9m5CVowtF4hwaIWcw6fHIyN5tZezo6KeqWpzH4ikDQ+/55T8EmiWLve+kQ4VrUMM4UgIXIhmhTXZs7W+06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933933; c=relaxed/simple;
	bh=bGQCnPeAYldP30QzX60pY3pg3Zg/GnBOiiNwoVJI5cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKN46uVOBoc0wK6nZk7SDGeuHeVWxSwkYm+S0ovatJnlBE6cpTjpBOiXsdnCkuSUmSMOL/7EmWkKCbRi44u4JNykduz3bv2bJpGMer/ntskmRZ6hGgo+TqpVD0ElhZyXYXoLQnr3vJbikuYlKSUW6qdHsMa5G8Uks4Vp18jTwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2LAYgPp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774933932; x=1806469932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bGQCnPeAYldP30QzX60pY3pg3Zg/GnBOiiNwoVJI5cM=;
  b=H2LAYgPpALAV3I1H8IwoJcvoy38c3uok7yeX08BXczLznR7bI2fTBMGJ
   JutyPLSRHsVPltRHLW4z/vX+tx5sNIupZn9FQk949oDtR3gNA0FJG6VYC
   kg2hkEMhaGGN1H8MvU5o7j+6VYylZpcUEcBRtCP3S2IGNtyIorBvdm+tf
   3ghSOSHTb0BwGm3VGL4+3pxqxElrebd5Y7LxcQMTjwJsHUW1iY95SrGn3
   NBfA44TC7Wl74k7FCwOrGP3PxZbHx7yR1VKbtuoVH9VqG77MNS7mDoyEi
   66fQyOuB8DuOfSfx++EEWEmc36zM1NTSeazRFO9MdBlSMbC2viDwZanzs
   A==;
X-CSE-ConnectionGUID: MRs15qnJSHWD77HkrZ9PFA==
X-CSE-MsgGUID: 4lvBGY4fQn+UeGhzUziM5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86552995"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="86552995"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 22:12:11 -0700
X-CSE-ConnectionGUID: XCW0dGPuQDOI/Ggoxfe0mg==
X-CSE-MsgGUID: 3GyJApuoROaO9SLvSORGbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="223371845"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.218]) ([10.245.245.218])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 22:12:08 -0700
Message-ID: <8f37f7dc-bcac-4344-9532-b59eac7e1ffd@linux.intel.com>
Date: Tue, 31 Mar 2026 08:12:25 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: Don't allow pointer operations on unconfigured
 streams
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Paul Olaru <paul.olaru@oss.nxp.com>,
 Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260326-asoc-compress-tstamp-params-v1-1-3dc735b3d599@kernel.org>
 <3cd96fe7-4575-40f9-a1f2-610fb1fac5c1@linux.intel.com>
 <aca1sW6ca1QJBN9V@sirena.co.uk>
 <e3c69a0a-5ed1-45f7-9180-9268bd671df0@linux.intel.com>
 <bf12ef77-0d28-4454-a910-59bf915b5048@sirena.org.uk>
 <3672d018-d7c2-4bdf-a130-60ed76a9e543@linux.intel.com>
 <accf8fa2-72b2-48a5-bdb7-72784b199347@sirena.org.uk>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <accf8fa2-72b2-48a5-bdb7-72784b199347@sirena.org.uk>
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
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,nxp.com,linux.dev,perex.cz,suse.com,oss.nxp.com,alsa-project.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-231319-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3212364070
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 30/03/2026 23:11, Mark Brown wrote:
> On Mon, Mar 30, 2026 at 02:50:15PM +0300, Péter Ujfalusi wrote:
>> On 30/03/2026 14:05, Mark Brown wrote:
> 
>>> We don't generally guard calls based on the state the stream is in,
> 
>> compress does this quite much, just avail and tstamp is exempt for some
>> reason.
> 
> Actually already we have a guard preventing userspace from doing an
> avail() when we're unconfigured but we do it after we've called down
> into the driver which is less than ideal.  I think that's because we
> also check for XRUN and the availability check might cause us to notice
> that we're in a bad state for that.

I don't see how the avail path checks for XRUN and if the drivers
supposed to do that, I'm not even sure if XRUN is possible with compress..

I did noted that the avail have the state check reversed, making it
ineffective.

The other point is that any return code from the driver's pointer
callback is ignored by the core, the return value of
stream->ops->pointer() is not even captured, it could be void.
Looks like a design choice, but I cannot say.

fwiw, the same check should be added to sound/soc/qcom/qdsp6/q6apm-dai.c
as it does div with prtd->pcm_size (q6apm_dai_compr_pointer), which is
only initialized in set_params.

-- 
Péter


