Return-Path: <stable+bounces-66435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2522A94EA68
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8434BB20E65
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E4216EB62;
	Mon, 12 Aug 2024 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEEi89s/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A316EB56;
	Mon, 12 Aug 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456918; cv=none; b=jTiUVDEwQvyUddSqa73PPeQsru5lDWWlI6mWFPkUsHgkH6GSjvfKjCYRwJn7Mb3vXCwKUajzZzMrKFT8kAdwFtv1Ztb9Ahh/YGJiIZqkDv3MkbIzauRp6MKfDpfpuW8UGXlYVQk5UWERWzNfDxjiHvF6ef5OZTaREnV6j6DvMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456918; c=relaxed/simple;
	bh=TUocSQU3Sq/FRWIM0WGpMLrzqpfEl4TEcFWNcxSwA/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cee1My7b327j0+JwUx/HtMB669wSemouMT7GWhLltOyda62D51bkUGEKO7IRrChpz/+D57+10Yn4Lt/DdCR4GRkY+Sk1iIBNKW4lwqXFNz8UbFRuogjEp12tCQUiBpTiSkjuf5pAcX9D0FkyFqoVG5Q7LJv5zD3dPId0asrVoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEEi89s/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723456916; x=1754992916;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TUocSQU3Sq/FRWIM0WGpMLrzqpfEl4TEcFWNcxSwA/E=;
  b=dEEi89s/jVWnY+7YG2riAG60DuqT3bL9aULn7siS28ZPkOmmJ+eK1Z1C
   a4ISfpgsrph89OJS55CBObWJDj6z+GMvtrU/WURXyO4Dr8aKoEDwYtMQl
   3RIBdg48Zl0FBmLg2tBe1bMrmdvGDW/FLrPkXqqUs9BF9hH20wQLSeI64
   TzuFbnQvZKk8vPA4SH3/f6edQHnv5SFHLQVddARxqAd1g+Li78utgR+5i
   DrLTGwj2Nv2y/Cl4HtQKpdpr9AP/e03GKKyK01bd34wQRgDtnWN0EkUa5
   pJvi4Z6CDzChdU8A0yxthEOZCRXCIwQRDYPCO8a4OBRmzkjyn1uvLX40S
   Q==;
X-CSE-ConnectionGUID: WJ6L4rfzS02A0jMubr610g==
X-CSE-MsgGUID: LPge9YCiRzenoKHEG9jPVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32179672"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32179672"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 03:01:55 -0700
X-CSE-ConnectionGUID: u60RawHgSUev7WIJ84u9+Q==
X-CSE-MsgGUID: 1woNTNf7TgayM4VHM0FB9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58288140"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 03:01:51 -0700
Message-ID: <210a825d-ace3-4873-ba72-2c15347f9812@linux.intel.com>
Date: Mon, 12 Aug 2024 12:01:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.9 17/40] ASoC: topology: Fix route memory
 corruption
Content-Language: en-US
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, linux-sound@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Vitaly Chikunov <vt@altlinux.org>, stable@vger.kernel.org
References: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
 <14e54a89-5c62-41b2-8205-d69ddf75e7c7@linux.intel.com>
 <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I guess that for completeness you need to apply both patches:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=97ab304ecd95c0b1703ff8c8c3956dc6e2afe8e1
was an incorrect fix which was later fixed by:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=0298f51652be47b79780833e0b63194e1231fa34

Applying just first one will result in runtime problems, while applying 
just second one will result in missing NULL checks on allocation.

