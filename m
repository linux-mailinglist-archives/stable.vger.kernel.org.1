Return-Path: <stable+bounces-124773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6434DA66F5C
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 10:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DB219A2C4F
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 09:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF686205AD5;
	Tue, 18 Mar 2025 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRujVJOy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A61F873D;
	Tue, 18 Mar 2025 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289039; cv=none; b=RI5Rr39wdm3I41IfIaPViaE0aJ326J/QAIjkwZ2T88p9saMuLMfsDkaKFiqt4uoQjSHVd/wwLmmTQC3TsRan+JIYyAYP0brJS+mqiytqdFMJvUNHdI0/oFqaBUTQKQanSNYsAiaassdoQAWNnVc51tcC0qkIXjsK4t9bRxczwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289039; c=relaxed/simple;
	bh=x2Oo1KpRFIngVaUsqEsq3GfsO/Lt5V1TiLtFXCIoJv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS6JR/xGJeaUXoyhqlgC42TiVyuI4tXUQk8NG6xi8H/oaM8nppYV9jNSUAO3kpYGhpd3B5ubAdD4TojupnnJdloA5c0An7JxFhXTVDX3a97855J8cINy+z87nVXFzIrcASnHhVig8eOc5j37GxrlcqBn2FUIe7YyyL8WNJjtK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRujVJOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C0EC4CEDD;
	Tue, 18 Mar 2025 09:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742289038;
	bh=x2Oo1KpRFIngVaUsqEsq3GfsO/Lt5V1TiLtFXCIoJv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bRujVJOystzhTifwpMiIEc1h8J46X2M+K2NYXSq4iTppqb0CMHyaAD4FMhMTJsqkA
	 XYvCBk+cFp23oxGtQ1okNKa4QPV09VXmS32TckNjwvJ+X3kIdiroeoaIr03Q7C89S4
	 +gRwpsuG6AynGK2R4D9fyuvhdImk8g3lyjiIefAJXXp2U49lBO53OSE46zF09TIjRS
	 7NdoMVZH+6aESaWKGEqEdg8RIPpQBkeB7UQBeHyP6VS3g0VHPhLWNaN+QRNXwO3HvL
	 9SXIxKerb5TE4vb+uzbAPNmwowZg1ouyk+TTB8fwe8DDTJ3pNTVQfFbriHyFJZZkUn
	 tRMWH6HFcTChw==
Date: Tue, 18 Mar 2025 10:10:33 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Eric <eric.4.debian@grabatoulnz.fr>
Cc: Hans de Goede <hdegoede@redhat.com>,
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
Message-ID: <Z9k4ic4nSkbUMAPA@ryzen>
References: <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
 <Z9BFSM059Wj2cYX5@ryzen>
 <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com>
 <Z9LUH2IkwoMElSDg@ryzen>
 <d5470665-4fee-432a-9cb7-fff9813b3e97@redhat.com>
 <Z9L5p6hTp6MATJ80@ryzen>
 <6d125c69-35b2-45b5-9790-33f3ea06f171@redhat.com>
 <Z9hXRYQw1-fX0_PY@ryzen>
 <06f76ca1-1a07-4df5-ba50-e36046f58d88@grabatoulnz.fr>
 <5fe0557a-b9ec-4600-a10f-20c494aa2339@grabatoulnz.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fe0557a-b9ec-4600-a10f-20c494aa2339@grabatoulnz.fr>

Hello Eric,

On Tue, Mar 18, 2025 at 01:04:48AM +0100, Eric wrote:
> Hi Niklas, hi Hans,
> 
> Le 17/03/2025 à 20:15, Eric a écrit :
> > Hi Niklas,
> > 
> > Le 17/03/2025 à 18:09, Niklas Cassel a écrit :
> > > 
> > > I sent a patch that implements your original suggestion here:
> > > https://lore.kernel.org/linux-ide/20250317170348.1748671-2-cassel@kernel.org/
> > > 
> > > 
> > > I forgot to add your Suggested-by tag.
> > > If the patch solves Eric's problem, I could add the tag when applying.
> > I'll report back when the kernel with your proposed patch is built and
> > tested on my system.
> 
> The test is a success as far as I am concerned. With this new patch, DIPM is
> disabled on the Samsung SSD, but not the Maxtor disk on the same controller
> :
> 
> 
> (trixieUSB)eric@gwaihir:~$ sudo hdparm -I
> /dev/disk/by-id/ata-Samsung_SSD_870_QVO_2TB_S5RPNF0T419459E | grep
> "interface power management"
>             Device-initiated interface power management
> (trixieUSB)eric@gwaihir:~$ sudo hdparm -I
> /dev/disk/by-id/ata-MAXTOR_STM3250310AS_6RY2WB82 | grep "interface power
> management"
>        *    Device-initiated interface power management
> 
> 
> and the SSD is successfully detected at reboot by both the UEFI and the
> linux kernel.

Thank you for all your perseverance!

Hopefully, your efforts will make sure that others with ATI AHCI do not
encounter the same issue that you faced.


Kind regards,
Niklas

