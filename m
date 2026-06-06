Return-Path: <stable+bounces-260854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lydvB32oI2rSwQEAu9opvQ
	(envelope-from <stable+bounces-260854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 06:56:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A95C964C64B
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 06:56:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gibson.sh header.s=20260228 header.b=Oux5ZJTJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260854-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260854-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A008C3036FA2
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 04:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D932FE05B;
	Sat,  6 Jun 2026 04:48:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA352F8EBA
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 04:48:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721291; cv=none; b=Mh/JvpReW34J+HoaFDHuqSojOXtLy+J5T7WcuydzjIHrJcV1c0n3UwtUiEnvUkVNocYdIMxBJ1aRB6lil+SOF1kdy80VhSO3EUGAHIdjWyR0RupryrV2JZo0DzXwVCtrVYfn+A+4u9mnqqIxWZxWptTdYxnmaMA8DFZBO5Yp0tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721291; c=relaxed/simple;
	bh=Ei+J1JQ+OQDRTYvxZ34inBIiZ97Iv+p9QAUQzY88dQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MB9zj/d1uwtbk5YpL1eGezICo6C4kQnJjQB3HiFhmazdyU2aXYPuahE/BZ3oYc+0uyrcMw/QVcNenrlsZz2Go8Jk1k8GvOl3h6HBEKN8yRdMHkEpwHyUUcFBeKw1xnEXg2krh+oJ/BhwWbUj3ggtCiY4IM1Oek4l5qUzPF8kHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=Oux5ZJTJ; arc=none smtp.client-ip=83.166.143.170
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gXQm21nZszWwH
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 06:48:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1780721282;
	bh=vHfo3+n/XMteJ5vHoQ7kA9U/Iy7x5RrsTtiy751rGnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oux5ZJTJNQx5Hs+j9bKNhhpEdpydbN/opFlQvTYJ8SFy690E6WA7WZsQgb/3ImySM
	 YHVj0nlQ7tebnsvvbtDfP1xUlc+FmQQ8mWFiaTJeKHrGiO46jyaewiXfjwhnvwKgwn
	 EW6ciWANiYVNSjgRoEu4daxnTdlDECNQCMQeAXwCa1jGvEAMHlOuykQggRzkZywuLm
	 s6emcJBzZmaSMJuQUK8RU3xWsRWDxGzalrXC5G61qlDoNKprwIVJ6sMmPZMgRrzAUR
	 lIkDWZsyb2DHHiIXnGBRE9YL6mHH4iL56Th9bFkN+wA+uzuw+6qY7Ju0UpD9xfGm2m
	 Gt1WnW9eXwrNw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gXQm156f6zwRS
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 06:48:01 +0200 (CEST)
Received: from unknown by spiderdemon.horst.lan (DragonFly Mail Agent v0.13);
	Sat, 06 Jun 2026 06:48:00 +0200
From: Daniel Gibson <daniel@gibson.sh>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>
Cc: Daniel Gibson <daniel@gibson.sh>,
	Sindre Henriksen <sindrehenriksen93@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/3] platform/x86/amd/pmc: Delay suspend for some Lenovo Laptops
