Return-Path: <stable+bounces-126805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD08A723EE
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 23:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F21216C7BC
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 22:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA93263F28;
	Wed, 26 Mar 2025 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwSh2KGo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF7725FA2B;
	Wed, 26 Mar 2025 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028141; cv=none; b=KvQaZkoOEKUDhmKlepgequRvg7r9rM9ifFItLztmdSoE3A6w8XJLV9ffrdWnWLte8XY6u8vpMu6x9IXv/+AvRqG1Ai/DQtqc+WnxzH9pxl73j/oG6Mi/ZiNMA4SiAx5EJGZ1DYG6I8iIitP/Vq5deuVO1QweIawLhnVe3Vo+AX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028141; c=relaxed/simple;
	bh=RGQ79AL+YiCZDMaPjLjHdeFsWSeNiy/I9zBCHtxfCFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwWDkQo0i4gp3U1lceJUKMBwjOj5AAuEX5Zjd2duOfYFt6RmKjrXRG52DuUvPLdQLwi0WgVGnZKoGPrXvA2cxmoD+HursLcIWqaEXPaVI9pWP01Lom0Kl0hn+whrKJQjLOdU1OZUoTAgq+StQklZoaDdCzP7ah9nIGgiCWq/95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwSh2KGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68863C4CEE2;
	Wed, 26 Mar 2025 22:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743028140;
	bh=RGQ79AL+YiCZDMaPjLjHdeFsWSeNiy/I9zBCHtxfCFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwSh2KGoDSh0k9ts3ex8EcysqoerhYeP/RsZiGcucNqQVE1V3ACizOw2bsLjFPc5L
	 ohKa3ymzYuSCCleA4smeL3fXqp2s2/mPaTlYJQPECmIzIqUY8r3qBPYiFw1yz77owJ
	 cRc1+91Ctf2zNlup9JhvmjNTNL20h9RqpHqSMyb1VgyMy+dE5fT+busfiPQcDSIXGf
	 an6FrcoaFmKjm8sBW0fxJ2UYxjvrX+1SQL9VcfE4oYvWC/PGXWd/fFVrt3+qtg7NMj
	 k0x8Ws2Q1pZkFa1uKog0G7WNcJ9S2fY+QVXVzsde9F6U1eEZL9lmslwuTwa52L8uzs
	 xKzZzFRwmHvEQ==
Date: Wed, 26 Mar 2025 15:28:55 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] lib/string.c: Add wcslen()
Message-ID: <20250326222855.GA378784@ax162>
References: <20250326-string-add-wcslen-for-llvm-opt-v2-0-d864ab2cbfe4@kernel.org>
 <20250326-string-add-wcslen-for-llvm-opt-v2-2-d864ab2cbfe4@kernel.org>
 <CAHp75Vd_mJggRRLfziWUf0tgr3K125uVBNh9VdSo9LHVJz2r_w@mail.gmail.com>
 <CAHp75VdQv=0wvgMDGNoXojALWh2B-92gjkO7zrv=d42ocamM4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdQv=0wvgMDGNoXojALWh2B-92gjkO7zrv=d42ocamM4Q@mail.gmail.com>

On Wed, Mar 26, 2025 at 08:41:44PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 26, 2025 at 8:39 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Mar 26, 2025 at 7:19 PM Nathan Chancellor <nathan@kernel.org> wrote:
> 
> ...
> 
> > > --- a/include/linux/string.h
> > > +++ b/include/linux/string.h
> > > @@ -7,6 +7,7 @@
> > >  #include <linux/cleanup.h>     /* for DEFINE_FREE() */
> > >  #include <linux/compiler.h>    /* for inline */
> > >  #include <linux/types.h>       /* for size_t */
> >
> > > +#include <linux/nls_types.h>   /* for wchar_t */
> >
> > I know it's not ordered, but can we at least not make it worse, i.e.
> > squeeze this to be after the compiler.h? Or even somewhere after below
> > the err*.h? Whatever gives a better (sparsely) ordered overall
> > result...
> 
> I just checked, and the only unordered piece is those two: types +
> stddef right now, and if you move nls_types.h after errno.h it will
> keep the status quo.
> 
> > >  #include <linux/stddef.h>      /* for NULL */
> > >  #include <linux/err.h>         /* for ERR_PTR() */

Yeah, I had noticed there was no alphabetical consistency, so I decided
to use this place to keep the types together but I have no strong
opinion. I can send v3 tomorrow unless Kees is happy with this version
and is okay with just applying this diff on top.

Cheers,
Nathan

diff --git a/include/linux/string.h b/include/linux/string.h
index 4a48f8eac301..750715768a62 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -7,10 +7,10 @@
 #include <linux/cleanup.h>	/* for DEFINE_FREE() */
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
-#include <linux/nls_types.h>	/* for wchar_t */
 #include <linux/stddef.h>	/* for NULL */
 #include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/errno.h>	/* for E2BIG */
+#include <linux/nls_types.h>	/* for wchar_t */
 #include <linux/overflow.h>	/* for check_mul_overflow() */
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>

