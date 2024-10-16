Return-Path: <stable+bounces-86439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D39A03C7
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 10:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66ED81C29075
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6C01D0F6B;
	Wed, 16 Oct 2024 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="JHYIq8Fs"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1A1CBA1B
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066052; cv=none; b=B2n+xDfH73eWpFXU3yYmdwPNxdB1wdnpr375QxyzGBxbMAVz2h8q76uDw7UCDQmCvgunaKbN7j5xkRe+VAWGstBWSoEd7iSiSVyvTyGKNSgCQp28YUTOYVR7NY+rG0aZT94UY1AlfdXDxgAJBG4A+VybqsyphFgQCOkBJrXpQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066052; c=relaxed/simple;
	bh=Go9psSZt+ilblkpj52S2WCvETXqcoVrv8eGFqi0T0a8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSlLuxtIb4BuE57T5AoHupwZos3/WPJqct4lJ/1HhDDhyTm5JvF4VeJLGGG6DPBY0q+xWXdEzgH8zmyHPNXMIqS/ZSoCiRTWjJF64QXsEQe3J7ZUPOV6hQZdhaGNMWLWv1ffO72dIsnLbD8ApmdjYgorTZbj75qx3qD8q7GuX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=JHYIq8Fs; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 4D16AA05C0;
	Wed, 16 Oct 2024 10:07:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=JZ/oOfvaVYqB9uGMCpte
	t9m3bI9Nh7zgcker05X7ZsE=; b=JHYIq8Fsu+Gnc4ihZpDnCtiiHbroDxqphXxE
	c0UaZs04ZOMQXP6auwEWB678RMmyoKq0Q9MqVSuAHn1t73RXszSKNrRrzsHcXt6x
	nl6TxQVN1zS0Ks5ez6E5MlSYt5JiK3rHhL3ZrrO/GGgV24ei3AhvFvwomNY5K4lB
	JzqGCKPeMajfiHmbKsiiRp4RkgOyIVthKElybzOrr12BpSIyWHVwOtO65MbaYewy
	priGsvJS8CzwcjiEgZLQ6rKfDWVi8AKVLuie1SyTgZVbcQCSL8UoZQsyzpd+sRvj
	JnVCbR62m7FmVxsLBagwAB/3lKEfXGgghZAJnt//rL9c/rrhrQqEMad/ApQyaIa1
	fAIPOQBAeN8cQ8WuXMiuxNHPlx8tDaFoT/oNQAmHLR3YKt1Vi9S5dcCTs6cLKv86
	auDjxEzDIInkukUi7UeGYOEf8KSu4c1IhlmdtnuRitkh+Iy+Uqqkj/2oM1uEVTlk
	TSx5GFTRdsE9v3PNePebBVcEhKP6wd6hTmZ/Moa1Mxw35MgUIa/8qqP77yeljDri
	bg2kDN+J7PCscd6Iqw7npc6kPbg3aoxMJldmGBBHk4FKVRemd8F7lg1gfKevvhba
	fDX1ZTVJEXJDQIWameKlZ060qHKMjVF9KN8oo2/yhy0l353J9uTfYAcqNk1Upo+O
	Pf09tZY=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 2/3] net: fec: Remove duplicated code
Date: Wed, 16 Oct 2024 10:01:56 +0200
Message-ID: <20241016080156.265251-2-csokas.bence@prolan.hu>
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1729066041;VERSION=7978;MC=3258465452;ID=74107;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485564736B

`fec_ptp_pps_perout()` reimplements logic already
in `fec_ptp_read()`. Replace with function call.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20240812094713.2883476-2-csokas.bence@prolan.hu
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 713ebaed68d88121cbaf5e74104e2290a9ea74bd)
---
 drivers/net/ethernet/freescale/fec_ptp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 7f4ccd1ade5b..4cffda363a14 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -235,13 +235,7 @@ static int fec_ptp_pps_perout(struct fec_enet_private *fep)
 	timecounter_read(&fep->tc);
 
 	/* Get the current ptp hardware time counter */
-	temp_val = readl(fep->hwp + FEC_ATIME_CTRL);
-	temp_val |= FEC_T_CTRL_CAPTURE;
-	writel(temp_val, fep->hwp + FEC_ATIME_CTRL);
-	if (fep->quirks & FEC_QUIRK_BUG_CAPTURE)
-		udelay(1);
-
-	ptp_hc = readl(fep->hwp + FEC_ATIME);
+	ptp_hc = fec_ptp_read(&fep->cc);
 
 	/* Convert the ptp local counter to 1588 timestamp */
 	curr_time = timecounter_cyc2time(&fep->tc, ptp_hc);
-- 
2.34.1



