Return-Path: <stable+bounces-96274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142FB9E1944
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1E1287A73
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04481E1C2E;
	Tue,  3 Dec 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Av+/tUnk"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6AD1E1C3A
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221784; cv=none; b=Vgd08uJbEyF4f6d2+x4QNrjV94fVMMFZT2PZ0MjgMoMXBcMkve8dLs7+qyLPgjX4v02hIFa8l5v+4atnqEMdE5PgtgShF8S5CYVJNxbcxtCUoWXNiWFyVLIIoYiAhMdUl5v15guT+X9qfXu3UU+c3UX/i5PCvXv4HnqsYdbJApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221784; c=relaxed/simple;
	bh=dD0V18pPtJ/xK3jYEFBpwOjhPcBRt3wQct94StiKHpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cocdJT9H0tTTQjx4lihuDZ7YhSd3zFX7E8RkS/dBYih2mg7x5n+HK0Ypk8BO7U9txrcxfe8ecnyyJolkP3ES7VMxNBwy3vDx6/EzhsYj7joWV7bjW1/PR7trQivqnMLdWEZoBmB6ILkuUVe/jDDXC1Q7JfAmB7nY+r670QIh3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Av+/tUnk; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 857F8A0120;
	Tue,  3 Dec 2024 11:29:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=km+RRrzeekuIehBWsb2M
	ndvhd+HsB154iFyHSVb8k1Q=; b=Av+/tUnkbpC92w2HuRM5h2gjm1Rlmer/bDGj
	LAAgNWuXWjdU5RS8QzJUwlnFYLO9bLPGZ2XKGRXb6++TTDVWXHoPpOY2seNLeCOZ
	9aOfytKFia6QdH1in7rBIar1GJTeoVePfnLIcgtcgxeZQBlXG+GNoE93pbsOSjL3
	YEW2Bx6yMJorTDhg4Povnm9/BtLsXGM3KrDQR1qX6/ybjkTKqQVKtE4PzSe8z3Yk
	fGdb7v0sqfN5uyzbFlt+YsHONTqjJb/wKyAAXsKIjOzIqI5QY/4DFqzXwK1CiQSi
	4rbtELV1LkqIWzNWQkCD8nJp+hMrsgZxj2Cw4I3W9H2kfSDq2JizoVGb7NH8GOpO
	CDc+iO99oCAHHSNqnW//iOM8E+wzdxJrkdazLSXWLLPGmoLEiuH7Rv/0tMs76XnD
	cs76WD9+xBKU7+shi6mHyxtLBAxx4yPlczTJk6oplATvptyFoqbiUiiSW2W+Vak9
	wzM3KkacR2Qi1LvfoWi0SctugkcdxF5ItS1fr7pAwqRFJZC8jCuPaWeoIq/nwECH
	6SQ6icxe9It0I9SGFcUZBhIokg/gro499rGtzOHrfnzQYlr9YOeK0bdpSIplY6B/
	RdR4zVGKPeIq81BkXxdvHGF0je289jvRgL1t9aulyFkOuuYbs6slMJdeDFfa95Zn
	PRcaw88=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>
Subject: [PATCH 6.12 v4 2/3] net: fec: refactor PPS channel configuration
Date: Tue, 3 Dec 2024 11:29:31 +0100
Message-ID: <20241203102932.3581093-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203102932.3581093-1-csokas.bence@prolan.hu>
References: <20241203102932.3581093-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733221772;VERSION=7982;MC=121583667;ID=156227;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855637D61

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



