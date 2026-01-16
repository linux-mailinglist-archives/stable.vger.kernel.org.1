Return-Path: <stable+bounces-210026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D00D2FB75
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6E230402E5
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D921935FF55;
	Fri, 16 Jan 2026 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VR1w6AWs"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0225328251;
	Fri, 16 Jan 2026 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768560096; cv=none; b=lhgrV0tIraNqhYvjwu3vovSQ9bBIxtPIxEZ1mQkYxZ0VxiWChec6+9N4ZddaGSkFAec7zD7LNW7PvOfsx+IoJLlkpQfJztxM1BmvcgHR9FT5qCNB0Sohstx1BCUeDZoM6cYVxjlPp++df2OkigWv0V231fVXFUYiErQGZnpNATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768560096; c=relaxed/simple;
	bh=3/C+bWgi0AfThekNiJDrSBW0qKtbD2zWV53O+N+nWFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnJcGylb2Dk5G4fUOwToq38k1e+e7aRntMZANfBh9X9wn1Q+GD9aByhw2jijCTT70DFIgsov25LOf5VBL5MXKqPGn8vBL0/eEAT+5UW5lcdibsuvkdV5Rpwm3XesuCdVUlgLUjnCXzcuSRytDAz0LLAMXVDCB8LY7DjobOrAzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VR1w6AWs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zmLDc/17mwH11CUQcCK0FYcncTQlL4lJDwKWt250yK0=; b=VR1w6AWsMIwWwzJQxxlrjeLOp+
	tFlkx+9KDbMc75Bleh9vyH3m+qBFV5TbxYGYOLLwRoj7gE3AjtN/KEjQQvAXPzbV5BIfHiTYYQxkJ
	m4bNiOwC3ji45RPlKZtjQjfc95zimHB8UYZ4yU3uCrXVVmyqP2PZNYL4fgCPvefY81tCMydNhTZL8
	1XRHWUZN7C5QY5vNNqHIrCMniYis3RvjzBjfcKV28D18dPsSJJKludBE1nbKtFPMh222amzGqHG0/
	VVXlBPl8feQdlAeM75dn52wTysLUu/DdqOgfrwEOClPBh6w0mJdT2+4giCYuuK5JtSoaYOFQ8w8IN
	3se7tAvQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vghGi-00000008W1E-3LCk;
	Fri, 16 Jan 2026 10:41:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 93D273005E5; Fri, 16 Jan 2026 11:41:27 +0100 (CET)
Date: Fri, 16 Jan 2026 11:41:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: tip-bot2 for Oleg Nesterov <tip-bot2@linutronix.de>,
	linux-tip-commits@vger.kernel.org,
	Paulo Andrade <pandrade@redhat.com>, stable@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: perf/core] x86/uprobes: Fix XOL allocation failure for
 32-bit tasks
Message-ID: <20260116104127.GA1890602@noisy.programming.kicks-ass.net>
References: <aWO7Fdxn39piQnxu@redhat.com>
 <176851343815.510.11862479025865189952.tip-bot2@tip-bot2>
 <aWoMN5oCPIl2M2DP@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWoMN5oCPIl2M2DP@redhat.com>

On Fri, Jan 16, 2026 at 11:00:23AM +0100, Oleg Nesterov wrote:
> On 01/15, tip-bot2 for Oleg Nesterov wrote:
> >
> > The following commit has been merged into the perf/core branch of tip:
> 
> Damn!
> 
> thanks Peter, but...
> 
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -1823,3 +1823,27 @@ bool is_uprobe_at_func_entry(struct pt_regs *regs)
> >
> >  	return false;
> >  }
> > +
> > +#ifdef CONFIG_IA32_EMULATION
> > +unsigned long __weak arch_uprobe_get_xol_area(void)
> 
> Oh, but x86 version should not be __weak. Copy-and-paste error, sorry :/
> 
> What do you want me to do now,
> 
> 	- send V2 ?
> 
> 	- send another s/__weak// patch on top of this hack?
> 
> 	- or perhaps you can fix this yourself?

I'll have to rebase anyway, might as well fix it directly.

Thanks!

