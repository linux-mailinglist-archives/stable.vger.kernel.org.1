Return-Path: <stable+bounces-188304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD3ABF4E56
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 09:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1353A3169
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 07:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E99279792;
	Tue, 21 Oct 2025 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kepdiKbI"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE142116E9
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030968; cv=none; b=B2jwCZRMG8xVowuxxORvTdT/ORnJXMb/2SIn3QZEey9l1t4GB1DcWcShF5OYJcZ0M0Y84vR7MgKNGG4igcl976bSZTv5NB1DL3Cg8RVfmLSuywJvd3Ox2CSZ35VyDOr520QUXHIKs/lhvbbi4aXKxao8s7X9Kpg33VBELzuCCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030968; c=relaxed/simple;
	bh=rQWEzVQ2sP3X3UgfzW4ijWcMIC5eMV3255ZFLSUlASw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWUt13+SOXsx8mspBtIFXbbmy+wSmsHpRk8YFhV+J4UbXDHsu6P2izoK+8jPCYJxtovg/R3e4b8Q1k2vD3qLLCUCRD4gYRDol0niKc8l6H5WCJzvJE5+pEcUlabXVCoiKsKKe93Et99kIBgEOQqP5TWdHlHIFyEU9L+FRiFKpu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kepdiKbI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59093864727so6150096e87.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 00:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761030963; x=1761635763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQWEzVQ2sP3X3UgfzW4ijWcMIC5eMV3255ZFLSUlASw=;
        b=kepdiKbI8ekSPamszj/hk5m50ouOSGP/DCVQg/X3cA+s1hgBv13VzJHI7U3lGsbdPH
         JgYcAOEubkUzjVUj6eiTNqHBeY5oEOaF/+myZlfTs3are917vPVR/CLnu8FWVMRsp2N9
         sKRUw4H0CgJd2J2r6gP8CPG6vHkUqfOv1xiI+Nb6QZTweh76tJ6PpkG580lDAaS6iS3/
         r4V/aLDfP6VprcNxZ3+/vj9rmKY1o/76j9Kx2fnpOFn2JoKKBHzHuGye8MbsdlFsbd1W
         qR3BJ2Vlxou7vB7qEPWrTRoMZp7DmIDe8ojEe2YiIA+hxPI9UjMGlEkl/r5ME+F8YYVH
         OpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761030963; x=1761635763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQWEzVQ2sP3X3UgfzW4ijWcMIC5eMV3255ZFLSUlASw=;
        b=koxkATLEUpYPIO+oq1qNlrI7QhHGbZZi+R14nWMRkXFWGKRIY61JU/i3PzDkD3kIjg
         9u14BO/rwPFKVkUYk34zhzUH4zxQuNUumCp2rt5WaDdHgKm/lS7aUg6ddL4ehCDiikUj
         3F6JH/yw1gRgqnAmOudxHhccXbFGt18bIvNM/kjf+37X5CDg9L9WgxfJP8OGdTAyCThS
         bRNpjrai/+0jX37vrCUcqi6n3WdBO7oEn362Hj4/CDgJAsc3C9o33dxrsCkmGPc69uGc
         4EBpcw6kKC66TBDoqFpMQ30280DCtT0u6mFBPtmnfaRzWxDMXJfr49WDkHyEIHHMCS1G
         yWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVVq5EreNIdrbld62od3bDJqbGVUAcnXRsC0ystHZJHBVTDSOv/bOHyQKi0Ej3SmxtHh/g2U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLiqzvBSutU4JCInGWVSO1RhTsBIehowlV6X8aV5Thj4Z5SWJh
	drF2TWrySzKH5k8vY4i9Lp/DVlgvXc8Gy8GrAWxf1B2PA/bs2OqJDck4D1sG6ZkgOAG/M2oeQOd
	NWiu+JZ4PhbVxvkUo1MRgUIkcYv1Bvkegf3LtXG8p0Q==
X-Gm-Gg: ASbGnctM1zRDIp7DvkfJ+Xqrvg+gs81t4iFc0Npxy8q04EE71aG5+yhGJ8THojnm6C5
	rWC5l6gl2/7Mis+fEx1+6JdqTTrmUxwe2ehIPPqrCNuO/REAPsSn8csKDWaEh12gqbJHMQmxGK4
	uQX7E2rQyi4InYZs7c8uHxprbALcd1nY3GPNM88EKQa2hBtwSj3rYb7ymicc2ENUm4U9Zmsma2G
	UeByvkGKOU+mWR0MDJiNmXV1n+I2U18sT9hH9folGNQpvdjbQ8F9Bw9UbVm
X-Google-Smtp-Source: AGHT+IGzyDckrbb1KeiI9VS9GysBs3j9cjfg3lRF18ScYzfeA7CZmuQgIKBi5NB2RI/U9eWthIdLrHA/CXD4tCAv970=
X-Received: by 2002:a05:651c:19aa:b0:377:78cd:e8f0 with SMTP id
 38308e7fff4ca-37797abc759mr50103031fa.45.1761030963322; Tue, 21 Oct 2025
 00:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-fix-gpio-idio-16-regmap-v2-0-ebeb50e93c33@kernel.org>
In-Reply-To: <20251020-fix-gpio-idio-16-regmap-v2-0-ebeb50e93c33@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 21 Oct 2025 09:15:50 +0200
X-Gm-Features: AS18NWA5wVKiKD-IlLzPjovWaTZwReIiIH_ziKmQoyWOfM6XDCDv0q_UbsE4rDA
Message-ID: <CACRpkdZyyjLjnfqT7Vq8VvzP7bbT+b1s0y142ODEhiK-thButw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpio: idio-16: Fix regmap initialization errors
To: William Breathitt Gray <wbg@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:52=E2=80=AFAM William Breathitt Gray <wbg@kernel=
.org> wrote:

> The migration of IDIO-16 GPIO drivers to the regmap API resulted in some
> regressions to the gpio-104-idio-16, gpio-pci-idio-16, and gpio-idio-16
> modules. Specifically, the 104-idio-16 and pci-idio-16 GPIO drivers
> utilize regmap caching and thus must set max_register for their
> regmap_config, while gpio-idio-16 requires fixed_direction_output to
> represent the fixed direction of the IDIO-16 GPIO lines. Fixes for these
> regressions are provided by this series.
>
> Link: https://lore.kernel.org/r/cover.1680618405.git.william.gray@linaro.=
org
> Closes: https://lore.kernel.org/r/9b0375fd-235f-4ee1-a7fa-daca296ef6bf@nu=
tanix.com
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

