Return-Path: <stable+bounces-135288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298ACA98BF4
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F421B80711
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8321074040;
	Wed, 23 Apr 2025 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wzm+JWoF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E3419F48D
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416420; cv=none; b=GRkOD0HTcBqeX0BpdbH9T46N4v6dwK+jWHSCkGgECI297w8SfSclwWznm9OvWCleWT31Nt/YNXIXRfMaNaiXPYNrxuz/dSTF9OgadKAmKs89KXXmPRCRLDwu4NvL5ieYzRwmuph9LYacmBPKkKsd8fi1wv7ceWyxWmkzGb2LyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416420; c=relaxed/simple;
	bh=IF7yphwydsrGYE1JfoYae/AVqUcXfh5oxnUTaQKAxx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKTkwtKEIJEQwVMWT5wZnQIFdUlraF9LI8NMH1XxM/s3cieu/vLTLoFOcdQqRiNqryxYythLnUFrqnoDzxFTYuvsEgQqeJr1juKmA4zGNEtu9MUSCCWpbeYHcC5DKSslg1W1eEnp7zW1BD9NjFYViN5ieobwol/hlw9hrysdZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wzm+JWoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C37FC4CEE2;
	Wed, 23 Apr 2025 13:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745416419;
	bh=IF7yphwydsrGYE1JfoYae/AVqUcXfh5oxnUTaQKAxx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wzm+JWoFkUlY2NXAag1muOjMIe3KB8kSID7ZFiRY590YMpY42Kr4S/kBtnEoenTv8
	 ExSg21gv4ihE6H8HX7XI/KLq6wLuupBvZjKWBl8xCw9qULp3HtiQAEdSy4KPzQtae+
	 YsVTatBQk7M9RadFImVR/drUmEJRuqDHV1G8GnF8=
Date: Wed, 23 Apr 2025 15:53:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: stable@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5.10.y 1/4] mmc: sdhci-brcmstb: Add ability to increase
 max clock rate for 72116b0
Message-ID: <2025042309-dexterity-vicinity-0c92@gregkh>
References: <2025032414-unsheathe-greedily-1d17@gregkh>
 <20250324204639.17505-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324204639.17505-1-kamal.dasu@broadcom.com>

On Mon, Mar 24, 2025 at 04:46:36PM -0400, Kamal Dasu wrote:
> From: Kamal Dasu <kdasu.kdev@gmail.com>
> 
>  [ upstream commit 97904a59855c7ac7c613085bc6bdc550d48524ff ]
> 
> The 72116B0 has improved SDIO controllers that allow the max clock
> rate to be increased from a max of 100MHz to a max of 150MHz. The
> driver will need to get the clock and increase it's default rate
> and override the caps register, that still indicates a max of 100MHz.
> The new clock will be named "sdio_freq" in the DT node's "clock-names"
> list. The driver will use a DT property, "clock-frequency", to
> enable this functionality and will get the actual rate in MHz
> from the property to allow various speeds to be requested.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Link: https://lore.kernel.org/r/20220520183108.47358-3-kdasu.kdev@gmail.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 69 +++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)

This commit breaks the build, how was it tested?

I'm dropping all of these from the 5.10.y tree now.

thanks,

greg k-h

