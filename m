Return-Path: <stable+bounces-87826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3829AC993
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9872B28232D
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 12:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DF71A0B0E;
	Wed, 23 Oct 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0yPOopt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AAE19F461
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684861; cv=none; b=qtkJo2RMda589VCWrlqM2nniVBGiO89z/5IY5VJs3SMyAf9vqUxAc/cI2DauZfQ8NWMJ2okukgKfVUQjKH7+hVpXJXv5q+/FsilD7vJrBzxPaDa/Cxia/0QJ2mqbtYAFuhzE3CTa8RMs0MPTizKhpeuKuWZK66unuIRZCNESGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684861; c=relaxed/simple;
	bh=tqbz9ghi25MyNM796HfNIo/wGiHciMSp9xBKYdZMdzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ug+pbxumid1v/xz+LF3Fi+kkV9MUv9Bxng7xICQoSLyuhDTzuZjqfxFXikx9igq04fdL6X6AY+WbgQP/EBOz+bVymxGnPoxcNGx3GQIhEhq8eowc14XZyp8RK/+eRev/9MX0HxuoeDzDQkZVRqQjxV98jREj6ck6Vhprhjwt020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O0yPOopt; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f53973fdso735280e87.1
        for <stable@vger.kernel.org>; Wed, 23 Oct 2024 05:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729684858; x=1730289658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqbz9ghi25MyNM796HfNIo/wGiHciMSp9xBKYdZMdzs=;
        b=O0yPOoptYA5qvFQFQ5CIcJg3J+mDQsluvxlSFXezl0AILmFw1QclJ+svnIa5QbQjyr
         VFJmZ7hQNXfXTZlcAxOeAk2tALFnUWokp92QDU48HNt88FX9qihqZGsyV9W3sy+Qi3nR
         BF3Xyo/Tmo3avpg0PbThSpSO2HbxTvsiXyfvd7JK7H3jufpeAC5Ww1CcsAvg2vjccDet
         S0TDJSBCBLi1lXBlf24I+4CJvhvzEq0ypnY2vVQOn/F3f0vS5e1llhEW27ueqACTuf7+
         FVXUB/AL5tMf8zIvtVPcbQdq8Fgu/YHKkeMdVdaAuHNX9JkNNbho1wZvm1eS99rf3B1w
         M9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729684858; x=1730289658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqbz9ghi25MyNM796HfNIo/wGiHciMSp9xBKYdZMdzs=;
        b=AgVRT9LO+J4Y4aoIXx7j3Pg5T/9RWqCJ9u9CAP+y3OI133Gtennw59ozYzr9hCHaLW
         1yBoA/nMFV54q7OMR/ZgsgyM14fTiuiBEhEfeAyzll4ADlBFQtydvYhG66JqoWADnGze
         ZtZPLRX/lxZeADA+Dtg4LgeJkvJpoS8LmVCpujmF5n+mhMldj40AlqK0TT1VVqusLHX0
         xb+3hh/6AA6UF5DpuJkSjKrXst1qNfYxjB3jSRozVi1iBJnpER6b/jSmaCeldEpUWp3x
         9psRTz24yPmZUQR5EiT3fQQhl679ys7QAj4sGzd6qafz2fmHyL8gg42+JZn0O+Yn/olD
         aE0g==
X-Forwarded-Encrypted: i=1; AJvYcCVG19oxS+Ymc5xIUzyjyFdMZIz+T0HS/EvpQMxEyv5w9ssrFmFAInCC/4s1J0zguBnjXgsinus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysga/6zCvzrfTAQDpGzCuiqbjGUER2Wke2yZqHOKgV4nrvtqoz
	x58gaksKD3VmRipAAtpTpaZReB1aoE3PuueRJ7XgGeSUjX7fx8FErW+S1UT5LjebolsxoSw3AU0
	uvQr9pXtIEcxrRi3W8WdxE6C9YDe3VswcGeLIFQ==
X-Google-Smtp-Source: AGHT+IE/UAzMY7V3eb5pkqaftwZ38vfA7061nJlGo03pDJqYCoLAKz73v+E375hMTpCsOw6OHL/EGlBNyYbkCpt8l/c=
X-Received: by 2002:a05:6512:3992:b0:539:f1d2:725b with SMTP id
 2adb3069b0e04-53b19c41fbamr866738e87.4.1729684857664; Wed, 23 Oct 2024
 05:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-arm-kasan-vmalloc-crash-v4-0-837d1294344f@linaro.org>
In-Reply-To: <20241021-arm-kasan-vmalloc-crash-v4-0-837d1294344f@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Oct 2024 14:00:45 +0200
Message-ID: <CACRpkdZfbjorFjZ9P7ifYO4mVa7eVdviyqO8+KjJXW3bhOq7aA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Fix KASAN crash when using KASAN_VMALLOC
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	Melon Liu <melon1335@163.com>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 3:03=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> This problem reported by Clement LE GOFFIC manifest when
> using CONFIG_KASAN_IN_VMALLOC and VMAP_STACK:
> https://lore.kernel.org/linux-arm-kernel/a1a1d062-f3a2-4d05-9836-3b098de9=
db6d@foss.st.com/
>
> After some analysis it seems we are missing to sync the
> VMALLOC shadow memory in top level PGD to all CPUs.
>
> Add some code to perform this sync, and the bug appears
> to go away.
>
> As suggested by Ard, also perform a dummy read from the
> shadow memory of the new VMAP_STACK in the low level
> assembly.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

As these are regressions that need to go in as fixes I'm putting
them into Russell's patch tracker now.

The 9427/1 patch:
https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D9427/1

Need to be avoided as it causes build regressions. Patch 1/3
supersedes it.

Yours,
Linus Walleij

