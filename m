Return-Path: <stable+bounces-135130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 445D7A96CFE
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29F1401105
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF07527CCF1;
	Tue, 22 Apr 2025 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JJHQyKsP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA827CCDC
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328781; cv=none; b=nAU4x8VDJW1Eh/qK/Af3W4DAcMoU4687G7JwK4ZHtLu/KDq0kpUM9sHtie0bx/4RkROHbnMhoeeGCKN92gdyApvAb4YA1vmc3hyr2RyGywfUEi+Za2rdKz9gHHGN8Cadzj2twhmf0thcC9RSQpwabUupCq6p9KLtLBj6l66bDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328781; c=relaxed/simple;
	bh=+ocsDpitN0NZRqhtHqG5YO+sNP1/StE8tsaDBe8XGgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTqXS+C0ZbV1ibVnHjlyi+JqEEeusmpJd8/J3RzWSld5LIdyks/OBABxNt5GiusT2oBkzDPm4hCYeN91X0RA7asLKjBFOli75qGriWYk6u2ooYVcGO/5D+w4mJ702PQZ2SFTTuc9R+g4btL65CVx3ouy0ZKlByquw0024zeDtOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JJHQyKsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2CCC4CEEC;
	Tue, 22 Apr 2025 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745328780;
	bh=+ocsDpitN0NZRqhtHqG5YO+sNP1/StE8tsaDBe8XGgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJHQyKsPRnj7fAl8AtRVnP+/A42fMZTMYg6b0fXYJkz4HBSXot4wrtSQWEdmdCkXG
	 NIfhwvwB29fGLWvmiXC1MY7Rlgr4bu/gdrFVkUmXx4TyMNBvDcWLZkEHHAK2Yo6cJl
	 bbvghjk7mLMVRBRW3wSsZh/fc9vHOmZTUwlDohtU=
Date: Tue, 22 Apr 2025 15:32:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/3 v5.4.y] dmaengine: ti: edma: Add support for handling
 reserved channels
Message-ID: <2025042246-hush-viable-35fa@gregkh>
References: <20250416064325.1979211-1-hgohil@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416064325.1979211-1-hgohil@mvista.com>

On Wed, Apr 16, 2025 at 06:43:25AM +0000, Hardik Gohil wrote:
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
> 
> patch 2/3 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.10.235&id=2a03c1314506557277829562dd2ec5c11a6ea914 
> patch 3/3
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=c432094aa7c9970f2fa10d2305d550d3810657ce
> 
> patch 2 and 3 are cleanly applicable to v5.4.y, build test was sucessful.

I'm sorry, I have no idea what to do here :(