Date: Sat,  6 Jun 2026 06:47:56 +0200
Message-ID: <20260606044758.2213401-2-daniel@gibson.sh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260606044758.2213401-1-daniel@gibson.sh>
References: <20260606044758.2213401-1-daniel@gibson.sh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Rspamd-Action: add header
X-Spamd-Result: default: False [8.34 / 15.00];
	URIBL_BLACK(7.50)[gibson.sh:mid,gibson.sh:dkim,gibson.sh:from_mime,gibson.sh:email];
	MID_CONTAINS_FROM(1.00)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260854-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[gibson.sh:s=20260228];
	FORGED_RECIPIENTS(0.00)[m:Shyam-sundar.S-k@amd.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:superm1@kernel.org,m:daniel@gibson.sh,m:sindrehenriksen93@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[gibson.sh];
	FORGED_SENDER(0.00)[daniel@gibson.sh,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[gibson.sh,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@gibson.sh,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gibson.sh:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gibson.sh:mid,gibson.sh:dkim,gibson.sh:from_mime,gibson.sh:email,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A95C964C64B
X-Spam: Yes

Some IdeaPad Slim 3 devices and similar with AMD CPUs have a
nonfunctional keyboard and lid switch after s2idle.

It helps to delay suspend by 2.5 seconds so the EC has some time
to do whatever it needs to get done before suspend - unfortunately
at least on my 16ABR8 waking it with a timer (wakealarm) still
triggers the issue, but at least normal resume via keypress or
lid works fine. On the 14ARP10 wakealarm has been reported to also
work fine with this patch.

This issue has been reported for many different devices, this patch
has been tested with the Zen3-based IdeaPad Slim 3 16ABR8 (82XR)
and the Zen3+-based IdeaPad Slim 3 14ARP10 (83K6) and IdeaPad Slim 3
15ARP10 (83MM).

Reported-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221383
Tested-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
Suggested-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Daniel Gibson <daniel@gibson.sh>
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 39 +++++++++++++++++++++++
 drivers/platform/x86/amd/pmc/pmc.c        | 24 +++++++++++++-
 drivers/platform/x86/amd/pmc/pmc.h        |  1 +
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index 24506e342943..74ddf1d8289a 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -18,6 +18,7 @@
 struct quirk_entry {
 	u32 s2idle_bug_mmio;
 	bool spurious_8042;
+	bool need_suspend_delay;
 };
 
 static struct quirk_entry quirk_s2idle_bug = {
@@ -33,6 +34,10 @@ static struct quirk_entry quirk_s2idle_spurious_8042 = {
 	.spurious_8042 = true,
 };
 
+static struct quirk_entry quirk_s2idle_need_suspend_delay = {
+	.need_suspend_delay = true,
+};
+
 static const struct dmi_system_id fwbug_list[] = {
 	{
 		.ident = "L14 Gen2 AMD",
@@ -203,6 +208,35 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
 		}
 	},
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=221383 */
+	{
+		.ident = "Zen3-based IdeaPad Slim and similar",
+		.driver_data = &quirk_s2idle_need_suspend_delay,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			/*
+			 * Note: there are also some Zen2-based 82X* devices that
+			 * need different quirks, they're already handled above
+			 */
+			DMI_MATCH(DMI_PRODUCT_NAME, "82X"),
+		}
+	},
+	{
+		.ident = "Zen3+-based IdeaPad Slim and similar",
+		.driver_data = &quirk_s2idle_need_suspend_delay,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83K"),
+		}
+	},
+	{
+		.ident = "IdeaPad Slim 3 15ARP10 (83MM)",
+		.driver_data = &quirk_s2idle_need_suspend_delay,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83MM"),
+		}
+	},
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=221273 */
 	{
 		.ident = "Thinkpad L14 Gen3",
@@ -356,6 +390,11 @@ void amd_pmc_process_restore_quirks(struct amd_pmc_dev *dev)
 		amd_pmc_skip_nvme_smi_handler(dev->quirks->s2idle_bug_mmio);
 }
 
+bool amd_pmc_quirk_need_suspend_delay(struct amd_pmc_dev *dev)
+{
+	return dev->quirks && dev->quirks->need_suspend_delay;
+}
+
 void amd_pmc_quirks_init(struct amd_pmc_dev *dev)
 {
 	const struct dmi_system_id *dmi_id;
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 2b9e5730170a..6bafd8661d68 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -611,6 +611,27 @@ static bool amd_pmc_intermediate_wakeup_need_delay(struct amd_pmc_dev *pdev)
 	return get_metrics_table(pdev, &table) == 0 && table.s0i3_last_entry_status;
 }
 
+static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
+{
+	/*
+	 * Some Lenovo Laptops (like different IdeaPad 3 Slims) need some
+	 * me-time before sleeping or they get uncooperative after waking
+	 * up and don't send events for keyboard and lid switch anymore.
+	 *
+	 * Unfortunately this doesn't entirely fix the problem: It can still
+	 * happen when resuming with a timer (wakealarm), but at least the
+	 * more common usecases (wakeup by opening lid or pressing a key)
+	 * work fine with this workaround.
+	 *
+	 * See https://bugzilla.kernel.org/show_bug.cgi?id=221383
+	 */
+	if (!disable_workarounds && amd_pmc_quirk_need_suspend_delay(pdev)) {
+		dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
+		return true;
+	}
+	return false;
+}
+
 static void amd_pmc_s2idle_prepare(void)
 {
 	struct amd_pmc_dev *pdev = &pmc;
@@ -647,7 +668,8 @@ static void amd_pmc_s2idle_check(void)
 	struct amd_pmc_dev *pdev = &pmc;
 	int rc;
 
-	if (amd_pmc_intermediate_wakeup_need_delay(pdev))
+	if (amd_pmc_intermediate_wakeup_need_delay(pdev) ||
+	    amd_pmc_want_suspend_delay(pdev))
 		msleep(2500);
 
 	/* Dump the IdleMask before we add to the STB */
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index fe3f53eb5955..f5257e47b8c4 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -147,6 +147,7 @@ enum amd_pmc_def {
 };
 
 void amd_pmc_process_restore_quirks(struct amd_pmc_dev *dev);
+bool amd_pmc_quirk_need_suspend_delay(struct amd_pmc_dev *dev);
 void amd_pmc_quirks_init(struct amd_pmc_dev *dev);
 void amd_mp2_stb_init(struct amd_pmc_dev *dev);
 void amd_mp2_stb_deinit(struct amd_pmc_dev *dev);
-- 
2.48.1


