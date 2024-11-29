Return-Path: <stable+bounces-95804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662789DE18A
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 13:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A7628285E
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 12:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5DD19CC3E;
	Fri, 29 Nov 2024 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X9nr8zOJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qtmVVG8x"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B9219A298;
	Fri, 29 Nov 2024 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732882794; cv=none; b=RmmApQdkATCoUxqB3VWa1RTg0LMA0tD3sPAFCdIkvHVd6EvKWkCowyMpy/zF4/aqi1Yr23GmVkp24Ml3RotQYKvAms7xwDfbDAKrPcnheKVM6WGC2POf/HEMNuPedN1nnBY26hZE5jF9xsm7c2End2uT0Pns7SXWH/mCGIcTf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732882794; c=relaxed/simple;
	bh=y3brqNqcSMjGr29bjlKyPrmAL/v5Lr5Fejii/A7CD18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvX+tMDrvU1LsI0LvC/EaXiCj84jjJ/Wzpl6GKmYhCSW/P8KQVh901kNcfveR9zGCWNdCis6ZALtoK/eKo0ayPiC1pBr7lcsquIcFupSjOMoK6itpJPYy5R/08ATTm1Uh/GDJm2hZSrZnCgMSxNvbzcHWZLICYZiY4XTa5b1G+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X9nr8zOJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qtmVVG8x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 29 Nov 2024 19:19:29 +0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732882790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=194Dl+Ndd5fhcCTGY5CqE8SBD4dv8kTBgN0LNYowsjM=;
	b=X9nr8zOJWF6bBVz9rngb5ykLjOrZOhPXw2tNOEJaDM+zHtaI/XRDT01NS9jAlwprCxgncC
	woiZmqBZajLS3k/bsTs5oKGSyLMkY2NhnJfVDn4HnDnocAgrDpe1atKzVhyon0Mr8P6mbg
	Vj/OHIuxKgfPd5NR2jEgFYdvXvJ3El0X1QTvfLGjHud94bvOUBOSol9d8Q9hJzAMHvuVw2
	KdHB/2nL5kN5XGiM1r6C/M6RuiiDgzymeFpJ7OP3ofFzn3gd4ewwIcSkS8lWOZBVYXg0e+
	vT0fP/Aq3G9Z1gULIJnUap0FIM7XAwd1p+coazJwd9ib4WmrJCFzAkmYMknNDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732882790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=194Dl+Ndd5fhcCTGY5CqE8SBD4dv8kTBgN0LNYowsjM=;
	b=qtmVVG8xie1wpdQ1GBPd2eSy/fK/mjWvICrZ5Wmu1NcIFQjS+NpOVFlPFT3mjCGLsWkJSQ
	y1mP4KaZHY88bmDg==
From: Nam Cao <namcao@linutronix.de>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: kprobes: Fix incorrect address calculation
Message-ID: <20241129121929.tOHlWxwS@linutronix.de>
References: <20241119111056.2554419-1-namcao@linutronix.de>
 <7662be43-16e6-4695-9bc4-077e1dd3ba12@ghiti.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7662be43-16e6-4695-9bc4-077e1dd3ba12@ghiti.fr>

Hi Alex,

On Thu, Nov 28, 2024 at 02:02:40PM +0100, Alexandre Ghiti wrote:
> On 19/11/2024 12:10, Nam Cao wrote:
> > p->ainsn.api.insn is a pointer to u32, therefore arithmetic operations are
> > multiplied by four. This is clearly undesirable for this case.
> > 
> > Cast it to (void *) first before any calculation.
...
> This looks good to me, how did you find this issue?

I found it while working on RV monitors (Documentation/trace/rv) which
use kprobes. The monitors exploded on riscv.

Best regards,
Nam

