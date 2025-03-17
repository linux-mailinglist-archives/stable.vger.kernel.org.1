Return-Path: <stable+bounces-124722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26705A65A55
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 18:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21959887C34
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E742C1B424A;
	Mon, 17 Mar 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp+fV+xw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732E21B043E;
	Mon, 17 Mar 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231371; cv=none; b=GGMl6dNMhxqK5A3T9uM7tdYszqgilorY0SaAqzcy4n3Oh8u0n1u71ISmuU44N9jl5IOWP/4FzAKU+YNdD0iO5FW0Q8z1GIxmGg/1csvwPWXEkEDrvRpKuRxR6TszqW3UHCO4fRTxC3JKqs7V89gO8E6205gLaXwumls2dI8/3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231371; c=relaxed/simple;
	bh=lzjEQyNrFqiofrWTqg+HjMoyqD6I8IOLRgBp+2jTyso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOooJX9e0Uf0erpsOAj0oXygfHTe7Ygwf+INcK2LrFRljJMrCzowgt2QbKpJXrxwSkOZhao9kfDYIxBbutdPU3pKTf6q+eTk3wOVgaLwMJ63Abk+kEJ4FfPNyGoZxAi8H6fJT4G0mqTJKo7rnpxfviki0xobBWIEz1D+xDy0AVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp+fV+xw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533C6C4CEE3;
	Mon, 17 Mar 2025 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231371;
	bh=lzjEQyNrFqiofrWTqg+HjMoyqD6I8IOLRgBp+2jTyso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mp+fV+xwdhZK133qDYGAH1lJlcZeYqEEBOP+TIvxjYbWscyk/SlTbprSzzi7hmflZ
	 soF/DaOzY2fCUZ7OmqJfKIYl1RXgJ8XgXpsA8mxbVKy9NOJEfvHIOJD4fhP33pJC08
	 clGMyJL7JjazS3XASZLN3UPbcZTlgfpTdDvDa77vFE7PRtYBiCpHuiuyTTtoEIxqKg
	 ZojCv6GsSZyI58NWpn+0/0edmGbDcU1pBUyws2a2NLvH0j0mCPlfszPLNIMTJ2tuR3
	 hsEHn5CmXe2bXpgYgbeGfkypWGx85rkwDKqU8AtVMILPJLvdFoW6gySFBAxa7n28Jg
	 WyFBDArppcahA==
Date: Mon, 17 Mar 2025 18:09:25 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Eric <eric.4.debian@grabatoulnz.fr>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Christoph Hellwig <hch@infradead.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jian-Hong Pan <jhp@endlessos.org>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-ide@vger.kernel.org,
	Dieter Mummenschanz <dmummenschanz@web.de>
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
Message-ID: <Z9hXRYQw1-fX0_PY@ryzen>
References: <Z8rCF39n5GjTwfjP@ryzen>
 <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
 <Z88rtGH39C-S8phk@ryzen>
 <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
 <Z9BFSM059Wj2cYX5@ryzen>
 <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com>
 <Z9LUH2IkwoMElSDg@ryzen>
 <d5470665-4fee-432a-9cb7-fff9813b3e97@redhat.com>
 <Z9L5p6hTp6MATJ80@ryzen>
 <6d125c69-35b2-45b5-9790-33f3ea06f171@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d125c69-35b2-45b5-9790-33f3ea06f171@redhat.com>

Hello Hans,

On Thu, Mar 13, 2025 at 07:47:11PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 13-Mar-25 4:28 PM, Niklas Cassel wrote:
> > Hello Hans,
> > 
> > On Thu, Mar 13, 2025 at 04:13:24PM +0100, Hans de Goede wrote:
> >>>
> >>> Considering that DIPM seems to work fine on the Maxtor drive, I guess your
> >>> initial suggestion of a Samsung only quirk which only disables LPM on ATI
> >>> is the best way?
> >>
> >> I have no objections against going that route, except that I guess this
> >> should then be something like ATA_QUIRK_NO_DIPM_ON_ATI to not loose the
> >> other LPM modes / savings? AFAIK/IIRC there still is quite some powersaving
> >> to be had without DIPM.
> > 
> > I was thinking like your original suggestion, i.e. setting:
> > ATA_QUIRK_NO_LPM_ON_ATI
> > 
> > for all the Samsung devices that currently have:
> > ATA_QUIRK_NO_NCQ_ON_ATI
> > 
> > Considering that this Samsung device only supports DIPM
> > (and not HIPM), I'm guessing the same is true for the other
> > Samsung devices as well.
> 
> Ah I see ...
> 
> > So we might as well just do:
> > ATA_QUIRK_NO_LPM_ON_ATI
> 
> Yes I agree and that will nicely work as a combination of
> ATA_QUIRK_NO_LPM + ATA_QUIRK_NO_NCQ_ON_ATI functionality
> so using tested code-paths in a slightly new way.

I sent a patch that implements your original suggestion here:
https://lore.kernel.org/linux-ide/20250317170348.1748671-2-cassel@kernel.org/

I forgot to add your Suggested-by tag.
If the patch solves Eric's problem, I could add the tag when applying.


Kind regards,
Niklas

