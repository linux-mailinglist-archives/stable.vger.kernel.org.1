Return-Path: <stable+bounces-152856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28660ADCE0F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45EF27A3505
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A76D1865EE;
	Tue, 17 Jun 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bHMX6qod"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29897224D6;
	Tue, 17 Jun 2025 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167997; cv=none; b=MSk0M1v/t/slLAqRU1nM9uH6abgCXGqCvcUBprCaRcPZDYSCAhb5uCNa0suebyc2rpurny2Bmw8FT+7mhE1HQDVumC718rnt/FCDC3HlqWMGYiPwgOTGswFsHkV9yYoBDwfN+Zq0WEs0tBLiLwDQp4oSZslkMV/KVOPSyTrk9cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167997; c=relaxed/simple;
	bh=9Aiss+lJlN2GFCeLAC0fBbI1Y2lLSDsGqL5H/o73/gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f02RXNjf1UQVxyQAF+W7uT5JAL4jGfowBo07rwNF3WmhdeJGjuRpWvHpyGCTmYe7dSHz4DNqq2Z+Mf0RRFvGx5/I72XdF4m9/dhc5cGiWGA3yMi++K5EmBVlHOGkxoGGNvtmUiSidHQpuvDMjn090NNGrgHcQJEW70YSCC6U4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bHMX6qod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294CBC4CEE3;
	Tue, 17 Jun 2025 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750167996;
	bh=9Aiss+lJlN2GFCeLAC0fBbI1Y2lLSDsGqL5H/o73/gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHMX6qodS2S5n4lQLF3YO/mNuqK/+1wYfGVDbSLKLgre5ksr0cF2+IQU/mjyQ7hia
	 9CaDDv/vXEhuN5rP1TEMPcTcmOzbioK2fJB7DWdoJokJ6FoM1oFamEzClFQTTPD15h
	 cqWJudrGS4XLDAAe7BzgVUuPnhkanXR+AO1BYLyk=
Date: Tue, 17 Jun 2025 15:46:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Patch "powerpc: do not build ppc_save_regs.o always" has been
 added to the 6.15-stable tree
Message-ID: <2025061725-manor-module-d648@gregkh>
References: <20250610115602.1537089-1-sashal@kernel.org>
 <1b88323e-8d79-4a79-9e6a-ea817a9e056b@kernel.org>
 <784650aa-80e5-4f1a-8a7f-6e61c3225e77@csgroup.eu>
 <8242fbd5-85f8-4ab0-b796-24d0048e8bdc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8242fbd5-85f8-4ab0-b796-24d0048e8bdc@kernel.org>

On Wed, Jun 11, 2025 at 12:15:07PM +0200, Jiri Slaby wrote:
> On 11. 06. 25, 7:39, Christophe Leroy wrote:
> > 
> > 
> > Le 11/06/2025 à 06:15, Jiri Slaby a écrit :
> > > On 10. 06. 25, 13:56, Sasha Levin wrote:
> > > > This is a note to let you know that I've just added the patch titled
> > > > 
> > > >      powerpc: do not build ppc_save_regs.o always
> > > > 
> > > > to the 6.15-stable tree which can be found at:
> > > >      https://eur01.safelinks.protection.outlook.com/? url=http%3A%2F%2Fwww.kernel.org%2Fgit%2F%3Fp%3Dlinux%2Fkernel%2Fgit%2Fstable%2Fstable-queue.git%3Ba%3Dsummary&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cf9c2453dd6154212e43a08dda89ea845%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638852121563909145%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=ckwC5j7O2j%2FATCggT3jwcKl3K5HRVpwA7DxjZUGnwZg%3D&reserved=0
> > > 
> > > Please drop this from all trees. It was correctly broken. The whole
> > > if was removed later by 93bd4a80efeb521314485a06d8c21157240497bb.
> > 
> > Isn't it better to keep it and add 93bd4a80efeb ("powerpc/kernel: Fix
> > ppc_save_regs inclusion in build") instead of droping it and keep a bad
> > test that works by chance ?
> 
> Makes sense to me too (it worked by a chance for almost a decade). So all or
> nothing...

Ok, I've done that now, thanks.

greg k-h

