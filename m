Return-Path: <stable+bounces-122879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3D6A5A1C5
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC1A3AEC01
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FA6233721;
	Mon, 10 Mar 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifDr2I4L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A1222576A;
	Mon, 10 Mar 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630394; cv=none; b=qwX51isLo+EDi0cdAw5OYr3jQcs0FIrR1uf1Oa2ciDWPOnBrLj8kjSnbJf96ewJ4Pq94H/K1Le1nyY7dkRBkMzBU8oRwZTsJIxKl+r5gx7agCr50nqidkD1J/N8Z4apo/SO1iFkzO1oMYrF3hrtUEtUpOmngqtx6Z/U+WLQ3l+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630394; c=relaxed/simple;
	bh=1lvYD4dJwhu3up1yUrM2XpUAp0MTVEkduNtJ4hcy4rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvoHrdd5YjFWm+XWDSKySrzmoCYwzmAIMXufp1rqrwqQvoRB07aOkkqrzJprTkuFhtyRX9I9xPIus4J8hIGXI+mtqkel2qwdnig7VdJ+GikN5ytNyDbv8nKfe21JjtKlQkRPcV4opN5LK0p7uuNpS7/FgnARi7uh2Bb49odB0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifDr2I4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3DCC4CEE5;
	Mon, 10 Mar 2025 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741630393;
	bh=1lvYD4dJwhu3up1yUrM2XpUAp0MTVEkduNtJ4hcy4rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifDr2I4LfGxd+q+0U+d/hAPdjxlxpILdlbBItf62WGSrsvHDbxKnOVO3ojHLubc4Y
	 WFXmp/Abok5F82GJtyRS6+js8q9F8Y1IhmtYiOWbmgKH44gaBvf/0Sja6H62+Q3uVq
	 H2OhDYDO9UxXQVFBT12b61lc9CaihqMp67iXG5bH2N12XX1l564msuBqLb5UVuFKUI
	 chyKxzOnwV9shTj0g9QoVKKcHHxGp56n404JtcRIW6fgS9egd33yE/tbt0xS1Ed36G
	 XRWUVt4z1XoGBiK2Ncjs41b1K6cKBc5WnEn/iyH3KASj48Z1MX+xaa0bUO8ck/9v/l
	 ybVGAzQP44hPg==
Date: Mon, 10 Mar 2025 19:13:08 +0100
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
Message-ID: <Z88rtGH39C-S8phk@ryzen>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan>
 <Z8SyVnXZ4IPZtgGN@ryzen>
 <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
 <Z8VLZERz0FpvpchM@x1-carbon>
 <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen>
 <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen>
 <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>

Hello Hans,

On Mon, Mar 10, 2025 at 10:34:13AM +0100, Hans de Goede wrote:
> 
> I think that the port-mask register is only read-only from an OS pov,
> the BIOS/UEFI/firmware can likely set it to e.g. exclude ports which are
> not enabled on the motherboard (e.g. an M2 slot which can do both pci-e + 
> ata and is used in pci-e mode, so the sata port on that slot should be
> ignored).
> 
> What we seem to be hitting here is a bug where the UEFI can not detect
> the SATA SSD after reboot if it ALPM was used by the OS before reboot and
> the UEFI's SATA driver responds to the not detecting by clearing the bit
> in the port-mask register.
> 
> The UEFI not detecting the disk after reboot when ALPM was in use also
> matches with not being able to boot from the disk after reboot.

If we look at dmesg:
ahci 0000:00:11.0: AHCI vers 0001.0200, 32 command slots, 6 Gbps, SATA mode
ahci 0000:00:11.0: 3/3 ports implemented (port mask 0x38)
ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 

We can see that the controller supports slumber, partial,
and aggressive link power management ("pm").


A COMRESET is supposed to take the device out of partial or slumber.

Now, we do not know if the BIOS code sends a COMRESET, but it definitely
should.

Anyway, it is stated in AHCI 1.3.1 "10.1 Software Initialization of HBA",

"To aid system software during runtime, the BIOS shall ensure that the
following registers are initialized to values that are reflective of the
capabilities supported by the platform."

"-PI (ports implemented)"


> 
> I think what would be worth a try would be to disable ALPM on reboot
> from a driver shutdown hook. IIRC the ALPM level can be changed at runtime
> from a sysfs file, so we should be able to do the same at shutdown ?
> 
> Its been a while since I last touched the AHCI code, so I hope someone else
> can write a proof of concept patch with the shutdown handler disabling ALPM
> on reboot ?

I mean, that would be a quirk, and if such a quirk is created, it should
only be applied for buggy BIOS versions.

(Since BIOS is supposed to initialize the PI register properly.)

If
ahci.mobile_lpm_policy=1
or
ahci.mobile_lpm_policy=2
works around your buggy BIOS, then I suggest you keep that
until your BIOS vendor manages to release a new BIOS version.


Kind regards,
Niklas

