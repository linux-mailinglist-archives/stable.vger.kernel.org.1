Return-Path: <stable+bounces-121211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EDAA5481E
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BD03ACEA3
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7762045AE;
	Thu,  6 Mar 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlJoE2+P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485ED53BE;
	Thu,  6 Mar 2025 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257645; cv=none; b=WjNIHxE2kY7M4OBxu9snplglszX/X4oQmz0pMLwLtXNgLIY+yrJ892//L7Mj4Fda2f0QUcEwgBR2x8D2vbckYTmgy0zaf1UP7fecn2menyEznYN7wH4Rr6GiGcmFan9c+q6f7YoBP3RmDBcUfzNcekXfSvEKYFbffiU/fCcRVUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257645; c=relaxed/simple;
	bh=raiGJehND5MNSQQhYP8JH4JYdYV2FUWjoSgtnGSLGgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFLjKxuioZCjGG07XvAPzGjKdPhbzvfd9EshlmP8boFEvp0FnaBeuZLeEvTQJ1/5rBtjgvaFJl5RC5wsspKtxoCdMYeoz8KBzEAfBLZjqNKoqrRyb7myHEEV8wZsQ0/lNdtNsjwsCenklNVzYdjKv34aEusgwVbznmM3Deee8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlJoE2+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A38C4CEE0;
	Thu,  6 Mar 2025 10:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741257642;
	bh=raiGJehND5MNSQQhYP8JH4JYdYV2FUWjoSgtnGSLGgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlJoE2+Pjgx67a89e+DGbvxeZLlqxMm2uiBSRVhdwKGORS9ZpIkZlqF2moIswqTla
	 o4oMAvS7x85FdWBcDb5BGAaTgIHflzR2LrN7jMP+k42iiROjdGhl1QrRLson5AmVr1
	 tlqHB+k8iVLSx9DMWI7XrO5uNtfs2bKiBGwWiPuBISjIBJV5GGHxIflsz3ihWTbuhA
	 h8K1pU5+Xf+Fi1s4o8ZvHwzN6ViyNeIRDeI3dPdfqtPtFMsiuB5RO4JbqJarxafyK6
	 7K1jaCMJhyrVLbSYKt2UECj6lKzAyeCawhSFDQ//VDqiCGmcZmjK30t7ECp1uJUD5k
	 wavbT8izcTBmg==
Date: Thu, 6 Mar 2025 11:40:37 +0100
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
Message-ID: <Z8l7paeRL9szo0C0@ryzen>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan>
 <Z8SyVnXZ4IPZtgGN@ryzen>
 <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
 <Z8VLZERz0FpvpchM@x1-carbon>
 <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8l61Kxss0bdvAQt@ryzen>

On Thu, Mar 06, 2025 at 11:37:08AM +0100, Niklas Cassel wrote:
> On Mon, Mar 03, 2025 at 03:58:30PM +0100, Eric wrote:
> > Hi Niklas
> > 
> > Le 03/03/2025 à 07:25, Niklas Cassel a écrit :
> > > So far, this just sounds like a bug where UEFI cannot detect your SSD.
> > Bit it is detected during cold boot, though.
> > > UEFI problems should be reported to your BIOS vendor.
> > I'll try to see what can be done, however I am not sure how responsive they
> > will be for this board...
> > > 
> > > It would be interesting to see if _Linux_ can detect your SSD, after a
> > > reboot, without UEFI involvement.
> > > 
> > > If you kexec into the same kernel as you are currently running:
> > > https://manpages.debian.org/testing/kexec-tools/kexec.8.en.html
> > > 
> > > Do you see your SSD in the kexec'd kernel?
> > 
> > Sorry, I've tried that using several methods (systemctl kexec / kexec --load
> > + kexec -e / kexec --load + shutdown --reboot now) and it failed each time.
> > I *don't* think it is related to this bug, however, because each time the
> > process got stuck just after displaying "kexec_core: Starting new kernel".
> 
> I just tired (as root):
> # kexec -l /boot/vmlinuz-6.13.5-200.fc41.x86_64 --initrd=/boot/initramfs-6.13.5-200.fc41.x86_64.img --reuse-cmd
> # kexec -e
> 
> and FWIW, kexec worked fine.
> 
> Did you specify an initrd ? did you specify --reuse-cmd ?

Sorry, typo:

s/--reuse-cmd/--reuse-cmdline/


Kind regards,
Niklas

