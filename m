Return-Path: <stable+bounces-121210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A7CA547EF
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E517A3CE3
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52563204F7E;
	Thu,  6 Mar 2025 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD1epc8Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CC1A76BC;
	Thu,  6 Mar 2025 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257434; cv=none; b=MwJP2GIchI86LB5hnLjPPVWb8FsRQPb3+0HJ2EewaceXQ4Gpa58jl1bQMtEi35zTkcvQln6iOpZyrB6xlvjLUgpTlzAJI8+FzHyX54EFC1ZsNL6m07nnUfNkwZo9Ay4C1TrgJChtQrgf8UqHodxp6dJQjVbmJToijkOKgUpcrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257434; c=relaxed/simple;
	bh=IO7c0ocWghm1HF2Y6BtOJGBD54V3rraIIlXJos9nIRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xjdan7UaqOYa3VZY7ABEM2VlWgAA0KIFI2qjLjpPGbDNh82iI6xG08BpLQPrN7vzQDTDC3AS6NjFLxkcC0ufYNPh53gwK5H9R+emi7V0s7LidPvsOQvdzJpQoFlrRWToCcsgbhe5OuCCeBGcTVtirM1TgBzXJ5SqcBJFLT4FSnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD1epc8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99F0C4CEE0;
	Thu,  6 Mar 2025 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741257433;
	bh=IO7c0ocWghm1HF2Y6BtOJGBD54V3rraIIlXJos9nIRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kD1epc8ZVdG4tJyWNHlY0ILFCECnUn/YrBiOFK7OXdUasu/4ggapdRwdrsI5fDlrs
	 kF1Emj8ZmB0Xx0c8s8J8ITH0yzbcpO+Nj7qpEIpkFSvw0pyPYJgqcGb/Rnuh0/L/M6
	 vO2QBR8MXndMNqKDghPh32Zb2Ox6PdR8ozJaTJMXmIVnMwGFZ8Y36K+9xWVQj99YIu
	 eSTPZGPul0RSbBCf9UMQl1g5a/q2qOAWJ5PEnStSxh25GoKhy4+sjUFfOGcEabE444
	 galG1B7wDGmdJYutFvVLBP+8jdzHuK9RT7UJY9aYSgx/W8BwT18JiuxxDJ+uFmA9z+
	 YWAL8qGqpu7ig==
Date: Thu, 6 Mar 2025 11:37:08 +0100
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
Message-ID: <Z8l61Kxss0bdvAQt@ryzen>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan>
 <Z8SyVnXZ4IPZtgGN@ryzen>
 <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
 <Z8VLZERz0FpvpchM@x1-carbon>
 <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>

On Mon, Mar 03, 2025 at 03:58:30PM +0100, Eric wrote:
> Hi Niklas
> 
> Le 03/03/2025 à 07:25, Niklas Cassel a écrit :
> > So far, this just sounds like a bug where UEFI cannot detect your SSD.
> Bit it is detected during cold boot, though.
> > UEFI problems should be reported to your BIOS vendor.
> I'll try to see what can be done, however I am not sure how responsive they
> will be for this board...
> > 
> > It would be interesting to see if _Linux_ can detect your SSD, after a
> > reboot, without UEFI involvement.
> > 
> > If you kexec into the same kernel as you are currently running:
> > https://manpages.debian.org/testing/kexec-tools/kexec.8.en.html
> > 
> > Do you see your SSD in the kexec'd kernel?
> 
> Sorry, I've tried that using several methods (systemctl kexec / kexec --load
> + kexec -e / kexec --load + shutdown --reboot now) and it failed each time.
> I *don't* think it is related to this bug, however, because each time the
> process got stuck just after displaying "kexec_core: Starting new kernel".

I just tired (as root):
# kexec -l /boot/vmlinuz-6.13.5-200.fc41.x86_64 --initrd=/boot/initramfs-6.13.5-200.fc41.x86_64.img --reuse-cmd
# kexec -e

and FWIW, kexec worked fine.

Did you specify an initrd ? did you specify --reuse-cmd ?

If not, please try it.


It would be interesting to see if Linux can detect your SATA drive after
a kexec. If it can't, then we need to report the issue to your drive
vendor (Samsung).


Kind regards,
Niklas

