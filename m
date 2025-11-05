Return-Path: <stable+bounces-192538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7143C37303
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 18:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364CE661D70
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F67220ADF8;
	Wed,  5 Nov 2025 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kUMlPEXb"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A549026E6F9
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363919; cv=none; b=mZhfTonTuBeZg8W5IYwdOChhkuLIrpeOnaPRKhaq+ynLFup4Jh0sE5xxfa7cjbZCdmvRTsKMcHEJ71sJojjMTKlcD4JD/rUtXTqnqW9FfT4+av1EW6iT6Al0w2VE7l41bePbZXRsNC8pxXWWXHH8EuPjZdmsV2kbPpDryKu0lOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363919; c=relaxed/simple;
	bh=6DsMjnjPhm3brsPt9ZCGpGkglGjc7zDVL11qn07tX8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mx1lzzwtlsOEWa4fM80EPUWJyABWYli1ABwcvWGplx/sZ+TajPbKgfxABJDCX6I4FJfLTjTX2CpysJUDH6EnWfzb8/e+/slt5B28JPxtc2pq8BiZ55h/NcVNiEfIaYnXFR38PfCDMh+J6F5oIHma//J6/eQH5Gj7E2avTjVZDWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kUMlPEXb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 24B564E4153C;
	Wed,  5 Nov 2025 17:31:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E550D60693;
	Wed,  5 Nov 2025 17:31:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6B97410B5046F;
	Wed,  5 Nov 2025 18:31:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762363915; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6DsMjnjPhm3brsPt9ZCGpGkglGjc7zDVL11qn07tX8Q=;
	b=kUMlPEXbYh8t1eG6isMDEM8WHOEMkx7ruwtDrHj5hF4Lj5KSce+BixtSgx4LI3k67zfiUi
	x/Ml5kb5FOsm9bDqBigIvdohD2b7m4WRd2WIJSZHpICQjnzsguW0pNh9oRlQziasSvgrOS
	AVG5uXQauQQQOCLi1BNgsHX4kD9TwvFWJQO4bD5eP3u89cZR3Lmeib/E1QBLK2MUDwlw0T
	0Sc2Ox0jENuYfv9NBPQK7p+C+zdHeUG2+rSyTuq6RZO6DdACEAKmuL7wUZUfulhp2B6XAF
	pF84g5x35rLKtTfVr6KvgEAFPYCnbCkqnccreY6YI3go66fenguyUOjPYNRo6A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Steam Lin <STLin2@winbond.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH 0/6] Hello,
In-Reply-To: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
	(Miquel Raynal's message of "Wed, 05 Nov 2025 18:26:59 +0100")
References: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 05 Nov 2025 18:31:53 +0100
Message-ID: <878qgk9yie.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 05/11/2025 at 18:26:59 +01, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> Here is a series adding support for 6 Winbond SPI NOR chips. Describing
> these chips is needed otherwise the block protection feature is not
> available. Everything else looks fine otherwise.

[...]

Sorry for messing up a bit the cover letter, I didn't pay enough
attention my first line got taken by b4 as Subject and forgot to put a
real title.

Subject should have been:
"mtd: spi-nor: winbond: Support for chips with block protection capabilitie=
s"

This will be fixed in case we need a v2.

Cheers,
Miqu=C3=A8l

