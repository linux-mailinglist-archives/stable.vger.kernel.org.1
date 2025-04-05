Return-Path: <stable+bounces-128398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C7BA7C965
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 15:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821BA7A8944
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556181F150E;
	Sat,  5 Apr 2025 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yKJG4FlL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC71119A;
	Sat,  5 Apr 2025 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743860522; cv=none; b=Vxg0BibJfN0h24nX4P4whNfxeF2IyQX84oaBOpMb2nIYoXCgzWx7YNVu174cD1+ZG5lj/5vRQDyl7Yd09YdryLFQHlQxus6bRHupKGYunXmPXk59WwYP3GWL7axcPY5bJRfaU9czD/zDlKSBW3mw8b9rGCS4Wo0xpGtwyZmKkWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743860522; c=relaxed/simple;
	bh=6ZBu1ypN5W8L8ABHscPMDLNWedVKSj4STFjXvlC54b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWNOFTDgERg/97PKygw1e/7eMdxkNU1dfl4pvdC8S32vo36TjJRyp6GxZ9O/sz+SWGW0hN85G1N/5UmZphsffmeRpKTdqnsiPX3qlOOVSCqHE4IbFyA2iPKfSAgyiqXOSLuOdrQf/GD8UYdtFcmHkv6Gi56rP1cRwuRxIUhdKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yKJG4FlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEF7C4CEE4;
	Sat,  5 Apr 2025 13:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743860521;
	bh=6ZBu1ypN5W8L8ABHscPMDLNWedVKSj4STFjXvlC54b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yKJG4FlLE0R4wffcuvHSI63O9Hn7/iUSBrOvJCJwRC0BW7UNldm2LUerVN3emEYBV
	 hU68YKpr1jCbDl3F/l9c/RNeAl1oYMsZCnQpAn+hSg6aEyWpHvqNV9MItxYnhjASZw
	 mcDyxpkuvVOPMdR5ILHIR9L4em1QdRzMMRbe2jpg=
Date: Sat, 5 Apr 2025 14:40:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, bigeasy@linutronix.de,
	conor.dooley@microchip.com, jirislaby@kernel.org,
	john.ogness@linutronix.de, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pmladek@suse.com,
	samuel.holland@sifive.com, u.kleine-koenig@baylibre.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] serial: sifive: lock port in startup()/shutdown()
 callbacks
Message-ID: <2025040513-bronco-capsule-91aa@gregkh>
References: <20250405132458.488942-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405132458.488942-1-ryotkkr98@gmail.com>

On Sat, Apr 05, 2025 at 10:24:58PM +0900, Ryo Takakura wrote:
> startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
> The register is also accessed from write() callback.
> 
> If console were printing and startup()/shutdown() callback
> gets called, its access to the register could be overwritten.
> 
> Add port->lock to startup()/shutdown() callbacks to make sure
> their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
> write() callback.
> 
> Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> 
> This patch used be part of a series for converting sifive driver to
> nbcon[0]. It's now sent seperatly as the rest of the series does not
> need be applied to the stable branch.

That means this is a v2 patch, and you should also send the other patch
as a v2 as well, right?

thanks,

greg k-h

