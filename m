Return-Path: <stable+bounces-105056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA1E9F5717
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE4D18863A2
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB6F1F8F10;
	Tue, 17 Dec 2024 19:43:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2351F8AD9;
	Tue, 17 Dec 2024 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464617; cv=none; b=QUAoKkJqK/MzRmG3lKgnqDlgHZFnFAkZRA/ZZk1/dPdMEd47/XsMJRQZBNBa+9OztNz5hIngE/YBWX2c5tGmJ4SOQ/X8oQ/xCH2JHr8Y+fcDqGlHcUM+yg4kvtPgWhN3nji/qN6kov3Dg1EzJYe9LGDvYTtaGG4cpahYEoE0vUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464617; c=relaxed/simple;
	bh=/2JWy7XyRJojOLT9csZ59o7qdtHc70xuhWajqM8UXVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9XyGXG8JUG9KaL65CGPD53qet/nO0OaiAotLkgGDkuCzMid/M9Jecseg8v+adUiGxMgAlVbnRYaPl96z1ca5neTurXr1lOYj3I0Rwa5VZ3lBNoOpEybjoG+qiIKhtlbxsetYFdDFzIsHUnPFmgXgdKfKixSybOsOyxF5ROCNcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2730C4CED3;
	Tue, 17 Dec 2024 19:43:35 +0000 (UTC)
Date: Tue, 17 Dec 2024 14:44:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
Message-ID: <20241217144411.2165f73b@gandalf.local.home>
In-Reply-To: <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
References: <20241217173237.836878448@goodmis.org>
	<20241217173520.314190793@goodmis.org>
	<CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
	<20241217130454.5bb593e8@gandalf.local.home>
	<CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
	<20241217133318.06f849c9@gandalf.local.home>
	<CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
	<20241217140153.22ac28b0@gandalf.local.home>
	<CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 11:38:00 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 17 Dec 2024 at 11:01, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > But instead, I'll replace the text/data_deltas with a kaslr offset (it will
> > only be exported if the trace contains data from a previous kernel so not
> > to export the current kaslr offset).  
> 
> Right - never export the KASRL offset for the *current* kernel, but
> the same interface that exports the "previous kernel trace data" can
> certainly export the KASLR for that previous case.

But this will be future work and not something for this merge window, as
it's more of a feature. The only fix is to add that print_field() code, and
the patch series that removes trace_check_vprintf() (which fixes a
different bug).

> 
> > Then, on our production systems, we'll save the meta data of the events we
> > enable (this can include module events as well as dynamic events) and after
> > a crash, we'll extract the data along with the saved data stored on disk,
> > and be able to recreate the entire trace.  
> 
> Yes. And if you save the module names and load addresses, you can now
> hopefully sort out things like %s (and %pS) from modules too.
> 
> Although maybe they don't happen that often?

Actually, they do appear a bit. As the kmalloc trace event records the call
sites that do allocation and many of them are in module code.

-- Steve

