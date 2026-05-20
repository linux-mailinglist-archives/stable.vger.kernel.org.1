Return-Path: <stable+bounces-251510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMuMBI/+DWok5QUAu9opvQ
	(envelope-from <stable+bounces-251510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:33:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38440596962
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E180B3204C5B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E73C870E;
	Wed, 20 May 2026 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KGA7hSGZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF33D88FC;
	Wed, 20 May 2026 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298169; cv=none; b=WIr35o+XGao8LG5NVrW+X5GqxRZYvwUam3/RErB3BcqIXZUx2AZ7E+/Us8HtNTD0dcUGI4ZuhlfWYGzBuMh6Fz+UzNlxTllkuieV0ICTcv0Wx2FqFaSYlXBrI21x8o+mT8IrR2weiI8T+c4LOtBEI6tioeLZW72FscoYkr2bGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298169; c=relaxed/simple;
	bh=y/tK5bPejXcUxolj3bpenr/I9oTmc931f13HgJCcErI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/72i0O5NEricEY81Bk6B9VLlfCY/66+QhI6Nz9j+UUDlWSX5yW9g2NalElUhRU8jiqZbbOs2gocbxBIHP9EAKvamrydHXQQFZ0DLKlObjz0AeUPp4HZkXZK5VdTBxIwQecRIQxFkYFSrOQipsFtaFdZ3QWbIGz8jz0f1zOwy58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KGA7hSGZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556811F000E9;
	Wed, 20 May 2026 17:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298167;
	bh=9dp3M0jcW808M9izF4ZScgTwPKqrsb6v4FUl5KF4NYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KGA7hSGZLpdi0uSImtSa7JXWWGA1pIZYXSuUdzE6WDKfGN5UIw7WewkIgyz10eQvK
	 BT/zv2i0e8J7VPLWw7Kw3F9kKqis8szTNS2VD/o0Y1ythGXsFW4Knpv+BpiF7qliVy
	 sFCj94hwDpljU6XHjNVGl2UCbvnZnAWWaW9kKITk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 266/957] drm/amd/pm/smu7: Add SCLK cap for quirky Hawaii board
Date: Wed, 20 May 2026 18:12:29 +0200
Message-ID: <20260520162140.313457200@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251510-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email]
X-Rspamd-Queue-Id: 38440596962
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 4724bc5b8d78c34b993594f9406135408ccb312a ]

On a specific Radeon R9 390X board, the GPU can "randomly" hang
while gaming. Initially I thought this was a RADV bug and tried
to work around this in Mesa:
commit 8ea08747b86b ("radv: Mitigate GPU hang on Hawaii in Dota 2 and RotTR")

However, I got some feedback from other users who are reporting
that the above mitigation causes a significant performance
regression for them, and they didn't experience the hang on their
GPU in the first place.

After some further investigation, it turns out that the problem
is that the highest SCLK DPM level on this board isn't stable.
Lowering SCLK to 1040 MHz (from 1070 MHz) works around the issue,
and has a negligible impact on performance compared to the Mesa
patch. (Note that increasing the voltage can also work around it,
but we felt that lowering the SCLK is the safer option.)

To solve the above issue, add an "sclk_cap" field to smu7_hwmgr
and set this field for the affected board. The capped SCLK value
correctly appears on the sysfs interface and shows up in GUI
tools such as LACT.

Fixes: 9f4b35411cfe ("drm/amd/powerplay: add CI asics support to smumgr (v3)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 30 ++++++++++++++++---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h   |  1 +
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 07d946c38ec04..6529a91a613b6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -787,7 +787,7 @@ static int smu7_setup_dpm_tables_v0(struct pp_hwmgr *hwmgr)
 		hwmgr->dyn_state.vddc_dependency_on_mclk;
 	struct phm_cac_leakage_table *std_voltage_table =
 		hwmgr->dyn_state.cac_leakage_table;
-	uint32_t i;
+	uint32_t i, clk;
 
 	PP_ASSERT_WITH_CODE(allowed_vdd_sclk_table != NULL,
 		"SCLK dependency table is missing. This table is mandatory", return -EINVAL);
@@ -804,10 +804,12 @@ static int smu7_setup_dpm_tables_v0(struct pp_hwmgr *hwmgr)
 	data->dpm_table.sclk_table.count = 0;
 
 	for (i = 0; i < allowed_vdd_sclk_table->count; i++) {
+		clk = min(allowed_vdd_sclk_table->entries[i].clk, data->sclk_cap);
+
 		if (i == 0 || data->dpm_table.sclk_table.dpm_levels[data->dpm_table.sclk_table.count-1].value !=
-				allowed_vdd_sclk_table->entries[i].clk) {
+				clk) {
 			data->dpm_table.sclk_table.dpm_levels[data->dpm_table.sclk_table.count].value =
-				allowed_vdd_sclk_table->entries[i].clk;
+				clk;
 			data->dpm_table.sclk_table.dpm_levels[data->dpm_table.sclk_table.count].enabled = (i == 0) ? 1 : 0;
 			data->dpm_table.sclk_table.count++;
 		}
@@ -3006,6 +3008,25 @@ static int smu7_init_voltage_dependency_on_display_clock_table(struct pp_hwmgr *
 	return 0;
 }
 
+static void smu7_set_sclk_cap(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+
+	data->sclk_cap = 0xffffffff;
+
+	if (hwmgr->od_enabled)
+		return;
+
+	/* R9 390X board: last sclk dpm level is unstable, use lower sclk */
+	if (adev->pdev->device == 0x67B0 &&
+	    adev->pdev->subsystem_vendor == 0x1043)
+		data->sclk_cap = 104000; /* 1040 MHz */
+
+	if (data->sclk_cap != 0xffffffff)
+		dev_info(adev->dev, "sclk cap: %u kHz on quirky ASIC\n", data->sclk_cap * 10);
+}
+
 static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -3017,6 +3038,7 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 		return -ENOMEM;
 
 	hwmgr->backend = data;
+	smu7_set_sclk_cap(hwmgr);
 	smu7_patch_voltage_workaround(hwmgr);
 	smu7_init_dpm_defaults(hwmgr);
 
@@ -3903,7 +3925,7 @@ static int smu7_get_pp_table_entry_callback_func_v0(struct pp_hwmgr *hwmgr,
 
 	/* Performance levels are arranged from low to high. */
 	performance_level->memory_clock = memory_clock;
-	performance_level->engine_clock = engine_clock;
+	performance_level->engine_clock = min(engine_clock, data->sclk_cap);
 
 	pcie_gen_from_bios = visland_clk_info->ucPCIEGen;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
index d9e8b386bd4d3..66adabeab6a3a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
@@ -234,6 +234,7 @@ struct smu7_hwmgr {
 	uint32_t                       pcie_gen_cap;
 	uint32_t                       pcie_lane_cap;
 	uint32_t                       pcie_spc_cap;
+	uint32_t                       sclk_cap;
 	struct smu7_leakage_voltage          vddc_leakage;
 	struct smu7_leakage_voltage          vddci_leakage;
 	struct smu7_leakage_voltage          vddcgfx_leakage;
-- 
2.53.0




