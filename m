Return-Path: <stable+bounces-116869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA65A3A953
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827AA179354
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6CC1FF5FE;
	Tue, 18 Feb 2025 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REfc6BDy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98651DDA2F;
	Tue, 18 Feb 2025 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910415; cv=none; b=I6uQLEKmyo8SMKntlcF0rQvc3xVSulyAo0jSJiio9koXBONN4X2r0m2kgkJxbfS4MSM6NCVEf2i3mkDzbqOebwjd9zk9dK2ywdeFdYnJ9gMfCJJWzW/ZHU67j1mUMwHAhBdu0AdYoUiJ3X0Qne58rVxdsmG1Y0Ws2+wTcdtp7bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910415; c=relaxed/simple;
	bh=OL3iHrhYU1CtX7JtXkVz4l/Hrhz90/5DcBtZjk9qTsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IygLiM4d1hwtrwRdwXu8e5tQoPsoAbAR1X7Nhdd9Z2Bh7nogdVM7ZWEz8NDIFpFjkC6+BsUkzQ2OIewfMVMM6nu0Sa5D8NUnmukcBkk//eMIPDdfbUJs0jCv9c6pxiTpjbZ0Ad8pNY5buAse4z5O17bSL7UZuN2eY6Jj0oM6868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REfc6BDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BE4C4CEE8;
	Tue, 18 Feb 2025 20:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910414;
	bh=OL3iHrhYU1CtX7JtXkVz4l/Hrhz90/5DcBtZjk9qTsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REfc6BDyoi07jiL++Gnof8a22ENXgpXSaA0V6mqNtbrDNLKxKtaUxpv1sHWeCFtsK
	 RavtB1QQrFrVQ8FH9k7XTPkBhM2+5gxDizQn3jWhuhHiWsRBz4v7lNZwwyxjdBCaOD
	 WxjOxNmqARE66U29XER7sVbhjgxMhbX1s8LSLa6q8xqOI0DkmtTlws+v4PnrGXxdMN
	 TNPPLAt05r0szc81Yw2KpT5CPL++NQoGe4AZfYyJzpOF3zb4qxDnIo1scOfF1qq85P
	 J5pF/rVXyRSu+mgDXadQihdBetrsebjjQX39G8BDms2g9SIWU+hefdPQXRs/cSJtop
	 1jtNXVVwzTklA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hmh@hmh.eng.br,
	hdegoede@redhat.com,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 16/31] platform/x86: thinkpad_acpi: Support for V9 DYTC platform profiles
Date: Tue, 18 Feb 2025 15:26:02 -0500
Message-Id: <20250218202619.3592630-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
Content-Transfer-Encoding: 8bit

From: Mark Pearson <mpearson-lenovo@squebb.ca>

[ Upstream commit 9cff907cbf8c7fb5345918dbcc7b74a01656f34f ]

