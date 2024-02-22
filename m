Return-Path: <stable+bounces-23379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D5185FF2B
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 18:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24BB1F2CADF
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70C0154C14;
	Thu, 22 Feb 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A6okmszY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAFF19478
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622371; cv=none; b=ZE8IVxlGxf4ylfj93j7QMI6TP+m+COqVDG6hLn3CHN56RZvjaUT/hCqUhOCtt2G0Rbf9MI6t0hZfBNeOfjKjXWacnPPloyPhWg/d65JoCF6kPONRhSAN4y9pAYO6cJ8PaY1o9Gk8RCzmxPSyF0f3iXE7t2caKy0gFaMpHAC+++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622371; c=relaxed/simple;
	bh=e2QeeR7UkEfhynkaY7xh20rFDgsHGsKYRGvuq1qVdXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7UgcdKKWrSEegKsbsuUMdjiZ2DdzUAdi1FNOA8Xv/7/SeY0b1yBCTClLxt75zN0Xg6Yk4Lh/2JB0Nv7gjhKqSaTinfycFeFOK8frOXfrnqjxFZ22ImU71PUGnmp9DtHypxl1qCq0dXWIEbJd6OoM2PO1ONWniZwPkhlkcPoLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A6okmszY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773C3C433F1;
	Thu, 22 Feb 2024 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708622371;
	bh=e2QeeR7UkEfhynkaY7xh20rFDgsHGsKYRGvuq1qVdXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6okmszYgQDuQ0CgXTJP6ljP/30qIjK5N8sgR0Pes2u/W0rs2j41LJgFAAGAIgWlV
	 i48GigUGzWeGO5TQcnCfNy6Gs8PY16ApwBGA8op9lyKjXLiS8D8HpsoE+btPsNJ/tL
	 FEHcCm9A5gRERjyNvUZ5hfg65BnzsPIPapYHDNzM=
Date: Thu, 22 Feb 2024 18:19:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Cyril Hrubis <chrubis@suse.cz>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] sched/rt fixes for 4.19
Message-ID: <2024022258-hypocrisy-unrigged-6905@gregkh>
References: <20240222151333.1364818-1-pvorel@suse.cz>
 <2024022218-fabric-fineness-0996@gregkh>
 <20240222165049.GA1373797@pevik>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222165049.GA1373797@pevik>

On Thu, Feb 22, 2024 at 05:50:49PM +0100, Petr Vorel wrote:
> Hi Greg,
> 
> > On Thu, Feb 22, 2024 at 04:13:21PM +0100, Petr Vorel wrote:
> > > Hi,
> 
> > > maybe you will not like introducing 'static int int_max = INT_MAX;' for
> > > this old kernel which EOL in 10 months.
> 
> > That's fine, not a big deal :)
> 
> Thanks for a quick info. I guess this is a reply to my question about
> SYSCTL_NEG_ONE failure on missing SYSCTL_NEG_ONE. Therefore I'll create
> static int __maybe_unused neg_one = -1; (which was used before 78e36f3b0dae).

Great.

> > > Cyril Hrubis (3):
> > >   sched/rt: Fix sysctl_sched_rr_timeslice intial value
> > >   sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
> > >   sched/rt: Disallow writing invalid values to sched_rt_period_us
> 
> > >  kernel/sched/rt.c | 10 +++++-----
> > >  kernel/sysctl.c   |  5 +++++
> > >  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> > Thanks for the patches, but they all got connected into the same thread,
> > making it impossible to detect which ones are for what branches :(
> 
> > Can you put the version in the [PATCH X/Y] section like [PATCH 4.14 X/Y]
> > or just make separate threads so we have a chance?
> 
> I'm sorry, I'll resent all patches properly.

No worries, the second round looks good.  I'll queue them up after this
latest set of stable kernels goes out in a few days.

thanks!

greg k-h

