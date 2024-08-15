Return-Path: <stable+bounces-68833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72649953437
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFF80B28FF3
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D31AC896;
	Thu, 15 Aug 2024 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qknL03s1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40317C995;
	Thu, 15 Aug 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731805; cv=none; b=fxgw2oui25doSJSgLq2BhRz6LkqNj4CqF7Ni0sLsNFG5Lm93WX09/OxEwmGWUY/HP1+peTv2lO245Yg7pN3Ly8AElypH+4ZHdFinvacPtPXZ/ZGW06Pw3594ocoidVmiy4A6WXOMI/kR2f/dIbRzX1/cwAsO5OHI66pluWqCFJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731805; c=relaxed/simple;
	bh=gm7IZY3N+ErRawlrqbSY2sGmE6Yps86qiaoIaNd8uAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyOjiYrDePBuiwj2ksmwRxAm0nkTsBZbnPG+GqJK8Rzscm95FH17Y2yrQDsdukLyPrFUABDUqX5uSVvantvb07EjytG1nY6B6KcAmWHRxGvg4f0bgpNO6kAosko2jjIA/Vcoo+D+Og/LqaCul04jGU7kGIqe/dN30QNpLMap/Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qknL03s1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584C4C4AF0A;
	Thu, 15 Aug 2024 14:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731804;
	bh=gm7IZY3N+ErRawlrqbSY2sGmE6Yps86qiaoIaNd8uAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qknL03s1Xl52jZOPghAtPqKdDYJ4yciRh62jU+8ab+Z3q4X9VA05dugIHAvBA/jW2
	 ojRG6nF+3+JriM1m4Gr6QQHL2MhazLnKNemkDqwhUR7rYrHuGu3vS2fuLrkXld20AV
	 mQuDiS3LsKE3OEX9O4imsDzVmdeoa4mLsLBr5NHs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5.4 244/259] power: supply: axp288_charger: Round constant_charge_voltage writes down
Date: Thu, 15 Aug 2024 15:26:17 +0200
Message-ID: <20240815131912.193400019@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 81af7f2342d162e24ac820c10e68684d9f927663 upstream.

Round constant_charge_voltage writes down to the first supported lower
value, rather then rounding them up to the first supported higher value.

This fixes e.g. writing 4250000 resulting in a value of 4350000 which
might be dangerous, instead writing 4250000 will now result in a safe
4200000 value.

Fixes: 843735b788a4 ("power: axp288_charger: axp288 charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240717200333.56669-2-hdegoede@redhat.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/axp288_charger.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -168,18 +168,18 @@ static inline int axp288_charger_set_cv(
 	u8 reg_val;
 	int ret;
 
-	if (cv <= CV_4100MV) {
-		reg_val = CHRG_CCCV_CV_4100MV;
-		cv = CV_4100MV;
-	} else if (cv <= CV_4150MV) {
-		reg_val = CHRG_CCCV_CV_4150MV;
-		cv = CV_4150MV;
-	} else if (cv <= CV_4200MV) {
+	if (cv >= CV_4350MV) {
+		reg_val = CHRG_CCCV_CV_4350MV;
+		cv = CV_4350MV;
+	} else if (cv >= CV_4200MV) {
 		reg_val = CHRG_CCCV_CV_4200MV;
 		cv = CV_4200MV;
+	} else if (cv >= CV_4150MV) {
+		reg_val = CHRG_CCCV_CV_4150MV;
+		cv = CV_4150MV;
 	} else {
-		reg_val = CHRG_CCCV_CV_4350MV;
-		cv = CV_4350MV;
+		reg_val = CHRG_CCCV_CV_4100MV;
+		cv = CV_4100MV;
 	}
 
 	reg_val = reg_val << CHRG_CCCV_CV_BIT_POS;



