Return-Path: <stable+bounces-96153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 366AE9E0CB7
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 21:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733A9B3D468
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A971DE3BB;
	Mon,  2 Dec 2024 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCd354iD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122D81DE4EC
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166493; cv=none; b=oEGo9faDuF8qpOu3658Fm47HbQ7YtF2YqJLigkuLISvMMOvCRD50AsEdfNxvCYfovEPRADElU5SK1CEuDv+sU0kIHmj6zLJbI3LVqMT990+sJ4niN2mmgomdUtTaI1s4ntENQ5KrwWkE6ClIbdTjMTuQ2mN3tKiyU6m5BLNV5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166493; c=relaxed/simple;
	bh=Z3/Pi2dwnK7FiWi+vOh/3V6OMwqv4AL7YpTH5gIU6vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+4MZJQF2xnTPSGMTKTb3CsKTP/HBSnSs2WNKdVwRKADCB0xwhgaLjXUfY5fGfOckRxKdhQ0AyH7yqfrIQYpjDWf42gDnp136p10UosVYNb3H+tI4rZowAoNE5X4eBWutytVD3eIBa3ZE/mM571TcqtZ9VdLm89BiyydeC8+3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCd354iD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a736518eso58543085e9.1
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 11:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733166490; x=1733771290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AG1woINgMag3tSmku7B6A03UURZTXe/U3RZwNl2BWp0=;
        b=RCd354iDROyliFeHYiiRV0+HsGKJSnuJz4IbiTG+uTwPC1P1lEfazQ5pYTBFpY7m0c
         nFPZPRqZue8r6OsfmD4G6hp9WpWxNTVcLrcOVbibF0h1R7HXrjed6M15xLsRDpHIdTUv
         Ml/IxR3G8cQD+NRdLN4i74BXWAh9Xd8Vvv9jVJ6PyOt/iLs+qVYy4T1u7+Kl8vRHmBCJ
         q17PfdKM2l0vI85ZPplNBcjhRDztT68biGGN/1CBczbfrGjBYQUEs+ecPj8kCjhKxiWu
         A6V8l4BgyCkeGSrLmXgWsQE9nwI4ZVKd8B9bQdyxWM6ms3U/b09FFdEor+g84/Yz4xuX
         QE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733166490; x=1733771290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AG1woINgMag3tSmku7B6A03UURZTXe/U3RZwNl2BWp0=;
        b=jgYvZtzcRWx3jof/M0VIj7CzflgRCQkmViHhjEjraXTI1poxYvOrTAEtWMapOB9TD0
         0oZuUSEToa873wGB2sv1USeDMp1iKBIY+AQiirAFFBb0/APqyEBaQfHAMnsXKS/Jn8WB
         WLfqTOl23HRb4ZJjHQ9jgTht8ldLV1p7zJSw3rHqF0fq8yIPAkcdegOjsxOLSkixTbXq
         Fao1dSZD4WC7MOYvdTj3ob+XZQuZyiNj35aWsywqB2IbtzxYhlrEyb/KSa/smJKiTEFX
         VYJ0t7jtlnH2lm3eUgjGrFUn6LfEdZC0ifRSP8EY0R6CCxkVpVmq50J3zX304zatE8Yv
         C5XA==
X-Forwarded-Encrypted: i=1; AJvYcCXRUFEXN5EzE1XQQKhxXKYX8FVGBBFpinKynPSmWiEnJHPQymXNovcIOEZLJmk4txhAKexueRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCFaSEa6pAexNUfst9V7iKWc614xSTLIhgfXAFmYCqdCfWXsDf
	QvvAmx0oJHtC7jbsjWt6vy4wsh5fAuXz92Z754x32gIq2cZI1gpX
