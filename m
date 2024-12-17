Return-Path: <stable+bounces-105050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE40A9F56B8
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A9A7A2A74
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3651F941E;
	Tue, 17 Dec 2024 19:13:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C918E1F8F10;
	Tue, 17 Dec 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734462823; cv=none; b=p07RepuIWwHLedSLREaLlsgUOe6vbAptNtMqefTlcPahADrTjtZg0uxOhXVXFFlkVbdgzuqfesSkR/UhE8VumvGduEiyS5Ieix5XBX1qjb7ZLBZVo1TepHMbT9WUyn6TZ8FELqaMT8o7HXhPcc6az1sxZXIp/fvCSP/k727Xo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734462823; c=relaxed/simple;
	bh=qugJ8rsNxA4s2sfFjius2+lQdwH2+COZM9rcvoD0gAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUlfBD8MZCuDrf3Lf3s6Vx/atjHh89p+kovwtHr3T34xE8sjs+fULJZki3ssVpYxpKEl/WSnbbiz8izcwochq/EjsASkuIQPqgj/viA8+S4dhtVetHEfzP42JPTh8w0aShlNnET8ILipRn9Wgto6vq5GFiwFeXzIzUfvnZvk1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CACCC4CED3;
	Tue, 17 Dec 2024 19:13:42 +0000 (UTC)
Date: Tue, 17 Dec 2024 14:14:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
Message-ID: <20241217141417.23b875f1@gandalf.local.home>
In-Reply-To: <20241217140750.43a65a01@gandalf.local.home>
References: <20241217173237.836878448@goodmis.org>
	<20241217173520.314190793@goodmis.org>
	<CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
	<20241217130454.5bb593e8@gandalf.local.home>
	<CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
	<20241217133318.06f849c9@gandalf.local.home>
	<CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
	<CAHk-=whV+=eymQ_eU8mj4fFw643nkvqZfeFM9gdGYavD44rB9w@mail.gmail.com>
	<20241217140750.43a65a01@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 14:07:50 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 17 Dec 2024 11:03:28 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Tue, 17 Dec 2024 at 10:42, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:  
> > >
> > > My initial suggestion was to just fix up the boot time array.
> > >
> > > I think that's actually wrong. Just print the raw data and analyze it
> > > in user space.    
> > 
> > .. I still think it's not the optimal solution, but fixing up the
> > event data from the previous boot (*before* printing it, and entirely
> > independently of vsnprintf()) would at least avoid the whole "mess
> > with vsnprintf and switch the format string around as you are trying
> > to walk the va_list in sync".

And that code that does the va_list and vsnprintf() tricks is going to be
removed as soon as that patch set finishes going through my full test suite,
and you are OK with the solution.

Again, that patch set is here:

  https://lore.kernel.org/linux-trace-kernel/20241217024118.587584221@goodmis.org/

-- Steve

