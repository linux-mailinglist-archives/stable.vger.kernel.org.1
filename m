Return-Path: <stable+bounces-171867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C47B2D0E4
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 03:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACCB52610F
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 01:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1782D1922D3;
	Wed, 20 Aug 2025 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+Egs0IY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F3EACD;
	Wed, 20 Aug 2025 01:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651750; cv=none; b=Io4oT2eRWpa8f6lkSFA7rnfZjR+03QBo+kemgkxKIv++nQR1xxR5iS0wsdIQeZePS6H9xt3qT9X20xg4dzt+MLRzTwoJI2RXW8szE4rbEFHF1oK1mCBqb9VBMAtD4oOEER9K8ebG1D6KsB6m0GJn+lI+pjkUrM7RZXHknxWHdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651750; c=relaxed/simple;
	bh=zN9F2urgnydClYzhbY8LGUEx2A95Kli5ZSO3hAroYX0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RsCm4LOtbuPsq9R+4QpiUnvTQL5I3rxR4pVfHX8lh9C3htRpJdwweRL9ygHOGCYgp8qPN6ICX6xSh4Md+2YLZ1NU2ZYVbXrBYxpVHEDj3XDyvsCZ3uEYE5AvCLwtPL7Xcmn6h1IFCK0TAiMmPOGkoww5gEx0R41DzmQHwi2vNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+Egs0IY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE86C4CEF1;
	Wed, 20 Aug 2025 01:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755651750;
	bh=zN9F2urgnydClYzhbY8LGUEx2A95Kli5ZSO3hAroYX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G+Egs0IYhgMABbLmL5jxkm1Yn8WS5mkz8L3nl9ilGRj37X8A9XZOEopDkBcLXAZ8u
	 7pdok9KnVVqNFaKyhbIlmXnYyDTfTMLgOqMXlGHGJHZC7QQ3x+EOM8b/z4RtfkztJ9
	 YPcIYtdxlLDszj2cnR8XscubhUGTSssmbkEGcd96DT3nMgWzXVJEq7RYkk4Me66t+Q
	 uJOBXpDLOZo+JRc8XdkbeJrLn8BGUgp/10xtwH4ZYJHr67q+hwTQyHMd96JsW86Am6
	 2t/3PnYVEt/BgHdRTl6nARsZU1yf30i+jwqmYuWQqKHSKOhicH4eSDl6Ba6R2lyFDp
	 UXBD1T3oHhyzQ==
Date: Wed, 20 Aug 2025 10:02:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Alan J. Wylie" <alan@wylie.me.uk>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: XOP prefix instructions decoder support
Message-Id: <20250820100224.ece0bc4483521b309991133a@kernel.org>
In-Reply-To: <20250817114734.42e17904@frodo.int.wylie.me.uk>
References: <175386161199.564247.597496379413236944.stgit@devnote2>
	<20250817093240.527825424989e5e2337b5775@kernel.org>
	<20250817114734.42e17904@frodo.int.wylie.me.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 11:47:34 +0100
"Alan J. Wylie" <alan@wylie.me.uk> wrote:

> On Sun, 17 Aug 2025 09:32:40 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hi Alan, 
> > 
> > Can you test this with our cros-compile build?
> > 
> > Thank you,
> 
> Applies cleanly to both 6.16.0 and 6.16.1, builds natively on both on
> my FX-8350 box and boots successfully on both.
> 
> Tested-by: Alan J. Wylie <alan@wylie.me.uk>

Thank you for testing!



> 
> Thanks
> 
> Alan.
> 
> > 
> > On Wed, 30 Jul 2025 16:46:52 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Support decoding AMD's XOP prefix encoded instructions.
> > > 
> > > These instructions are introduced for Bulldozer micro architecture,
> > > and not supported on Intel's processors. But when compiling kernel
> > > with CONFIG_X86_NATIVE_CPU on some AMD processor (e.g. -march=bdver2),
> > > these instructions can be used.
> > > 
> > > Reported-by: Alan J. Wylie <alan@wylie.me.uk>
> > > Closes: https://lore.kernel.org/all/871pq06728.fsf@wylie.me.uk/
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > ---
> > >  arch/x86/include/asm/inat.h                        |   15 +++
> > >  arch/x86/include/asm/insn.h                        |   51 +++++++++
> > >  arch/x86/lib/inat.c                                |   13 ++
> > >  arch/x86/lib/insn.c                                |   35 +++++-
> > >  arch/x86/lib/x86-opcode-map.txt                    |  111 ++++++++++++++++++++
> > >  arch/x86/tools/gen-insn-attr-x86.awk               |   44 ++++++++
> > >  tools/arch/x86/include/asm/inat.h                  |   15 +++
> > >  tools/arch/x86/include/asm/insn.h                  |   51 +++++++++
> > >  tools/arch/x86/lib/inat.c                          |   13 ++
> > >  tools/arch/x86/lib/insn.c                          |   35 +++++-
> > >  tools/arch/x86/lib/x86-opcode-map.txt              |  111 ++++++++++++++++++++
> > >  tools/arch/x86/tools/gen-insn-attr-x86.awk         |   44 ++++++++
> > >  .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |    2 
> > >  13 files changed, 513 insertions(+), 27 deletions(-)
> 
> 
> 
> -- 
> Alan J. Wylie     https://www.wylie.me.uk/     mailto:<alan@wylie.me.uk>
> 
> Dance like no-one's watching. / Encrypt like everyone is.
> Security is inversely proportional to convenience


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

