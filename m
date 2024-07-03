Return-Path: <stable+bounces-57452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4370F925DD7
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D70B3AFBB
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C188B194AC4;
	Wed,  3 Jul 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="di7PfdXZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F25A1850A8;
	Wed,  3 Jul 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004925; cv=none; b=dGyoAzdmyLQZP4WHe/XxUXYceAlfpPiIi6SfQkd7AJlPkP1TwVIZ81GKh8NdlVTDbnt3VcqfmhG0ZssSl/cBdSS44xIngQOmwUBCDjVkGeHKlCM6We6BizKjLjQaOtBxmVlF88cxmKz2b6f/JfiK/Q5IXeUCB/pDyPIOzx8/5go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004925; c=relaxed/simple;
	bh=87rTganSAj/skvIIiLViOPMFZTc8kFk1ZqRTbe078Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NL4CPErEszDyhS4D7DkgB0sh3U3d4d1y/Xi+AmbowFco3An4pKxKcWzTcpORwNFjR9Jjm3+VudTsIfZQa4SI5b65Apj7BS7fz+tE9mOfOCuSqcE1ElNw5rZNs1MwZJa8o3dz+q2MlSemed8d4JVlHpYCnK2ockywFi+el5MroHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=di7PfdXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02245C4AF0B;
	Wed,  3 Jul 2024 11:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004925;
	bh=87rTganSAj/skvIIiLViOPMFZTc8kFk1ZqRTbe078Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=di7PfdXZVJJ6hKxti+8AZ6T4E/uG9wbqAR7hz1xutuLNt4yZyXQirYBro3HKkXSVC
	 FGtsSSCSNpDkc+HeL1cYi3Tx0RpRPJYU1ADn8O30vUlj188egEJNtwdgAMP9AEdzOI
	 jQIVij9FG6A/Uag2RDn/Km6o/mtw97upQZaRqpTU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 203/290] ACPI: x86: Force StorageD3Enable on more products
Date: Wed,  3 Jul 2024 12:39:44 +0200
Message-ID: <20240703102911.830373199@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit e79a10652bbd320649da705ca1ea0c04351af403 ]

A Rembrandt-based HP thin client is reported to have problems where
the NVME disk isn't present after resume from s2idle.

This is because the NVME disk wasn't put into D3 at suspend, and
that happened because the StorageD3Enable _DSD was missing in the BIOS.

As AMD's architecture requires that the NVME is in D3 for s2idle, adjust
the criteria for force_storage_d3 to match *all* Zen SoCs when the FADT
advertises low power idle support.

This will ensure that any future products with this BIOS deficiency don't
need to be added to the allow list of overrides.

Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 7d6083d40bf6b..aa4f233373afc 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -179,16 +179,16 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 }
 
 /*
- * AMD systems from Renoir and Lucienne *require* that the NVME controller
+ * AMD systems from Renoir onwards *require* that the NVME controller
  * is put into D3 over a Modern Standby / suspend-to-idle cycle.
  *
  * This is "typically" accomplished using the `StorageD3Enable`
  * property in the _DSD that is checked via the `acpi_storage_d3` function
- * but this property was introduced after many of these systems launched
- * and most OEM systems don't have it in their BIOS.
+ * but some OEM systems still don't have it in their BIOS.
  *
  * The Microsoft documentation for StorageD3Enable mentioned that Windows has
- * a hardcoded allowlist for D3 support, which was used for these platforms.
+ * a hardcoded allowlist for D3 support as well as a registry key to override
+ * the BIOS, which has been used for these cases.
  *
  * This allows quirking on Linux in a similar fashion.
  *
@@ -201,17 +201,13 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
  *    https://bugzilla.kernel.org/show_bug.cgi?id=216773
  *    https://bugzilla.kernel.org/show_bug.cgi?id=217003
  * 2) On at least one HP system StorageD3Enable is missing on the second NVME
-      disk in the system.
+ *    disk in the system.
+ * 3) On at least one HP Rembrandt system StorageD3Enable is missing on the only
+ *    NVME device.
  */
-static const struct x86_cpu_id storage_d3_cpu_ids[] = {
-	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 24, NULL),  /* Picasso */
-	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
-	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
-	X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),	/* Cezanne */
-	{}
-};
-
 bool force_storage_d3(void)
 {
-	return x86_match_cpu(storage_d3_cpu_ids);
+	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
+		return false;
+	return acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0;
 }
-- 
2.43.0




