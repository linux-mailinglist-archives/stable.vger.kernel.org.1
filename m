Return-Path: <stable+bounces-179497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A4FB561BC
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D085E1BC283E
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835A22F0661;
	Sat, 13 Sep 2025 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk+KwypG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B7D2EC0BC
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776376; cv=none; b=FeAKYk3QwfuIQsy0xq0ZJWWbhByhj+TS95e+rVv9Okme8BlzOw70se1/YdI85pHPUv0WMaamue2vVIftOuJeSuAFQlI/cAwkD+Oir2n9W3qbEMTw0YcqRGzWOAj1tIq6ZfsPhNp20rfh1/3j0/+nOVPVezGrC6ZsaH9yWoZoNng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776376; c=relaxed/simple;
	bh=vQw3MPCJJ/rdsbX9nIVjUIU7aV0cZyymoS/wQxAKsjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HK962t/nCjRHT2gksp0FXEAF8IagkOosqrjrfcaDZFUkQdt9PVeArifvBcSIyoQOeiTqEo5Hrkh+Iakt3BahXBR03DKZ6+Q/CrqUoROBnM/E5a9sQZ0DzLAPwlNPQHGc6ZxK+FPjYFPngqK3FhOZmQ1Wv7I2famXnjP1LDRMVlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk+KwypG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB049C4CEEB;
	Sat, 13 Sep 2025 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757776375;
	bh=vQw3MPCJJ/rdsbX9nIVjUIU7aV0cZyymoS/wQxAKsjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uk+KwypGGFX6faaN/svTxH7Xpf4fTbug0YhOZu3XByLwgozm6C805nN+td1H830wx
	 R3G5mHK50vJBOiEBVwLjzGvUgbnnxHQ7JxpkW7ieOBDbgkzZMQKDP1gvSQLgUetjrb
	 3ZKpcnN1PRDtFs+jMuWOHZCEF5StdueJYp1QI2cLhfiZGOZIGupyAdzrvcPdC0PxDh
	 qZ7VhsGRwJgZRcgtL9EFfUoX40YyO2AYPkLoIZU1hfpFnwo2Ck4CAi0jS49MzEH/wv
	 kUQn3U65AtZ140utuEZQaRvs7HKr8NnUe4PQhTyvgmtaXLLI76fMl14rozQdbaxswQ
	 ujYO5+bofAqoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Dahl <ada@thorsis.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mtd: nand: raw: atmel: Fix comment in timings preparation
Date: Sat, 13 Sep 2025 11:12:50 -0400
Message-ID: <20250913151251.1410237-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091346-coral-alphabet-9d67@gregkh>
References: <2025091346-coral-alphabet-9d67@gregkh>
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
index 060e2c11b8e04..48d6194efeb7d 100644
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


