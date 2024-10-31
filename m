Return-Path: <stable+bounces-89414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661FA9B7DC9
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 16:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC15328167B
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 15:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BDD1A256B;
	Thu, 31 Oct 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VkQyjN8W"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572F21A0BFF
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387227; cv=none; b=nIvPx218GAKV7nGMcppuokDKZaU+TFudqu60i3ygsjYmHO38LAftb0GrqA9dks8us1L3BT8Uf3lsG6pw4u3ovrToJ/hW2PjDiwnWrbVagBWgKKI68VwFUKyvD+YubcconPkvC/fxVgEG20wa6C0agBDJ/8PLeMd0bT2A5zNt84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387227; c=relaxed/simple;
	bh=RjuxSppiBq3w5/JKbYGq8GoAHjzsNyjHTYkHz/iAfBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvPAMH3eM9iK9mnA/4CiL4e7ZwjBAAb4l8oGNqADC2lrM4/Gu4RozQrdsxzM7b5T14M1a8YI7ZlGS3FMK3PXsaWZM1YqCZZT0pHmQRFBa9VgR6J+qd/HKlD1kmI2UPJ1kKoFTQAtVkB4kUVaeXSwxqzsf7yU31U+iEuI5RlGJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VkQyjN8W; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <751a4ab5-acbf-4e57-8cf4-51ab10206cc9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730387220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4U6SCFjDt3RFRuNzC5QvY8+3i7nEcu3/ZcBbDN5c4g=;
	b=VkQyjN8WNBI0oCCjXz7F5Wp+EptgxTa3J6nnBjquraUwZAfRGV6npP7KRjnrzGC5S+YpNc
	+sPNwwkDQLuts1YhSWuwfwyU38Mzgqj1rHgzyY8hsT79Oij0b1AMVi7c6JlWF7jr8LJRmX
	AIOove+nInVVaCXBnxug+gsjRaMQBek=
Date: Thu, 31 Oct 2024 23:06:38 +0800
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

Hi, Dears maintainers

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
>>
>> This also prevent us from finding a better solution.
>
> Better solution of ? This needed to be fixed and backported to stable,

We were thinking about

1) if possible to add a proper DT binding for those drives.

Or alternatively, as Laurent pointed out that

2) Invent some extra techniques to move the idr allocation
    procedure back to the AUX bus core. Make the core maintained
    device ID happens can help to reduce some boilerplate.

And those really deserve yet an another deeper thinking? no?
    

> if there's desire to redesign the driver, then it should be discussed 
> in a separate thread.
>
No, please don't misunderstanding. We are admire your work
and we both admit that this patch is a valid fix.

But I think Johan do need more times to understand what exactly
the real problem is. We do need times to investigate new method.
This bug can be a good chance to verify/test new ideas,
at the least, allow us to talk and to discussion.


>>
>>> [1/1] drm/bridge: Fix assignment of the of_node of the parent to aux 
>>> bridge
>>> https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/85e444a68126a631221ae32c63fce882bb18a262
>>>
>
-- 
Best regards,
Sui


