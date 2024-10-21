Return-Path: <stable+bounces-87024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4077A9A5E69
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2CF2814BB
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 08:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADD91E04AB;
	Mon, 21 Oct 2024 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjv0kPqO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9A31A60
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498689; cv=none; b=FJddzL8EH13yFd2Fk8ax3DU4qb/bBAkJ8Em+y07KoYxP7RDjiS09sQuYpl2gpzBu27cTGByX+rry5FEnvYeX9RBko0zA96oWuUh7fdAnz+7qje07mhsOqZ6Hlv1B0VlBsMie9r4S9hyAiCrB/ZHp7gFEezrk6kwz3cB3fCg2QAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498689; c=relaxed/simple;
	bh=eoi9k7Ygt7ktavMqWKGD7qsQYEk2fiEFaSEeoaagxAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5Lc7rYW4ENGrQ+yqr/icSHpKyXXiw9r9Atdv76IK8Bem3se3WSJwc5QLjI9PxBPz5G/gAhVVb4XpuCo80e+OTDfScBP9jB0PgH4uG6tjRUiDFqgCSezMVE/CWPt1RrafdhZjBbZAXyAmgT2msRKQrEAAbnCACcpl/NGAaqcQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mjv0kPqO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso32126441fa.1
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729498686; x=1730103486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoi9k7Ygt7ktavMqWKGD7qsQYEk2fiEFaSEeoaagxAI=;
        b=mjv0kPqOlihYOAuGMDtdY/Lmnwo8342NFaiw0baYukuQsoU4Roz3oP78dwoYrutaje
         Y7do0ksCS/3YnztG80W3zkxrbOpC65TbmPUJaWINx/Z08Lb8dd5hFD89ECxU86rcIZAQ
         Sl0PRBJqhGqYP0Bn/NbWipryuXeIL7AzUzQhjj09IDIeRE8Z/KlEXqT5U97hWq/iEBZD
         DvXOEBGvkI8Bxa3jNddCwH5GfK10+3o3m2N4bIWp9GA+PBVEZTdVyALmBpDm0kXnDSvb
         dOUYF0sTnNLst8gmo6/umubuz3GJ1If5E7OvhjwU3oRozrJV/cVi/nhhDwOAzvRO8SIk
         iEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498686; x=1730103486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoi9k7Ygt7ktavMqWKGD7qsQYEk2fiEFaSEeoaagxAI=;
        b=vFC2Su7cbQBQ+yo6vMQzJzbUpuPBYFux0c6vvG3//QtFRStk7oBiHfHd891RoaqYpd
         Gkf2idd2IGC17hJ7v1h1wAjxE773yZnM1UlcnxiU4OouIOkJsZCWKHxCUu8KXFzMa/qm
         ptWIsPy2lAgy1pAmF2A+hpgrROk95flL5xEQkHWZpvexRzxJ0NSJcDNLln8Cu1tRiupB
         x7keYu/OBamXWVp1HRzCnP9Kj2FtA3YYmT+tMFjyMhlpG3za6NsNYPFBwWzEdzR7r5FY
         LEI5TlxleYbQs9DeXunU3EGvcPKLeMokHQWQipuZPmzx7aD1yAC2jUkL5pyMCP6Ilg0p
         F7sA==
X-Forwarded-Encrypted: i=1; AJvYcCUlovmtfJ1lNRL6aurwEJgT8n2WmZJ0qXAFSObaoOsnUW/fFvKZgWnDHRjMfTh6PK1yThlZ9k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCN21h7Shhqd9DwvpdDqbMCIZaBesq2evqFnaEKKOLStjLn55y
	AfPU5TjH6DMXBvANxQUTijSl7zeKrThaneadaHWj7pVO0CUFUqBSi1l2S0m3IMKpHIIyDqPJXOC
	zibJZWxlwDItHEARRmILoj7EgbwMoWVM9Ja2xVw==
X-Google-Smtp-Source: AGHT+IHqcu6/cs+18LQiPhDruAMJcQI78x11uXeyZZCo4iTRJVHXBAwnvIbkLUHZqP7mp8QjrS5VJe0fWAo0cI/9A4E=
X-Received: by 2002:a05:651c:1502:b0:2fb:593c:2bf2 with SMTP id
 38308e7fff4ca-2fb82e90cebmr38651181fa.3.1729498685512; Mon, 21 Oct 2024
 01:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-arm-kasan-vmalloc-crash-v2-0-0a52fd086eef@linaro.org> <20241016-arm-kasan-vmalloc-crash-v2-1-0a52fd086eef@linaro.org>
In-Reply-To: <20241016-arm-kasan-vmalloc-crash-v2-1-0a52fd086eef@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 Oct 2024 10:17:53 +0200
Message-ID: <CACRpkdY8pA_z6DSzOVUH+wRt2uDpWtD=ipkCs0aZyWgfZ7fyjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Melon Liu <melon1335@163.com>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 9:15=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> When sync:ing the VMALLOC area to other CPUs, make sure to also
> sync the KASAN shadow memory for the VMALLOC area, so that we
> don't get stale entries for the shadow memory in the top level PGD.
>
> Since we are now copying PGDs in two instances, create a helper
> function named memcpy_pgd() to do the actual copying, and
> create a helper to map the addresses of VMALLOC_START and
> VMALLOC_END into the corresponding shadow memory.
>
> Cc: stable@vger.kernel.org
> Fixes: 565cbaad83d8 ("ARM: 9202/1: kasan: support CONFIG_KASAN_VMALLOC")
> Link: https://lore.kernel.org/linux-arm-kernel/a1a1d062-f3a2-4d05-9836-3b=
098de9db6d@foss.st.com/
> Reported-by: Clement LE GOFFIC <clement.legoffic@foss.st.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

As it turns out in my confusion I have missed that the more or less identic=
al
patch with a different subject (talking about recursion) is already submitt=
ed
by Melon Liu and waiting in the patch tracker:
https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D9427/1

I've tested it and it solves the problem equally well.

I even reviewed that and didn't remember it...

I will submit patch 2/2 into the patch tracker and let Melon's
patch deal with this issue.

Yours,
Linus Walleij

