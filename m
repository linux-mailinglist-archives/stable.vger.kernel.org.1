Return-Path: <stable+bounces-69205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5E9953608
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C211F210C1
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A461A76B7;
	Thu, 15 Aug 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xu6Z1pAY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925BE1AC893;
	Thu, 15 Aug 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733008; cv=none; b=cyjHKfbBvuP9s1Hfip/Udy52TJeX45ePNjYKHjflvlPuiXL3s86gYcI8qub62CKhxywthWHD4X1yS6DJUTbZtOL8JdyLaYy2IFjHNnlpwf7WZff6eSq+72xYuopC9loTZAbjXKo18INQe84b2uuf3SgmOg406+mzlr/nDsHkr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733008; c=relaxed/simple;
	bh=LeRwTyAiYFguLDDdGK7TfP+fTYs65pdyN1Ww8cOqvKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cb6fiOLDUBbqoNLYm0fNm2+I6yjk6XlNKYN1mQ3IZUfB1vOMxkPP5YbD58SvRt1CxaZGjvpyqZAI1ztRnh+8yYOXWiQwf9YZft28C71Q2aC6HS721lh2m5fh948NSGKqSHeJydjXUI3Kb3I7qET9Xcf4sCcBaHHo8XE9iDrgTXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xu6Z1pAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F806C32786;
	Thu, 15 Aug 2024 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723733008;
	bh=LeRwTyAiYFguLDDdGK7TfP+fTYs65pdyN1Ww8cOqvKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xu6Z1pAYvqZjY1wJC5z78fPwsiYqKRLtpP5GVA1dfAcl5KlPysF2Jh9jG8xfE5ykE
	 n58lry+IN2BZLn4MORJlaRjBBFKghjsynN25J8tTzviWLAXMZhFt+XyJIyAb/Oe43Y
	 wiun5enAtPbckHEWo+q7Vv8GQVDll+9olll0wVZ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5.10 322/352] power: supply: axp288_charger: Round constant_charge_voltage writes down
Date: Thu, 15 Aug 2024 15:26:28 +0200
Message-ID: <20240815131931.899895695@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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



