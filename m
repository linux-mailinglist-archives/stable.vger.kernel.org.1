Return-Path: <stable+bounces-105037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F659F55E1
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A1A167212
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216B1F76A2;
	Tue, 17 Dec 2024 18:16:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5598F5A;
	Tue, 17 Dec 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459403; cv=none; b=UU+8/9gns03aJZQehjLJMJ/cYcDFtE+1D4e/z8Q2I1LbTXggF9raXI29ZXEvRhe/UFI38R5UCP/gRZoAhLZzaigrJhcTL2gX7ULaXwbgT03yzajIBOjcVIXbcC+xmSrPl/kFma//H5a4fhlrX/U3SDIW2bblJIeSfOPVqeFpjDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459403; c=relaxed/simple;
	bh=XUK5GhWqKa1G0rhFkWoJia5kAw7ohSgwGou0pheg2fs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eS5P14rK+WjVtJNX/J+6YoYIl/vDT2PrjVRhWrwLGu8m/ESkXuJJH9QTkPE34VfDCdvbMU7liIT3c1MtRVmDjwqMOLy9Hs6yOTn1qOYLcRz9w4BgO7CL2ZhnQRkRI2k0PSDTJTjN0dM8puC5tqr6zX+Mtp44vVqm0FinBgCGQsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD21C4CED3;
	Tue, 17 Dec 2024 18:16:42 +0000 (UTC)
Date: Tue, 17 Dec 2024 13:17:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
Message-ID: <20241217131717.0fa5a21b@gandalf.local.home>
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

> Now you basically hide that, and make it harder to see any data from a
> bad kernel (since you presumably need to boot into a good kernel to do
> analysis).

Note, this isn't for debugging kernels that crash at boot. There's other
methods to debug things like that. Like, ftrace_dump_on_oops. This is for
debugging something that happens after boot or in the field. Where the
"bad" kernel can still boot in a good state. The kernel should be good
enough to boot into a state where you can extract the trace and send it
offline somewhere.

I used this to debugging a few things in development, where someone hands
me a reproducer. I enabled the boot_mapped buffer, run the reproducer, the
system crashes and reboots into the same kernel. Then I was able to debug
what happened, as long as I don't re-run the reproducer. But I did do
several iterations of:

  Start boot mapped tracing, run reproducer, crash, reboot, look at boot
  mapped trace. Restart boot mapped tracing with more events, run reproducer, 
  crash, reboot, look at mapped trace, wash, rinse, repeat.

-- Steve



