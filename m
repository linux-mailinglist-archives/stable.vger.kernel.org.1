Return-Path: <stable+bounces-200010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EE7CA37F2
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 12:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEBCE30380E3
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 11:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85C82F2616;
	Thu,  4 Dec 2025 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go/IgpOZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051A2DAFBE;
	Thu,  4 Dec 2025 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764849220; cv=none; b=fTe5TjrJjUwRXyteTQ2Xux4ik1CSVz7oyPG5tlA4kLmsk1IffrVO8CLFycIKSy0/dbcRLPT6ui9/+2Ar9k9QU9qcw64lclPKfKdsZcVZja01PnbNu2e2QQfI2Out9mq+6bQ45riYpfWpbMei0ZqzzASkcw8PM21enFaV8nW0fp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764849220; c=relaxed/simple;
	bh=L3hEC/VBaZaUXv80HCKy07BIxXVcM/EDaXeEIWewJHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRGqVze/mHBTR8aBxC+eSLMAnWZqa8n+c+yUthoMMsKZrp1qYjV4XC82p/q2G6hnfW2c97qdarVCIkU4YSDu/Kccy08Ywv6uof2DDAFmqfI5YTGP1ShY3Wj15yyh1Jn6ORvHzwtq0YlQba9AcrtxCnn4okyZTcWRPglDHVdmnIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go/IgpOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38D7C4CEFB;
	Thu,  4 Dec 2025 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764849220;
	bh=L3hEC/VBaZaUXv80HCKy07BIxXVcM/EDaXeEIWewJHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=go/IgpOZU8JX2GpIm/zXaX55hQX4XbtrP0pG8ftqcqvnoSuhBQPw9pn4Gjd8SuqJ+
	 PrYEH51l4d/20+T4KIS2yAH7Td1y0RQ/pMlUiGIzA5SVzPWvK3yqPZwUMafnGVrvFg
	 7ufiIrfu0RsRb4RzJnavDn3e1ge3N3JKi3tIZdG2MTa4Zz+ItNHAfO5qWbIBvVhuIC
	 vvPd+dJ0UC7LW6yCpuU7Ux/aQg+eLaz4hR8jzEJWPNHbBF3nsAY7x6yg2yGHUshEfT
	 Wtt+2dlunZ1e5p6ZD1gC60Nxdn166cIKIVGKf7HPLA2Qw4xIdbmHm20acWiqVc32gu
	 8a72lh2JbGzhA==
Message-ID: <0fc5c657-4edf-474f-9df7-3c3473b5f458@kernel.org>
Date: Thu, 4 Dec 2025 12:53:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reset: gpio: suppress bind attributes in sysfs
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251204094412.17116-1-bartosz.golaszewski@oss.qualcomm.com>
 <75004da5-1ff6-4391-9839-2d134709eea0@kernel.org>
 <CAMRc=McEX6y_9JF=ji_TQ0aSMaQYe4kjq8Tj1S=vOcbawyXw3w@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAMRc=McEX6y_9JF=ji_TQ0aSMaQYe4kjq8Tj1S=vOcbawyXw3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/12/2025 12:22, Bartosz Golaszewski wrote:
> On Thu, Dec 4, 2025 at 12:14 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 04/12/2025 10:44, Bartosz Golaszewski wrote:
>>> This is a special device that's created dynamically and is supposed to
>>> stay in memory forever. We also currently don't have a devlink between
>>
>> Not forever. If every consumer is unloaded, this can be unloaded too, no?
>>
>>> it and the actual reset consumer. Suppress sysfs bind attributes so that
>>
>> With that reasoning every reset consumer should have suppress binds.
>> Devlink should be created by reset controller framework so it is not
>> this driver's fault.
>>
> 
> Here's my reasoning: I will add a devlink but Phillipp requested some
> changes so I still need to resend it. It will be a bigger change than
> this one-liner. The reset-gpio device was also converted to auxiliary
> bus for v6.19 and I will also convert reset core to using fwnodes for
> v6.20 so we'll significantly diverge in stable branches, while this
> issue is present ever since the reset-gpio driver exists. It's not the
> driver's fault but it's easier to fix it here and it very much is a
> special case - it's a software based device rammed in between two
> firmware-described devices.

That's not the answer to my question. You can unbind every other reset
controller. Why is this special although maybe you mentioned below?

> 
>>
>>> user-space can't unbind the device because - as of now - it will cause a
>>> use-after-free splat from any user that puts the reset control handle.
>>>
>>> Fixes: cee544a40e44 ("reset: gpio: Add GPIO-based reset controller")
>>
>> Nothing to be fixed here, unless you claim that every reset provider is
>> broken as well? What is exactly different in handling devlinks between
>> this driver and every other reset provider?
>>
> 
> I don't care if we keep the tag, it's just that this commit introduced
> a way for user-space to crash the system by simply unbinding
> reset-gpio and then its active consumers.
> 
> And the difference here is that there is no devlink between reset-gpio
> and its consumers. We need to first agree how to add it.

So you mean that between every other reset consumer and reset provider
there is a devlink? And here there is no devlink?


Best regards,
Krzysztof

