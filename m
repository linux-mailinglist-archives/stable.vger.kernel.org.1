Return-Path: <stable+bounces-67500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C67950804
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8598B287CB2
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 14:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A0919E822;
	Tue, 13 Aug 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egosHgS9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583DD26AE8;
	Tue, 13 Aug 2024 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560134; cv=none; b=ui5+CNPH/dzHnMUoE8cnPYZCseZSqJhJr1bTzcuTP7Z+mL6t59kz+qlJkmjbmME6cKEAkSW2ocoFHIChzx78CfMv9k0H1Cj+P5dw8KIDx4HuKcullogv1PhoPFFlORbOlfDG7Z89C5Iljc39liffac28vyY0QnlzWf6nw057hzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560134; c=relaxed/simple;
	bh=t/3sn+zJb5soHCGFSsLi8+AAfVQY4IzOjU0MFJj9U0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcULs/UJ9Kpn+BRHwbf3NG6vaNHxWqovEShKeACj2ezS4GPRAks9dgDmfKmQ8XHaS1/F2cunfqOrkHF6IKTyLUkYePYfW5ffPT2qB4wI6KghyU/hi0WV81VraLNFK8vYFxnkU43CJz7A68kFN9saX6Djeq/2j1spJJSrcwvZyVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egosHgS9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723560133; x=1755096133;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t/3sn+zJb5soHCGFSsLi8+AAfVQY4IzOjU0MFJj9U0s=;
  b=egosHgS9cgUnogsT3oDKXkVGZxReD6D+UFjVsooG6zgXBv2j0PLG7U+z
   3LhBSjqtfRcd29E1jzaXAmugQCA2K5s8Pzmx6w4Grspj5mY/G/FAd7hwu
   /Z8Q091fZAWBh+RGK39ax4mKRNnoN6HdGI+gPeU1IKzS1c+O3PtgnNib7
   OM/nXVjSriczjMQKgumXVbNRwGvEHdfggjgGAgSqGzqmAC0efhLi5tDhU
   uL1zPvQxw6BimPFu60DLTcim54lKPAzGGbxZLB0Q5ou2roGNQMV3/4Ko/
   ZQo17kofVC869Juw1f3NIfVHri3XHXOk6IIK9CEFs6RctEV3Evg1wddb/
   A==;
X-CSE-ConnectionGUID: Ovur+fP7Q6OmKDeHqM+QSA==
X-CSE-MsgGUID: WA1Gr4b0S9+yQdP02AAeog==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25518836"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="25518836"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:42:12 -0700
X-CSE-ConnectionGUID: 6ft7ySktRo2/qjTJZk4hFg==
X-CSE-MsgGUID: 5sMOjk9aSR+hZ5XsGoH20w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="63110132"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:42:06 -0700
Message-ID: <53ab1511-b79c-4378-b2b5-ea9e19e8f65b@linux.intel.com>
Date: Tue, 13 Aug 2024 16:42:04 +0200
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vitaly Chikunov <vt@altlinux.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, linux-sound@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 stable@vger.kernel.org
References: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
 <14e54a89-5c62-41b2-8205-d69ddf75e7c7@linux.intel.com>
 <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>
 <210a825d-ace3-4873-ba72-2c15347f9812@linux.intel.com>
 <2024081225-finally-grandma-011d@gregkh>
 <20240812103842.p7mcx7iyb5oyj7ly@altlinux.org>
 <2024081227-wrangle-overlabor-cf31@gregkh>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <2024081227-wrangle-overlabor-cf31@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/12/2024 4:11 PM, Greg Kroah-Hartman wrote:
> On Mon, Aug 12, 2024 at 01:38:42PM +0300, Vitaly Chikunov wrote:
>> Greg,
>>
>> On Mon, Aug 12, 2024 at 12:25:54PM +0200, Greg Kroah-Hartman wrote:
>>> On Mon, Aug 12, 2024 at 12:01:48PM +0200, Amadeusz Sławiński wrote:
>>>> I guess that for completeness you need to apply both patches:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=97ab304ecd95c0b1703ff8c8c3956dc6e2afe8e1
>>>
>>> This is already in the tree.
>>>
>>>> was an incorrect fix which was later fixed by:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=0298f51652be47b79780833e0b63194e1231fa34
>>>
>>> This commit will not apply :(
>>
>> It depends upon e0e7bc2cbee9 ("ASoC: topology: Clean up route loading"),
>> which was in the same patchset that didn't get applied.
>>    
>>    https://lore.kernel.org/stable/?q=ASoC%3A+topology%3A+Clean+up+route+loading
>>
>> I see, Mark Brown said it's not suitable material for stable kernels
>> (since it's code cleanup), and Sasha Levin dropped it, and the dependent
>> commit with real fix.
> 
> Ok, then someone needs to provide a working backport please...
> 

Should this be cherry-pick of both (they should apply cleanly):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=e0e7bc2cbee93778c4ad7d9a792d425ffb5af6f7
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=0298f51652be47b79780833e0b63194e1231fa34
or just the second one adjusted to apply for stable trees?

