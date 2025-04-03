Return-Path: <stable+bounces-127961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E8CA7ADA8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C694F3A74E4
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D53425D21D;
	Thu,  3 Apr 2025 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9dMkvM8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE8325D1FB;
	Thu,  3 Apr 2025 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707609; cv=none; b=FBVycMF9n33y1uYJ60ZLFQpt0rqLPDoTEJvJRQ6NSaIboBDkayH+BJsB5V212IIiC+cZE+g7gayBOlCVe85czX4BfeKSKEmDdyusPMpadpGdRkqN3nSsRIMe6HhO0lF/KbebDdqcXuUfTB3eUb/qjdniiJwD+xjGdaYDBbSOFvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707609; c=relaxed/simple;
	bh=ZitZnKc6GaKj3znOrVC+fxWxvciTXM4EsePKmqwYpAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUgLp5O8YGn7DT3cUiiDrURBYbRJ3U/NMaMbnAlfpOfbMB5sYciTZkkrfKex+3RNpGsz34yX3zP8NxL6KgCaXqI3Pvwwzr1DKI8Ujl9AoLZm4/qnyjt+eWfx9Bh67K2vI6HcbugpPC4Y3tzjbRsv0MORm6A9p0ZLs/JPsYzaXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9dMkvM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4E7C4CEE3;
	Thu,  3 Apr 2025 19:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707608;
	bh=ZitZnKc6GaKj3znOrVC+fxWxvciTXM4EsePKmqwYpAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9dMkvM8vW2HAYcofHC8sjHWVhrRQ7lghSLVg4mE8szYnvYto1vJtRZy3w3v8Vx8H
	 AFLxboZPRhRu1pvjEKA2Db6tP4dPWN8D50WiaQ/o3dviz/AOPtMKl2avmHOFEaYtYS
	 yvZFkYtX/OUGQE68zyazIpxklsK554AjZh1G2in27dc/f7s/Em0l45KjIDzbFpskMd
	 SWlCy/56pVZz0EvKAiJtJyfB3mIpu/RXM2PpfAoPpep83Tt9xxIL2c4M2C6wnnKXfp
	 bTx+4/PKynvLdnDP+8T/n5kXm6DB3/MfFDz9VNHLj6FW1sx+ELr3GMTjQixq+gE0ZN
	 U1JIR2tdMrq2g==
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
Subject: [PATCH AUTOSEL 6.14 06/44] drm/xe/pf: Don't send BEGIN_ID if VF has no context/doorbells
Date: Thu,  3 Apr 2025 15:12:35 -0400
Message-Id: <20250403191313.2679091-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index 878e96281c035..4bd255adfb401 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
@@ -262,7 +262,7 @@ static u32 encode_config(u32 *cfg, const struct xe_gt_sriov_config *config, bool
 
 	n += encode_config_ggtt(cfg, config, details);
 
-	if (details) {
+	if (details && config->num_ctxs) {
 		cfg[n++] = PREP_GUC_KLV_TAG(VF_CFG_BEGIN_CONTEXT_ID);
 		cfg[n++] = config->begin_ctx;
 	}
@@ -270,7 +270,7 @@ static u32 encode_config(u32 *cfg, const struct xe_gt_sriov_config *config, bool
 	cfg[n++] = PREP_GUC_KLV_TAG(VF_CFG_NUM_CONTEXTS);
 	cfg[n++] = config->num_ctxs;
 
-	if (details) {
+	if (details && config->num_dbs) {
 		cfg[n++] = PREP_GUC_KLV_TAG(VF_CFG_BEGIN_DOORBELL_ID);
 		cfg[n++] = config->begin_db;
 	}
-- 
2.39.5


