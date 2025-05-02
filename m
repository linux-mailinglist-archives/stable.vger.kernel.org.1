Return-Path: <stable+bounces-139425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 859F6AA68A0
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 04:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDA31BC1D8B
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 02:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED69614C5B0;
	Fri,  2 May 2025 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fC3NKU6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB6E645;
	Fri,  2 May 2025 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746151766; cv=none; b=hNS26HpnNYlw43gMPJGhkHfvncj3hyLruyTd23BxogS+WF1tbI1rIljLLoqu/Wu5g9vPASvro8DqenI3SFW8jvvVs5PMvg44GyuXygVw4r0Tsp3qlpIlyGedO3FqjpL59zEUkCCw+iN5y/cbn0PvS3LHGB7WHdKLuHPgzlTSSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746151766; c=relaxed/simple;
	bh=9iY+NUlySSfWDQWhHXatksr+kpAmZtFcMt3RcEBPtpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PL+k3Fz/zfXmd+ri/oGtEdyyopL6S6hyEItCOiyAmsJb0DQ1lynhUA8tnoQuEuk0WVp2jJqijmM8XGonXTgWDIJWUrMizX4Kz8sMDC3UBZjFKoI2BwQi3Lb95Y+0Swe2NtToYwZ3EPuiZbQeOntTIPuEwl4xrMuvHVjQpjkg4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fC3NKU6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3055C4CEE3;
	Fri,  2 May 2025 02:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746151766;
	bh=9iY+NUlySSfWDQWhHXatksr+kpAmZtFcMt3RcEBPtpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fC3NKU6Y0J3lOBeZTn3kzJeq0iEMx5lMxrEERVYpD4Zol6ZH8dg7UqglysVyxbJKG
	 fyIiqPx9mrx0wNtSTZEXFwXzneUd7RtMe2ISX5ihQNZxsRC3nrHXuI5DpBY9E/1Sn3
	 1t+lGcsJKcesFCAVGwew6IgfFHWgbiz7RM7rGuWE3lQlcnlZbuJ1AVVn0RO+dTwwcA
	 aj81SzTmhEcbUtkvjGQKIZ3Z+a/Q7e7cGpaDzJLwnJOymU5gufpJGUZVBm+37i6W7f
	 OOXCwsQYK0Z37yzblLo8D5zBvaR6H35H7oEIPXP2uAH2MyKAQTGR9Egv4uTZclClso
	 M0ADYEgWeZkYw==
Date: Thu, 1 May 2025 19:09:19 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, stable@vger.kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Marcus Seyfarth <m.seyfarth@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/2] include/linux/typecheck.h: Zero initialize dummy
 variables
Message-ID: <20250502020919.GB1744689@ax162>
References: <20250501-default-const-init-clang-v1-0-3d2c6c185dbb@kernel.org>
 <20250501-default-const-init-clang-v1-2-3d2c6c185dbb@kernel.org>
 <CAHk-=whL8rmneKbrXpccouEN1LYDtEX3L6xTr20rkn7O_XT4uw@mail.gmail.com>
 <20250502012449.GA1744689@ax162>
 <CAHk-=wif4eOpn3YaUXMKUhSrF1t-2ABasBiBRXR2Mxm059yXqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wif4eOpn3YaUXMKUhSrF1t-2ABasBiBRXR2Mxm059yXqQ@mail.gmail.com>

On Thu, May 01, 2025 at 06:34:57PM -0700, Linus Torvalds wrote:
> On Thu, 1 May 2025 at 18:24, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > but '= {0}' appears to work: https://godbolt.org/z/x7eae5vex
> >
> > If using that instead upsets sparse still, then I can just abandon this
> > change and update the other patch to disable -Wdefault-const-init-unsafe
> > altogether (
> 
> The "= { 0 }" form makes sparse unhappy for a different reason:
> 
>        void *a = { 0 };
> 
> makes sparse (correctly) complain about the use of '0' for 'NULL'.
> 
>     warning: Using plain integer as NULL pointer
> 
> and gcc has also finally adopted that warning for braindamage:
> 
>     warning: zero as null pointer constant [-Wzero-as-null-pointer-constant]

> although it's not on by default (and apparently we've never enabled it
> for the kernel - although we really should).
> 
> sparse has complained about this since day one, because I personally
> find the "plain 0 as NULL" to be a complete BS mistake in the language
> (that came from avoiding a keyword, not from some "design" reason),
> and while it took C++ people three decades to figure that out, in the
> end they did indeed figure it out.

Yeah, that is all entirely reasonable. It does not really seem like
there is a clean way to deal with this with our matrix (aside from
something like a local __diag_push() sequence, which I understand you do
not like), so I will abandon this and just turn off the warning entirely
(unless folks have other ideas). I am not really sure we will miss it
because clang will still warn if the variable is used uninitialized
since -Wuninitialized is enabled in -Wall.

  $ cat test.c
  int main(void)
  {
      const int a, b;
      return a;
  }

  $ clang -fsyntax-only test.c
  test.c:3:15: warning: default initialization of an object of type 'const int' leaves the object uninitialized and is incompatible with C++ [-Wdefault-const-init-var-unsafe]
      3 |     const int a, b;
        |               ^
  test.c:3:18: warning: default initialization of an object of type 'const int' leaves the object uninitialized and is incompatible with C++ [-Wdefault-const-init-var-unsafe]
      3 |     const int a, b;
        |                  ^
  2 warnings generated.

  $ clang -fsyntax-only -Wuninitialized test.c
  test.c:3:15: warning: default initialization of an object of type 'const int' leaves the object uninitialized and is incompatible with C++ [-Wdefault-const-init-var-unsafe]
      3 |     const int a, b;
        |               ^
  test.c:3:18: warning: default initialization of an object of type 'const int' leaves the object uninitialized and is incompatible with C++ [-Wdefault-const-init-var-unsafe]
      3 |     const int a, b;
        |                  ^
  test.c:4:12: warning: variable 'a' is uninitialized when used here [-Wuninitialized]
      4 |     return a;
        |            ^
  test.c:3:16: note: initialize the variable 'a' to silence this warning
      3 |     const int a, b;
        |                ^
        |                 = 0
  3 warnings generated.

Cheers,
Nathan

