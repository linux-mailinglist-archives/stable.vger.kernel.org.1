Return-Path: <stable+bounces-128002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49F2A7AE02
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231F5178395
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA651E1DE3;
	Thu,  3 Apr 2025 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAXyvYQN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB01DF99D;
	Thu,  3 Apr 2025 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707723; cv=none; b=YTVW/Dm0u1uNln1Ha3S7YCsJ4AMq8weGP63pVTURtv4aQZS5A6NGWD6RXAyEm8PC76NEnEDBkeLfOnlVYPWOluG03b5Tk39kJ5sFpVt62eXSKyji2IJ1rc1Pr92Hp4wV2aqvwxJiYqjMrCT52zTqQcYThisEl1T6QednvJyMESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707723; c=relaxed/simple;
	bh=fsd3SSt20hEt2WtM3bbOg0Gfle74YPjrfC0otTbbw+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFvg71BUPTr8DArvpf0NADTke8p1G4FMwSGXZzOppD5MC8WsHIZsnkkYGIrlYuLFCLx5skCp68HpaoU7cqsb8bRsZXyDf7ABpysQkyBXMTRIcDYuKAjdhh7AsQw9QgFviLojnK6JvvI64rmuNnpQAlkTKFPv5oLX706fTPiQDVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAXyvYQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8757C4CEE3;
	Thu,  3 Apr 2025 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707723;
	bh=fsd3SSt20hEt2WtM3bbOg0Gfle74YPjrfC0otTbbw+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAXyvYQNE9RVJazBm4De9sDFMENJyj2X1k6051hMlMloDem4jGQYYt2fNMsusFo7e
	 ZBW6Naevu6rQ8vVDOEHfJhhSVX+6VeRXHucn2Gt3SJC48vs8UOcPb5RQFi8hH+/v4m
	 5g2BMb+Ep+Sbx940DC2MLCcziIEjEv3jQnOz0xW7gPBjQqxiSGcqSyNv4pQVqQU8Wz
	 sZD+JSDbIHYhFewCNI0xEdA5OkiClzAok2RfSChgw2jav9qHtevs9V2O3KJCA0SYsG
	 XMkArM2XvjX46WtGFXF5kqCgubeoRG1+B0CHfJlPVUapzxGQ7PFrXCAjdLlo06EcxJ
	 mB0ZPe9ttpVTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 03/37] drm/xe/pf: Don't send BEGIN_ID if VF has no context/doorbells
Date: Thu,  3 Apr 2025 15:14:39 -0400
Message-Id: <20250403191513.2680235-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 21ccac0e22aaf27b767f9de4bf573e7c47f619c8 ]

It turned out that GuC validates VF configuration immediately
after receiving "some" set of configuration KLVs and complains
if one of the critical, from GuC understanding, resource is left
unprovisioned, even if PF should be still allowed to make late VF
config adjustments, since VF was not yet started.

This issue was discovered after we decided to asynchronously
re-send configuration KLVs after GT reset/resume, as then fair
VF auto-provisioning could already allocate some of the resources,
which was a prerequiste for sending those config KLVs:

 # fair GGTT provisioning
 [] xe 0000:00:02.0: [drm] GT0: PF: pushed VF1 config with 2 KLVs:
 [] xe 0000:00:02.0: [drm] GT0: { key 0x0001 : 64b value 0x176a000 } # ggtt_start
 [] xe 0000:00:02.0: [drm] GT0: { key 0x0002 : 64b value 0xfd696000 } # ggtt_size
 [] xe 0000:00:02.0: [drm] GT0: PF: VF1 provisioned with 4251541504 (3.96 GiB) GGTT
 # re-provisioning worker
 [] xe 0000:00:02.0: [drm] *ERROR* GT0: H2G request 0x5503 failed: error 0x60 hint 0x0
 [] xe 0000:00:02.0: [drm] GT0: PF: Failed to push VF1 14 config KLVs (-EIO)
 [] xe 0000:00:02.0: [drm] GT0: { key 0x0001 : 64b value 0x176a000 } # ggtt_start
 [] xe 0000:00:02.0: [drm] GT0: { key 0x0002 : 64b value 0xfd696000 } # ggtt_size
 [] xe 0000:00:02.0: [drm] GT0: { key 0x8a0b : 32b value 0 } # begin_ctx_id
 [] xe 0000:00:02.0: [drm] GT0: { key 0x0004 : 32b value 0 } # num_contexts
 [] xe 0000:00:02.0: [drm] GT0: { key 0x8a0a : 32b value 0 } # begin_db_id
 [] xe 0000:00:02.0: [drm] GT0: { key 0x0006 : 32b value 0 } # num_doorbells
 [] xe 0000:00:02.0: [drm] GT0: { key 0x8a01 : 32b value 0 } # exec_quantum
 [] xe 0000:00:02.0: [drm] GT0: { key 0x8a02 : 32b value 0 } # preempt_timeout
 [] xe 0000:00:02.0: [drm] GT0: { key 0x8a03 : 32b value 0 } # cat_error_count
 [] xe 0000:00:02.0: [drm] GT0: { key 0x8a04 : 32b value 0 } # engine_reset_count
 [] xe 0000:00:02.0: [drm] GT0: { key 0x8a05 : 32b value 0 } # page_fault_count
 [] xe 0000:00:02.0: [drm] GT0: { key 0x8a06 : 32b value 0 } # guc_time_us
 [] xe 0000:00:02.0: [drm] GT0: { key 0x8a07 : 32b value 0 } # irq_time_us
 [] xe 0000:00:02.0: [drm] GT0: { key 0x8a08 : 32b value 0 } # doorbell_time_us
 [] xe 0000:00:02.0: [drm] GT0: PF: Failed to push VF1 configuration (-EIO)

To avoid such errors stop sending BEGIN_CONTEXT/DOORBELL_ID KLVs
if no GuC context/doorbell IDs were provisioned to VF.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4176
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Michał Winiarski <michal.winiarski@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250129195947.764-2-michal.wajdeczko@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
index ca49860168f6d..ca566e3761e1d 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
@@ -257,7 +257,7 @@ static u32 encode_config(u32 *cfg, const struct xe_gt_sriov_config *config, bool
 
 	n += encode_config_ggtt(cfg, config, details);
 
-	if (details) {
+	if (details && config->num_ctxs) {
 		cfg[n++] = PREP_GUC_KLV_TAG(VF_CFG_BEGIN_CONTEXT_ID);
 		cfg[n++] = config->begin_ctx;
 	}
@@ -265,7 +265,7 @@ static u32 encode_config(u32 *cfg, const struct xe_gt_sriov_config *config, bool
 	cfg[n++] = PREP_GUC_KLV_TAG(VF_CFG_NUM_CONTEXTS);
 	cfg[n++] = config->num_ctxs;
 
-	if (details) {
+	if (details && config->num_dbs) {
 		cfg[n++] = PREP_GUC_KLV_TAG(VF_CFG_BEGIN_DOORBELL_ID);
 		cfg[n++] = config->begin_db;
 	}
-- 
2.39.5


