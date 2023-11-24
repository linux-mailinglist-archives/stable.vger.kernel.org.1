Return-Path: <stable+bounces-231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868657F75A8
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B13282157
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96DD28E2C;
	Fri, 24 Nov 2023 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mpRidiAS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64864286B9
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66EDC433C9;
	Fri, 24 Nov 2023 13:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700834017;
	bh=jrCsDLgF4UplDxWs8WIl+ljVEB0ulwJf8h5dCde26Jo=;
	h=Subject:To:Cc:From:Date:From;
	b=mpRidiASKDmlqqbeKbz3n9t/BlC3qyxyiTFB/ikIkAW3fjK+uz4vN1p6xD4mq2ET4
	 Udr+EVvBskYFI+ztuoiTF7/GdB85BZlcWT+D5fsMYNphBM6qB/V3lEBPePo9PmY7RO
	 Eooha6kthVI2H5is3oDfoB7nQ21Wri44CwKtycpw=
Subject: FAILED: patch "[PATCH] drm/amdgpu: correct gpu clock counter query on cyan skilfish" failed to apply to 6.5-stable tree
To: Lang.Yu@amd.com,aaron.liu@amd.com,alexander.deucher@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:53:26 +0000
Message-ID: <2023112426-pajamas-spinach-d33a@gregkh>
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
git cherry-pick -x a19d934986b0f750ca95b5da2ebe54ee27fc25e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112426-pajamas-spinach-d33a@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

a19d934986b0 ("drm/amdgpu: correct gpu clock counter query on cyan skilfish")
4e8303cf2c4d ("drm/amdgpu: Use function for IP version check")
6b7d211740da ("drm/amdgpu: Fix refclk reporting for SMU v13.0.6")
1b8e56b99459 ("drm/amdgpu: Restrict bootloader wait to SMUv13.0.6")
983ac45a06ae ("drm/amdgpu: update SET_HW_RESOURCES definition for UMSCH")
822f7808291f ("drm/amdgpu/discovery: enable UMSCH 4.0 in IP discovery")
3488c79beafa ("drm/amdgpu: add initial support for UMSCH")
2da1b04a2096 ("drm/amdgpu: add UMSCH 4.0 api definition")
3ee8fb7005ef ("drm/amdgpu: enable VPE for VPE 6.1.0")
9d4346bdbc64 ("drm/amdgpu: add VPE 6.1.0 support")
e370f8f38976 ("drm/amdgpu: Add bootloader wait for PSP v13")
aba2be41470a ("drm/amdgpu: add mmhub 3.3.0 support")
15e7cbd91de6 ("drm/amdgpu/gfx11: initialize gfx11.5.0")
f56c1941ebb7 ("drm/amdgpu: use 6.1.0 register offset for HDP CLK_CNTL")
15c5c5f57514 ("drm/amdgpu: Add bootloader status check")
3cce0bfcd0f9 ("drm/amd/display: Enable Replay for static screen use cases")
e20ff051707c ("drm/amdgpu: Add memory vendor information")
603b9a575d57 ("drm/amdgpu: skip fence GFX interrupts disable/enable for S0ix")
15419813f2ef ("drm/amd: Hide unsupported power attributes")
47f1724db4fe ("drm/amd: Introduce `AMDGPU_PP_SENSOR_GPU_INPUT_POWER`")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a19d934986b0f750ca95b5da2ebe54ee27fc25e8 Mon Sep 17 00:00:00 2001
From: Lang Yu <Lang.Yu@amd.com>
Date: Thu, 21 Sep 2023 12:29:52 +0800
Subject: [PATCH] drm/amdgpu: correct gpu clock counter query on cyan skilfish

Cayn skilfish uses SMUIO v11.0.8 offset.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: <stable@vger.kernel.org> # v5.15+

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 35357364b5b3..d9ccacd06fba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -102,6 +102,11 @@
 #define mmGCR_GENERAL_CNTL_Sienna_Cichlid			0x1580
 #define mmGCR_GENERAL_CNTL_Sienna_Cichlid_BASE_IDX	0
 
+#define mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish                0x0105
+#define mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish_BASE_IDX       1
+#define mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish                0x0106
+#define mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish_BASE_IDX       1
+
 #define mmGOLDEN_TSC_COUNT_UPPER_Vangogh                0x0025
 #define mmGOLDEN_TSC_COUNT_UPPER_Vangogh_BASE_IDX       1
 #define mmGOLDEN_TSC_COUNT_LOWER_Vangogh                0x0026
@@ -7316,6 +7321,22 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	uint64_t clock, clock_lo, clock_hi, hi_check;
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
+		preempt_disable();
+		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish);
+		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish);
+		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish);
+		/* The SMUIO TSC clock frequency is 100MHz, which sets 32-bit carry over
+		 * roughly every 42 seconds.
+		 */
+		if (hi_check != clock_hi) {
+			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish);
+			clock_hi = hi_check;
+		}
+		preempt_enable();
+		clock = clock_lo | (clock_hi << 32ULL);
+		break;
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):


