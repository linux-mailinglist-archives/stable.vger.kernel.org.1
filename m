Return-Path: <stable+bounces-105086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FC29F5BDC
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 01:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF8B7A35DB
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 00:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36ADBE6C;
	Wed, 18 Dec 2024 00:47:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808832572;
	Wed, 18 Dec 2024 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482867; cv=none; b=MbDsC+qQzt2kU6EOotWzcSLRCji3uS2VAaVoDnT3hZY4nzrgs/2YKCz1/bVxLus24sO1tBx3+r7bLxDRiK93qxLHIsb3wEvXkZDQCv87KdeSDcrM8ayRowE7zuMYw80uPRmAJnvsJqyR6hTNXPMRalk7Hgd1AWy1ZT+LADDqnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482867; c=relaxed/simple;
	bh=xqNAI8+AELjGQ5jruNEEsTFLc+OTvmmjJkh0Cc4jLdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKM9bo1Yj1w/v7EQ428bDhEeywe4J40f25UXwVYgQb4WHv+6J9tWQRvn815Zr7arsa0GT6vsvuEksoPfYa4xwcxbnJKTVsr/3yDE3BkhqqzlGLRcQirOavjbXBKiOBesO7oLfvosLIXjoGoulm1qancv9qMvxJbgCO2YbNuCsGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07566C4CED3;
	Wed, 18 Dec 2024 00:47:45 +0000 (UTC)
Date: Tue, 17 Dec 2024 19:48:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
Message-ID: <20241217194822.4fb1d81a@gandalf.local.home>
In-Reply-To: <CAHk-=wgdFnwBD9odfSBz2zjedw1oWKKO3F46YAC_puE4b9J6JQ@mail.gmail.com>
References: <20241217173237.836878448@goodmis.org>
	<20241217173520.314190793@goodmis.org>
	<CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
	<20241217130454.5bb593e8@gandalf.local.home>
	<CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
	<20241217133318.06f849c9@gandalf.local.home>
	<CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
	<20241217140153.22ac28b0@gandalf.local.home>
	<CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
	<20241217144411.2165f73b@gandalf.local.home>
	<CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
	<20241217175301.03d25799@gandalf.local.home>
	<CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
	<CAHk-=wgdFnwBD9odfSBz2zjedw1oWKKO3F46YAC_puE4b9J6JQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 16:02:34 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 17 Dec 2024 at 15:32, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But if you look more closely, you'll see that the way the buffer is
> > managed is actually not as a word array at all, but using
> >
> >         char *str, *end;
> >
> > instead of word pointers.  
> 
> Oh, and in addition to the smaller-than-int types ('%c' and '%hd'
> etc), pointers that get dereferenced also get written as a byte string
> to that word array. There might be other cases too.
> 
> So it's really a fairly odd kind of "sometimes words, sometimes not"
> array, with the size of the array given in words.
> 
> That binary printf is very strange.

Note that at least on the tracing user space side, as trace_printk() is
never used in production systems and mostly just used for debugging, we can
be pretty liberal if I have to change libtraceevent.

I could even add an update to the format file to have the library stay
backward compatible with older kernels and can see that the format file has
been updated to know that the vbin_printf() has changed.

-- Steve

