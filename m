Return-Path: <stable+bounces-96120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07049E0AA5
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEAFB36D64
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C1C13A3F7;
	Mon,  2 Dec 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="GtjXci2a"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377D139D19
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155087; cv=none; b=b5etkTO0UsqTPT9maNx+HmLcLlylG0l2yomGUcG09OwSJXNIZPdnSvj499f3T0Y4R2+AFKwv5ee+Bbeo24jnuGMtEvw5XhP23viLfO0/7mmGhWi46cHVEMkoIhH8Mg+PqGqTCQb5b4nFCsuUVV1nqkvBlWasoo+1JLwIwX5IWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155087; c=relaxed/simple;
	bh=8+LyaBWREjQInupjASE9sQ2Oa4JjlAvEDMvPzEVZRGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5ZrE1sXKylZ5R7ElV2OcXoYOoWXtZKuJK7rlY03/9Y6UOR4CFp6e7iRW1UJ+iOyPJ1NxuQc2AzJMaYaAWIAsKz685QQJ+MG5o9SRkz8Xo7YYaq7FNj83DiVezsTsaxZrYm7s4sQFS5jUll3klhJs/3ICJvO6oMtdpfv5j5Roi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=GtjXci2a; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C4D82A0895;
	Mon,  2 Dec 2024 16:58:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=DXhKt42b/ZNrT+XgK2dm
	5hyq3ayw20HDBubAXjXBvMY=; b=GtjXci2aRZMueycBf2nnE34N4C1NqWcOZ3Hu
	qKNoiqnXN6sQ9CdGGTStxkCtIz6E8jBbBPx61sgb5c5pk6d53RciCjtIZSEF6Okw
	LynfdccwGRgOtSJsiBewuvExptLvObJh/TLrwXrvNo9sVad58J8SVDWz4Y7ZBrCZ
	lZegZGuzabtudRbnYWatiZl7U6FAtDl4n0XB1lJRmq266kCx2WDBNRpivCnk1bV1
	TPqutclGGsDLIa7RwKkzYWVoGIPBFZqrIEBcfKssfKOx5fdZHHufv+BactqsgDxW
	TocRLMY2Rpip2I/yz/LF/Z0i6dTUPU4P1JzaoxNP+v+tNkfELNc//OwAQ6ZrkQRe
	eaGh0+ukRKWJspyRQ3G+ceMSDmonp+BNP/WvcbEraQ3tufuLwGmEl2zophSRuoy2
	gD/Mm/jeTUf9cI1KJ6SohGFAiHPPZa8828Qp6S2/bf41eoLh0TBRqx4kaOAA/zTH
	2XsODXpFIwV1C7aYY39YCGvviRe0rSMRgeiJyQtQCWQq2CKJFbR/cfY8VSVpNUHF
	dhHyJPtfVzFrdrcCsxxaFUFb3qiyvz/FTvESx6MFr487zQUlOfsDBBRHqUMspTOz
	klFX+JlcLN9CTwu5YnjlN24uSRiy0uuAgczFqR71F7oXNyPQqNoSmBREKO2t8Pjq
	gbc/YPA=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Rafael Beims <rafael.beims@toradex.com>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH 6.12 v3 3/3] net: fec: make PPS channel configurable
Date: Mon, 2 Dec 2024 16:58:00 +0100
Message-ID: <20241202155800.3564611-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202155800.3564611-1-csokas.bence@prolan.hu>
References: <20241202155800.3564611-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733155084;VERSION=7982;MC=1451083861;ID=157285;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637261

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Depending on the SoC where the FEC is integrated into the PPS channel
might be routed to different timer instances. Make this configurable
from the devicetree.

When the related DT property is not present fallback to the previous
default and use channel 0.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Rafael Beims <rafael.beims@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(cherry picked from commit 566c2d83887f0570056833102adc5b88e681b0c7)
---
 drivers/net/ethernet/freescale/fec_ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 37e1c895f1b8..7f6b57432071 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -523,8 +523,6 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 	unsigned long flags;
 	int ret = 0;
 
-	fep->pps_channel = DEFAULT_PPS_CHANNEL;
-
 	if (rq->type == PTP_CLK_REQ_PPS) {
 		fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
 
@@ -706,12 +704,16 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct device_node *np = fep->pdev->dev.of_node;
 	int irq;
 	int ret;
 
 	fep->ptp_caps.owner = THIS_MODULE;
 	strscpy(fep->ptp_caps.name, "fec ptp", sizeof(fep->ptp_caps.name));
 
+	fep->pps_channel = DEFAULT_PPS_CHANNEL;
+	of_property_read_u32(np, "fsl,pps-channel", &fep->pps_channel);
+
 	fep->ptp_caps.max_adj = 250000000;
 	fep->ptp_caps.n_alarm = 0;
 	fep->ptp_caps.n_ext_ts = 0;
-- 
2.34.1



