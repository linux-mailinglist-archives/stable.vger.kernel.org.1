Return-Path: <stable+bounces-45415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2D28C9357
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 05:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7DD1F214B3
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 03:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B9FCA6B;
	Sun, 19 May 2024 03:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="RFqSbC2s"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536EDD515
	for <stable@vger.kernel.org>; Sun, 19 May 2024 03:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716088506; cv=none; b=Lh/QaLvBB/iSX+nywtiGH8tQ/d4OUcnftXRzuPIDoX4Lsx7IfwsGRpUozFH5o9jwfGPAymyICglSfWpWumpSVv5gkljEh0fo+XEKISmBh53PPbIFzbU9HJhIhWmF/EWJ5/GmtlGfIWBoTMYsMgCIUMhVCdxId5ZxukvyB+6gzok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716088506; c=relaxed/simple;
	bh=pM5i6LqokDz4pzzZFVyCXFt0ByKBOSnsXU6BpIshdws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z05QuvjIvDe283Lv79s4l62+l25vZ4itaXpqZcPbETSs8HbKRcN6ifrmFHxtaa7jFzq7BLgABNIPZV32xqcS0yM+u0N7ZA+0sv0Fe5wGgZr8R0cJCJqhOmyStEZw8GCljYxdlWKq6KbCSPtEw0j90ZgoKg0+mnkNoQWpUfimCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=RFqSbC2s; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Envelope-To: val@packett.cool
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1716088501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQ68eiixPLPA8K8ibwC9Cqzr0rdSmWCBdWf8xU1y1GM=;
	b=RFqSbC2snfhymVSfYyYailtwV2CqggBM/RQHKsrNoV3zW3MCK9cpI1GjMbIu624pm6PfOf
	wMZxYamANR3bImVCiq3rd4Hey2NKzUTdjLZW2TmnW6HxtGiohDrEnlWvPfeh94XTIQmTWG
	RkZ+/kTLV+QTyRJ6fGX6ifWe4SQ9p7hFBBJZEssvD/EZ3yPEymxWItYHBjcEPbz7KXgohG
	BbrN+IVoTm+cEKZ5LHwvSV8y6sIn1qqos9AizSoliMKpVHEuANf6+ot95p8Nr6DcY8FFZ5
	bAJa+9or7pdVeu/zXV1hTt73Lu3vETEgjRXxYBOSnTnEGSBckyFPRw9qptYMxA==
X-Envelope-To: stable@vger.kernel.org
X-Envelope-To: miquel.raynal@bootlin.com
X-Envelope-To: richard@nod.at
X-Envelope-To: vigneshr@ti.com
X-Envelope-To: heiko@sntech.de
X-Envelope-To: sfr@canb.auug.org.au
X-Envelope-To: linux-mtd@lists.infradead.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: rawnand: rockchip: ensure NVDDR timings are rejected
Date: Sun, 19 May 2024 00:13:39 -0300
Message-ID: <20240519031409.26464-1-val@packett.cool>
In-Reply-To: <20240518124404.472eb60b@xps-13>
References: <20240518124404.472eb60b@xps-13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

.setup_interface first gets called with a "target" value of
NAND_DATA_IFACE_CHECK_ONLY, in which case an error is expected
if the controller driver does not support the timing mode (NVDDR).

Fixes: a9ecc8c814e9 ("mtd: rawnand: Choose the best timings, NV-DDR included")
Signed-off-by: Val Packett <val@packett.cool>
Cc: stable@vger.kernel.org
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 7baaef69d..555804476 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -420,13 +420,13 @@ static int rk_nfc_setup_interface(struct nand_chip *chip, int target,
 	u32 rate, tc2rw, trwpw, trw2c;
 	u32 temp;
 
-	if (target < 0)
-		return 0;
-
 	timings = nand_get_sdr_timings(conf);
 	if (IS_ERR(timings))
 		return -EOPNOTSUPP;
 
+	if (target < 0)
+		return 0;
+
 	if (IS_ERR(nfc->nfc_clk))
 		rate = clk_get_rate(nfc->ahb_clk);
 	else
-- 
2.45.0


