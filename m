Return-Path: <stable+bounces-67665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E588951CDD
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 16:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B438B2801D
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE831B32A1;
	Wed, 14 Aug 2024 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnbPawRw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9101B32D2;
	Wed, 14 Aug 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645154; cv=none; b=O8rn5x7mJ/NdzT+G3zU6eCbqc8NiJUz+xalutsJIcxdImRHNLWyv0Ob1x8XafOcsjSFjzgo29OA6wB1KwzRORC5uNuhlNbbBY7N5v9pB0EwYcQZl9OkP0aEQXo1168OLIYHluzPn/fo+DgFoVkTOhhDN57/8H+uZ2snrTeFUvug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645154; c=relaxed/simple;
	bh=04e9o2Fx4Kod3F3iY7QMBHw4y2QRFo52lhWrhiGAmm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mkxYlQQi4gB0qzwoVWZ4nSk0kAr6DhSeJtYWr8AXfNkVSXh5PSnTmKdrogHsYAiXy9mpWwcJD8UDbdI/D+qToYionee00HIDJkL+XknV9GQGqtH95FMInYbJLcYjeNjp+dX1KxCeK0W3FBu265SfU5s/5/YSP87uCBH+wchtTNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnbPawRw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723645152; x=1755181152;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=04e9o2Fx4Kod3F3iY7QMBHw4y2QRFo52lhWrhiGAmm0=;
  b=dnbPawRw8y/qXDHmxi5gOGAutLnupLToirTTKCM4eFl6BWqXIb5AAELt
   Zx1qrxRZKxLx5/tg8tKGjCDPWUjHdpJEaSIqfFwlzeuwId0Vu5sFEgGwB
   PcuWVKL8L9He5diAVFWvALnLI4rz7i5+PJIUjmkAk4dJccLTuaPHvAFkT
   OHcN8Mnkqq9WS8dEaHOWYtMUF61dpjdZxNbynJBEC4sXqJ0JMjirR8htp
   QIkl4GRgPDNQsjxvHw+q/DSUUw2j8M0RZb7z0/BP8nvLsxig+/wRG7Ns7
   nP5E5SG1eQfzA73+6tz+jPv1LpLdfefAobGeayFVv+CBZOZSUYNlRFuZq
   w==;
X-CSE-ConnectionGUID: nBcvOATIRWSonwKFH4JL+Q==
X-CSE-MsgGUID: N++A9fgxQgGdCEcQV9bxvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21420190"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="21420190"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 07:19:12 -0700
X-CSE-ConnectionGUID: e1UdUu7gSzO3P35vee5F/A==
X-CSE-MsgGUID: i3M92WHmRY2CcWm8Xy/gMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="82256535"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 07:19:08 -0700
Message-ID: <351cb9f0-c016-43d2-a1f4-6635503aed56@linux.intel.com>
Date: Wed, 14 Aug 2024 16:19:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for stable 0/2] ASoC: topology: Fix loading topology issue
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>, tiwai@suse.com,
 perex@perex.cz, lgirdwood@gmail.com,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Vitaly Chikunov <vt@altlinux.org>, Mark Brown <broonie@kernel.org>
References: <20240814140657.2369433-1-amadeuszx.slawinski@linux.intel.com>
 <2024081434-drowsily-stingy-1b09@gregkh>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <2024081434-drowsily-stingy-1b09@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/14/2024 4:12 PM, Greg Kroah-Hartman wrote:
> On Wed, Aug 14, 2024 at 04:06:55PM +0200, Amadeusz Sławiński wrote:
>> Commit 97ab304ecd95 ("ASoC: topology: Fix references to freed memory")
>> is a problematic fix for issue in topology loading code, which was
>> cherry-picked to stable. It was later corrected in
>> 0298f51652be ("ASoC: topology: Fix route memory corruption"), however to
>> apply cleanly e0e7bc2cbee9 ("ASoC: topology: Clean up route loading")
>> also needs to be applied.
>>
>> Link: https://lore.kernel.org/linux-sound/ZrwUCnrtKQ61LWFS@sashalap/T/#mbfd273adf86fe93b208721f1437d36e5d2a9aa19
>>
>> Amadeusz Sławiński (2):
>>    ASoC: topology: Clean up route loading
>>    ASoC: topology: Fix route memory corruption
>>
>>   sound/soc/soc-topology.c | 32 ++++++++------------------------
>>   1 file changed, 8 insertions(+), 24 deletions(-)
>>
>>
>> base-commit: 878fbff41def4649a2884e9d33bb423f5a7726b0
>> -- 
>> 2.34.1
>>
>>
> 
> What stable tree(s) is this for?

For whichever one has 97ab304ecd95 ("ASoC: topology: Fix references to 
freed memory") applied and doesn't have following patches, as far as I 
can tell:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/sound?h=v6.9.12
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/sound/soc?h=v6.6.46
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/sound/soc?h=v6.1.105

should I send separate mail for each?


