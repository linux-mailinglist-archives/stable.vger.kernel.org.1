Return-Path: <stable+bounces-89475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9037D9B8B14
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 07:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40EF1C20EDF
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 06:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152AC148308;
	Fri,  1 Nov 2024 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WmTczjPq"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CEC2E62C
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441744; cv=none; b=Gm/B23LvTUIrAWfri2ufUI2M5pWauCd7GMO/YQi+cffkv9GashutKQ9fuEeELLLJY6+P1EZ3MK/udX7WhRU350pCsiH2/8xQfGV1r/+k3b9Hv7B3Fe2aWZXJsd5kZRNqVHNAcKOv9PRPnN1CsIY823+YOM3bA6jKRkgUnrU2Ba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441744; c=relaxed/simple;
	bh=J+Jtl/wPq7/sIvq26Ag+Dyt1uGggkEqLX46l4Y0JFD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qfszy3eXq7d3R3IKbsZR0rlFkoN2MMNyOAPPURSpHzQHXX5NtmDNmVGWYXdCUWGoOujSYnbllp6TqRUv8G8tKmbylr0KES06Uh3E/uHjSZ/VSNCn1d+0ojZBVcNQPxditRKMfjzsVvyx8jXCAdEyxtYYNHNBmE7FXnOj48N7ZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WmTczjPq; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ccffb15f-f63c-4d52-bb26-654916939cae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730441737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YC7POznpvjbkEo+eDdqRIo9I6A+2MKdx9zJLeweiyg=;
	b=WmTczjPqopaNy5j6ftE2neyrwfWYCeF8n0cn9B1+25HUWPFYYbfLu56CNllPXWNMV30YJt
	fGcowN+OVz142Bx2Ct3nkT0WBS/a+vxMK7mZcDMLTa2neKfflVDi2AD3qDIjXVr5NLnjEQ
	8YeMnMPLNqfDYgBks3Q8A0o0KctVvRs=
Date: Fri, 1 Nov 2024 14:15:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
To: neil.armstrong@linaro.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: Johan Hovold <johan@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <172951608323.1285208.3162107667310691864.b4-ty@linaro.org>
 <230b5910-6790-44cb-90ed-222bee89054d@linux.dev>
 <c2a4cc3a-2ffc-46f3-8636-238cd561f7aa@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <c2a4cc3a-2ffc-46f3-8636-238cd561f7aa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/10/31 20:31, Neil Armstrong wrote:
> On 30/10/2024 15:49, Sui Jingfeng wrote:
>> Hi,
>>
>> On 2024/10/21 21:08, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On Fri, 18 Oct 2024 15:49:34 +0300, Abel Vesa wrote:
>>>> The assignment of the of_node to the aux bridge needs to mark the
>>>> of_node as reused as well, otherwise resource providers like 
>>>> pinctrl will
>>>> report a gpio as already requested by a different device when both 
>>>> pinconf
>>>> and gpios property are present.
>>>> Fix that by using the device_set_of_node_from_dev() helper instead.
>>>>
>>>>
>>>> [...]
>>> Thanks, Applied to 
>>> https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)
>>
>>
>> It's quite impolite to force push patches that still under reviewing,
>> this prevent us to know what exactly its solves.
>
> It's quite explicit.
>

Auxiliary bus emphasis on *compartmentalize*, layer, and distribute
domain-specific concerns via *Linux device-driver model*.

Reusing(or sharing) of_node by multiple devices proved that the two
subsystems are still tangled together somehow. Which is fundamentally
violate the philosophy of compartmentalization.

The way that driver operated is not via Linux device-driver model either,
lots of those kind things happens quite implicitly.

But I think beautiful things associated behind this might also be voided,
that's it.


>>
>> This also prevent us from finding a better solution.
>
> Better solution of ? This needed to be fixed and backported to stable,
> if there's desire to redesign the driver, then it should be discussed 
> in a separate thread.
>
>>
>>> [1/1] drm/bridge: Fix assignment of the of_node of the parent to aux 
>>> bridge
>>> https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/85e444a68126a631221ae32c63fce882bb18a262
>>>
>
-- 
Best regards,
Sui


