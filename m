Return-Path: <stable+bounces-155128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 810D9AE1A5A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 13:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11357AD99A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA5E28A1C5;
	Fri, 20 Jun 2025 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="CvQkZyeu"
X-Original-To: stable@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E482264A6E;
	Fri, 20 Jun 2025 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750420556; cv=none; b=gslAttzBSlkiNOHo/mxLK8td+gOInr76JkkwPPihidYVJ5EBQ3KKq+4LSFWW7ner7+0njs7Xn5Ine77dMwX7CRSkcwC9c1P7cqrXW86Wn9BWlLsSikFq5GDNkizjhRXEN247HyRtJtVDx58sgJ3AZqj6nKUhNXgBmIR2cxd/FsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750420556; c=relaxed/simple;
	bh=bz1RmF0ne1dy26kmvs7vVr7cqD7gXbPeDxg9l6yhPDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NewLHke16UY4hMr2D9iO/LEHkx0178qSmYjAvrpeeIAbzdoBmJ+pYghKKP487BzYLeQ6bd2BIRqNsLkTKM4qSC8WEXeljvAoz7W0CMGB2EAL/S6fnhpkMS98rRGi7yeHn9qfOJ/kRvqLi0ajOf73+PSlUZengaiXmTvG852AEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=CvQkZyeu; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.178.76] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 5CE232FC007C;
	Fri, 20 Jun 2025 13:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1750420544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MO78KbUAIvE06t0LdPjySs+xxyAgHTWk9FjQUky7GBg=;
	b=CvQkZyeuOaEMvd4IAB2YeZAFxWcuvq13KUo9ffknB+8+0jFnBoPCc+q6msywkwYcyzUh/M
	LIgrZzIp48VzutnBXUHCP5l0FNMx+6AtlZA1MH3xzMimvS+y8ap0PQ4YFARHEU3zoNy6XB
	W3ARagkHuENBzyL/iu4A6mPzPoJTZW4=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=g.gottleuber@tuxedocomputers.com
Message-ID: <0d86a892-ebfb-40b9-b84c-ad8075905cd8@tuxedocomputers.com>
Date: Fri, 20 Jun 2025 13:55:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amd/display: Radeon 840M/860M: bisected suspend
 crash
To: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>, ggo@tuxedocomputers.com,
 stable@vger.kernel.org, regressions@lists.linux.dev,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: amd-gfx@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Werner Sembach <wse@tuxedocomputers.com>,
 Christoffer Sandberg <cs@tuxedocomputers.com>
References: <fd10cda4-cd9b-487e-b7c6-83c98c9db3f8@tuxedocomputers.com>
 <3002633a-5c9e-4baa-b16a-91fdec994e02@amd.com>
 <3271e5d7-9b2a-4378-9ed2-825507202c16@amd.com>
Content-Language: en-US
From: Georg Gottleuber <g.gottleuber@tuxedocomputers.com>
Autocrypt: addr=g.gottleuber@tuxedocomputers.com; keydata=
 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
 bsxTTcOuRnk=
In-Reply-To: <3271e5d7-9b2a-4378-9ed2-825507202c16@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Am 18.06.25 um 04:16 schrieb Mario Limonciello:
> On 6/17/2025 6:42 PM, Alex Hung wrote:
>> Hi,
>>
>> Thanks for reporting. Can you please create a bug at https:// 
>> gitlab.freedesktop.org/drm/amd/-/issues/ for issue tracking and log 
>> collection.
>>
>> On 6/12/25 08:08, ggo@tuxedocomputers.com wrote:
>>> Hi,
>>>
>>> I have discovered that two small form factor desktops with Ryzen AI 7
>>> 350 and Ryzen AI 5 340 crash when woken up from suspend. I can see how
>>> the LED on the USB mouse is switched on when I trigger a resume via
>>> keyboard button, but the display remains black. The kernel also no
>>> longer responds to Magic SysRq keys in this state.
>>>
>>> The problem affects all kernels after merge b50753547453 (v6.11.0). But
>>> this merge only adds PCI_DEVICE_ID_AMD_1AH_M60H_ROOT with commit
>>> 59c34008d (necessary to trigger this bug with Ryzen AI CPU).
>>> I cherry-picked this commit and continued searching. Which finally led
>>> me to commit f6098641d3e - drm/amd/display: fix s2idle entry for DCN3.5+
>>>
>>> If I remove the code, which has changed somewhat in the meantime, then
>>> the suspend works without any problems. See the following patch.
>>>
>>> Regards,
>>> Georg
>>>
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index d3100f641ac6..76204ae70acc 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -3121,9 +3121,6 @@ static int dm_suspend(struct amdgpu_ip_block
>>> *ip_block)
>>>
>>>       dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>>>
>>> -    if (dm->dc->caps.ips_support && adev->in_s0ix)
>>> -        dc_allow_idle_optimizations(dm->dc, true);
>>> -
>>>       dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv,
>>> DC_ACPI_CM_POWER_STATE_D3);
>>>
>>>       return 0;
>>>
>>
>>
> 
> That patch you did is basically blocking hardware sleep.  I wouldn't 
> call it a solution.
> 
> If you haven't already; please use 
> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/amd-debug-tools.git/about/ 
> to triage this issue.  It will flag the most common things that are hard 
> to diagnose without knowledge.
> 
> If that doesn't flag anything, please reproduce on a mainline kernel 
> (6.15.y or 6.16-rcX) and then file a bug as Alex suggested.  Attach the 
> report you generated from the tool there.
> 

Tested with newest mainline kernel 6.16.0-rc2 and the bug somehow
changed. Now the system resumes always (with GUI), but NVMe is always
disconnected. If I apply the patch resume works (including NVMe).

Created an issue:
https://gitlab.freedesktop.org/drm/amd/-/issues/4344 (with report)

Regards,
Georg


