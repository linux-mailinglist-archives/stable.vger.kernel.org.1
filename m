Return-Path: <stable+bounces-86440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0E9A03C8
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 10:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FEB1C290C3
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 08:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B74A1AF0AE;
	Wed, 16 Oct 2024 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="VY24jwup"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E11CF7AA
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066053; cv=none; b=uq3awmUAifzX+KIL5Sli0Hf+Oq3PIOcl3iwQCX4TrLuXYbSWi+Jmbi2yq5DB4AQQ5zEv9VI8i9F12B4nU1MMQxr6QRMVu0Kkdhxc71+99V3FdAXd+ODrTiHn10mS6yaMEZqfLUgw3KERqUVEHup1ElyUN8xe8wq6vY44UcTCJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066053; c=relaxed/simple;
	bh=PbQ3lwfDaxQX+ZJqQiVsjJaBJQgpuQDcPylKxU9cSvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7BifgqujxWQA22k5yFNujTZEmBxxkB0U1h9Ii5PgNuRqPxfLKHAP7kWPrAUCkh4+m9zQO4Xwlx0hl4GTbk5HYPQLzBbdjdXgG2jnUBCRTQ6t7gFa+diYRedYu+aYUq/ADDwX2P9rRYongtQ6OI97R2YKPaogPRzo0tiZqZyDSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=VY24jwup; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 81824A06B3;
	Wed, 16 Oct 2024 10:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=eoAE4sRebzAWexflSN9l
	W+48d0pmKcrzW0QMv5SY5Qs=; b=VY24jwupFDe7PD16yHS1wzg4LfCh2+m2bn2j
	cdGhXgrDbvgyf4B9/fAzFrZgRWRHbIYcIlXms+vi3lSi+7k1Txt3hCkNts20UXY7
	gKPIJbte/v7Y0oH6490lZO3QgBIFngzb3W7pIRr72/cjopSEGMdBZ3wnDjl0lWJT
	tRPOY2zxBqkq+qXkK4zg3dA1LfScw6nUtQ8uB2pIvQZTUfqtyq5MO6xhDC5O4dUg
	7/25903MtizoM+4YpJrinJZhGjd2gafzt/3pM48RqolRs9j+Vb79vmwMeEm9by7D
	ncft8M4FyQgBq4Qux8ipDcFtUrbuQJNxaLBVUTp4vg5BG7X6pMlPqYHCnKkwr11d
	E1MnoY2zdg2baqOgYtitRE0fVBVvQYh0QhruyMhLsCrs74UrTV9YSzvgAkpV7NMq
	lThYLBph2WoNBlG6IKgeCRKKzuq3MWwWHau2nZiwMtT6kla9hSOEwMd0M7p3UE2s
	NztYskPOjChz6V/xeOVMqq1xCR1iwJw1osDCyvXq7qxxSuikFHZuN9lvRi71SgtW
	p0b4C6Hbxxw3sXkx5f8cQ9tedEKUSY2m9Ee01rpdqn9sWkgGEvoI7mjtwk8AMjfG
	ukTlvNzbA1ur5Xh75OFpOTa13SmEKdmeNr/IbsrJwf/1+Fzj7PGWE+csY1bn5mWO
	rhgHhPs=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Frank Li <Frank.Li@nxp.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH 6.6 3/3] net: fec: refactor PPS channel configuration
Date: Wed, 16 Oct 2024 10:01:57 +0200
Message-ID: <20241016080156.265251-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e437a6ba-292d-4a0e-8e81-074c84045b26@prolan.hu>
References: <e437a6ba-292d-4a0e-8e81-074c84045b26@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1729066043;VERSION=7978;MC=848656463;ID=74108;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485564736B

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
index 4cffda363a14..ce7aa2c38c7f 100644
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



