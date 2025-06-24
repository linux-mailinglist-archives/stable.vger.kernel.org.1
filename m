Return-Path: <stable+bounces-158330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E350BAE5E2E
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 09:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07757405122
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AA9255E34;
	Tue, 24 Jun 2025 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyG/QAwi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45C254AE7;
	Tue, 24 Jun 2025 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750835; cv=none; b=hj8ZzK40NApjzUbP7+JnLaMjQQKuv3iIMrnA2x7fpdMzHqpMaWJKQF3PwhbFS6+f89ZQwuy1gOS4+91LKR0hg1NOWBKKkO+IvwLWqMSQr4amGOoN7ET03M2gggZFLfjjV0ygVAhtE7t6IaCSiwNeeHEIJwNwTaWbFoJdhijACDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750835; c=relaxed/simple;
	bh=5MDN88FZVbyrRfF8wE+i0e6TOjgW+iZQPYw3FoygM2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjQXfKpV+HYUaHrUBS/RaCZoK3K1dAmH+iEyc0pFW1Tn6G7Cmys78kh4E+HVLkEMa7ZYiAmdgFmcnUYEKzsB4DvV1iyY7CK4SvXFICx8nK7MXJWPycUk7lyZZpZ5JoVB4COft9SN6njXI/MdcYKVcW8kU+/5km126BiQ28vFTcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyG/QAwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3551BC4AF0B;
	Tue, 24 Jun 2025 07:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750750834;
	bh=5MDN88FZVbyrRfF8wE+i0e6TOjgW+iZQPYw3FoygM2w=;
	h=From:To:Cc:Subject:Date:From;
	b=hyG/QAwiuTa+wBO82JRHXIiFv6X4Fmc5r0hboVSQ0F9swcKFvnlVbkB1PP4K6z2T+
	 A3ZHzriq+At3q9plM8FPOGELXOTaOBc/Q5GXH1lWOdA4LB2MIUcj45wbu7DR5m97BZ
	 HmWgQOEZtiu/4hgJv99+gNAC4VSR02OlCpiZ2nnmUpMRpzC8APT1sHHoXRAfCT4ZH5
	 hFWa9LYiDkvXLWW8Kwh9HsiV7lefK74pK1tq1paw/vaarU3dGR9I1/GHMMyK/QOp5F
	 WV/gvi1yxoZPFofjxwufKBwa2t9BwcPVEeKBEsQsIoCHMMcaXfYq4EpuFasmDRk+VY
	 lGs3lf5ccIQ2g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hans de Goede <hansg@kernel.org>
Cc: stable@vger.kernel.org,
	Andy Yang <andyybtc79@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: ahci: Use correct DMI identifier for ASUSPRO-D840SA LPM quirk
Date: Tue, 24 Jun 2025 09:40:30 +0200
Message-ID: <20250624074029.963028-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=cassel@kernel.org; h=from:subject; bh=5MDN88FZVbyrRfF8wE+i0e6TOjgW+iZQPYw3FoygM2w=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKiwnJfOzGc/9g4j2X2xZzLB91m/Sja1C70Vr1grdHne 1v2Xu3L7yhlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBENm5hZPiy5zVv9/LEHkVe k7BwZpd/OZf/NFbZvck6wGmharbZYg8jw52t7ttnB5ruzsrgn5s2W3IJu9oqnevsS2M/nPuxqDX ejRkA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ASUS store the board name in DMI_PRODUCT_NAME rather than
DMI_PRODUCT_VERSION. (Apparently it is only Lenovo that stores the
model-name in DMI_PRODUCT_VERSION.)

Use the correct DMI identifier, DMI_PRODUCT_NAME, to match the
ASUSPRO-D840SA board, such that the quirk actually gets applied.

Cc: stable@vger.kernel.org
Reported-by: Andy Yang <andyybtc79@gmail.com>
Closes: https://lore.kernel.org/linux-ide/aFb3wXAwJSSJUB7o@ryzen/
Fixes: b5acc3628898 ("ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard")
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Improved commit log
-Picked up tag from Hans

 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e5e5c2e81d09..aa93b0ecbbc6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1450,7 +1450,7 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 		{
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-				DMI_MATCH(DMI_PRODUCT_VERSION, "ASUSPRO D840MB_M840SA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "ASUSPRO D840MB_M840SA"),
 			},
 			/* 320 is broken, there is no known good version. */
 		},
-- 
2.49.0


