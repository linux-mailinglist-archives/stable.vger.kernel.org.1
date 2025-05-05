Return-Path: <stable+bounces-139685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6967DAA9411
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69856188E302
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8CB256C62;
	Mon,  5 May 2025 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G9MyYjjd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46920204592;
	Mon,  5 May 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450629; cv=none; b=khBR+mHavxtiUw68rkAqmP42kSst+QP1w/NXbMTwLGvNjRM/iCZLRlJAuJlBjBqEu4QvRuuO76S/LAR2vsZg2AteJDftrnr+nLDTpMXJmKC7mGLX7FKP3+IIofz8yTUZQ2D+0K4D4zimkUN1Nv5teN6ynXMOE6R53nhN9CYOHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450629; c=relaxed/simple;
	bh=zuaVkHIzYNlAKf5VzbBjzQDmx4Dhb53JHSmDopwVB1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs+qPGdWA4AyGUav3HF6QYg/gSqb4hJa1yCsw4RlIZ/DQSsx9Cl9GIu/bHHhF8tb+LtJJ0mcMVJdClF3QMQSHIK3oNER0HjG9SyCHHT22PqNfOS35hRG9HkbK7xdVr5IKRCXsKoKyw/mjw31lYAwOKFAvEdEdWs90fK/rg0C8PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G9MyYjjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455FAC4CEED;
	Mon,  5 May 2025 13:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746450628;
	bh=zuaVkHIzYNlAKf5VzbBjzQDmx4Dhb53JHSmDopwVB1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9MyYjjdoTp3KU3D3vY1aPUfgTV0uXFu3iFnBgoKrSUgePiS0rvi+yPZ4+E4MMG48
	 C4PUt864zmTGSGe9wtrWziugOiWxbr8G0AaJzdrhimEipcuobtpfRlovZxr44b0NSc
	 ngz3SCcA6vEJcN4Y75PAnY1ZSCv7LWi1d+5y/B9g=
Date: Mon, 5 May 2025 15:10:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: linux-stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: Please apply to v6.14.x commit 6eab70345799 ("ASoC: soc-core:
 Stop using of_property_read_bool() for non-boolean properties")
Message-ID: <2025050556-blurred-graves-b443@gregkh>
References: <7fb43b27-8e61-4f87-b28b-8c8c24eb7f75@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fb43b27-8e61-4f87-b28b-8c8c24eb7f75@cs-soprasteria.com>

On Mon, May 05, 2025 at 11:48:45AM +0000, LEROY Christophe wrote:
> Hi,
> 
> Could you please apply commit 6eab70345799 ("ASoC: soc-core: Stop using 
> of_property_read_bool() for non-boolean properties") to v6.14.x in order 
> to silence warnings introduced in v6.14 by commit c141ecc3cecd ("of: 
> Warn when of_property_read_bool() is used on non-boolean properties")

What about 6.12.y and 6.6.y as well?  It's in the following released
kernels:
	6.6.84 6.12.20 6.13.8 6.14

thanks,

greg k-h

