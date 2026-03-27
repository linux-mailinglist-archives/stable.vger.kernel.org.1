Return-Path: <stable+bounces-230611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HqHGJRTxmkkIwUAu9opvQ
	(envelope-from <stable+bounces-230611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:53:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE743342093
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4216330B3AE4
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793CF3DC4D6;
	Fri, 27 Mar 2026 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOcomEd2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DF236AB46;
	Fri, 27 Mar 2026 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604970; cv=none; b=ipRe9ZY+DvoAKweCimgG7glTaZo6p8OQWLgObbv5195dtrkM5xUWBRmQJeH+fBskYHTijI3hFASa6UJbyiQ3SRjlRw9jjIg9iwlYfdnTYqga6JcQSteoj7Qij5weHLBvLaK7642+Md8mB0mvFm+kDQALbOJnz1lXON2hN+Mqnic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604970; c=relaxed/simple;
	bh=d8LeTn2owfYK7hLjrXzgR9iinlSReoBrCWpWK2GTg/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQjo0pc0rKRcUE3yeM6RUvccwuziIIDO7HHwq3CWE8LzGoQ13R1Rf5GYtpUdssx7qNwGO5YxHg72zS3F946czd4TVD3krshW87u9+WqPpjUH+yblrnda8YSoPik6y4jl5+clh8ddPos9oWOmH741Riwav4dDUP6uhrpzYogfECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOcomEd2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774604968; x=1806140968;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d8LeTn2owfYK7hLjrXzgR9iinlSReoBrCWpWK2GTg/s=;
  b=FOcomEd2ZaSF0fODVpAh/1tZWOGabO0dN4otrNCDCnWHexKky66fJKUK
   /3Mr3U4R5Me4eOFdvi2ana33YioD8Wb248g4aYqWPHsrzCTUSSnR2r9Dp
   cwda6EGz+sly06Mawbn0QjrFh2vSZH9CKmnxksdSfBIFyMix4EKncZYw6
   p5q0OQJoLdBvulfLFejuKbCh6EsT9qEpo33Qtzsbjrnsn+8PF07lB6d1z
   zSEOoyBzyzHmZFwDoEZHguGrlEa3c5RA1K0OS5NaCZU5QKLAYu4625YtF
   TdJKaC71D4L59i1d9+0AO+5zHOY6FuWVhhngN+cY37DAQ+a9D4e6bWjOq
   w==;
X-CSE-ConnectionGUID: YXL1arDwS4Ox6ePfvzcVXQ==
X-CSE-MsgGUID: 5D/fSWxqTPOL6HYzheer8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="101135347"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="101135347"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:49:28 -0700
X-CSE-ConnectionGUID: DBt+iOidTTq6zsK64aLb5A==
X-CSE-MsgGUID: f++7qdMmQrawAslXvg0Dag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="222394731"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.182]) ([10.245.244.182])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:49:24 -0700
Message-ID: <3cd96fe7-4575-40f9-a1f2-610fb1fac5c1@linux.intel.com>
Date: Fri, 27 Mar 2026 11:49:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: Don't allow pointer operations on unconfigured
 streams
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Paul Olaru <paul.olaru@oss.nxp.com>,
 Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260326-asoc-compress-tstamp-params-v1-1-3dc735b3d599@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20260326-asoc-compress-tstamp-params-v1-1-3dc735b3d599@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-230611-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux.intel.com,nxp.com,linux.dev,perex.cz,suse.com,oss.nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: BE743342093
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26/03/2026 16:52, Mark Brown wrote:
> When reporting the pointer for a compressed stream we report the current
> I/O frame position by dividing the position by the number of channels
> multiplied by the number of container bytes. These values default to 0 and
> are only configured as part of setting the stream parameters so this allows
> a divide by zero to be configured. Validate that they are non zero,
> returning an error if not
> 
> Fixes: c1a731c71359 ("ASoC: SOF: compress: Add support for computing timestamps")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  sound/soc/sof/compress.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
> index 96570121aae0..90f056eae1c3 100644
> --- a/sound/soc/sof/compress.c
> +++ b/sound/soc/sof/compress.c
> @@ -379,6 +379,9 @@ static int sof_compr_pointer(struct snd_soc_component *component,
>  	if (!spcm)
>  		return -EINVAL;
>  
> +	if (!sstream->channels || !sstream->sample_container_bytes)
> +		return -EBUSY;
> +

Is this a theoretical fix?
I don't think this can happen in real world as set_params would need to
fail and if that failed then applications would not ask for a pointer as
the compress stream cannot be even started.

>  	tstamp->sampling_rate = sstream->sampling_rate;
>  	tstamp->copied_total = sstream->copied_total;
>  	tstamp->pcm_io_frames = div_u64(spcm->stream[cstream->direction].posn.dai_posn,
> 
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260326-asoc-compress-tstamp-params-296f38f15217
> 
> Best regards,
> --  
> Mark Brown <broonie@kernel.org>
> 
> 

-- 
Péter


