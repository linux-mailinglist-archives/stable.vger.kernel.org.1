Return-Path: <stable+bounces-179499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DC3B561C0
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670051BC401E
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFE828469E;
	Sat, 13 Sep 2025 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kmdbhtri"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9802DC76D
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776754; cv=none; b=e7oc+ujpvi2my4t4RUZ6iV8H70iTynJHgaGyOOzs82ocRhKaxdIMR0YaaaGAgf/8ITFxnMwYAhP7B3Vd6TJvAmX85P5qzHbY6HlOTvNW41AnL8YhQ+rfe6vw4TV9CN5j6vMzx4HWD7vQRpufJEUBgYbbPSUpoRNyEvmjWomg8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776754; c=relaxed/simple;
	bh=KHvx9AX5dIwfiLbFPWMZRqViOs8x5BNY8mhEjq2dGek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OngdQZqoKHEILWhGP4U9H4jngwXRhwHoATkBN2bCIqvvlrBfbchQWZObWYZSIBnVsm/fiDVZ9sTj/CkELiO4PcS1TKnu4IRqbhKos2J6aRykreXBIb81MJLQBrMbKcq2GHdnwcUDN3OTF2BQ9HTk1sL9SutfVC5FdbYkN6+mkdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kmdbhtri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90BBC4CEEB;
	Sat, 13 Sep 2025 15:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757776753;
	bh=KHvx9AX5dIwfiLbFPWMZRqViOs8x5BNY8mhEjq2dGek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KmdbhtriQDMqiG+4PsVh2BU+PIzxA/3KT81nE6uLO9RV1ZmqJoZTY/vfWbEPi+bwR
	 wh4lxojOrKZ83cpkGI0zpUoupveD350ByMGvHZPL8ibEqV3EdySSSeVplCAfzxaCqK
	 aj3CddLah8TCWapp/SocCq+JY17uklM/Xcqi2VUGnoyAIAIPg9OtvLGVoTkfYWIOEd
	 eHGj90IXOKqNlLLOM5X0X1ZXsPZD75kLu5F/uqHOHqlrAWJcZjC7e/m/Q7MHlKqP3i
	 +BhQiL2J2ra5JoAC/x126BNCy6jFRAC8uV9CC1mhVhAfwv0/BMdsBMY69oZ8f9VstG
	 zmvwGwUtHDIEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Dahl <ada@thorsis.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] mtd: nand: raw: atmel: Fix comment in timings preparation
Date: Sat, 13 Sep 2025 11:19:08 -0400
Message-ID: <20250913151909.1412861-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091346-museum-immunity-ab3d@gregkh>
References: <2025091346-museum-immunity-ab3d@gregkh>
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
index 3468cc3293992..b2cc7ff9ed1c6 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1378,7 +1378,7 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 		return ret;
 
 	/*
-	 * The write cycle timing is directly matching tWC, but is also
+	 * The read cycle timing is directly matching tRC, but is also
 	 * dependent on the setup and hold timings we calculated earlier,
 	 * which gives:
 	 *
-- 
2.51.0


