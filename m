Return-Path: <stable+bounces-160318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D80AFA5FB
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 16:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B49F17C34B
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B2F2857F7;
	Sun,  6 Jul 2025 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkzQ907W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5501172A;
	Sun,  6 Jul 2025 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751813216; cv=none; b=s5Rbcp8JTeg0wiwoxPJ5UW7B7hG7XvxIQIZ7aXD5nLjXHdwPM12tA3HriajHodOklR7JgHH1WQo77oWFkw47WQnO8O0Bf35i6Bv5iUmtEt6OI/2EmG67MfZJ1oig7PQzAvrjftXSgnMrJNly10JeeMFAs239qbnNG4uYdroYXnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751813216; c=relaxed/simple;
	bh=emjIfMnw11DUF6YcJcMlbg6nSmu2TH0D8xuysAMqiH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdSuv2WRUQYhUBkiUC8PEeYC/CJXc/ZZP+uo2Q5iQXFdItFVOjHmw/jIx/46suJWGrYiAIjmtt5RR+jvggEkH8BpzkMHQxMzT2vG7hh3T2fFPVixDX7loZ1UwZt6NCbntxpl1x+99QdLSlUu6hJg6FmaMeAgeNuwgHBgTXY59rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkzQ907W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F84C4CEED;
	Sun,  6 Jul 2025 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751813216;
	bh=emjIfMnw11DUF6YcJcMlbg6nSmu2TH0D8xuysAMqiH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pkzQ907WOvrPMsBQog46+S1c5Fuuq1vcSeZuqY3q/rut2ieVzI54Tzp60In9Re0Vk
	 llaMNBvcheEXXbvUNz3WlsZIxayHnPngXaLBUqyjzLK3EaG+OmzjElmMvOr1cf3vxD
	 +YlAhFPql0g4WNLtz1zIcOd1C+E8XFivdcpD64aI46OdGexmsQqy3QjV+AXToBuIRX
	 MXmVwAvxO0wI/qpCQWKefZlCOeOolqiTPeuAAUd3Evnp56zNR8/Fe/c+zKyrN3oVYm
	 Ym6Rw4r1hCLLgEeG4JNJT43kJiW1GSSIRSomuFHkk6TO459TW5+ifoeU8WQItOHb8k
	 5f1qfsDOrl7/w==
Message-ID: <51d5393c-d0e1-4f35-bed0-16c7ce40a8a8@kernel.org>
Date: Sun, 6 Jul 2025 10:46:53 -0400
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
 <87v7odo46s.fsf@alyssa.is>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <87v7odo46s.fsf@alyssa.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/30/25 07:32, Alyssa Ross wrote:
> Alyssa Ross <hi@alyssa.is> writes:
> 
>> On Fri, Apr 11, 2025 at 10:14:44AM -0500, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> commit a5cfc9d65879c ("thunderbolt: Add wake on connect/disconnect
>>> on USB4 ports") introduced a sysfs file to control wake up policy
>>> for a given USB4 port that defaulted to disabled.
>>>
>>> However when testing commit 4bfeea6ec1c02 ("thunderbolt: Use wake
>>> on connect and disconnect over suspend") I found that it was working
>>> even without making changes to the power/wakeup file (which defaults
>>> to disabled). This is because of a logic error doing a bitwise or
>>> of the wake-on-connect flag with device_may_wakeup() which should
>>> have been a logical AND.
>>>
>>> Adjust the logic so that policy is only applied when wakeup is
>>> actually enabled.
>>>
>>> Fixes: a5cfc9d65879c ("thunderbolt: Add wake on connect/disconnect on USB4 ports")
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Hi! There have been a couple of reports of a Thunderbolt regression in
>> recent stable kernels, and one reporter has now bisected it to this
>> change:
>>
>>   • https://bugzilla.kernel.org/show_bug.cgi?id=220284
>>   • https://github.com/NixOS/nixpkgs/issues/420730
>>
>> Both reporters are CCed, and say it starts working after the module is
>> reloaded.
>>
>> Link: https://lore.kernel.org/r/bug-220284-208809@https.bugzilla.kernel.org%2F/
>> (for regzbot)
> 
> Apparently[1] fixed by the first linked patch below, which is currently in
> the Thunderbolt tree waiting to be pulled into the USB tree.
> 
> #regzbot monitor: https://lore.kernel.org/linux-usb/20250619213840.2388646-1-superm1@kernel.org/
> #regzbot monitor: https://lore.kernel.org/linux-usb/20250626154009.GK2824380@black.fi.intel.com/
> 
> [1]: https://github.com/NixOS/nixpkgs/issues/420730#issuecomment-3018563631

Hey Greg,

Can you pick up the pull request from Mika from a week and a half ago 
with this fix for the next 6.16-rc?

https://lore.kernel.org/linux-usb/20250626154009.GK2824380@black.fi.intel.com/

Thanks,

