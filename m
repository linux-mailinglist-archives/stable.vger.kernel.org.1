Return-Path: <stable+bounces-123189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E642A5BE0A
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 11:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235991894069
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EA4231CB0;
	Tue, 11 Mar 2025 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2uun/cS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74285BA34;
	Tue, 11 Mar 2025 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689492; cv=none; b=UgSfFdLv4hwR8+h+84aZ2LROxDpMY2t0q/h0zvoPBegHpxyLWzxP5U3YuerzA8Mn6tQNfv9C7gvkN7adKRjgzlM2SusJYoSNm5GdiAZHBiqj9oqhP9vv3SvvffQZYeGu5nGVd/1LT/ZzyhCCIhSjqXT4P9bFmaB9FmYlcG7IS2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689492; c=relaxed/simple;
	bh=21MGhRofUEJ0IDxhS/iYYEkZv7ETUGr/oWnYX8xLlUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teHSaIZBq6Fjb8lyqN8X4nAz63rx52mtEhbonftCdY0bRfznzWEhrIC9QWaVwxxpIP05iaxpgcd3zopv7O4EvGgIl7WQaSijUlEbN/FsodMTIcepSt30rLJtqguDDQFYCewqEKwsZVlVgwFBDvFZec8ddcbDsrlfzA8MWtKjLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2uun/cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33BFC4CEEF;
	Tue, 11 Mar 2025 10:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741689491;
	bh=21MGhRofUEJ0IDxhS/iYYEkZv7ETUGr/oWnYX8xLlUI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c2uun/cSpJpOKknbR7fJLyOmluRIxIbLOkrrdW/X6jV+8YjfKADX5+qa08Cx1MIju
	 3+bikZO5TwGOXN4SuaeaIv0tA3nyjo6eEspFGijS10AloVXdMyl+95BtxV2aB7Am+G
	 GTi9bNpOJjXJd+w+DfqPi2NjKBUrCL4x5bvfz2BK82Qs55oguXmpqbOrEC8XzIBCz0
	 mEH+8s+6wwoo7Uya1GjR2mMgsm501eEmuYZ+PXs/MYXB3Uh1VlcNP4iiVU13YdbGrR
	 a5OzGo+hlZ5NPjoQy18jkmGCSiFwrdLHoGCCordVmuL31PaRFZ7GWJ1LMSxxuAJt4U
	 Hd9e4ogJYTXqQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5497590ffbbso6049301e87.1;
        Tue, 11 Mar 2025 03:38:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVISjD3MKDhuSLY0YzFP9SmC8OLijnP740RcOSYIl30XouyfTTATvrXa+fBxMS2HDu77kD++YxD@vger.kernel.org, AJvYcCXwWvjDJif3QTloGN1SY14TOSbftHApYEZ47wKYrK51i383WSFg+ppFioFRRaW798AhOBxr6rjJi5PuIUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZZz9HzzWWeDMIEjFYqNPK+DSkt92Izs0SMlwYsM0EzaKm6xk
	NvBBNsBciR/R12k4NE1itlz3o45bPJLVvNCt/v6pSCHyW4BhSD8+Nc2rP9tqhvw1m2s4sJLWw65
	Da+mHLoQgoU04CxgeWakqPNEeaiA=
X-Google-Smtp-Source: AGHT+IFrw+jE8gCJmyCxRdWJX3PFj25i+6jaxU+VEI+QQJjytmYuJT8E955/OiftWm3m7XUK+z46/p2vYkJY2vCm23k=
X-Received: by 2002:a05:6512:b84:b0:545:f1d:6f2c with SMTP id
 2adb3069b0e04-54990e5d4c2mr5402590e87.18.1741689490117; Tue, 11 Mar 2025
 03:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-2-brgerst@gmail.com>
 <20241206123207.GA2091@redhat.com> <CAMj1kXGKCJfBVqgsqjX1bA_SY=503Z-tJV893y5JAwoVs0BUfw@mail.gmail.com>
 <20241206142152.GB31748@redhat.com> <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
 <CAMzpN2iUi_q_CfDa53H8MEV_zkb8NRtXtQPvOwDrEks58=3uAg@mail.gmail.com>
 <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com>
 <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local> <CAMj1kXEK0Kgx-C8sOvWJ9rkmC0ioWDEb+tpM9BTeWVwOWyGNog@mail.gmail.com>
 <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local>
In-Reply-To: <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 11 Mar 2025 11:37:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrK06MMGiOLeXqn-RxFrz_Tgl974_VpGDYK6e2sdNyxF6FLCPKn4dvM90Y
Message-ID: <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with CONFIG_STACKPROTECTOR=n
To: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Mar 2025 at 11:24, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Mar 10, 2025 at 11:19:03PM +0100, Ard Biesheuvel wrote:
> > and no error.
>
> Oh fun.
>
> > Could you capture the output of
> >
> > objdump -dr .tmp_vmlinux2 --section .head.text
> >
> > and share it somewhere please?
>
> See attached.
>
> Now lemme try to bisect it, see what this machine says since it is magically
> toolchain or whatnot-specific. :-\
>

There are many occurrences of

ffffffff8373cb87: 49 c7 c6 20 c0 55 86 mov    $0xffffffff8655c020,%r14
ffffffff8373cb8a:         R_X86_64_32S __ref_stack_chk_guard

whereas the ordinary Clang uses R_X86_64_REX_GOTPCRELX here, which are
relaxed by the linker.

I suspect that Ubuntu's Clang 15 has some additional patches that
trigger this behavior.

We could add __no_stack_protector to __head to work around this.

