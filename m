Return-Path: <stable+bounces-96029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6177F9E02ED
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DFF2872F7
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777EC1FF7CF;
	Mon,  2 Dec 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="HiNZx9k2"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824C1FECD5
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145039; cv=none; b=kFufJ5yu8fC2ErXtXwVhgbdyIv1RP+jedKyJwb75+Z6LDwmMuRIpNWqR0kADV4MSPVMGUewcETLUCnUI7GjdW/zFOTHIU99kK8105IOKa6zvxpJu6mnhQiAoY3MEhOy/KD98Uxa5C0/C6DqVgdKNeFfaBsqETqnjlT2h2mLjq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145039; c=relaxed/simple;
	bh=yDNJAKGdyZ+r0Nn0U16UdDvuDZVmFYECRFW4ArFw1lg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fdnmkeh8tlRLr8ecaLblJ3BoiJ2VnY/W70U699TfGDV8cwOak1KNTKS/OcYUMa9Yo5p4lFmC1kO+ofxeQmoA1FpdiJfg+ZC7tQilOwFdlMyXZzBsJEWJBi34Do+cAsQsgEFewEMQ71xbPbA64eq3jMuo6KNxodK6SpHm6CxXQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=HiNZx9k2; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 13BE8A0365;
	Mon,  2 Dec 2024 14:10:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Hyebgrl5PkWtsQO0HwY7
	FrqwTpEMMdGIukYafsPBExc=; b=HiNZx9k2WIHqP7FPjNHSd4tfAIANzQtLPJk0
	L6FBwh6V1WCgeoyWtbQpYFLfY49IB7G+GtI+0ZCKFXZdc1z7+m8J3Qu8cRO+X104
	bybZQSB9YsdhpcsWR2qoGYJ/3ehy5/fV1m2120cKeLN56K7kWBitwveSN5PPovVE
	e3pG1jrYjMDog7osLV1A252jkwxOYR4Dx1/mWIFSv0KFKABwqdHvp7so2+FrSNI+
	OdlL+GEobMndEGZp/+fxLnqjEgR4FJ2PVFMziTXLJC4ur0t9LBrGijUp1n+s4h/A
	ql5BkszhVwmV/yiGbWz38fVK0s/RL9q7DjZSWlCMhdzjwEFUTI/R1eskOMRpnRLW
	rPYS9MToPILVdxoKtHmS/rG0X221YVhvGJo+E9SSyPx//6OJ49AnL6i7gC0u3DNi
	Fi6UfZ8HeMnVjvoUEw1j2y3vSG2NM2t/r+UVEa6IYIxemE1cvFGkqhNgIIryEkST
	LIeibxkj+V+/EIfRC+1LEsTyB35ThCKMhB0rz9w2xRNh+iJX/Wx6TyA4KPcZNkUf
	2w1eyjEEYmioWw0NjIWwtEn+xL9lEilldugnsdaetPcujh7jb8uUarXn4hDPNRQr
	EtEkD4J2xOH2Y4fZDbKAgmyN9adlFT9224qaQsQ2fTWXiy4RLAulIVIKX6PtI04N
	5tDs2jM=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.11 v2 2/3] net: fec: refactor PPS channel configuration
Date: Mon, 2 Dec 2024 14:10:24 +0100
Message-ID: <20241202131025.3465318-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131025.3465318-1-csokas.bence@prolan.hu>
References: <20241202131025.3465318-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733145035;VERSION=7982;MC=2269963086;ID=156987;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637261

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Preparation patch to allow for PPS channel configuration, no functional
change intended.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
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



