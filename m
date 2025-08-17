Return-Path: <stable+bounces-169885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556BEB292B6
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 12:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB24E1964FF2
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F022877CA;
	Sun, 17 Aug 2025 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="cC4/g1+y"
X-Original-To: stable@vger.kernel.org
Received: from wylie.me.uk (wylie.me.uk [82.68.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61D1A0728;
	Sun, 17 Aug 2025 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.68.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755427703; cv=none; b=l6G/r9+oN5ViNsElKSrxzJksgEXnfAdYpvjbfC51BQ8PI5l8f+dI0v18LXQ8JAP5HiA5AHTLGxHbc5mN6/jfKjg2pwFgPuGcn2Zh5Y1UcUyjO0pjl+53pW+iQwXSNPk5l30RPhZT5vhETx9j3pXsXHbzJp4y4NP2R8IBztaAL2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755427703; c=relaxed/simple;
	bh=8y/nQYrJexvHvsyddRBDWw78Fri3Me8pm4TUvREXXQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2VV0ij51hx1hCkREJdsoapPmrrzFwpG9FH3OXu8NSSw51Z9pvH8nh22+7IdpNC7tg3oIO8lOoHIN5d1RQdWbH9kSKPkYlS5pgwr9gATq0lDIY0bZz10CNQ7EZcgl3b/3TgXgTIVp9hauMAfXx8cYdWGDZuKv5ckmBSlRZrolm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk; spf=pass smtp.mailfrom=wylie.me.uk; dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b=cC4/g1+y; arc=none smtp.client-ip=82.68.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wylie.me.uk
Received: from frodo.int.wylie.me.uk (frodo.int.wylie.me.uk [192.168.21.2])
	by wylie.me.uk (Postfix) with ESMTP id A24591208FA;
	Sun, 17 Aug 2025 11:47:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
	s=mydkim006; t=1755427655;
	bh=8y/nQYrJexvHvsyddRBDWw78Fri3Me8pm4TUvREXXQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cC4/g1+yr026ZMQA4pQTypUdwOrCUm/i/AMvOGPKRzGFy3Z1OWA69q46Xj/PF5MYQ
	 /svATdqh5y0vvnG1f5znd06rKgFIof60VN5f/Rgal+Z8nKaMVoJhdpUj57MPJe6Pyz
	 VHSL9aFLZrZqoaqMi5dMqInOypweKiRWGSQq9AYpIaqsrPDFTBUx7DtUqNRr57KPP6
	 6e1eyvzDft3pboi7A/nEuZSEkJ2FPYjeE4XZkS5iBqoqws08o9MZNDi+gJTnH/W9FZ
	 Oc3Pmz8Fo3xvV9zAWyftvN15G21YxUTZlCZWUMEcb5xFDvjOLfSC/P29PHjJtJkx13
	 VYVom48nKqPyQ==
Date: Sun, 17 Aug 2025 11:47:34 +0100
From: "Alan J. Wylie" <alan@wylie.me.uk>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: XOP prefix instructions decoder support
Message-ID: <20250817114734.42e17904@frodo.int.wylie.me.uk>
In-Reply-To: <20250817093240.527825424989e5e2337b5775@kernel.org>
References: <175386161199.564247.597496379413236944.stgit@devnote2>
 <20250817093240.527825424989e5e2337b5775@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 09:32:40 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Alan, 
> 
> Can you test this with our cros-compile build?
> 
> Thank you,

Applies cleanly to both 6.16.0 and 6.16.1, builds natively on both on
my FX-8350 box and boots successfully on both.

Tested-by: Alan J. Wylie <alan@wylie.me.uk>

Thanks

Alan.

> 
> On Wed, 30 Jul 2025 16:46:52 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Support decoding AMD's XOP prefix encoded instructions.
> > 
> > These instructions are introduced for Bulldozer micro architecture,
> > and not supported on Intel's processors. But when compiling kernel
> > with CONFIG_X86_NATIVE_CPU on some AMD processor (e.g. -march=bdver2),
> > these instructions can be used.
> > 
> > Reported-by: Alan J. Wylie <alan@wylie.me.uk>
> > Closes: https://lore.kernel.org/all/871pq06728.fsf@wylie.me.uk/
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  arch/x86/include/asm/inat.h                        |   15 +++
> >  arch/x86/include/asm/insn.h                        |   51 +++++++++
> >  arch/x86/lib/inat.c                                |   13 ++
> >  arch/x86/lib/insn.c                                |   35 +++++-
> >  arch/x86/lib/x86-opcode-map.txt                    |  111 ++++++++++++++++++++
> >  arch/x86/tools/gen-insn-attr-x86.awk               |   44 ++++++++
> >  tools/arch/x86/include/asm/inat.h                  |   15 +++
> >  tools/arch/x86/include/asm/insn.h                  |   51 +++++++++
> >  tools/arch/x86/lib/inat.c                          |   13 ++
> >  tools/arch/x86/lib/insn.c                          |   35 +++++-
> >  tools/arch/x86/lib/x86-opcode-map.txt              |  111 ++++++++++++++++++++
> >  tools/arch/x86/tools/gen-insn-attr-x86.awk         |   44 ++++++++
> >  .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |    2 
> >  13 files changed, 513 insertions(+), 27 deletions(-)



-- 
Alan J. Wylie     https://www.wylie.me.uk/     mailto:<alan@wylie.me.uk>

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience

