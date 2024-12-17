Return-Path: <stable+bounces-105074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CEB9F59DE
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 23:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61F018935F1
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA51E009D;
	Tue, 17 Dec 2024 22:52:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE819155CB3;
	Tue, 17 Dec 2024 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734475947; cv=none; b=MR6/KdyhBEdzu+TB0U1RYZ+8ZlfdOUWbT+7sWBWoT4BSULdf0CCEkF9uSUcc5VxXVz22S8kZhBCv4QpxrIz9NviolMbIJrnVrNN7DRdWestXASSs+O4uU4npwZnOQ7fr66sKEs98fV6j6WnnCs2z7D5E4jlRHfNLYWbWKaHK0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734475947; c=relaxed/simple;
	bh=Xyb0HXId3pOZNdVW9rcyiCOIr69ico/rvnIB22rWzJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1jNZTHIseQ4KoTWzK0ueoFCT9bITmmPBaApJ3NSuQm0BklU6gkQCdb/f9+l79C4FL6gofFmIV/KaEYsMlc+W2j2lvkWazIDkh9S0T7rBcqyFbRL8Ihmqcrb2ITioCo5aMluTzaNc2MOVTHLdnD6KwL24Of8JhGfXfzmIXambiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A13BC4CED3;
	Tue, 17 Dec 2024 22:52:25 +0000 (UTC)
Date: Tue, 17 Dec 2024 17:53:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
Message-ID: <20241217175301.03d25799@gandalf.local.home>
In-Reply-To: <CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
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
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 14:24:08 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> (Aside: are those binary buffers actually exported to user space (that
> "u32 *bin_buf, size_t size" thing), or could we fix the binary printf
> code to really use a whole word for char/short values? The difference
> between '%hhd' and '%d' should be how it's printed out, not how the
> data is accessed)

libtraceevent is able to parse the raw trace_printk() events:

  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/tree/src/event-parse.c#n5155

The format it reads is from /sys/kernel/tracing/events/ftrace/bprint/format:

name: bprint
ID: 6
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:unsigned long ip;	offset:8;	size:8;	signed:0;
	field:const char * fmt;	offset:16;	size:8;	signed:0;
	field:u32 buf[];	offset:24;	size:0;	signed:0;

print fmt: "%ps: %s", (void *)REC->ip, REC->fmt

In this case, the "print fmt" is ignored.

Where the buf value holds the binary storage from vbin_printf() and written
in trace_vbprintk(). Yeah, it looks like it does depend on the arguments
being word aligned.

-- Steve