On 8/12/2024 11:53 AM, Thorsten Leemhuis wrote:
> Hi, top-posting for once, to make this easily accessible to everyone.
> 
> Greg, Sasha, to me it looks like something fell through the cracks.
> Pierre-Louis afaics about a week ago asked (see the quote below) to
> revert 97ab304ecd95c0 ("ASoC: topology: Fix references to freed memory")
> [v6.10-rc6, v6.9.11, v6.6.42, v6.1.101] from the stable branches *or*
> pick up b9dd212b14d27a ("ASoC: topology: Fix route memory corruption").
> But nothing like that has happened yet and I can't see any of those
> resolutions in the 6.6 queue.
> 
> Side note: I have a very strong feeling that I'm missing or
> misunderstood something, but I decided to send this mail despite this...
> If something like that was the case: apologies in advance.
> 
> Ciao, Thorsten
> 
> On 05.08.24 19:09, Pierre-Louis Bossart wrote:
>> On 8/5/24 18:17, Vitaly Chikunov wrote:
>>> Sasha, Greg,
>>>
>>> On Tue, Jul 09, 2024 at 12:18:57PM GMT, Sasha Levin wrote:
>>>> From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>>>>
>>>> [ Upstream commit 0298f51652be47b79780833e0b63194e1231fa34 ]
>>>>
>>>> It was reported that recent fix for memory corruption during topology
>>>> load, causes corruption in other cases. Instead of being overeager with
>>>> checking topology, assume that it is properly formatted and just
>>>> duplicate strings.
>>>
>>> Can this backport actually be applied to the 6.9/6.6/6.1 stable branches?
>>>
>>> I have multiple bug reports about sound not working and memory
>>> corruption on some laptops (for example ICL RAYbook Si1516). See for
>>> example bug reports[1][2], and the fix discussion [3].
>>>
>>> dmesg messages from Lenovo ThinkBook 13 gen 1:
>>>
>>>
>>>    [ 3.555191] sof-audio-pci-intel-cnl 0000:00:1f.3: Firmware info: version 2:2:0-57864
>>>    [ 3.555206] sof-audio-pci-intel-cnl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
>>>    [ 3.574043] sof-audio-pci-intel-cnl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:0
>>>    [ 3.575180] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sink MIXER1.0> not found
>>>    [ 3.575772] sof-audio-pci-intel-cnl 0000:00:1f.3: error: tplg component load failed -22
>>>    [ 3.575793] sof-audio-pci-intel-cnl 0000:00:1f.3: error: failed to load DSP topology -22
>>>    [ 3.575801] sof-audio-pci-intel-cnl 0000:00:1f.3: ASoC: error at snd_soc_component_probe on 0000:00:1f.3: -22
>>>
>>> Error messages from other boots showing memory corruption:
>>>
>>>    [ 3.904397] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sink PCM0C03-std-def-alt0.p11@jh\x86Ŝ\xff\xff@\xc8\xff\x82Ŝ\xff\xff`P\x82\xbb\xff\xff\xff\xff\x94$A\xbc\xff\xff\xff\xff\x06 not found
>>>    [ 3.966777] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sink PGA1.0\x01 not found
>>>    [ 3.899748] sof-audio-pci-intel-cnl 0000:00:1f.3: error: source BUF2.0 not found
>>>    [ 3.975359] sof-audio-pci-intel-cnl 0000:00:1f.3: error: source PCM0P\x01pcsc-lite.conf not found
>>>    [ 7.275851] sof-audio-pci-intel-tgl 0000:00:1f.3: error: source HDA1.IN/0123456789:;<=>? not found
>>>
>>> [1] https://github.com/thesofproject/sof/issues/9339
>>> [2] https://github.com/thesofproject/sof/issues/9341
>>> [3] https://lore.kernel.org/linux-sound/171812236450.201359.3019210915105428447.b4-ty@kernel.org/T/#m8c4bd5abf453960fde6f826c4b7f84881da63e9d
>>
>> Agree, the commit "ASoC: topology: Fix references to freed memory"
>> [ Upstream commit 97ab304ecd95c0b1703ff8c8c3956dc6e2afe8e1 ]
>> should not have landed on any -stable branch. It should be reverted or
>> this follow-up fix be applied.
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>> Closes: https://lore.kernel.org/linux-sound/171812236450.201359.3019210915105428447.b4-ty@kernel.org/T/#m8c4bd5abf453960fde6f826c4b7f84881da63e9d
>>>> Suggested-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>>>> Link: https://lore.kernel.org/r/20240613090126.841189-1-amadeuszx.slawinski@linux.intel.com
>>>> Signed-off-by: Mark Brown <broonie@kernel.org>
>>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>> ---
>>>>   sound/soc/soc-topology.c | 12 +++---------
>>>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
>>>> index 52752e0a5dc27..27aba69894b17 100644
>>>> --- a/sound/soc/soc-topology.c
>>>> +++ b/sound/soc/soc-topology.c
>>>> @@ -1052,21 +1052,15 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
>>>>   			break;
>>>>   		}
>>>>   
>>>> -		route->source = devm_kmemdup(tplg->dev, elem->source,
>>>> -					     min(strlen(elem->source), maxlen),
>>>> -					     GFP_KERNEL);
>>>> -		route->sink = devm_kmemdup(tplg->dev, elem->sink,
>>>> -					   min(strlen(elem->sink), maxlen),
>>>> -					   GFP_KERNEL);
>>>> +		route->source = devm_kstrdup(tplg->dev, elem->source, GFP_KERNEL);
>>>> +		route->sink = devm_kstrdup(tplg->dev, elem->sink, GFP_KERNEL);
>>>>   		if (!route->source || !route->sink) {
>>>>   			ret = -ENOMEM;
>>>>   			break;
>>>>   		}
>>>>   
>>>>   		if (strnlen(elem->control, maxlen) != 0) {
>>>> -			route->control = devm_kmemdup(tplg->dev, elem->control,
>>>> -						      min(strlen(elem->control), maxlen),
>>>> -						      GFP_KERNEL);
>>>> +			route->control = devm_kstrdup(tplg->dev, elem->control, GFP_KERNEL);
>>>>   			if (!route->control) {
>>>>   				ret = -ENOMEM;
>>>>   				break;
>>>> -- 
>>>> 2.43.0
>>>>
>>


