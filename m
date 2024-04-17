Return-Path: <stable+bounces-40060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D8B8A7C04
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 08:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3972B282CE9
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 06:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F25338F;
	Wed, 17 Apr 2024 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvDzj3LU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101D537E4;
	Wed, 17 Apr 2024 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713333754; cv=none; b=flYt7eSkHiUxNQ5ptCuBBBawjqfNQMfuNKeP0UMj22az6RpJEX3oVOXnVW1iYSYIY2N43xyOBQtUO1GzRiePAmUAfN7Wy5MHVAvjyYYJbvkx7bsKWD9nxcfus1c+PJ6j1YtTLmCMOJSZOHdEE9Z0C+u5r03Gd+/m97klvY2sg9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713333754; c=relaxed/simple;
	bh=WTcNft45QiDM3rme2X9uzvBlgjquXnt492YuuWbWWsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P140NYQA7uPFMXAvthnBnmgTCnvUBc0Kz/7OZ0m6APIG6mZVglThX5ilYEecSNq7QOtDNYrRL/ibzd4DnFR2pCcw1h7sXI/eDU632k241Jp6iTH9vMypKOU/cjjmU8+dOWgjH3oCHyLJmkLt8RjTCU9SCCgqfUN57A8Jp/CmAdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvDzj3LU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso5194496a12.3;
        Tue, 16 Apr 2024 23:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713333751; x=1713938551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mF0pFS51gH5GTcHJ1C7dzPpVn54sb8Hp42gXRnRRY/Y=;
        b=PvDzj3LUeWQ9FJ/0T6fiitXyqrt3RiLCdZyTfi5mB64K/gcKOq4hdfAJlNvSQMUi1E
         Hu2Uztax8m5L0qumvS5F0Zl0EpvHz0mtqomX8XNx9amqnddt5HcFbpt/0rOLnH09wb2q
         g4c7clP9wG8vUGYOQ45zJb8dLbQndZOzl5ChOSQQ40fNwrXnpS9IjhEGwnydSAbM1F2q
         H7NcoedH9BkpopRXGYOm/gIpkeMunPag/xXjMHCSjohGDoODow2oRyIhGmQDBjxjBNLk
         kS51KYniyeOE7owTzupv7YHdndBNdbRBse9kViaRgXfIxpYCYxhewTlUAKFWAzPWk6zm
         ky7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713333751; x=1713938551;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF0pFS51gH5GTcHJ1C7dzPpVn54sb8Hp42gXRnRRY/Y=;
        b=X7MB/xkR6SixARuCZmK1Xj+JFEeC8E9IuCEVMcWHTkmJQz7gFp8NrlVwuePB7fu2g/
         Vy3+B69/4vXBchVEWGuG7tRh9VdawvvHTDo4ps/5fqfPfHbQmo4BdUIiwDy0j1yWw8bi
         kPx7EAErd1mLBTspXPRqEFBdC4pIuMzj1iku+JRsCUhCSmWfE+VtsAMB/lpX+sBAselw
         mHt93DgPjlXK0WIlALtQKxooyy9nWulAEJjqt17UWRdTizc26yeGSMkTbIFX4fTfhWuC
         2zHtqVbP/aUchPkPN86GpD4tDqt8RGmmL/XXrGcRRNqvHhh49zBXQI8YMDi12TEdIp0J
         DgiA==
X-Forwarded-Encrypted: i=1; AJvYcCVf+BI5JFvnpnKPXyokqYUGlyZxVTXwFueysLDDR4fu1p6DoXGJGrgYDPexLiCecQK/qmZ5jI0VfsonWHzb0N26ugJ1ldY3
X-Gm-Message-State: AOJu0YzMO6ipA5Kk1/jKUsv1jiAQJoMspjraQju4Q6Mf58jiZJWt8mTF
	9f2lLsJfvfSB1Nvt0RjQIOUcwQbCd/b//2PfBGiXWbikfZkn7+if
X-Google-Smtp-Source: AGHT+IECIW3ezBkiS3IalzpjIIm4RDga8kMmuYznsaks+IExQAwH+dr2xrxqXlJY1uTb+9XMtSKzqA==
X-Received: by 2002:a17:906:cb10:b0:a52:351f:5694 with SMTP id lk16-20020a170906cb1000b00a52351f5694mr9464204ejb.14.1713333750738;
        Tue, 16 Apr 2024 23:02:30 -0700 (PDT)
Received: from ?IPV6:2a01:c22:721d:1e00:e86e:6f8a:5e9e:a11a? (dynamic-2a01-0c22-721d-1e00-e86e-6f8a-5e9e-a11a.c22.pool.telefonica.de. [2a01:c22:721d:1e00:e86e:6f8a:5e9e:a11a])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4855048eje.94.2024.04.16.23.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 23:02:30 -0700 (PDT)
Message-ID: <4b0495fd-fab5-4341-9b06-2f48613ee921@gmail.com>
Date: Wed, 17 Apr 2024 08:02:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
To: Jakub Kicinski <kuba@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ded9d793-83f8-4f11-87d9-a218d10c2981@gmail.com>
 <20240416193458.1e2c799d@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240416193458.1e2c799d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.04.2024 04:34, Jakub Kicinski wrote:
> On Mon, 15 Apr 2024 13:57:17 +0200 Heiner Kallweit wrote:
>> Binding devm_led_classdev_register() to the netdev is problematic
>> because on module removal we get a RTNL-related deadlock. Fix this
>> by avoiding the device-managed LED functions.
>>
>> Note: We can safely call led_classdev_unregister() for a LED even
>> if registering it failed, because led_classdev_unregister() detects
>> this and is a no-op in this case.
>>
>> Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
>> Cc: <stable@vger.kernel.org> # 6.8.x
>> Reported-by: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Looks like I already applied one chunk of this as commit 97e176fcbbf3
> ("r8169: add missing conditional compiling for call to r8169_remove_leds")
> Is it worth throwing that in as a Fixes tag?

This is a version of the fix modified to apply on 6.8.
It's not supposed to be applied on net / net-next.
Should I have sent it to stable@vger.kernel.org only?


