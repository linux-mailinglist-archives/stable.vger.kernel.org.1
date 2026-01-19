Return-Path: <stable+bounces-210320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B824AD3A70A
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07B0F3008764
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729AD313E19;
	Mon, 19 Jan 2026 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="08s0qwhh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E2314B63
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768822701; cv=none; b=kuIy4w0L/aOwo9RwmEm31hYDjTV88G16/udIOhiTC6SIZjWwcC3f7rZrambHbGcIvdFnJTZDOtzWoU/JPq36j942xju1E8qTLXBasT2O7c3IwMqAo7/xgJzEn7qqkOw5Z9IIIgcqRfL5VEmXOSWhwo7h322RpHb0vCxUP5m8HkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768822701; c=relaxed/simple;
	bh=Ps2KphrNYk9+A9Jf0Rcug5o0OSTW6xQX/ux0v/l9IO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p39QS0OOPJ5TX0KoXF2TsLmvRL434VSNdV6Qt7Rpa1jqbtMf0z17y8s64aIBVDp5gLHyT1Vr2XQsni2wlH1xxHErwXF3kiZkb7c8cyFw3m56CQEhMZWTLVQew3ZtCoLv0JyBCc/t68BQ9qoZkPPv55JVIBuZhPXZP3+eB2DRexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=08s0qwhh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8707005183so702311966b.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1768822698; x=1769427498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YDsjal1GbbeJ/GHIkZdKBs/Za2CZbIezJM0l1CRzjuE=;
        b=08s0qwhhkF5PEn4VljUl4Z6yjzvsLSuz8Ok3h3aD/odWVbwnPhugW+Qxtub86j2ADz
         +uHZoOq50v6lkYdyOfYtMy2zwC6nuXWMrBNODgbPkDwf9H8gZdjWxT9Crp6Z4oNdBB/R
         JeajCd3/WHiUoM/9g3JNh/EgJG1JD58yCOHBerSHHoL84AEQcDOPzckBIu7F64JdLmQl
         IIRIIHxe59vI9uQo6KOhFnoGt3xJNA3d7WUztXuNH/rOrLkH0GdUf7vUBR993LE+xKGV
         bkYXUFJ+3kqAuLemYC+8WX4Qaobml3c/wc5u5lbHDAiBMuoqWnXz52D6Gt8RNCGK8+ZA
         RzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768822698; x=1769427498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDsjal1GbbeJ/GHIkZdKBs/Za2CZbIezJM0l1CRzjuE=;
        b=JPPTede2SK35LipldlR0Q6C35d6p27b1mjo5gVn5/TwqqWvPEZxuLhgq4CK7jw9988
         LxtY54JlipEytjPK86GhY7RqxXcDJ130aNCmUvbVRB6NRKt+7gSRRJ/uhUB7V9QVIB0Z
         qBYg6GZil0I9GZYBAn3rVweICbYCeOPquHXiSe0+HumnWaTHB5nwj5oCYexk3v1KLU10
         cE+TWy8EfmknKHjpgjcYX5T/e9IUgC66Tg1vOmPQWuZK9M9RestCEtMpmYP05FF4t01w
         9K7e1hahtC1+guP3q0MO7PQaqzcuOVtjBHh9fHxRPJHlQ23ELa7G2zEI0lHkPpWUWD4p
         jQqA==
X-Gm-Message-State: AOJu0YwyTjAtP5jMoy9Scvs5h0XtdjELd4j4WJyaN399a+ksKFbdmQx3
	ZOZRIB5CClgxSdPpY9eq0vDxHBR47aijzZ8DmrGUEM3k9/fxXPuDxaDzjjbzRuQyQEpMFsklQcO
	FVMZqMlmq6UG7tg/7WxMo2rFm7ynBGYvrgXmucJTWAQ==
X-Gm-Gg: AY/fxX74vsMWYt7Q6v3K+5eOB3SMjANxAHekW0c18B6YlDxyQpO5kMpasREIlJozuRa
	XYWj++Ufk2tqWkEqsY7pKWMcziGdvBEYFq/5MW1JgPDVvTvUgjSGKFd0GkZ0FdKm2OflVJOqi4K
	beLhZjO4yTk3MZg3sPLgDkuyLmZHlC4UZ+n7hdWzXcu9EFwkOrmHoMtD+4ZmXrHUB9JH6+PtEta
	OEkgBrx64SbBa9umvMF9OILVcTOrLsLeSj+DSmpgCx4IrfM/CvCQ+yTkUZX0lEEAxuJC5owrA==
X-Received: by 2002:a17:907:26c9:b0:b80:3fb7:f3a8 with SMTP id
 a640c23a62f3a-b87932eb1b6mr1012155066b.63.1768822698042; Mon, 19 Jan 2026
 03:38:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164230.864985076@linuxfoundation.org>
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Mon, 19 Jan 2026 17:07:41 +0530
X-Gm-Features: AZwV_QimJIeBfXB2Nyk88e2LVRiaArtEmEljGQEZ2MlIKUhFVpaSmDSUh5uHBwo
Message-ID: <CAG=yYwndSL66QOUV7cC_EAVjj3hW+d_KBiv9_xqVaLD5AKuAvw@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/451] 5.10.248-rc1 review
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

Compiled and booted   5.10.248-rc1+

dmesg -l err shows:
[   10.672706] snd_pci_acp3x 0000:04:00.5: Invalid ACP audio mode : 1

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

