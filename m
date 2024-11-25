Return-Path: <stable+bounces-95362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EFB9D8212
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 10:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D262B1632C2
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E141917D7;
	Mon, 25 Nov 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Smc9TvON"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB1018FDBE;
	Mon, 25 Nov 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526217; cv=none; b=U+rFscGod6quDqYoizSMm2sAkUTbJVYk0kRsnRpChaaBViApbwwAN68mtciCh/brQaFdD3K1kEncGRDWsSyeFpKSq1QZphn0Z/2Q7xST/6nqyGuUv15jqaGTLbf1g2afbLNSVfyfZCxLuIRLA4apbjMhSlI5toWpSvrIelAWk5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526217; c=relaxed/simple;
	bh=17ic6u8a2Bvo+vx670R/sedCYSWel8wjM2LQ4U7aIvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hp1Pij6Yc5fhu4VhdixOvolZd2vUcGSixf7Mzw4BmqK3INJtONT4hk7BQXHSpyjlm7+ygnFFYJB6y0l7MrBmbJOh4m0YJKS/rEtDj/qCC9YOgd+ETmOsD9MM09j3ytoZfyVJISwEnbXyP9QwPYhs2d3ThWMf4MIRloexFhvAE+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Smc9TvON; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 8EA38A0888;
	Mon, 25 Nov 2024 10:16:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=HuA3zgq41U+katKsYp5H
	+YNI3j4ahVT5oYw1VTy9j3E=; b=Smc9TvONDcoSa3fX+PlEsvZmJAcZlDsX4M8q
	RYfUHijNnsoiq3NQlQo9iGyJ31dy31fUS1BW4kOr75q/H1uPyyVnvgxu1N/tqAw7
	TaxEhSirAHaU1TQ5jo75QK9hUEJZ7Jlse6GFK22Ce4Cs2pMLghQjKSXQjA+LqBxy
	LgCEvkvNT2+5Me/a4/5wVGNU/hN6dYa3YsgnFI5QgHoA1IabkAeVR3V+FhNa3xzG
	/6ev4AGCtpJD+oGiIrdVAGrhwTAxPPrFFaqnAAfco9QAHNTXDobJn7fvd8Um+ytz
	u5VYz9eQDZSY/H5Wu4lUHSYmiq22VMiBTG76OK8f3F/EoaQyiGwWVhK4PnDqo9tp
	/ZtmrYjFN5Puybw1Mzwyq+O4/6Dxt7DPthoB/CqgRZ1Dl3bt1q8KjyVjnuxHR5K0
	Li3WzJ2se9W0wu4BgZQ5cjOGkPKCvoLN4f+nGCDzDSWjy6u8qUkNgj18xo0U/H+C
	7IAeGFmttOBpRm8s1g65MU9utNt3Pxl3HJ7Em+TmpA2ZLza6WgFAvwnLokHG9o3B
	QHmQXN6TvrJyskQ90dH2DJlSmN0VumKbWFQmajKBNWvQtiB28tAXUx2JbFfOaWEF
	SsVm6IlPcnOlfKJL0fN5VYwvpcchWljTq/VDEBi7NeyGKRohi5aD3LndlNKzxfw6
	DKrFEBI=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Frank
 Li" <Frank.Li@nxp.com>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?=
	<csokas.bence@prolan.hu>, Paolo Abeni <pabeni@redhat.com>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH 6.6 2/3] net: fec: refactor PPS channel configuration
Date: Mon, 25 Nov 2024 10:16:38 +0100
Message-ID: <20241125091639.2729916-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125091639.2729916-1-csokas.bence@prolan.hu>
References: <20241125091639.2729916-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732526206;VERSION=7980;MC=2326158866;ID=94029;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855607C67

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Preparation patch to allow for PPS channel configuration, no functional
change intended.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index a4eb6edb850a..37e1c895f1b8 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -84,8 +84,7 @@
 #define FEC_CC_MULT	(1 << 31)
 #define FEC_COUNTER_PERIOD	(1 << 31)
 #define PPS_OUPUT_RELOAD_PERIOD	NSEC_PER_SEC
-#define FEC_CHANNLE_0		0
-#define DEFAULT_PPS_CHANNEL	FEC_CHANNLE_0
+#define DEFAULT_PPS_CHANNEL	0
 
 #define FEC_PTP_MAX_NSEC_PERIOD		4000000000ULL
 #define FEC_PTP_MAX_NSEC_COUNTER	0x80000000ULL
@@ -524,8 +523,9 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 	unsigned long flags;
 	int ret = 0;
 
+	fep->pps_channel = DEFAULT_PPS_CHANNEL;
+
 	if (rq->type == PTP_CLK_REQ_PPS) {
-		fep->pps_channel = DEFAULT_PPS_CHANNEL;
 		fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
 
 		ret = fec_ptp_enable_pps(fep, on);
@@ -536,10 +536,9 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 		if (rq->perout.flags)
 			return -EOPNOTSUPP;
 
-		if (rq->perout.index != DEFAULT_PPS_CHANNEL)
+		if (rq->perout.index != fep->pps_channel)
 			return -EOPNOTSUPP;
 
-		fep->pps_channel = DEFAULT_PPS_CHANNEL;
 		period.tv_sec = rq->perout.period.sec;
 		period.tv_nsec = rq->perout.period.nsec;
 		period_ns = timespec64_to_ns(&period);
-- 
2.34.1



