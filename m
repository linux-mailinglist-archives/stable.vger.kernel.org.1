Return-Path: <stable+bounces-172826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA227B33E48
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57AA3A9055
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 11:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2260A2EAD0D;
	Mon, 25 Aug 2025 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EuZGLakx"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0814F125;
	Mon, 25 Aug 2025 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122103; cv=none; b=Pb4OPniewvBHLJX7o8QpB3Id0+mMkrFIe6MVDZ+p58lyOhmk2tJdsVWTxL4bEoXdGoQZj/1sBguSYeDcoDlBVaiz1uEOerF2zalrlgn6cDhwJ+P4IOlGhTqdoWz0eEb44FfI0y7PJNiDEifU9g18O0vju0dzu+5Po0DjhQ9Sj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122103; c=relaxed/simple;
	bh=bBFviAzxusD/+ZPvjk0KTb3vBlia5EPA1Z2wkC6FT50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTKRTbxiVxhN3+VrpYIBlR0Xe2YHXwr4DlYtOylsSEJw+P7qTCCg2Y94ARZ597/AV0Zo6xmJNiXWD9dqgaKvjdEtyZpgnIFD4w4z1sIR+MMmN0utDHy7ysb4WIQfW0gezeQZWMa7HhiF8La4ERaBUQFcz8HPDYbK/nGggsrvIX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EuZGLakx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=szRULD1n0EhsnipFMeC6o6cR64ZzbwiUDN0/FCW1MhU=; b=EuZGLakxzaMgyif0TTSqwZQ6F1
	hMpWjooj9GCM2r8WhhQ+IR5ik6j4FMcixr4UTdQg24IFCMfkcQEG6ax2IY/MJHVqFAbnQX1Y2yqcD
	lgz1ik74GYK0NVN8f4qUk3NJ+ozSsXr5wcEHRT85YhG4P2JJyumuGg2GwTD0arMOlJCi0T+aHkp3V
	vT4BWkjJ4MdRWLx6mzViYy3knPao90/NeE/ptmSQLr/31PXJRD4BEbQO+Kh6hcpf8qVhiw/8tJSbh
	n8qPXfJlOs+/kdbBTSyRCvb2ut9Pu/z7zBR4BniyF62QrbPz7ivng/p2l9oUlOUC66/eBDnzV0JwI
	zdyyzW1g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqVZw-00000001oqM-2smU;
	Mon, 25 Aug 2025 11:41:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 407F13002ED; Mon, 25 Aug 2025 13:41:36 +0200 (CEST)
Date: Mon, 25 Aug 2025 13:41:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Eero Tamminen <oak@helsinkinet.fi>, Will Deacon <will@kernel.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Message-ID: <20250825114136.GX3245006@noisy.programming.kicks-ass.net>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <20250825071247.GO3245006@noisy.programming.kicks-ass.net>
 <58dac4d0-2811-182a-e2c1-4edfe4759759@linux-m68k.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58dac4d0-2811-182a-e2c1-4edfe4759759@linux-m68k.org>

On Mon, Aug 25, 2025 at 06:03:23PM +1000, Finn Thain wrote:
> 
> On Mon, 25 Aug 2025, Peter Zijlstra wrote:
> 
> > 
> > And your architecture doesn't trap on unaligned atomic access ?!!?!
> > 
> 
> Right. This port doesn't do SMP.

There is RMW_INSN which seems to imply a compare-and-swap instruction of
sorts. That is happy to work on unaligned storage?

Anyway, it might make sense to add an alignment check to
arch/m68k/include/asm/atomic.h somewhere, perhaps dependent on
some DEBUG flag or other.

