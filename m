Return-Path: <stable+bounces-35629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D146D895AA8
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 19:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B77287425
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 17:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF4014B06C;
	Tue,  2 Apr 2024 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maCNZLF9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B44915A490
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078862; cv=none; b=BL0qGPxPWViaeJMkv/WJH2eMfrDWk9evjxLi3m61YE+ImFYW4m/cZWN6lzbbd9L8WzqkjOgmZlm9emeq9eQDLTH3OAEn3TmfMAd/iC1dmThGUVhQivP9b7//BsW0WwLIMR/pPRyKpB5LJTf0qIt15Px80I/Pq/TLDxQW8ev2ixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078862; c=relaxed/simple;
	bh=C+KN2V9wpye3eVQp8A9k8wGfFywTWnLq6qVtUjdFm2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GSVs78LEWaE4jY2PGpTWG8ytg6BpMW0gfiNy4rg76dMSwVS73IkqW4V9ZS4/qdpugsvtHQAcvQSxZmQLAmZUdTGY5royjulJryCgp4dCwSoSaxx2HpPK2APIqiaM5gBqajep3OXV2ByljRHwwRvUJ5+MX2BWKr6SiieUFwbP5OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maCNZLF9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4a393b699fso17441966b.0
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 10:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712078859; x=1712683659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEHmyuJnTcLQOH/PKZK7H+N0e7ofu0PP36+q0+beXDY=;
        b=maCNZLF97aMlixiC704wvbuMv/ZqxN5Q+LwL+je9BklRd+5c6+4hevVCi+YCwWBAKQ
         FwRnjJWpJqOHSJ9KHXOVSsuO4BhH6uNRll1OJd0l9mk1eMa6k7XeyDkjHc3SFBecJLxU
         f9ebofbRncSEDXROw3riZiidTS7DRNmchLZ2vhx7A62nNJrNp/cOqYE8XoVyYCRwoJra
         4erRAAfaO88K7cDpBPppQe2Y/RogmO35StZrj+w9LjUSMcU0QhvZyhNn2KlrltioiIGC
         IYRmD3NAbA2aQr76AjlgQCB9YaPhqGcv5EeW7CWm1SjlG7F2U1JeW/sPz4YI9rQPWepn
         jDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712078859; x=1712683659;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEHmyuJnTcLQOH/PKZK7H+N0e7ofu0PP36+q0+beXDY=;
        b=osfWi98GOpDLvi40n7bIV8wu0Yw8c6+piphOAeGf1zHO+oJZQzzY5DTGvUmaX1ZbpI
         wJOE6jyttoQXPwPGaaDIED98dv7K4XgPGuitjixZDqQML4mBttIN1ewnlKL312SgOS4i
         FUar0cKsmN8/b6h1a6VOKjSSpdIKpnHM7IoZg2XJHq86jE2ogECUb8xAuOMppUze+Xup
         33rSc+0dUKOXoJaI6m5Smxqn7BYIu7YIRRao5lwNI3Fc1rBv6OJI01fsKKq1SmsmGQ4H
         16g11ryuECPSfHTImpGKe68zaBHT70a5kPXFBYnODsTT9my4dQ1rTJgdFd83N75GsQOF
         W6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWK6r/ikx52CcBfSkb6Z1CUd3/b6O5bGsLMzdKl1FX1qNvUHy6wgMVCDkJTxtQI/QYlx3AbV2L2/ZnXsPnCXDIDgswha5oS
X-Gm-Message-State: AOJu0Yz1xhA45GRyb2IGvB7bCmos7DEDXS3yZvZb3upaKVIRJDwkMXM4
	8tBjG5eBhuDFydxPCSoyYatTkzRxOF8BKzA4vqaViLAr+2L0hWs=
X-Google-Smtp-Source: AGHT+IGxLtnnZo/nwOFRpJkkD6C5Ad3DTeR5fuztUnmw36V5pRmDqe8TW8eDD2edsI+CnSSZXLCEWA==
X-Received: by 2002:a17:906:1388:b0:a4e:8992:2b9e with SMTP id f8-20020a170906138800b00a4e89922b9emr135535ejc.3.1712078859220;
        Tue, 02 Apr 2024 10:27:39 -0700 (PDT)
Received: from [194.171.31.163] ([194.171.31.163])
        by smtp.googlemail.com with ESMTPSA id e10-20020a1709061e8a00b00a4df061728fsm6740061ejj.83.2024.04.02.10.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 10:27:38 -0700 (PDT)
Message-ID: <ec06af0a-a8e4-4681-be7f-10dcfb5e70d1@gmail.com>
Date: Tue, 2 Apr 2024 19:27:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression : Latitude 5500 do not always go to true sleep mode
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 stable@vger.kernel.org
References: <1ee68691-9eb4-404a-adb4-fdaaf12c905d@gmail.com>
 <2a4a2d24-2c4d-47cc-bc1b-30c309c173e3@leemhuis.info>
From: =?UTF-8?Q?L=C3=A9o_COLISSON?= <leo.colisson@gmail.com>
In-Reply-To: <2a4a2d24-2c4d-47cc-bc1b-30c309c173e3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Thorsten,

Thanks a lot for your answer. I'd love to give a more precise bug 
report, but it's not so easy (see below), so my hope was that this would 
ring a bell to some devs here with a trivial fix to apply, especially as 
I see surprisingly many people with this issue (3 people reported 
similar regressions in my threads). Since it seems not to be the case, 
I'll try to bisect … But it might take quite some time as it is not so 
easy to do as I can't find:

1) a deterministic way to trigger the bug (sometimes it goes to sleep 
correctly, sometimes not) Even worse, I feel like some kernel versions 
are "less buggy", for instance, I tried 6.1 and I only experienced a 
single complete battery drop, and 2 drops of 20% (which never occurred 
before), while on 6.6, it was significantly more often in my (short) 
experience. But this might just be statistical bias.
2) a simple way to check if the bug occurred (waiting for my battery to 
drop is not really optimal)

I'll let you know if I have some progress…

Cheers,
Léo



On 29/03/2024 17:14, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 29.03.24 16:21, Léo COLISSON wrote:
>> Since I upgraded my system (from NixOs release
>> 2caf4ef5005ecc68141ecb4aac271079f7371c44, running linux 5.15.90, to
>> b8697e57f10292a6165a20f03d2f42920dfaf973, running linux 6.6.19), my
>> system started to experience a weird behavior : when closing the lid,
>> the system does not always go to a true sleep mode : when I restart it,
>> the battery is drained. Not sure what I can try here.
>>
>> You can find more information on my tries here, with some journalctl logs :
>>
>> - https://github.com/NixOS/nixpkgs/issues/299464
>>
>> -
>> https://discourse.nixos.org/t/since-upgrade-my-laptop-does-not-go-to-sleep-when-closing-the-lid/42243/2
> Thx for the report, but the sad reality is: I doubt that any kernel
> developer will look into the report unless you perform a bisection to
> find the change that causes the problem. That's because the report lacks
> details and this kind of problem can be caused by various areas of the
> kernels, so none of the developer will feel responsible to take a closer
> look. From a quick look into your log it seems you are also using
> out-of-tree drivers that taint the kernel, which is another reason why
> it's unlikely that anyone will take a closer look.
>
> For further details on reporting issues and mistakes many people make
> (and you might want to avoid in case you want to submit a improve
> report), see:
>
> https://docs.kernel.org/admin-guide/reporting-issues.html
> https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/
>
> Ciao, Thorsten

