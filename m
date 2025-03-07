Return-Path: <stable+bounces-121358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE24A56463
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 10:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AE016F797
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40B920C473;
	Fri,  7 Mar 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SamWFfD6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762DE1E1DEE;
	Fri,  7 Mar 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341213; cv=none; b=lIqIDHIshaV3vDg23krDyzuple2K7YRSIHzRLY6LWq0LuC1PSmyFt53GQSEa/WLG+6fsm+NBIAwsEfWywI16QUagtDp8Ofq70tJ/19bTvbo+qNKjFWJb3kwyVCFVpEMgIt4aff3/nJt5I2is8iM65yK5AfNUl/SkfwPaj6eoLMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341213; c=relaxed/simple;
	bh=R7va4ZOYcRU/Jgig4WSUdBULAgDeoE6ZzyA21S1NKac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnDolZk6LfBqbg7pOjgITSnqKAkQb3Z+wqMHWSQJ1LUDeYuzSbbwE0TKUEQPrKbX7oB/rz9tnNXVsoHvDPQgtPRxcrrxYNOkjqfVXA4/Oxd7iReXJnlZVUKOitZGfdXEpc1zUJP1AdFWT21L1Q7IJ5V87+f4sHkO8MWztlhu56M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SamWFfD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1F1C4CED1;
	Fri,  7 Mar 2025 09:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741341212;
	bh=R7va4ZOYcRU/Jgig4WSUdBULAgDeoE6ZzyA21S1NKac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SamWFfD6ZSeTD2JrNTRYVn/oCXt8vIvryW6ivWniA+DzkcQN5gj46XEa+n/O4Hy5f
	 7La3Jt6JQ+8FJqW5KOL52hS8lgykILsnt0kqNRhdQW8+tGutD5rvoOUiW9WS57D/9+
	 zS/pZ7UrqOtct6/dLaw0MbAEQqdZkGppupBezyILafPR8Vj5F0C/ruWgctbCxZ6sPs
	 mpFQASiyWjUQxQ5KW1pLkzTd8jLBwUwrqzY9lyQewxp/+cvu0Kqf9gurAwdgTfYr4g
	 aAl23fczurFkIvxpIIiNzXgclra7Il5nZTrePWixdi2enMnvE9CXQwgm0zCtzmszxO
	 f5rxyl/YnGHiQ==
Date: Fri, 7 Mar 2025 10:53:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Eric <eric.4.debian@grabatoulnz.fr>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
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
Message-ID: <Z8rCF39n5GjTwfjP@ryzen>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan>
 <Z8SyVnXZ4IPZtgGN@ryzen>
 <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
 <Z8VLZERz0FpvpchM@x1-carbon>
 <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen>
 <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>

Hello Eric,

On Thu, Mar 06, 2025 at 01:27:17PM +0100, Eric wrote:
> 
> I installed the same system on a USB stick, on which I also installed grub,
> so that the reboot is made independent of weather the UEFI sees the SSD disk
> or not. I'll attach dmesg extracts (grep on ata or ahci) to this mail.

Exellent idea!


> 
> One is the dmesg after coldbooting from the USB stick, the other is
> rebooting on the USB stick. First of all, the visible result : the SSD is
> not detected by linux at reboot (but is when coldbooting).
> 
> Here is what changes :
> 
> eric@gwaihir:~$ diff
> /media/eric/trixieUSB/home/eric/dmesg-ahci-ata-coldboot.untimed.txt
> /media/eric/trixieUSB/home/eric/dmesg-ahci-ata-reboot.untimed.txt
> 
> 4c4
> <  ahci 0000:00:11.0: 4/4 ports implemented (port mask 0x3c)
> ---
> >  ahci 0000:00:11.0: 3/3 ports implemented (port mask 0x38)
> 14c14
> <  ata3: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b200 irq 19
> lpm-pol 3
> ---
> >  ata3: DUMMY
> 27,28d26
> <  ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> <  ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> 29a28
> >  ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> 31,34d29
> <  ata3.00: Model 'Samsung SSD 870 QVO 2TB', rev 'SVQ02B6Q', applying
> quirks: noncqtrim zeroaftertrim noncqonati
> <  ata3.00: supports DRM functions and may not be fully accessible
> <  ata3.00: ATA-11: Samsung SSD 870 QVO 2TB, SVQ02B6Q, max UDMA/133
> <  ata3.00: 3907029168 sectors, multi 1: LBA48 NCQ (not used)
> 37a33
> >  ata5.00: configured for UDMA/100
> 40d35
> <  ata5.00: configured for UDMA/100
> 43,46d37
> <  ata3.00: Features: Trust Dev-Sleep
> <  ata3.00: supports DRM functions and may not be fully accessible
> <  ata3.00: configured for UDMA/133
> <  scsi 2:0:0:0: Direct-Access     ATA      Samsung SSD 870 2B6Q PQ: 0 ANSI:
> 5
> 50,51d40
> <  ata3.00: Enabling discard_zeroes_data
> <  ata3.00: Enabling discard_zeroes_data
> 
> I hope this is useful for diagnosing the problem.

It is indeed!

Wow.

The problem does not appear to be with the SSD firmware.

The problem appears to be that your AHCI controller reports different
values in the PI (Ports Implemented) register.

This is supposed to be a read-only register :)

At cold boot the print is:
4/4 ports implemented (port mask 0x3c)
meaning ports 1,2 are not implemented (DUMMY ports).

At reboot the print is:
3/3 ports implemented (port mask 0x38)
meaning ports 1,2,3 are not implemented (DUMMY ports).

So, the problem is that your AHCI controller appears to report different
values in the PI register.

Most likely, if the AHCI controller reported the same register values the
second boot, libata would be able to scan and detect the drive correctly.

What AHCI controller is this?

$ sudo lspci -nns 0000:00:11.0


Which kernel version are you using?

Please test with v6.14-rc5 as there was a bug in v6.14-rc4 where
mask_port_map would get incorrecly set. (Although, this bug should only
affect device tree based platforms. Most often when using UEFI, you do
not use device tree.)


I do see that your AHCI controller is < AHCI 1.3, so we do take this path:
https://github.com/torvalds/linux/blob/v6.14-rc5/drivers/ata/libahci.c#L571-L578

Could you please provide a full dmesg?


Also, it would be helpful if you could print every time we read/write the
PI register. (Don't ask me why libata writes a read-only register...
we were not always the maintainers for this driver...)


diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index e7ace4b10f15..dd837834245b 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -533,6 +533,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 
 	/* Override the HBA ports mapping if the platform needs it */
 	port_map = readl(mmio + HOST_PORTS_IMPL);
+	dev_err(dev, "%s:%d PI: read: %#lx\n", __func__, __LINE__, port_map);
 	if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {
 		dev_info(dev, "forcing port_map 0x%lx -> 0x%x\n",
 			port_map, hpriv->saved_port_map);
@@ -629,6 +630,7 @@ static void ahci_restore_initial_config(struct ata_host *host)
 	if (hpriv->saved_cap2)
 		writel(hpriv->saved_cap2, mmio + HOST_CAP2);
 	writel(hpriv->saved_port_map, mmio + HOST_PORTS_IMPL);
+	dev_err(host->dev, "%s:%d PI: wrote: %#x\n", __func__, __LINE__, hpriv->saved_port_map);
 	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
 
 	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {




Kind regards,
Niklas

