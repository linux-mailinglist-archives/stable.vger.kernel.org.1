Return-Path: <stable+bounces-96114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03649E07B7
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85191281AA1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88910757EA;
	Mon,  2 Dec 2024 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="ILlnwjtM"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB5312FF70
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155042; cv=none; b=XxrYeFnLxY4R9dheVNGmuwfoUN2nK+zTv0UwPSI0j7+/I/EtKTSARHF/gOYmk1Z/zrHGiUPZpr3CaP3uT7RP+poH+j/00N8XdqqfhPmEJdFo17jf9uDNYvPSbgm1mXZ2Za95kUYWzzM18NFjBSR+quC3nJt7CPaV8bZeifrZoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155042; c=relaxed/simple;
	bh=17ic6u8a2Bvo+vx670R/sedCYSWel8wjM2LQ4U7aIvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzV2SIEwfFcgXu40BzEtPHIS3McnZB3v1JORpLxUQ1CQDf9Dgwgrd/YX/NvA9IJ5iraT5KVX25IXsl/pMAyTRvgxi/aBsVOtUrlaPEswxwO7+kzAGH1ngDfDpqIowLFC15mqb9ZZNnnX+fcjNSAZRyeN2zzMec0zRLnD7eSNcxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=ILlnwjtM; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 62202A0895;
	Mon,  2 Dec 2024 16:57:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=HuA3zgq41U+katKsYp5H
	+YNI3j4ahVT5oYw1VTy9j3E=; b=ILlnwjtMy5q1UPdMvrPvbDbXNcV7RdRlEaiQ
	7/ayR0QzT7ZX6k4i2JSsnHb8GeTAMkQC7QfCPMQxl5k0jgcUSrFlkdi5S79hd+FM
	l/0NgW19VcuHVAO/LMRmFr3MDQq5wHu01SOjqQGjdnHjinus8M06YoAvS7hzlNLL
	DeviRslQCYoaGaCnyTsEDGiwMqQ4CgZ13IOnA4ZGvL0/TOEcYlz/MwDewWfJRi/K
	jfZayX0CorXXiP3tl+47Dhr3yMmGSUdBao0+meBsJufRjdXNgu7z33oGQEAma2um
	qNlq/13NKo1IUl2AHw6z5WfD+4Fy63Qtze0E4rs5UEmxh8r9GdhdF8/Okf988OFy
	EUg4a2Od2wxYcoJXV/9J+JvfFTKOI7UgQPkqeG+BtNVrPzg1b2xwrL03aYYoOKid
	W/Z8AbJb381wvr4ht9+rEKtg45c57XbOZDSofeb1FZxHjTdrX/izAcpR7k+A/Ti/
	E19ydpQRx3b2WiIiJ0q0flaqnuJvEi4GdfZxERp/8soSczssD0pSF/CjAL0LjSrq
	gma6mwGNS7Hg7c9kne0dw5f5ztBC2ZLpD0t4eg/3l+b8OqPWUHHX999KiFrrR7hX
	hbUcP0h4gfd84r3AhoMGgQt30mz+eNcxZcfZnsLRIjJHTXWnX8MSHu3KGsOdr/DW
	WnO4Tws=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.11 v3 2/3] net: fec: refactor PPS channel configuration
Date: Mon, 2 Dec 2024 16:57:12 +0100
Message-ID: <20241202155713.3564460-3-csokas.bence@prolan.hu>
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733155037;VERSION=7982;MC=2258809466;ID=157280;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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



