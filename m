Return-Path: <stable+bounces-177662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71932B42AE2
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 22:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CE95E568F
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 20:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FDB2E1C79;
	Wed,  3 Sep 2025 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H5YGLXGv"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6C2989B5;
	Wed,  3 Sep 2025 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931289; cv=none; b=J5QHwffh6oUeQJy6iAh9i20xPyBwOqm0sUIHoresy5q9BzPxcgNmKkN6ACBHz4zatgIABk0XAI2jblIubJ4mOMGb8xNSXTycdV6glmBnSTB42+UtmLfagRbP+60gqVUy2nQRaSeG8adNwpxW47v2O9ymWs9ed2o7Boh8jTciARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931289; c=relaxed/simple;
	bh=FXX7vCndb5jyCNrEFKxEbiBmLyA2whfFQXrgWUo3LWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnQsCVRD32YxhTGEqrdI4ww9PS+UhOq0kJmCya4xDmqZxc5tS8FbU39pFu4qjMITQn0XxnbMRqnuamzuk5FeMudE6nl8Av0OfDbzzlkQ4DLGvr3FgnvdMO9S3dyCKzaqNigJxDZmBj04vb+DIyYi/9PEroyyYz8u1pXdtGcEP0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H5YGLXGv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dQqseQNcgscixdyVaCFhVdxJCiisNidf6D68QVReldg=; b=H5YGLXGvwHqOU/EB798ChPDAvM
	LNit1fcg/BOsGWvScZvXYhKHhTsRTq5MjLWgslJVBPe16gJSLUZVjzIHbxb9LoUwzJDAOYLGA3Y50
	giJU3Ln/9focte8EeBeSmPGAUbHsHzvy4cUO24bbT24E+tX8intdAGA9GAtkCuhVW2Er8TcmEydSl
	YnEK6uRox5KJORRolqgf5iEAKymmE50AUH1L3/YIeCt6XrouzinlvbxZN6YXRWErmKnBFoHa/Tgj4
	yLF3SyCwcqKwz+kFlsxF6UWhQGciR24sUsZB41HKvfpJZ9C2YSCSLLn5oKcnP8tjsH2EInS47btj4
	gzNOdH3w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utu5L-00000007fvU-1cO1;
	Wed, 03 Sep 2025 20:28:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 97F59300220; Wed, 03 Sep 2025 22:28:03 +0200 (CEST)
Date: Wed, 3 Sep 2025 22:28:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RFC] riscv: Do not handle break traps from kernel as nmi
Message-ID: <20250903202803.GQ4067720@noisy.programming.kicks-ass.net>
References: <20250903-dev-alex-break_nmi_v1-v1-1-4a3d81c29598@rivosinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-dev-alex-break_nmi_v1-v1-1-4a3d81c29598@rivosinc.com>

On Wed, Sep 03, 2025 at 07:54:29PM +0000, Alexandre Ghiti wrote:
> kprobe has been broken on riscv for quite some time. There is an attempt
> [1] to fix that which actually works. This patch works because it enables
> ARCH_HAVE_NMI_SAFE_CMPXCHG and that makes the ring buffer allocation
> succeed when handling a kprobe because we handle *all* kprobes in nmi
> context. We do so because Peter advised us to treat all kernel traps as
> nmi [2].
> 
> But that does not seem right for kprobe handling, so instead, treat
> break traps from kernel as non-nmi.

You can put a kprobe inside: local_irq_disable(), no? Inside any random
spinlock region in fact. How is the probe then not NMI like?

