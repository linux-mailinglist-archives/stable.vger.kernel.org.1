Return-Path: <stable+bounces-125454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6138AA690B8
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F027AE0FB
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBA8221566;
	Wed, 19 Mar 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gg7iu6rQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8351C8618;
	Wed, 19 Mar 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395199; cv=none; b=LJVHoongxeRgtRloijgNDviwNYGTzvb4KOKKUz7GMxFOANqEw+QrQdWU3xaCXqcItpXTkvFApB7zByAki7PaYjpZR/jzGutW0cIeZErMCj0UD8LrmMCo5HemN2A1vyrQ3ylTlmCxTZsJ3vHk/4aLYMycEBqs/eN+mXSoqQ2Er2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395199; c=relaxed/simple;
	bh=m7emd2O9bOAvQui9OFx9XUKpPRwnq5vfwsdBgisB1bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVHE4aDqLJgBRFzpoMBO0ehzktIemh7OeMk2yhkqzUpFn3hwiwgsh2Vvkwyvc2i+oRN56VeRQHOAdfjyAxfIiYu6aFWNr7rME91Y77D0IZiew43WA+w6WU9Iqwd0MqfKlvWwfME7lmJtr+9UEHCK6NkiKVzkb8S/XaBxEIHW3AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gg7iu6rQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF19C4CEE4;
	Wed, 19 Mar 2025 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395198;
	bh=m7emd2O9bOAvQui9OFx9XUKpPRwnq5vfwsdBgisB1bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gg7iu6rQDGCXnGlBXKQ1wv4aSMtPxz7ky9j1Ezi0ghJG7K3fjyctrm++zsJZoUXzp
	 gun8IITof18R0eGjuLI16tdit0j95F9x7bsOTFsoRlfzrV618Rp8aFM8wfJvmLOE8Q
	 Ri2eKTA//5Gba4XOlFPuB7h+QUvaxw58pG7Jwa+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 060/166] platform/x86: thinkpad_acpi: Support for V9 DYTC platform profiles
Date: Wed, 19 Mar 2025 07:30:31 -0700
Message-ID: <20250319143021.631521543@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143019.983527953@linuxfoundation.org>
References: <20250319143019.983527953@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index b11f5ac658e01..cde5f845cf255 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10283,6 +10283,10 @@ static struct ibm_struct proxsensor_driver_data = {
 #define DYTC_MODE_PSC_BALANCE  5  /* Default mode aka balanced */
 #define DYTC_MODE_PSC_PERFORM  7  /* High power mode aka performance */
 
+#define DYTC_MODE_PSCV9_LOWPOWER 1  /* Low power mode */
+#define DYTC_MODE_PSCV9_BALANCE  3  /* Default mode aka balanced */
+#define DYTC_MODE_PSCV9_PERFORM  4  /* High power mode aka performance */
+
 #define DYTC_ERR_MASK       0xF  /* Bits 0-3 in cmd result are the error result */
 #define DYTC_ERR_SUCCESS      1  /* CMD completed successful */
 
@@ -10303,6 +10307,10 @@ static int dytc_capabilities;
 static bool dytc_mmc_get_available;
 static int profile_force;
 
+static int platform_psc_profile_lowpower = DYTC_MODE_PSC_LOWPOWER;
+static int platform_psc_profile_balanced = DYTC_MODE_PSC_BALANCE;
+static int platform_psc_profile_performance = DYTC_MODE_PSC_PERFORM;
+
 static int convert_dytc_to_profile(int funcmode, int dytcmode,
 		enum platform_profile_option *profile)
 {
@@ -10324,19 +10332,15 @@ static int convert_dytc_to_profile(int funcmode, int dytcmode,
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
@@ -10357,19 +10361,19 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
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
@@ -10558,6 +10562,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	if (output & BIT(DYTC_QUERY_ENABLE_BIT))
 		dytc_version = (output >> DYTC_QUERY_REV_BIT) & 0xF;
 
+	dbg_printk(TPACPI_DBG_INIT, "DYTC version %d\n", dytc_version);
 	/* Check DYTC is enabled and supports mode setting */
 	if (dytc_version < 5)
 		return -ENODEV;
@@ -10596,6 +10601,11 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
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




