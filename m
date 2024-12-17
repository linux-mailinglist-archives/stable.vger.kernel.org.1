Return-Path: <stable+bounces-105029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703769F5569
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EAD16FD4D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A63D1F892A;
	Tue, 17 Dec 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Q2RMLuqq"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C60145B16
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457860; cv=none; b=pz5jlVFbnb7FLpKl1auWs6aHbh4mhW4+WgWbPhMOWIP6W2Q84L0UCWJYBoBxaPTb48lXcUcvoia1ttnQcvcPkYlW9O1bZqMAATOdS66+0Q5GfiCJPE4LiDYkc0Ac8bmp8WQo8zKU8wjoEei1KY2blX6WgxhN9W/V7AgrHbJ2UaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457860; c=relaxed/simple;
	bh=dD0V18pPtJ/xK3jYEFBpwOjhPcBRt3wQct94StiKHpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XoflOIY5p2kla1c/htI+b1LF8cGq2KwDVxV51O19m5n9mRmt5rhhQiFRp/sM7JLa0Tp29NvXZt4fGr+mCd0A4d7BlgwxjoPshMWk9kT5Iu+RrzL+NUgxaimZfE75TyuZ9wvRWdvhjkMY3OG/WoegOb1KQrfyoy2EbqnynTqjKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Q2RMLuqq; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 38AFEA0E14;
	Tue, 17 Dec 2024 18:50:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=km+RRrzeekuIehBWsb2M
	ndvhd+HsB154iFyHSVb8k1Q=; b=Q2RMLuqqF9K0MNgQc1vtaFjPJe6MX9WlylyL
	FIDil+naOx1y9/DhrIq+dEiTa8nKD6unqTIYEHpD+8KbwHTHtn2kDiak7Y+q0+Gb
	xHsyb8YiiBF4GrQ1WejCKtP5oOFoKBHrszU5Y+CGYaUXVU8axyB2vA7P3p9hHlxM
	ak084SrxY6lDyIgGBmpi/RAvbdFtnIlyttq4mKBkIBsuFThmuEpn1KjkKMqqg257
	0w3IH309oMW50LQyyxwDJr6I19QfJxnHFyiFPqSqYwEhWTWJBP30ZKXKXsmID+0z
	OHOcwedsbq2haugJALWRnK5lb7cfaKLAV6MhpZRLT+AWI1rbCD9nPaEZO+0b4Oju
	97SR13v4+HDDG+uLzN+JPPuPfTnmiRJfeqMeV7aUzl5HBnoTxzXKxh2zWcYOcXIZ
	1+5cre8CpJBiQfNhRvuS79y8bMPWxF0wh4IZg9gqan70lL9RiouUi6SxJa0GVYl2
	i/XQorGGZWtDrsC/5R9fh94mPGJWGY+9ocf3x37FGIsPooPnh+XEcMfbf4/k4irx
	MdYn/iqQLkN2TdJneegjj46+TbI7mNzNKybvUFb3l5+K6URJSICl3eAGG9SJWqcD
	07cqOobUs4BYEOwj2vVT2dUu1HqeJ/PV4Ia/X//jlnsYGXcx86rZsgUq8xGJHM81
	bMv+skY=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6 2/3] net: fec: refactor PPS channel configuration
Date: Tue, 17 Dec 2024 18:50:41 +0100
Message-ID: <20241217175042.284122-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217175042.284122-1-csokas.bence@prolan.hu>
References: <20241217175042.284122-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734457849;VERSION=7982;MC=1914769880;ID=67966;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD948556D766B

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



