Return-Path: <stable+bounces-159227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FADAAF1229
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 12:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F26B1C407AB
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0532571DA;
	Wed,  2 Jul 2025 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b="Sm4qnWfZ"
X-Original-To: stable@vger.kernel.org
Received: from gbr-app-1.alpinelinux.org (gbr-app-1.alpinelinux.org [213.219.36.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8B182D0
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.219.36.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452977; cv=none; b=GnZ7kk9nIiu/1rY/yhl6cJAq2uw0R1zaA6XkVM1IUeKrcbE7CwOyjXm8jzn81w5WY5xSzKidseA5/1gfB6f0w83u6vXTrIiVASielO802z0uhCtvZrxiBZz8EFp7cRKohGAn0bcSWS0ZIV52Iaa0+syiJXo8Xmb6LteruurOszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452977; c=relaxed/simple;
	bh=DUc3Z9IrKtC636KTDUahr2LgTAK2oVb/ZlZJBWaY9cU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReSBpXdvVrOFXwzyW+x/IsdN5dJFmGMAZ8geV1Zaglp2GXjK512AbJH26G09sSvEMx3MwLeNXWnHtsZnV2FTmqfRgysa42xP4JvDMeh/sZZ3bVUURg2HOBSSKCzWvgdsmcq/fti6Y5e8dYjy1cD45VhhLgzkhapB3Xadeb7Ntzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org; spf=pass smtp.mailfrom=alpinelinux.org; dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b=Sm4qnWfZ; arc=none smtp.client-ip=213.219.36.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpinelinux.org
Received: from ncopa-desktop (unknown [IPv6:2001:4646:fb05:0:4fb5:52fd:8640:8e74])
	(Authenticated sender: ncopa@alpinelinux.org)
	by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id 990B22235BE;
	Wed,  2 Jul 2025 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
	s=smtp; t=1751452973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6J/8oqixf3r0pd99QlA4EJMgd8zRX4okR0pgaVruqM=;
	b=Sm4qnWfZZK4AsDful0ncKnRJJ9iVSNPvTLow9lnt4NaVLyuuoFqFvwpcIu/slnAEnYM9LD
	YPMVT6Ln/Q+MwnZGo3WD0qZ/SDhN99AqLcHU47mA6SHN1BFIk/+Ru/g2wWjlSxUqssgKhC
	SnkHEzhKm9SrqYqPMwD1chpOfVP0sF8=
Date: Wed, 2 Jul 2025 12:42:47 +0200
From: Natanael Copa <ncopa@alpinelinux.org>
To: Sergio =?ISO-8859-1?B?R29ueuFsZXo=?= Collado <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, Achill Gilgenast
 <fossdd@pwned.life>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] v6.12.35: (build) kallsyms.h:21:10: fatal error:
 execinfo.h: No such file or directory
Message-ID: <20250702124247.7540ec3a@ncopa-desktop>
In-Reply-To: <CAA76j90io241-a+2SDLfAMHY2ro4x-Bstw4AxKDOU_izW9goYg@mail.gmail.com>
References: <20250701141026.6133a3aa@ncopa-desktop>
	<CAA76j90io241-a+2SDLfAMHY2ro4x-Bstw4AxKDOU_izW9goYg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-alpine-linux-musl)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Jul 2025 19:07:32 +0200
Sergio Gonz=E1lez Collado <sergio.collado@gmail.com> wrote:

> Hello,

Hi Sergio,

>  Thanks for pointing that out. I was not aware of it.

No worries. It happens. Just slightly unfortunate that it tickled down
to stable branches before it got fixed.

It is trivial to fix but I wonder what is the best way though. Achill
proposed to use #ifdef HAVE_BACKTRACE_SUPPORT in
tools/include/linux/kallsyms.h but it appears that this was included
only for KSYM_NAME_LEN.

KSYM_NAME_LEN appears to be defined multiple places:

$ rg 'KSYM_NAME_LEN\s+512'
include/linux/kallsyms.h
18:#define KSYM_NAME_LEN 512

tools/include/linux/kallsyms.h
9:#define KSYM_NAME_LEN 512

tools/lib/perf/include/perf/event.h
107:#define KSYM_NAME_LEN 512

tools/lib/symbol/kallsyms.h
10:#define KSYM_NAME_LEN 512

scripts/kallsyms.c
34:#define KSYM_NAME_LEN                512

So I wonder if it would be acceptable to simply:

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decod=
er_test.c
index 08cd913cbd4e..7916bf487ed2 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -10,7 +10,6 @@
 #include <assert.h>
 #include <unistd.h>
 #include <stdarg.h>
-#include <linux/kallsyms.h>
=20
 #include <asm/insn.h>
 #include <inat.c>
@@ -105,6 +104,7 @@ static void parse_args(int argc, char **argv)
        }
 }
=20
+#define KSYM_NAME_LEN 512
 #define BUFSIZE (256 + KSYM_NAME_LEN)
=20
 int main(int argc, char **argv)

I am also confused with who should be in the CC list.

Thanks!
-nc
=20
> On Tue, 1 Jul 2025 at 14:10, Natanael Copa <ncopa@alpinelinux.org> wrote:
> >
> > Hi!
> >
> > I bumped into a build regression when building Alpine Linux kernel 6.12=
.35 on x86_64:
> >
> > In file included from ../arch/x86/tools/insn_decoder_test.c:13:
> > ../tools/include/linux/kallsyms.h:21:10: fatal error: execinfo.h: No su=
ch file or directory
> >    21 | #include <execinfo.h>
> >       |          ^~~~~~~~~~~~
> > compilation terminated.
> >
> > The 6.12.34 kernel built just fine.
> >
> > I bisected it to:
> >
> > commit b8abcba6e4aec53868dfe44f97270fc4dee0df2a (HEAD)
> > Author: Sergio Gonz_lez Collado <sergio.collado@gmail.com>
> > Date:   Sun Mar 2 23:15:18 2025 +0100
> >
> >     Kunit to check the longest symbol length
> >
> >     commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.
> >
> > which has this hunk:
> >
> > diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_d=
ecoder_test.c
> > index 472540aeabc2..6c2986d2ad11 100644
> > --- a/arch/x86/tools/insn_decoder_test.c
> > +++ b/arch/x86/tools/insn_decoder_test.c
> > @@ -10,6 +10,7 @@
> >  #include <assert.h>
> >  #include <unistd.h>
> >  #include <stdarg.h>
> > +#include <linux/kallsyms.h>=20
> >
> >  #define unlikely(cond) (cond)
> >
> > @@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
> >         }
> >  }
> >
> > -#define BUFSIZE 256
> > +#define BUFSIZE (256 + KSYM_NAME_LEN)
> >
> >  int main(int argc, char **argv)
> >  {
> >
> > It looks like the linux/kallsyms.h was included to get
> > KSYM_NAME_LEN. Unfortunately it also introduced the include of
> > execinfo.h, which does not exist on musl libc.
> >
> > This has previously been reported to and tried fixed:
> > https://lore.kernel.org/stable/DB0OSTC6N4TL.2NK75K2CWE9JV@pwned.life/T/=
#t
> >
> > Would it be an idea to revert commit b8abcba6e4ae til we have a
> > proper solution for this?
> >
> > Thanks!
> >
> > -nc =20


