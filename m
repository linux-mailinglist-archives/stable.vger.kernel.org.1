Return-Path: <stable+bounces-179493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFCCB561B1
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1058A1B2760C
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9672EBB98;
	Sat, 13 Sep 2025 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5kbWo5I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40C2DC775
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776114; cv=none; b=fUDAEedV6SVznQ2WrMzjHIm2DpKRZVdcdODKfrv5qSK16IMrF4pK0tuq/GTDZe8TMJJuE69uRwpMI04LiAtbuiXUNzUPWJYscgnVxDcVuK+xfLpgS5UJek98PjR+JtbSwCZHeq+gpvkKkx2hxUHTVadBgCtbtINmoX6NSoFWipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776114; c=relaxed/simple;
	bh=wKN62QRzAlaIpHdl+CkSVDmb1uRlFxwhi9nLbOarbYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwsEGbkY9TxmppGdjoZcORk4xrVhLFPE5QRhiw8T+d4ClpiAqJz8mN2GzloqAeGQillTYYJZQTWnCkYCGlah5LoyQgG6O1ELvR8mwxyQcY0k8VnIK5MSshZ7UfB6KR924fsw+eBYfuAf0+OMwLXJ5x1X0d3T4EVhGmSTBIhfPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5kbWo5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94795C4CEEB;
	Sat, 13 Sep 2025 15:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757776113;
	bh=wKN62QRzAlaIpHdl+CkSVDmb1uRlFxwhi9nLbOarbYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5kbWo5ISmT0huz2KQa1L7gWX+xO5FKsN0/fRpedj1/OTgxg5PFMZi9tECnbCEtMw
	 vTF6+le75u1dkombvtYlVLzArwQq76iO0OLdKaoOih4Htl081wdwntapzdE/Isk5jA
	 VOaMHPZ9Re92bF2d+x0bolyLn4mjjq3kaQ8GpONxZMYi+/9L0DJsqdhLfkS6W83HF6
	 yNYNHt8sGpye3Isn+GpXKv0HMTVUNK2gEVei3RU3eTR2kBeJzbzsJbMANpvbBFomG1
	 roNLrbMUvZAUpCihrIRlbx3rbqfR7h2SgCtbxzW+ge3tAZ3gYKuLR5JJLf01jIekLr
	 tFPLVsbJAUbuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Dahl <ada@thorsis.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mtd: nand: raw: atmel: Fix comment in timings preparation
Date: Sat, 13 Sep 2025 11:08:28 -0400
Message-ID: <20250913150829.1407206-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091345-prewar-jump-dad8@gregkh>
References: <2025091345-prewar-jump-dad8@gregkh>
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
index 710d1d73eb352..511bd0d1e0672 100644
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


