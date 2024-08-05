Return-Path: <stable+bounces-65404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1384294800E
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 19:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3435D1C225B6
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AD715E5D3;
	Mon,  5 Aug 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOHE3pIf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BDE155351;
	Mon,  5 Aug 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877789; cv=none; b=NFi4Fq+ws3f/DsPg6NdS7NtS3qAAPjjn6/MkSfuapxhgPyfiZy1pTiCpJKA3ShirJwhIz5NoLtOkCFIgVCJ6lk7KinCSMXzVpqrwVIXJsVbWHTdHY7UZ1MMavGpbj7/stkX82UI/azmA8FCOB8J/YVkp7ZTJJVz8pLyXu5Nq3vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877789; c=relaxed/simple;
	bh=l5eeU2KMyQQLO/LoHJpu0VbOHJKCVW2Gxs25CzhaKeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3ua1lwcFDGy92TxSN4FqXOqZJIW+WnxrTbys1dqLBkNDoGQPtSmYbHkrLKzJHwdhaABBrWCw1bhTaEHDU4ciHj5ETuvZ8p3iqLsbQJ1K5mCZTCW42Qw9xV7hO+1ivXR6upObtimLghZv7t3N54nui1B8xwhSCrsQTYp20i3WzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOHE3pIf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722877788; x=1754413788;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l5eeU2KMyQQLO/LoHJpu0VbOHJKCVW2Gxs25CzhaKeM=;
  b=LOHE3pIffKd5Hlt+uHH7IYFwdfvjuYuF+BPuREVPGkiWxWXVFQ+kHdoU
   6KJgZV4ZXPxGCuOwddogonFYCDo6a/PAD4qILdBpQIa3ymn3Hi1cheL8w
   VVZONgPUG5ScS9Sh7D027d3dDLI2yUQ3YKMLvQYMCrtuEoIWWedckI88Z
   ZsQU2Y52KytO/5ySRrwj48N8zXTNTUznHOmUkhvXyrBt5CFedK/UjACsC
   I9VSYaL+6Na7Awe2ddyuSmYGiGKNDeUrDeYwPrxIS05LPknf5erRlpvH5
   QY8g1pOT8rEmdykvGBqd9KD7Sk2k9pmMUTwoori9fGypK1aPQfqWZ7RtJ
   w==;
X-CSE-ConnectionGUID: 5gLTciPtTZq8wupjHAeRAA==
X-CSE-MsgGUID: wekTk4RRQK2w4CIq9w4mwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="46256294"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="46256294"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 10:09:47 -0700
X-CSE-ConnectionGUID: qgbq14LYS9myPs/NA8Nw9g==
X-CSE-MsgGUID: +F64G3IIR/K9G6dYpE7b0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="60373390"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.181]) ([10.245.246.181])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 10:09:43 -0700
Message-ID: <14e54a89-5c62-41b2-8205-d69ddf75e7c7@linux.intel.com>
Date: Mon, 5 Aug 2024 19:09:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.9 17/40] ASoC: topology: Fix route memory
 corruption
