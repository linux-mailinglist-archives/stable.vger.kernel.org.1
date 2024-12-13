Return-Path: <stable+bounces-104017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8769F0B03
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D257162BEC
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9371DE89C;
	Fri, 13 Dec 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="pLemdJJo"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36EC1DE4F3
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089404; cv=none; b=EJHWnI+X1ygvXozfAnXxvBgWjzlTHWpFM/yQNqfz2tDiALI9LTkXGgD5SrVYj1M8lc9UBuyteuG9WhIMQbSsTGbMpHbgzZCTXmXfyTdJH4qSBzFxpxpq3jlG8pwyiOtk+ZaZ57uAhHnmvkD0LNSgJ5cfkwnhginSxSZhSWiWEug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089404; c=relaxed/simple;
	bh=dD0V18pPtJ/xK3jYEFBpwOjhPcBRt3wQct94StiKHpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sG2lL3c6ZwOyGWTSkbPU6Nji2zfwZRGOokJW4k/OYdVi4enmUwLyVJ+4eDfgymsqdwm16svL0yKZNdcGRDMDcCyv7zlNcJl8/Z/+zRynqBa533PP5WZjWjYEsnU8YsaVhrkOQ9AzmMwxF8GkBmeQDwZgU0m3qKzqKYK9Cyx/iJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=pLemdJJo; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 1141BA0361;
	Fri, 13 Dec 2024 12:29:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=km+RRrzeekuIehBWsb2M
	ndvhd+HsB154iFyHSVb8k1Q=; b=pLemdJJovPvkGLXw0nTfqi1iB2oQlXf1QGa8
	H8Pkz2/6wAJyy7496xp9e+mSWMzNdI2UB6miBzWjaWjGk6DxppDSe4nx787wZ7zg
	n5TzHTTBaGAP6Bc14DrM3kNTh4+FLK99glh9cKI5Jwsi8oVNkLD3Ryv0GYmormg5
	C/2gPy9N0h/PJpNR9i/nWo/8xuAfapgG1MPuiRqSk09va06krt+nozq+5kZX7YnS
	pkAGU7T1uijsEglAcEM4r3O3dqtxEnDayjBbunlKTUR6Hfhm8YC/o6bSIVJ+z+wH
	p/Yp/gOPxVNqrPrXzEu6f6ZmmuPE/0eWw/DTHcBSUxPNaSPsFXMmKCzDXgiAvnFK
	pk5qDhDYCDt94E5zDcn2pcelplDYWWW367+aTeVhzygPpLHJRxjA3PshobNH1e1T
	min3ihiYPyZatpX2nGNHfLzXXsfuE/gb2e0Q9o0dUcGVG0Sr7NjC5B4L4L6I4mvB
	wy0NCv8Ux1UKp6vqWl9fT6kqEfH3DxoQjqyxJZBzC5YN+FhfC+QDMm3HfWhnojcX
	wcRJk+vfGXeSvlmbHJ0NazXQKybhFdXfrXCfc7jpho6QH6E4PWYU3fQqPPv0XoVT
	uIAF0FFbdburpXN6by6KntWyX1kwfjg4sCAEN0LUL3W0l5HfCt3bDAp/pYdhwAD3
	7KaR3Tc=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6 resubmit 2/3] net: fec: refactor PPS channel configuration
Date: Fri, 13 Dec 2024 12:29:21 +0100
Message-ID: <20241213112926.44468-3-csokas.bence@prolan.hu>
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734089398;VERSION=7982;MC=2956509981;ID=408617;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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



