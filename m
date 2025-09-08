Return-Path: <stable+bounces-178907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1520EB48E86
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 15:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205861888E81
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 13:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0923054ED;
	Mon,  8 Sep 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuIsOTaI"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D16307484
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336659; cv=none; b=k2hnJahMHnoQsfy52fAuuNYU+BjL90c4xu3cabxSK3LET2YqfAXd6wymnxkIIvGe/ZOz1l6ecLFIgbD27LLR9H2x36gK76inVZIvTKnWxXVcTw56+pjwdlqdSpJsn8XGGfoKbxyGcRgmnCQUuXTebIXQRAcXbeyUdt4s2GhaIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336659; c=relaxed/simple;
	bh=cbZwiukwDnHDrFq3wQYLcIHXlTy3luajkiLNTJ9nWiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddxawkWRMh05pQ9KbhwNz8qWcx+4fY6orb2vf/1hNfSJc/2ba0VMibgg1Wi2NDmaWJYfQDqoJPWAKBJ7cIvw3qk7kF6qXgAwufK8ndOcNsmyZ0UARBKfikMZyfLYat3kck4Zf1Kac9EjeaCxC9RCFVTV3yw1gBti8gE6IDGZLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MuIsOTaI; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5608b619cd8so5162684e87.2
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757336655; x=1757941455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbZwiukwDnHDrFq3wQYLcIHXlTy3luajkiLNTJ9nWiM=;
        b=MuIsOTaIbDk/Ne+m0B/pMslwiNeAYtXtApwjwNMtoj7EeRIGhnv9kWDsPBtIALLZN3
         1U/spYWmvDSR+I0JF7ztWFbre74L11tS6ht7cPlKITrJgpYZ/MgQdA+SWUmlMPoQODMy
         i4WEzp2bWtdzNaH5TIuL6NgDEHNlFpjdvHEdji+PtwJaol+7LOexLI6zorNvwmV5YcnR
         B0z6T8sYtbOJy4MBe8VCOIy5xAZ82Vs1GU8B1g+j7nptIB39uzvBNpVYV9DTn71ZOZGh
         OtXzumWQ/sTKg8rfWCIdQHHvzIoMI9xjToxUx7WSJEHrtzim5425JTlxGAC3hZIELFyw
         NT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336655; x=1757941455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbZwiukwDnHDrFq3wQYLcIHXlTy3luajkiLNTJ9nWiM=;
        b=nC4TzuOt4RWXlGZqs7ibSGNOI3oXtcAOVx/+abJc8iB/AkNhHFSSS1viSvb7h/PTTv
         ONNhHqhDQQhAAzt8fpz638pML+kWQnWuD8IR8vv8DgKV7Vd3fvR2JPzybwp+b/B7rjTs
         bsfXfXwwtFw0lf+Rkn641NIZ7wnfqsXrW4ZXuXQs9KNrszL2YEMHDuUm7N5H9IJH980t
         bYtxCaOn2VoMg4VllHrwsg/A7M/4NeroFJxFvTZSGrHW1wPms1F4ECL4SJt1SpYa9TCK
         x48bKgjpH+0so7wXB0fX9wkJizwyH4H99co4ySLS46k5WWKdKQPbfIpoHav6B4XgnnyM
         rUag==
X-Forwarded-Encrypted: i=1; AJvYcCVB6zB/0MpEsvoBlb4at9mW3KStS2lK4KLaWaHWi1N2xbx1wA8C0TzcF+3Ka83uxXmPICnD1Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/SvBhZ+i/ss8lACCsq237wZarhtkJ8ITSnTCxnsmxp0sTf6K
	1CeaPTpqKkJgdaP4aEsbY2Mbenj3JDsxlWVPXc5SMN3MuhN3k1w4C6jbJZKkkdPy9Tmy9iQ2kyT
	cWUiweV9b+y/5AmO+m5iAfyGqWSYNPZorSkYDLreRKg==
X-Gm-Gg: ASbGnctnvJSxPTGhJnTvk5Q6JTtB1c+CnzIk1l5Z4X4iPO/TWzoBZ/KWWnVuYyVZOZ1
	ylsua8VlIgT7Yf23wL1oxYzFmiifKFELbi6Ng+bHkugG5KZjeUBnMx1N2qSI9dhsDVluWTG35hS
	V1DzzeW4Z7FbMTEprtVXKW83/rkcNzDRTDZ/DoVmdJNC+r0EWIArPzUL/GlKaQVurnnM1Gk3Q2e
	y40LHw=
X-Google-Smtp-Source: AGHT+IGg4rogX0hb8M3wkRrCGyxcIS8n1x/nra5mMODdrlIDHhbHVFLHqNZGqHHGv1GU+9Sji/glMKNv4ydxz2WaN08=
X-Received: by 2002:a2e:a78a:0:b0:32c:a097:4140 with SMTP id
 38308e7fff4ca-33b485c2616mr21948241fa.0.1757336655209; Mon, 08 Sep 2025
 06:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908113723.31559-1-ansuelsmth@gmail.com>
In-Reply-To: <20250908113723.31559-1-ansuelsmth@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 8 Sep 2025 15:04:04 +0200
X-Gm-Features: Ac12FXyaXKE0nskg1RjYMc8Puf3_DYZA9QjaZBlexnTSmjTh-Rk2P6swvJ94zgM
Message-ID: <CACRpkdYYYAeqZZg58-2De-gfJkovYxABssuRk4xrS5SAC5=YQg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: airoha: fix wrong MDIO function bitmaks
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:37=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:

> With further testing with an attached Aeonsemi it was discovered that
> the pinctrl MDIO function applied the wrong bitmask. The error was
> probably caused by the confusing documentation related to these bits.
>
> Inspecting what the bootloader actually configure, the SGMII_MDIO_MODE
> is never actually set but instead it's set force enable to the 2 GPIO
> (gpio 1-2) for MDC and MDIO pin.
>
> Applying this configuration permits correct functionality of any
> externally attached PHY.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c8ace2d0725 ("pinctrl: airoha: Add support for EN7581 SoC")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Patch applied, recorded Benjamins response as Acked-by.

Yours,
Linus Walleij

