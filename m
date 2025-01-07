Return-Path: <stable+bounces-107862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F721A04462
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 16:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A593F1668E9
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF581F5405;
	Tue,  7 Jan 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VArcrndb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66DB1F4E5B;
	Tue,  7 Jan 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263656; cv=none; b=Efuu/1GmUKC/PZi+JDUH7dd0LODhBKqrCbq4An3z/9QfFwLJ9i7hFoAugSBl61SYSbWB7dfSP1+KUraaDHdW5hNrNqWExb2CP37UpXJaNea+3KXiJiFcNJFNMUzkCGNOTFwIfuG9rYkNARKnSh+dUZEtJVh+H3X46AonmQW+ZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263656; c=relaxed/simple;
	bh=ScqUhtJE+0fBFNr0lmCLLMRPqcgRjvXG+/C8hOZCSCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs2XPca8KPXerFotEPj670pOz/ULwb/dAn+tUT2tBq/gVMhwPtzdhqDqDnI2UiUJr6RXvE8RXguTDlMvsMX+qqrglJTq3z6Uw0Jazqf84UJ+3xGBH1OEMckrJyfxANEG3g/xk8awuSmMAi8Npe9ncAsqTKX2kxxHvxzLjTKZCNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VArcrndb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1D6C4CED6;
	Tue,  7 Jan 2025 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736263655;
	bh=ScqUhtJE+0fBFNr0lmCLLMRPqcgRjvXG+/C8hOZCSCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VArcrndb/RNzEstEyq3ObLhOlcFwRJ+GWZdLrZaYSaJKvnD6agKZr09DdKaIqg6Od
	 zqD8HkEJm8XWGuhL3EWrWZL1pKJkYRJdOVWawMu5YSjl0rqPk8o5J8kCtLOLe0gl3r
	 8oMoU2ambRz3uDQ068UtYNxO++wpVYWNXdEiUqpo=
Date: Tue, 7 Jan 2025 16:27:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] Revert "staging: remove rts5139 driver code"
Message-ID: <2025010718-tamale-eraser-4c49@gregkh>
References: <20241119121912.12383-1-sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119121912.12383-1-sean@starlabs.systems>

On Tue, Nov 19, 2024 at 12:19:10PM +0000, Sean Rhodes wrote:
> This reverts commit 00d8521dcd236d1b8f664f54a0309e96bfdcb4f9.
> 
> The staging driver that was removed, `rts5139`, worked well with multiple
> Realtek card readers and provided more comprehensive functionality than
> `rtsx_usb`. It supported features like interrupts, SSC, speed modes,
> suspend, secure erase, TRIM, and more. Additionally, its error recovery
> mechanisms were superior.
> 
> Notable issues with the `rtsx_usb` driver include delayed S3 entry until
> `mmc_rescan` was frozen and data corruption on SDR104 cards. Over 100 bugs
> related to the `rtsx_usb` driver are reported on Bugzilla, with additional
> reports downstream. As a result, several forks of `rts5139` exist on
> GitHub and other repositories, which users rely on to mitigate these
> problems.
> 
> Reintroducing `rts5139` addresses these deficiencies until the current
> `rtsx_usb` driver achieves feature parity and stability.
> 
> Fixes: 00d8521dcd23 ("staging: remove rts5139 driver code")
> Cc: stable@vger.kernel.org

Sorry, but this isn't a stable patch, it's "add a whole new driver".

Also, who is now going to take over maintaining this driver?  There's
still a lot of things left on the TODO list:

> --- /dev/null
> +++ b/drivers/staging/rts5139/TODO
> @@ -0,0 +1,9 @@
> +TODO:
> +- support more USB card reader of Realtek family
> +- use kernel coding style
> +- checkpatch.pl fixes
> +- stop having thousands of lines of code duplicated with staging/rts_pstor
> +- This driver contains an entire SD/MMC stack -- it should use the stack in
> +  drivers/mmc instead, as a host driver e.g. drivers/mmc/host/realtek-usb.c;
> +  see drivers/mmc/host/ushc.c as an example.
> +- This driver presents cards as SCSI devices, but they should be MMC devices.

The biggest issue is the whole mmc stack being in here.  When is that
work going to happen?  Why not just add the missing features to the
existing misc/ drivers instead?

I'll be glad to add this back, but I need someone to take ownership of
it in order to fix this and get it out of staging.  Please feel free to
resend this series with that information.

thanks,

greg k-h

