Return-Path: <stable+bounces-87045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 539B39A6107
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2EE1F23CCE
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C601E4113;
	Mon, 21 Oct 2024 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IccWz6Li"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E21E47D0
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504953; cv=none; b=Gxl+fW1WaL0EI3Y8hA3N0+cMX+g1zMjP6e1b54ody7nq1SkV8BwE52ArbAG6JFzTExCUfOmJXhZCV0wv2TUpJh1q/bb7JRzlzGafWz9I0NS5I0xzOLtF5BMjsPBPQkwV49qNbA8cgvIWaiGCicqCrnJz4qTE3DZXOPcE1naQ0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504953; c=relaxed/simple;
	bh=8YFGTQzPW0Ym88bknSjqt+2GQ3iq1CXghgt48PNtB3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVGixY4R4Zfga6BMA/hYjT4o2NbR5FcaBQ9+u4KllVDZ+nzf3FdRSfGE87RUqJW28DBTBSOF/hettsL2WkJE+RD2hS2MQ9kY9KRJN4k2vgEfYeEvnAGgbFjtgpqJ0pzmzlIl8vYzOIbN2x3pnuXH2RY8jSmvsjzMxOmI/YkYXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IccWz6Li; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6B53AFF80B;
	Mon, 21 Oct 2024 10:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729504949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmFNbYry4fYR0yOVynMut4LpTiSFqticxBBNXk964So=;
	b=IccWz6LimGSApIO83TyexwmEH4wiL/30JVpMj7tUNegF+0J2RCDFKXpzCTpOlZxX/K9Kup
	ReHIGPF3el9FFjucGsi/ksA7X0SNHCIaILAIs489STsLx+QaL1uudZtjga9XR6xRWvVovr
	5AqMFPH5Dj3YbD0YVLQgfCgLexBwpQPUjuq1r9zunU5v7Xj6xazQUdhj2GqSBegZAqEhnK
	v++lC2BDLMlhmFwhaOn3fEvf2Zsnn1yasLJT5TKiGbPMbPgC6i8Hw6NgIvHAuB65Nm1Ea+
	cCRneKRCs0YfAer4Y/6znaxPeqyBjKY9cmToAmiPpbnM82Ddsj8jHgeguN2dew==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org
Cc: Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sridharan S N <quic_sridsn@quicinc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] mtd: spi-nand: winbond: Fix 512GW, 01GW, 01JW and 02JW ECC information
Date: Mon, 21 Oct 2024 12:02:27 +0200
Message-ID: <20241021100228.173306-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009125002.191109-3-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'fee9b240916df82a8b07aef0fdfe96785417a164'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-10-09 at 12:50:00 UTC, Miquel Raynal wrote:
> These four chips:
> * W25N512GW
> * W25N01GW
> * W25N01JW
> * W25N02JW
> all require a single bit of ECC strength and thus feature an on-die
> Hamming-like ECC engine. There is no point in filling a ->get_status()
> callback for them because the main ECC status bytes are located in
> standard places, and retrieving the number of bitflips in case of
> corrected chunk is both useless and unsupported (if there are bitflips,
> then there is 1 at most, so no need to query the chip for that).
> 
> Without this change, a kernel warning triggers every time a bit flips.
> 
> Fixes: 6a804fb72de5 ("mtd: spinand: winbond: add support for serial NAND flash")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next.

Miquel

