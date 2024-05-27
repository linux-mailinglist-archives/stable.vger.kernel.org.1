Return-Path: <stable+bounces-46297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5F78CFFBF
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFAB1C2174C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 12:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9708115EFCF;
	Mon, 27 May 2024 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WR5qzrYZ"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F313B7A9
	for <stable@vger.kernel.org>; Mon, 27 May 2024 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812108; cv=none; b=jpb7/d7cKJjpTzvty2stgTW8zzRkFflqyVEZ02zVPPNJ0JGx1E44vyHdviN24YWtzo5365sLov2lvjN6tIRSsZ94SBYY+3PqS2KajLf43wv7+nJ6d3Vx06PicXDnQPpk8NcQE0HpsIg+2a3syHfs8+MZLlUiUnTO1kc/hQlNsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812108; c=relaxed/simple;
	bh=XPn0sdQXnroBKOAU96Hx3ykV61ZKbF2LKKLQXgz1d70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGRfHEhVBc0ziMkMppLRL+Es/O9DMVF8SOKzu0Ey43ciDjxPCttEJwTYj1YqInCF62QtuNrfJV3QXKU4b1DuJEXLNXZD37k2AP7SqetK1RpuG8BF4wMBw3p3A4Q5D3/q1M8zVYslpxUd5emhWXzmPFuWJ33lJ+qSQc3pBUYEoic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WR5qzrYZ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EDC9FF806;
	Mon, 27 May 2024 12:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycfn8V0TO+0cAWPu0IIelsCn5K2PufFE56/wIItVhVs=;
	b=WR5qzrYZ+FJtkM9EfQGTWaCz/RdiUWlsx+mC+Xqi5c/XiuJfHb8WjSnbR7DcLKFtEF1R8V
	Up3IzNtko4qOU0jR4+qtvVZLE0nPtIRQajRuIgAx4jPt+XGZnc0lamW6MNedJK++rhtBJw
	tJ1k6aoz02mGLEvYONFhqU7IhjTu8IiiwrSf1z53/xLqOAhFLUUw3qn20cGtYaE1v5HKKd
	TYqJQqMgHdhqBVRw3tE75YwfYa0eeXF3s3AREg1DaWJTeq8hcr/Cw4sMiHtvFaYzYAaefV
	kjFoei0TxER6V4cQe7oJ2Y7bETlOARjw5V0/w3sNLTXtR0rG2WTI8udxzv1pLQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mtd: rawnand: Ensure ECC configuration is propagated to upper layers
Date: Mon, 27 May 2024 14:15:03 +0200
Message-Id: <20240527121503.29794-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240507085842.108844-1-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'3a1b777eb9fb75d09c45ae5dd1d007eddcbebf1f'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2024-05-07 at 08:58:42 UTC, Miquel Raynal wrote:
> Until recently the "upper layer" was MTD. But following incremental
> reworks to bring spi-nand support and more recently generic ECC support,
> there is now an intermediate "generic NAND" layer that also needs to get
> access to some values. When using "converted" ECC engines, like the
> software ones, these values are already propagated correctly. But
> otherwise when using good old raw NAND controller drivers, we need to
> manually set these values ourselves at the end of the "scan" operation,
> once these values have been negotiated.
> 
> Without this propagation, later (generic) checks like the one warning
> users that the ECC strength is not high enough might simply no longer
> work.
> 
> Fixes: 8c126720fe10 ("mtd: rawnand: Use the ECC framework nand_ecc_is_strong_enough() helper")
> Cc: stable@vger.kernel.org
> Reported-by: Sascha Hauer <s.hauer@pengutronix.de>
> Closes: https://lore.kernel.org/all/Zhe2JtvvN1M4Ompw@pengutronix.de/
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes.

Miquel

