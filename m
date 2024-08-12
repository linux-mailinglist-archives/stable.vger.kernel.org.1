Return-Path: <stable+bounces-66434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073CC94EA4F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FD51F2247E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 09:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001A316E87C;
	Mon, 12 Aug 2024 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Kv7cL/Sc"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF8A16DEDF;
	Mon, 12 Aug 2024 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456404; cv=none; b=K5uNuB5T93W9R/THKh89zxrIJI6PaV5Z3XFIdpr2zE4mERyYxQpGssz097j3PwEX3Bt7JGOEqScBYZ+EqI9pknEn//YMYtzad7mJYESSeyczXbhnzQnNnvex2m/RXV+wuFv5Zh50ELqQt+nVphHNQWWsoEUUBI0AWcnt5VwvJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456404; c=relaxed/simple;
	bh=ZTIK9p1LZSXettsRRTxYj2K5vgDymhfTgQ4CCuduHPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NO3KlQzgZ5iYidMVommurMTqh2WQaygvG1qQxXt8i7SlzHkJ0tZZdYNlm3i85BU24m7z2BTKUIjUw+ibgKQ6m8v+k9gLCwPp0FM8Ol0RSROjFvrRAQNDl4plDA9KZ73n+rDJh12XtiYc47+8iq0cgOvH0UlSPHA8M/9RVQwFZHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Kv7cL/Sc; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=kQSeuyy/syznTgBKr11NB5llJx+aGsX2WTrimtcmwWo=; t=1723456402;
	x=1723888402; b=Kv7cL/ScB6tS39L4YKtU5oTIg4ztxd9wCWZZdD6H9Xxjr+8HgYiUsDj1k4/rd
	jQ1U9qgUb1wFBwAYAFT+PgRkoZogHakFWoEFQvJFGDetPmYQt3J6tsol8efZwoO9T45hDmMu9EgjA
	M9fkWvmzd9XjW7iEdtPv1FblvXkUHcmsamjRfVO6IC9JLCzUM/gWkqCHvQlU6GSXJyM/Um2Bh+NjS
	2r+7HeSjECjq2hRTtd7IJSo9t1LZoCYBL/tDu8dKhBd2y0n4XForIg0FxfxRLoNf8bKSIhMTvSjdQ
	yTSXUJuyM9FThyfaVFmObNtSVTTKlM9CS86OBklZ2WV9aDEGXA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sdRjq-0003eb-LX; Mon, 12 Aug 2024 11:53:18 +0200
Message-ID: <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>
Date: Mon, 12 Aug 2024 11:53:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.9 17/40] ASoC: topology: Fix route memory
 corruption
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, linux-sound@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Vitaly Chikunov <vt@altlinux.org>, stable@vger.kernel.org
References: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
 <14e54a89-5c62-41b2-8205-d69ddf75e7c7@linux.intel.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <14e54a89-5c62-41b2-8205-d69ddf75e7c7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1723456402;bac64d84;
X-HE-SMSGID: 1sdRjq-0003eb-LX

Hi, top-posting for once, to make this easily accessible to everyone.

Greg, Sasha, to me it looks like something fell through the cracks.
Pierre-Louis afaics about a week ago asked (see the quote below) to
revert 97ab304ecd95c0 ("ASoC: topology: Fix references to freed memory")
[v6.10-rc6, v6.9.11, v6.6.42, v6.1.101] from the stable branches *or*
pick up b9dd212b14d27a ("ASoC: topology: Fix route memory corruption").
But nothing like that has happened yet and I can't see any of those
resolutions in the 6.6 queue.

Side note: I have a very strong feeling that I'm missing or
misunderstood something, but I decided to send this mail despite this...
If something like that was the case: apologies in advance.

Ciao, Thorsten

