Return-Path: <stable+bounces-89338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969749B6676
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4172E1F210E7
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C431E9071;
	Wed, 30 Oct 2024 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hChgAx3v"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1611F4712
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299779; cv=none; b=ufd6jKQ0k4jdlRCjQFu2VuU7Ukn16pOjCgr6YOuknhGvZmqbxAi+eYmmayGwN7YjKSGYfg3RGNeV5pT/r+rGGWE0xOXkT4EpG8pRC01l6tzQypIpphoG6KfoIGYxA0vrZfDCS3IQJhd7uuqTksdJyv+0wtaajk/5YyDjRLLt8bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299779; c=relaxed/simple;
	bh=58fkI0DxBTuYu41ZNeXJTYW9hWb+IBRT0RkNSze6a4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqWbydVtRzBVO977u2i5+DCu02x0V1Z2yWynYWOEdk5soPlnkOeOCrfI3m8rhfoxEusnV5QvM/+e58m2/5fJDCdYNxxdCNdyyIROiL9NPnuSVQODB9olL8nAbimUdeU3Tj2fZxNSlcB+pS2SsNPklpmmH4K4aG34/AxW4+FraJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hChgAx3v; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <230b5910-6790-44cb-90ed-222bee89054d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730299774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1w/iqqQqeWdeidkDYmAvBZgSRrIyIu8DOwMPAJKc5Y=;
	b=hChgAx3vpxAGTC+OhSh6VQuCWJeMJr+0JC1YgvQs6qW6kvU5WF6nXBZ98DDucWqYkFvPkT
	F8TPGR9+POiRaVmvmQnWW3KABiWHhd2eHu0ra11vSqHySg4IdE4cMK03hMllBb4rkXzCm/
	urjRWKw09rxXAhEPe72OlmQuYLc7t+M=
Date: Wed, 30 Oct 2024 22:49:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <172951608323.1285208.3162107667310691864.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/10/21 21:08, Neil Armstrong wrote:
> Hi,
>
> On Fri, 18 Oct 2024 15:49:34 +0300, Abel Vesa wrote:
>> The assignment of the of_node to the aux bridge needs to mark the
>> of_node as reused as well, otherwise resource providers like pinctrl will
>> report a gpio as already requested by a different device when both pinconf
>> and gpios property are present.
>> Fix that by using the device_set_of_node_from_dev() helper instead.
>>
>>
>> [...]
> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)


It's quite impolite to force push patches that still under reviewing,
this prevent us to know what exactly its solves.

This also prevent us from finding a better solution.

> [1/1] drm/bridge: Fix assignment of the of_node of the parent to aux bridge
>        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/85e444a68126a631221ae32c63fce882bb18a262
>
-- 
Best regards,
Sui


