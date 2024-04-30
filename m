Return-Path: <stable+bounces-42825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C658B7F67
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 20:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9D3285532
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 18:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F34181328;
	Tue, 30 Apr 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rHVYOcgP"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B79175560
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500311; cv=none; b=JS34yX8BQSbdGhzicDNm2vQK+PJXaW95TZuR1yBc6sUx44XcHem/8612XfJw73ggLRgR3LuV/OSndr/BsUXPF0SX9JL0yTDicCh/zGszkvX7hTD8Uul7CycJs4QbYAEZhPnK2M5ASNSZeO0hPwZjxzCVqee0Yr8NM/iIvq4egOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500311; c=relaxed/simple;
	bh=M53z728+dCewei6ejN+fmLv/x5FO9DLaWreT856fL2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHfTF7VlnC+i4D9H7e6VkMDq9ggg0jobiJI00t44beUghqWjQlOZsL6dDEtatU8JN6lctaT534lF0ydAd/kAcJqFz7Hv6shnlV1UFiuCEleecyQ3LIfa9vETsLs2yPUcWNflNKYPEMMlbZM1ZOQXzDAvmLbOBFYE+8jtH7x1lY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rHVYOcgP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.32.120] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 438D1210FBDF;
	Tue, 30 Apr 2024 11:05:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 438D1210FBDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714500309;
	bh=RBmODfw55/HU7MmeK3F4V3ZTJv8UwVJIHwsZ65Ttsqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rHVYOcgPLEgCmJ2hOD7EU2h3Iket1KAxk8OsfAr2A+vXiLhGA81diXqMf9t6Q03oY
	 HPsgzdc6hKcuxMWhD2Eyf/yz8g+VjR6/bZHE+BxK/2D4In4pUgbhfHsrx8PmL94BZI
	 DzZ4l1FHVYNFXL5bymzEU5kdODhxHm0l1I6bWPPg=
Message-ID: <3693107b-054d-485a-9e1c-c23c683db590@linux.microsoft.com>
Date: Tue, 30 Apr 2024 11:05:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] ACPI: CPPC: Fix access width used for PCC
 registers" failed to apply to 5.15-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: vanshikonda@os.amperecomputing.com, jarredwhite@linux.microsoft.com,
 rafael.j.wysocki@intel.com, stable@vger.kernel.org
References: <2024042905-puppy-heritage-e422@gregkh>
 <24df5fe0-9e1a-4929-b132-3654ec9d8bf3@linux.microsoft.com>
 <2024043016-overhung-oaf-8201@gregkh>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <2024043016-overhung-oaf-8201@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/2024 10:41 AM, Greg KH wrote:
> On Tue, Apr 30, 2024 at 09:05:28AM -0700, Easwar Hariharan wrote:
>> On 4/29/2024 4:53 AM, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 5.15-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x f489c948028b69cea235d9c0de1cc10eeb26a172
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042905-puppy-heritage-e422@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
>>>
>>> Possible dependencies:
>>>
>>> f489c948028b ("ACPI: CPPC: Fix access width used for PCC registers")
>>> 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
>>> 0651ab90e4ad ("ACPI: CPPC: Check _OSC for flexible address space")
>>> c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not supported by firmware")
>>> 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities to the _OSC regardless of the query flag"")
>>> f684b1075128 ("ACPI: CPPC: Drop redundant local variable from cpc_read()")
>>> 5f51c7ce1dc3 ("ACPI: CPPC: Fix up I/O port access in cpc_read()")
>>> a2c8f92bea5f ("ACPI: CPPC: Implement support for SystemIO registers")
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>
>> Hi Greg,
>>
>> Please fix this with the following set of changes in linux-5.15.y.
>>
>> Revert b54c4632946ae42f2b39ed38abd909bbf78cbcc2 from linux-5.15.y
>> Cherry-pick 05d92ee782eeb7b939bdd0189e6efcab9195bf95 from upstream
>> Pick the following backport of f489c948028b69cea235d9c0de1cc10eeb26a172 from upstream
> 
> Please provide a series of patches that I can apply that does this,
> attempting to revert and cherry-pick and then manually hand-edit this
> email and apply it does not scale at all, sorry.
> 
> thanks,
> 
> greg k-h

Sorry about that, I'll send the series right away. I'm not quite sure what Closes: lore link to provide, could you please fix it up?

Thanks,
Easwar

