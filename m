Return-Path: <stable+bounces-120270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE84A4E78A
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10F6885EFC
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADBF27BF72;
	Tue,  4 Mar 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qhgzmTBD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF2E26388D;
	Tue,  4 Mar 2025 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105227; cv=none; b=FwFbk7p95w7EABG3jWuxdSc+c8ULWPEshVHVWE92o/U0Bd9x4qA3caPyj7/3peRcaAne3t/Zt5ruQF8U4nUt5BPe50hfQKV32B4gPMuZNf2oxUKP2g7fV/78c4/I1y9Sny/uDoyJb/yBZgKpLDUVdoT3B93tmAhyvWpja6GzACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105227; c=relaxed/simple;
	bh=TkxPbcmHtN7pCbda8Jun30wnH1K0iXw0SY5Ec2Wx1ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0m7D7UIrEQh8sZ7PIS933LhUm7643T179Vf8S661GDblSkL3rcnlveE+dqNLq0CGej3Xk4e8m1L2Wt515ZxFFRZ622+8SNMmZH0iDp/klwbfBcvfu1hdtYI1e/khwbuHjU/Rvg5erkCcr+WVnc76Kpn/rXI4qJVNBOn+4uMTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qhgzmTBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74EAC4CEE5;
	Tue,  4 Mar 2025 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741105226;
	bh=TkxPbcmHtN7pCbda8Jun30wnH1K0iXw0SY5Ec2Wx1ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhgzmTBD3hKPMAUmIo86nmjLCsULTyxwhrQzkOfhoi8i+3wyI8CA93NOMxdgMglbx
	 WAqwK8VgGk4Sf9B8kMYwLJjHBRsr9/cQMb5UZRvPfkUV2TDO027F4yIp3FrBy4YG8k
	 YzxViWc6NmNuGPsgFKhiO9TwvTgVavRk74QCI4Zw=
Date: Tue, 4 Mar 2025 17:20:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, ardb@kernel.org
Subject: Re: Regression for PXE boot from patch "Remove the 'bugger off'
 message" in stable 6.6.18
Message-ID: <2025030459-singer-compactor-9c91@gregkh>
References: <202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de>

On Tue, Mar 04, 2025 at 03:49:35PM +0100, Ulrich Gemkow wrote:
> Hello,
> 
> starting with stable kernel 6.6.18 we have problems with PXE booting.
> A bisect shows that the following patch is guilty:
> 
>   From 768171d7ebbce005210e1cf8456f043304805c15 Mon Sep 17 00:00:00 2001
>   From: Ard Biesheuvel <ardb@kernel.org>
>   Date: Tue, 12 Sep 2023 09:00:55 +0000
>   Subject: x86/boot: Remove the 'bugger off' message
> 
>   Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>   Signed-off-by: Ingo Molnar <mingo@kernel.org>
>   Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
>   Link: https://lore.kernel.org/r/20230912090051.4014114-21-ardb@google.com
> 
> With this patch applied PXE starts, requests the kernel and the initrd.
> Without showing anything on the console, the boot process stops.
> It seems, that the kernel crashes very early.
> 
> With stable kernel 6.6.17 PXE boot works without problems.
> 
> Reverting this single patch (which is part of a larger set of
> patches) solved the problem for us, PXE boot is working again.
> 
> We use the packages syslinux-efi and syslinux-common from Debian 12.
> The used boot files are /efi64/syslinux.efi and /ldlinux.e64.
> 
> Our config-File (for 6.6.80) is attached.
> 
> Regarding the patch description, we really do not boot with a floppy :-)
> 
> Any help would be greatly appreciated, I have a bit of a bad feeling
> about simply reverting a patch at such a deep level in the kernel.

Does newer kernels than 6.7.y work properly?  What about the latest
6.12.y release?

thanks,

greg k-h

