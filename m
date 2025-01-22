Return-Path: <stable+bounces-110232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A62FA19A76
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 22:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE91D188DB5B
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 21:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B9A1C5F1C;
	Wed, 22 Jan 2025 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SCsaXahl"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E781C5D7A;
	Wed, 22 Jan 2025 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737582060; cv=none; b=dwCfAsEcHRLygztOQ2nU7PFzDQdC6Rz0lxKBVni7RPvxWuwV7nKfEgUrr3+IOtZKNVCPUO/+LW6XehnVflURHEV/qqlBN7Xks25/nwGP5bL0QOZpv2oYjdBpr8+WXNoPyIxeETg8PAfEKNCB+o9diwkowcBKPjsBsHV2u4KeBU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737582060; c=relaxed/simple;
	bh=8dCGUBoRedD49K9gCIm4MnTcF+hUjrSzwQ06onykJ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T60nMORRLrS+cud955mzXK9XH+G+AKNk/xr9mLG/8qGlgyqq+Y9l1Wfp3r1bAhfpjyAG/YvCcfMsxq9Kfyh/JQCu97Ks7kyYdiAkbwtBrAJdqNf8Q6xv9aWth5kGXo50NGXthjDNbYNBlw5y96iIl2s+XtV3ahbLGcK/s3tRLUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=SCsaXahl; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737582055;
	bh=8dCGUBoRedD49K9gCIm4MnTcF+hUjrSzwQ06onykJ0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCsaXahlxixFIzkg5YUT5lxBsZCCRynmcVi/+6jOrLE6gDzCk6OlIjpqiKyKtQAZt
	 1M2ehiK16TJWrSbqJZm6pXHPToqSP6N+I964d+G0CArgrc+vpzPFPdPyt3hsL19jqb
	 1P8Pw29CpS2wwnvYp3mozzQTQA/FzFPTzCmu4l3g=
Date: Wed, 22 Jan 2025 22:40:54 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, John Stultz <john.stultz@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] ptp: Ensure info->enable callback is always set
Message-ID: <a1b805e3-af05-45a7-8094-136b0247db9c@t-8ch.de>
References: <20250122-ptp-enable-v1-1-979d3d24591d@weissschuh.net>
 <beff971d-caee-449a-868e-aa9214137ddc@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <beff971d-caee-449a-868e-aa9214137ddc@lunn.ch>

On 2025-01-22 21:15:50+0100, Andrew Lunn wrote:
> On Wed, Jan 22, 2025 at 07:39:31PM +0100, Thomas Weißschuh wrote:
> > The ioctl and sysfs handlers unconditionally call the ->enable callback.
> > Not all drivers implement that callback, leading to NULL dereferences.
> > Example of affected drivers: ptp_s390.c, ptp_vclock.c and ptp_mock.c.
> 
> > +	if (!ptp->info->enable)
> > +		ptp->info->enable = ptp_enable;
> 
> Is it possible that a driver has defined info as a const, and placed
> it into read only memory? It is generally good practice to make
> structures of ops read only to prevent some forms of attack.

The modified info struct is a subsystem-private copy and not the struct
passed by the driver. Also ptp_clock_register() requires a mutable
ops struct parameter anyways.