Newer Thinkpad AMD platforms are using V9 DYTC and this changes the
profiles used for PSC mode. Add support for this update.
Tested on P14s G5 AMD

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://lore.kernel.org/r/20250206193953.58365-1-mpearson-lenovo@squebb.ca
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/thinkpad_acpi.c | 34 ++++++++++++++++++----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 05d77f87e235e..31ec9ec9206cf 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10329,6 +10329,10 @@ static struct ibm_struct proxsensor_driver_data = {
 #define DYTC_MODE_PSC_BALANCE  5  /* Default mode aka balanced */
 #define DYTC_MODE_PSC_PERFORM  7  /* High power mode aka performance */
 
+#define DYTC_MODE_PSCV9_LOWPOWER 1  /* Low power mode */
+#define DYTC_MODE_PSCV9_BALANCE  3  /* Default mode aka balanced */
+#define DYTC_MODE_PSCV9_PERFORM  4  /* High power mode aka performance */
+
 #define DYTC_ERR_MASK       0xF  /* Bits 0-3 in cmd result are the error result */
 #define DYTC_ERR_SUCCESS      1  /* CMD completed successful */
 
@@ -10349,6 +10353,10 @@ static int dytc_capabilities;
 static bool dytc_mmc_get_available;
 static int profile_force;
 
+static int platform_psc_profile_lowpower = DYTC_MODE_PSC_LOWPOWER;
+static int platform_psc_profile_balanced = DYTC_MODE_PSC_BALANCE;
+static int platform_psc_profile_performance = DYTC_MODE_PSC_PERFORM;
+
 static int convert_dytc_to_profile(int funcmode, int dytcmode,
 		enum platform_profile_option *profile)
 {
@@ -10370,19 +10378,15 @@ static int convert_dytc_to_profile(int funcmode, int dytcmode,
 		}
 		return 0;
 	case DYTC_FUNCTION_PSC:
-		switch (dytcmode) {
-		case DYTC_MODE_PSC_LOWPOWER:
+		if (dytcmode == platform_psc_profile_lowpower)
 			*profile = PLATFORM_PROFILE_LOW_POWER;
-			break;
-		case DYTC_MODE_PSC_BALANCE:
+		else if (dytcmode == platform_psc_profile_balanced)
 			*profile =  PLATFORM_PROFILE_BALANCED;
-			break;
-		case DYTC_MODE_PSC_PERFORM:
+		else if (dytcmode == platform_psc_profile_performance)
 			*profile =  PLATFORM_PROFILE_PERFORMANCE;
-			break;
-		default: /* Unknown mode */
+		else
 			return -EINVAL;
-		}
+
 		return 0;
 	case DYTC_FUNCTION_AMT:
 		/* For now return balanced. It's the closest we have to 'auto' */
@@ -10403,19 +10407,19 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
 		if (dytc_capabilities & BIT(DYTC_FC_MMC))
 			*perfmode = DYTC_MODE_MMC_LOWPOWER;
 		else if (dytc_capabilities & BIT(DYTC_FC_PSC))
-			*perfmode = DYTC_MODE_PSC_LOWPOWER;
+			*perfmode = platform_psc_profile_lowpower;
 		break;
 	case PLATFORM_PROFILE_BALANCED:
 		if (dytc_capabilities & BIT(DYTC_FC_MMC))
 			*perfmode = DYTC_MODE_MMC_BALANCE;
 		else if (dytc_capabilities & BIT(DYTC_FC_PSC))
-			*perfmode = DYTC_MODE_PSC_BALANCE;
+			*perfmode = platform_psc_profile_balanced;
 		break;
 	case PLATFORM_PROFILE_PERFORMANCE:
 		if (dytc_capabilities & BIT(DYTC_FC_MMC))
 			*perfmode = DYTC_MODE_MMC_PERFORM;
 		else if (dytc_capabilities & BIT(DYTC_FC_PSC))
-			*perfmode = DYTC_MODE_PSC_PERFORM;
+			*perfmode = platform_psc_profile_performance;
 		break;
 	default: /* Unknown profile */
 		return -EOPNOTSUPP;
@@ -10604,6 +10608,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	if (output & BIT(DYTC_QUERY_ENABLE_BIT))
 		dytc_version = (output >> DYTC_QUERY_REV_BIT) & 0xF;
 
+	dbg_printk(TPACPI_DBG_INIT, "DYTC version %d\n", dytc_version);
 	/* Check DYTC is enabled and supports mode setting */
 	if (dytc_version < 5)
 		return -ENODEV;
@@ -10642,6 +10647,11 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 		}
 	} else if (dytc_capabilities & BIT(DYTC_FC_PSC)) { /* PSC MODE */
 		pr_debug("PSC is supported\n");
+		if (dytc_version >= 9) { /* update profiles for DYTC 9 and up */
+			platform_psc_profile_lowpower = DYTC_MODE_PSCV9_LOWPOWER;
+			platform_psc_profile_balanced = DYTC_MODE_PSCV9_BALANCE;
+			platform_psc_profile_performance = DYTC_MODE_PSCV9_PERFORM;
+		}
 	} else {
 		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");
 		return -ENODEV;
-- 
2.39.5


