Return-Path: <stable+bounces-161871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F060B0458A
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 18:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0094A2918
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 16:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AF32620F1;
	Mon, 14 Jul 2025 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFoc59lB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5892620D5;
	Mon, 14 Jul 2025 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510942; cv=none; b=JhpyJRcUT5MkklL7bzj5OiU19JrDcJrwhqH7gPXor4n970vw0qv0o0n0wNykWpMl4HGyqWuv+LEDkmxpCf59tLY5cpmgBywLwgpKeHx/KyNaQ1kpc762EnJpW7ecovWxE2pVlIGqpHm7QJR3qGcZdGZy6RnWkzxWJpVyWjnFQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510942; c=relaxed/simple;
	bh=HCTIYugXe3ybLmowCq2D9pzqaHhFBDzT2Z0kcsA7nhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHPLnyYO8fdvGgAwMO35O+jnWK7jXbmHA+Dy0jONK3YKnaNN8str5rHlNPycWnAfQ8ZCtS8n42Q0B/73XBc0yCBn1dbi0ZbFAqhfjZEguznlMqfr32Amb9B/zDoVCJb59cJJez64d1wyTxeWfsX31k01tD9is1Tcg/KHiJxvOEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFoc59lB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7FFC4CEED;
	Mon, 14 Jul 2025 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752510941;
	bh=HCTIYugXe3ybLmowCq2D9pzqaHhFBDzT2Z0kcsA7nhI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tFoc59lB7p3DS+EG+cbfcNxThwczpLZw+oWAaDlUE1pnYxwjcDWMipv7X+Hi1jBE2
	 oSzSUphDbDG3DMZXmY3pQpQdopCVp1+ytg0DibEw6Z9nX4ZR3j7A21fTHf/MTPYdPU
	 kT/LGqIeg81vWG1Oxc2qO9HEaY5Ilnyl1RzFi9rB0gHV0MM0abv/tk97UJzGcVMWr4
	 ag7tLS8Z46CCRPPi+L4/u0AnUfxo0LEDQLGVqjL2rU8UgRHJTl8XirLjpnrqhtzy9a
	 gTGHUWD6w039b4I9r6grLoVJycZPPEgTf4fl2SV+5+rMCgRLMQD49AG7MOEYM/kjwz
	 8gfXF4tNL0o7Q==
Message-ID: <bb98ecb6-eb56-44d9-8f80-3172f9e7de03@kernel.org>
Date: Mon, 14 Jul 2025 11:35:39 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] thunderbolt: Fix a logic error in wake on connect
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: mario.limonciello@amd.com, andreas.noever@gmail.com,
 michael.jamet@intel.com, westeri@kernel.org, YehezkelShB@gmail.com,
 rajat.khandelwal@intel.com, mika.westerberg@linux.intel.com,
 linux-usb@vger.kernel.org, kim.lindberger@gmail.com, linux@lunaa.ch,
 Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 Alyssa Ross <hi@alyssa.is>, regressions@lists.linux.dev
References: <20250411151446.4121877-1-superm1@kernel.org>
 <cavyeum32dd7kxj65argtem6xh2575oq3gcv3svd3ubnvdc6cr@6nv7ieimfc5e>
 <87v7odo46s.fsf@alyssa.is> <51d5393c-d0e1-4f35-bed0-16c7ce40a8a8@kernel.org>
 <2025070737-charbroil-imply-7b5e@gregkh>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2025070737-charbroil-imply-7b5e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/7/25 2:57 AM, Greg Kroah-Hartman wrote:
> On Sun, Jul 06, 2025 at 10:46:53AM -0400, Mario Limonciello wrote:
>> On 6/30/25 07:32, Alyssa Ross wrote:
>>> Alyssa Ross <hi@alyssa.is> writes:
>>>
>>>> On Fri, Apr 11, 2025 at 10:14:44AM -0500, Mario Limonciello wrote:
>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> commit a5cfc9d65879c ("thunderbolt: Add wake on connect/disconnect
>>>>> on USB4 ports") introduced a sysfs file to control wake up policy
>>>>> for a given USB4 port that defaulted to disabled.
>>>>>
>>>>> However when testing commit 4bfeea6ec1c02 ("thunderbolt: Use wake
>>>>> on connect and disconnect over suspend") I found that it was working
>>>>> even without making changes to the power/wakeup file (which defaults
>>>>> to disabled). This is because of a logic error doing a bitwise or
>>>>> of the wake-on-connect flag with device_may_wakeup() which should
>>>>> have been a logical AND.
>>>>>
>>>>> Adjust the logic so that policy is only applied when wakeup is
>>>>> actually enabled.
>>>>>
>>>>> Fixes: a5cfc9d65879c ("thunderbolt: Add wake on connect/disconnect on USB4 ports")
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> Hi! There have been a couple of reports of a Thunderbolt regression in
>>>> recent stable kernels, and one reporter has now bisected it to this
>>>> change:
>>>>
>>>>    • https://bugzilla.kernel.org/show_bug.cgi?id=220284
>>>>    • https://github.com/NixOS/nixpkgs/issues/420730
>>>>
>>>> Both reporters are CCed, and say it starts working after the module is
>>>> reloaded.
>>>>
>>>> Link: https://lore.kernel.org/r/bug-220284-208809@https.bugzilla.kernel.org%2F/
>>>> (for regzbot)
>>>
>>> Apparently[1] fixed by the first linked patch below, which is currently in
>>> the Thunderbolt tree waiting to be pulled into the USB tree.
>>>
>>> #regzbot monitor: https://lore.kernel.org/linux-usb/20250619213840.2388646-1-superm1@kernel.org/
>>> #regzbot monitor: https://lore.kernel.org/linux-usb/20250626154009.GK2824380@black.fi.intel.com/
>>>
>>> [1]: https://github.com/NixOS/nixpkgs/issues/420730#issuecomment-3018563631
>>
>> Hey Greg,
>>
>> Can you pick up the pull request from Mika from a week and a half ago with
>> this fix for the next 6.16-rc?
>>
>> https://lore.kernel.org/linux-usb/20250626154009.GK2824380@black.fi.intel.com/
> 
> Yes, I was waiting for this last round to go to Linus as the pull
> request was made against a newer version of Linus's tree than I
> currently had in my "for linus" branch.  I'll go get to that later
> today.
> 
> thanks,
> 
> greg k-h
> 

Greg,

Sorry to be a bugger, but I was surprised I didn't see this come in -rc6 
this week, and I went and double checked your "usb-linus" branch [1] and 
didn't see it there.

Thanks,

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/log/?h=usb-linus

