Return-Path: <stable+bounces-210284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29139D3A252
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C37EF3018975
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A38433C1BD;
	Mon, 19 Jan 2026 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="jYUc7RSK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794CF29BD95
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813358; cv=none; b=QmqG8XYtsNKrT32jrfylkhnMUEthsi9G0d84v4oi/rNzFGNufQZs8Ck3bq5JkGfEQNR4sQ7CFW+3VKxZPB6tUgIIiwebJQpF24PC3VYyZJAgoXGY4Tlfg8db17U7veYGyU+xxnUJNDTH8icELfI/RR0D5SNxtfaEuTkMuZH2tIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813358; c=relaxed/simple;
	bh=D/qymOUiKrDRNHdcVSuc2YdoB3yDp9DNMPd5KyFHae4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQfefkEmbTG2oEBCUHpeuHr2pg4OZpm59UHm4sE9aTU5JUtJMHD80pU6lI6abMqNkETWsVr94/4Q2pb1BdpoiY3yCkVjJr+Vw1DfRt1o0mNCpxOq7+KrjfgFUSsk0RT+F2We+bSZHJEB5+iKJ0SnpxFZeAk519kGhRdMNU8wH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=jYUc7RSK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8710c9cddbso496862366b.2
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1768813356; x=1769418156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7wetYJgFN/oe6JyYcEwXdk9ol2wsti2uzuGgOiTbKZU=;
        b=jYUc7RSKCTg1JodHYy2VBjNaPPyrF1aEpIRp8avZYxKNvK+2fD+D6ZTs33DKBUQupv
         A5QA9QRbidF01Vd6SId5Ctel+IXioniIWZw0V7PgJrIGKcuB9Zn1ETyK1+V19OvzGAHj
         qTrJCNdQttQJOFlXK7gGQggOus2b0lEnTKSLzxXYxHAWBxtFC3DI10cHsmSn//B3LFEj
         FLokzPZjw5OLLZGYXk1Ym5HleapojR+m6X6hhwqyBBcLRASk+izywo4dxGXj/Ygn53Cp
         tLnioUiyNAda+x0mqvrhBgVS0WW1ZIiZwm1MRm73elUwKM73yepd/8oiO1evGVzliPD/
         RvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768813356; x=1769418156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wetYJgFN/oe6JyYcEwXdk9ol2wsti2uzuGgOiTbKZU=;
        b=OA7lQuDJeS3JcGTB/0B80pO8BbWWScKaKV6QKCSjyI15f/uPamHAqFoItBrvAgG8oq
         eYa2LRApshQ737rb6l7UQympAKtEG+j/GXxvy0EGkGhJFnv8rGOEVhjPcZh6T2wRQUkh
         CkpYYhrVQ2ODdIbcbT1TPB23G84rtOq2+bKdR/f1B2EPcCeaK7nYUZ7+J+i/pVPynqqL
         +Qoqra8WFm+bLtsEw/VKBDRHH5wG+Eue0Hp+JWAGkmj34vEVsX/yhc5w/W8qr1ahtGcx
         mZz5aCWfxEgVpU1AI+dNGlvCV1HekqPsl/Kmlrf+b/1onz+KLejrcWU2Ee2Trmav1yyN
         zQXQ==
X-Gm-Message-State: AOJu0YzN/Jg7qIpCHJWqbcXVj3jBydkaUmGbWfkACskC29BcYaalILYr
	fpnTlrLLLsujxfbbHpCk9YI3BGWkMFKeIw7oq5DBTM+7x2Oq6RU24sC/FDPDCRp10K0XGvwpHXQ
	HhfVJs57Rl8MsjVxeMefo5k4L9MdxAa8x5pOtIBUTwA==
X-Gm-Gg: AY/fxX41pc+D7N8vFYnI1rrfZvlMs+HlGHmj2kC4AjFACeC+QpoSrrBNtzEu51W6tyl
	GuB/AVjPDbQP1Y24oaQd5gdd//OIpMe+64dVdeG+VNb+U5Xk5QYXIIN3OSWOjoPtmOSyLYUE2VI
	3hgp0YHv+D/33R5yYJOhhFtvNrO6cr5Sg0S4oqmO5T/0TZlcuGwnfJZ7GDbs7PhLU9tdg7pUP2P
	eAOV3JMjGG0PnCt6tZn61fvj917yOtyC38cF+JvE6DNHXsDxaAUn45oHAFWuEGsfOdfrVm45w==
X-Received: by 2002:a17:907:3d16:b0:b87:2675:9e97 with SMTP id
 a640c23a62f3a-b8796afd684mr820214066b.35.1768813355548; Mon, 19 Jan 2026
 01:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164202.305475649@linuxfoundation.org>
In-Reply-To: <20260115164202.305475649@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Mon, 19 Jan 2026 14:31:59 +0530
X-Gm-Features: AZwV_QicdP5-7gzgqt8EDbBW67zD4lwsJGeTHQGwZRUxy96WyDyOfzMqSVVGPqk
Message-ID: <CAG=yYwkFhDZaFibqHJ1MMnKSbJ8124ZuHUB9FXjVFVyeTJeR=w@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/181] 6.18.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

hello

Compiled and booted  6.18.6-rc1+

No  typical new regressions   from dmesg.

As per dmidecode command.
Version: AMD Ryzen 3 3250U with Radeon Graphics

Processor Information
        Socket Designation: FP5
        Type: Central Processor
        Family: Zen
        Manufacturer: Advanced Micro Devices, Inc.
        ID: 81 0F 81 00 FF FB 8B 17
        Signature: Family 23, Model 24, Stepping 1

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

