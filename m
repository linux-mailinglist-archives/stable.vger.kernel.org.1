Return-Path: <stable+bounces-90076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D809BDF6C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 08:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5DF280FED
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 07:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A421CC898;
	Wed,  6 Nov 2024 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UjuOnZFC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360219066D
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878176; cv=none; b=ZRhb9o0a9K3ikLQOLESshb+bGdBu5XCtgIUP/pYuTHbC76O+Zpt/Ev/UHCCmfNpeRHRX9OdNFwTuQ15FzuSdwNLPRivKss8N2LaGy/+zyc1sF1chVMumImcz+uikagrYz15bw/OQUsWUQb+RaHA9l7l9lM2iFnibVDcMLR8D2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878176; c=relaxed/simple;
	bh=6Xll3ARcdpj4y4QS+PEoxA4rK3qYXzviE+dodAFH40Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeNeA3g2NmW6ict8evow6R4BIpzW6Pvqi8Ay0rALRmQotsIPkVopzFZZhdBAceuGEBYVWJA2FwHPGUmbHNeZv1RjpreRQJkkwAO4fXEwEzHEHA0msbEZkAjPQlD6LIbKtZgZ14swvoLQKN4CY5iNtvfZl/6qEE3HczA/7QVvwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UjuOnZFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629E3C4CECD;
	Wed,  6 Nov 2024 07:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730878175;
	bh=6Xll3ARcdpj4y4QS+PEoxA4rK3qYXzviE+dodAFH40Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UjuOnZFCaL0DN07qVNYk1u4fKgh2teJ521K+xvYUa0+SEhBYsK9PUv5MFknkc6EJf
	 vE/crtXKCvF55Imv8T7Hly57cwcd6LW6bgSwZiaz9RBNGhB9YWpy4mjiD44FQ0GQaT
	 eqkf27x70oeA5OznnsPpTox6ogtvxl1fnPoeCz6c=
Date: Wed, 6 Nov 2024 08:29:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell Senior <russell@personaltelco.net>, stable@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>, Hartmut Birr <e9hack@gmail.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Esben Haabendal <esben@geanix.com>,
	Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: fix w25q128 regression
Message-ID: <2024110606-data-trance-3ca8@gregkh>
References: <20241029-v6-6-v2-1-04165dcaf177@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-v6-6-v2-1-04165dcaf177@linaro.org>

On Tue, Oct 29, 2024 at 11:01:45AM +0100, Linus Walleij wrote:
> From: Michael Walle <mwalle@kernel.org>
> 
> Upstream commit d35df77707bf5ae1221b5ba1c8a88cf4fcdd4901
> 
> ("mtd: spi-nor: winbond: fix w25q128 regression")
> however the code has changed a lot after v6.6 so the patch did
> not apply to v6.6 or v6.1 which still has the problem.
> 
> This patch fixes the issue in the way of the old API and has
> been tested on hardware. Please apply it for v6.1 and v6.6.
> 
> Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> removed the flags for non-SFDP devices. It was assumed that it wasn't in
> use anymore. This wasn't true. Add the no_sfdp_flags as well as the size
> again.
> 
> We add the additional flags for dual and quad read because they have
> been reported to work properly by Hartmut using both older and newer
> versions of this flash, the similar flashes with 64Mbit and 256Mbit
> already have these flags and because it will (luckily) trigger our
> legacy SFDP parsing, so newer versions with SFDP support will still get
> the parameters from the SFDP tables.
> 
> Reported-by: Hartmut Birr <e9hack@gmail.com>
> Closes: https://lore.kernel.org/r/CALxbwRo_-9CaJmt7r7ELgu+vOcgk=xZcGHobnKf=oT2=u4d4aA@mail.gmail.com/
> Fixes: 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Esben Haabendal <esben@geanix.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> Link: https://lore.kernel.org/r/20240621120929.2670185-1-mwalle@kernel.org
> [Backported to v6.6 - vastly different due to upstream changes]
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This fix backported to stable v6.6 and v6.1 after reports
> from OpenWrt users:
> https://github.com/openwrt/openwrt/issues/16796
> ---
> Changes in v2:
> - Use the right upstream committ ID (dunno what happened)
> - Put the commit ID on top on the desired format.
> - Link to v1: https://lore.kernel.org/r/20241028-v6-6-v1-1-991446d71bb7@linaro.org
> ---
>  drivers/mtd/spi-nor/winbond.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Now queued up, thanks.

greg k-h

