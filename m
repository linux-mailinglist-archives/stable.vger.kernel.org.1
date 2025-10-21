Return-Path: <stable+bounces-188831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74821BF8C20
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 22:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 761044E1E28
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017751F463E;
	Tue, 21 Oct 2025 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCkiHoRh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D0350A19
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079551; cv=none; b=mtGQFEt91HFKLVjXw/46FK4O4MnZaW1SEOo7Zd2f1aUz0xsqsYfZZc9TOLqn/Zl6tDqBqgNkkqCYpy8szkU1cyvniqrej5OkcO96A9oXMj5Q6JzLlkP3wDJbnzJtqNEevrGwRDDDxa+CwrRugc5zioaBe4NlFgusEDvwZVsrXKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079551; c=relaxed/simple;
	bh=yCvePnnHsH7OrzMTgDNXckMoBSwDxteI/MvnGdYPSTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LSFw3RalV/oTMqIMTQaZ+MPwe/I95AopaRxScnnurjqmsl5jSU9PASfG2Xj3zKVGAXYVGDRj4gcfuOT1cpUlX7HnUV5gJZcz3fFfbrX8QKaJT0coGu5mGKkoxsMMYKTGuFzns6kx5GaPDKOCU4428Qos5jnMZQSq9TZ0R1y7aZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCkiHoRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25B5C4CEF1;
	Tue, 21 Oct 2025 20:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761079551;
	bh=yCvePnnHsH7OrzMTgDNXckMoBSwDxteI/MvnGdYPSTU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=XCkiHoRhG8vWAHI/1GruZzL7PQ5PxrzbVqEJfFtv15/GjIpRgA+V5eAJ1Y4ui+iWY
	 HvCTvhQcrhiXJKkNKSgFFf0HUc+ElrxBZnECvQKiv5NwV1SgRAgxIE11iFsU3BllBA
	 SPFDURH0Ur77WuqMDWK/BaULLBdqgOgPWfcAontkDnft/Z34wfMOXtivppq/SoVahy
	 qU70NP4qGNsGGCJOXWsU7ieS/fb5bFwbDF38Dib2Z6ciH6TxqRgzEGgHFm4ZHiuPLA
	 1tfhvzQyERNhKkacfxwx+RlMKMYVlD8rfGCPY30fC+3Mc4SlP5jWYhxmnixMwLzwR8
	 lrDahRX3e4Ztg==
Message-ID: <8c4d1326-512c-4b98-bac0-aa207b54aa2a@kernel.org>
Date: Tue, 21 Oct 2025 15:45:49 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "PM: hibernate: Add pm_hibernation_mode_is_suspend()" has
 been added to the 6.17-stable tree
To: Pascal Ernster <git@hardfalcon.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
References: <2025102032-crescent-acuteness-5060 () gregkh>
 <2745b827-b831-4964-8fc5-368f7446d73e@hardfalcon.net>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <2745b827-b831-4964-8fc5-368f7446d73e@hardfalcon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/21/2025 3:43 PM, Pascal Ernster wrote:
