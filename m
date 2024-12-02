Return-Path: <stable+bounces-95985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AF69DFF8B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE5628130A
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038001FBC9E;
	Mon,  2 Dec 2024 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="YwJAtjHg"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457A11FBC8B
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137266; cv=none; b=doMo0QzUXkPCkm/3koIIwwuLRYi3g9dWTwdTuOGU29zZjS+KkIZ96gi9l8McV5DRYEva9RC5AahbB7Cabq6bd8sqKCJGJ1mYoujeKLUWbBjY8jTHJZHdimMKxYSigaYc3S8Ujwy9tqZX55DOIdYrwXIp97s912I67WtH1S0kPo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137266; c=relaxed/simple;
	bh=5e/ABJTRlW4Kn8aITfXHP7G+RlpZfFW013vJEb0hG38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9FILAdGTDqdGfCrPtqzcJ5W1/Oy1rIcIR5pOyP6bNT4oSRAMEsyPb4JNSQuFh80zTkaCCAGy6ZlK2Tunr2v/ACLug13xdhVQ6Ngk5xl4NaxSj23WKAxj+MEYMia4LV4eoycyUCd1Cc41HlmjjQXEpAUA7mKs5G6z0gWZUE0Hig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=YwJAtjHg; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BD033A0A10;
	Mon,  2 Dec 2024 12:01:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=p0qYBdk4opynxBR2emw8
	8DLKaZYatHYME02V72iRLWQ=; b=YwJAtjHgaARNiPJUs/1GryX9mOA27Wh9l6xk
	iiY54yv8mPV3fn+k+pc8is3A+DUHVR0n+XYpexqg6jhAif+e/g0fedH1LdHuS8hB
	ppSR7gorwa9ndkQWdqocFgxuA+YhFFsE+flppyKIfP8bR8TG1PryuZF9FZ+PWqyL
	mXCPXkCDQ2OPHGgpMRJvup4BxCot1Cga9GMvQ7vwDUUbyhv7M55Tt+LdkK/lPiDo
	sNnv7CHFzOyAGFMlHZZzElQcLkM3DhE/qBVxk+uLIrg5eYMvg0e3Zj7N81Ys9fJi
	rHBhU6DwObgbh+4eT+RXMaf+WwivyL4vgpOFag/VYjPqa3I9023zTWi4E9kyw7hD
	/C3S2qeQpkCkceIBbrKOilXUDyT5Pm6r+Dlb4JRsGSbUcIWH6sGwzmzQZVGD5FFg
	JAi/JRHZV4OsPqKJcJUXOkbQfWxCW7I5BO131lWKe/nXbXZH9CWDoK79DxVBVz8e
	pPIxNdEnLzkk4lSPVH/aXxlS3MOLkn2cYY53qpFhT45iM71qAcWW3K4yH6e7vEcM
	rS9iZiO0Y/x0FKrd7so6qTJuK8eoJbL+XHwDpbyJ71xNMyG/NZnjnhj1ZHtllPCr
	LMtttuRf1e4Nijr60aezo08vPxliry95wWFVgu2/PjvzZ1/kVAh09DLf3zLstce9
	iqkksaU=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Frank
 Li" <Frank.Li@nxp.com>, Rafael Beims <rafael.beims@toradex.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH 6.12 3/3] net: fec: make PPS channel configurable
Date: Mon, 2 Dec 2024 12:00:01 +0100
Message-ID: <20241202110000.3454508-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202110000.3454508-1-csokas.bence@prolan.hu>
References: <20241202110000.3454508-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733137263;VERSION=7982;MC=2490259619;ID=155739;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637263

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



