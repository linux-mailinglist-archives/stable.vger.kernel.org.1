Return-Path: <stable+bounces-124106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 827FEA5D1F1
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 22:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB8B189E036
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 21:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2796122CBD3;
	Tue, 11 Mar 2025 21:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irmHBhpo"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA12221720;
	Tue, 11 Mar 2025 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729677; cv=none; b=FrgLeKlzq9yUvXR3ImGWqI9ya+uMjaPjbtLGbiBMJRb9Hvu5ZjH1kxLoXlx4x73hWFjxG6LBC1eY4or6n9gqgRy1OZZAdC2X5ZNzLTfZMqxSIE7VjfvSQpmJmGts2ESgk32ERRxEB3eS1+IK4JuAreHMt0I8HFn8l2g0x64C3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729677; c=relaxed/simple;
	bh=3T4DbaFg18rciOHzFePVLDz+eAOpKoSoMMwqeyCCDOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgGyh31DPpBVMEJ5nwjLwV9qeDR113Ite1FZxqZmcEIfGhrjkGAzJhPolTF0He35iJU4widsUP2f0QK7xr+YvwL4di8qY2W/FMKDZbIZ2WbcHfwA3AwrJK/CzPZwkKBcR/y8/giQ1DospuTmUQu/J99j8yWBCfqK7m6a40gHcZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irmHBhpo; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30b83290b7bso65344021fa.1;
        Tue, 11 Mar 2025 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741729674; x=1742334474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9vgzU+eZVFcSIn6w6E51XRuCiWeRmIlJU64r3csFlU=;
        b=irmHBhpoBTXb8D1lNc4V6sNlKpnIJoJIetQV0FOiN/pLaxIhk8SDypN7h0yPsJn9P5
         f/oPVUVe+amLczKCOlGOze46MKDkXw2skuAfS2GTP9+qbaaFEwsJ5MBaqsCu0wnUsU6K
         CWte74prQbmAIBBplPzvGRbMMy3qlKA2kkwWRMPTtXiZCSQTViLoBGy9VoHbD4XcPIUU
         L7YQxfNeuG7+igJUxTc7kEeLo7SKcWpO8of2/im6xIY5mfxRFG2WMHTpGBmK3HelzBTD
         bkJU/2uqFxWdgymL09ESNlkIKv0CEGbS+TfBOrnvwS1F2yAZVGnkbHNfZR3B9Xid7S1+
         Bopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729674; x=1742334474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9vgzU+eZVFcSIn6w6E51XRuCiWeRmIlJU64r3csFlU=;
        b=iVYTnY4TshFDn8C4QFmJzGO5ySkSf1XtSAcZL4GO7toG/qAncSBAUAwy1USYNBqwQi
         Vwoqq6eeyJgUctb9d3oQjnAm3d0OiToo9MPdEB5o0mTYXVdZbhRRsiWG3j/sTkAQTX1U
         7YN0bP7bESqyNh2shtuBfytP5mKOT6w/c7P2gfDPbPxx4Y3yAaq6XPUBEuuD/5J3gSA4
         50snV+5mhfhfbpf9oeGOD0LfigREblf7WS02UXMnIKWdJL6BFxhpVnVo+ZKPtT+RMjuE
         lic7//F1pWXVYRYCsDLTgIjC//Pe4md0lZPOyMxwpjHB54xq0Hbes3Wu3effQmTM01Ct
         BYew==
X-Forwarded-Encrypted: i=1; AJvYcCWJV9sFoEIjv2gYNg8C224Q8sQNcryB4lPp2+ODsa0DctA1Uy/Dua5WZo0Jxh27Lz5Xg2p2cWRz@vger.kernel.org, AJvYcCXvOJsQko2p+Fjlyj9irCKAFQ0xfXHcmvFTTiIUuduIe+ps5i2MIDL7d4dMfuorE3de0Uq8Qi9M40/GIes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbpzehByr9Ms1Kgz0XaEhwT97ixVYjhIcmCr84tko4sAn4Re6X
	3MBEHexcxBrUsOFKaY950sYKAinXUbMQCuTADBpAbgLWwTXXuKEcIn0jn6Ky4BU3CiohRseT64Y
	kmaBLWQhIXh9ba5GYuZIqRaUXCQ==
X-Gm-Gg: ASbGncs7rl4wfHNblkZcxkR+ydsxX7HGNBwvJ6sVqFsi0Q2YoOT5VzxUdITXKildAMe
	4xeJwW0ofBCMfc31hOhLmwR2gcPmJrOJpjlkmVkhGOAHNUARA/VCUgFjCs6dCHbh6mlUffCbLwd
	EbUpQFYJw4KgDME/cVhTkdhS+eeT13pEWi6tV4Nq0/
X-Google-Smtp-Source: AGHT+IF8xESdXJHMqJ/D9UyFzEiq2RloDH6VkP8Bza5VBEIJMeohMMuQFJRHBfaH+sCixf8rzrKmdEY9nafjRASdd64=
X-Received: by 2002:a05:6512:3d15:b0:545:60b:f394 with SMTP id
 2adb3069b0e04-54990e2bcdbmr6813537e87.4.1741729674090; Tue, 11 Mar 2025
 14:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local>
 <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
 <20250311112112.GEZ9AcqM2ceIQVUA0N@fat_crate.local> <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>
 <20250311143724.GE3493@redhat.com> <20250311174626.GHZ9B28rDrfWKJthsN@fat_crate.local>
 <20250311181056.GF3493@redhat.com> <20250311190159.GIZ9CIp81bEg1Ny5gn@fat_crate.local>
 <20250311192405.GG3493@redhat.com> <CAMzpN2hb7uD6Z410YFPYiGQvsV6-9b8iMXXCtfJYJ7ATwO-L5g@mail.gmail.com>
 <20250311214159.GH3493@redhat.com>
In-Reply-To: <20250311214159.GH3493@redhat.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 11 Mar 2025 17:47:42 -0400
X-Gm-Features: AQ5f1JoR5bIlFE8s6b_lH2efo_DiDc9TYiwcTayS_CBM6l0T4F9nszPzkfD95g4
Message-ID: <CAMzpN2iDOdn_r2aFipfyx3yKSKcSkQ5U6BpZ84L7i_Q6LmXgbA@mail.gmail.com>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with CONFIG_STACKPROTECTOR=n
To: Oleg Nesterov <oleg@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 5:42=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 03/11, Brian Gerst wrote:
> >
> > On Tue, Mar 11, 2025 at 3:24=E2=80=AFPM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > OK. I'll update the subject/changelog to explain that this is only
> > > needed for the older binutils and send V2.
> >
> > With it conditional on CONFIG_STACKPROTECTOR, you can also drop PROVIDE=
S().
>
> Sorry Brian, I don't understand this magic even remotely...
>
> Do you mean
>
>         -/* needed for Clang - see arch/x86/entry/entry.S */
>         -PROVIDE(__ref_stack_chk_guard =3D __stack_chk_guard);
>         +#ifdef CONFIG_STACKPROTECTOR
>         +__ref_stack_chk_guard =3D __stack_chk_guard;
>         +#endif
>
> ?
>
> Oleg.

Yes.  Also keep the comment about Clang.


Brian Gerst

