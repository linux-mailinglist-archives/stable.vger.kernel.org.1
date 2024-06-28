Return-Path: <stable+bounces-56075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1081891C2A8
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 17:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85F41F229CC
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38A41C2308;
	Fri, 28 Jun 2024 15:30:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52D41DFFB;
	Fri, 28 Jun 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588650; cv=none; b=GvisH3cvdZ/DVqtZ82CBwATSF8X+84Cs6bbDk2s+7HOtFRoW1P6gLOJyTm56R4gbZOThklfVqvLEp/m99W+90i4GZz4lqNXcn5qbpopzQs4Hx2YUzfpcJJfFqnyx/iHrBBMnFWlDBNkENElbEn0QNhp4oZ6ASBq4SzGg5nLSpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588650; c=relaxed/simple;
	bh=4HDsAVLZLxiZ5+G1Zto3N3DQCl/QQAc8FlAsBMy/RFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jexVyPOd8rZZFXainobw7biNzuW+bXPDLOJPZ0rE5SjkM3exiyihwuVuAhi5cnDIDpk1MbFyvgq0UmElFg88PQinyE6dnVvSNeW8YRJvTg6ovaUwiGiPTHoOBNFSTYricDi/m8/YoYiux10PD0Cb1owZ/wDbmGjryDGfTC05URk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1sNDYJ-0002WE-00; Fri, 28 Jun 2024 17:30:19 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 5643FC031A; Fri, 28 Jun 2024 17:29:49 +0200 (CEST)
Date: Fri, 28 Jun 2024 17:29:49 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, ms@dev.tdt.de
Subject: Re: Patch "MIPS: pci: lantiq: restore reset gpio polarity" has been
 added to the 6.9-stable tree
Message-ID: <Zn7W7SPHgZrsZcrn@alpha.franken.de>
References: <20240627185200.2305691-1-sashal@kernel.org>
 <Zn5easOVbv3VGAMu@alpha.franken.de>
 <2024062827-ransack-macarena-b201@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024062827-ransack-macarena-b201@gregkh>

On Fri, Jun 28, 2024 at 04:18:37PM +0200, Greg KH wrote:
> On Fri, Jun 28, 2024 at 08:55:38AM +0200, Thomas Bogendoerfer wrote:
> > On Thu, Jun 27, 2024 at 02:52:00PM -0400, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     MIPS: pci: lantiq: restore reset gpio polarity
> > > 
> > > to the 6.9-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      mips-pci-lantiq-restore-reset-gpio-polarity.patch
> > > and it can be found in the queue-6.9 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > 
> > can you drop this patch from _all_ stable patches, it was reverted already
> > in the pull-request to Linus. Thank you.
> 
> What is the git id of the revert?

6e5aee08bd25 (tag: mips-fixes_6.10_1) Revert "MIPS: pci: lantiq: restore reset gpio polarity"

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

