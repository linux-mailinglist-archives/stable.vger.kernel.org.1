Return-Path: <stable+bounces-33798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A3A8929E2
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B792EB2201D
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA13BA34;
	Sat, 30 Mar 2024 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJvnjLMe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9763320B
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789658; cv=none; b=E39NUn3l5De1mXehDLi09q7ReJy8UG3NUtEAv0Fd4wlX+SsCLF1ZnuYxzrXHBi52nY5+l5dkbUn2eJqFSxISPi3GprN5LWwKMMXb0+2vou8vD3t6SeRA6LpTZadXnSKe4mhiqsEpNUuDDAhF28hxO6KMcIxGzg3AwnompbaHTAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789658; c=relaxed/simple;
	bh=ZSeCR6BCDm96IuSAipNes2qfDZabDsf3w7yLGFimvm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMk+9S0pUVshQLLZMcRxZIM/kx/j/IOpAmbe7h9/HAxY2jWUKDSIvpaaUnLx1zGENvwkDEH96shG5A/RTTYAtT8Hx0O4mRTwsiU1dkF98cYrYtpQN3+guqu0+iCBhc5z0OrEfnAMKJGP3j7PXe80QKjSX7WSrAFz76OKBT90whs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJvnjLMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBCCC433C7
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711789658;
	bh=ZSeCR6BCDm96IuSAipNes2qfDZabDsf3w7yLGFimvm8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oJvnjLMetKjkhnJf7EVWaaqowjy3FX2Ke919HXKZNdfLPZX+IwC4z6CIcbvnh2HX+
	 tVaq2s3FlOe49fhZQKXg8kqv8CaRPySoh1oi+ayvUTgWJKPDSgPlteZwAHdF6rlIKT
	 BUjubuGaBI0AbenxgEKt3Q7beg4VnaCO7VrnpzPC1TkiHohSgwufYOFKrKDegWs+/a
	 1c3db52EgNxVmhn5BAkqivW8vH8/Ggjm1zzf34N5p3ViViaWqlszgW1RLQHFZzgV3p
	 JcKuzmr6eppsrepInjavkkgX2MdcZjd4Q06A/WVhjADb0fruLpjMl9KnX+skgWnQpG
	 kvi7XzT37MWWQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d4979cd8c8so25716921fa.0
        for <stable@vger.kernel.org>; Sat, 30 Mar 2024 02:07:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzf3jbq/V1tJu2vbaex0xEOjOkkUNtdFTJJItztfSLlWJ1kcx464Mnwc8l31J2uQhUO3t/RBw8VDj/+Oqs4W72i53tukBd
X-Gm-Message-State: AOJu0YwzsVuy8iy2z4WpOW50N91evWkh0MuV80IvY97vnhhyzxKm2R+D
	sq7ScFYPaXe14pRjxcbjs6W49vjjp8nF5Cz72VGyf195ohI8Nr5NasjLvgZKm+bAEVw8D/TqKa0
	rVaH0i5KRZj4mS3HZsDgvUsqJ1m4=
X-Google-Smtp-Source: AGHT+IG29ck8CD2uBXeSkjAyUvjwr4cIoGkQf6qVmjlPU2GufvRJ6NxVEJfTEFFWvGX2srSxcXYz1+6KlFkiwGJDF/o=
X-Received: by 2002:a2e:900c:0:b0:2d4:a7cc:203c with SMTP id
 h12-20020a2e900c000000b002d4a7cc203cmr2309280ljg.26.1711789656821; Sat, 30
 Mar 2024 02:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329181800.619169-5-ardb+git@google.com> <20240329181800.619169-8-ardb+git@google.com>
 <2024033004-mutilator-alumni-358b@gregkh>
In-Reply-To: <2024033004-mutilator-alumni-358b@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 30 Mar 2024 11:07:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE4rrrmDFnsO4hgufKEb3jdOEKuTAN1ONqWsGh=X38afA@mail.gmail.com>
Message-ID: <CAMj1kXE4rrrmDFnsO4hgufKEb3jdOEKuTAN1ONqWsGh=X38afA@mail.gmail.com>
Subject: Re: [PATCH -stable-6.1 resend 4/4] x86/sev: Fix position dependent
 variable references in startup code
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, stable@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Borislav Petkov <bp@alien8.de>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Mar 2024 at 11:03, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 29, 2024 at 07:18:04PM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > [ Commit efec46b78cf062b7eab009c624cf32dfdab99aa7 upstream ]
>
> That's not the id in Linus's tree, or anywhere else, let me dig...
>
> It's really 1c811d403afd73f04bde82b83b24c754011bd0e8.  I'll use that
> here, thanks.
>

Oops my bad.

