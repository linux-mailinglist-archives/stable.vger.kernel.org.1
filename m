Return-Path: <stable+bounces-105047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D239F56A5
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9827A16F1D8
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E8B1F76A0;
	Tue, 17 Dec 2024 19:01:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588013EFF3;
	Tue, 17 Dec 2024 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734462079; cv=none; b=tajtnsGF2lfz/Rcu6eK4f7knt0ebswdAHQCaY/qfpfc7mWBAdbN4Rcb1aTmucF1UZk/PZh7JMCeNOZDHtEXVWQB+r21qyyrwsoe9gNBQ/kt9OQvmxxGj0MMUXRh/+4vZZZUxxrZSNsd6UI2tG0cRS7HmSsZ5ld+chHpog7Yi71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734462079; c=relaxed/simple;
	bh=byASTRhA/kuKrPE71olh+hKv4gdHIvRVSw7hNu8gn94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+/Y/dP1vlGxyxnzw7PibtmCupHzpvAZS/kT5CE9cxdPQvYfWs3+DZbX23193b63RrpLNvqawB4W37m+MaSLy8cKMp8dYQ7u88gfh96h9oBuEyPrkkq0gYom0uT55UnABLhLZh41bNuffXMvYbrqJpKozpLILKkCNsh6QxVW4IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626F5C4CED3;
	Tue, 17 Dec 2024 19:01:17 +0000 (UTC)
Date: Tue, 17 Dec 2024 14:01:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
Message-ID: <20241217140153.22ac28b0@gandalf.local.home>
In-Reply-To: <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
References: <20241217173237.836878448@goodmis.org>
	<20241217173520.314190793@goodmis.org>
	<CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
	<20241217130454.5bb593e8@gandalf.local.home>
	<CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
	<20241217133318.06f849c9@gandalf.local.home>
	<CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 10:42:47 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> Really. This is literally what I started the whole original complaint
> about. Go back to my original email, and try to understand the
> original issue. Let me quote the really relevant part of that email
> again:
> 
>   This stuff is full of crazy special cases for things that should never
>   be done in the first place.

To my defense, all of ftrace (function tracing, live kernel patching, etc)
came from trying to do crazy special cases. The TRACE_EVENT() macro being
another one ;-)

> 
> Note - and really INTERNALIZE - that "for stuff that should never be
> done in the first place".
> 
> You started with the wrong design. Then you keep hacking it up, and
> the hacks just get wilder and crazier as you notice there are more
> special cases.
> 
> This is now getting to the point where I'm considering just ripping
> out the whole boot-time previous kernel buffer crap because you seem
> to have turned an interesting idea into just a morass of problems.
> 
> Your choice: get rid of the crazy, or have me rip it out.
> 

Point taken. And for my work use case, I can keep the ring buffer as is and
do most the work in user space. I did these "hacks" for those that do not
use trace-cmd and still use the tracefs file system directly (like a lot of
the embedded folks).

But instead, I'll replace the text/data_deltas with a kaslr offset (it will
only be exported if the trace contains data from a previous kernel so not
to export the current kaslr offset).

Then, on our production systems, we'll save the meta data of the events we
enable (this can include module events as well as dynamic events) and after
a crash, we'll extract the data along with the saved data stored on disk,
and be able to recreate the entire trace.

I'll only push patch 3 without the %s pointer update.

-- Steve

