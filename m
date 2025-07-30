Return-Path: <stable+bounces-165199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4355BB15A64
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 10:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF549189A975
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958A52512D8;
	Wed, 30 Jul 2025 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIU54rE/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCEB187326;
	Wed, 30 Jul 2025 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753863624; cv=none; b=UQfK/IfWocvLr7SrWjTJhiSP3qc+NkCk5MTxPWfVj2oZQrmurjwcikaM8F31lNDPufOlnb00p/tygkFHD95qUgRlOdghz/fRJByWvXuuEEEh5ad8PP9/+JDCHKcL/nw32BbWS4PlhRrcI0sE3+IxBXJzmyhPPV3oz3PaQt/B7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753863624; c=relaxed/simple;
	bh=G2xhbiG9MhxwFQfbZuB+oDrqa9cbn97T9Zn90EGVbF0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PhYVSl1H/XgR6MVVA927vDVOsKlHdE546rjiFy/Ebo5rkgDoSXPCvdTYbflmsouBwjV79zx77fRX4tH8SliRuJI+xkib9s79n/XGfMQdZNxZmxwT0MjLkxC0VZXDbeDgVs1CATmL9ArCTq4OWGcEXtKdyBa3mY8KdaSY8QXAWvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIU54rE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE72C4CEF5;
	Wed, 30 Jul 2025 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753863623;
	bh=G2xhbiG9MhxwFQfbZuB+oDrqa9cbn97T9Zn90EGVbF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gIU54rE/53PmhiwB/a0q1TUMwg6FBnJm8rOIhcfkpcIf3TnXT5tJYQOq2om+0SfAb
	 va+0nhaPM2mySuzIQuHiRS1yF9fJr0KHugT9fcDyKZJE9VBTJA3mcKm2C4vv22HEqP
	 MSj4+h89kLmi6G5zTK2s4WChbvBA74cevzu5iY3BCf7hEJNh2Q9uxXVa+6YZdAy/1B
	 VtMhDon9WBCd8SUPzQycZt1H+gAvrZokQx7ucmeRl+EGdVQ5BD7xi4Z0AJxjtZW4L0
	 EzmBm56rCDVMlOUjWy1Qd1MnpwEG+3wggI+on2PDjIFhlF6Y87UPOB/kJvP4uXUsQx
	 /RO/Zw4u25ebg==
Date: Wed, 30 Jul 2025 17:20:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, "Alan J. Wylie"
 <alan@wylie.me.uk>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: "stack state/frame" and "jump dest instruction" errors (was Re:
 Linux 6.16)
Message-Id: <20250730172020.00a4dd1ad453d94c7ef47f30@kernel.org>
In-Reply-To: <20250729224000.2f23f59acc79a78f47c1624f@kernel.org>
References: <CAHk-=wh0kuQE+tWMEPJqCR48F4Tip2EeYQU-mi+2Fx_Oa1Ehbw@mail.gmail.com>
	<871pq06728.fsf@wylie.me.uk>
	<hla34nepia6wyi2fndx5ynud4dagxd7j75xnkevtxt365ihkjj@4p746zsu6s6z>
	<20250729224000.2f23f59acc79a78f47c1624f@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 22:40:00 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 28 Jul 2025 08:42:44 -0700
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > On Mon, Jul 28, 2025 at 09:41:35AM +0100, Alan J. Wylie wrote:
> > > #regzbot introduced: 6.15.8..6.16
> 
> > I don't have time to look at this for at least the next few days, but I
> > suspect this one:
> > 
> >      1a3:	8f ea 78 10 c3 0a 06 00 00 	bextr  $0x60a,%ebx,%eax
> 
> Thanks for finding!
> Indeed, this is encoded by XOP which is not currently supported
> by x86 decodeer. 
> 
> > 
> > in which case the kernel's x86 decoder (which objtool also uses) needs
> > to be updated.
> 
> OK, let me see how XOP works.

I've sent it to;

https://lore.kernel.org/all/175386161199.564247.597496379413236944.stgit@devnote2/

I confirmed it worked with the XOP encoded "bextr".

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

