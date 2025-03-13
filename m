Return-Path: <stable+bounces-124329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE09DA5F9D2
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 16:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 355DD7A7D29
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 15:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2DB2686B4;
	Thu, 13 Mar 2025 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ykaaz8Ev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2809063B9;
	Thu, 13 Mar 2025 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879726; cv=none; b=B6h0R2I8xmT09SGQjJYMdIq3Mz1cNScD+Dx73YpekeWGFnMfN13DoGKd9nHfTUx9QwGlB0EYAvAoIjFziFowNRApIzlU7QO4Z25iyq80qzoi5mPyRwwDH+5qeT3YksGvNl74kUwVrEJeON6I3+dNIitjTUOs6cWqclNBIZ/C7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879726; c=relaxed/simple;
	bh=lIR/mv+/T4+eBiXevpWk0XOQ03DNNvzlfMdH31gNmlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL877RvwjuG4/t+4XXPo0F9GqEFnXgodDUInauYwk3jYifW4ehp8des+e8J2NB4+LSU9M5SxyFzmQCMhI2VPaselhnoA3H1zdjYdmic3+PGU6IHtk02+H4LDXzdQfYzH4yGEjnLfyeNcwzwU8iUbtNLvDP+6U8ep/u2jdbCNVvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ykaaz8Ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA68AC4CEDD;
	Thu, 13 Mar 2025 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741879724;
	bh=lIR/mv+/T4+eBiXevpWk0XOQ03DNNvzlfMdH31gNmlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ykaaz8EvwLRjauOJ+9BWqbCFqAkEq/lowFZEgJ8fdld3+mMuGiXUq6vbHShELnjyt
	 FUvY1RZhb/t4w8oi2rgaUXBitPJruildi5uyHmGDuZ+FKy9GYU3AJVPxU1MXVTKNgy
	 UZWBVfUGiBHTqUtwhc+gYm9QyMpfvBjAWhPw51QM2QXySvKkKDqqCBoFxjA60ud7bj
	 7PUSLMOgUpzwSQPI+jVfDh5ypOjp0d2bVs0wiOTf05UpN3t4Z2ORbhxXxKLtA/PmYE
	 uDi+kRyRhU9+oAKSLxcnvDbfRFWc8fNMMGfWJC/fH5sUk9oDqDGZdZLYi0sNNNHXX5
	 QlX1ysmilFdKQ==
Date: Thu, 13 Mar 2025 16:28:39 +0100
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
Message-ID: <Z9L5p6hTp6MATJ80@ryzen>
References: <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen>
 <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
 <Z88rtGH39C-S8phk@ryzen>
 <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
 <Z9BFSM059Wj2cYX5@ryzen>
 <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com>
 <Z9LUH2IkwoMElSDg@ryzen>
 <d5470665-4fee-432a-9cb7-fff9813b3e97@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5470665-4fee-432a-9cb7-fff9813b3e97@redhat.com>

Hello Hans,

On Thu, Mar 13, 2025 at 04:13:24PM +0100, Hans de Goede wrote:
> > 
> > Considering that DIPM seems to work fine on the Maxtor drive, I guess your
> > initial suggestion of a Samsung only quirk which only disables LPM on ATI
> > is the best way?
> 
> I have no objections against going that route, except that I guess this
> should then be something like ATA_QUIRK_NO_DIPM_ON_ATI to not loose the
> other LPM modes / savings? AFAIK/IIRC there still is quite some powersaving
> to be had without DIPM.

I was thinking like your original suggestion, i.e. setting:
ATA_QUIRK_NO_LPM_ON_ATI

for all the Samsung devices that currently have:
ATA_QUIRK_NO_NCQ_ON_ATI

Considering that this Samsung device only supports DIPM
(and not HIPM), I'm guessing the same is true for the other
Samsung devices as well.

So we might as well just do:
ATA_QUIRK_NO_LPM_ON_ATI

to disable both HIPM and DIPM
(since only DIPM would have been enabled without this quirk anyway).


> Yes the most severe problems do seem to come from that specific mix,
> although the long list of other ATI controller quirks also shows those
> controllers are somewhat finicky.

Definitely!


Kind regards,
Niklas

