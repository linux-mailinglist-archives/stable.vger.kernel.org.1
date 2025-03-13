Return-Path: <stable+bounces-124222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D9A5EE64
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF9E16A80E
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD2262D03;
	Thu, 13 Mar 2025 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OW6BStxA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A42620FF
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855764; cv=none; b=Zkgn/F8CfSxDDGezVp7OcjYLhO1I9qO3nySePguu5MawOJQCqdPx3t+BPlCCni+iN75ofHT7pS4VOSGglBgv1wQiszSgM8mqFVRrqiJEH4KLMvlb1TAjsBsI9BuJys+k75qCpREOmv2hMM0pqvHnIgbeqq5Ij5q2Zzna1aXs9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855764; c=relaxed/simple;
	bh=wDdfhJhBThiZUn+0LbZ9lmE9r4DbYfHvlI21cG6BxoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hL5my8XsneMOxwf8uoR8vDgqUzwHGIOU5f0A3DqfrOXwXj8Dx9vH6u7VKY9mxSSojGhN/2nN5A8f6Q6FbLOi7w62QWkZlSNzizbjzv0AV5rn4DlVa2zS38VZ3R4ALuhyS/AJzHm9z7kbmExoFAVXXKX0s6EWDGDx9lvms4bkcjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OW6BStxA; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5499c5d9691so772510e87.2
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741855760; x=1742460560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH0/G8dnIsLEQps0a+QRu5yJlelIyIdUnSqN98914W0=;
        b=OW6BStxADydn6/Me4yfuO+9rgVQfirts/pkGEyYF0ptTOMt07HdwFDTRQuO/qMZooS
         GPNVWOzl6Rgxixx1N+PYswTtC9M/1QGmrT7ByJdLA48Pd2om1+cEPZpHy7ZPoW9YNLDa
         KZPiyujMvbF93BcPEEvfo4HOCLp4Lv6obU2e4HqVsQNRRhQWBe6DaHbdTcfEt7pyDefR
         BxU+YKMuWP3o6Fq1Wcyi4IynV1wIf3lQ5FIQsQDnVUJvd2GtNxZxMeboQ/MHoA/bTchR
         dGQ09hgM/gDx0ZEo9SQR0HPofVyVzdi1CtPKsm2jh04dxURCVmMcKQqYEnKsXL0L8WCA
         K8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741855760; x=1742460560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH0/G8dnIsLEQps0a+QRu5yJlelIyIdUnSqN98914W0=;
        b=Tkd3j5ZGw3sHCsHL4/ltp12Pp0Kt01jTRpuPdqkgwdSDvZ3mRdF+sIHpsyjpeR2zgw
         Ox9IbjYP6HjvY3a5Eg6lRi/rGEPx2Ng6BlZJrLvQTFmfjGVjrObNLHerkoZba+rP/TNx
         ZcH2Mj9y01un1bxfrJUAZmxN2AzGSap/uDXzMrzDfKw8dkow6dQHCQlTGIRcdZs3A1lw
         TVG/qHkhVMusZFvjHJLO7/JHLf4gjQaK0ES9LufrTjKYQ6RzTd69fwLTpvFY2nqAv1Y7
         0sRIAYVG6KXqcn4rsLGLfQQb/lWFJQgeteyr0Z/JmrmG/cuzv1GVnJSGwZc2I2b25wDZ
         tXaA==
X-Forwarded-Encrypted: i=1; AJvYcCWpevNhQYMzuogKdEpHvpmozjqbM/VP+QFnI+YuxuuH6/iXsFcZQGxNyewzuVkv7YccrEpOu48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPTMvW6dkn+dgk1BAQfoHyTLhl4zgvTPeCPR+JlNnhBLTluMC
	7k6/F0I4awtws7V41hCC/Vb5aYb0wuBHWNThb/Dils9pULpVY7y/38ayRvmSv0wCxxtovCYYzGj
	jIuClxeulinXb+2NdsogASdTiokCfQvJFKVnsuA==
X-Gm-Gg: ASbGncveD5L8xWaH8DIRphoC1AWrEc69hBqp/1Yec80Pu1JKWQfIx/UiHvb74g3bgDY
	zReWTdHfgmOMFdLWRe8oJhJTTTd4u+pRbNnFek5yoyry0tjaaNYgavaWyXDI066kw2E5euOEqjQ
	PeiK8DrH7unmz4TzBW6ifoO9t4vQ==
X-Google-Smtp-Source: AGHT+IHZkAfEyI5h1xNp9EscwBtm7RYtlJrFqFkZLqQeebsL2P20q1EFV/vAiiJ7hbwVCtlIBk24ytpLzUux5mvsmjw=
X-Received: by 2002:a05:6512:ba6:b0:549:5b54:2c6c with SMTP id
 2adb3069b0e04-54990e673f2mr9060936e87.23.1741855759797; Thu, 13 Mar 2025
 01:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311-arm-fix-vectors-with-linker-dce-v1-0-ec4c382e3bfd@kernel.org>
 <20250311-arm-fix-vectors-with-linker-dce-v1-2-ec4c382e3bfd@kernel.org>
In-Reply-To: <20250311-arm-fix-vectors-with-linker-dce-v1-2-ec4c382e3bfd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Mar 2025 09:49:06 +0100
X-Gm-Features: AQ5f1Jr7N3AP_OP74JY7L1V0VadIJIbOxnWg4sgQC81ix5N9CYiTFnZob5PuCj4
Message-ID: <CACRpkdatTYZ9oxSBdjTbs-LjF3ONqcA-9vYojPc-KSGZmoEO=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: add KEEP() keyword to ARM_VECTORS
To: Nathan Chancellor <nathan@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Christian Eggers <ceggers@arri.de>, 
	Arnd Bergmann <arnd@arndb.de>, Yuntao Liu <liuyuntao12@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 8:44=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:

> From: Christian Eggers <ceggers@arri.de>
>
> Without this, the vectors are removed if LD_DEAD_CODE_DATA_ELIMINATION
> is enabled.  At startup, the CPU (silently) hangs in the undefined
> instruction exception as soon as the first timer interrupt arrives.
>
> On my setup, the system also boots fine without the 2nd and 3rd KEEP()
> statements, so I cannot tell whether these are actually required.
>
> Cc: stable@vger.kernel.org
> Fixes: ed0f94102251 ("ARM: 9404/1: arm32: enable HAVE_LD_DEAD_CODE_DATA_E=
LIMINATION")
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> [nathan: Use OVERLAY_KEEP() to avoid breaking old ld.lld versions]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