X-Gm-Gg: ASbGncvM6Y5sg0a5USdaSu86A5Cg8Rvbxl1T5RHip7uT+Fz5goHMf2JMEd6NX/FBWaA
	UogGJ5zr8d0HgPlasOnvX7HOe7xJmq4DNAVlJxZeknNGvOkPaTlacAU42wjVj9fE3FycRtDsESy
	KZMI5fXWMIdmwiPk+88kV1xw09vdQvokJl1Zt8zHcPMpzgPRzzIwtJiHnQDZPViHaqo2/ftHeOu
	Z1ti/IZx8fof36stqoN+8/S+WVjLVjQpVe4Sr5FUf/l6p5ES8OFO7AA4OSUvcLP7fFSs7ToemS0
	Qe8/Ch2jCnK9BUfXRHn0n7r7iNwpQaSUQ6uEkFA9eOC4YvTZQOVjo2wy9gT26fppzDq8XXSNd3x
	mtaA4U7PUZbIm8u1h81FjLt5iuyLl5THHxsKOQNBpaF0=
X-Google-Smtp-Source: AGHT+IFIjEfIyWru+eonp7zMm72+TTQvuR4J8szhZTn6SqrZjrnk3uoRVEbUMl0UcEV1FEH94UI+8A==
X-Received: by 2002:a05:600c:c86:b0:42c:ba83:3f00 with SMTP id 5b1f17b1804b1-434a9dbb6a7mr224332605e9.1.1733166490021;
        Mon, 02 Dec 2024 11:08:10 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:d553:b993:925a:609c? (2a02-8389-41cf-e200-d553-b993-925a-609c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d553:b993:925a:609c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b9a9679bsm128559595e9.13.2024.12.02.11.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 11:08:09 -0800 (PST)
Message-ID: <e58b3f28-7347-4f89-8f1e-a4f05e5f3ae0@gmail.com>
Date: Mon, 2 Dec 2024 20:08:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stable-rc: queue: v5.15:
 drivers/clocksource/timer-ti-dm-systimer.c:691:39: error: expected '=', ',',
 ';', 'asm' or '__attribute__' before '__free'
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 linux-stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <CA+G9fYtQ+8vKa1F1kmjBCH0kDR2PkPRVgDuqCg_X6kKeaYjuyA@mail.gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <CA+G9fYtQ+8vKa1F1kmjBCH0kDR2PkPRVgDuqCg_X6kKeaYjuyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2024 19:43, Naresh Kamboju wrote:
> The arm queues build gcc-12 defconfig-lkftconfig failed on the
> Linux stable-rc queue 5.15 for the arm architectures.
> 
> arm
> * arm, build
>  - build/gcc-12-defconfig-lkftconfig
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build errors:
> ------
> drivers/clocksource/timer-ti-dm-systimer.c: In function
> 'dmtimer_percpu_quirk_init':
> drivers/clocksource/timer-ti-dm-systimer.c:691:39: error: expected
> '=', ',', ';', 'asm' or '__attribute__' before '__free'
>   691 |         struct device_node *arm_timer __free(device_node) =
>       |                                       ^~~~~~
> drivers/clocksource/timer-ti-dm-systimer.c:691:39: error: implicit
> declaration of function '__free'; did you mean 'kfree'?
> [-Werror=implicit-function-declaration]
>   691 |         struct device_node *arm_timer __free(device_node) =
>       |                                       ^~~~~~
>       |                                       kfree
> drivers/clocksource/timer-ti-dm-systimer.c:691:46: error:
> 'device_node' undeclared (first use in this function)
>   691 |         struct device_node *arm_timer __free(device_node) =
>       |                                              ^~~~~~~~~~~
> drivers/clocksource/timer-ti-dm-systimer.c:691:46: note: each
> undeclared identifier is reported only once for each function it
> appears in
> drivers/clocksource/timer-ti-dm-systimer.c:694:36: error: 'arm_timer'
> undeclared (first use in this function); did you mean 'add_timer'?
>   694 |         if (of_device_is_available(arm_timer)) {
>       |                                    ^~~~~~~~~
>       |                                    add_timer
> cc1: some warnings being treated as errors
> 

The __free() macro is defined in include/linux/cleanup.h, and that
header does not exist in v5.15. It was introduced with v6.1, and older
kernels can't profit from it.

That means that this patch does not apply in its current form for v5.15.
If someone wants to backport it, calls to of_node_put() have to be added
to the early returns.

Best regards,
Javier Carrasco


