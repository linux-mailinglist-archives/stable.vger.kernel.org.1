Return-Path: <stable+bounces-65371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F0947A1C
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 12:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830731F21667
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DF71547F2;
	Mon,  5 Aug 2024 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O9q5DlN0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VjLtUHMg"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED81311AC;
	Mon,  5 Aug 2024 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855519; cv=none; b=lonD9pYWVFP57Wtcfuc8m88YwzV7XvqQg17SdHaKFeVSXnrCQht/M3dh0WcS2DyZTV02Q49q0WRV+DxAbnY+8ZgXjbmgNTLjBNjzmu0TJwW0CMh0Flhe17xA08ds7PH+KwhAP777TNIu37TDCz6RaceSvfR801dUMhDLnA4ukVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855519; c=relaxed/simple;
	bh=iCDyLJDJcrNsVT2B/JZ97EcLspik/XX/andmruk85YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3UuqxkgxoZ5lpZxoye36rlNfHppY7cwh56HsYHi7PVmdmrJfZ9qXQP/k8uKCzB9iwqivgdvl0EAqACDNlZY/Hp7byd1PGM6cIxQFoR/zcbHD3373BAWQPwpcKtKBJaG6xmy49eI3UKRWXMOi8qD1YswokeTDZVRLOry2CQw2xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O9q5DlN0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VjLtUHMg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 5 Aug 2024 12:58:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722855516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hOQHdh8C0L92v8N4xs5E7i95vlFnGxFZ44qi7RqxWX8=;
	b=O9q5DlN0lF2Q3joYKlNpQcOkviufksOsRpjlhk41A9yKIzSs5q1ZbZ6BEOp5oOsUzxdkXt
	lv44IGllo7dE+vnJKGN0HQ2oLR746kJbnnrwsfMnd0nkG3VhI5r1uGjqiK564kmIX8MeiO
	BHRkBdBcpePUvihblGBgZ9aPlDav2XQ8zUs8r8NKJlzLCBA0+jRR34W3E34ChMFJ4qShvC
	RpaeXCyBm03vfgAn/yVSPA6udEc4qNapIO18YDEPybGtRTSeCWV0dmDy1l3XmdMUmc+W3Q
	pG751KoMXv2dNnOhP6eyBGfxSEuQ9O1wIuvk7W66TgE5hFGbnH4QJ2fX7v1imQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722855516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hOQHdh8C0L92v8N4xs5E7i95vlFnGxFZ44qi7RqxWX8=;
	b=VjLtUHMgnh1PtNOSAJwdeVCqs3pcvMtsai8Qdk8v17qfE5QPWycuyztaZ8veaQNYVPzBDE
	MhscXepMUqxC9hDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Kroah-Hartman, Greg" <gregkh@linuxfoundation.org>
Cc: Clark Williams <williams@redhat.com>,
	stable-rt <stable-rt@vger.kernel.org>,
	stable <stable@vger.kernel.org>,
	"Claudio R., Luis" <lgoncalv@redhat.com>
Subject: Re: CI build failure in v6.6-rt
Message-ID: <20240805105834.9GZL-G9o@linutronix.de>
References: <CAMLffL9t0SFkO90d6pFZAwp-WVbont7NgELx_WW-GRRYkF_QXA@mail.gmail.com>
 <2024080344-division-undertook-4905@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024080344-division-undertook-4905@gregkh>

On 2024-08-03 08:20:16 [+0200], Kroah-Hartman, Greg wrote:
> On Fri, Aug 02, 2024 at 08:46:55PM +0000, Clark Williams wrote:
> > Greg,
> > 
> > Kernel CI is reporting a build failure on v6.6-rt:
> > 
> > https://grafana.kernelci.org/d/build/build?orgId=1&var-datasource=default&var-build_architecture=riscv&var-build_config_name=defconfig&var-id=maestro:66a6b448bb1dfd36a925ebef
> > 
> > It's in arch/riscv/kernel/cpufeature.c where a return statement in
> > check_unaligned_access() doesn't have a value (and
> > check_unaligned_access returns int).
> > 
> > Is 6.6 stable supporting RiscV? If so then we either have to fix that
> > return, or backport the refactor of arch/riscv/kernel/cpufeature.c
> > (f413aae96cda0).  If it's not then who should I talk to about turning
> > off riscv CI builds for v6.6-rt?
> 
> Why not ask the people responsible for the -rt patchset?  If this isn't
> an issue on a non-rt kernel, then I think you found the problem :)

I'm sorry. I misunderstood Clark and assumed this is a stable issue. Now
that I have the needed pointers, it is a RT-stable issue only.
I'm going to drop the stable folks from Cc: and reply with a patch.

> thanks,
> 
> greg k-h

Sebastian

