Return-Path: <stable+bounces-95984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6208B9DFF8A
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD0816220F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A121F9407;
	Mon,  2 Dec 2024 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="SKrWFxAl"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C001D63FB
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137264; cv=none; b=f5IJnO7JyVyAzATtrH6cmGZsPjTXIiBJaRTCvZEoth+twTYXYqnAmk/MGoCqbNC3WgAP+KqvKOriYJknCXWwRRPJkfBBw9hBbCLH9tbsNsd/J4jVQHYqC2A1yiM+zNsamxDRDlOWY597nfRIaBsQmUsR9pmxX0qjcaE8KuNaeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137264; c=relaxed/simple;
	bh=aSZedKbuPc157SNY+ud2LPqNMiL56Izhqed+H4NGIsI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHNQolxSTAkS9C/orCLxHiIfNXO8+0XNEPyvbqoGW8Yf2c3haOMbdlr5SpS+6HC/Sn0FkmFF4+J7uo90ZlTOtli2O9urX48tA5XBaMBr2yXIehRiDlLMzx7ShSdmdPxLNh3+W4ql86TeSpTBr7WlYswF0Lp/CptLNHqu4hHabT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=SKrWFxAl; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 36244A09FA;
	Mon,  2 Dec 2024 12:01:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=L3M5KJ4s1bBrYtSP+XK8
	qdQQXjNqeR0Qz3i4yctLQ0o=; b=SKrWFxAl2/SJypyQqhF6e3ijTcPccfMgoYs8
	L4XRQHPc63VKWTtaspbPqpffwbt5Bfjc0hCmanTkmz5D4EYdmLMMDF/xVPPEhTCX
	o8yi7kfjnBEz/i4HPCoEqAGTaNnkZXde/dEa4y/BiF4itH9lAyBoEIkVtfqmgPHz
	F1KUl+1fAW/a1DQ4u9eVAnIMX7oiOT9hcgWdAqyv3KEN22Ri04DDuBLcoBSZsXl2
	o5e7p1OstKMZDfNSTt4f+RoF9GfAXLC2VDKCFkQoDezLP2uuG82CZ92sz8aNrp2z
	8eiOWlO/4PW5iTikFtujx4PqZ03fQLBo0S2JpAJMcJnoznB4Nxd5ypdCDOmvRtNx
	yBmNcOvizNjJk5DBi2sfWN7ORTwC/nQaEtP2XRnC2eaNIwTW/lWDQYFHl/OPwk7j
	Mv62ZCC/UZO3iqmJ+e8Py+AOsi2A8CIJDjycGKGGZ3kj+BBAIEt9jNPA16MV8GzT
	o6iVZxd/+9WxUmD+Jpc9oRcAY7jDXkyD7D+XxW53h4lnqvaOLxzwOToSfSDakqc6
	tRc4SflIO+qFsA9mWKc0ifWDttzvP+4pVw3Z9csHykQeaWB/NnmIfk09D3ZHcPw0
	TvBicMmTdnrgtHw15Q6+rIv1FdhEcJ2R2X3SqZXT8KEMGyHEeqHRgQrKBbXFbWXQ
	X4p8KPs=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Frank
 Li" <Frank.Li@nxp.com>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?=
	<csokas.bence@prolan.hu>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 2/3] net: fec: refactor PPS channel configuration
Date: Mon, 2 Dec 2024 12:00:00 +0100
Message-ID: <20241202110000.3454508-3-csokas.bence@prolan.hu>
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733137260;VERSION=7982;MC=3048299702;ID=155738;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637263

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Preparation patch to allow for PPS channel configuration, no functional
change intended.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
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



