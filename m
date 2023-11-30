Return-Path: <stable+bounces-3574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C3F7FFD30
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 21:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA79B21149
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 20:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1C54675;
	Thu, 30 Nov 2023 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2C71708;
	Thu, 30 Nov 2023 12:58:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6459D63434F3;
	Thu, 30 Nov 2023 21:58:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id wHy7eT70_uv9; Thu, 30 Nov 2023 21:58:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id ECE826342D40;
	Thu, 30 Nov 2023 21:58:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QLLCiiJfXUQa; Thu, 30 Nov 2023 21:58:37 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id C86C96342D3F;
	Thu, 30 Nov 2023 21:58:37 +0100 (CET)
Date: Thu, 30 Nov 2023 21:58:37 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown <broonie@kernel.org>, 
	linux-spi <linux-spi@vger.kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Ryan Wanner <ryan.wanner@microchip.com>, 
	stable <stable@vger.kernel.org>, 
	Richard Weinberger <richard.weinberger@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>
Message-ID: <1578539475.50621.1701377917637.JavaMail.zimbra@nod.at>
In-Reply-To: <d4ffca97-bb5d-4c42-a025-69b308c24f82@raritan.com>
References: <20231127095842.389631-1-miquel.raynal@bootlin.com> <a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com> <0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com> <20231129094932.2639ca49@xps-13> <723263313.45007.1701348374765.JavaMail.zimbra@nod.at> <1192504136.46091.1701368767836.JavaMail.zimbra@nod.at> <20231130211543.2801a55b@xps-13> <d4ffca97-bb5d-4c42-a025-69b308c24f82@raritan.com>
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any
 signal
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: atmel: Do not cancel a transfer upon any signal
Thread-Index: 9RzQc9560ZsBY6W1TBZkC6rc/eYBpw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Ronald Wahl" <ronald.wahl@raritan.com>
> I think yes. But the only thing the FS can do is stop any writes from now
> on which is not a useful consequence of killing a process.

Exactly. If I understand the spi code correctly, now an *unprivileged*
user can abort a file operation on UBIFS and UBIFS will switch to read-only=
 mode.
...which is pretty bad.

Thanks,
//richard

