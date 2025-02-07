Return-Path: <stable+bounces-114250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BFAA2C393
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 14:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2820916B036
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EAD1F418C;
	Fri,  7 Feb 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OoZpBxZV"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3351F1505;
	Fri,  7 Feb 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935009; cv=none; b=MmNfHiO5UPSvgrHGTblBOujAeaNvCDzRipqHSGWcoheU3qXWtLXx6IVu78IS2VMnSkb6oduvhwZLCHEaeaKbObquiT4/PbkwjTDOqOREzU8Y5HyU8TIsHiUmKSWA8UEAe/ynZ0K+PuCTVS70YT66RjVkZedBu1ZGK2D9Ar8KQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935009; c=relaxed/simple;
	bh=bKUuRClkZe1XnXxLTPyQ6tscMqQy1rs3PGNwX1eXlH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgweZeUlFNu6qieel2K6Dnu3Ie5S17wfGZ2PqDBu1txnhZuhTWKjVpUCTK76t4Jw+N23WVDlKQ05v3sLW4CLeTFjggaKN9clHxTghFPZxFBby12QR3STxzJEHT+pWVFqvE1wlhTqLXdtdWdX78H2rQFFgnkTs6CXKpUf6Qlp24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OoZpBxZV; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7B1D442F5;
	Fri,  7 Feb 2025 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738935005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uLJEtoS2PPJFMr0I1tAyocsm8P41/TMCB7vqODm0mU=;
	b=OoZpBxZVH/MaCQGmcz4JeZqJ48Oqd3LrSrTxiEnH0uO9644BdWBqRtn6n0Po58+Fu4amN0
	9bPks+EnjQIvq3wD4XxW2cxFKbMsDIWEwkA909n5rmpr5Ei5RIBdaZU7GUexzRQJ/J3AWG
	BH6BimoOaVQNFxGTsv1m65LeCDF+0G5FxUDq2+y034cUmUMlXrKLTEmWrFlme3eC1e0Ehp
	B5L1IHtZJXS/dBqZrIhdaSO4RJH4ssqOZKO4GOgub9I1Uv5PB5R4Ni5M5dUMHaoODFaCgo
	V6EEHxvUY9E8hGGTmHW6JHt0DXkS+ATUCf46+WzfEd2xk9r4TLw+hK1/HWQPeQ==
Date: Fri, 7 Feb 2025 14:30:03 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, Tony Lindgren
 <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Tomi Valkeinen
 <tomi.valkeinen@ti.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH] backlight: led_bl: Hold led_access lock when calling
 led_sysfs_disable()
Message-ID: <20250207143003.1c518df3@bootlin.com>
In-Reply-To: <20250122091914.309533-1-herve.codina@bootlin.com>
References: <20250122091914.309533-1-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghltheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhinhhgohhohhgrnhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvlhhlvghrsehgmhigrdguvgdprhgtphhtthhopehtohhnhiesrghtohhmihguvgdrtghomhdprhgtphhtthhopehprghvvghlsehutgifrdgtiidprhgtphhtthhopehtohhmi
 hdrvhgrlhhkvghinhgvnhesthhirdgtohhmpdhrtghpthhtohepjhhjhhhisghlohhtsehtihdrtghomh
X-GND-Sasl: herve.codina@bootlin.com

Hi Lee, Daniel, Jingoo,

On Wed, 22 Jan 2025 10:19:14 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> Lockdep detects the following issue on led-backlight removal:
>   [  142.315935] ------------[ cut here ]------------
>   [  142.315954] WARNING: CPU: 2 PID: 292 at drivers/leds/led-core.c:455 led_sysfs_enable+0x54/0x80
>   ...
>   [  142.500725] Call trace:
>   [  142.503176]  led_sysfs_enable+0x54/0x80 (P)
>   [  142.507370]  led_bl_remove+0x80/0xa8 [led_bl]
>   [  142.511742]  platform_remove+0x30/0x58
>   [  142.515501]  device_remove+0x54/0x90
>   ...
> 
> Indeed, led_sysfs_enable() has to be called with the led_access
> lock held.
> 
> Hold the lock when calling led_sysfs_disable().
> 
> Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

I didn't receive any feedback.

v6.14-rc1 has been released since the patch was sent but the patch applies on
top of v6.14-rc1 without any issue.

Of course if really needed, I can resend the patch. Just tell me.

Best regards,
Hervé

