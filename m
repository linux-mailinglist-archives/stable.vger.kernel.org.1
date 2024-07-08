Return-Path: <stable+bounces-58193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 861F8929CAA
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 09:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41617280C59
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 07:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6DE1CAA6;
	Mon,  8 Jul 2024 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="csnDubFD"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95780182AE;
	Mon,  8 Jul 2024 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422115; cv=none; b=ad5CLmSLrlmKpAUSQipYzeagSkOEOggZqnS2YDJJ605vxOZAPg9jqP87GyFc4ocIs8uoVBjeQ0udqtBGSnnNhzKNYbMezC/e6Gj25+XLJ6EVkF+hKRpis9RBRdn91top5h4uaITPHPa2CPLKeopZYWwkxd80kPgpdJPxJpMm+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422115; c=relaxed/simple;
	bh=UwwuUSuo2D6/dt6MqiW1z0OObhU6shNIC63QWSIFu7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWIv3A9/I4QhAi4H5bNmzlBwW6eiNrfbFfJPaHf2XIiJdkWQshDrIuvI+3GKSEazHbLbUJ7t2+EIE1qSCjVhcHSj8tph7t3gmScGFbdW/3MY8tOHh32sKC+KTuhT8lbyl+jrb2n9k6FN3DtmjJgY831I9ha/IZ11LchMRR7l1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=csnDubFD; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68E841C0002;
	Mon,  8 Jul 2024 07:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720422106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFyhUQfDWH2BkI3PZl+BB8bptYesbh+J9oIuRZIQ3+Y=;
	b=csnDubFDvkPISyceGvrqdlxbuax7LfjnBvSwBCZIVZ2Bxzx1nbRCMLzV2cfRFTcvcgoMoS
	160VjK8L2pogbqOcIoH0+rZvjxx/z70M36+8OWVwh6ivxior4c7pEnySrkrvSz7RnPbeRk
	a1LKS2zVqAGX/eTJU93s5cv9nHVsjHnGMMl318U/tWVu9Ak6GLx9qvgbRrmk9eiH0Q4+4B
	X8Z0VqjFKuAFq2zt3P4B2xglPp/FfNB/dfxLDEOvpwwr7gO6+cwuVlCKaxlTjj3+cIxTZv
	qTbrBXbZFRXl2IbKTCT8wsVqZ7oBfY4OggevI9HURM4Zo4B+shwE78DqIqRCBg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	miquel.raynal@bootlin.com
Cc: stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yangtao Li <frank.li@vivo.com>,
	Li Zetao <lizetao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] mtd: rawnand: lpx32xx: Fix dma_request_chan() error checks
Date: Mon,  8 Jul 2024 09:01:44 +0200
Message-Id: <20240708070144.12186-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240705115139.126522-1-piotr.wojtaszczyk@timesys.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'5f713030117a12b0239e604c163e69af58bb0b63'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-07-05 at 11:51:35 UTC, Piotr Wojtaszczyk wrote:
> The dma_request_chan() returns error pointer in case of error, while
> dma_request_channel() returns NULL in case of error therefore different
> error checks are needed for the two.
> 
> Fixes: 7326d3fb1ee3 ("mtd: rawnand: lpx32xx: Request DMA channels using DT entries")
> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> Cc: stable@vger.kernel.org

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

