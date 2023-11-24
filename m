Return-Path: <stable+bounces-609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C50D67F7BCC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1251F20F7A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D1839FEA;
	Fri, 24 Nov 2023 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NNJVwHgp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D9339FE3;
	Fri, 24 Nov 2023 18:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5684C433C8;
	Fri, 24 Nov 2023 18:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849328;
	bh=Jck3wZcXVkWCZ1m3JcJmkSq0BGYLgQsb3Fx/P7wU9To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NNJVwHgplAaaldCjXyVCQ/DsOJJ+ZBygIUc8u2+ASgZKVD5l1VlQV3sCl1vf7lfaz
	 DvNcovRTt5oMKmKkh3JWV+fx0q3NDvijfwKRxubW2VqDD31qSgk3xYHY6Zu7FIpUt7
	 9+18Y3g9NGWVWk8igLgT4bL2MmFyRtIpdP6tXGzY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 113/530] ASoC: Intel: soc-acpi-cht: Add Lenovo Yoga Tab 3 Pro YT3-X90 quirk
Date: Fri, 24 Nov 2023 17:44:39 +0000
Message-ID: <20231124172031.551000297@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 2cb54788393134d8174ee594002baae3ce52c61e ]

The Lenovo Yoga Tab 3 Pro YT3-X90 x86 tablet, which ships with Android with
a custom kernel as factory OS, does not list the used WM5102 codec inside
its DSDT.

Workaround this with a new snd_soc_acpi_intel_baytrail_machines[] entry
which matches on the SST id instead of the codec id like nocodec does,
combined with using a machine_quirk callback which returns NULL on
other machines to skip the new entry on other machines.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231021211534.114991-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/common/soc-acpi-intel-cht-match.c   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index cdcbf04b8832f..5e2ec60e2954b 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -75,6 +75,39 @@ static struct snd_soc_acpi_mach *cht_ess8316_quirk(void *arg)
 	return arg;
 }
 
+/*
+ * The Lenovo Yoga Tab 3 Pro YT3-X90, with Android factory OS has a buggy DSDT
+ * with the coded not being listed at all.
+ */
+static const struct dmi_system_id lenovo_yoga_tab3_x90[] = {
+	{
+		/* Lenovo Yoga Tab 3 Pro YT3-X90, codec missing from DSDT */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
+		},
+	},
+	{ }
+};
+
+static struct snd_soc_acpi_mach cht_lenovo_yoga_tab3_x90_mach = {
+	.id = "10WM5102",
+	.drv_name = "bytcr_wm5102",
+	.fw_filename = "intel/fw_sst_22a8.bin",
+	.board = "bytcr_wm5102",
+	.sof_tplg_filename = "sof-cht-wm5102.tplg",
+};
+
+static struct snd_soc_acpi_mach *lenovo_yt3_x90_quirk(void *arg)
+{
+	if (dmi_check_system(lenovo_yoga_tab3_x90))
+		return &cht_lenovo_yoga_tab3_x90_mach;
+
+	/* Skip wildcard match snd_soc_acpi_intel_cherrytrail_machines[] entry */
+	return NULL;
+}
+
 static const struct snd_soc_acpi_codecs rt5640_comp_ids = {
 	.num_codecs = 2,
 	.codecs = { "10EC5640", "10EC3276" },
@@ -175,6 +208,16 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "sof_pcm512x",
 		.sof_tplg_filename = "sof-cht-src-50khz-pcm512x.tplg",
 	},
+	/*
+	 * Special case for the Lenovo Yoga Tab 3 Pro YT3-X90 where the DSDT
+	 * misses the codec. Match on the SST id instead, lenovo_yt3_x90_quirk()
+	 * will return a YT3 specific mach or NULL when called on other hw,
+	 * skipping this entry.
+	 */
+	{
+		.id = "808622A8",
+		.machine_quirk = lenovo_yt3_x90_quirk,
+	},
 
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
-- 
2.42.0




