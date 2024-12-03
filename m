Return-Path: <stable+bounces-96317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1DB9E1ED3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B935280E2E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2185F1F471B;
	Tue,  3 Dec 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="VfhoEzTc"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE21DE2DE
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235368; cv=none; b=ubhnwV8lbdqLLmspo/r4lNFq/JhhPjTuUPOWy4ivnWkr0AKMdu0AT8Db3ge3rOD3sT/DbSa+QxB9kd8MVOMgugmWBqx3dtHMm3CX2QEQrWAXMJUyyLKNzJe5WmOpkm6Zq39FI0TheoYP6j+gq+pKTODipwSX8KLG1/sqYThyByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235368; c=relaxed/simple;
	bh=dD0V18pPtJ/xK3jYEFBpwOjhPcBRt3wQct94StiKHpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqUjsRrAq5XxVT6Tvl+R18ycvqz8wo2UlknjF7fWqysBCDhlZjFvY3Ak56m8m/tyjjOvOkXzpACAdvsv09mecRTFCFn0tHKSmrg8ShIHP6smeKp5Spn7kUiF3WoHIz6ouGvZQTpwbJIhJyt0fMUCfoHh5tMmK0pxiLKNSl4P1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=VfhoEzTc; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 80335A0D33;
	Tue,  3 Dec 2024 15:16:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=km+RRrzeekuIehBWsb2M
	ndvhd+HsB154iFyHSVb8k1Q=; b=VfhoEzTcPsYruj2ECht8/g8eFrALcmKb9bGo
	aJFi/E5FIfcmArBuhigNHnoI8Qih869H7wajfv7bYowfhW6cXKhu45Tjy4Ihg50+
	saPFlLSuycqdcWErCL8ASD+ezoaTxsc4/kA/SJrHOrbQKSTfNwY4k91vJKvYwdVd
	DMwkjZ0syyW7O3gKAv3UWQSA0AbD3JDyqW28Ae+0T5eAR0z6BP1IPIDFxtg1KjRR
	HMLDKb4rijGgYjdsZ8JCADgXsszkzxKR2bI9Y/UaOdf2G4/0Oqu9eQlls+7/zqQJ
	u+xYslCwkv+yV4FFRbrbVxsjQhzDBOMZVVjJpuq0qg/JmJh/X7UxpbQ5ryQle5Yv
	NYU+hg6ZOxRmfVQAdAxq4QQlD7UQAqXNlOqnpTKbJ4SjPPJmnuZ/a70gfNWmK34k
	P2du/b4eLLOIrAXkbNGNmHkumVrBrMc+I60Y785xBBXaFlr8q2QdvjjUmE++D4sI
	lLDBp1W30Mi+ScHyi2Cp21qcDe1nwpr4yiFboAu2NLl2wxdTqhaDYpD7dufvHtZ+
	Xzuk9Joth4NZJin9l8q7lmnOAvsD80UCKbLdV5sdXs6HnVpsox1jnmnr1DsiEPk7
	1Wo4+/AbZMq6w6DPHSzCN4A30LF2Voh7ULP90iOuSq6kEF+nValeC4n3bQNYYBNr
	eM8nhMk=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.11 v4 2/3] net: fec: refactor PPS channel configuration
Date: Tue, 3 Dec 2024 15:15:59 +0100
Message-ID: <20241203141600.3600561-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203141600.3600561-1-csokas.bence@prolan.hu>
References: <20241203141600.3600561-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733235362;VERSION=7982;MC=3845416702;ID=166216;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637D67

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



