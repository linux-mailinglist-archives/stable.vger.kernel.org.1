Return-Path: <stable+bounces-123223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4583AA5C396
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A35A177874
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5943825C710;
	Tue, 11 Mar 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG0oXFG6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07348254B0D;
	Tue, 11 Mar 2025 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702479; cv=none; b=FPhDz7LLThh+dyZpjjHqhew7NyJLdFIbIG6RFQckwktyqysW2VuNtYFuGZiMa6Fy7aw1XuTxT+XbGEMMLMlFh58G+Jqiq9qwHc655WvkjY91NnWFoiotnsbcbXniBkbMHtlPlLLKB1Gu1mlKSwvDjijTvP30TM1cPvD6VTrq8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702479; c=relaxed/simple;
	bh=yeuRqhNPxhQWRMw+OTMnVBLhf+GKJ3O5IeEzkxZ0+Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m74fw51nMBjkQP0BQWFzzIZe+wd+U7wCrsr3qKka9F8/C0N8EeG3JalcI9IxYjVeszqY92lAvy9LLNIO5sLVAcrYTcTu4tQv5svJ6ZQzmcFGL29bnKsSAis6gov8jmQoqw7GVeufKK2OvH7V/Oro2Z8ncjO6ijAJ5UgD4TYuN3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG0oXFG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C50BC4CEE9;
	Tue, 11 Mar 2025 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741702478;
	bh=yeuRqhNPxhQWRMw+OTMnVBLhf+GKJ3O5IeEzkxZ0+Xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hG0oXFG6SC8sDIeE5/XxN1PPtT4J5WkqDYCfDK2Fxpycjk3PWYAn6NOXRQrl0qz+E
	 UgYNxORvvwIhTnNyrBAo3uvi6V//t5SILKN6JvE4mwH/0/KdpvsGRu+g60DRIqrq8X
	 mJTnJAMsDmgr49FDdgiYiHBmtNp7YPR8dJUU2VW6TggIRk8OA3HPawnqZMEtHTvN49
	 5ueTMQEt4Dxn+5kVp5mlvGhGvSASFvrDzpjdVsGwEneAQnOT0kiHBJbn8wwAQ85JsK
	 gzuyHrc4R9Th4qG2eOEvdnnD+cLhWLJ12l7Sd2fAeNADMII4X6hCWqe+/E6o7KMESz
	 d7yqvzyNNSP3w==
Date: Tue, 11 Mar 2025 15:14:32 +0100
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
Message-ID: <Z9BFSM059Wj2cYX5@ryzen>
References: <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
 <Z8VLZERz0FpvpchM@x1-carbon>
 <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen>
 <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen>
 <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
 <Z88rtGH39C-S8phk@ryzen>
 <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>

Hello Hans, Eric,

On Mon, Mar 10, 2025 at 09:12:13PM +0100, Hans de Goede wrote:
> 
> I agree with you that this is a BIOS bug of the motherboard in question
> and/or a bad interaction between the ATI SATA controller and Samsung SSD
> 870* models. Note that given the age of the motherboard there are likely
> not going to be any BIOS updates fixing this though.

Looking at the number of quirks for some of the ATI SB7x0/SB8x0/SB9x0 SATA
controllers, they really look like something special (not in a good way):
https://github.com/torvalds/linux/blob/v6.14-rc6/drivers/ata/ahci.c#L236-L244

-Ignore SError internal
-No MSI
-Max 255 sectors
-Broken 64-bit DMA
-Retry SRST (software reset)

And that is even without the weird "disable NCQ but only for Samsung SSD
8xx drives" quirk when using these ATI controllers.


What does bother me is that we don't know if it is this specific mobo/BIOS:
     Manufacturer: ASUSTeK COMPUTER INC.
     Product Name: M5A99X EVO R2.0
     Version: Rev 1.xx

     M5A99X EVO R2.0 BIOS 2501
     Version 2501
     3.06 MB
     2014/05/14


that should have a NOLPM quirk, like we do for specific BIOSes:
https://github.com/torvalds/linux/blob/v6.14-rc6/drivers/ata/ahci.c#L1402-L1439

Or if it this ATI SATA controller that is always broken when it comes
to LPM, regardless of the drive, or if it is only Samsung drives.

Considering the dmesg comparing cold boot, the Maxtor drive and the
ASUS ATAPI device seems to be recognized correctly.

Eric, could you please run:
$ sudo hdparm -I /dev/sdX | grep "interface power management"

on both your Samsung and Maxtor drive?
(A star to the left of feature means that the feature is enabled)



One guess... perhaps it could be Device Initiated PM that is broken with
these controllers? (Even though the controller does claim to support it.)

Eric, could you please try this patch:

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f813dbdc2346..ca690fde8842 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -244,7 +244,7 @@ static const struct ata_port_info ahci_port_info[] = {
 	},
 	[board_ahci_sb700] = {	/* for SB700 and SB800 */
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
-		.flags		= AHCI_FLAG_COMMON,
+		.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_pmp_retry_srst_ops,



Normally, I do think that we need more reports, to see if it is just
this specific BIOS, or all the ATI SB7x0/SB8x0/SB9x0 SATA controllers
that are broken...

...but, considering how many quirks these ATI controllers have already...

...and the fact that the one (Dieter) who reported that his Samsung SSD 870
QVO could enter deeper sleep states just fine was running an Intel AHCI
controller (with the same FW version as Eric), I would be open to a patch
that sets ATA_FLAG_NO_LPM for all these ATI controllers.

Or a ATA_QUIRK_NO_LPM_ON_ATI, like you suggested, if we are certain that it
is only Samsung drives that don't work with these ATI SATA controllers.


Kind regards,
Niklas

