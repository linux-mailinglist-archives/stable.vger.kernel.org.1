Return-Path: <stable+bounces-105041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2AF9F5672
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B38077A39D9
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04981F7580;
	Tue, 17 Dec 2024 18:42:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C8A442F;
	Tue, 17 Dec 2024 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460924; cv=none; b=KrdH1ZUUgCMkYK4nx+ALYNzide9yO9oQj+wiplF/e7+chhDItzyq0eliNv97f+gtgTgROgxrnaVjizSjUnulZ8cWZr3ON3WW4zOef4zuSV14vi6KWig/EwVS52xHKhR+sy1VFzYEChZK7L1gjPBCznp+NUpdOrPj9bV4gAYKfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460924; c=relaxed/simple;
	bh=nLEBAbT68ZYoMtJ41mflcfC/vqMvDCDxGv+G/pCeiEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwgH6palX7aFQMF/cZLMRahdk1CHmBjrfJgXKtmlQ7Y0vgdeEAS3tEysQnUN5x1+nz+A25AS55RNwgET0WVamFs+2RxK6KNHCbHE5Ox0gucoXSNyIssRkM1dGAnRk3kOp09IOZzEm6hc6kRTbgVGH/ncQr1azDt/3MZ+CvowGwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ED2C4CED3;
	Tue, 17 Dec 2024 18:42:03 +0000 (UTC)
Date: Tue, 17 Dec 2024 13:42:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
Message-ID: <20241217134238.475b4011@gandalf.local.home>
In-Reply-To: <CAHk-=wjThke2-HB_Zi35xHe9ayTPk=zB_kjd0Hr-Yn1oV0ZSsg@mail.gmail.com>
References: <20241217173237.836878448@goodmis.org>
	<20241217173520.314190793@goodmis.org>
	<CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
	<20241217130454.5bb593e8@gandalf.local.home>
	<CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
	<CAHk-=wjThke2-HB_Zi35xHe9ayTPk=zB_kjd0Hr-Yn1oV0ZSsg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 10:24:42 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 17 Dec 2024 at 10:19, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > What *woiuld* have been an acceptable model is to actually modify the
> > boot-time buffers in place, using actual real heuristics that look at
> > whether a pointer was IN THE CODE SECTION OR THE STATIC DATA section
> > of the previous boot.
> >
> > But you never did that. All this delta code has always been complete
> > and utter garbage, and complete hacks.  
> 
> Actually, I think the proper model isn't even that "modify boot time
> buffers in place" thing.
> 
> The proper model was probably always to just do the "give the raw
> data, and analyze the previous boot data in user mode". Don't do
> "delta between old and new kernel", print out the actual KASLR base of
> the old kernel, and let user mode figure it out. Because user mode may
> actually have the old and different vmlinux image too - something that
> kernel mode *never* has.

I already support this somewhat, as the text_delta (and data_delta) are
presented in the tracefs directory so that trace-cmd can parse it.

For my use case, this would work, as we are extracting the raw data and
need to do most the processing in user space anyway. I could have it export
the KASLR offset of the previous boot and then trace-cmd should be able to
handle it fine if the events and kallsyms of the previous boot are all
saved. It could easily put things back together, including modules and
dynamic events.

This will just make it useless for those that want to use the tracefs
directly.

-- Steve


