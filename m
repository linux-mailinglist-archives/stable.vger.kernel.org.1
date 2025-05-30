Return-Path: <stable+bounces-148179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877DAAC8E04
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 14:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95C1A42D41
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 12:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD00F235047;
	Fri, 30 May 2025 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRFdJhO+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C72343B6;
	Fri, 30 May 2025 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608757; cv=none; b=c6oO8aEqUaLgy019Ml1GcgW5HtKXNsNth3P29CZ5a1Y8ZWujjztmWfAYnnPzth2/ZhEn6ehgBzyuJluJ99Up169E7JpaZWpS3ELUaT6ij7v8ivGFMY2PzgtSvkzSUQ+9Svuz3bqwOA4uxNr1BMwBg0lqH/hppV6+dHVLPG0gglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608757; c=relaxed/simple;
	bh=0mNPQpbwT1Pfw1ec0QHifRguoEQrfpMBmf9+3fPz8uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZMHNTEM/ZYh85cfDvil9hGubqRRjL8456qLNfjQfx4iSTARe75xq55VULP0llwDS5ZBgXr0gH4Bu+R5ID3//nG/SFf+i5Dg6Vo69/w0BG+x/i+rf+5L38cWymlUtqLcgPsDmZGE+SqSi2kE1+6jvNfo6x6N7siVx8+x4tQk1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRFdJhO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667D2C4CEEB;
	Fri, 30 May 2025 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608757;
	bh=0mNPQpbwT1Pfw1ec0QHifRguoEQrfpMBmf9+3fPz8uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRFdJhO+ApuA3Ntz+gPQKQxwg5682IRiBJEf9J11v9jUQoyJLnrcuxJhHlPmBCNNN
	 3BGxmGhjfuQEl1blzGEZiWgihfq/wxtlAYNzf95JPX9WJHIyyBomM8pE2p8SoNyrlC
	 PFYBjmU+I0c+tL/6szYIgeh6b+SNhtiVcPg/CyoP4SEaQgeRQkes0QG31ygGCxqYkY
	 /CI9Md5deDYMEWctHgDbaKM3seVPUxdH2QYSs/zdoaBQmhK6Z/qoV2PfwhVjW1Tph1
	 P/IEvL27MwAmDTDDWeGM2UkOiGHebNjZvZZ6uChRnVtMmps9O+auJtB9RjR0Cx+HpM
	 tmPtB4iFodjXw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 18/30] ALSA: hda: cs35l41: Fix swapped l/r audio channels for Acer Helios laptops
Date: Fri, 30 May 2025 08:38:40 -0400
Message-Id: <20250530123852.2574030-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530123852.2574030-1-sashal@kernel.org>
References: <20250530123852.2574030-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit e43a93c41982e82c1b703dd7fa9c1d965260fbb3 ]

Fixes audio channel assignment from ACPI using configuration table.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Link: https://patch.msgid.link/20250515162848.405055-3-sbinding@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees.
**Extensive Analysis:** **1. Nature of the Fix:** The commit fixes
swapped left/right audio channels for Acer Helios laptops by adding
three new entries to the `cs35l41_config_table[]`: - `{ "10251826", 2,
EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 }` -
`{ "1025182C", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0,
-1, -1, 0, 0, 0 }` - `{ "10251844", 2, EXTERNAL, { CS35L41_LEFT,
CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 }` The corresponding model
table entries are also added to enable these configurations. **2.
Comparison with Historical Similar Commits:** This commit is **very
similar to Similar Commit #1 (Status: YES)** which also fixed swapped
l/r audio channels for Lenovo ThinkBook laptops. Both commits: - Fix the
same fundamental issue: swapped audio channels - Make identical types of
changes: correcting channel assignment in configuration tables - Are
small, contained fixes affecting only audio configuration data - Target
specific laptop models with broken audio channel mapping The primary
difference is that Similar Commit #1 modified existing entries by
swapping `CS35L41_LEFT` and `CS35L41_RIGHT`, while this commit adds new
entries with correct channel assignments. **3. Why This Qualifies for
Backporting:** **✅ Fixes Important User-Affecting Bug:** Swapped audio
channels are a significant usability issue that directly impacts users'
audio experience on affected Acer Helios laptops. **✅ Small and
Contained Change:** The fix only adds static configuration data - three
new entries in a lookup table. No algorithmic changes or complex logic
modifications. **✅ Minimal Risk of Regression:** Adding new entries to a
device-specific configuration table cannot break existing functionality
for other devices. The changes only affect the three specific Acer
laptop models. **✅ No Architectural Changes:** This is purely data-
driven configuration, not structural code changes. **✅ Specific Hardware
Support:** The SSID values (10251826, 1025182C, 10251844) are vendor-
specific identifiers for Acer devices (1025 = Acer vendor ID), ensuring
the fix only applies to the intended hardware. **4. Code Analysis
Verification:** From examining the current kernel tree at
`/home/sasha/linux/sound/pci/hda/cs35l41_hda_property.c`, I confirmed
that: - The file exists and contains the same structure as the commit -
No "1025" entries currently exist in the configuration table - The
pattern matches exactly with other vendor entries (HP: 103C, ASUS: 1043,
Lenovo: 17AA) **5. Risk Assessment:** - **Regression Risk: MINIMAL** -
Adding device-specific entries cannot affect other hardware - **Side
Effects: NONE** - Changes are isolated to specific Acer laptop models -
**Complexity: LOW** - Simple data table additions with no logic changes
**Conclusion:** This commit perfectly fits the stable tree criteria:
it's an important hardware-specific bug fix that affects users, with
minimal risk and no architectural changes. The historical precedent
(Similar Commit #1 with identical nature receiving YES status) strongly
supports backporting this fix.

 sound/pci/hda/cs35l41_hda_property.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 61d2314834e7b..d8249d997c2a0 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -31,6 +31,9 @@ struct cs35l41_config {
 };
 
 static const struct cs35l41_config cs35l41_config_table[] = {
+	{ "10251826", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
+	{ "1025182C", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
+	{ "10251844", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "10280B27", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10280B28", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10280BEB", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
@@ -452,6 +455,9 @@ struct cs35l41_prop_model {
 static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
+	{ "CSC3551", "10251826", generic_dsd_config },
+	{ "CSC3551", "1025182C", generic_dsd_config },
+	{ "CSC3551", "10251844", generic_dsd_config },
 	{ "CSC3551", "10280B27", generic_dsd_config },
 	{ "CSC3551", "10280B28", generic_dsd_config },
 	{ "CSC3551", "10280BEB", generic_dsd_config },
-- 
2.39.5


