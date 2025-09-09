Return-Path: <stable+bounces-179137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29DFB5096B
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 01:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785485467B2
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 23:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6821C29346F;
	Tue,  9 Sep 2025 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs8wGUhr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1952D266EFC;
	Tue,  9 Sep 2025 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462207; cv=none; b=dc7urvl4/wdxhyceQm4CYTGK4ErCONkQIyx7xSuQ1abfuFn+W6I2wkKyb8EOAnaNNYB5N0CmOTBtgh0iVO5WAYkY2aDgPu4mLstjQGYV4BEZK/LPGeO8eAwoDxoe0YbFND1splmtmWQ7GK/qGV7Lg+8JwuLyRjuPjNjr1QbuI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462207; c=relaxed/simple;
	bh=RtMtg9jTo0dPnCXR9Ongd8bypezQi/dR6SjGeueSbhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tejjuxHP/5R2YyD9JNHe2BopkFFue9Z2xLc1hQzd1iR32aJ6h0uxec1+bU4nvsr6KkQLPwJclNzCCr5LXJCtfBbmZxdgzirlE2vSAd9MJ03adcYFlq6IAnlaGvxpDWrRfvFo9SJ6H9+m54n1XAl6KDCc4RzjV3WBU7Ic4LvKt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs8wGUhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CFBC4CEF4;
	Tue,  9 Sep 2025 23:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757462206;
	bh=RtMtg9jTo0dPnCXR9Ongd8bypezQi/dR6SjGeueSbhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fs8wGUhrX3o0Ej2360sNBrMWJpeOhmM6XmykZSWKWc5rve4fKMLdlYaVcKT1DSosc
	 mCIZXVZmW/CgxdzPx9x8CCYk5/VukqLnVEwN/4b47GzYqg0NCcE2/FxnOWTVFlM+n0
	 626943MC7WnEHmrOxJQ6xRt0KlfsgpxBDB/X0s9zS9IOHkI0BzNW0CvRvwmNtFZ8w0
	 hA5OB909ONlsSiOfhsT1nAEHQ7YO0Zoa+gBnx7Ts1esg/W/snqXXEBlebPWuqZiDHc
	 P/Cv6DG4waKcSPQrLox+e8Vkt1fshQxuf7aa9K63GZA/e3p/2cCicMReIcO9mUXV1l
	 DkDteNlI6CdGQ==
Date: Tue, 9 Sep 2025 16:56:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Hubert =?UTF-8?B?V2nFm25pZXdza2k=?= <hubert.wisniewski.25632@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, stable@vger.kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Lukas Wunner
 <lukas@wunner.de>, Russell King <linux@armlinux.org.uk>, Xu Yang
 <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <20250909165645.755e52f6@kernel.org>
In-Reply-To: <aL_UfST0Q3HrSEtM@pengutronix.de>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
	<DCNKVCWI6VEQ.30M6YA786ZIX2@gmail.com>
	<aL_UfST0Q3HrSEtM@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 09:17:17 +0200 Oleksij Rempel wrote:
> > > Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")  
> > 
> > It does, but v5.15 (including v5.15.191 LTS) is affected as well, from
> > 4a2c7217cd5a ("net: usb: asix: ax88772: manage PHY PM from MAC"). I think
> > it could also use a patch, but I won't insist.  
> 
> Ack, I'll try do address it later.

Any idea what the problem is there? Deadlocking on a different lock?

