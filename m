Return-Path: <stable+bounces-203093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F044DCD01C7
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 14:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C56EF303DD02
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 13:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276811E7C34;
	Fri, 19 Dec 2025 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="Q6PnFlPO"
X-Original-To: stable@vger.kernel.org
Received: from mout.freenet.de (mout.freenet.de [194.97.204.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D61322B95
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.97.204.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766152012; cv=none; b=nwa1ipzSLkQ46Xh1tjJCYR2Fu0F55s7mV8bIxWvZeGvpDTzFvV1+fJazIGYyznWBNxnG7xxCzNzb06s36o23OPVfkEMePDzCCfyjGg+O4LtGD5FsQJndcHWzT78e+yfADSGO++TLVWilWOk/hKnW78jiH+x3S9Yll6RkW24t3BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766152012; c=relaxed/simple;
	bh=OJQghQIYa+kJxY8X6d0If3IbUVHn9kbw05hfP5Vers4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQvdckWtTJJb2dhVzHFm3rEYeZVP3m4/oGWBch60pDkrBn91e1o/5i3UBRO7w4F5/S26mFlO01ndbw0dpZEuqX1ziGYv/gl10CXViiyDOjHXLc5Iip2kkuOobDPHXTveK+CiIX9y2LhXkLaNBB7CiMLvbI0TC/b6/VM27Wz5LSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=Q6PnFlPO; arc=none smtp.client-ip=194.97.204.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Received: from [2001:748:400:1319::5] (helo=sub7.mail.fnrz.de)
	by mout5.mail.fnrz.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port 25) (Exim 4.96 #2)
	id 1vWajU-00DUxI-1T;
	Fri, 19 Dec 2025 14:41:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5k1DhQk1Nv53G3Eu2pTGP1PdYEwH2Uv+D5jfzmQOTrI=; b=Q6PnFlPOdegpO0JaNsxDqv5ihq
	qgggmsr3HDPpUR8B13P4rBcJMBOxonS3/6lLcQJKZDB0alV+yemoRfLTIgCYYi6oYj1gptJrJ7eeq
	v3vEYAsnhFgqswH9bTStU1UR9HPe2WYERSbBr87LK0RooGs9LJc096bs5CN20E+6VuO8g/yrsxY2D
	6d5wtqEbsdXbO2TeeIHQKnXqcTxYHvBHbzl1kSXIXIA7kW6VqWg0K8pQc3VsOdSy/8/MQkyxpXAm1
	7VqWjUxrDnwwRxdObG0H9Rz1VPRwl8GMm0+0y5ybF5gKS1sxnTp/craLk0E8t3quf5H3B9UPunUE1
	NyQ5PxfQ==;
Received: from [2a02:8071:a85:f020:a8:6478:ce84:36e2] (port=45260 helo=[127.0.0.1])
	by sub7.mail.fnrz.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim 4.96 #2)
	id 1vWajU-00AZTi-0x;
	Fri, 19 Dec 2025 14:41:24 +0100
Message-ID: <e67f2f0b-e9ce-4dfb-a4b4-1ff0425b52dd@freenet.de>
Date: Fri, 19 Dec 2025 14:41:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: don't attach the tlb fence for SI
To: Hans de Goede <johannes.goede@oss.qualcomm.com>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>
References: <20251214095336.224610-1-johannes.goede@oss.qualcomm.com>
 <2025121502-amenity-ragged-720c@gregkh>
 <b78aadb1-d2ca-459c-8078-b1cd9a500398@oss.qualcomm.com>
 <2025121500-portside-coleslaw-915b@gregkh>
 <0f92d42d-5df8-423b-82a4-7fa9342d69ef@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
In-Reply-To: <0f92d42d-5df8-423b-82a4-7fa9342d69ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 176615168481794966051BO
X-Scan-TS: Fri, 19 Dec 2025 14:41:24 +0100

(Adding Sasha to this thread)

Hans de Goede wrote:
> Hi Greg,
> 
> On 15-Dec-25 10:05 AM, Greg KH wrote:
>> On Mon, Dec 15, 2025 at 09:15:17AM +0100, Hans de Goede wrote:
>>> Hi greg,
>>>
>>> On 15-Dec-25 9:12 AM, Greg KH wrote:
>>>> On Sun, Dec 14, 2025 at 10:53:36AM +0100, Hans de Goede wrote:
>>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>>
>>>>> commit eb296c09805ee37dd4ea520a7fb3ec157c31090f upstream.
>>>>>
>>>>> SI hardware doesn't support pasids, user mode queues, or
>>>>> KIQ/MES so there is no need for this.  Doing so results in
>>>>> a segfault as these callbacks are non-existent for SI.
>>>>>
>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4744
>>>>> Fixes: f3854e04b708 ("drm/amdgpu: attach tlb fence to the PTs update")
>>>>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> What kernel tree(s) should this go to?
>>>
>>> This fixes a regression introduced in at least 6.17.y (6.17.11)
>>> and 6.18.y (6.18.1). So it should at least go to those branches.
>>
>> But that commit is in 6.19-rc1, not anything older.
>>
>>> If any other branches also have gotten commit f3854e04b708
>>> backported then those should get this too.
>>
>> I don't see that commit in any stable tree, what am I missing?
> 
> Ah, I see now the Fixes tag in the original fix (which I cherry
> picked) is wrong and does not point to the canonical commit id as
> merged into Torvalds tree, sorry.
> 
> This is b4a7f4e7ad2b120a94f3111f92a11520052c762d  ("drm/amdgpu:
> attach tlb fence to the PTs update") in Torvalds' tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b4a7f4e7ad2b120a94f3111f92a11520052c762d
> 
> and this actually made it into the v6.18 tag (vs being introduced
> in 6.18.1 as I originally thought).
> 
> This is also in 6.17.11 as 23316ed02c228b52f871050f98a155f3d566c450
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/gpu/drm/amd?h=linux-6.17.y&id=23316ed02c228b52f871050f98a155f3d566c450
> 
> FWIW I don't see it in 6.12.y (and I did not look further back).
> 
> Regards,
> 
> Hans
Can this fix be added to the 6.18 queue, please? All relevant
information can be found in the previous email from Hans.

Thanks,
Viktor

