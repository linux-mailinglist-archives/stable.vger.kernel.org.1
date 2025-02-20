Return-Path: <stable+bounces-118525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD22A3E78B
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 23:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467774210AF
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 22:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1BE1EEA5E;
	Thu, 20 Feb 2025 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT40j2HT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978B1DDC3B;
	Thu, 20 Feb 2025 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090822; cv=none; b=jTlYe1rUZRgq9EmIuEG9Z5vGIPjC3HwvokoAiFNgate+NVcsMbRUhPs78cOORwowkwcruVvxl773TlRWWmqQIIynUl6fNj/umM0go+S21nwba11ZGq0AHTwQOY2Ya0oSpLhwYwLPxOUAzjCvkJ3a9aQRe9pT90C1EkHEN7x7PK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090822; c=relaxed/simple;
	bh=GZP0hAL8CZE2pxOWI9s57ubBFMFVoeEqc+ujzonTdOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeRS8FbrAeoOzkl46mpTUo58Qlay4mr+5NG/5itAHioeRQSAC/pglTyoNJvbbeOd6/tQRDKvloF3naaHx99ZG9xQE1xS6S2qcLDHIG4K7MWJwVLhZ0Ytmh6j/EoZBpBl7beJYpz6ZiWWTNoK41zXihFaGg53iQIKZwTQwi5iRMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT40j2HT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3710CC4CED1;
	Thu, 20 Feb 2025 22:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740090822;
	bh=GZP0hAL8CZE2pxOWI9s57ubBFMFVoeEqc+ujzonTdOQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LT40j2HT9ptC2x5elOWRf26buC8aAGhDm1Wjn1UPHC3tSXv+WbBhcz3yacbyg+mCi
	 9TgUC71R8/bFMnmNOQ73os1UJVdT90f4e81TP569DeRxLZ2JRwLhG7L9syKqAksO97
	 kEJcbpCWBWFemUdjrXzDda7ZmgPk2jovDZJ3RKRXuv/uH5C2pVf9Z8wVhfT4Z/I0JS
	 XwXi/YdbwpGtjR5yC/5vkyL24dtiRsYUSmKqYmKCqNV7UpA9fgtjspChpFnUac+jxi
	 ITrLxFtpeEf+WROqz01llQ8BAZlqJrSoAVRCVSnHoHdldG1vTqQNuNMd5sSItSZ7Jx
	 TPMwQjjnQhIHw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54622e97753so1395506e87.0;
        Thu, 20 Feb 2025 14:33:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhHQT6FmMrhhmWdcEEvwM6rdwTx8tQ7eQmMt/bUJhvFJLJSSEYExDmT5yxoO7uhQXdbiqUEMsuCoQVYeo=@vger.kernel.org, AJvYcCXdQJ42oMLlbNprle9ZY7hsCZm7/VOZBYLJMEUwev77YIMIu9haL2CuNF368BNo0n5LrW5Gd14Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyquBFe6R/Al+ZA8vC+KUBwuNfuYUUXdyx8WArCbf/rTNBo8HLu
	dhqomv9WqgA091Nu1RpXMVazFwvMOywmz5aBsNTc8ruWsFI5TWoYsdU2uRAsMddSH+jIbGylFKa
	TtwDUK9CET509IXmqHMgulXjWoQA=
X-Google-Smtp-Source: AGHT+IHtzINxTb0cHtYeV0gMkaKzC0ALxl+9shqA+p1/eaWGCFQfD3jrxzRDozzTo0nKp7aqRn0lAJfdDhl3vwNr4DA=
X-Received: by 2002:a05:6512:3d8b:b0:545:81b:1516 with SMTP id
 2adb3069b0e04-54838c73e38mr274842e87.15.1740090820585; Thu, 20 Feb 2025
 14:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219105542.2418786-4-ardb+git@google.com> <20250219105542.2418786-5-ardb+git@google.com>
 <20250220205536.ty7mpvhqmi43zgll@jpoimboe>
In-Reply-To: <20250220205536.ty7mpvhqmi43zgll@jpoimboe>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 20 Feb 2025 23:33:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH3RoAGQSG8KL1mkmiGbqi68CYFAuJSwBPdbt2b=7RUfA@mail.gmail.com>
X-Gm-Features: AWEUYZlESxK12Tah6Nlx6Nw98OAhhB7vd6vh4FDSJgG4-_vnG5ZIRapYh59JRyA
Message-ID: <CAMj1kXH3RoAGQSG8KL1mkmiGbqi68CYFAuJSwBPdbt2b=7RUfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] asm-generic/vmlinux.lds: Move .data.rel.ro input
 into .rodata segment
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 21:55, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Wed, Feb 19, 2025 at 11:55:44AM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
>
> BTW, I was copied on the cover letter but not the individual patches.
>
> > When using -fPIE codegen, the compiler will emit const global objects
> > (which are useless unless statically initialized) into .data.rel.ro
> > rather than .rodata if the object contains fields that carry absolute
> > addresses of other code or data objects. This permits the linker to
> > annotate such regions as requiring read-write access only at load time,
> > but not at execution time (in user space).
>
> Hm, this sounds more like __ro_after_init, are we sure the kernel
> doesn't need to write it early?
>

It does need to write to it early, for KASLR relocation. So
conceptually, it is the same as .rodata. __ro_after_init conceptually
remains writable for longer.

In practice, they are all treated the same so it doesn't really matter.

> > This distinction does not matter for the kernel, but it does imply that
> > const data will end up in writable memory if the .data.rel.ro sections
> > are not treated in a special way.
> >
> > So emit .data.rel.ro into the .rodata segment.
>
> This is a bug fix, right?  Since the RO data wasn't actually RO?  That's
> not clear in the title.
>

Yes, it is. I'll clarify that.

