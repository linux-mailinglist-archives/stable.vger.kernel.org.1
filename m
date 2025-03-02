Return-Path: <stable+bounces-120026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E136A4B465
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 20:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2510516A4B9
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 19:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EB21EB1B9;
	Sun,  2 Mar 2025 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDy8TDLt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DFF14900B;
	Sun,  2 Mar 2025 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740943965; cv=none; b=I+2urcueAGr89ypuUOiNCBDjOWIFeaEdOld2dky9wpPF5LNckEZBSepG+2faM7MEi28K3saRaMxv9W2cp+Y8nplqz2mz/ciDFSmFvvonMZasRSu2qm0bLt4H3uum/9lYNvAAto0PsNGpQq3JSSkAYhtraldU/veHB7vV0JfDy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740943965; c=relaxed/simple;
	bh=QlIv7JyW0eVcenFCtSuwq+4GrTmOSf00iooKtosEn1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+rg4LSWupchjd15xfAISkzl5NimO4BvOWi21WJux1zZZU/I5k/GonscM8D7ygyA4rBjOeUWzq4recZoEj+uW9ih+Un45WsJi6T81cngP7UP0WT+kG2EJo0+gvemCmu2OBnQH1w9oT1ZPQaLNDCUSsf/MsD4nI8ZqIqmCS47cbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDy8TDLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AABC4CED6;
	Sun,  2 Mar 2025 19:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740943963;
	bh=QlIv7JyW0eVcenFCtSuwq+4GrTmOSf00iooKtosEn1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDy8TDLtzjR52hOi6FAoPZV05pCKyVrlc40SA4PkypCGd5Z/QuLnVFVkc6Wcxgc0W
	 qY5aiqd8Uw6IbNw34L8dZfSskaJXJ9miK3L+n/UCi4D6Eb56usbtZZ4frHiAEnvNwG
	 YlwyTDQU9qKaeQR+Eo+ZpWRVwRhH8u7gtpZcYGyHJODED7INnPD5wdpeiuBthqKAUo
	 EwTuWIl2lRLwRLqRgoDTwZOkMFoUtoWBH94yI9B4eUEv5pSPbXc7s/Fx0yEU1DtOM4
	 Y5IyGGalABEulpGrJJOGXnacnY16WqHWco3NG7MEp/Xeb2CJquJvnIeqY2MtfJmPHR
	 53X8dZ1qnlvrQ==
Date: Sun, 2 Mar 2025 20:32:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Christoph Hellwig <hch@infradead.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Eric Degenetais <eric.4.debian@grabatoulnz.fr>,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, linux-ide@vger.kernel.org,
	Dieter Mummenschanz <dmummenschanz@web.de>
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
Message-ID: <Z8SyVnXZ4IPZtgGN@ryzen>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8SBZMBjvVXA7OAK@eldamar.lan>

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

The model and fw version of the SSD.

Anyway, I found it in the bug report:
Device Model:     Samsung SSD 870 QVO 2TB
Firmware Version: SVQ02B6Q

The firmware for this SSD is not great, and has caused us a lot of pain
recently:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata?id=cc77e2ce187d26cc66af3577bf896d7410eb25ab
https://lore.kernel.org/linux-ide/Z7xk1LbiYFAAsb9p@ryzen/T/#m831645f6cf2e6b528a8d531fa9b9f929dbf3d602
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata?id=a2f925a2f62254119cdaa360cfc9c0424bccd531


Basically, older firmware versions for this SSD have broken LPM, but from
user reports, the latest firmware version (which Eric is using) is
apparently working:
https://bugzilla.kernel.org/show_bug.cgi?id=219747
https://lore.kernel.org/stable/93c10d38-718c-459d-84a5-4d87680b4da7@debian.org/


Eric is using the latest SSD fimware version. So from other peoples reports,
I would expect things to work for him as well.

However, no one has reported that their UEFI does not detect their SSD.
This seems to be either SSD firmware bug or UEFI bug.

I would expect your UEFI to send a COMRESET even during a reboot, and a
according to AHCI spec a COMRESET shall take the decide out of sleep states.

Considering that no one else seems to have any problem when using the latest
firmware version for this SSD, this seems to be a problem specific to Eric.
So... UEFI bug?

Have you tried updating your BIOS?


Kind regards,
Niklas

