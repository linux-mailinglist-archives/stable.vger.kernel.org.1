Return-Path: <stable+bounces-48450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02938FE910
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEFE2835F3
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3258197538;
	Thu,  6 Jun 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LcchwRsz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15CD196C9C;
	Thu,  6 Jun 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682974; cv=none; b=Kv9bwSxJOzeWuYQeHys7Uk65IbKI6Mc2Z436OOM+rgsxxLTsPTKVZ3uyWwM02OTiDdc522fvEBIgvv1H9iWhRF0F+L8K1c/lM7GChM67d0/P/6cCsSV6MgbHWp3iBqkQ27GgpVHBP1eeflmVPYhbZD3zKwWOnvvJQmVdUn9ti6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682974; c=relaxed/simple;
	bh=y4s/UobXaVwMB5TjdH8M+cRj4BMQH9bZlVs2rIjvsns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9gpPHvcfq8lHxCdaTx7M2UbUDewyk9yXKXKLzjUjqD2OarVtygbnWUnObxzx4zsS5g9te0N19P2Tyk+o7HrZgDhDqPOvYKf56eDnQxddoXzBJEbpq8rdFXvqgi0PDfNMIUOBMvcGk2H1RMaqVXOOkOGBE5vhv6i2qtiqbkiLCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LcchwRsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6ECC2BD10;
	Thu,  6 Jun 2024 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682974;
	bh=y4s/UobXaVwMB5TjdH8M+cRj4BMQH9bZlVs2rIjvsns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LcchwRszP2pvrpFjTqli8nY9uagcS8+E2aqm7RzR9oQ4OiCWTaBHYN4E7lMrSLVic
	 /CK8wIjKkykCvZqnZENd3Wm9c+ynp0uhbBb+Gh66AHAh5sd8l1x1XVnl12jEonYxXM
	 IaWA8iP0h4Q/cKgL8RjZbDTMcQG0Tq5gCked2OCE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Judith Mendez <jm@ti.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 151/374] mmc: sdhci_am654: Add ITAPDLYSEL in sdhci_j721e_4bit_set_clock
Date: Thu,  6 Jun 2024 16:02:10 +0200
Message-ID: <20240606131656.982982633@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Judith Mendez <jm@ti.com>

[ Upstream commit 9dff65bb5e09903c27d9cff947dff4d22b6ea6a1 ]

Add ITAPDLYSEL to sdhci_j721e_4bit_set_clock function.
This allows to set the correct ITAPDLY for timings that
do not carry out tuning.

Fixes: 1accbced1c32 ("mmc: sdhci_am654: Add Support for 4 bit IP on J721E")
Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20240320223837.959900-7-jm@ti.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci_am654.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 888bfda0ebc0e..884d1b53180d7 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -320,6 +320,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	unsigned char timing = host->mmc->ios.timing;
 	u32 otap_del_sel;
 	u32 itap_del_ena;
+	u32 itap_del_sel;
 	u32 mask, val;
 
 	/* Setup DLL Output TAP delay */
@@ -329,13 +330,18 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	val = (0x1 << OTAPDLYENA_SHIFT) |
 	      (otap_del_sel << OTAPDLYSEL_SHIFT);
 
+	/* Setup Input TAP delay */
 	itap_del_ena = sdhci_am654->itap_del_ena[timing];
+	itap_del_sel = sdhci_am654->itap_del_sel[timing];
 
-	mask |= ITAPDLYENA_MASK;
-	val |= (itap_del_ena << ITAPDLYENA_SHIFT);
+	mask |= ITAPDLYENA_MASK | ITAPDLYSEL_MASK;
+	val |= (itap_del_ena << ITAPDLYENA_SHIFT) |
+	       (itap_del_sel << ITAPDLYSEL_SHIFT);
 
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
+			   1 << ITAPCHGWIN_SHIFT);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
-
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   sdhci_am654->clkbuf_sel);
 
-- 
2.43.0




