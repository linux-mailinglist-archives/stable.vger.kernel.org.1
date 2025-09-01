Return-Path: <stable+bounces-176845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F79DB3E2DF
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 14:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE263B0DF3
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 12:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED51326D65;
	Mon,  1 Sep 2025 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QNTbYNtZ"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11776326D5E
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729589; cv=none; b=nSAsk5Uj9egppFh8DwJuFKyYxIhDQqt6Zr8RJXyBLnp/EmxVZe9jPxU7ez6Ob9oo9IcxfuSC4orQu8yVcqua1cXdsvwd+JdV84qa6G41mrqTnRAGDhAOj3RaO34wu8Ml3b9bLygUccYH+cuwXFEGJvO0IMhzbetBiqaa8ULgGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729589; c=relaxed/simple;
	bh=1BZ6biF1Hq34l5j3qpniKSw2bnZLqivxP5C7A0Go0Hk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EFMAmdsu+8L0v+QPv10jP6Ny08oK2TzJc0qhmUoNqUQFrnztmNRxViB7cUUTt8iNxb8fC4MPNsjwUPBTORdDo6GkCNzL+17wrvjQUHz1KkFBlhC3XQIXf8JTkbCUdqnEzQAK9a/dme02jNd95ki4JUwo2QQYVinef0qgMWp9QVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QNTbYNtZ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 988FFC8F1CA;
	Mon,  1 Sep 2025 12:26:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 72A3C60699;
	Mon,  1 Sep 2025 12:26:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF8801C22C8BB;
	Mon,  1 Sep 2025 14:26:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756729584; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UbSWQH4bFjDPLvG/kct3uB1vklz5zdXrHO0a0fdTay4=;
	b=QNTbYNtZGe/Rez2qkXQ8x/CtwL54EdeCkYpZimpV6z9LZpAAQhzSoQSGHRowQPL65c6YOn
	h5DHmNwb9cdUNlhZ6IsGEWP3Fn+t3tVXZ2b2JGqxwCBuK0n0jFx4Di4OE6OdPZ6iLuFlfh
	5xvvn77xkblzZgAd8R6ssFvDwqvgwRmaYKdd7CuMaKslNGRp6Ynwb3SbPU9gWugcf9U76D
	BQ6R3EIv92iIaUohi40gFILMLcUyX9TvySgtQKv78bfhivWMpHQu1VgXJ/M4CHfqpECzWk
	m5g57zuMiTqNX4CMIhGNvN4y4REkGgcBQ33UsKmcKmniKvUH2ykhoKd20VL+4A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>, linux-mtd@lists.infradead.org, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Balamanikandan.Gunasundar@microchip.com, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250821120106.346869-1-alexander.sverdlin@siemens.com>
References: <20250821120106.346869-1-alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v2] mtd: nand: raw: atmel: Respect tAR, tCLR in read
 setup timing
Message-Id: <175672957665.48300.9426658311064681547.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 14:26:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 21 Aug 2025 14:00:57 +0200, A. Sverdlin wrote:
> Having setup time 0 violates tAR, tCLR of some chips, for instance
> TOSHIBA TC58NVG2S3ETAI0 cannot be detected successfully (first ID byte
> being read duplicated, i.e. 98 98 dc 90 15 76 14 03 instead of
> 98 dc 90 15 76 ...).
> 
> Atmel Application Notes postulated 1 cycle NRD_SETUP without explanation
> [1], but it looks more appropriate to just calculate setup time properly.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing
      commit: fd779eac2d659668be4d3dbdac0710afd5d6db12

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


