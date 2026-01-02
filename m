Return-Path: <stable+bounces-204488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54235CEEDD0
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 16:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 229EC301EC66
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C3C2673AA;
	Fri,  2 Jan 2026 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aWVJdlHC"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091B222F772;
	Fri,  2 Jan 2026 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367349; cv=none; b=RHxhp7eEwH9vykZTb+eLEWbdzyxKXhRzMoRCQ1r2gWL8xUPw7OGWZ3NUeSh15wv7J6RzBgcwEavAEwpdAbdBo7IfZAxv15kaPQjg7zcdB/xJXGakPLHUjg6sfO0uAR5tCIeJJ3JbELlLSt8oxA0sZBzFOwjLr9pqwqvZVBPrhDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367349; c=relaxed/simple;
	bh=ex4F+6drm7YP9wB2pd5PXYYgeLj3LuztRrHWDc4/1gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOSzrHG+PDFsDR4YXetEc/ttdJQeZ0MZ9Bl/Ryq1AR+MnbPZ8EnAfts9/t30eAlMU6RAluKQ8yY1XneNcpKgSkv4eofY8c41yFSrxn7MN+xnOj/3TMRBNQTTbXn1FNZaUFzHOgjD9iEfcmJ2yddpuLybV53zDEEf1Wt5+uSoqQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aWVJdlHC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Mfp0vOpU/C0y9oWZefdEhz0M9QMslqJoP/j34iw2EJc=; b=aWVJdlHC5dLL0Orukc+rZLMyXb
	wOoBw7oxhxZDILMWSN0N9Cw088qKKM3wBoDdGXPjRy537XJlLV0nMa8SBYB3vtGWiZHcWDdL+lx9p
	s47NzV1YbwPcnEUXW1Me4hpp3Fr/P35kgFBf+o0iSAN7T79Z0gt0dHjTqKCwdZ2bRYCHhTmfPyby0
	SL77zSmY2CGgLRjeIfWp/4pjPZ4HfV/ovYCZ4SLNEKaglry8EK9yP9OY63aFvZeulItXe7QgnA6Mj
	Rr0Qjkh4B4rcrLSIp+mgXkVwDFvob1Baft90Or1EDxR7ASDVcPIX3PbgVqvubwxGn4sscUjFenNrz
	ULJtY4Og==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbgyq-00000006eoL-49Ea;
	Fri, 02 Jan 2026 15:22:21 +0000
Date: Fri, 2 Jan 2026 15:22:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org
Subject: Re: [PATCH] ARM: fix memset64() on big-endian
Message-ID: <aVfirJvsYt0-jDRD@casper.infradead.org>
References: <20260102-armeb-memset64-v1-1-9aa15fb8e820@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260102-armeb-memset64-v1-1-9aa15fb8e820@linutronix.de>

On Fri, Jan 02, 2026 at 08:15:46AM +0100, Thomas Weiﬂschuh wrote:
> On big-endian systems the 32-bit low and high halves need to be swapped,
> for the underlying assembly implemenation to work correctly.

Heh.  In my heart, ARM will always be a litte-endian architecture.
I'm not really surprised this bug took, er, 8 years to show up; big-endian
arm is rare enough and memset64() isn't much used on 32-bit systems.
And it turns out that many of the users pass a constant 0 as the value,
which was kind of not the point, but it seems to be an easier API to
use than memset, so whatever ;-)

> Fixes: fd1d362600e2 ("ARM: implement memset32 & memset64")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

