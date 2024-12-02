Return-Path: <stable+bounces-95971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEE29DFF76
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47099B22448
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E731FCD13;
	Mon,  2 Dec 2024 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="bVandld6"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D201FCCF9
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137054; cv=none; b=YDfPfzxNR1buTgRxMtJCZ8OVKf1i204dhxEVNu47iC+ODF6uw0tzLg79pXbm60XaTFv7IAJv0ZiSYi9bD5IwHYbLXN81uK+30IMa/vO2MzgtZlVh5HQ7qWfByKdRJ3nlacbAiE2Ljhkm7oYVba0P+kogH+AJdEac+Jb4oCn0KIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137054; c=relaxed/simple;
	bh=aSZedKbuPc157SNY+ud2LPqNMiL56Izhqed+H4NGIsI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADDjRxLG40kA7VjGvznz8p1XT+NRp/edPDSAlG8xZj4A+HvsJn63BqHWOyP/D6vSW0BvCtS9X4Gz65R8xGq7cqKr3+ACWP6Zc8a3TOkWI/WRWjXC+zKki1HP9aoHq6jf3WA2udN1jnAdE8mLiQL+i146HiHKtVw0PpfOlmAFWh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=bVandld6; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 43580A0776;
	Mon,  2 Dec 2024 11:57:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=L3M5KJ4s1bBrYtSP+XK8
	qdQQXjNqeR0Qz3i4yctLQ0o=; b=bVandld63F5YX83+qb4H8Tg2TDxOlM4NiBp7
	aNl2LDVBuMik6//em+yF3sNF/c9KdmKAA1KmMc8AXM4PnINxkZoAvknBXmg2i4za
	jqiTwP5icSYO5VTFR1GaE06K8ptMd9mAolT/KIqf64FhDA/vcN1z7Kg3lgx3bkCQ
	C/BtSUWuZQtZCEz+SaqjlxN6s37ZSfZK58VsVkJ6PVcspS8elI1803j/cvQxYFF9
	NDY64ly2pcouz/MnFdfI0nvQcGZ+tyQhn713gEe0DmCrjO1XcCQq7/vx/YCQjcGK
	jqo88wP+meelhTnqqJbREh2mIx7+U2iLNjxm9cDD+jbATZtDWzb7c3OPhVbMrjpQ
	YzhETR8HWX6bM5dWF8+9ZgH0bCnO1cblD5JOWwZEiJunPRQoGdnMYQiOI27eC0nC
	8DNdDUFUy2z/1pOH08n5CoboIqjcJrv9iiATAeEM2VtG4jOYc9GEqPxzMfaZgFi3
	OfrQk3vtC+Mlvvn3XOUU3ZJT4XauDFv33I1sI1mmq6CB97UO8EL2gZ02851gpK3c
	NMnwZ3M3b6VwPZlgUs6GX4pyUElUo2jPuFk2yeUcdd/7tIrmPNCk5CCcjLIk6a6b
	CtQMlwK/9iWhVrUYqc/vafusycKWttZbVdD43E4rTVlW9kuaO3zwB+WpLUeiraU0
	ssdLsYc=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Frank
 Li" <Frank.Li@nxp.com>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?=
	<csokas.bence@prolan.hu>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.11 2/3] net: fec: refactor PPS channel configuration
Date: Mon, 2 Dec 2024 11:56:45 +0100
Message-ID: <20241202105644.3453676-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202105644.3453676-1-csokas.bence@prolan.hu>
References: <20241202105644.3453676-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733137049;VERSION=7982;MC=4176945249;ID=155632;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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



