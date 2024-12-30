Return-Path: <stable+bounces-106580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346019FEACB
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 22:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783EE3A1F2A
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 21:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F676199E94;
	Mon, 30 Dec 2024 21:02:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED515E8B;
	Mon, 30 Dec 2024 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735592524; cv=none; b=NI76lfDma1NaQsUuFfOXp+a9FE3sU7fYH6NXjHff6HLU+TyqFZ6k2zosu47AgJi5wLe0MoiINmOEbCjSzDDyLx5NSciWWBPU1rPNVmZoPaWhfkJ2abe6ILt86CwxBYRuEeOx945mXq1a1PQVbPHm96ZHGksJdDNW8KEYEj0hQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735592524; c=relaxed/simple;
	bh=R2iy9PiJuBrHMtn68/ruwaKcZCthffzOclvW2shpZ/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBCuGqELZCvQOu/L+fq5VmLjGZGe31mZQxoT1xD07ve6wv4bTAWFs7+7L/ZtWY892NWGYYyNqsxUInb8Ppmi84ujejb5DNsSpyKEkqr8vieX1DfPTWTUfdq/kvOG88dvEKlNNYGj8goz6+7qaVauANG6PXKSIb3xpvI/ub4vJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B6FC4CED0;
	Mon, 30 Dec 2024 21:02:03 +0000 (UTC)
Date: Mon, 30 Dec 2024 16:03:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Genes Lists <lists@sapience.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, lucas.demarchi@intel.com,
 thomas.hellstrom@linux.intel.com, stable@vger.kernel.org,
 regressions@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REGRESSION][BISECTED] Re: 6.12.7 stable new error: event
 xe_bo_move has unsafe dereference of argument 4
Message-ID: <20241230160311.4eec04da@gandalf.local.home>
In-Reply-To: <5f756542aaaf241d512458f306707bda3b249671.camel@sapience.com>
References: <2e9332ab19c44918dbaacecd8c039fb0bbe6e1db.camel@sapience.com>
	<9dee19b6185d325d0e6fa5f7cbba81d007d99166.camel@sapience.com>
	<20241230141329.5f698715@batman.local.home>
	<20241230145002.3cc11717@gandalf.local.home>
	<5f756542aaaf241d512458f306707bda3b249671.camel@sapience.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 15:52:14 -0500
Genes Lists <lists@sapience.com> wrote:

> On Mon, 2024-12-30 at 14:50 -0500, Steven Rostedt wrote:
> > On Mon, 30 Dec 2024 14:13:29 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > I guess the "fix" would be to have the check code ignore pointer to
> > > arrays, assuming they are "ok".  
> > 
> > Can you try this patch?
> > 
> > -- Steve  
> 
> Confirmed - all quiet now with 6.12.7 + your patch - I can test
> mainline too but doesn't look that useful.
> 
> Thank you for sorting this out so quickly.
> 
> 

I'll start making it into an official patch. Can I add your "Tested-by" to it?

-- Steve

