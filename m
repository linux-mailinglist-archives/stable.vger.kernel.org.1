Return-Path: <stable+bounces-172705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA22B32E67
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 10:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C5FD4E2409
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AABE25E44B;
	Sun, 24 Aug 2025 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0d+Vw/zI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11525BEF4
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756025138; cv=none; b=fdf9GN/qLVcYn4EqV7QBt1uO0IVbzmryIejPwatL38rdCMIBe1AvaEdgLYnf9e2S6kUpT1D0sdoaG4bE/MhaqvnPxCT4gF8HkYR3qcbH6uGV2fLal2esy6Khk14XIuzDm7jp2rouY5wCXeROcXhoOOR8/4vCJMz+UUjX8XT1BZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756025138; c=relaxed/simple;
	bh=J7wTPt4ppJNFIk2BNIc6tg7ymkHsYYRmsUbZz2/Zd6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/6MVcdEEORCu6vbSggg7qXN7TjFBz1cwNxsZ7LREyph3I7IpETCdQSxZb0dCv4Y8W8eTHgKdq9p0ac40TFGzCwchKXTusZjnJkfNT185J7zvgYQ5iCLjrB0jo5o/stS9BmuLgleZ7rxGaak53su5sbhPPOhhMphTYm4qvNYdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0d+Vw/zI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AA7C4CEEB;
	Sun, 24 Aug 2025 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756025138;
	bh=J7wTPt4ppJNFIk2BNIc6tg7ymkHsYYRmsUbZz2/Zd6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0d+Vw/zIY7oabQCPUTqNm1gWidcheqfRGUALzVy48cm7daecF8GEzYh2dIW02RVBD
	 2KHaLa1wzJ6Yryw3AreejYdMNFhFBDL/r//BdhrnIKNsExvbVY/AC8A4V9zz4IqwmZ
	 oE86McSnO0+rOpHqRG+apxx83YNcTxDzaXKow69U=
Date: Sun, 24 Aug 2025 10:45:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH 5.4.y] net: usbnet: Avoid potential RCU stall on
 LINK_CHANGE event
Message-ID: <2025082429-unholy-sprung-75cb@gregkh>
References: <2025081259-headset-swinger-4805@gregkh>
 <20250813134932.2037778-1-sashal@kernel.org>
 <20250813073802.3f28d69c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813073802.3f28d69c@kernel.org>

On Wed, Aug 13, 2025 at 07:38:02AM -0700, Jakub Kicinski wrote:
> On Wed, 13 Aug 2025 09:49:32 -0400 Sasha Levin wrote:
> > From: John Ernberg <john.ernberg@actia.se>
> > 
> > [ Upstream commit 0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f ]
> > 
> > The Gemalto Cinterion PLS83-W modem (cdc_ether) is emitting confusing link
> > up and down events when the WWAN interface is activated on the modem-side.
> > 
> > Interrupt URBs will in consecutive polls grab:
> > * Link Connected
> > * Link Disconnected
> > * Link Connected
> 
> Be sure to pull in 8466d393700f9cc into the same release.
> This change broke Linus's laptop.
> 

Thanks, now picked up.

