Return-Path: <stable+bounces-81246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDDD992927
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBD71C22E07
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FF61B85F5;
	Mon,  7 Oct 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xCmzBC/d"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39421B85CA
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296752; cv=none; b=OwgAI3yXvzYtZbE+gK84TaRh5Htqs/u5iW3qtaa3gzGC7KYPgE62+BGjyA03aIJ7Fko6Ib+smGM1ydgspBLSwezvqfyeYfTS+hWyTyKyn/7x+HB+/KufNaReWFFCyl11oD7Tzs5uvN0kxKhRsOhBYWYsX037q/CtDxVhQkf4x+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296752; c=relaxed/simple;
	bh=KMvUNyTATbdVfIldS1AebWbXq6+gazugkjCVLIYZIsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0UrtY4dJZG3YkKo5J1M4gskwz39BParvfXbumQm01XAfKva2WNi4jmK/sWr1C/MVFwhaodCByB4zmiCYpomGZIgc9BtCwybLvksSzjUR4adW3Or4IRNCkbWPorcrgyX4ZoQZbQV48nWVUNNoIwuL9tkGY02ezURhM1tmxi3ucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xCmzBC/d; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fad0f66d49so62430171fa.3
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 03:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728296749; x=1728901549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tq4Mh1/pERBmTxuuNnLyUAvp7YHaFtdyt/qPZp7mNMc=;
        b=xCmzBC/diZ4CXoZCeGyPe5DFjaC6fgHtdY+ghu5yNzbyrq/dA3jfMwT1VeT6Yrwn+Q
         AVErs/flE785iQcLeD6bhLIjt2QqLcdcir4cZSq38RqPUipn+HQ520o2PNGjMEJQf31l
         6kr98SkQmhfd5c/+9KENbKhTJh2pAauI+hdhhVLmBfBA/RPuA6NhAz5nS674FR7gAYks
         hHayTO5L/sPUoLSwawcCdm8jnh/lLHZgC+4UUPm4EwVr+XEpj6qWk0HZh8Kf1k1ZSWvb
         OOC91U8IHBr9AbkmEUtI+0PIfP2qU2jBYPVD0x3V1T5H28LRgYxQfGBOd6iUU3t8IQcK
         hn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296749; x=1728901549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tq4Mh1/pERBmTxuuNnLyUAvp7YHaFtdyt/qPZp7mNMc=;
        b=Jro0sTMeNZVwnlcoPPUNkwNH4IncEBl4HR7woTJZ5RqbOO+8IHov840JS1KZ8f78ux
         BunEbmcUAU+RonbI/OWaeKRAYWeuba/5EjasAozYnAYHAaRjpNMeM73FACoyAGd/e3yv
         +Fhv+3U9ve0XBkULA2JwuMeek6RuZF3BMJ8d+FBhChkW/HiCQLU5sUDtKodgLo+Z2Jzg
         650XZxHdezmDMZ1LOUzpE/WTcVy1yPjXkCVH11jYqaf3y9Nm7Vb/kqlgO04Kn2ioMFbk
         hmZZ8OqT51/WSlKGry+lI209H+Z+a7LBUR/5VJ9xYbC/El8qu/mxsA8E/QW61d6W9RqC
         XahA==
X-Forwarded-Encrypted: i=1; AJvYcCUYNxGJHooxi15+GGv4ghdFlFdI1KountgdjUiikt8ut95INa2zrvf/rFOhormvtroWDQikXhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ZIrKERp/w6QzX2u4ftKLMazwO4CR374bS/pEIFclFjL1SMWA
	42/jyophS7MM0zWHsR22E80c859/B7ZWpz8A3t3o/2sTHsRUl/KfOSkg3ThGfRN1VxAlG7PjCqB
	qENFtXqvA2o8WXrLjDHe3CLDMIle/JXvUPUW13Q==
X-Google-Smtp-Source: AGHT+IGHK5m0lHQ9EY3lI1Ifuto3R7Qpi2V9xbBas8nUaP3hexdv7yue5PupjkQ8KMbRjRKMFmQZZ/ci60VJuVAXnXQ=
X-Received: by 2002:a05:651c:1548:b0:2fa:cf40:7335 with SMTP id
 38308e7fff4ca-2faf3c28d38mr49821001fa.19.1728296748894; Mon, 07 Oct 2024
 03:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZwNwXF2MqPpHvzqW@liu>
In-Reply-To: <ZwNwXF2MqPpHvzqW@liu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 7 Oct 2024 12:25:38 +0200
Message-ID: <CACRpkdZwmjerZSL+Qxc1_M3ywGPRJAYJCFX7_dfEknDiKtuP8w@mail.gmail.com>
Subject: Re: [PATCH] ARM/mm: Fix stack recursion caused by KASAN
To: Melon Liu <melon1335@163.com>
Cc: linux@armlinux.org.uk, lecopzer.chen@mediatek.com, 
	linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 7:25=E2=80=AFAM Melon Liu <melon1335@163.com> wrote:

> When accessing the KASAN shadow area corresponding to the task stack
> which is in vmalloc space, the stack recursion would occur if the area`s
> page tables are unpopulated.
>
> Calltrace:
>  ...
>  __dabt_svc+0x4c/0x80
>  __asan_load4+0x30/0x88
>  do_translation_fault+0x2c/0x110
>  do_DataAbort+0x4c/0xec
>  __dabt_svc+0x4c/0x80
>  __asan_load4+0x30/0x88
>  do_translation_fault+0x2c/0x110
>  do_DataAbort+0x4c/0xec
>  __dabt_svc+0x4c/0x80
>  sched_setscheduler_nocheck+0x60/0x158
>  kthread+0xec/0x198
>  ret_from_fork+0x14/0x28
>
> Fixes: 565cbaad83d ("ARM: 9202/1: kasan: support CONFIG_KASAN_VMALLOC")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Melon Liu <melon1335@163.org>

Patch looks correct to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Can you put the patch into Russell's patch tracker after some
time for review, if no issues are found, please?

Yours,
Linus Walleij