On 05.08.24 19:09, Pierre-Louis Bossart wrote:
> On 8/5/24 18:17, Vitaly Chikunov wrote:
>> Sasha, Greg,
>>
>> On Tue, Jul 09, 2024 at 12:18:57PM GMT, Sasha Levin wrote:
>>> From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>>>
>>> [ Upstream commit 0298f51652be47b79780833e0b63194e1231fa34 ]
>>>
>>> It was reported that recent fix for memory corruption during topology
>>> load, causes corruption in other cases. Instead of being overeager with
>>> checking topology, assume that it is properly formatted and just
>>> duplicate strings.
>>
>> Can this backport actually be applied to the 6.9/6.6/6.1 stable branches?
>>
>> I have multiple bug reports about sound not working and memory
>> corruption on some laptops (for example ICL RAYbook Si1516). See for
>> example bug reports[1][2], and the fix discussion [3].
>>
>> dmesg messages from Lenovo ThinkBook 13 gen 1:
>>
>>
>>   [ 3.555191] sof-audio-pci-intel-cnl 0000:00:1f.3: Firmware info: version 2:2:0-57864
>>   [ 3.555206] sof-audio-pci-intel-cnl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
>>   [ 3.574043] sof-audio-pci-intel-cnl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:0
>>   [ 3.575180] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sink MIXER1.0> not found
>>   [ 3.575772] sof-audio-pci-intel-cnl 0000:00:1f.3: error: tplg component load failed -22
>>   [ 3.575793] sof-audio-pci-intel-cnl 0000:00:1f.3: error: failed to load DSP topology -22
>>   [ 3.575801] sof-audio-pci-intel-cnl 0000:00:1f.3: ASoC: error at snd_soc_component_probe on 0000:00:1f.3: -22
>>
>> Error messages from other boots showing memory corruption:
>>
>>   [ 3.904397] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sink PCM0C03-std-def-alt0.p11@jh\x86Ŝ\xff\xff@\xc8\xff\x82Ŝ\xff\xff`P\x82\xbb\xff\xff\xff\xff\x94$A\xbc\xff\xff\xff\xff\x06 not found
>>   [ 3.966777] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sink PGA1.0\x01 not found
>>   [ 3.899748] sof-audio-pci-intel-cnl 0000:00:1f.3: error: source BUF2.0 not found
>>   [ 3.975359] sof-audio-pci-intel-cnl 0000:00:1f.3: error: source PCM0P\x01pcsc-lite.conf not found
>>   [ 7.275851] sof-audio-pci-intel-tgl 0000:00:1f.3: error: source HDA1.IN/0123456789:;<=>? not found
>>
>> [1] https://github.com/thesofproject/sof/issues/9339
>> [2] https://github.com/thesofproject/sof/issues/9341
>> [3] https://lore.kernel.org/linux-sound/171812236450.201359.3019210915105428447.b4-ty@kernel.org/T/#m8c4bd5abf453960fde6f826c4b7f84881da63e9d
> 
> Agree, the commit "ASoC: topology: Fix references to freed memory"
> [ Upstream commit 97ab304ecd95c0b1703ff8c8c3956dc6e2afe8e1 ]
> should not have landed on any -stable branch. It should be reverted or
> this follow-up fix be applied.
> 
>>
>> Thanks,
>>
>>>
>>> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>> Closes: https://lore.kernel.org/linux-sound/171812236450.201359.3019210915105428447.b4-ty@kernel.org/T/#m8c4bd5abf453960fde6f826c4b7f84881da63e9d
>>> Suggested-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>>> Link: https://lore.kernel.org/r/20240613090126.841189-1-amadeuszx.slawinski@linux.intel.com
>>> Signed-off-by: Mark Brown <broonie@kernel.org>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>> ---
>>>  sound/soc/soc-topology.c | 12 +++---------
>>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
>>> index 52752e0a5dc27..27aba69894b17 100644
>>> --- a/sound/soc/soc-topology.c
>>> +++ b/sound/soc/soc-topology.c
>>> @@ -1052,21 +1052,15 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
>>>  			break;
>>>  		}
>>>  
>>> -		route->source = devm_kmemdup(tplg->dev, elem->source,
>>> -					     min(strlen(elem->source), maxlen),
>>> -					     GFP_KERNEL);
>>> -		route->sink = devm_kmemdup(tplg->dev, elem->sink,
>>> -					   min(strlen(elem->sink), maxlen),
>>> -					   GFP_KERNEL);
>>> +		route->source = devm_kstrdup(tplg->dev, elem->source, GFP_KERNEL);
>>> +		route->sink = devm_kstrdup(tplg->dev, elem->sink, GFP_KERNEL);
>>>  		if (!route->source || !route->sink) {
>>>  			ret = -ENOMEM;
>>>  			break;
>>>  		}
>>>  
>>>  		if (strnlen(elem->control, maxlen) != 0) {
>>> -			route->control = devm_kmemdup(tplg->dev, elem->control,
>>> -						      min(strlen(elem->control), maxlen),
>>> -						      GFP_KERNEL);
>>> +			route->control = devm_kstrdup(tplg->dev, elem->control, GFP_KERNEL);
>>>  			if (!route->control) {
>>>  				ret = -ENOMEM;
>>>  				break;
>>> -- 
>>> 2.43.0
>>>
> 

