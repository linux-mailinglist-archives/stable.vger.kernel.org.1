Return-Path: <stable+bounces-120036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0304A4B7E6
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 07:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2C63AE830
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 06:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9CF1E521F;
	Mon,  3 Mar 2025 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGaCYVb9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF941156237;
	Mon,  3 Mar 2025 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740983146; cv=none; b=SLiIvptqHSm3hXoYV50rZzpWKtRRwVDFhlG2bfS2nZ2UvdwijRhJeqaThKO8npcmPQHt6MK0hzjc/HOdHGFdPAGzYYvuB6rAogGLkxov8sgG9AgSVLyc+mR6JTteJX1+W7ng/Wee8dtbM9Q6og7t2JTfBz4XkA2eDlngJzziCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740983146; c=relaxed/simple;
	bh=HMeE8a/cFpKumunodQGwNDLfpxZBYTWa5hdf+CBH/Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8+MkYL2rnL0x07LrzY38zWz55O/HhNtETTIfkFyHstsU0a+EUG80w/LoneIHsupwa5w1lCjaDTBQXldUzKBrBaFfyRyyzvBWCFrNlfzKLOxTwswHKTYiWSaG74Twz76xBwWy815dxMF8P/90511t/PvmHimhxzjFv+OrAfXlPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGaCYVb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EA7C4CED6;
	Mon,  3 Mar 2025 06:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740983146;
	bh=HMeE8a/cFpKumunodQGwNDLfpxZBYTWa5hdf+CBH/Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGaCYVb9L+CPSLTB4qoOwxd1LUahB9PwctBQpNpdZrYdindae/YenfwrnfDrvp44D
	 iQ2AcKMtUiBGFtExwop7ksjpBriBpMBqkTko2Cdt5oZOqOoJgYMzKfoeoJ+jdRhCaH
	 A5MF2u5Kep738Pm4bXtazbm2zB6B0XsFDG9v+OUPklHdD5cvjtNLJb0lbKB34NxDkd
	 pd/aqxVRD+aZVWdYUycqCOcnyxT+t7/FtgXRbF7pDdY0Lbb++ijVyOchQAnGPb3Xzc
	 KJPs82efUZWgc82+GiJd63TEvPFCFRN1IGPMR8kMIWLMyXCm6foxQAgsVfZmfzqND7
	 VBz/g7DswMDYw==
Date: Mon, 3 Mar 2025 07:25:40 +0100
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
Message-ID: <Z8VLZERz0FpvpchM@x1-carbon>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan>
 <Z8SyVnXZ4IPZtgGN@ryzen>
 <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>

On Sun, Mar 02, 2025 at 09:32:07PM +0100, Eric wrote:
> Hi Niklas,
> 
> Le 02/03/2025 à 20:32, Niklas Cassel a écrit :
> > On Sun, Mar 02, 2025 at 05:03:48PM +0100, Salvatore Bonaccorso wrote:
> > > Hi Mario et al,
> > > 
> > > Eric Degenetais reported in Debian (cf. https://bugs.debian.org/1091696) for
> > > his report, that after 7627a0edef54 ("ata: ahci: Drop low power policy  board
> > > type") rebooting the system fails (but system boots fine if cold booted).
> > > 
> > > 
> For what it's worth, before getting these replies I tested the
> ahci.mobile_lpm_policy=1 kernel parameter, which did work around the
> problem.

I'm glad that you have a workaround to make your system usable.


> > 
> > Eric is using the latest SSD fimware version. So from other peoples reports,
> > I would expect things to work for him as well.
> > 
> > However, no one has reported that their UEFI does not detect their SSD.
> > This seems to be either SSD firmware bug or UEFI bug.
> > 
> > I would expect your UEFI to send a COMRESET even during a reboot, and a
> > according to AHCI spec a COMRESET shall take the decide out of sleep states.
> > 
> > Considering that no one else seems to have any problem when using the latest
> > firmware version for this SSD, this seems to be a problem specific to Eric.
> > So... UEFI bug?
> > 
> > Have you tried updating your BIOS?
> 
> I had not tried to update my bios (bit shy on this due to a problem long ago
> with a power failure during bios update which left me with an unbootable
> machine).
> 
> However, as far as I see, there is no newer version of it.

Ok.

So far, this just sounds like a bug where UEFI cannot detect your SSD.
UEFI problems should be reported to your BIOS vendor.

It would be interesting to see if _Linux_ can detect your SSD, after a
reboot, without UEFI involvement.

If you kexec into the same kernel as you are currently running:
https://manpages.debian.org/testing/kexec-tools/kexec.8.en.html

Do you see your SSD in the kexec'd kernel?


Kind regards,
Niklas

