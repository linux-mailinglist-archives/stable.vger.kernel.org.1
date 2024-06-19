Return-Path: <stable+bounces-54133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA60690ECD8
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B4FB20BF8
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C3A147C7B;
	Wed, 19 Jun 2024 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aoxuWwaL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF9143C58;
	Wed, 19 Jun 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802683; cv=none; b=BGgeYm+8I7zjUeHPSjD31GThOwDiKb9jgBuzqG/FP/dg7zpEvC1keEWdlbpY7uVeaKUfY5ZOPMMPXdHY5R50Ci6cVnFVbmmzxTeBWGMs6SbQ1RmqC6YKpOTITMiYbU9jG9YuK3VoyTsSmDDZIl7XDLJaOiy4UKzCLo/JDWZm44o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802683; c=relaxed/simple;
	bh=VFJpsGYLnOFO/SuZpk0IQ491AbAo3nyWFoP/1kGO3/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3eHMNrmF4XvwKqKSiZC28ypPtTV7yBuFW7QqpQkhssgh4lt9nsCiRWMx8OSTp5aU4fUtoMNXc6VBCvd0+7N4eV6euOeQCcvdUH0NE+5AXh6heK/PRauKkO0m1uPMXvIUrydWVK4uvdafXfnCfhJsUbLNPrGMiTAZC/ROY2avkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aoxuWwaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB51C4AF1A;
	Wed, 19 Jun 2024 13:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802682;
	bh=VFJpsGYLnOFO/SuZpk0IQ491AbAo3nyWFoP/1kGO3/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoxuWwaLFGpkWo8HGHA/fMbdpTyEV+USP2GO/2q5ojV4qwI+8DsdkSnRueYCGlxOM
	 fFY9MdO+62XjRk8lMi2hGqQfAoY7UTZtS9hL/2dmMLqEMShq/afZyleuTU2fKP09hd
	 jgRul6dfgB4mJ1IVF1BzpjMAaCXBhMnkmsRHm970=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 004/281] cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing
Date: Wed, 19 Jun 2024 14:52:43 +0200
Message-ID: <20240619125610.012090660@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Perry Yuan <perry.yuan@amd.com>

[ Upstream commit eb8b6c36820214df96e7e86d8614d93f6b028f28 ]

Add quirks table to get CPPC capabilities issue fixed by providing
correct perf or frequency values while driver loading.

If CPPC capabilities are not defined in the ACPI tables or wrongly
defined by platform firmware, it needs to use quick to get those
issues fixed with correct workaround values to make pstate driver
can be loaded even though there are CPPC capabilities errors.

The workaround will match the broken BIOS which lack of CPPC capabilities
nominal_freq and lowest_freq definition in the ACPI table.

$ cat /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
0
$ cat /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq
0

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 779b8a14afde ("cpufreq: amd-pstate: remove global header file")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 53 ++++++++++++++++++++++++++++++++++--
 include/linux/amd-pstate.h   |  6 ++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e8385ca32f1fc..605b037913ff8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -68,6 +68,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
+static struct quirk_entry *quirks;
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -112,6 +113,41 @@ static unsigned int epp_values[] = {
 
 typedef int (*cppc_mode_transition_fn)(int);
 
+static struct quirk_entry quirk_amd_7k62 = {
+	.nominal_freq = 2600,
+	.lowest_freq = 550,
+};
+
+static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
+{
+	/**
+	 * match the broken bios for family 17h processor support CPPC V2
+	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
+	 * definition in ACPI tables
+	 */
+	if (boot_cpu_has(X86_FEATURE_ZEN2)) {
+		quirks = dmi->driver_data;
+		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
+		return 1;
+	}
+
+	return 0;
+}
+
+static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
+	{
+		.callback = dmi_matched_7k62_bios_bug,
+		.ident = "AMD EPYC 7K62",
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VERSION, "5.14"),
+			DMI_MATCH(DMI_BIOS_RELEASE, "12/12/2019"),
+		},
+		.driver_data = &quirk_amd_7k62,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
+
 static inline int get_mode_idx_from_str(const char *str, size_t size)
 {
 	int i;
@@ -818,8 +854,16 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	min_freq = cppc_perf.lowest_freq * 1000;
-	nominal_freq = cppc_perf.nominal_freq;
+	if (quirks && quirks->lowest_freq)
+		min_freq = quirks->lowest_freq * 1000;
+	else
+		min_freq = cppc_perf.lowest_freq * 1000;
+
+	if (quirks && quirks->nominal_freq)
+		nominal_freq = quirks->nominal_freq ;
+	else
+		nominal_freq = cppc_perf.nominal_freq;
+
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
 	highest_perf = READ_ONCE(cpudata->highest_perf);
@@ -1664,6 +1708,11 @@ static int __init amd_pstate_init(void)
 	if (cpufreq_get_current_driver())
 		return -EEXIST;
 
+	quirks = NULL;
+
+	/* check if this machine need CPPC quirks */
+	dmi_check_system(amd_pstate_quirks_table);
+
 	switch (cppc_state) {
 	case AMD_PSTATE_UNDEFINED:
 		/* Disable on the following configs by default:
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index d21838835abda..7b2cbb892fd91 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -124,4 +124,10 @@ static const char * const amd_pstate_mode_string[] = {
 	[AMD_PSTATE_GUIDED]      = "guided",
 	NULL,
 };
+
+struct quirk_entry {
+	u32 nominal_freq;
+	u32 lowest_freq;
+};
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.43.0




