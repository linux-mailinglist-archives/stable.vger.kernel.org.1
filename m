Return-Path: <stable+bounces-151388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B32BACDE2B
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8941884ADC
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CEA28EA76;
	Wed,  4 Jun 2025 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z2xSW+QB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A328D8DD;
	Wed,  4 Jun 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040703; cv=none; b=Xfim9p1F5I/QKZTM/YONwAcphsjLrwdkbCNsSr61wMj63weFJR7kJgvu6WqbmHzO1PktjdEZPVlc/e00UYpqaU70yRRGUmsijyRAWBScnOzRMFse146O1IB2CthW09NVcjpnrXALJD98S/DU7pOlczZllGiSlhD6/y9u2f4tB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040703; c=relaxed/simple;
	bh=7tHoRWpClE5dLKc7eKaOJE0EBswVDCbH75bRZ0dvDtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8t8YR6egeW11X3ucyif9MlFfhFZ4zEqC33j7zT5Mpo1rZG0Nh9CbM+ALqCP0/GM1KW8bn/CS634JhmYYNY6E6jmS5xlzS21ICRxGpwfDNMwY43JDSoW6/thuSTb7vdKDYPYvwrvbylxEyu3X8Khfz9NOLJ5a/M4pdpHsO93Gsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z2xSW+QB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1572BC4CEEF;
	Wed,  4 Jun 2025 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749040702;
	bh=7tHoRWpClE5dLKc7eKaOJE0EBswVDCbH75bRZ0dvDtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z2xSW+QBOUmyM2yWlcdXcasGDUIDdoKL+FVRkca1oDExVNmQFUMTFBhfYxzMf081m
	 seIkXDCaBdvIqEkSL21CwhsLPL5o2rEjQhPoKgmelIB+BIwGgqCOsPipyrZ1oSCNCy
	 2amykKUElpsO18F5eiHtk0mj5QVMWgFQ7KK1sCsE=
Date: Wed, 4 Jun 2025 14:38:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH stable 6.6.y] arm64: kaslr: fix nokaslr cmdline parsing
Message-ID: <2025060409-fidgeting-basil-abf7@gregkh>
References: <20250603125233.2707474-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603125233.2707474-1-chenridong@huaweicloud.com>

On Tue, Jun 03, 2025 at 12:52:33PM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Currently, when the command line contains "nokaslrxxx", it was incorrectly
> treated as a request to disable KASLR virtual memory. However, the behavior
> is different from physical address handling.
> 
> This issue exists before the commit af73b9a2dd39 ("arm64: kaslr: Use
> feature override instead of parsing the cmdline again"). This patch fixes
> the parsing logic for the 'nokaslr' command line argument. Only the exact
> strings, 'nokaslr', will disable KASLR. Other inputs such as 'xxnokaslr',
> 'xxnokaslrxx', or 'xxnokaslr=xx' will not disable KASLR.
> 
> Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
> Cc: stable@vger.kernel.org # <= v6.6
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  arch/arm64/kernel/pi/kaslr_early.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

