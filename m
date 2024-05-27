Return-Path: <stable+bounces-46296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3487F8CFFC0
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C72A1B20B7C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A4A15E5A9;
	Mon, 27 May 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q3sP9eQC"
X-Original-To: stable@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535715EFC4
	for <stable@vger.kernel.org>; Mon, 27 May 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812107; cv=none; b=SaQ/rLxZDBUv/O407JgULh/cgX6DJzLP0BOT7ZA/ncy1/p/W3N2KRuRoDdtJyiQepFnbpBabDWItvZo4yIMZBIuqiICa5h7+be0WxcWIGNVynVSunAWXuNC8Dad47/it6Wcz4NqSTDY5Z8QH9yPYT7S6Q0gckVc7AjDtBz7bgeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812107; c=relaxed/simple;
	bh=mZMsHhAPxFIsqYR952uJxt0Nn4Pt46OSj2/cT4cri3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DF0hlEePGHvSa3nWf75EokFrEcsWjnIrLjTgEcqo91YbnGZhFh5hWSddHDj3euaHC60POY9PLzd6zktjuShn4/leN3e+vs/o5IOhUwOqTtnaS0FgqgBAmWvaoqU25k+huI4kXiL+XK0E7JjqZWiTM4C3OnXhP42CuG1+LZaR/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q3sP9eQC; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7915460007;
	Mon, 27 May 2024 12:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HDTmRRXuN9QOiag5lhJ8j7FE52vEtHWkBxLBSHfYwSI=;
	b=Q3sP9eQCk5J3Pk72WWYPhS9H5SoRZJzfNYMhb27TjZLeklmSPTCpueTwgty/SQWxPpcVJK
	9VpxeZYLgvXfMhTpz4g1GZIPvEAaXiXuUEsx2IVEBaH1KrweTb2kiqy3AU/oX4QINk4vIM
	t3dEummnMtRLAUXaZfVmEHC1Ud1Boc91Qex9BYr05hxWIyhxeSngV7gbApTIGCX1Zr5lgr
	icZ+lo+/RIP3huDLHgEDrdqQ0h/MIE41Kl3IBvR3L5dwDCaAsJUomhuiPwk6JnYN9pKHua
	Yc2R6jLGQbbE59HAavlTAu6U+4LDWR2h0s7TbRnj3oRsVH5vDxvd5gLGEicE9A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org
Cc: Alexander Dahl <ada@thorsis.com>,
	Steven Seeger <steven.seeger@flightsystems.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mtd: rawnand: Bypass a couple of sanity checks during NAND identification
Date: Mon, 27 May 2024 14:14:56 +0200
Message-Id: <20240527121456.29738-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516131320.579822-3-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'8754d9835683e8fab9a8305acdb38a3aeb9d20bd'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-05-16 at 13:13:20 UTC, Miquel Raynal wrote:
> Early during NAND identification, mtd_info fields have not yet been
> initialized (namely, writesize and oobsize) and thus cannot be used for
> sanity checks yet. Of course if there is a misuse of
> nand_change_read_column_op() so early we won't be warned, but there is
> anyway no actual check to perform at this stage as we do not yet know
> the NAND geometry.
> 
> So, if the fields are empty, especially mtd->writesize which is *always*
> set quite rapidly after identification, let's skip the sanity checks.
> 
> nand_change_read_column_op() is subject to be used early for ONFI/JEDEC
> identification in the very unlikely case of:
> - bitflips appearing in the parameter page,
> - the controller driver not supporting simple DATA_IN cycles.
> 
> As nand_change_read_column_op() uses nand_fill_column_cycles() the logic
> explaind above also applies in this secondary helper.
> 
> Fixes: c27842e7e11f ("mtd: rawnand: onfi: Adapt the parameter page read to constraint controllers")
> Fixes: daca31765e8b ("mtd: rawnand: jedec: Adapt the parameter page read to constraint controllers")
> Cc: stable@vger.kernel.org
> Reported-by: Alexander Dahl <ada@thorsis.com>
> Closes: https://lore.kernel.org/linux-mtd/20240306-shaky-bunion-d28b65ea97d7@thorsis.com/
> Reported-by: Steven Seeger <steven.seeger@flightsystems.net>
> Closes: https://lore.kernel.org/linux-mtd/DM6PR05MB4506554457CF95191A670BDEF7062@DM6PR05MB4506.namprd05.prod.outlook.com/
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes.

Miquel

