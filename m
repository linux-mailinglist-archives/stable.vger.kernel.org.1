Return-Path: <stable+bounces-258516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEpDITgoG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:11:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BB5611304
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BDE43047991
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D3D3B9D80;
	Sat, 30 May 2026 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZdoqBOaU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503BC362157;
	Sat, 30 May 2026 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164612; cv=none; b=mzCpTCSqO50MUbU5emjyB73lqDXuDSiJuhkjlqbq4OzQ+cB2IdyYxFQPHq+hIsVriZd9g6k7pum2lCou8GNzkg5B9So7XYSHqcfVpnQuyR7cDgBaQWQgBqKJVQt9WxP325pBz3noLPfDV5u8KcxL9IZoSvy93lGHCgsppaVS4rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164612; c=relaxed/simple;
	bh=Zp1qapp7Xtxke4TQG219ek/5trwPD5SN8Srg/Ah3FgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apAfMTir7tX2Nxjukb2n2pgd+EY4CEOyYiY/blciw9cx5gbFbu+Ds6HTUfpDqkpbRjScuMCPAQU7oUM8AzUwrC7QNJCXkt9FBkX5F7c6qv4yctcPmIRbXqYT/Re8AbSBv2idMftJTR7x7snKvoOKT3g6x9f9uz/iLI9PP/toOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZdoqBOaU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DED1F00893;
	Sat, 30 May 2026 18:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164611;
	bh=yaZQ4+zb06TKgPfx/1eLsa3iXnW8Pf5H2kNjhbYI/qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZdoqBOaU+ezhCSB92Vos1HRVbpLYni9LQCDqBZakwV7L+dAsyjgAf+pb8shQuhwWR
	 twvrxK62BHRUAIDbrl6n7tTtLpreD5fB2pQnXiZiKUJ6G6EarP/it9wskQBa1SPOAi
	 VdmjoC8G+s6ovxkIZu7BYcUx1H55ceIF8PJwSCSg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre Demers <alexandre.f.demers@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 606/776] drm/amdgpu: fix spelling typos
Date: Sat, 30 May 2026 18:05:20 +0200
Message-ID: <20260530160255.680598072@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258516-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 02BB5611304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Demers <alexandre.f.demers@gmail.com>

[ Upstream commit ce43abd7ec9464cf954f90e1c69e11768b02fa0a ]

Found some typos while exploring amdgpu code.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 13e4cf116dbf ("drm/amdgpu/uvd3.1: Don't validate the firmware when already validated")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c   | 6 +++---
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c   | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 259897f1ea8a4..e00d1637859fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -259,7 +259,7 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
  * @adev: amdgpu device structure holding all necessary information
  * @mc: memory controller structure holding memory information
  *
- * Function will place try to place GART before or after VRAM.
+ * Function will try to place GART before or after VRAM.
  * If GART size is bigger than space left then we ajust GART size.
  * Thus function will never fails.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index e458e0d5801b0..fbfed90503868 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -98,7 +98,7 @@ static void uvd_v3_1_ring_emit_ib(struct amdgpu_ring *ring,
 }
 
 /**
- * uvd_v3_1_ring_emit_fence - emit an fence & trap command
+ * uvd_v3_1_ring_emit_fence - emit a fence & trap command
  *
  * @ring: amdgpu_ring pointer
  * @addr: address
@@ -242,7 +242,7 @@ static void uvd_v3_1_mc_resume(struct amdgpu_device *adev)
 	uint64_t addr;
 	uint32_t size;
 
-	/* programm the VCPU memory controller bits 0-27 */
+	/* program the VCPU memory controller bits 0-27 */
 	addr = (adev->uvd.inst->gpu_addr + AMDGPU_UVD_FIRMWARE_OFFSET) >> 3;
 	size = AMDGPU_UVD_FIRMWARE_SIZE(adev) >> 3;
 	WREG32(mmUVD_VCPU_CACHE_OFFSET0, addr);
@@ -416,7 +416,7 @@ static int uvd_v3_1_start(struct amdgpu_device *adev)
 	/* Set the write pointer delay */
 	WREG32(mmUVD_RBC_RB_WPTR_CNTL, 0);
 
-	/* programm the 4GB memory segment for rptr and ring buffer */
+	/* Program the 4GB memory segment for rptr and ring buffer */
 	WREG32(mmUVD_LMI_EXT40_ADDR, upper_32_bits(ring->gpu_addr) |
 		   (0x7 << 16) | (0x1 << 31));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index c108b83817951..01d8e7d2caf97 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -298,7 +298,7 @@ static int uvd_v4_2_start(struct amdgpu_device *adev)
 	/* enable VCPU clock */
 	WREG32(mmUVD_VCPU_CNTL,  1 << 9);
 
-	/* disable interupt */
+	/* disable interrupt */
 	WREG32_P(mmUVD_MASTINT_EN, 0, ~(1 << 1));
 
 #ifdef __BIG_ENDIAN
@@ -308,6 +308,7 @@ static int uvd_v4_2_start(struct amdgpu_device *adev)
 #endif
 	WREG32(mmUVD_LMI_SWAP_CNTL, lmi_swap_cntl);
 	WREG32(mmUVD_MP_SWAP_CNTL, mp_swap_cntl);
+
 	/* initialize UVD memory controller */
 	WREG32(mmUVD_LMI_CTRL, 0x203108);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 98952fd387e73..ddbcfcc70df5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -278,7 +278,7 @@ static int vce_v2_0_stop(struct amdgpu_device *adev)
 	int status;
 
 	if (vce_v2_0_lmi_clean(adev)) {
-		DRM_INFO("vce is not idle \n");
+		DRM_INFO("VCE is not idle \n");
 		return 0;
 	}
 
-- 
2.53.0




