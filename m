Return-Path: <stable+bounces-89416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E709B7E90
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 16:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58608283D51
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7AD1A256A;
	Thu, 31 Oct 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g3TCnlZo"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBDC1A286D
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388715; cv=none; b=QEEdNeyalD8LrH5sggehUpWVzKgCP65WQ05bTxNLAaEvnHyW9F/rs/ryJ13Rjwjf5n5U4NCmZzm+FSAZ/vsm22VUh2sZH/rwq+A/NieSwcFXTTvNnfDGzaOje1QCRl3h/JReLPZ8Tagi1urRNrWatU87Mg/YKkruJ8BM0NPfF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388715; c=relaxed/simple;
	bh=kKdz1fUu1s/fMJEdwaAtVgGUNN/sK5LY8qFij3jZWW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tc1uazkNOSm1N0aEXdIynhqs7VeH6GRd1ec7Fnj9SWi4lYCR7ZGTYAmpqB4jR8Uxnt30XsuH8oIrtoonFB93jrS481E3rysOK4FqowMT9S/FXzKcNWuUYa4mzNnp67nPeInHZs9SEgKzADIA6d9JSxuxYw+Vovnw/7JSKGhGBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g3TCnlZo; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <664a1251-203d-4d29-86c4-6edd36c23eb9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730388710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FsbTOlKbKVtI/UbvwBD7+VePpEQEZip+EtLwmeq1hc=;
	b=g3TCnlZooYIDOinnZd6O2mliVhJVxCI4EWURNoQ5SGuegjVoMZka6XQCMwC2VcreiTLoSY
	eKw6S5DC7gG6/cOqbaMg/J77oLm0vCF3h59a+2MNz0fRnrk7nVaSayVvXfKy1mZFGA99pq
	rbDWupTLmeS5G5KTPttnp5qQ+7mK8/A=
Date: Thu, 31 Oct 2024 23:31:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
To: Johan Hovold <johan@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
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
 <ZyOOEGsnjYreKQN8@hovoldconsulting.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ZyOOEGsnjYreKQN8@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/10/31 22:02, Johan Hovold wrote:
> On Thu, Oct 31, 2024 at 01:31:47PM +0100, Neil Armstrong wrote:
>> On 30/10/2024 15:49, Sui Jingfeng wrote:
>>> On 2024/10/21 21:08, Neil Armstrong wrote:
>>>> On Fri, 18 Oct 2024 15:49:34 +0300, Abel Vesa wrote:
>>>>> The assignment of the of_node to the aux bridge needs to mark the
>>>>> of_node as reused as well, otherwise resource providers like pinctrl will
>>>>> report a gpio as already requested by a different device when both pinconf
>>>>> and gpios property are present.
>>>>> Fix that by using the device_set_of_node_from_dev() helper instead.
>>>>>
>>>>>
>>>>> [...]
>>>> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)
>>>
>>> It's quite impolite to force push patches that still under reviewing,
>>> this prevent us to know what exactly its solves.
>> It's quite explicit.
> It's still disrespectful and prevents reviewers' work from being
> acknowledged as I told you off-list when you picked up the patch.
>
> You said it would not happen again, and I had better things to do so I
> let this one pass, but now it seems you insist that you did nothing
> wrong here.
>
> We do development in public and we should have had that discussion in
> public, if only so that no one thinks I'm ok with this.


Yeah, extremely correct, Johan!

While I am really don't know why a child device have to
share the referencing of the OF device node with its parent device?
Is possible to pass a child device node via the platform data to reference?

I means that, in DT systems, the child device can easily
have(find) its own device node to attached.
I'm imagining that it probably should be belong to the USB
connector device node or something like that.

Sorry, I'm confused. I understand that you also might be busy.
I think I probably should go back alone to think for a while.


> Johan

-- 
Best regards,
Sui


