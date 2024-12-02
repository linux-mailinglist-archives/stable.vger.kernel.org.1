Return-Path: <stable+bounces-96118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267A09E0AC6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C381B2DA59
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FFA137C37;
	Mon,  2 Dec 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="cbT9flYE"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9680604
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155085; cv=none; b=XfwFGk5T6DPEebcuTX77SukcREbBljqxr84Nwe93ath8xFWfgrBCsHCCvKrXFBlh8fP3/mjxNc0QxIMRgrMSm5wDzk7sJ5w39+uR7/aAfBunhvyi1+QpIoj1cF1dbCrwz1UL3hGgJrAcoHRJkfdlzf4Jah6l/IseEyuvM/9dVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155085; c=relaxed/simple;
	bh=yDNJAKGdyZ+r0Nn0U16UdDvuDZVmFYECRFW4ArFw1lg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcuE5bgDMbtHjro6cQlwLqU/jv4qvV4iPxyWAYDDhc9JJhZZdLQbxH+ODN8KZj1zKPIJOvIBm7O4l6JILVO2Ui+6oBkGpHB6iQVPT4piKLs4o/qwIdr+H6AJeY/BK7Lzdf3RILwBFwTlUox0zyR7wqpvjt3HJdg7vHATWqYgAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=cbT9flYE; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BE91FA05BF;
	Mon,  2 Dec 2024 16:58:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Hyebgrl5PkWtsQO0HwY7
	FrqwTpEMMdGIukYafsPBExc=; b=cbT9flYEEcM8Ybwecft93GITZJvt1fF9IdX1
	Y7v269IwmzCP6+0FQql9lcZZV5a1xI5AcyMCn18KnJQEF0UJasYL2K90QYU5X5/M
	My8Hoh0Nd3ZqO64vLP75sSn1xtyKt0WRSmnMmpNHJSnWq6pqTILV8av9rTaqVb3I
	PMXR3k11WIBT5sgmtLf3ArRszT9tArTABTjJ4oQHLpOUW4kQfFK/9udRI4ToWlnU
	3jLLkX0h9XR3MzSdBeWdL7eeJjhvwf8HwqIeDq+jQEaTWckQEBjiAU0r+bwCZzyg
	+Rto0wNS/RYO16fqqzF6CfkpR+QG5ty95n4F05vrMZ22LF6/YZ3J2UqxLcIneTye
	I134/sSG4wRYGSm+jQq9tng3QaYJC3AiwRn8Hoq5Bs/Ta2nbjGmWZ9DY7jP3Ur9p
	bo9WhlrjsJYjVZd7hoexqaAs8wAj8Sv8dkLQL09JGT63HEZCX8LiS9JlWwJ6NZBo
	FevJmsrqqL9MJlyqjYX4zTQwSBUKJgTnKcNI/kmSpjPYuT6MLeBbTT+i51shaCi9
	HgQt63+DvG7dc+sHG6SwKe5S/RyKO6zKfpay6FVJvnOh15ownBI69BIC1VrtVqdQ
	Jjo+LKCTyn5X36ehetzkAf+2gW5CGrWJORvWkDG+mEnm3XPInbOSEgvwe1euh8d0
	MWssw/E=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 v3 2/3] net: fec: refactor PPS channel configuration
Date: Mon, 2 Dec 2024 16:57:59 +0100
Message-ID: <20241202155800.3564611-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202155800.3564611-1-csokas.bence@prolan.hu>
References: <20241202155800.3564611-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733155082;VERSION=7982;MC=3068387182;ID=157284;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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



