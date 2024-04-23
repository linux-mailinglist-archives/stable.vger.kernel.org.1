Return-Path: <stable+bounces-40776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150478AF904
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FF21C21F40
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A16314389A;
	Tue, 23 Apr 2024 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WuFcQJND"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C9F143899;
	Tue, 23 Apr 2024 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908454; cv=none; b=iPGAG+e0pNva3YScWULd8OXUb+LfK9OCPgkc+tX69IP66qy4GWmO3yEpiKePd6lAUvd/i0qEO3X1OrF+UmVfPsSNPt6nQf9ZXaYweHHdGCl1+jdKiYHZMEpYS2XqyjEUz5hBwCCYLK7APa/LP0f9yf7AfbAlSLdYZv6ccI6bgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908454; c=relaxed/simple;
	bh=mBH98hwW/rVngNROlkEIBWoA1XRQ6dc/EkmNpZCI6w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifnqllbAkN8tS49ycLirRN4yf1GdVk7nDT7N7Ih5LmREGYh5qZ+RFenQuP5uw9ZSsR9fFrU0FkZISLlXla3GGb17siF7R83o5d4rs5bU2P++5KsBWQAG1H9NIdNivNbN/1cOXqCZ9FknsmYIXj4w7FPpC+L3Gt8Vp/DlSk0idrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WuFcQJND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B93C116B1;
	Tue, 23 Apr 2024 21:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908454;
	bh=mBH98hwW/rVngNROlkEIBWoA1XRQ6dc/EkmNpZCI6w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WuFcQJNDbC/YaA18E51bTRsi6mUNKhS2EkcPAt/2iudbjUYdVZVCyAZuYLN1Ke/1h
	 8UXDWJtD+KiNxwhu+02it6JmiIbHm4EuRwX7gMcYxcOghiPIRx2Dv/LHHILdn7ODD8
	 pBUMJG7axGTBhG2Qzj9FQ2uvw+nmRf2LiwWG/FdQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amit Pundir <amit.pundir@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 013/158] scsi: ufs: qcom: Add missing interconnect bandwidth values for Gear 5
Date: Tue, 23 Apr 2024 14:37:15 -0700
Message-ID: <20240423213856.277043241@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: <20240423213855.824778126@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 8db8f6ce556af60ca9a9fd5e826d369ded70fcc7 ]

These entries are necessary to scale the interconnect bandwidth while
operating in Gear 5.

Cc: Amit Pundir <amit.pundir@linaro.org>
Fixes: 03ce80a1bb86 ("scsi: ufs: qcom: Add support for scaling interconnects")
Tested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20240403-ufs-icc-fix-v2-1-958412a5eb45@linaro.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/host/ufs-qcom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index f532e2c004a25..bcbcf758925be 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -47,7 +47,7 @@ enum {
 	TSTBUS_MAX,
 };
 
-#define QCOM_UFS_MAX_GEAR 4
+#define QCOM_UFS_MAX_GEAR 5
 #define QCOM_UFS_MAX_LANE 2
 
 enum {
@@ -67,26 +67,32 @@ static const struct __ufs_qcom_bw_table {
 	[MODE_PWM][UFS_PWM_G2][UFS_LANE_1] = { 1844,		1000 },
 	[MODE_PWM][UFS_PWM_G3][UFS_LANE_1] = { 3688,		1000 },
 	[MODE_PWM][UFS_PWM_G4][UFS_LANE_1] = { 7376,		1000 },
+	[MODE_PWM][UFS_PWM_G5][UFS_LANE_1] = { 14752,		1000 },
 	[MODE_PWM][UFS_PWM_G1][UFS_LANE_2] = { 1844,		1000 },
 	[MODE_PWM][UFS_PWM_G2][UFS_LANE_2] = { 3688,		1000 },
 	[MODE_PWM][UFS_PWM_G3][UFS_LANE_2] = { 7376,		1000 },
 	[MODE_PWM][UFS_PWM_G4][UFS_LANE_2] = { 14752,		1000 },
+	[MODE_PWM][UFS_PWM_G5][UFS_LANE_2] = { 29504,		1000 },
 	[MODE_HS_RA][UFS_HS_G1][UFS_LANE_1] = { 127796,		1000 },
 	[MODE_HS_RA][UFS_HS_G2][UFS_LANE_1] = { 255591,		1000 },
 	[MODE_HS_RA][UFS_HS_G3][UFS_LANE_1] = { 1492582,	102400 },
 	[MODE_HS_RA][UFS_HS_G4][UFS_LANE_1] = { 2915200,	204800 },
+	[MODE_HS_RA][UFS_HS_G5][UFS_LANE_1] = { 5836800,	409600 },
 	[MODE_HS_RA][UFS_HS_G1][UFS_LANE_2] = { 255591,		1000 },
 	[MODE_HS_RA][UFS_HS_G2][UFS_LANE_2] = { 511181,		1000 },
 	[MODE_HS_RA][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
 	[MODE_HS_RA][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
+	[MODE_HS_RA][UFS_HS_G5][UFS_LANE_2] = { 5836800,	819200 },
 	[MODE_HS_RB][UFS_HS_G1][UFS_LANE_1] = { 149422,		1000 },
 	[MODE_HS_RB][UFS_HS_G2][UFS_LANE_1] = { 298189,		1000 },
 	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_1] = { 1492582,	102400 },
 	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_1] = { 2915200,	204800 },
+	[MODE_HS_RB][UFS_HS_G5][UFS_LANE_1] = { 5836800,	409600 },
 	[MODE_HS_RB][UFS_HS_G1][UFS_LANE_2] = { 298189,		1000 },
 	[MODE_HS_RB][UFS_HS_G2][UFS_LANE_2] = { 596378,		1000 },
 	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
 	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
+	[MODE_HS_RB][UFS_HS_G5][UFS_LANE_2] = { 5836800,	819200 },
 	[MODE_MAX][0][0]		    = { 7643136,	307200 },
 };
 
-- 
2.43.0




