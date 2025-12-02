Return-Path: <stable+bounces-198139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FBCC9CC00
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 20:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3068C3A89AD
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E982DC34B;
	Tue,  2 Dec 2025 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxpKiSr+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83692DAFAE
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703271; cv=none; b=gSsPxVeQmjmMkUc+HvWaddpUPLH4J3QXxkhsbvB112D5KwJQG/lcSBlVg/L8uYFM+ZZbtBpT+ckDe49oRXG9wzhJ7lD8NexY5UD+HJET6k+BOyGm5R/iR+Q+a9Qs7NlxVLqyaXA5tgISbu24n3OWOQ0T91g/MzSGi7h6S+w6AH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703271; c=relaxed/simple;
	bh=sZr5xSFQ+ZBk7V+QlZyj7F0x6zSUgeEmN+PRmEXg8sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kc1vRYdbpcF0L81/0fQm3W/Ryxmh+0b3XSqNUc5FWwgBUf+WxL2rP869b2E7XGYQxoTsYd5mhBdcTvj9y4vPqzooAmQb3JSSwWHeVTlB0ukzaV/fB5UatMBCO4B2i20zZ18k/y1AYpr+Izy4SgcQ0IdT7yKvHs1nOP+GhDilXTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxpKiSr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F44EC4CEF1;
	Tue,  2 Dec 2025 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764703271;
	bh=sZr5xSFQ+ZBk7V+QlZyj7F0x6zSUgeEmN+PRmEXg8sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxpKiSr+n9BGggLFY46/t30dJBsVv1Rvz8E4DRw0kmFxorXyq2psOkE2/Kex9Vnqm
	 zJyoPFxCSqs7crcxLq/4nAyJGm6RgR7RojeRlTmT9SqeXVi5Dcq8j7oMs0ltFkGDUw
	 KJKKp+umnR7X5PPWMIB0gcX1cMYjk0ktU0/LynkIGoJeZqaMxgrHsQEF+u9MotXsRQ
	 +CRisWSXfCXmlSaBkesqAdsJAf/vtUJwkwRqg12TsTpLdZRf9GtGYNCWQQp4ToP83m
	 Z6FdQsIJ1bAMteY49RZ03XDn4n8QTcPO0KgjhpcMJuQTmcIGUzxW9kMs6o+PLYmm8a
	 jDv3z7K/pBxYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] net: dsa: microchip: Free previously initialized ports on init failures
Date: Tue,  2 Dec 2025 14:21:00 -0500
Message-ID: <20251202192100.2403411-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202192100.2403411-1-sashal@kernel.org>
References: <2025120246-talcum-rectangle-f99d@gregkh>
 <20251202192100.2403411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>

[ Upstream commit 0f80e21bf6229637e193248fbd284c0ec44bc0fd ]

If a port interrupt setup fails after at least one port has already been
successfully initialized, the gotos miss some resource releasing:
- the already initialized PTP IRQs aren't released
- the already initialized port IRQs aren't released if the failure
occurs in ksz_pirq_setup().

Merge 'out_girq' and 'out_ptpirq' into a single 'port_release' label.
Behind this label, use the reverse loop to release all IRQ resources
for all initialized ports.
Jump in the middle of the reverse loop if an error occurs in
ksz_ptp_irq_setup() to only release the port IRQ of the current
iteration.

Cc: stable@vger.kernel.org
Fixes: c9cd961c0d43 ("net: dsa: microchip: lan937x: add interrupt support for port phy link")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Link: https://patch.msgid.link/20251120-ksz-fix-v6-4-891f80ae7f8f@bootlin.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz_common.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 4a7cb9dca3243..da99e88c6e9eb 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2564,12 +2564,12 @@ static int ksz_setup(struct dsa_switch *ds)
 		dsa_switch_for_each_user_port(dp, dev->ds) {
 			ret = ksz_pirq_setup(dev, dp->index);
 			if (ret)
-				goto out_girq;
+				goto port_release;
 
 			if (dev->info->ptp_capable) {
 				ret = ksz_ptp_irq_setup(ds, dp->index);
 				if (ret)
-					goto out_pirq;
+					goto pirq_release;
 			}
 		}
 	}
@@ -2579,7 +2579,7 @@ static int ksz_setup(struct dsa_switch *ds)
 		if (ret) {
 			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
 				ret);
-			goto out_ptpirq;
+			goto port_release;
 		}
 	}
 
@@ -2602,17 +2602,16 @@ static int ksz_setup(struct dsa_switch *ds)
 out_ptp_clock_unregister:
 	if (dev->info->ptp_capable)
 		ksz_ptp_clock_unregister(ds);
-out_ptpirq:
-	if (dev->irq > 0 && dev->info->ptp_capable)
-		dsa_switch_for_each_user_port(dp, dev->ds)
-			ksz_ptp_irq_free(ds, dp->index);
-out_pirq:
-	if (dev->irq > 0)
-		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds)
+port_release:
+	if (dev->irq > 0) {
+		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds) {
+			if (dev->info->ptp_capable)
+				ksz_ptp_irq_free(ds, dp->index);
+pirq_release:
 			ksz_irq_free(&dev->ports[dp->index].pirq);
-out_girq:
-	if (dev->irq > 0)
+		}
 		ksz_irq_free(&dev->girq);
+	}
 
 	return ret;
 }
-- 
2.51.0


