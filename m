Return-Path: <stable+bounces-151941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E6FAD1327
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 18:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C447188B4DB
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AB9156F3C;
	Sun,  8 Jun 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFJXxzKX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE313C3CD
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749398432; cv=none; b=LV+ciAfxGjx/DYr+fbKUqh+Mk5mN0SaYVJWl+VQBrOwstqManm7t2vlVxVEkgYUwbh3w9LCP4RSvsMgdB3YxGGwWYHsuXXD1bdg1UcAhg2rZLbY7OpGGT1wTtc9fEKXUjhflkYSBoQlbCa1ao9NOPYBH7LqZGP8P5Bg9GXgQnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749398432; c=relaxed/simple;
	bh=5ull8SHmrLVLnCZpt+X9CgX+0fDWN8cWRgwHN8HCwR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+kfLU3CB0MoDF7cKp0CZZo6poC4IKdThy7IZIjt+fKE1jjvdp4LErqi1Km9hn3ueGyH66JYbgYPHWUnlwUDNikEYEymIuGe5UmJPoPOJcwx/hEyjGbUZiqGFBXhtiK4g4rnYtgDRagPQKzpQe9HH3b4GqZeLU30LJNN21AhkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFJXxzKX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313336f8438so586349a91.0
        for <stable@vger.kernel.org>; Sun, 08 Jun 2025 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749398431; x=1750003231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IKL1Gs0wyMJo46IfNicTP5SavY3/GM73Bnhdjt7e0A=;
        b=bFJXxzKXys976jtQZnuswc94aQvqHdEtkJBpvAuLoCEpr8HE8TXYkUy4dVCjh//3vv
         MwzEBwEPkwk8Lh9MsxDQN/66dVnyLzfLjFZUKj+Fq6PW0JmABAbm1Ivmo0Cha6zq/GUw
         uupL3SwlWjJXrKOSTHk23pXyqNXXDsYbaE4eh1vO9Hfphhcbm3/pjWH8eqFiLo+GQeYJ
         UJKyFbicYMCcGpRL6516sKnQn7AQWvNCJMrMlPODBU873ibxSByepq9aZwvZxX6APXi+
         u4oVzNufMHsTDbg2ojNSEclfV7btG9Zm575TSrNjhms0TmUkYfkUD4gA6yiGZHzBpn5D
         ODdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749398431; x=1750003231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IKL1Gs0wyMJo46IfNicTP5SavY3/GM73Bnhdjt7e0A=;
        b=lgIt1iT01/k0RXoc61YDcj6NCSy7xKEQjOR97E0x3VK6WicpwfJY/N0yl+0pWobe8e
         4lDzF2Vvz015KMp0bPPKFJtF6DNYtvUYt5ow848l6oFuwYEzpUuYaQo4Gqo7mU+CEx4P
         9e4RTKM0TpZkvg47Il1n1Bs3eBBdF4rnUTYBZa0nby97InWRKfEoHRLQmlUkucRm6C3e
         Tm6NZyODBZfWF+CwM2g//pmB3lbEx2yqdEAjlEnCqmdXmy56se2v/hq1eGKSA9vqZNk4
         lCEBau6ByAoqR1zud81P2X5rlcha5V4y5tZjoQdwxLEmPPJfS+xcfxq1XzSWrZKJpam9
         hf8g==
X-Gm-Message-State: AOJu0Yxfz2Pl6F4RmpSMBKm/U+QM1Ym1X4CFrP/3hWPCt+mccZHYc9A7
	xvgblquCdCkSPxeWfCv5zSbYEaihTeg0D8CNGbo+sJDSBHGMqfFCoHJ3uJjWTtlHBzS7rmZaSSq
	62PxI/Xm4odPVMIzAT7dEe9BIRjDUQyw=
X-Gm-Gg: ASbGncs+s59DYzXZEzGByRe/yUyvxp1FYxAhBs86fImUJ0uY8g/xH0lwQGRyW0lVSUe
	S/C06NiyuQvMmy3XNu3K02SXpYIM2rEbJf1yfzSC32/JwUvU71aTNVInWtLOR6pVANDIh/k4ylw
	wO0R91wq9bCWVbC+L1Z4yDy88QIYtJ47w3
X-Google-Smtp-Source: AGHT+IG0yWw81hyCKOl55h5RVJ81xv7oEY0z+gCDeUcyT+5avsy24QpN5d2Fjw5yTckMihMMqjcXP8m1ttpEeVF02zc=
X-Received: by 2002:a17:90b:1801:b0:313:2f9a:13c0 with SMTP id
 98e67ed59e1d1-3134e2b90f8mr4935392a91.1.1749398430785; Sun, 08 Jun 2025
 09:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608145450.7024-1-sergio.collado@gmail.com> <20250608145450.7024-3-sergio.collado@gmail.com>
In-Reply-To: <20250608145450.7024-3-sergio.collado@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 18:00:18 +0200
X-Gm-Features: AX0GCFvNdGFJF6nbJ1krqcY5qjF0EnvjkoT21d1Rxb9TUrBOrjPqtyxtmz44XkY
Message-ID: <CANiq72=BU_WTui=OQK4xz-c9h1EdX9a--hs8awv=AJMqfR_SVw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 2/2] x86/tools: Drop duplicate unlikely()
 definition in insn_decoder_test.c
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 4:55=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
> From: Nathan Chancellor <nathan@kernel.org>
>
> From Nathan Chancellor <nathan@kernel.org>

I think the second one does not need to be here.

> [Upstream f710202b2a45addea3dcdcd862770ecbaf6597ef]

If you use the second format, I think this would need to be:

    [ Upstream commit f710202b2a45addea3dcdcd862770ecbaf6597ef ]

But maybe the stable team's tooling still recognizes it or they fix it manu=
ally.

>  #include <stdarg.h>
>  #include <linux/kallsyms.h>
>
> -#define unlikely(cond) (cond)
> -
>  #include <asm/insn.h>
>  #include <inat.c>
>  #include <insn.c>

The contents seem indeed equivalent to the original commit, so it
looks fine to me if Option 3 is used:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

