Return-Path: <stable+bounces-96115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 788359E0929
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC0EB31730
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC2412FF70;
	Mon,  2 Dec 2024 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="ctanbt2A"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAC781AC8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155042; cv=none; b=EU1uTh+Olz8cxbbh4iqxgmcDNzTUWsyFDjzEgH9kgtG+hC+Z6jOhawLuutzKSA1WpVtj1TSo7MCYJg2MCFdZ8QSlrCuBytgOb+tWr47OeVWFp+C5Rgj5xkdKhZPnGQ6C1UWRImyA7JazMUsontrGL+DtmcJ27pEAlF4NkM7Z580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155042; c=relaxed/simple;
	bh=Y74p5h63B8YlHWDy/ce7uQvyoMJg/1MjVN+VyHmPi+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjI9RUaoj2VFtQyWsEDcqPgi6kU/4x4AYbqCJGil8IEznDbbRIh7YkRrMcMTSt4T0cA0uAy+1SG69ZjKwq1MLq6Pqeq51TULJGVX8wt/PKRRLwtSYFV8JTxRAI4Dw5E4LTrjOofQZgm8YuCC82FuHTZCDKErT2AU6c/bMPs7GRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=ctanbt2A; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 81E74A0365;
	Mon,  2 Dec 2024 16:57:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=BcIfIIITBoL48mjUW8ky
	myP9kexR3fKyrefe9Pm6zM8=; b=ctanbt2AnBjn9WktxZuSOcSkbicwJftEXhpD
	S4MaJUZ+J1FKeOh9qBFsYD/ugv7CzBF2ku4JMmGoQYT864AbSLEHN1ICun2QnkbP
	NyGcyWSHc5kZhJ8TpfEyUiLUuoy1OrcNoCaS0NCOz0cbve5hSoxSGt1ZFOxKjTsx
	2xzWtjnsUC0OP1/0+hOXf5Sa0tdWikqs7BoTZDvbCpnBkhiIIvFdKBjbDKoFySk8
	GEUrDW//89wMAxj0gDU4bioFooTbMG5OsvsUwkS7w7L7z67JgHZsOK16GfYuA3c1
	AqZfgI9Mcx6uw3kObTHkNniGb4qevWLU7N/GDjeRUpQbghVRsFfmc9zgpaE6pMLf
	4U01PfG5/7rnK/eTV+XaGS5Q/x/hcJa0AFsBEhwRmozriHBa9peSKPNLmGsIq2u5
	EhTT3ftM22qtTFDxLboac9bjANqr3hfrVATRIHo+2/x791mF6c/kfy5P9UigGe1T
	15Skr22gmoo1aUcsRxHHkyIZP8Jct2z0T7opq+dwMlAWrHj+KeUQbYAbI9clnJsg
	rWSrMCxvZnvl3YTRVmUpjIskceeefzFMJMurbHnucyZLn4AJD+QO1oa0qb9X0o1j
	C6e2jHQKWwhDCjgj8pE3ZPr1oP5ODwfqLar4Jb49vQv3ITdpu58cnEqG7ROCXwTI
	YGCUGe4=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Rafael Beims <rafael.beims@toradex.com>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH 6.11 v3 3/3] net: fec: make PPS channel configurable
Date: Mon, 2 Dec 2024 16:57:13 +0100
Message-ID: <20241202155713.3564460-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202155713.3564460-1-csokas.bence@prolan.hu>
References: <20241202155713.3564460-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733155037;VERSION=7982;MC=341798536;ID=157281;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
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



