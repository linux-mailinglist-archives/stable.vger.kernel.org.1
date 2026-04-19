Return-Path: <stable+bounces-238663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJoCGThE5WlHgQEAu9opvQ
	(envelope-from <stable+bounces-238663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 23:08:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B7425849
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 23:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D24CE301AA40
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 21:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA21B2F260F;
	Sun, 19 Apr 2026 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkB72OY8"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407562638BC
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776632882; cv=none; b=gDDTnJVwsC1LzbalIq4uxKtxP8G0h17hJ0TcI2qiOwpl2mFWuoI8s7LrpGjFWGxOg9yjmrsYgOWwKEI7/yS1GQ2LJic700nbpGoK6ycM72+N4x5WTryoF3kk9JBjybluV9OfrFO7rUl2QJxiyZ3GXkFcYnbMiGGeX8zxRDO0VaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776632882; c=relaxed/simple;
	bh=eG1K3OPJpxXLDQlKQ8rcmnhJ+HA4zvnmrY3kBdh0UFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QP2xV2U2urNJ3jkRQ9jfWZNjslBOYRMEy0ijkabBDvdCmEzzzV0USl60Fd7IrLHp6LIUQxOfyK4lTKeOZJJFPGOzBBmCZc7+UWf5X6+R69m96CfZKVE8WSiFIfLQ7fPaG1NqU2/lu6UXcVamRN9rq/zopji88ncnskPlv3hr4KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkB72OY8; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c726c30efso2044237c88.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776632880; x=1777237680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3M1MaUHGzn+cfnIYT0AwYFeLYCGE/VmNLUEv5pP3SyY=;
        b=OkB72OY8OoEbwkFniKz7kg3ygmNvUekNJTPiSrznhMP4JeA/wk3NVLT9p+A0A3OKkc
         bpSDqMinrKbQ2iZWuqBH0oexK6o+SomvsJxmhmzo/5znaZSG1sUvm1NikE26WKbonWD0
         6l0/bQHf7cIKLr/CP8j/LffvViuNXKJfJ0FXmiMbfwbmKkyNNmpolJyQVsNInH78QAs9
         +uolQ/yn4xMr+In77wb9ALLFkkZDRt/9/AGovLZlOXWjCX57SM0V5hl742Kjiv/b5Tgr
         DLChLJlrq2fGf99+4aCOuyiLXFWcRoiiPxcVj2V7vJLpIp7XOT8wUbzELoGZKo4UFgTK
         zUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776632880; x=1777237680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M1MaUHGzn+cfnIYT0AwYFeLYCGE/VmNLUEv5pP3SyY=;
        b=W47FMqphekNAfRzO4sLKjaonFRd3B22arE2Oo+SweVh6DevLRpr0K3xCvtAjxaEYU/
         Mnw7zIqVMFQJ8YBNo2fNDGmUiTXZec7qW1cLyuvD9tYT6q2uBO3DYxe0/giKw8kUE787
         Gu8+tibZ8OzSM3qKVp64YbI6nU1tB8zZi4ml7OQpUJdVP2o/Zm8Ts6tkYuAEIhsKHeMj
         24lPCIE375Im2xI9nmTwxgCH1bPV4q3kdvyDp9En40TfedRR3PVH2pwtMRYbQa3h0c0Q
         PS6KbFzuddKiXZLgY2qL7+7OMZtDNhGDAHYULr3lR7Hahhh/kGNfEix5y6p5ZnmIs3Xg
         O4gQ==
X-Forwarded-Encrypted: i=1; AFNElJ9H0rTh8h27v/0KGOEqut+pD4HZWD0u4fOeoX2d8xGfcM3sxSCZmU8FRz2o3mN77ErteOkGww8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLNMdHrJu6qrrWiUMnXlKHYdWaUz12OpeTB0bznSQIoPfgg6Z9
	uZjVlJ4Da0tznP62ATSxS+/44qHaTYB2YGN+ElCTn43TD0hagQpFGXRc
X-Gm-Gg: AeBDievHRgNSPm3Be1sWPJJoQRS0Kjz1iNikphcYbHlym8LKUdQnvWkXYG+Q1YTL1PT
	QRDpDrufgTQZ6z2J3PfInGFKcv1UY3muTMCsp/649OStHIOHjcYfIEY+Zj7e5QBfX+ZXSOlfkOE
	rg8Lxy4g2KdJ7O8Vq1FfGKC3P3JY8Woa14UMMuXEODfQxGMJX47lExpJCF+owWgAJdDvhLYQnDy
	wGoVR9G5RC75cLnNdVUfP/0y2XLyw7UH5WduhJsL7EHcl8lkUC3icvObJJ43CuqLMZGhHAGFfiZ
	vJbigz2n2nbvwMispkq3M/7/MdioqnTBn+RhSA9LD6nsx8LU2vtBAOB5zpjseOWD2wlPAaTH6Q5
	Jpg3bnn4KQcUBisKhhgG6jELpLOC5UeM5DdJJoQkVUrF/g00QRIimmwtY39URtF2ZtQMAkM0AjJ
	Pcfmkltr6PB6rs7IA0Ma8DEOdNCJuApFR/QuJxGcT9kCt9VymeFFb1hFQA5dkY+SwnEuqoGE0f8
	UfJysnl5xs=
X-Received: by 2002:a05:7022:4393:b0:12c:4928:e57e with SMTP id a92af1059eb24-12c73f920bdmr4395154c88.21.1776632880241;
        Sun, 19 Apr 2026 14:08:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e79c2954f6sm5288391eec.30.2026.04.19.14.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 14:07:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aa801626-2e33-489a-931f-600540fe4ae3@roeck-us.net>
Date: Sun, 19 Apr 2026 14:07:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: ixp4xx: fix reference leak on
 platform_device_register() failure
To: Linus Walleij <linusw@kernel.org>,
 Guangshuo Li <lgs201920130244@gmail.com>
Cc: Imre Kaloz <kaloz@openwrt.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260413154727.3051321-1-lgs201920130244@gmail.com>
 <CAD++jLnC5MGg1e_Suv6BD_=XKbsn1aLxHxRfCdD3Nos+2XRzfw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAD++jLnC5MGg1e_Suv6BD_=XKbsn1aLxHxRfCdD3Nos+2XRzfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-238663-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A65B7425849
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/19/26 13:22, Linus Walleij wrote:
> Hi Guangshuo,
> 
> thanks for your patch!
> 
> On Mon, Apr 13, 2026 at 5:47 PM Guangshuo Li <lgs201920130244@gmail.com> wrote:
> 
>> ixp4xx_timer_probe() directly returns the result of
>> platform_device_register(&ixp4xx_watchdog_device). When registration
>> fails, the embedded struct device in ixp4xx_watchdog_device has already
>> been initialized by device_initialize(), but the failure path does not
>> drop the device reference, leading to a reference leak.
> (...)
> 
>> -       return platform_device_register(&ixp4xx_watchdog_device);
>> +       ret = platform_device_register(&ixp4xx_watchdog_device);
>> +       if (ret)
>> +               platform_device_put(&ixp4xx_watchdog_device);
> 
> If the problem in the description is indeed there, it seems the bug
> is inside platform_device_register(), surely a function returning an
> error code is supposed to clean up any resources it takes before
> returning an error. It seems wrong to try to fix this in all the
> consumers.
> 

 From platform_device_register():

/**
  * platform_device_register - add a platform-level device
  * @pdev: platform device we're adding
  *
  * NOTE: _Never_ directly free @pdev after calling this function, even if it
  * returned an error! Always use platform_device_put() to give up the
  * reference initialised in this function instead.
  */

Not that any code actually does that as far as I can see, but isn't
the above doing exactly what the comment suggests ?

Thanks,
Guenter


