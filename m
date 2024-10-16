Return-Path: <stable+bounces-86535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5739A123C
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 21:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D0C1C2337F
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 19:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B91925B0;
	Wed, 16 Oct 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWXJ36ta"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E1194A4B
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105473; cv=none; b=d3aMzWnwpY+h6s47fhnB6Z5BWV+rMe/qf3cPDoNLvZK4HQCRzy9zKAVHJDS4av6AKazioef15/xjKwsDRNrvQBuW6JHJcJ6aMRLXgHJBC1HKr7rNdyJHzHh4sCnlwoiePQtfx3yol8JTfUe6Xv1eAZiqeY0YK7sDnlxCurBEMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105473; c=relaxed/simple;
	bh=RtGYrIijwgBxdrnD7WLkzM6UJ+0XPIv1IwjkYUNx0TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XH1Jc49QPMRLeg8afKaR9fggR7ios/ZE87Z6fdG5HQJQFEW+GokUftUL6zoBIE6nrmr9SyTTy+IVdWxx7JNA3kA/ncPwn45wknwj3xx3Z67Q406+BHh3TcDga0ZHSufN+gIRo9em9CnrH2pXrD0+3CSJWW0fkgsiT8kzs7VeUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UWXJ36ta; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb51f39394so2066021fa.2
        for <stable@vger.kernel.org>; Wed, 16 Oct 2024 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729105469; x=1729710269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtGYrIijwgBxdrnD7WLkzM6UJ+0XPIv1IwjkYUNx0TA=;
        b=UWXJ36taXc+Ch1hVQJfJCgMS0QKkEitn3S6GGFphCcvyEobLIC83kIhg8elvHoVZWA
         yA9ZQA4shh6ttC+zr2LiKOnHBkahctZa+Y9yK/wFAqcCKegI4TqqfY7NKYua8TGkP+dt
         1m6suyKulduEP86ZbTJld2eXyVE9HOzTAJPP8dwjOQYKoGudE0hRka8hRDKY3IkjVujp
         9OsMGMZP/Gg2+HR9PUUOwQGISh7FT++ypriAs9b4ZkgL4Ygcf3bwwrSTrfpO0qTLMafm
         JIQZkPa13eAwkPuAaI04ZRDMRjuDWE13GNfeIi+/1LPWxm+LrxXPSOOyRWGj5q562ojG
         EKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729105469; x=1729710269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtGYrIijwgBxdrnD7WLkzM6UJ+0XPIv1IwjkYUNx0TA=;
        b=b/6LXaxlgg8UFRNUbDeYRirv0SLonC6olxqmuEA3LfufeJiNSjwmTs5u6Su/i+e5Jh
         9DP6OwDFo974Ub7IoWfX6OaQKKUMCnfSPvi4mgnKHutxxTrS8KaEJSJicfpKSh5I2e1Y
         a7yRXPAFJ5WNIQjB/tOIoROIYBtL6gZ6ik8Oz390GslFwJABScXZlmsYbbcDqylH+FSZ
         nmwBf0XvCvJZO0u1B2muiXIoTG7wgiNr0M24DNecJFEnwLSORIzQQpFfo5y5SK/BWJ2f
         THH8G/1WlJwUyofr6+rCy9z/dt/7mY2nQ5RiznL54Ym++iE9bivtxk6UFblZgoqQASRj
         weSg==
X-Forwarded-Encrypted: i=1; AJvYcCX5gjay/Mf8cjj3WZTkYgZggReOUCcYwxeLwewiF+/Q1chih4cNoulo5m5pAeotpm5U6I39O5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0ridMKo0TFu1hKeQpuvgwdY/fC1wTF0GMG/1YxK1CYPqeOcV
	QwKMzlmvqIk86ZbIXtUvmUK9s0XX1wDpnAsHlhzKD+I/tXXoje9f7rQSSyby8b+cTXLN3eSumAq
	dZJJHq8j7V1sCegZRrxnVSYYjB8NG1Sm9Nb+ZXw==
X-Google-Smtp-Source: AGHT+IHIiGX53/jRYrTj8MoxWL7Vaa89300icCl3MuVxWGPS9PILDn3Ma2WDMTpSv2vm8WeFAxQjKhYjPTwtch2LcgY=
X-Received: by 2002:a05:651c:212a:b0:2fb:4b0d:9092 with SMTP id
 38308e7fff4ca-2fb61b3e46dmr32242961fa.1.1729105469454; Wed, 16 Oct 2024
 12:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-arm-kasan-vmalloc-crash-v1-0-dbb23592ca83@linaro.org>
 <20241015-arm-kasan-vmalloc-crash-v1-1-dbb23592ca83@linaro.org>
 <CAMj1kXHuJ9JjbxcG0LkRpQiPzW-BDfX+LoW3+W_cfsD=1hdPDg@mail.gmail.com>
 <CACRpkdZp84MzXEC7i8K2FCnR3pEc05wPBVX=mMO5s6j1tJTm_A@mail.gmail.com> <CAMj1kXGHsexspqKfewL3i7M1aqZJwkb6D_kO_UCoAvoSF24Wrg@mail.gmail.com>
In-Reply-To: <CAMj1kXGHsexspqKfewL3i7M1aqZJwkb6D_kO_UCoAvoSF24Wrg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Oct 2024 21:04:18 +0200
Message-ID: <CACRpkdZ2nvH1UP_anBmU7q4GHNmUqxe-DTmbXNeQAOkgwUfkRA@mail.gmail.com>
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

On Wed, Oct 16, 2024 at 8:50=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:

> Yes, so we rely on the fact that changes to the vmalloc area and
> changes to the associated shadow mappings always occur in combination,
> right?

Yes otherwise it is pretty much the definition of a KASAN violation.

Mostly it "just works" because all low-level operations emitted by the
compiler and all memcpy() (etc) are patched to do any memory access
in tandem, this vmalloc_seq-thing was a big confusion for me.

I'll send out the revised patches so people can test!

Yours,
Linus Walleij

