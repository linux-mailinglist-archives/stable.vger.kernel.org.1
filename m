Return-Path: <stable+bounces-137183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E8EAA1207
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B9C4A6A04
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556E2244679;
	Tue, 29 Apr 2025 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="odBTB5Qy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3QIFNafg"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE7229B05;
	Tue, 29 Apr 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945310; cv=none; b=tNGalp8KFT5EBaLd+ydWFFXBpofD3xSkFPxtW0mj3lANypDSITB9g20+oN2WpJk6BhtW5IyLT5b9ybtIJE/UzxmqQIItj2chAWFhfIe5PhJSsrgSR0L7WHZsLd/1axOa0ix+6N4l/hh97DkPPwhpwnFYVaA1CDaIVBSnavl4kV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945310; c=relaxed/simple;
	bh=qPz8W9mQRFkr+tQs+W2tyTIpPrmHqC39JGGcuMRU22s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj15BYuWnr3xgl3COECzgevjRNz8XDgkHvzsqkPg7OKpJXtldREontFAWeMPSH8q5b18yfMjkAJG/5kYwhXGOnOoTYkIn6tq//5sCY2Btywvm/33qa6N4F3WIxY0IPUEhiF+GwuxVo1zZMLU4p+JGP1vFtUNEux6hx3DRTyPjog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=odBTB5Qy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3QIFNafg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Apr 2025 18:48:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745945306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eesAZMgstduPVaEESNAi0LnDjxGoJvSDuC/mj3w1pYU=;
	b=odBTB5QykgKLaJoG3eJifs7bkg4z54MWQmZDMSDQ+hP4Qw1WCEALVv4DRJ+6me3mIW8kmY
	Q7jqyd/6qjzwZThiTcj+skcpCQ/xcPFjVdN25wvVWmva+1fl69J3EX1GTXN/sEX3/o4Eks
	b9LHQvRHyR0IjYDrIAwvYdNCpC1gdF4gVEMOJNl0EO6tNCG07f+Sg6KAD9ZBsRxFwWwxPg
	q9yw/Unxsd9EzXs7ikI2TFiFe1efpRnzESQATSzzkOZhnZHWXdzBvenBo5y+Q6a2J/J7xr
	Bv/jE8k7YuugsjkdKcGLzdBgQDLtkEbpQm6rtznaSKNSMOxOU02isPnZJbTJ2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745945306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eesAZMgstduPVaEESNAi0LnDjxGoJvSDuC/mj3w1pYU=;
	b=3QIFNafg6nxw8am8DCLkuq71zFvv4hecAyBBCes9WCZvY7dNUVVJf1qLzVZ/FRfGCp0UHO
	adH1ylpazfq0GIBA==
From: Nam Cao <namcao@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Kai Zhang <zhangkai@iscas.ac.cn>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable v6.6] riscv: kprobes: Fix wrong lengths passed to
 patch_text_nosync()
Message-ID: <20250429164614.g3w8JJAk@linutronix.de>
References: <20250429161418.838564-1-namcao@linutronix.de>
 <2025042945-financial-rumbling-bcd0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025042945-financial-rumbling-bcd0@gregkh>

On Tue, Apr 29, 2025 at 06:31:09PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 29, 2025 at 06:14:18PM +0200, Nam Cao wrote:
> > Unlike patch_text(), patch_text_nosync() takes the length in bytes, not
> > number of instructions. It is therefore wrong for arch_prepare_ss_slot() to
> > pass length=1 while patching one instruction.
> > 
> > This bug was introduced by commit b1756750a397 ("riscv: kprobes: Use
> > patch_text_nosync() for insn slots"). It has been fixed upstream by commit
> > 51781ce8f448 ("riscv: Pass patch_text() the length in bytes"). However,
> > beside fixing this bug, this commit does many other things, making it
> > unsuitable for backporting.
> 
> We would almost always want the original commit, why not just send that
> instead?  What is wrong with it being in here as-is?

The original commit is probably fine. But I'm paranoid, because it is not
completely obvious whether the original commit would break something else
in v6.6. Because, as mentioned, it does more than just fixing the bug.

Best regards,
Nam

