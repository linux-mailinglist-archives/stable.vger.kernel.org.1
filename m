Return-Path: <stable+bounces-105040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ED69F5659
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D21C7A3DEC
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4FE1F9A8D;
	Tue, 17 Dec 2024 18:32:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B291F9439;
	Tue, 17 Dec 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460364; cv=none; b=WsYLf1Bx6v9FRzj72OrAznFxAIoyP9VjpTy/PigVO8/VOtGbDJkyzVaDao/A/emtfvbMcK6Oj93QdLlBdlTUp/EiO/e8HpMT5mXMF2ptXa9EZUSiZBL7JWUGNVS3xmG4PsaovFDdN+m8Mmk/N9XLSnGTH0DAp8Sqxd8wHIAF69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460364; c=relaxed/simple;
	bh=LzxOMt9OHgu0yiPI0bkh+oIBORYFJHQLEZVw+6EU00s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9HHsC6io7pLgpG9v4lBSaixnR37WIvnHimHT78BtGSwMcWfHqR4HcYfPIqyMC37vciuy4zXPLNV62PLS9viVL0n16SsQQV7k6snxpqf/o+nqzWnSEABQGJeV1Vf4PvIyO21+KTfDnTYSKvBZ/O71QLzu7hI9Qlaq5nixbA7hqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FAAC4CED3;
	Tue, 17 Dec 2024 18:32:42 +0000 (UTC)
Date: Tue, 17 Dec 2024 13:33:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
Message-ID: <20241217133318.06f849c9@gandalf.local.home>
In-Reply-To: <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
References: <20241217173237.836878448@goodmis.org>
	<20241217173520.314190793@goodmis.org>
	<CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
	<20241217130454.5bb593e8@gandalf.local.home>
	<CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 10:19:45 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 17 Dec 2024 at 10:04, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I'm not sure what you mean. If the kernels are the same, then the pointers
> > should also be the same, as KASLR just shifts them. This no longer uses
> > module code. It only traces core kernel code which should always have the
> > same offsets.  
> 
>  (a) the shifting is what caused problems with you having to hack
> round the format string and %pS.

How else do I get the function name?

> 
>  (b) the data addresses are more than shifted, so that "data_delta" is
> *completely* bogus

The data_delta and text_delta are equal, and I could get rid of delta_data,
as I haven't used it. I only used the text_delta as they are always the
same.

> 
>  (c) neither of them are AT ALL valid for modules regardless

I can make sure that it only works for core kernel code, and print the raw
address if it isn't.

> 
> Stop using the delta fields. They are broken. Even for the same
> kernel. It's literally a "I made sh*t up and it sometimes works"
> situation.
> 
> That "sometimes works" is not how we do kernel development. Stop it.

For core kernel code it *always works*. I haven't seen it fail yet.

This is the point of this patch series, is to remove the cases where it can
fail. That is, if the kernel isn't the same, or the use of modules and
dynamic events that are not stable across reboots.

But for the core kernel code, I have not seen it fail once!

> 
> What *woiuld* have been an acceptable model is to actually modify the
> boot-time buffers in place, using actual real heuristics that look at
> whether a pointer was IN THE CODE SECTION OR THE STATIC DATA section
> of the previous boot.

So basically, you want a full parser of the trace event code that reads the
boot time buffer and makes it match the current kernel?

> 
> But you never did that. All this delta code has always been complete
> and utter garbage, and complete hacks.
> 
> Remove it.
> 
> Then, if at some point you can do it *right* (see above), maybe you
> can try to re-introduce it. But the current delta code is pure and
> utter garbage and needs to die. No more of this "hacking shit up to
> make it sometimes work".

As I said. It doesn't "sometimes work" it "always works", at least for the
core kernel. And I agree that it shouldn't "sometimes work" which is why
this patch series sets out to remove those cases that do not work.

-- Steve

