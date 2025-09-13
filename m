Return-Path: <stable+bounces-179503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FE5B561C9
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D95584D4D
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D622F28EB;
	Sat, 13 Sep 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hybZbnTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709126FC5
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776992; cv=none; b=UQ2grX/9cVeqzHrN4S44ekStHT5YmAK+DQn42UisWA+lTd7YIhp6nZiV0G4ETH666g+v1SyRaVqWi996OPDZnwUJsc5owkoT7KUjTHV38lmRamHgwjVF8tp2LDUc/scIEiGpt3WVbh5JqXhsxrnYBbR6071sCpavNrgU1EdzQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776992; c=relaxed/simple;
	bh=gmVDh2+lZAxPURSqfdz3J+brMiZLvmSd0oxGzQalutU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd6ZA2mPVz6VWzmKM+SFi5R9WT4i5pDg7PwMZwSb/TBQr50tJSEJQ8V5FQV+u0FmjxEXVNXVD84PaqSKrDsfDpbE/Ba040lbq66ECiU9dRDtsvPHvEG7gNd8l1Qw8PoknVwrADpk0aDcc39Y1d8a4mOwgqXDNO295yu0XmQ/PF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hybZbnTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3920EC4CEEB;
	Sat, 13 Sep 2025 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757776992;
	bh=gmVDh2+lZAxPURSqfdz3J+brMiZLvmSd0oxGzQalutU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hybZbnTjEv6eggeLTOXDoYiuI2sesEmZVh44fFJg22+CdIMNOGLEAe3ftjSGGKdbB
	 hnQnZyLoa4nYBDOvzZx8sFxxkIy6l0eQnQdszE7BvyWN0v+ogGnXN5KBdkHR2nUM5H
	 uGrsYI2vOzMKQ4wbuefMNt+XKACA2lCLXTxCDC1bAfXlpk36AJ1vnSUvXNvG1KDhCT
	 nqpj0iL8U8JyJnPPjCkTWb3G4caKL9sW/Cg5zpNeBDxDy8DsNk4Pmo2uCWBpO4pUCE
	 IUWpRToS+BODSu/2mAECXWJT/MaJc+OncaojpARHRXZGwCxr+/7P9JV7cekLC9HYqS
	 8/Er9soAEC3WA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Dahl <ada@thorsis.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/2] mtd: nand: raw: atmel: Fix comment in timings preparation
Date: Sat, 13 Sep 2025 11:23:06 -0400
Message-ID: <20250913152307.1415556-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091346-runaround-croon-39cc@gregkh>
References: <2025091346-runaround-croon-39cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Dahl <ada@thorsis.com>

[ Upstream commit 1c60e027ffdebd36f4da766d9c9abbd1ea4dd8f9 ]

Looks like a copy'n'paste mistake introduced when initially adding the
dynamic timings feature with commit f9ce2eddf176 ("mtd: nand: atmel: Add
->setup_data_interface() hooks").  The context around this and
especially the code itself suggests 'read' is meant instead of write.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240226122537.75097-1-ada@thorsis.com
Stable-dep-of: fd779eac2d65 ("mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index a54ad340f1e25..2610460cd288c 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1312,7 +1312,7 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 		return ret;
 
 	/*
-	 * The write cycle timing is directly matching tWC, but is also
+	 * The read cycle timing is directly matching tRC, but is also
 	 * dependent on the setup and hold timings we calculated earlier,
 	 * which gives:
 	 *
-- 
2.51.0