To: Vitaly Chikunov <vt@altlinux.org>, Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, linux-sound@vger.kernel.org
References: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/5/24 18:17, Vitaly Chikunov wrote:
> Sasha, Greg,
> 
> On Tue, Jul 09, 2024 at 12:18:57PM GMT, Sasha Levin wrote:
>> From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>>
>> [ Upstream commit 0298f51652be47b79780833e0b63194e1231fa34 ]
>>
>> It was reported that recent fix for memory corruption during topology
>> load, causes corruption in other cases. Instead of being overeager with
>> checking topology, assume that it is properly formatted and just
>> duplicate strings.
> 
> Can this backport actually be applied to the 6.9/6.6/6.1 stable branches?
> 
> I have multiple bug reports about sound not working and memory
> corruption on some laptops (for example ICL RAYbook Si1516). See for
> example bug reports[1][2], and the fix discussion [3].
> 
> dmesg messages from Lenovo ThinkBook 13 gen 1:
> 
> 
>   [ 3.555191] sof-audio-pci-intel-cnl 0000:00:1f.3: Firmware info: version 2:2:0-57864
>   [ 3.555206] sof-audio-pci-intel-cnl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
>   [ 3.574043] sof-audio-pci-intel-cnl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:0
>   [ 3.575180] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sink MIXER1.0> not found
>   [ 3.575772] sof-audio-pci-intel-cnl 0000:00:1f.3: error: tplg component load failed -22
>   [ 3.575793] sof-audio-pci-intel-cnl 0000:00:1f.3: error: failed to load DSP topology -22
>   [ 3.575801] sof-audio-pci-intel-cnl 0000:00:1f.3: ASoC: error at snd_soc_component_probe on 0000:00:1f.3: -22
> 
> Error messages from other boots showing memory corruption:
> 
>   [ 3.904397] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sink PCM0C03-std-def-alt0.p11@jh\x86Ŝ\xff\xff@\xc8\xff\x82Ŝ\xff\xff`P\x82\xbb\xff\xff\xff\xff\x94$A\xbc\xff\xff\xff\xff\x06 not found
>   [ 3.966777] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sink PGA1.0\x01 not found
>   [ 3.899748] sof-audio-pci-intel-cnl 0000:00:1f.3: error: source BUF2.0 not found
>   [ 3.975359] sof-audio-pci-intel-cnl 0000:00:1f.3: error: source PCM0P\x01pcsc-lite.conf not found
>   [ 7.275851] sof-audio-pci-intel-tgl 0000:00:1f.3: error: source HDA1.IN/0123456789:;<=>? not found
> 
> [1] https://github.com/thesofproject/sof/issues/9339
> [2] https://github.com/thesofproject/sof/issues/9341
> [3] https://lore.kernel.org/linux-sound/171812236450.201359.3019210915105428447.b4-ty@kernel.org/T/#m8c4bd5abf453960fde6f826c4b7f84881da63e9d

Agree, the commit "ASoC: topology: Fix references to freed memory"
[ Upstream commit 97ab304ecd95c0b1703ff8c8c3956dc6e2afe8e1 ]
should not have landed on any -stable branch. It should be reverted or
this follow-up fix be applied.

> 
> Thanks,
> 
>>
>> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Closes: https://lore.kernel.org/linux-sound/171812236450.201359.3019210915105428447.b4-ty@kernel.org/T/#m8c4bd5abf453960fde6f826c4b7f84881da63e9d
>> Suggested-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> Link: https://lore.kernel.org/r/20240613090126.841189-1-amadeuszx.slawinski@linux.intel.com
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  sound/soc/soc-topology.c | 12 +++---------
>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
>> index 52752e0a5dc27..27aba69894b17 100644
>> --- a/sound/soc/soc-topology.c
>> +++ b/sound/soc/soc-topology.c
>> @@ -1052,21 +1052,15 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
>>  			break;
>>  		}
>>  
>> -		route->source = devm_kmemdup(tplg->dev, elem->source,
>> -					     min(strlen(elem->source), maxlen),
>> -					     GFP_KERNEL);
>> -		route->sink = devm_kmemdup(tplg->dev, elem->sink,
>> -					   min(strlen(elem->sink), maxlen),
>> -					   GFP_KERNEL);
>> +		route->source = devm_kstrdup(tplg->dev, elem->source, GFP_KERNEL);
>> +		route->sink = devm_kstrdup(tplg->dev, elem->sink, GFP_KERNEL);
>>  		if (!route->source || !route->sink) {
>>  			ret = -ENOMEM;
>>  			break;
>>  		}
>>  
>>  		if (strnlen(elem->control, maxlen) != 0) {
>> -			route->control = devm_kmemdup(tplg->dev, elem->control,
>> -						      min(strlen(elem->control), maxlen),
>> -						      GFP_KERNEL);
>> +			route->control = devm_kstrdup(tplg->dev, elem->control, GFP_KERNEL);
>>  			if (!route->control) {
>>  				ret = -ENOMEM;
>>  				break;
>> -- 
>> 2.43.0
>>


