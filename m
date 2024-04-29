Return-Path: <stable+bounces-41695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A5E8B57EC
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F007286D80
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430D7745FA;
	Mon, 29 Apr 2024 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sz8zeAn/"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9601B94D
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393058; cv=none; b=MiwDGA2A+2+KAr+zcOS2y548Z+K/0klffWnJeL5SWmzVYoXbfQygRnnQj62SkQzuSNC0WdLZzwGNN2t51P/Ooirb1pYca8MOo/8YzKPAyhLFVcq6unH9lciYTdhRvH61KmxwwnEuDB+880Cmd7EAOcRFoXxIavBg0Gk4nf8Yq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393058; c=relaxed/simple;
	bh=HGfBt+Fza2UFEr/W9T7dNZvNerrOp8Y1sQziorbFaTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8qzr0U4dXBKutoSB09Ypdbs69lF2mlMdshXaC8DsTiyymIFZNUS3PkKolwumeDkTrJ32i4qOBa7wFHS52WwyRZE5NFBh9JBGoyU/2+xg3CX/1Dr/IMLJ74Epv0FdOhJasqWNvTfmmxJSCi1aurdqjxlTzTfOuX/hOAJ593eli0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sz8zeAn/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ZThOf7gSG10pOleANmystZpY4GhFeC5dog3QGqVfAtY=; b=sz8zeAn/hdzumII8kzH5Tk8QgV
	hbOLMy+krKD2bXrleiuPad1wigR3MixsCYK6HE06TydIigwPV/WFDJD42cmoELdhV6ukQLrDoiIYl
	TF3cGLVaoz1tdakpOk1uWDYM7cmzIzKJKU8cWuQ5Utf4176euidAnPbWDaoZCI0Py2qkzxVS0knkj
	z9HrcAkOHhrtQMlYCw9hsYCOdT3zA7+K8IHeHH6EB/MPVSWXqvwm2WHA3gtywgDX5seulzPM0oFr1
	/G/cUumgh3/NwVMgmfAMmjkMn4f42fpCs36yzHXfU2VCzxu45p4ZreDHFjof9+brxDt68lkdJF2vn
	lNLn2UQA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Pwo-0000000CP9T-1qaJ;
	Mon, 29 Apr 2024 12:17:30 +0000
Date: Mon, 29 Apr 2024 13:17:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: =?utf-8?B?0JzQuNGF0LDQuNC7INCd0L7QstC+0YHQtdC70L7Qsg==?= <m.novosyolov@rosalinux.ru>
Cc: riel@surriel.com, mgorman@techsingularity.net, peterz@infradead.org,
	mingo@kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org,
	sashal@kernel.org,
	=?utf-8?B?0JHQtdGC0YXQtdGAINCQ0LvQtdC60YHQsNC90LTRgA==?= <a.betkher@rosalinux.ru>,
	i gaptrakhmanov <i.gaptrakhmanov@rosalinux.ru>
Subject: Re: Serious regression on 6.1.x-stable caused by "bounds: support
 non-power-of-two CONFIG_NR_CPUS"
Message-ID: <Zi-P2rrWZTlrpi3B@casper.infradead.org>
References: <1c978cf1-2934-4e66-e4b3-e81b04cb3571@rosalinux.ru>
 <Zi8MXbT9Ajbv74wK@casper.infradead.org>
 <134159708.2271149.1714363659210.JavaMail.zimbra@rosalinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <134159708.2271149.1714363659210.JavaMail.zimbra@rosalinux.ru>

On Mon, Apr 29, 2024 at 07:07:39AM +0300, Михаил Новоселов wrote:
> >> It was backported to 6.1.84, 6.1.84 has problems, 6/1/83 does not, the newest
> >> 6.1.88 still has this problem.
> > 
> > Does v6.8.3 (which contains cf778fff03be) have this problem?
> > How about current Linus master?
> 
> 6.1.88 - has problem
> 6.6.27 - does not have problem
> 6.9-rc from commit efdfbbc4dcc8f98754056971f88af0f7ff906144 https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git - does not have problem
> 
> 6.8.3 was not tested, but we can test it if needed.

How curious.

> > What kernel config were you using?  I don't see that info on
> > https://linux-hardware.org/?probe=9c92ac1222
> > (maybe my tired eyes can't see it)
> 
> Kernel config for 6.1: https://abf.io/import/kernel-6.1/blob/bcb3e9611f/kernel-x86_64.config

CONFIG_NR_CPUS=8192

> For 6.6: https://abf.io/import/kernel-6.6/blob/7404a4d3d5/kernel-x86_64.config

CONFIG_NR_CPUS=8192

Since you're using a power-of-two, this should have been a no-op.
But bits_per() doesn't work the way I thought it did!

#define bits_per(n)                             \
(                                               \
        __builtin_constant_p(n) ? (             \
                ((n) == 0 || (n) == 1)          \
                        ? 1 : ilog2(n) + 1      \
        ) :                                     \

CONFIG_NR_CPUS is obviously a constant, and larger than 1, so we end up
calling ilog2(n) + 1.  So we allocate one extra bit.

I should have changed this to
DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS - 1))

Can you test that and report back?  I'll prepare a fix for mainline in
the meantime.

