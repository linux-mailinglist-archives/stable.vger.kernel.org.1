Return-Path: <stable+bounces-235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80667F75AE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243DBB2147C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD928E26;
	Fri, 24 Nov 2023 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CRwgetlN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DEC28E2C
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E18C433C7;
	Fri, 24 Nov 2023 13:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700834039;
	bh=kkemW3ggAlp/qwUYzKy2TB4dFljd4MbqSykNtP0jzFo=;
	h=Subject:To:Cc:From:Date:From;
	b=CRwgetlN6I5DNtGozsTT5JFWwf4+P7/5Vb3ckA/8jx0j24fCU3XCzjOkBoX7Qsu1n
	 hOZiCX2QH6Z5EtOrAWIU6joDDJ1/GFCFLWPducKLP+6uK+L/WfuKjMO4ZR4eUniDFO
	 iIeZukGgMjaVWYmifXJiPL+X2vpq0fVV/2Io2R/k=
Subject: FAILED: patch "[PATCH] drm/amd: Fix logic error in" failed to apply to 6.5-stable tree
To: mario.limonciello@amd.com,alexander.deucher@amd.com,coelacanth_dream@protonmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:53:49 +0000
Message-ID: <2023112449-cautious-donation-6754@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x ade134ddaee5baa1fa35cc66a12d2489213a26e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112449-cautious-donation-6754@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

ade134ddaee5 ("drm/amd: Fix logic error in sienna_cichlid_update_pcie_parameters()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ade134ddaee5baa1fa35cc66a12d2489213a26e0 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 26 Sep 2023 21:07:43 -0500
Subject: [PATCH] drm/amd: Fix logic error in
 sienna_cichlid_update_pcie_parameters()

While aligning SMU11 with SMU13 implementation an assumption was made that
`dpm_context->dpm_tables.pcie_table` was populated in dpm table initialization
like in SMU13 but it isn't.

So restore some of the original logic and instead just check for
amdgpu_device_pcie_dynamic_switching_supported() to decide whether to hardcode
values; erring on the side of performance.

Cc: stable@vger.kernel.org # 6.1+
Reported-and-tested-by: Umio Yasuno <coelacanth_dream@protonmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1447#note_2101382
Fixes: e701156ccc6c ("drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters implementation with SMU13")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 164c2264027d..1f05bfb7d473 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2089,36 +2089,41 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 	return ret;
 }
 
+#define MAX(a, b)	((a) > (b) ? (a) : (b))
+
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_gen_cap,
 					 uint32_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
-	u32 smu_pcie_arg;
+	uint8_t *table_member1, *table_member2;
+	uint32_t min_gen_speed, max_gen_speed;
+	uint32_t min_lane_width, max_lane_width;
+	uint32_t smu_pcie_arg;
 	int ret, i;
 
-	/* PCIE gen speed and lane width override */
-	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
-		if (pcie_table->pcie_gen[NUM_LINK_LEVELS - 1] < pcie_gen_cap)
-			pcie_gen_cap = pcie_table->pcie_gen[NUM_LINK_LEVELS - 1];
+	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
+	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
 
-		if (pcie_table->pcie_lane[NUM_LINK_LEVELS - 1] < pcie_width_cap)
-			pcie_width_cap = pcie_table->pcie_lane[NUM_LINK_LEVELS - 1];
+	min_gen_speed = MAX(0, table_member1[0]);
+	max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
+	min_gen_speed = min_gen_speed > max_gen_speed ?
+			max_gen_speed : min_gen_speed;
+	min_lane_width = MAX(1, table_member2[0]);
+	max_lane_width = MIN(pcie_width_cap, table_member2[1]);
+	min_lane_width = min_lane_width > max_lane_width ?
+			 max_lane_width : min_lane_width;
 
-		/* Force all levels to use the same settings */
-		for (i = 0; i < NUM_LINK_LEVELS; i++) {
-			pcie_table->pcie_gen[i] = pcie_gen_cap;
-			pcie_table->pcie_lane[i] = pcie_width_cap;
-		}
+	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
+		pcie_table->pcie_gen[0] = max_gen_speed;
+		pcie_table->pcie_lane[0] = max_lane_width;
 	} else {
-		for (i = 0; i < NUM_LINK_LEVELS; i++) {
-			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
-				pcie_table->pcie_gen[i] = pcie_gen_cap;
-			if (pcie_table->pcie_lane[i] > pcie_width_cap)
-				pcie_table->pcie_lane[i] = pcie_width_cap;
-		}
+		pcie_table->pcie_gen[0] = min_gen_speed;
+		pcie_table->pcie_lane[0] = min_lane_width;
 	}
+	pcie_table->pcie_gen[1] = max_gen_speed;
+	pcie_table->pcie_lane[1] = max_lane_width;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
 		smu_pcie_arg = (i << 16 |


