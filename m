Return-Path: <stable+bounces-118633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE8A3FF91
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 20:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0741703A4F
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 19:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D64250BE6;
	Fri, 21 Feb 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DlqYrXba"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849811EF0B9;
	Fri, 21 Feb 2025 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165441; cv=none; b=REYMrMU7ueG18i4qg42AL8oZpVOCvM+GNyuGGm3x441NUdlCs0HpTr9X+1JQpo9Dne4rhPUxjSr+y0qQObY411O+v8Uh743viLLLF/y9wA+XGkV8lDZ/0RiPkNrLZVaq2PgV2/Y9864YtKPyZc4eCI2LAkBJ95oR4mNO8Th+ywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165441; c=relaxed/simple;
	bh=fyicvHFif9U3OCmS3KwQTqNzm8djGk2z5hMgb3BaD4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h15+9SaA+N2AoHoaZbJFFZtl+gzdYRdsSZw/UcoAxI1SRTblDX5MfRMSRxFin/rJ6tl6XelpmUB0FAW0t2rU5eH7nGQVNM5Z63WH4nhgAm6B2b/pN76k68rcrEYpLl2b7Nb/JwSxxAxMr2B85OGj5x0aAcwZoYfTvE2w37RLTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DlqYrXba; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wIywcsgE21jHle8TXRvpSWiOPzaeM16+bhN+cx8tgoE=; b=DlqYrXbahlQeMINOy9UhB/oF2m
	Miu2NnXVVyQJW9rFyq9LWxm4BTyuFpfZtQWGA6vWEbzNTxoFHxOnlv6Mnb6n1B5Ij+JDvdNVhqLdc
	KSpf+XlAPxVD+jdlGTyCrMTtEXwj4l7B47PzYeSTvo8k+26rzXpbmrltW9xYRrnix45A2sBhzQmQC
	0sDowB7rtBPxmpOLEOS/D4Z6f1tLcOWZCLZN3g0M+4fG68KYnN4EbnS4rwmB9CFTXGnDP0nANfJTD
	OBbOiU1PuAtJlsd851pe74XcAlfYJr/TqeA3hs86SxBFMmNDpZZrVq7SMWsO3vM46i9Rwfu955QHS
	z1p5a8Sw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tlYWP-0000000Eoh8-2q5h;
	Fri, 21 Feb 2025 19:17:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4419A30066A; Fri, 21 Feb 2025 20:17:13 +0100 (CET)
Date: Fri, 21 Feb 2025 20:17:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: sched/core] x86/tsc: Always save/restore TSC sched_clock()
 on suspend/resume
Message-ID: <20250221191713.GE7373@noisy.programming.kicks-ass.net>
References: <20250215210314.351480-1-gpiccoli@igalia.com>
 <174014866289.10177.10974658062988825500.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174014866289.10177.10974658062988825500.tip-bot2@tip-bot2>

On Fri, Feb 21, 2025 at 02:37:42PM -0000, tip-bot2 for Guilherme G. Piccoli wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     d90c9de9de2f1712df56de6e4f7d6982d358cabe
> Gitweb:        https://git.kernel.org/tip/d90c9de9de2f1712df56de6e4f7d6982d358cabe
> Author:        Guilherme G. Piccoli <gpiccoli@igalia.com>
> AuthorDate:    Sat, 15 Feb 2025 17:58:16 -03:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 21 Feb 2025 15:27:38 +01:00
> 
> x86/tsc: Always save/restore TSC sched_clock() on suspend/resume

Should this not go into x86/core or somesuch?