> [2025-10-20 10:36] gregkh linuxfoundation ! org:
>> This is a note to let you know that I've just added the patch titled
>>
>>      PM: hibernate: Add pm_hibernation_mode_is_suspend()
>>
>> to the 6.17-stable tree which can be found at:
>>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>       pm-hibernate-add-pm_hibernation_mode_is_suspend.patch
>> and it can be found in the queue-6.17 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>  From stable+bounces-187839-greg=kroah.com@vger.kernel.org Sat Oct 18 15:51:25 2025
>> From: Sasha Levin <sashal@kernel.org>
>> Date: Sat, 18 Oct 2025 09:51:01 -0400
>> Subject: PM: hibernate: Add pm_hibernation_mode_is_suspend()
>> To: stable@vger.kernel.org
>> Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>, Ionut Nechita <ionut_n2001@yahoo.com>, Kenneth Crudup <kenny@panix.com>, Alex Deucher <alexander.deucher@amd.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Sasha Levin <sashal@kernel.org>
>> Message-ID: <20251018135102.711457-1-sashal@kernel.org>
>>
>> From: "Mario Limonciello (AMD)" <superm1@kernel.org>
>>
>> [ Upstream commit 495c8d35035edb66e3284113bef01f3b1b843832 ]
>>
>> Some drivers have different flows for hibernation and suspend. If
>> the driver opportunistically will skip thaw() then it needs a hint
>> to know what is happening after the hibernate.
>>
>> Introduce a new symbol pm_hibernation_mode_is_suspend() that drivers
>> can call to determine if suspending the system for this purpose.
>>
>> Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
>> Tested-by: Kenneth Crudup <kenny@panix.com>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Stable-dep-of: 0a6e9e098fcc ("drm/amd: Fix hybrid sleep")
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>   include/linux/suspend.h  |    2 ++
>>   kernel/power/hibernate.c |   11 +++++++++++
>>   2 files changed, 13 insertions(+)
>>
>> --- a/include/linux/suspend.h
>> +++ b/include/linux/suspend.h
>> @@ -276,6 +276,7 @@ extern void arch_suspend_enable_irqs(voi
>>   
>>   extern int pm_suspend(suspend_state_t state);
>>   extern bool sync_on_suspend_enabled;
>> +bool pm_hibernation_mode_is_suspend(void);
>>   #else /* !CONFIG_SUSPEND */
>>   #define suspend_valid_only_mem	NULL
>>   
>> @@ -288,6 +289,7 @@ static inline bool pm_suspend_via_firmwa
>>   static inline bool pm_resume_via_firmware(void) { return false; }
>>   static inline bool pm_suspend_no_platform(void) { return false; }
>>   static inline bool pm_suspend_default_s2idle(void) { return false; }
>> +static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
>>   
>>   static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
>>   static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -80,6 +80,17 @@ static const struct platform_hibernation
>>   
>>   static atomic_t hibernate_atomic = ATOMIC_INIT(1);
>>   
>> +#ifdef CONFIG_SUSPEND
>> +/**
>> + * pm_hibernation_mode_is_suspend - Check if hibernation has been set to suspend
>> + */
>> +bool pm_hibernation_mode_is_suspend(void)
>> +{
>> +	return hibernation_mode == HIBERNATION_SUSPEND;
>> +}
>> +EXPORT_SYMBOL_GPL(pm_hibernation_mode_is_suspend);
>> +#endif
>> +
>>   bool hibernate_acquire(void)
>>   {
>>   	return atomic_add_unless(&hibernate_atomic, -1, 0);
>>
>>
>> Patches currently in stable-queue which might be from sashal@kernel.org are
>>
>> queue-6.17/drm-amd-fix-hybrid-sleep.patch
>> queue-6.17/usb-gadget-introduce-free_usb_request-helper.patch
>> queue-6.17/pm-hibernate-add-pm_hibernation_mode_is_suspend.patch
>> queue-6.17/usb-gadget-store-endpoint-pointer-in-usb_request.patch
>> queue-6.17/media-nxp-imx8-isi-m2m-fix-streaming-cleanup-on-release.patch
>> queue-6.17/usb-gadget-f_rndis-refactor-bind-path-to-use-__free.patch
> 
> 
> Hi,
> 
> 
> I kept getting "ERROR: modpost: "pm_hibernation_mode_is_suspend" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!" when trying to build a 6.17.4 kernel with all the patches from queue-6.17 applied on top (from the stable-queue git repo at commit id 6aceec507fd0d3cefa7cac227eaf897edf09bf32). That build-time error is gone and the resulting kernel boots/runs fine on various x86_64 machines and VMs since I've removed/omitted both this patch and queue-6.17/drm-amd-fix-hybrid-sleep.patch.
> 
> I'm not sure if omitting queue-6.17/drm-amd-fix-hybrid-sleep.patch would have been sufficient, but both patches are part of the same patch set anyway.
> 
> Sadly, I haven't been able to figure out what about the changes actually causes the issue. My first guess was that if CONFIG_SUSPEND is not selected/enabled, then the whole pm_hibernation_mode_is_suspend() function and the corresponding export symbol would be missing. However, the kernel that I was trying to build *does* have CONFIG_SUSPEND=y in its config, so this shouldn't be the cause…
> 
> 
> Regards
> Pascal

Are you cleaning your tree between builds?

