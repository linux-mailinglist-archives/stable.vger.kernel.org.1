Return-Path: <stable+bounces-167237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA96B22DE9
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4C03A4A1D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536A02F90DB;
	Tue, 12 Aug 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D+ES2IUF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AED2F8BE7
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016470; cv=none; b=jW+ggfPU0uGSHwdfzd/BMyXPZOZ3F/K7S+6h2FTglpBlFlS122w2PZ+YkcivSt06DAD2l8ltr9PVGH+8PZ2LX0WMGlDv5SYHYx245XKYtNruxZTH5DMcj4nrEGm6uJsnusTnhb7cAjgcSevYmxA6xoB16MCoF7GfBhjRoX8cBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016470; c=relaxed/simple;
	bh=LJ/i+tieKXDbQKIs6+URwWC+bkiPwWUMswiri6E3TD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGVtsmBBEEz3fd/a6YYJODExj7wA8oqtY4trOHIzDCKhY8HBC7wloszAKv3VI9OHiNHhhk2G+Gsu38pkImZRwist4eOLqJR4iSWVTb+L3CYNE2eoW6QZKBwkKBXe7Ow45fgKKmVI9NBNgZO1Y/PrItFC90jf1iuR8o9FFOF+x5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D+ES2IUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB9AC4CEF0;
	Tue, 12 Aug 2025 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755016469;
	bh=LJ/i+tieKXDbQKIs6+URwWC+bkiPwWUMswiri6E3TD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+ES2IUFv+oRzhzltfLB2sFcMz2OptTswQSD5z+lIv20PMCiuBiFs1DzIwt0wUl8c
	 0MzcSlG96ms9oNST95yyoZfMntUAfhJ/SDvZckXPF5MHwIZmDPo4Cp6yHzbus4aluo
	 2wFRkR9I35GO/WfVEcTUqPLfJ82lHcmm+DhVlrB8=
Date: Tue, 12 Aug 2025 18:34:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zenm Chen <zenmchen@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Don't apply "Bluetooth: btusb: Add USB ID 3625:010b for TP-LINK
 Archer TX10UB Nano" to kernel 6.1 and 5.15
Message-ID: <2025081221-motivator-carried-1b1f@gregkh>
References: <CAO96fyriHkbCmDG=RGWMf7VHKeK0boQY-AycDDkchQQfZCun2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO96fyriHkbCmDG=RGWMf7VHKeK0boQY-AycDDkchQQfZCun2w@mail.gmail.com>

On Wed, Aug 13, 2025 at 12:29:10AM +0800, Zenm Chen wrote:
> Hi Greg,
> 
> Sorry that my patch [1] didn't clearly tell which kernels it should apply
> to.
> 
> The Bluetooth support for Realtek RTL8851BE/RTL8851BU chips was added into
> the kernel since 6.4 [2], so please don't apply this patch to kernel 6.1,
> 5.15 and other older stable kernels, thank you very much!
> 
> [1] Bluetooth: btusb: Add USB ID 3625:010b for TP-LINK Archer TX10UB Nano
> https://lore.kernel.org/stable/20250521013020.1983-1-zenmchen@gmail.com/
> 
> [2] Bluetooth: btrtl: Add the support for RTL8851B
> https://github.com/torvalds/linux/commit/7948fe1c92d92313eea5453f83deb7f0141355e8

Ok, now dropped, thanks.
greg k-h

