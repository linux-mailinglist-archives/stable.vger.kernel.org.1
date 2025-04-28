Return-Path: <stable+bounces-136859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C57A9EFA4
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D6E189CE3F
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E1A20DD45;
	Mon, 28 Apr 2025 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XTaMzyhA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F2F25D531;
	Mon, 28 Apr 2025 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840976; cv=none; b=isfwizI2qNTd69s7Lo3bSDpX9YTfRzlgCP8NZPSvKfLEja1Y0Fyz8r0Rl5orb/QLvgpK22rt6F4hW7c8LS+Ttcihv5tziuTHZ+PNcdEIYtwHK9ftXWCCVJR+OAhe9mRHXb4lAgfNQ5ibVvfSzUTAj3RFJ1b2ZF7pm4HVlG34A5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840976; c=relaxed/simple;
	bh=uqfKM5vMpttVCNrHFvle5LKcmxfpoSowxYv+ROJmjpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvLC3Bx6xRjAJl81n0Fjpa1gaanVKT2GoUn12IWlu/8wugUr8th1Ati4lcfw5bVkddWanAEI5MnZh2Evc2vI5MtWIHb4bHtRt/ZCOQRMwsJbl/8Mv3+H0UILXt6qRiKDzV9veaSbzcQKPdny5hUSB9c2BjL2LIm5p2cm/ZAej/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XTaMzyhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCEAC4CEE4;
	Mon, 28 Apr 2025 11:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745840975;
	bh=uqfKM5vMpttVCNrHFvle5LKcmxfpoSowxYv+ROJmjpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTaMzyhApDrXJRzDxLWc8uwHoiL3J6KpKvYmxK/nJwag/vjWhZjoaoRsta3VO4n9j
	 fxhd38OlgnR7/XMMnJHp9R+ZRWkUTPGiaKhXNBK82ik0IWJ/qWoUV+FcbtFfupKs2a
	 Vps57SsNUyPNHGuMhnLHUFhvdP03UC6gErwWZsfM=
Date: Mon, 28 Apr 2025 13:49:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: linux-stable <stable@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: Stable request: net: stmmac: resume rx clocking
Message-ID: <2025042826-radiantly-rack-2542@gregkh>
References: <ec5cf6b5-a32e-4f98-a591-9cb13a9202e9@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec5cf6b5-a32e-4f98-a591-9cb13a9202e9@nvidia.com>

On Thu, Apr 24, 2025 at 05:56:53PM +0100, Jon Hunter wrote:
> Hi Greg, Sasha,
> 
> Updates to the stmmac networking driver in Linux v6.14 exposed some issues
> with resuming the driver on platforms such as the Tegra186 Jetson TX2 board.
> This is why the suspend test has been failing on this platform for the
> linux-6.14.y updates ...
> 
>  Test failures:    tegra186-p2771-0000: pm-system-suspend.sh
> 
> Russell has provided some fixes for this that are now in the mainline and so
> I would like to integrate the following changes to linux-6.14.y ...
> 
>  f732549eb303 net: stmmac: simplify phylink_suspend() and
>   phylink_resume() calls
>  367f1854d442 net: phylink: add phylink_prepare_resume()
>  ef43e5132895 net: stmmac: address non-LPI resume failures properly
>  366aeeba7908 net: stmmac: socfpga: remove phy_resume() call
>  ddf4bd3f7384 net: phylink: add functions to block/unblock rx clock stop
>  dd557266cf5f net: stmmac: block PHY RXC clock-stop
> 
> I had a quick look to see if we can backport to linux-6.12.y but looks like
> we need more commits and so for now just target linux-6.14.y.

Now queued up, thanks.

greg k-h

