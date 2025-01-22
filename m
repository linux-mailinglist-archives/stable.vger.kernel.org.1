Return-Path: <stable+bounces-110226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B9DA19991
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 21:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DED518866A0
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F40C21576D;
	Wed, 22 Jan 2025 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pqXTxbUL"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73B17DE36;
	Wed, 22 Jan 2025 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737576974; cv=none; b=assRdOwnuskl29z+TWYyeTMYwhdfNFCbqFI//IjMuP8bZLAYeFs/gRmrEIu55h8E27OGvsYxJmULM9cPWf3c5VzlzCaryJOTr9/QHl1J8lKU+js0icokggAoHXGvD0d+mTY9DGo3Uw3Jtxo2WszIUmlohY43kbnWqckKX7KPeKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737576974; c=relaxed/simple;
	bh=mrELf360ddFSXfr/6Kk6zfUpfHKhnGtGQt3ND1h8iMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIBPT2b0H1ZD5rRiI4PNZicWyuebDEumBAuq2gEouoTXmSoM2FbFRm5hVBc/gKcU8IO7zP6Pt3AjSk6n2ks9ilY/ZuVDI8ar0LyR6Fzw6bfbsKsVNWJO+P1jvun/YE5f76NetSjas9LFM56wWc9OWAZkIb39FqssxbniQfIfCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pqXTxbUL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=FEP6BDE1bCKHh4jPC1RgeOE19jluOGsto4pWRvxO/C8=; b=pq
	XTxbULKsHW0HSkTfNZQOynnfhy1DREsZqv2i2BouP7qnWKKsvjH8AQ2N8FV0vO6Dp77VZKCyxDRhP
	cGFoC96kAsN9o7vHiZVueHf2RFMintRDf/zB1vPaD2dN0XKvrcWTIBX4ow8FS4VtucVcRn1CRioIq
	20xYp1rdTnu9uFU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tah8g-007397-TJ; Wed, 22 Jan 2025 21:15:50 +0100
Date: Wed, 22 Jan 2025 21:15:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] ptp: Ensure info->enable callback is always set
Message-ID: <beff971d-caee-449a-868e-aa9214137ddc@lunn.ch>
References: <20250122-ptp-enable-v1-1-979d3d24591d@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122-ptp-enable-v1-1-979d3d24591d@weissschuh.net>

On Wed, Jan 22, 2025 at 07:39:31PM +0100, Thomas Weißschuh wrote:
> The ioctl and sysfs handlers unconditionally call the ->enable callback.
> Not all drivers implement that callback, leading to NULL dereferences.
> Example of affected drivers: ptp_s390.c, ptp_vclock.c and ptp_mock.c.

> +	if (!ptp->info->enable)
> +		ptp->info->enable = ptp_enable;

Is it possible that a driver has defined info as a const, and placed
it into read only memory? It is generally good practice to make
structures of ops read only to prevent some forms of attack.

	Andrew

