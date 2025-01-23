Return-Path: <stable+bounces-110239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E67A19D07
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 03:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50DE188CEC3
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 02:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FA435975;
	Thu, 23 Jan 2025 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GurgnwFF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCDA35953;
	Thu, 23 Jan 2025 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737600591; cv=none; b=M+GXTjI3S/DTfyY9jr/VKZPS6nuH+exALOeilYSALfR8lW1eBtUUR1FivDuENBlKTpxeBK6hKTdC02JSZQMwODzlNqbVcTpdHM3VLaBEklmktkBsKgxbBykLKps74XMFedHmNNrkiTZW/HbIjHqzqVkYfqyxdvUPCNQElwcRw9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737600591; c=relaxed/simple;
	bh=j1tynmHw4EvxQ0LCZ5A/XsXUIsB+nUovZtTw8a8sGoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIw9oEwMu/c11nb7r4+mBmGMlSTORseF3t/mh+KLKz8+oKKsSUjPhx9gx4RuwDp2L2qeYTJEfLHbSBgFLorFUNQSkncMjMQdg+xXu0mAxM2LeIrh7HTZoW+zKUFlbY8iO/41tGzL8ed0Z9AtsKvJa3v3fXizLFs3JnyGDnsmEy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GurgnwFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E341C4CED2;
	Thu, 23 Jan 2025 02:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737600591;
	bh=j1tynmHw4EvxQ0LCZ5A/XsXUIsB+nUovZtTw8a8sGoE=;
	h=From:To:Cc:Subject:Date:From;
	b=GurgnwFFyeQCQmuKSOF0rZbzfYTZ9icniKKxMsBL0wTHKT1e1Bvx5VZhQP6/nhp2B
	 aP81heCowK4ZEQhWah26o+QG8fqjIPGiOGon4yezqYHlm9m87Md0cTuYcoyl3DDi6+
	 QseHU6UzFnICu3jLL5sboLSrADzdc0+PygUDGp5vU+kr+YVq/dsaCT1EcS5eDCi6iw
	 lw13TmEBunCeBG+kcMjv5FhTuodW+O0FxyS0QpagFqi2H4JFqfQwI2Evl4sfJMT2Dj
	 F8JKGgIlRVMzHyiEMSOZlQTGAs+eyeTV2cSKR7guqumv7wd/exy+hVj8T2SI3+T1qa
	 nAClMCLooL4Fg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: nijs1@lenovo.com,
	pgriffais@valvesoftware.com,
	mpearson-lenovo@squebb.ca,
	stable@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH] ASoC: acp: Support microphone from Lenovo Go S
Date: Wed, 22 Jan 2025 20:49:13 -0600
Message-ID: <20250123024915.2457115-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

On Lenovo Go S there is a DMIC connected to the ACP but the firmware
has no `AcpDmicConnected` ACPI _DSD.

Add a DMI entry for all possible Lenovo Go S SKUs to enable DMIC.

Cc: nijs1@lenovo.com
Cc: pgriffais@valvesoftware.com
Cc: mpearson-lenovo@squebb.ca
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index ecf57a6cb7c37..b16587d8f97a8 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -304,6 +304,34 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83AS"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


