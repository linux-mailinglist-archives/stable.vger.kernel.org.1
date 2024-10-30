Return-Path: <stable+bounces-89347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE249B6978
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 17:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436FA1F20F23
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCD51F1310;
	Wed, 30 Oct 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nFJ/Pnzu"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478C1E8849
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306743; cv=none; b=fQw9MEEzKYRSCuh3f6Q6xWv91ZkgVMYXOBlZA7lwzYtr3LSyyH1iPM0PAnyG0obbI7K0ooExBZ8fDlaCmAblXLuvGy9nUbowsBYi81VbuMCxlR1nspgpjBuoueX1YpGXjmbz8t5e+Jielc8q9eSdlE2WUgAYKHdRptjSbNO6Q6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306743; c=relaxed/simple;
	bh=hcFBMSRwI7XyLVXiwju9iNxMgHCXtPSFdswCTiWGT8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lf7eLnUv6wvi6BIa45XgsPSEoQdx+WdhTxPOMFT9vS6gUeoQvmQn3AuQ5eaqwb2PyIXOB2gcHLi69P6lGTkZSRPCxb1tuRx8lKdNZ/xtQLpf7WmIw2WU1rhsIFgcjBjdmn4gynqS3NbywuL/2JwCPmCAvmQ/ihTKkTgd/W2ODyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nFJ/Pnzu; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f2119a4d-7ba3-4f11-91d7-54aac51ef950@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730306737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IImZ1cZVsIXJIGIFBIuoTjHne0xPtt9XDcxUzdxcbs=;
	b=nFJ/PnzuiZtjPkvI0PKl64gdNlEDUbL7oSAq78a1QvDclqZGoe1La2Ah6XdSp1vzNooun7
	bCwWvVAvHmL8gchTeI60zfM3b/WoGPP/2zLD0EmFLUI0Odu5eYChun3lBUKye2a73LAIIs
	yadQopyWqNnFMUSZFHBPqPAtYd1KtN8=
Date: Thu, 31 Oct 2024 00:45:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <ux2lfkaeoyakulhllitxraduqjldtxrcmpgsis3us7msixiguq@ff5gfhtkakh2>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ux2lfkaeoyakulhllitxraduqjldtxrcmpgsis3us7msixiguq@ff5gfhtkakh2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/10/18 23:43, Dmitry Baryshkov wrote:
> On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
>> The assignment of the of_node to the aux bridge needs to mark the
>> of_node as reused as well, otherwise resource providers like pinctrl will
>> report a gpio as already requested by a different device when both pinconf
>> and gpios property are present.
>> Fix that by using the device_set_of_node_from_dev() helper instead.
>>
>> Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
>> Cc: stable@vger.kernel.org      # 6.8
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>> Changes in v2:
>> - Re-worded commit to be more explicit of what it fixes, as Johan suggested
>> - Used device_set_of_node_from_dev() helper, as per Johan's suggestion
>> - Added Fixes tag and cc'ed stable
>> - Link to v1: https://lore.kernel.org/r/20241017-drm-aux-bridge-mark-of-node-reused-v1-1-7cd5702bb4f2@linaro.org
>> ---
>>   drivers/gpu/drm/bridge/aux-bridge.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


Technically speaking, your driver just move the burden to its caller.
Because this driver requires its user call drm_aux_bridge_register()
to create an AUX child device manually, you need it call ida_alloc()
to generate a unique id.

Functions symbols still have to leak to other subsystems, which is
not really preserve coding sharing.

What's worse, the action that allocating unique device id traditionally
is the duty of driver core. Why breaks (so called) perfect device driver
model by moving that out of core. Especially in the DT world that the
core knows very well how to populate device instance and manage the
reference counter.

HPD handling is traditionally belongs to connector, create standalone
driver like this one *abuse* to both Maxime's simple bridge driver and
Laurent's display-connector bridge driver or drm_bridge_connector or
whatever. Why those work can't satisfy you? At least, their drivers
are able to passing the mode setting states to the next bridge.

Basically those AUX drivers implementation abusing the definition of
bridge, abusing the definition of connector and abusing the DT.
Its just manually populate instances across drivers.

  

-- 
Best regards,
Sui


