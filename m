Return-Path: <stable+bounces-86533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DFD9A11CF
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 20:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77D1287B53
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 18:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB792144BA;
	Wed, 16 Oct 2024 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLYchQED"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CD62144AD
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103927; cv=none; b=YfijeNCselt2jqQ2xTq25n7eq1h7wQxWkDUNpW5YOSoPbd40zDZPRQRyNBGcGQrBI8pnvNOdQyYBnrCDiEI9Dl0ymY8RbbjxV/PqHLZbvVToE9ozYg8EpyU8O1NrTZFtXLy+vz9meu8OJrqCRarAqehS1w+FEmvZgDiwBXkTlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103927; c=relaxed/simple;
	bh=CaXyLEeXI3tLmhlmHR8p7InKimN5ZtQoIcO+dVnX8ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBZRY5Xxib4LASlukM4HShEzCBmQlIYqw6b+G5ASn3+NRZ2+kNHEh1MHj5h7NVQaHRlYlksohV3vL5/++p9ZyupMbgzyr5la7NCMFWxTdlFNvVXyoth7HLjaWk1gj69LFcBsuOMZtLNh5QWOMIP1jq8pJ8vhS6CaaUPnS91XEHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gLYchQED; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso2291091fa.2
        for <stable@vger.kernel.org>; Wed, 16 Oct 2024 11:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729103924; x=1729708724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6rKDIzOUTRgJd5hJo09U0dfDGO4bSLC/6WzdPUaGc0=;
        b=gLYchQEDoMLSFi+waGfwIS6SlKX4VirBgRMwIb6DhAoDM58SJt7GAiH7mYi1HL0nwV
         jBE9A/j8owDIauGG57y0xfJ6sA2f3pjiBlOOYhXkn6zpwH5sORQrG9n4E7s2j56/k3FA
         TRA1G60FiNhAegRpTn3PgRMSMmFVjb0Pi1kwaMBEgaop0GQiUSS9aweV1uMwZstPCUJO
         Y7/KMvkE01eBOMSI12mxxuZ7drsXeWQyF04A/VybF47eP6ThilLrQism86cCu4huXuaG
         b4NQPH2GyCbrVqz+WUdeY9yQTMdqeqkXyrqdljKlLpMSzb5mApGoJBSj3W/VLOejmOYP
         +WaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729103924; x=1729708724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6rKDIzOUTRgJd5hJo09U0dfDGO4bSLC/6WzdPUaGc0=;
        b=I9QCy5RiMnmB+OAW7qT8d/TLLibT5XV92rhQRBNRJlXoTtViP1pDw4AouqJyAJ+8hF
         xXaBhjmTtLiyZRSDDaqqYLEPd+WbTA0YIS1MnEEHoD0jTDZZ+5L2PCBHyiUyZNxAIs1A
         TwMhPvm7bZAJnyAKnOOl50C6cbxJbSMbIs3bLuQZDnTaLDCadg63bggzUmAxVbeCwFKh
         b5h3EFZQrfuHHBWscvzZ1InkSJcFOGhlnetjT+nApbVSDbBfZv6JidLvqEzEs6fOtbtj
         pMMMkWUPQoJNBQoPytkYqAZomcZissAkrr5u+vWTYUYQ4MQPbLR5jUa5F2Y42XIG1D1P
         m4DA==
X-Forwarded-Encrypted: i=1; AJvYcCVvdfVu+svrGN1CVW8z+m35bZJnSKHg1YzIDprbLuLL0v1FzYoUTJjf89R0/a5f0F4EtQuC8So=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMqQHa4HI3aXF+VDxQtiMQLp2bEgYdbgjkKA8yy5qnrdLsGkZL
	6X5qubirk9/0l2vnJUzWEcD2Qp5qIp6QVLmK7Mxtjq6sETS8HlpfhlQfeN7rvidLR6PWsqeATOX
	MQAzeeh3x48xyER2q30tkvSqvZeKZ/10/XKHACWO0rtsE2ggUPb0=
X-Google-Smtp-Source: AGHT+IF13Ea7y6L9Can5T137qlH4Oc5vSjbBPA5f2FxIJOA7leG6kVirqELpYBS6TOYKSL0EXSp2T3MOJSZA4oMAFBo=
X-Received: by 2002:a2e:4c19:0:b0:2f7:6653:8053 with SMTP id
 38308e7fff4ca-2fb3f1adfa0mr77485051fa.18.1729103923979; Wed, 16 Oct 2024
 11:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-arm-kasan-vmalloc-crash-v1-0-dbb23592ca83@linaro.org>
 <20241015-arm-kasan-vmalloc-crash-v1-1-dbb23592ca83@linaro.org> <CAMj1kXHuJ9JjbxcG0LkRpQiPzW-BDfX+LoW3+W_cfsD=1hdPDg@mail.gmail.com>
In-Reply-To: <CAMj1kXHuJ9JjbxcG0LkRpQiPzW-BDfX+LoW3+W_cfsD=1hdPDg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Oct 2024 20:38:32 +0200
Message-ID: <CACRpkdZp84MzXEC7i8K2FCnR3pEc05wPBVX=mMO5s6j1tJTm_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: ioremap: Flush PGDs for VMALLOC shadow
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Clement LE GOFFIC <clement.legoffic@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:33=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:

> > @@ -125,6 +126,12 @@ void __check_vmalloc_seq(struct mm_struct *mm)
(...)
> Then, there is another part to this: in arch/arm/kernel/traps.c, we
> have the following code
>
> void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
> {
>     if (start < VMALLOC_END && end > VMALLOC_START)
>         atomic_inc_return_release(&init_mm.context.vmalloc_seq);
> }
>
> where we only bump vmalloc_seq if the updated region overlaps with the
> vmalloc region, so this will need a similar treatment afaict.

Not really, right? We bump init_mm.context.vmalloc_seq if the address
overlaps the entire vmalloc area.

Then the previously patched __check_vmalloc_seq() will check that
atomic counter and copy the PGD entries, and with the code in this
patch it will also copy (sync) the corresponding shadow memory
at that point.

Yours,
Linus Walleij

