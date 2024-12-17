Return-Path: <stable+bounces-105049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0219F56AD
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA691893127
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A371F8AD1;
	Tue, 17 Dec 2024 19:07:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4813EFF3;
	Tue, 17 Dec 2024 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734462436; cv=none; b=IaePuqJBykNDeJpkQoLqkhi8nGbvUKcJ4aXuTFU2WFiwd9NAtKBUt6gtWcGoolEcD/J7mPfU2NrjpIStRM08Qy4fwMFwTt5Bhc+j2yG6fgDmxTdohJyDcRqPJXILHlsdAJv0obZ5UDMOCEIhsfMSzKt5Lo3okqiyPUwKfb5RWjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734462436; c=relaxed/simple;
	bh=nwUc8PRvDlPDZ/wjrfTuqf6oRv/lHr4t2YSfVdA1iKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLcTHElj7SaIa3hverWapV5k24reL73q6uogNdGa9POx8D09FmnF7ruL+ajX/au79TM0KOz1lPVTvnYkyxC5m6BTEUUggftLSSlJGRaOq/kxKzDTnje9eo+6agb/8hWWruoXY6rOFpSqNoizUtI5ZSh3wgjpW5PAHtZYiz/ydMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B49AC4CED7;
	Tue, 17 Dec 2024 19:07:15 +0000 (UTC)
Date: Tue, 17 Dec 2024 14:07:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
Message-ID: <20241217140750.43a65a01@gandalf.local.home>
In-Reply-To: <CAHk-=whV+=eymQ_eU8mj4fFw643nkvqZfeFM9gdGYavD44rB9w@mail.gmail.com>
References: <20241217173237.836878448@goodmis.org>
	<20241217173520.314190793@goodmis.org>
	<CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
	<20241217130454.5bb593e8@gandalf.local.home>
	<CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
	<20241217133318.06f849c9@gandalf.local.home>
	<CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
	<CAHk-=whV+=eymQ_eU8mj4fFw643nkvqZfeFM9gdGYavD44rB9w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 11:03:28 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 17 Dec 2024 at 10:42, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > My initial suggestion was to just fix up the boot time array.
> >
> > I think that's actually wrong. Just print the raw data and analyze it
> > in user space.  
> 
> .. I still think it's not the optimal solution, but fixing up the
> event data from the previous boot (*before* printing it, and entirely
> independently of vsnprintf()) would at least avoid the whole "mess
> with vsnprintf and switch the format string around as you are trying
> to walk the va_list in sync".
> 
> Because that was really a non-starter. Both the format string hackery
> and the va_list hackery was just fundamentally bogus.
> 
> If you massage the data before printing - and independently of it -
> those two issues should at least go away.

But I can't massage the data without the deltas. That takes us back to
having to have the same kernel and only processing kernel core data and
ignoring modules.

-- Steve


