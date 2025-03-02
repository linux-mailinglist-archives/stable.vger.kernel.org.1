Return-Path: <stable+bounces-120025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B33AAA4B462
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 20:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82577A6F21
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 19:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B441EBA07;
	Sun,  2 Mar 2025 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="rf6c+1nl"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E62B3597E;
	Sun,  2 Mar 2025 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740943741; cv=none; b=Qnc4YfrrvMRZyrDMB6YqK1uRGpUKqlPOf/AfBq9SoGrbG2YO8Q8ekDyl7KGx70UQmj2a52YpzSYkYDJ5aT9/vrx6boSIlRxe6wcJRmGZoCegcr4wtNnlqZEgy2Z59wRbOj26CuTXhfZ0SpTkWVqoqxBDpepG6NzyGwT0LFgbxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740943741; c=relaxed/simple;
	bh=o79N5Awt3V5gZlY4O7Vz3tTzMEESQb1ok1NmG4v1UVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgrKTnB3nuUrjOxuS+UuOAGg6AI7FActknZBiz4vaTPndGFtFerJOy2cV7pyFz+kx4AXo5e+2HCB55Oy01pTMPHIPbOF4tS4SInimA2QoaSOuf9EkNQxb6G04r9ZKR9NdNYN/Ch6GGXqW/gLifnksDJaZyBriC3lYQ+ZaTRkxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=rf6c+1nl; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=a8hjUpRMJeEgoLFm8QSk6Wp5JPgQATrXtWJpep9pL9M=; b=rf6c+1nlfIOO9K0d0NOWtS1iPY
	ZEP5/+997LwwZghgT6DniDikjGrqQ7DBoTLxkT0GEDc4EuFgvnM58K2/rqMHqYiKnR0ydJKWBniIZ
	3JR7gOkjcms97lE7bGvvB3zXj/AhY0XRfSiUCxhQjJBCXySLpLKyE0lh6VqSZ3yUlgPmhp+/WZ8ip
	gZVkgLRmOgS2dG5IqyMK/Fwp89u3P9C5+JQ0cBAJf88Dza+ncq0sbJbvrmixw8ZH49i/zsTlDoGsw
	UBO9D54AhCGg/EctSfd1fwfilA1Ar/gizbme1HKSIn+1tqOIlbmspqcsJUdAvmRS0wTJjQS1yszm0
	1nWtDthQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1toozM-002ULU-Pt; Sun, 02 Mar 2025 19:28:37 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 9C711BE2DE0; Sun, 02 Mar 2025 20:28:35 +0100 (CET)
Date: Sun, 2 Mar 2025 20:28:35 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Eric Degenetais <eric.4.debian@grabatoulnz.fr>,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, linux-ide@vger.kernel.org,
	Daniel Baumann <daniel@debian.org>
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
Message-ID: <Z8SxY0Lb7o3iAtDN@eldamar.lan>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8SBZMBjvVXA7OAK@eldamar.lan>
X-Debian-User: carnil

On Sun, Mar 02, 2025 at 05:03:48PM +0100, Salvatore Bonaccorso wrote:
> Hi Mario et al,
> 
> Eric Degenetais reported in Debian (cf. https://bugs.debian.org/1091696) for
> his report, that after 7627a0edef54 ("ata: ahci: Drop low power policy  board
> type") rebooting the system fails (but system boots fine if cold booted).
> 
> His report mentions that the SSD is not seen on warm reboots anymore.
> 
> Does this ring some bell which might be caused by the above bisected[1] commit?
> 
> #regzbot introduced: 7627a0edef54
> #regzbot link: https://bugs.debian.org/1091696
> 
> What information to you could be helpful to identify the problem?

Additional information from the reporter: The SSD is:

$ sudo smartctl -i /dev/disk/by-id/ata-Samsung_SSD_870_QVO_2TB_S5RPNF0T419459E
smartctl 7.4 2023-08-01 r5530 [x86_64-linux-6.12.12-amd64] (local build)
Copyright (C) 2002-23, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Family:     Samsung based SSDs
Device Model:     Samsung SSD 870 QVO 2TB
Serial Number:    S5RPNF0T419459E
LU WWN Device Id: 5 002538 f4243493c
Firmware Version: SVQ02B6Q
User Capacity:    2 000 398 934 016 bytes [2,00 TB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    Solid State Device
Form Factor:      2.5 inches
TRIM Command:     Available, deterministic, zeroed
Device is:        In smartctl database 7.3/5528
ATA Version is:   ACS-4 T13/BSR INCITS 529 revision 5
SATA Version is:  SATA 3.3, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun Mar  2 18:46:44 2025 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

So this might be the same issue aimed to be addressed by cc77e2ce187d
("ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO
drives"), but which got reverted with a2f925a2f622 ("Revert "ata:
libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives"") as
it introduces other problems.

So I'm adding as well Daniel Baumann into the loop as this seems
related.

FTR, thanks Christian Heusel for the other comments an input!

Regards,
Salvatore

