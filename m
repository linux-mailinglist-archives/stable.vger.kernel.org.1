Return-Path: <stable+bounces-86608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D342A9A22CA
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 14:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6B7282FC9
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 12:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5881DD89F;
	Thu, 17 Oct 2024 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sbs+cfzo"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099A3770E2
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169752; cv=none; b=tpLGI2YV63avLBsBXUXK9WKEii5o5H4Vn2xphstfindHXyP1uCs7mmVh1ljYZt0k+fvkL2F406CO0yIsXtB+XdDvvjHmX5b8duWZpju1iEUBLSGa/v4P+3HjZpixchGXPCsBHvfeIeO2OfNTMhlXIUr9VQuplLGZFpIglnvTJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169752; c=relaxed/simple;
	bh=0oDiiXISiskmw2N32VB83lMBIXlRn3Dusq+r3QQGyv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDuCcloftzoaXK8OfsQI2sNZuY0T3weNFOtth0RYn4S4zNqTi8Q8b3Veglq2Dkbspb7WQq73OCSKKFB2pllUhMnhSozSi4DvTe7aIv6DMbfXtizqAXMCwaWjPBhZkcufr73kxEGOk8VBikCpy1No6bKeRbGTOMSK5/fgWKxR3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sbs+cfzo; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so10306121fa.3
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 05:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729169747; x=1729774547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCFsQLccHzWDScb5aVoa2fyWE78FPrp3oEuT9gFmNzk=;
        b=Sbs+cfzoF6qmZCq6jD+7gBdSlw2++1YeFMGY4gSJ9VhX+pnJBkC0ZthxvR6VU6nGGT
         equzaHUnwhU42l4C7leExLQst7v3hXpO0QenR8E5iCzEf8hbMvRaqwv6BWUo1GjL+OSe
         SOOZ2qkcqkvRfqpTgwSUfC/AGfoZi9XSBuuDRDzfNFc+7IiDzQd4uK19yCE04YRQ9wl0
         V5+TURDeMffMZDRvjhRDEdXpH6uTpk3Bs5sNGb6XeZTwm5rMOlKpejZZ6t/ze32+L0p0
         sKoKqWUQ3oZ6tfv2Vo75x2ZJzNS94rYMYVzOzEPJR+NSVTgDVbcuxeKiMJPkAqqHTtXe
         XlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729169747; x=1729774547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCFsQLccHzWDScb5aVoa2fyWE78FPrp3oEuT9gFmNzk=;
        b=dKPP9dJCIy/CC4AUlygcqOzgrGXlHgHY9SDKj7TnpNwmgYRMhzSbgoDD7D0HRaOCro
         sUT53DMS4JoQ0OXLVYybpQ+0UBU/5oZqeRIom+vc6SoyNHOxb2yjjb/k1oRuG7BKgPnl
         Y6s44TlFkxdXXslf+hKyRXPnvBoJXAsSQam5u63ocYvlaK5ey43fDqJhZp0IKiph6Ypy
         f5RY3DDXRKcmEZtw04kwTBYU6hrkrakaL422KSBE5RiRJ2DLCsdC6nM9ylIWq+Ri26RU
         gC7AZQk1YOyO59UoWxY6qDCVjL+aFyppqBB/B4Hm7rx8124MG3GPA1NzPnk/FUmD4Ya6
         RvhA==
X-Forwarded-Encrypted: i=1; AJvYcCVsP9t1K1pCcUsxVlJyK9/iPbKuqKrHBc31bCRpXeQiHYdOPZCRyFoPuxBzrRV/WDtV9Qh8e/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0BvftLSAtr3zROWgXlfIRgu7xNBsakwLGIkk/ag62TdFke4mu
	hn20eiAeOrTjv9Zq1Bbd0Bk427Uu61/d3PpQnv2gNyjTpoMNFe2EfafUnhMuq9WKgRJfOJayZBG
	BnpY/VP+rGB6QF68IofPLovbKHGs8hgva1y0+Sg==
X-Google-Smtp-Source: AGHT+IFFnc0tQjTTTOLtjbrBvukWeEJCbwl2OnBf8sTx6M68DY0cJ5kzCJje64gUnuuqZzTni7J195+mWq0F64ydybo=
X-Received: by 2002:a2e:b8ce:0:b0:2fa:d84a:bd8f with SMTP id
 38308e7fff4ca-2fb3f2d1667mr94996631fa.30.1729169747121; Thu, 17 Oct 2024
 05:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-arm-kasan-vmalloc-crash-v2-0-0a52fd086eef@linaro.org>
 <20241016-arm-kasan-vmalloc-crash-v2-2-0a52fd086eef@linaro.org> <16e45f70-d1d6-4cca-95b0-24d3959e50be@foss.st.com>
In-Reply-To: <16e45f70-d1d6-4cca-95b0-24d3959e50be@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 17 Oct 2024 14:55:35 +0200
Message-ID: <CACRpkdaAnutxm-vrrWiqXPoJfsU_RNUOi+a0XP6FNysuYWiX+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: entry: Do a dummy read from VMAP shadow
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Cc: Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Antonio Borneo <antonio.borneo@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 12:20=E2=80=AFPM Clement LE GOFFIC
<clement.legoffic@foss.st.com> wrote:

> > +     add     r2, ip, lsr #KASAN_SHADOW_SCALE_SHIFT
(...)
> While ARM TRM says that if Rd is the same of Rn then it can be omitted,
> such syntax causes error on my build.
> Looking around for such syntax in the kernel, this line should be :
> add     r2, r2, ip, lsr #KASAN_SHADOW_SCALE_SHIFT

Yeah clearly my compilers allowed it :/

I changed it to the archaic version, will repost as v3.

Please test at your convenience!

Yours,
Linus Walleij

