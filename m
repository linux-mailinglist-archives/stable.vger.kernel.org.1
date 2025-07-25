Return-Path: <stable+bounces-164732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31278B11E12
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 14:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFF51C2772A
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 12:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DDD242936;
	Fri, 25 Jul 2025 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L47/rdFP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2C241668
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445000; cv=none; b=gKUr8kng0EDCnfuFPFz6Npr1PbKVMV+jchOEgvgd3Y1aHBIB5+T+MHeWQ+vR4MADeXX7FhuHGdmAj0lBWY6IQHbe+Tw/zv93nkukgR2uTcfbczYkcWQjnVcmg1YczgPNCGZ/XxOLS8pSol70SU7tcanaxWOn+8zx2ZItk+m8gi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445000; c=relaxed/simple;
	bh=CqWK6AkacP8H5wXTmziPUbXlgPcSs9pBqfR+AzjnTQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoHvotH+0k3yTD+Ab/Z2RbBfA/b8cCe73BKsPxV17TcW+12ZfQo/SFUeOgfWSHR+bZoylXVHqWlweHoixNwUORrvhejM9JVLtSPux+xJzwVecGNH4qoGyXTvrADYqW1Z4558hMeAUqk8TuckrTlDDPMiryFVrjcwXTCs4vrHSb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L47/rdFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F459C4CEF6;
	Fri, 25 Jul 2025 12:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753444999;
	bh=CqWK6AkacP8H5wXTmziPUbXlgPcSs9pBqfR+AzjnTQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L47/rdFPbU/YIBdOKKhixMDMHYEP7P9gaXDXv/Sq503AjciFFVymoQD2wqYGMDAuo
	 Xr8moJfaEgGfJyPZbFtbmigmFJTBe38IwhK/hC3UHMv75ID3yLlNi7ExeE/yhbhum6
	 4hNoBD+fQ2qVT9WvueebXpBD7xmQjrzYh4eLJw8w=
Date: Fri, 25 Jul 2025 14:03:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Arin Sun <sunxploree@gmail.com>
Cc: stable@vger.kernel.org, x86@kernel.org, tglx@linutronix.de
Subject: Re: [stable backport request] x86/ioremap: Use is_ioremap_addr() in
 iounmap() for 5.15.y
Message-ID: <2025072520-pedometer-abstract-f159@gregkh>
References: <CAGvw722wvDKxrmhm--3xu2Ck7fG0Z4PAOyeNaN27bwccbVLRGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGvw722wvDKxrmhm--3xu2Ck7fG0Z4PAOyeNaN27bwccbVLRGg@mail.gmail.com>

On Fri, Jul 25, 2025 at 06:32:50PM +0800, Arin Sun wrote:
> Dear Stable Kernel Team and Maintainers,
> 
> I am writing to request a backport of the following commit from the
> mainline kernel to the 5.15.y stable branch:
> 
> Commit: x86/ioremap: Use is_ioremap_addr() in iounmap()
> ID: 50c6dbdfd16e312382842198a7919341ad480e05
> Author: Max Ramanouski
> Merged in: Linux 6.11-rc1 (approximately August 2024)

It showed up in 6.12, not 6.11.

> This commit fixes a bug in the iounmap() function for x86
> architectures in kernel versions 5.x. Specifically, the original code
> uses a check against high_memory:
> 
> 
> if ((void __force *)addr <= high_memory)
> return;
> 
> This can lead to memory leaks on certain x86 servers where ioremap()
> returns addresses that are not guaranteed to be greater than
> high_memory, causing the function to return early without properly
> unmapping the memory.
> 
> The fix replaces this with is_ioremap_addr(), making the check more reliable:
> 
> if (WARN_ON_ONCE(!is_ioremap_addr((void __force *)addr)))
> return;
> 
> I have checked the 5.15.y branch logs and did not find this backport.
> This issue affects production environments, particularly on customer
> machines where we cannot easily deploy custom kernels. Backporting
> this to 5.15.y (and possibly other LTS branches like 5.10.y if
> applicable) would help resolve the memory leak without requiring users
> to upgrade to 6.x series.
> 
> Do you have plans to backport this commit? If not, could you please
> consider it for inclusion in the stable releases?

Note, this caused problems that later commits were required to fix up.

Can you please provide a set of properly backported commits, that are
tested, to all of the relevant kernel trees that you need/want this for?
You can't just apply a patch to an older kernel tree and not a newer one
as that would cause a regression when upgrading, right?

But I might ask, why not just move to the 6.12.y release?  What is
forcing you to keep on 5.15.y and what are you plans for moving off of
that in a few years?

thanks,

greg k-h

