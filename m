Return-Path: <stable+bounces-155210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3F7AE280B
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CC2189F4A0
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E41DEFE6;
	Sat, 21 Jun 2025 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="j/2raRqf"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F31DED49;
	Sat, 21 Jun 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750494966; cv=none; b=V089xfr61FvHsTPcMYO8tGMk8AzKoXjvvnCyBmeYgNvbdr8I9izun0audDSOoHhruoc7sgg5XjdLgGCyGaAak7P3cD79LjJ/SAhTdDAEj8i+dRf9yhVYlJfDx2xDDjKkluyUIUf5pSY8Iv1m/HV0EZv4rXoob/9a5tFhNbNe4os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750494966; c=relaxed/simple;
	bh=S+btYjTpaDR+H9zyUrrcPktiVcYTaJ+qZKepdMYabL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7H6DegY5q850d9PpdDPdF0r6j+gfEeQJL4OqUapAxy3aj7cbynXoOCQ3KOhxKgfBtP+xsqZTYjr3YggR7jlhTfFgNYrThGQgCAmsYqcpd5eYV5dZ4Q37uctnbl3s4YVh1IkV3TgbgjLgh3+R0Kpl2rKGk5nOftYnRFqTq0ludg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=j/2raRqf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750494962;
	bh=S+btYjTpaDR+H9zyUrrcPktiVcYTaJ+qZKepdMYabL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/2raRqfQZYJBEm2re78QTL0BTQaV/Z43lecW5wB4bc2VXbrUcoX6PTNxn1tbBsNa
	 sjXbNhlmb54GvzDqXHbzOknSaoHlzpm+327kgvQQ0/OuOlwLbH0wR1JnYo3AtwvhwD
	 NincIln8AtI9tdAzynwiAtEuFtnEYvHmIGs9NOe4=
Date: Sat, 21 Jun 2025 10:36:01 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: fix spelling of FD_SETBITMASK in FD_*
 macros
Message-ID: <87bac9f6-1646-4a5f-84f7-1dd127717dbc@t-8ch.de>
References: <20250620083325.24390-1-w@1wt.eu>
 <e5561bc6-8220-4088-8bc0-0aba62c2cec3@t-8ch.de>
 <20250621082133.GA26919@1wt.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250621082133.GA26919@1wt.eu>

On 2025-06-21 10:21:34+0200, Willy Tarreau wrote:
> On Sat, Jun 21, 2025 at 10:19:52AM +0200, Thomas Weißschuh wrote:
> > On 2025-06-20 10:33:25+0200, Willy Tarreau wrote:
> > > While nolibc-test does test syscalls, it doesn't test as much the rest
> > > of the macros, and a wrong spelling of FD_SETBITMASK in commit
> > > feaf75658783a broke programs using either FD_SET() or FD_CLR() without
> > > being noticed. Let's fix these macros.
> > > 
> > > Fixes: feaf75658783a ("nolibc: fix fd_set type")
> > > Cc: stable@vger.kernel.org # v6.2+
> > > Signed-off-by: Willy Tarreau <w@1wt.eu>
> > 
> > Acked-by: Thomas Weißschuh <linux@weissschuh.net>
> > 
> > Let me know if I should apply it.
> 
> As you prefer, given that you already have other ones in flight, maybe
> you want to order them as desired. Otherwise I'll push it.

Then feel free to push it.
I have nothing going on right now.


Thomas

