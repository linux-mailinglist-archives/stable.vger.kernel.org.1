Return-Path: <stable+bounces-96024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7289E02EA
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F10162428
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8331FC115;
	Mon,  2 Dec 2024 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="aP9JWSkb"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC461FA15B
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144971; cv=none; b=FNN2iil0WsLFJzDucBoWF4XWzz3sfrSQO2+C8Z5OoJ6TwFbOlt0gs4wA4TfYARG2ET13q/K3OKL9vTu76SmKDEjLpxkFH2JUlabpYY+qE+HK1r1R6VIMASjJsFfGUSf/+6UuR+9MXlkLTjz2vsjKQFMHmJFZaH/fIFdCp/Rx94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144971; c=relaxed/simple;
	bh=yDNJAKGdyZ+r0Nn0U16UdDvuDZVmFYECRFW4ArFw1lg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbgQr5AJcNag88iW6gEPe1KjmQr4uhfsq7MkYxyTW8yZ5oqFqg4tzMFXQYe5p3PiJjwP9fGY2fIn2ZLkpWdCNmxEY3I/GaHhuXlyEEQ+koIwGTgIak6SAX4G+W8kjrM3JIycHZO9rhglQliLj86Hy84wcCJuiy5XipA8l32EqD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=aP9JWSkb; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 72D6AA0365;
	Mon,  2 Dec 2024 14:09:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Hyebgrl5PkWtsQO0HwY7
	FrqwTpEMMdGIukYafsPBExc=; b=aP9JWSkbBn/CYZYrcAVJjBy1aDnoVQznKtUw
	5wQiJVisPsWSWNHVtTNYJv+zPIYxA0GPJjB+Kj4qFYrE5xs+RRo9igOfpth0QETO
	c0rE8iyvbJpTyVhxkvPbkkt+DkWARldzp0x2crizXEtHhtcUAuLrtsaphyIYiNZ4
	ZwqTd649HTtxql0YF6/f9rCrEJWd6xubjrICCd3/z9mMLKcPuOSkeFOZVYaJE5d0
	eTuM6Z7/m1ZBTyeyK7NFUDPgC/tPtqD86T81c0Dqg1ayHV74ixWGJjwTwlL3LMHH
	4SWkZpxUBrTZjDcHi/8MoKZ5k8Du8rmM3DlzkQW3C6ZUPpXfkqA1sjtE7j3SjxT1
	9rH81VqxpBMEMAY87/c4CAlzrCIGNSbvYOiOXr/5Op4rhvY5F5T+bX7rbXWYa7Xs
	wgiWb+g55wPg50Q5kV43YoytfEGpuHZp/y3iY49liSGHytXuh071XwIZo5C1JzOj
	6Jy/Tw1JJT6+sPMInq7tuy5X8KpwYszgW9kg5vW3aQTuomMEd7SqtjPcWDGcHJzQ
	TMxe/V55cmRZgdo++3OfYIW9X0EpBqM8AbIZ4QuC8SkMVgDw6cyyF2ASnjE5TX9/
	UVnJXzwBDD5QuYMOxgf2sTKO6pONSSsEeWmQ5KTeGQcHEkkRMPc/xUG+wmo4uN3L
	bUVDzsw=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 v2 2/3] net: fec: refactor PPS channel configuration
Date: Mon, 2 Dec 2024 14:07:34 +0100
Message-ID: <20241202130733.3464870-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202130733.3464870-1-csokas.bence@prolan.hu>
References: <20241202130733.3464870-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733144964;VERSION=7982;MC=3818365594;ID=156982;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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



