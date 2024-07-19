Return-Path: <stable+bounces-60587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEAF9372A6
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 05:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6FC2820E3
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 03:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1939B667;
	Fri, 19 Jul 2024 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxtenVPf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9954EDDB1;
	Fri, 19 Jul 2024 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721358317; cv=none; b=u0Mx8X4Qv7BzDdy/ObEC8P+f49e0gJmNqW9v7DqsTC6P9x9MHaz+MD+JVZP0imUjGPLNB8Rl9dFZLlaupnED1aXasEZV0OlBDe3+hKStUMMR27vUaSsTD2u3uE0EHw54qeVv7JQo+sPsoM4RJA4YtqdI0lfZU+3LfhMuNV6Fmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721358317; c=relaxed/simple;
	bh=d9s2Rss6fi/rFO5jF6iazzfVjBfS4xr2kBDXkKgmgeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxQNTnTEfpckKibrVV7rWp4AmNj10MtNak1EwJhqTs81QE8U4XfxH5J5UwB+AVrIAeCr/9D9YEIc5lRG2aw4i2MRuzTprrG7UGSrsLbAxMt3jGLUS1+TGpLegAlqLyAYSaCZKkAOM4MKlWuI+Z9tNHF8/IGSJ/tzsL06ZTrCYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxtenVPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19543C116B1;
	Fri, 19 Jul 2024 03:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721358317;
	bh=d9s2Rss6fi/rFO5jF6iazzfVjBfS4xr2kBDXkKgmgeg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dxtenVPfTEC8+tJ2V8Q8wwpiYL0SnDi/mTTWEJ0BcwJKfvRhosBp7CadGr4UetOrM
	 iLm9/Nzl62n3H1UNPck5m1FqTHW0Rofyh4XpZoTTqViFkB9vP1wIjrlOXJrdWlD9qf
	 e+s1K128/Fl2AYZEQAhNp3mV5ZqqCqBGyCRi/22Ycp/ecmzYexYUVx65uWjbW5PzqA
	 pPOiAUAguZG9VOfqHMP+hNGUpHuHXFCO7PbmMx0UgDLUHQYkfGBqK551z6TCBl8QIs
	 L7bdQZe0lzpW6n65iVWExG49W799IbC679F9PmbRkqti+cd+cbYVWSx4nscrAH95Fb
	 GttDUzdrqOjSQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eeec60a324so22285001fa.2;
        Thu, 18 Jul 2024 20:05:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnxGex9HSFPvvNZfsHRe4k+rmBvWh4t0nA70XIFRlcq0KpAe33IfcevXpt5TSep8n0/uwE1z1x9JM17ziGUNeTF0XavyrOfV0dfkToDv6IVRjGXnTen6zAU40YYeXqJq0IMZMb
X-Gm-Message-State: AOJu0YyfNZUzki7Zz/pjjzszDNvvx8nYBunzQhHN4M6DaCDsbP0XS/wp
	mdvhjKApcqfJ2T9c2boRLzJyJy6aDBXoxvRWbiCGEdr6OUH80uyrqSavgzqqKescK7jfZT3SkYn
	V8Ao2P1da4m6wsgJIOido/tlazqQ=
X-Google-Smtp-Source: AGHT+IHfVe69lNstYW5VEPeEZJLm0kZa7S8eWsw8fbwhX3hh/hpgwDIrfPqJwo5VbhckbjAiAn2AT+fib261MYXGu/s=
X-Received: by 2002:a2e:97cb:0:b0:2ec:5777:aa5c with SMTP id
 38308e7fff4ca-2ef059975e8mr33064741fa.0.1721358315767; Thu, 18 Jul 2024
 20:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926160903.62924-1-masahiroy@kernel.org> <CANDhNCraQ6UCDNH3s4+YKCWfk4dGjxP_LkZ7WBUnJ_WiKM5u6Q@mail.gmail.com>
In-Reply-To: <CANDhNCraQ6UCDNH3s4+YKCWfk4dGjxP_LkZ7WBUnJ_WiKM5u6Q@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 19 Jul 2024 12:04:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3WQ+3K+Z=ueZ4f_1EF29aPui-HS2eV3erSb9rHJSPLA@mail.gmail.com>
Message-ID: <CAK7LNAT3WQ+3K+Z=ueZ4f_1EF29aPui-HS2eV3erSb9rHJSPLA@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix get_user() broken with veneer
To: John Stultz <jstultz@google.com>
Cc: patches@armlinux.org.uk, linux-kernel@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	Neill Kapron <nkapron@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 2:10=E2=80=AFAM John Stultz <jstultz@google.com> wr=
ote:
>
> On Tue, Sep 26, 2023 at 9:09=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > The 32-bit ARM kernel stops working if the kernel grows to the point
> > where veneers for __get_user_* are created.
> >
> > AAPCS32 [1] states, "Register r12 (IP) may be used by a linker as a
> > scratch register between a routine and any subroutine it calls. It
> > can also be used within a routine to hold intermediate values between
> > subroutine calls."
> >
> > However, bl instructions buried within the inline asm are unpredictable
> > for compilers; hence, "ip" must be added to the clobber list.
> >
> > This becomes critical when veneers for __get_user_* are created because
> > veneers use the ip register since commit 02e541db0540 ("ARM: 8323/1:
> > force linker to use PIC veneers").
> >
> > [1]: https://github.com/ARM-software/abi-aa/blob/2023Q1/aapcs32/aapcs32=
.rst
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>
> + stable@vger.kernel.org
> It seems like this (commit 24d3ba0a7b44c1617c27f5045eecc4f34752ab03
> upstream) would be a good candidate for -stable?


Yes.

This one should be back-ported. Thanks.






--
Best Regards
Masahiro Yamada

