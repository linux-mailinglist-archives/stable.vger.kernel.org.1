Return-Path: <stable+bounces-89472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57EC9B8A1A
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 04:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73411C21BA9
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 03:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16BB1459F7;
	Fri,  1 Nov 2024 03:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y++Ha3+I"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26FC13BC18;
	Fri,  1 Nov 2024 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730432962; cv=none; b=bZ1JQtBh/FmxTtfE9Q1EkXm9PhEsqm3u6Tg9DAyyAq5NNT7hL1wgaWNgiXV3ihFOm3cxmedhevNu+2BL5lR9HAjFE3QX0ZPaJqGxJlEgSeHP4GtmBf3iPAwCO4+j6S/KN2HsARYN1+/y1GwKtko1a3Pb7OwSRueIE8zcrD+wbjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730432962; c=relaxed/simple;
	bh=ITlk7toW7r+/8ai/vHURhDUElQIuKW6j+3xWJJXBal4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuJ81GOPJu18tcMpI2L7yNgSFfvPmzXsxwdDArdGGsaEuAk7qqtj74P3ayCN0QLIxzjuwovAKI95jqeIUKB9mi5V3gYv5v1OuTUjdR/1t0EcI0Vg1JujL2qCUszoakOHHRnqBgX3Qg0DI6t98yUs0+ALRVvMiAui1NAm8HVQwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y++Ha3+I; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <30fefafc-d19a-40cb-bcb1-3c586ba8e67e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730432957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+aisCwM6KP9qhKb2kb76HEqZmfimYG5W48SHq8fMVq8=;
	b=Y++Ha3+Inw7JOluD44nkAOSKEmpOHi1RI6ERF950vDTo2tE4evJIgqeCCjhUGWnS3wOJLE
	KJLrcTTGP+Ayn1k31dYjysjoFgR/A1qCWb/jV/ZUx5Gngphix6NPathal7tWHsLdSmdcF/
	QK6CmqO46uFanBZJj0jAq2gK7lGlG3c=
Date: Fri, 1 Nov 2024 11:49:07 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
To: Johan Hovold <johan@kernel.org>
Cc: neil.armstrong@linaro.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abel.vesa@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <172951608323.1285208.3162107667310691864.b4-ty@linaro.org>
 <230b5910-6790-44cb-90ed-222bee89054d@linux.dev>
 <c2a4cc3a-2ffc-46f3-8636-238cd561f7aa@linaro.org>
 <751a4ab5-acbf-4e57-8cf4-51ab10206cc9@linux.dev>
 <ZyOvAqnuxbNnGWli@hovoldconsulting.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ZyOvAqnuxbNnGWli@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/11/1 00:23, Johan Hovold wrote:
> On Thu, Oct 31, 2024 at 11:06:38PM +0800, Sui Jingfeng wrote:
>
>> But I think Johan do need more times to understand what exactly
>> the real problem is. We do need times to investigate new method.
> No, I know perfectly well what the (immediate) problem is here (I was
> the one adding support for the of_node_reused flag some years back).
>
> I just wanted to make sure that the commit message was correct and
> complete before merging (and also to figure out whether this particular
> patch needed to be backported).


Well under such a design, having the child device sharing the 'OF' device
node with it parent device means that one parent device can *only*
create one AUX bridge child device.

Since If you create two or more child AUX bridge, *all* of them will
call devm_drm_of_get_bridge(&auxdev->dev, auxdev->dev.of_node, 0, 0),
then we will *contend* the same next bridge resource.

Because of the 'auxdev->dev.of_node' is same for all its instance.
While other display bridges seems don't has such limitations.


> Johan

-- 
Best regards,
Sui


