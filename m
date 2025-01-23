Return-Path: <stable+bounces-110297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AA7A1A7C7
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDF8188C8BD
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B61F212B06;
	Thu, 23 Jan 2025 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OVdQG0EY"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE521C5D4D;
	Thu, 23 Jan 2025 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649377; cv=none; b=sdtZqZRd4dwvIec6ZjS5yB/rBc0c9nR8TlMD5YTwBkXoM4dRoybxGQrDthIsxKzutVrLFZMfzE4oJsHzvTw1c/7NiIp+e7AkPSZHIpXITH6sKSJt+s+KBsBEneNIQTXUN8qIdhffU799uJa9dI/N/qI0QrLZ9xXja7QBIEH0D0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649377; c=relaxed/simple;
	bh=N6HZrAsYICGN9MzebeZPm2VLnTBchujah17HfU33zjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOF3s8XdpnqS8Xc4QsJyPDA4yIH0UEcuXNVigtEV9VMh/1YMjXqNt2gCgv3irPqcNIim818CW9tNayNomkUV3ExQmzx0EaKulWYjxUnbJ1HCSqbGJ5NWPolOdv1q1Nzw+FaWsaK0Js7ZJUM3OgNTtGK6+8SIoTIGmwAAyARx3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OVdQG0EY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737649370;
	bh=N6HZrAsYICGN9MzebeZPm2VLnTBchujah17HfU33zjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVdQG0EYhyJoVMggmIPGVJN5Kz1UNA8Vd9HJ4dFpeKJ1liSRMc0efxIpxSLpkR8p+
	 0P7x3WDUSNboHWlpUe7Nr6taiXVz98XIqgkUHuClYOuxZAd8z+Yh7vMW5DovyY+IK6
	 qfV8x8MND8+WBwTpTeV74XB9E59zgCFBMfSz7slg=
Date: Thu, 23 Jan 2025 17:22:49 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Arnd Bergmann <arnd@arndb.de>, 
	Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Anna-Maria Gleixner <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>, 
	Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Cyrill Gorcunov <gorcunov@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] posix-clock: Explicitly handle compat ioctls
Message-ID: <82861179-dfd5-4330-86cb-048d124487b0@t-8ch.de>
References: <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>
 <603100b4-3895-4b7c-a70e-f207dd961550@app.fastmail.com>
 <Z5Ebh4pbOUGh64BS@hoboy.vegasvil.org>
 <0ecf1a72-d6ae-46ab-ad20-c088c6888747@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ecf1a72-d6ae-46ab-ad20-c088c6888747@app.fastmail.com>

On 2025-01-22 18:15:13+0100, Arnd Bergmann wrote:
> A simpler variant of the patch would move the switch/case logic
> into posix_clock_compat_ioctl() and avoid the extra function
> pointer, simply calling posix_clock_ioctl() with the modified
> argument.

That would work, but be a layering violation.
Or a "compat_mode" argument to ptp_ioctl()

I'm fine with either approach.


Thomas

