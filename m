Return-Path: <stable+bounces-105033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7279F55AE
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0622C171DC8
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382E41F37D5;
	Tue, 17 Dec 2024 18:04:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345113EFF3;
	Tue, 17 Dec 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458662; cv=none; b=Bkx80MMuCNL5RzrHHjMTa7fN5RhuJ2oyZFXF8AUWzcExJdHV6JP9TpfuPjm9AzFtDCkutAcC4hafG3uLhVxH1GXwcqUWqzJ+SEBjH1IbvttNtiKEvvfP8rPh7bwZCH6Ah48quO56mvpq4LaEqjmQPJ6PxraBu0C9Al1Wiy8zmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458662; c=relaxed/simple;
	bh=8sEJY4egU/hmBp5Z8itqEWIHD6TLmWip41RonSTwJks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eyj9XrBY+WsA3cPEurvYVNVxaLXkiJc+ifMkIjInIlmYbF9HhIvCq8yK0i0rZMI5brl5YdjEv7PuPZTO40ImeH08VvpjBAr8EyYjtwn7qaMdWCf8t+Z57sn0EDa4YKQ73rU/mXy0k70Xa3r2382BS4fqMDgl/DuGsACBb7t/OSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F272C4CEDD;
	Tue, 17 Dec 2024 18:04:18 +0000 (UTC)
Date: Tue, 17 Dec 2024 13:04:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
Message-ID: <20241217130454.5bb593e8@gandalf.local.home>
In-Reply-To: <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
References: <20241217173237.836878448@goodmis.org>
	<20241217173520.314190793@goodmis.org>
	<CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 09:46:30 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 17 Dec 2024 at 09:34, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Add uname into the meta data and if the uname in the meta data from the
> > previous boot does not match the uname of the current boot, then clear the
> > buffer and re-initialize it.  
> 
> This seems broken.

BTW, this isn't the fix for the trace_check_vprintf(). That is here:

  https://lore.kernel.org/linux-trace-kernel/20241217024118.587584221@goodmis.org/

Where the I completely remove that function.

> 
> The problem is not that the previous boot data is wrong.
> 
> The problem is that you printed it *out* wrong by trying to interpret
> pointers in it.
> 
> Now you basically hide that, and make it harder to see any data from a
> bad kernel (since you presumably need to boot into a good kernel to do
> analysis).
> 
> The real fix seems to have been your 3/3, which still prints out the
> data, but stops trying to interpret the pointers in it.
> 
> Except you should also remove the last_text_delta / last_data_delta
> stuff. That's all about exactly that "trying to interpret bogus
> pointers". Instead you seem to have actually just *added* a case of
> that in your 3/3.

I'm not sure what you mean. If the kernels are the same, then the pointers
should also be the same, as KASLR just shifts them. This no longer uses
module code. It only traces core kernel code which should always have the
same offsets.

With the last_text_delta (and last_data_delta is always the same, but I
added it in the case that ever changes), the shifts have always been
accurate. For example, for RCU event strings.

With the pointer update to print_fields() I get:

           <...>-912     [001] d..1.   304.817710: rcu_utilization: s=(0xffffffff9c4026b5:Start context switch)
           <...>-912     [001] d..1.   304.817713: rcu_utilization: s=(0xffffffff9c4ca779:End context switch)
          <idle>-0       [002] dN.1.   304.817769: rcu_utilization: s=(0xffffffff9c4026b5:Start context switch)
          <idle>-0       [002] dN.1.   304.817772: rcu_utilization: s=(0xffffffff9c4ca779:End context switch)
           <...>-19      [002] d..1.   304.817805: rcu_utilization: s=(0xffffffff9c4026b5:Start context switch)
           <...>-19      [002] d..1.   304.817806: rcu_utilization: s=(0xffffffff9c4ca779:End context switch)
          <idle>-0       [006] dN.1.   304.817819: rcu_utilization: s=(0xffffffff9c4026b5:Start context switch)
          <idle>-0       [006] dN.1.   304.817821: rcu_utilization: s=(0xffffffff9c4ca779:End context switch)
           <...>-902     [006] d.h1.   304.817901: rcu_utilization: s=(0xffffffff9c488fdd:Start scheduler-tick)
           <...>-902     [006] d.h1.   304.817903: rcu_utilization: s=(0xffffffff9c426d45:End scheduler-tick)
          <idle>-0       [007] dN.1.   304.817913: rcu_utilization: s=(0xffffffff9c4026b5:Start context switch)
          <idle>-0       [007] dN.1.   304.817915: rcu_utilization: s=(0xffffffff9c4ca779:End context switch)
           <...>-18      [007] d..1.   304.817931: rcu_utilization: s=(0xffffffff9c4026b5:Start context switch)
           <...>-18      [007] d..1.   304.817931: rcu_utilization: s=(0xffffffff9c4ca779:End context switch)
           <...>-902     [006] ..s1.   304.817941: rcu_utilization: s=(0xffffffff9c470f20:Start RCU core)
           <...>-902     [006] ..s1.   304.817958: rcu_utilization: s=(0xffffffff9c419bb8:End RCU core)
          <idle>-0       [002] dN.1.   304.818003: rcu_utilization: s=(0xffffffff9c4026b5:Start context switch)
          <idle>-0       [002] dN.1.   304.818003: rcu_utilization: s=(0xffffffff9c4ca779:End context switch)

Without that calculation, all I get is garbage and completely useless:

           <...>-903     [000] d..1.    24.712788: rcu_utilization: s=(0xffffffff970026af)
           <...>-903     [000] d..1.    24.712791: rcu_utilization: s=(0xffffffff970ca75b)
          <idle>-0       [004] dN.1.    24.712796: rcu_utilization: s=(0xffffffff970026af)
          <idle>-0       [004] dN.1.    24.712799: rcu_utilization: s=(0xffffffff970ca75b)
           <...>-19      [004] d..1.    24.712825: rcu_utilization: s=(0xffffffff970026af)
           <...>-19      [004] d..1.    24.712825: rcu_utilization: s=(0xffffffff970ca75b)
           <...>-18      [004] d..1.    24.712838: rcu_utilization: s=(0xffffffff970026af)
           <...>-18      [004] d..1.    24.712839: rcu_utilization: s=(0xffffffff970ca75b)
          <idle>-0       [005] dN.1.    24.712881: rcu_utilization: s=(0xffffffff970026af)
          <idle>-0       [005] dN.1.    24.712883: rcu_utilization: s=(0xffffffff970ca75b)
           <...>-893     [005] d.h1.    24.712911: rcu_utilization: s=(0xffffffff97088feb)
           <...>-893     [005] d.h1.    24.712912: rcu_utilization: s=(0xffffffff97026d3f)
           <...>-893     [005] ..s1.    24.712942: rcu_utilization: s=(0xffffffff97070f2e)
           <...>-893     [005] ..s1.    24.712944: rcu_utilization: s=(0xffffffff97019bb2)
           <...>-893     [005] dN.1.    24.713412: rcu_utilization: s=(0xffffffff970026af)
           <...>-893     [005] dN.1.    24.713412: rcu_utilization: s=(0xffffffff970ca75b)

The delta calculations are done by saving an address of a symbol into the
meta data, and when the meta data is considered a match, it calculates the
delta between what was saved in the meta data to the same symbol in the
current kernel.

This works across several reboots too. That is, I can save the boot mapped
data, reboot several times, and still see the correct data in the ring
buffer, as the delta is calculated at each boot. It's only saved when
tracing starts and the ring buffer is re-initialized.

So what exactly are you saying is broken?

-- Steve

