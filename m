Return-Path: <stable+bounces-67659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33829951C9F
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 16:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D054A1F22473
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497921B29D7;
	Wed, 14 Aug 2024 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJSV+psT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF81B1511;
	Wed, 14 Aug 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644483; cv=none; b=i8w8mgtZTpAoqmwdnalrS9ugBe3pCPvfNHXBtY+xmj4hT9FSh4PBxrMYpnTCduQh5Vk4dU1iiX4sGo9+ri2uULEIoBi2+GLM5FMo8N9pNoQCwsgTbeJO5jjEkzJwJdfrsubuVBe2UXUjzIJp45kEDToI1qJm9SpRUxuo1pcXygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644483; c=relaxed/simple;
	bh=UXD7Yz5uxT3M095WHjvjkFG6zafPrLrj0PbfzPxqi1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpRdNvQEtVNT9FimfoNGHvzWvsYPuG3ehVDsKuaSo1Jj8MGyqF6V1waCP5ICyI/mCmGpc9szI+xboFcuY9KTf3aXuqUvs773jstOz/eyWBAGeGTHd6vqN0yMlszMp6Cu+NL6RS+Ebhe4hhL7fUScJJTU4Hx6UGXyMgDPsiTClto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJSV+psT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723644482; x=1755180482;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UXD7Yz5uxT3M095WHjvjkFG6zafPrLrj0PbfzPxqi1M=;
  b=bJSV+psTtYBomZL+6awS78DwGNPAQLrde534Jund3HPESvLrlux9Qsar
   f4spYpZGcPQFKSqypZYOwoQQx4F5tkwKEebzfGo2HksySAFjtAeXR5QVN
   Bu2PxrLhMnL+TMiQmw0NApbkhwHbf37UGTbu9qMl2pDoh/Xyv/6G2iCjN
   AyJ3i45VU9ngFdHqI+tdipCyploiqXe/r1rG8WPiZM05Y2EusUvEvCD8v
   x3trdCvMFjwDWifK1vfGgopJh3G+oNOQ0EAC11t6iR4IvR+crJG3MlS6K
   S+1tU0X983+GmZ5uNIGm9UQrSp1DHbNdK9MJ+xvoYFNeKxgnrBURxVsJZ
   Q==;
X-CSE-ConnectionGUID: w6fTmK4dSYaZKn9jJYr4kA==
X-CSE-MsgGUID: dZS675R0Qy6bVqmZHrsIjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33270338"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="33270338"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 07:08:01 -0700
X-CSE-ConnectionGUID: J+nroZkKTMKZPQmgrrvMaQ==
X-CSE-MsgGUID: 7BKcIl+6Tv+ml9wfo0Tz+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="58709885"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 07:07:57 -0700
Message-ID: <1ea93e69-80da-4dc3-b63c-217b1f9f0447@linux.intel.com>
Date: Wed, 14 Aug 2024 16:07:55 +0200
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
To: Mark Brown <broonie@kernel.org>, Vitaly Chikunov <vt@altlinux.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 linux-sound@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
 <14e54a89-5c62-41b2-8205-d69ddf75e7c7@linux.intel.com>
 <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>
 <210a825d-ace3-4873-ba72-2c15347f9812@linux.intel.com>
 <2024081225-finally-grandma-011d@gregkh>
 <20240812103842.p7mcx7iyb5oyj7ly@altlinux.org>
 <2024081227-wrangle-overlabor-cf31@gregkh>
 <53ab1511-b79c-4378-b2b5-ea9e19e8f65b@linux.intel.com>
 <20240814000053.posrfbgoic2yzpsk@altlinux.org>
 <e7b0597c-72d8-4cb6-bcec-19e29c1b864e@sirena.org.uk>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <e7b0597c-72d8-4cb6-bcec-19e29c1b864e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/14/2024 12:33 PM, Mark Brown wrote:
> On Wed, Aug 14, 2024 at 03:00:53AM +0300, Vitaly Chikunov wrote:
>> On Tue, Aug 13, 2024 at 04:42:04PM +0200, Amadeusz Sławiński wrote:
> 
>>> Should this be cherry-pick of both (they should apply cleanly):
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=e0e7bc2cbee93778c4ad7d9a792d425ffb5af6f7
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=0298f51652be47b79780833e0b63194e1231fa34
>>> or just the second one adjusted to apply for stable trees?
> 
>> I think having commit with memory corruption fix is more important to
>> stable kernels than not having the code cleanup commit. So, I would
>> suggest stable policy to be changed a bit, and minor commits like this
>> code cleanup, be allowed in stable if they are dependence of bug fixing
>> commits.
> 
>> Additionally, these neutral commits just make stable trees become closer
>> to mainline trees (which allows more bug fix commits to be applied
>> cleanly).
> 
> The reason I nacked the cleanup commit was just that there was no
> indication that it was a dependency or anything, it just looked like
> standard stuff with not reviewing bot output.

I've send both patches for stable in 
https://lore.kernel.org/linux-sound/20240814140657.2369433-1-amadeuszx.slawinski@linux.intel.com/T/#t

