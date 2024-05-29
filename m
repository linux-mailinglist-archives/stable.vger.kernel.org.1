Return-Path: <stable+bounces-47659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0741C8D3E83
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 20:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311DE1C216D4
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 18:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40DB1C0DFB;
	Wed, 29 May 2024 18:48:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF331386A7;
	Wed, 29 May 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008483; cv=none; b=m+71Mw5HHTZeCBY+QaWwkEUuM8ImJ0WyCC36pbAcN44fIC1v/jrtJWwdXLryte/z5wSxsmtchNjqq9XpVH0cuu1LQLtmwCPA0vLn/nzzL+tV9n/qWICnzykTenndcQjnmXVwbpEhvLdeif0kIRbo2JEuDk+B87nAC+yJt2lzDOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008483; c=relaxed/simple;
	bh=aSjkcMM0/WS+PWVEiRzVXc2xuIlLSgJEp7biwCjtivw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BC+X2HoiTK6KzNW3Oewb/NSXbYDFHu/7WFXch727LOwwmN9HqFQDvnsFYmOphQtRWB9pv3LLFDeou3FYT9oasvUU6E2xVxuTCvEvfQMrOfNkPHqyWn6iCvfXvcFpBwb+c0za2VkSXvT26mSECkx+L/+Lc+PVZvvzvt/FaUrBWw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AB4C113CC;
	Wed, 29 May 2024 18:48:01 +0000 (UTC)
Date: Wed, 29 May 2024 14:47:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?= <digirigawa@gmail.com>
Cc: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Linux regressions mailing list
 <regressions@lists.linux.dev>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During
 Shutdown/Reboot
Message-ID: <20240529144757.79d09eeb@rorschach.local.home>
In-Reply-To: <CAE4VaRE3_MYVt+=BGs+WVCmKUiQv0VSKE2NT+JmUPKG0UF+Juw@mail.gmail.com>
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
	<5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
	<20240527183139.42b6123c@rorschach.local.home>
	<CAE4VaRHaijpV1CC9Jo_Lg4tNQb_+=LTHwygOp5Bm2z5ErVzeow@mail.gmail.com>
	<20240528144743.149e351b@rorschach.local.home>
	<CAE4VaRE3_MYVt+=BGs+WVCmKUiQv0VSKE2NT+JmUPKG0UF+Juw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 May 2024 21:36:08 +0300
Ilkka Naulap=C3=A4=C3=A4 <digirigawa@gmail.com> wrote:

> applied your patch without others, so trace and panic there.
> Screenshot attached. Also tested kernels backward and found out that

Bah, it's still in an RCU callback, which doesn't tell us why a
normal inode is being sent to the trace inode free list.

> this trace bug first triggered on 6.6-rc1.

Hmm, that's when eventfs was added.

>=20
> Let me know if you need more assistance with this.

Let me make a debug patch (that crashes on this issue) for that kernel,
and perhaps you could bisect it?

Thanks!

-- Steve

