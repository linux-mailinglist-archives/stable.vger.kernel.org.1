Return-Path: <stable+bounces-136665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A37A9C07D
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7C216AFD6
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 08:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6827522F76B;
	Fri, 25 Apr 2025 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dCo9LtGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186AC635
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568661; cv=none; b=k9M4eCYTadhiGVy3fpt3TAbhsgOB0Fh5pN3R+fYRfb3WbIEzLcpHO7Y7m5mGvEWl0h2fS6lxOhqFCfZbx5H8BSdyH1ig0Oo5xI1yPNl9pAiqVHXWwD+913qAgE6jwvB0BjpllUeKq8fRNJgAvdXjrLuc7OFiKwNIeKLXTohny7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568661; c=relaxed/simple;
	bh=pmI+5fAV2orsjncEnefA8IfCtK8LmtT4UhEnHtmgE5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paI/8KGHC5BWSHb6evSucYlC3tH85SRpUBANjwIFWztUc5CazYgKvRpqZyyUWp3PLk8JfBVzScrX4IU1HVlFz8nxsNlwpt5skRq/uR4JWFrS5hXC98BY40lJXuhNuyEv0EPgjogTmBgID7TcLlokVoyIMbutUgfsP3B0RS/0/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dCo9LtGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330F2C4CEEA;
	Fri, 25 Apr 2025 08:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745568660;
	bh=pmI+5fAV2orsjncEnefA8IfCtK8LmtT4UhEnHtmgE5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCo9LtGOrEaQ+UtLc7zG0Sp0NmS53bpE9pwdt2KU2Cd7YE0yj6i2eWEHHa1LJjwPA
	 RzfyKairdGxt/mhRZSaJOCMQ68nKJerfcdvhD0DaHrHiWTrnh6WxvJf50cLK9xnQYK
	 Mo9UHoKe8J6UL6ZNVy5BBjkoUNLSFQ+ClB6XNJwQ=
Date: Fri, 25 Apr 2025 10:10:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, peter.ujfalusi@ti.com, vkoul@kernel.org
Subject: Re: [PATCH 1/3 v5.4.y] dmaengine: ti: edma: Add support for handling
 reserved channels
Message-ID: <2025042527-livestock-client-3c04@gregkh>
References: <2025042315-tamer-gaffe-8de0@gregkh>
 <20250424060854.50783-1-hgohil@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424060854.50783-1-hgohil@mvista.com>

On Thu, Apr 24, 2025 at 06:08:54AM +0000, Hardik Gohil wrote:
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Like paRAM slots, channels could be used by other cores and in this case
> we need to make sure that the driver do not alter these channels.
> 
> Handle the generic dma-channel-mask property to mark channels in a bitmap
> which can not be used by Linux and convert the legacy rsv_chans if it is
> provided by platform_data.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Link: https://lore.kernel.org/r/20191025073056.25450-4-peter.ujfalusi@ti.com
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Hardik Gohil <hgohil@mvista.com>
> ---
> The patch [dmaengine: ti: edma: Add some null pointer checks to the edma_probe] fix for CVE-2024-26771                                   needs to be backported to v5.4.y kernel.

No upstream git commit id?

Please fix and resend the whole series as a new versioned set of
patches.

thanks,

greg k-h

