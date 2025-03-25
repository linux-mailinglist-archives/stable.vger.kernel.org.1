Return-Path: <stable+bounces-126567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017E8A7025B
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60141189E30D
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7102C1DC9A2;
	Tue, 25 Mar 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agVramHM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A681732;
	Tue, 25 Mar 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909596; cv=none; b=s1JSHh8OntY0m4Nqlpg05v0hw3qpIqBq70rMC6ms0JU/vmnxLpoBtYil+1URbZghP+WVTZEqc+8L0+/QCD/ckK2xYHaB4GP33pQrCoPmWi63EJZXdjbPaNjVr/0OdhWmPTYgVsRyN1+/tjEMokDURsxAbeU1hb/VxyTKUDMhfgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909596; c=relaxed/simple;
	bh=UjX2RfNQ/VRIIJXNNKCUw29i1T0PQOAe9QlnPpWUqy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJpeQIATRoxl/V1wJWcsDnURb4xy2NEZAFtWGxcGpqt9lpBd/16rrEUBrK7p7GRXY25tvS9YKYM0Z2hLbqGbeA/ieLOiRk89yk+L2iawFOz/KPidikHMrxvtMl2Fo+i/psQL34D+ChsIbI+/f5zbOLIbJJpybyEVVyNhxI975F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agVramHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59FFC4CEE4;
	Tue, 25 Mar 2025 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742909595;
	bh=UjX2RfNQ/VRIIJXNNKCUw29i1T0PQOAe9QlnPpWUqy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=agVramHMhROTTc3Ff18vUmGKMkJl26P/zi/+hOjd/IwrOxATHM7Oi5N7eGIWuOC/k
	 p4E5Sywk7zaIUcOXVESIsFDB/Sly2Ai45ZsP6Htl9rsdBrJaEC9khjFpHLmoQFqCkz
	 8TwYWAFX3hhNdiZnh+yD6PMelLNElfig9JWxpzgYKjXkEIfJ7J7G08NVIlNlSv96up
	 +3o/9IRmCtln+CvdeAx9KqkCHPbz+p9BS9eTIWqZYYv0NkfVDy6JhoPKF0Ja58Fcs6
	 YAR8BdA0dhRmw9XKmPkQx4aVXqSZpFiKYk+0UCfwcJ6Aqr8cMxkoycsbkU4/beTZpg
	 cvZ01qKqfd2kg==
Date: Tue, 25 Mar 2025 06:33:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot
 <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/4] net: fix uninitialised access in mii_nway_restart()
Message-ID: <20250325063307.15336182@kernel.org>
In-Reply-To: <20250319112156.48312-2-qasdev00@gmail.com>
References: <20250319112156.48312-1-qasdev00@gmail.com>
	<20250319112156.48312-2-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 11:21:53 +0000 Qasim Ijaz wrote:
> --- a/drivers/net/mii.c
> +++ b/drivers/net/mii.c
> @@ -464,6 +464,8 @@ int mii_nway_restart (struct mii_if_info *mii)
>  
>  	/* if autoneg is off, it's an error */
>  	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> +	if (bmcr < 0)
> +		return bmcr;
>  
>  	if (bmcr & BMCR_ANENABLE) {
>  		bmcr |= BMCR_ANRESTART;

We error check just one mdio_read() but there's a whole bunch of them
in this file. What's the expected behavior then? Are all of them buggy?

This patch should be split into core and driver parts.
-- 
pw-bot: cr

