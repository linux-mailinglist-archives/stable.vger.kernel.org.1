Return-Path: <stable+bounces-86438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AED9A03C6
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 10:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22091F2200E
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F34E1D078F;
	Wed, 16 Oct 2024 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="eB5rtUFj"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22DF1CBA16
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066051; cv=none; b=bUXAuQXyqdRB/63hhxqWP4XmvLj0YXeMOA0DBsHcleOVoUWeDIPxAzbn90sqiQpucHpYcxeGzw0cdb4uHv0Zc5A7UzbolphsqNWIlVB+jUzz1O6TkwOXwuy6UlQeUoxi0Sk7YBCFKA8BE1eBkWYlZ1Zx0O8GgR1zPTrdaUxoZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066051; c=relaxed/simple;
	bh=2A1/T28pJuMbDL/wdgM8e/noVkWTePThMeM7iprAnMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7s+trwc4HnNixCgB56Rm7uhLcwsC7vad7qt2lQb3hqEfit5ZOTgwztOw8Q63qPVIHve65lNX/T7kpKzX4YMfOC0ElQfW3F+BahEevcN899kiiYJygVib87Nnaj2/nSedL5pGTR1rD2W1/J+A0lH3o9fgpdc9N/poCATT99sr98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=eB5rtUFj; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B0C49A051F;
	Wed, 16 Oct 2024 10:07:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=fbvROluuOUX1xq03BOp0
	i9zqE+9GsA3bL8TniGDfS5s=; b=eB5rtUFjy/8iKS1d9hCOxab7WRU9ebQ58N8d
	2qWbhwHgoVOCcX8VlIxYKTai4a+98IrIEhaXGOgQ00hWXXwTbZ7v9CWslH94kuy5
	awTPyv8/bEaxRc1QADBfMizPzgjx1fDgEUlBcHSl4ooUMGoMT6mu895vVak+TJIq
	yRtnhPHlKobhrobhjMVPLp4/9RutaQqB31jDMy9nUbZKTl+Yx4j60aq6IOFxCD8R
	F5VfyOYgYB4o+rQwJKjUOSgeQRua3IbaGQ2DI0sLqqnR6t8PDTajmu4JEts6ehjk
	1I8y2IsalHm2bIwfPz50ONHWiKXIrQLCB/oO7RKCL/hod2uHNIuZF9UV7eXQFUzy
	qksokNsz97uIs7RaNVP/5S4EtpE2VXAAzgZmQviDLE0a++iQ1cMb5ODYQqbUKoao
	9Fd2Z0X8oAbVvJDtsCBb7wwuMKf0p51DF8BDu3eFtivQGhdtq6ISCN0gHIzLtqY2
	T6MTVV1m0hl9PCAwC25jOmft2FUHKR32ptUIdTryA77srwr6b/WwzFOunVqG6auA
	IcduAKbVI6wV5NSPXsYOFQ0GKZ/MnPuBn6lSRQ9z1SGCsfhxe7rUEHxzEjy1FDXV
	Ydj61ASGEKpgqAKIc5xpanBO9uckrKFmou4Gk+rO9pJkjfRaH6Q8AVibKws+pRe/
	at3sbmU=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Frank Li <Frank.li@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 1/3] net: fec: Move `fec_ptp_read()` to the top of the file
Date: Wed, 16 Oct 2024 10:01:55 +0200
Message-ID: <20241016080156.265251-1-csokas.bence@prolan.hu>
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1729066039;VERSION=7978;MC=973097388;ID=74106;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485564736B

This function is used in `fec_ptp_enable_pps()` through
struct cyclecounter read(). Moving the declaration makes
it clearer, what's happening.

Suggested-by: Frank Li <Frank.li@nxp.com>
Link: https://lore.kernel.org/netdev/20240805144754.2384663-1-csokas.bence@prolan.hu/T/#ma6c21ad264016c24612048b1483769eaff8cdf20
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20240812094713.2883476-1-csokas.bence@prolan.hu
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 4374a1fe580a14f6152752390c678d90311df247)
---
 drivers/net/ethernet/freescale/fec_ptp.c | 50 ++++++++++++------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 2e4f3e1782a2..7f4ccd1ade5b 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -90,6 +90,30 @@
 #define FEC_PTP_MAX_NSEC_PERIOD		4000000000ULL
 #define FEC_PTP_MAX_NSEC_COUNTER	0x80000000ULL
 
+/**
+ * fec_ptp_read - read raw cycle counter (to be used by time counter)
+ * @cc: the cyclecounter structure
+ *
+ * this function reads the cyclecounter registers and is called by the
+ * cyclecounter structure used to construct a ns counter from the
+ * arbitrary fixed point registers
+ */
+static u64 fec_ptp_read(const struct cyclecounter *cc)
+{
+	struct fec_enet_private *fep =
+		container_of(cc, struct fec_enet_private, cc);
+	u32 tempval;
+
+	tempval = readl(fep->hwp + FEC_ATIME_CTRL);
+	tempval |= FEC_T_CTRL_CAPTURE;
+	writel(tempval, fep->hwp + FEC_ATIME_CTRL);
+
+	if (fep->quirks & FEC_QUIRK_BUG_CAPTURE)
+		udelay(1);
+
+	return readl(fep->hwp + FEC_ATIME);
+}
+
 /**
  * fec_ptp_enable_pps
  * @fep: the fec_enet_private structure handle
@@ -136,7 +160,7 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 		 * NSEC_PER_SEC - ts.tv_nsec. Add the remaining nanoseconds
 		 * to current timer would be next second.
 		 */
-		tempval = fep->cc.read(&fep->cc);
+		tempval = fec_ptp_read(&fep->cc);
 		/* Convert the ptp local counter to 1588 timestamp */
 		ns = timecounter_cyc2time(&fep->tc, tempval);
 		ts = ns_to_timespec64(ns);
@@ -271,30 +295,6 @@ static enum hrtimer_restart fec_ptp_pps_perout_handler(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-/**
- * fec_ptp_read - read raw cycle counter (to be used by time counter)
- * @cc: the cyclecounter structure
- *
- * this function reads the cyclecounter registers and is called by the
- * cyclecounter structure used to construct a ns counter from the
- * arbitrary fixed point registers
- */
-static u64 fec_ptp_read(const struct cyclecounter *cc)
-{
-	struct fec_enet_private *fep =
-		container_of(cc, struct fec_enet_private, cc);
-	u32 tempval;
-
-	tempval = readl(fep->hwp + FEC_ATIME_CTRL);
-	tempval |= FEC_T_CTRL_CAPTURE;
-	writel(tempval, fep->hwp + FEC_ATIME_CTRL);
-
-	if (fep->quirks & FEC_QUIRK_BUG_CAPTURE)
-		udelay(1);
-
-	return readl(fep->hwp + FEC_ATIME);
-}
-
 /**
  * fec_ptp_start_cyclecounter - create the cycle counter from hw
  * @ndev: network device
-- 
2.34.1



