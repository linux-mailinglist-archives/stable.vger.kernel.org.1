Return-Path: <stable+bounces-88201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FEC9B111A
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 23:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CE51C2111F
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 21:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A41C18BB90;
	Fri, 25 Oct 2024 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iBA5Cbws"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4A217F26
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889849; cv=none; b=KVepQEbe0STAmTJGdZqJsNyCkGw1Re4aA1K9NYF25y2iOzSQxJ8bsjG+TFbKYP3onp2gYxbILOBYnuMemKyXwnm8U5vUpnDB6dz4NBP1b+lvNKnour1SxjW6axJeHRWKnkNA1YlslWV6E4/mTA1jmlUYXIPmC+I4B92SO7uX0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889849; c=relaxed/simple;
	bh=hNPFlVbZVA/OKJ3932WwecR37g7+EI0egSRr36/qweM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0NXggAdjW3UazXWspbNzvz6AMfwYMEgrS2s1imwilKa1BaJhnfWLo2EOMHO1VbjvnwEIzu8fb70Luwup3P9/9gKxbh5c5oIeJqUyDnUqMsKJlfxyr6/an7U9AAEBHfOiK3hhN848y6X0WjfJclsLTfqZvrJB1ypgvajdyxF9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iBA5Cbws; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f2b95775so2888635e87.1
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 13:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729889845; x=1730494645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hNPFlVbZVA/OKJ3932WwecR37g7+EI0egSRr36/qweM=;
        b=iBA5Cbws3HSP6VVTVkLq+HffhQbSMtXqIVyTsQD79Dsu+pfVc/rP+NeA7WSjVruxXT
         jfN1457sg4PxRqLu/w5o+FpDGY8Ee+x+V5+iCxHglzTgUDqS8P55ssxzd4GMzOdZdnrR
         Zb9H1PvYGIfGoc7URDtyaCRor31R6KAbCJDS31i5eJNZM+Howg//vucpZa9Qa4drtCIY
         UQJ0LDdjNPTYXj3oaOaK/HKXJQCVhUG7WGt/rNAQIJA6f/im7hfcT8eXHlYifcNrGDKA
         HYFWVNOMIDF2JO/HnswT8Tb95wMJBkZGPXKPh/ur+oAvJAhQhxgAlE8kZSSbCjQNHiae
         /cgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729889845; x=1730494645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNPFlVbZVA/OKJ3932WwecR37g7+EI0egSRr36/qweM=;
        b=V0BdUnVE34Er7J6/QvTTQuO2k+WtRdY1wbWDjDzQQGcG2/KHDC6sV57iHgfZq8Yols
         e2d0zrW7Lwkl0l25wrjW5Q6FpNFALvQuMjO1Iy4o39pcQO4SkeT30NDHItB3eujtd0Jf
         UsnN9a4CodTUrlJMJU7BBwI7d3EWyD4jBq/ZiEXzVEqfBFxjO3s4KPuyAG4+JvL93MBp
         eI3ovxujTg8rWILswsU29uxTym589/yKKu41iaprPKyBu6VHRpWRejiTXl5Vozi1du+4
         Bq3EZOuVvx3XndbJ5hZHEmTfNySmbXWkKdO4U38j1SD/xNFodZ+qezsr4DhLzlKLICHH
         18rw==
X-Forwarded-Encrypted: i=1; AJvYcCXbqpNTzOI6CZVCO3zbuLxx6zI5LXCsRM8X08ibgSxKunfMYWn4RE2sn/DUVcNwg3B7lxLrWrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwywLvmc8Haw7Apht0UZX9Ryha6BTHWFUgM+MxKZrJ2SVNwbx/C
	6xHcO5FbRkqaRwhGjbniyS6Cg49foTLHmpP5e9asfoAiv6+tcYnu/eYqEoKlYmeBHADXhWOSc6R
	eR/OXUuxp4hTH9jqcZCNXFoCknJT72kvqiz5T1Q==
X-Google-Smtp-Source: AGHT+IGNM4TYAOHuoUTcKkN3riSvNQrGUI2BitGMjHxjJ9ZNHlb/Bci2C7h3R3BXPLmrz9pSyztWUOGUMtDmtzwbabk=
X-Received: by 2002:a05:6512:3da8:b0:535:6baa:8c5d with SMTP id
 2adb3069b0e04-53b348cbb72mr418498e87.20.1729889844751; Fri, 25 Oct 2024
 13:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-arm-kasan-vmalloc-crash-v3-0-d2a34cd5b663@linaro.org>
 <20241017-arm-kasan-vmalloc-crash-v3-1-d2a34cd5b663@linaro.org>
 <69f71ac8-4ba6-46ed-b2ab-e575dcada47b@foss.st.com> <CACRpkdYvgZj1R4gAmzFhf4GmFOxZXhpHVTOio+hVP52OBAJP0A@mail.gmail.com>
 <46336aba-e7dd-49dd-aa1c-c5f765006e3c@foss.st.com> <CACRpkdY2=qdY_0GA1gB03yHODPEvxum+4YBjzsXRVnhLaf++6Q@mail.gmail.com>
 <f3856158-10e6-4ee8-b4d5-b7f2fe6d1097@foss.st.com> <CACRpkdZa5x6NvUg0kU6F0+HaFhKhVswvK2WaaCSBx3-JCVFcag@mail.gmail.com>
In-Reply-To: <CACRpkdZa5x6NvUg0kU6F0+HaFhKhVswvK2WaaCSBx3-JCVFcag@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Oct 2024 22:57:12 +0200
Message-ID: <CACRpkdYtG3ObRCghte2D0UgeZxkOC6oEUg39uRs+Z0nXiPhUTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev <kasan-dev@googlegroups.com>, Russell King <linux@armlinux.org.uk>, 
	Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[Me]
> What happens if you just
>
> git checkout b6506981f880^
>
> And build and boot that? It's just running the commit right before the
> unwinding patch.

Another thing you can test is to disable vmap:ed stacks and see
what happens. (General architecture-dependent options uncheck
"Use a virtually-mapped stack".)

Yours,
Linus Walleij

