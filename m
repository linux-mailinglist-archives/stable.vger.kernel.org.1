Return-Path: <stable+bounces-104016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32639F0B05
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DB6188A516
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59341DEFCC;
	Fri, 13 Dec 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="FEzHLyU3"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50091DE89C
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089403; cv=none; b=S0RXBpw6eAlVgGlnEsm+hzIsXr1lRIhU6slnK52ZpjjI7HUMvAvJdAq9MXir8fIckTpk/tdZIONtp75C8ATeQXJIvDjPWDu+ndG3HYUj2ue19vI8Ho7kqd7gpOi5LY4t3O3IjNo/1ftgfXfMOapueTD5LxSJ845uiNUJuA6rNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089403; c=relaxed/simple;
	bh=dD0V18pPtJ/xK3jYEFBpwOjhPcBRt3wQct94StiKHpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmSc06Nx66/GCzsE654s8Oouedyely5okMDy1oUx0sZl0Xw7R7h+ZXuyKG7JxyGAOuoykgo/NTOfge6DfH/5QRePSQUE3GJ6NxtUDwGbowprtDmySrBxvnV8n9gSj1Yqn0gGVwzRuawHK01z68rZu+KqIcOUtd7SFkuDzeIVFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=FEzHLyU3; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 117C9A0580;
	Fri, 13 Dec 2024 12:30:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=km+RRrzeekuIehBWsb2M
	ndvhd+HsB154iFyHSVb8k1Q=; b=FEzHLyU3IraNHW+gmeHC0kTTAE34/lRF8Sca
	B49GiafGv6dIlXKrm0Jczvp1jxrk/se0kmnGxBn8kU18UjI9UoNkLeIDqH82LcUg
	yAU+0rtG6ij3k7uMBMleL3pM0uinim2Jouc0KXevovmD4B784LqDzcUuUeOBQyYL
	fGJ+L69wPM6zM0FXDFaWuhdfWgxh1Xh4JYFWWQC/qsqSOHDRHl4B7M+/pyz7Ub7l
	BDVVsH7liyMV5rNrcXfMU881oTXG9wAdw+MnylwWHJHfLm5lUCd6nOWIFTLMhUt3
	wg5Yb04A5gpPTFyPv5stgNQwpWP09fPSVw3ZaOTJM0zgFE5wHv+KVdJ0N6F+x/bF
	EUx8PlVuP2+jG9sBfTfrQqo8a6BrVlDWa5sx8gLzi6iksdQ+g54wJruJy23+GlYf
	Omcgzd5hR68lsReoEeb7DUWdn9BSRLXyC+2Sv4JYdiwviliZIVzEdfzaIy/vB+oI
	XCGTrHp+Du1ajVK0pCOP24qr40SfFRiHsvx/3x5M+walMbibtsNwtPho+A1h29yH
	lDUxOl/OZLGIDVfhDBnLFmfujlxxjzBuYjk5znkZSV1iVtVIU8pavBKaqKcn0hdr
	m4AKC8QNfXxUerySkuZybXM37vsJ/q7IuG2oFW/8wy4vtVlnO7Fy5WaQCjjELb+e
	5qByWyE=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.11 v4 2/3] net: fec: refactor PPS channel configuration
Date: Fri, 13 Dec 2024 12:29:25 +0100
Message-ID: <20241213112926.44468-7-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213112926.44468-1-csokas.bence@prolan.hu>
References: <20241213112926.44468-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734089399;VERSION=7982;MC=524408882;ID=408621;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855627C65

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



