Return-Path: <stable+bounces-72994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA296B771
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7F11F261D0
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798CD1A42D2;
	Wed,  4 Sep 2024 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YaSfZaoE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1C1EBFEA;
	Wed,  4 Sep 2024 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443602; cv=none; b=SPb6CZe9XLcv2uCo65g6xDjJ05s5qDclMLxVmPv5v/1wj+0Ixsjzl/Rgifnyu6NW7ddYnwpO86VrYP+EipU7gp5CcWi6HBICpAdMXccASWgRiSqL2SBAZ/kMGUsDGGugBcvC1MFOwpnI6uzK5IXk2n39jcy+WOjDa+M56E+eCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443602; c=relaxed/simple;
	bh=NBh72CSFH3xrTu5kazoMl9N+ejgQmT44qsc98DLhg8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnaRdU1IwBf6ZhSVfigG37mI6DijR0TyOjHDBkpnIEKD51BCRgfMEET+N3AQl832vH+0xfcBuHtJVqsodMM1RGZCMtof8+FI3upRzfnWEckAmrWEBbfUHqeg8gvRhiRXRyjkwb8nzNW5XfDd6HqG9MBiiBGMJjj9tVkuCv52Ido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YaSfZaoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F3BC4CEC6;
	Wed,  4 Sep 2024 09:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725443601;
	bh=NBh72CSFH3xrTu5kazoMl9N+ejgQmT44qsc98DLhg8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YaSfZaoENlPebWPb53Xjtvae3OqpsrD/7wvZUVtYVvb02xCj9EW91hzSzj+Qmlfky
	 vcMui7R7v2fRy63fxB+3nhjs1mGF1egWObarP7pAOGADjxTk4/vwIsmk/923wuu+0G
	 uaWfRCbx98sJeY4UXQXp0t4vm7sNCsE+suDodY+g=
Date: Wed, 4 Sep 2024 11:53:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Narron <richard@aaazen.com>
Cc: Linux stable <stable@vger.kernel.org>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5.15 000/215] 5.15.166-rc1 review
Message-ID: <2024090419-repent-resonant-14c1@gregkh>
References: <8c0d05-19e-de6d-4f21-9af4229a7e@aaazen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0d05-19e-de6d-4f21-9af4229a7e@aaazen.com>

On Mon, Sep 02, 2024 at 03:39:49PM -0700, Richard Narron wrote:
> I get an "out of memory" error when building Linux kernels 5.15.164,
> 5.15.165 and 5.15.166-rc1:
> ...
>   LD [M]  drivers/mtd/tests/mtd_stresstest.o
>   LD [M]  drivers/pcmcia/pcmcia_core.o
>   LD [M]  drivers/mtd/tests/mtd_subpagetest.o
> 
> cc1: out of memory allocating 180705472 bytes after a total of 283914240
> bytes
>   LD [M]  drivers/mtd/tests/mtd_torturetest.o
>   CC [M]  drivers/mtd/ubi/wl.o
>   LD [M]  drivers/pcmcia/pcmcia.o
>   CC [M]  drivers/gpu/drm/nouveau/nvkm/engine/disp/headgv100.o
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.o
>   LD [M]  drivers/mtd/tests/mtd_nandbiterrs.o
>   CC [M]  drivers/mtd/ubi/attach.o
>   LD [M]  drivers/staging/qlge/qlge.o
> make[4]: *** [scripts/Makefile.build:289:
> drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.o]
> Error 1
> make[3]: *** [scripts/Makefile.build:552: drivers/staging/media/atomisp]
> Error 2
> make[2]: *** [scripts/Makefile.build:552: drivers/staging/media] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   LD [M]  drivers/pcmcia/pcmcia_rsrc.o
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_outbox.o
> make[1]: *** [scripts/Makefile.build:552: drivers/staging] Error 2
> make[1]: *** Waiting for unfinished jobs....
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dml/calcs/dce_calcs.o
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dml/calcs/custom_float.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.o
> ...
> 
> #uname -a
> Linux aragorn 5.15.166-rc1-smp #1 SMP PREEMPT Mon Sep 2 14:03:00 PDT 2024
> i686 AMD Ryzen 9 5900X 12-Core Processor AuthenticAMD GNU/Linux
> 
> Attached is my config file.
> 
> I found a work around for this problem.
> 
> Remove the six minmax patches introduced with kernel 5.15.164:
> 
> minmax: allow comparisons of 'int' against 'unsigned char/short'
> minmax: allow min()/max()/clamp() if the arguments have the same
> minmax: clamp more efficiently by avoiding extra comparison
> minmax: fix header inclusions
> minmax: relax check to allow comparison between unsigned arguments
> minmax: sanity check constant bounds when clamping
> 
> Can these 6 patches be removed or fixed?

It's a bit late, as we rely on them for other changes.

Perhaps just fixes for the files that you are seeing build crashes on?
I know a bunch of them went into Linus's tree for this issue, but we
didn't backport them as I didn't know what was, and was not, needed.  If
you can pinpoint the files that cause crashes, I can dig them up.

thanks,

greg k-h

