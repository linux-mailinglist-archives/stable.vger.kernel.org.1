Return-Path: <stable+bounces-140044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D153AAA461
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38993A3FA3
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC552FE08D;
	Mon,  5 May 2025 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdekeqBC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4052FE083;
	Mon,  5 May 2025 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483968; cv=none; b=jjd/5clNk6RQAneW+mScba/LY3/h81ukPWgMOAdyWoARcU65Eu5qjuDeFKXnV0AqhPzCsPpxtjC+Y/aN6Cu0hXAm6s4kx4jlbsTBoWiwTtdZgOaYuEJDXXH2FjSAlaBha9d0w0NXH7a937Z1q+KfELPDSFFzev8q26B080vPpio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483968; c=relaxed/simple;
	bh=/joEZPBd8kB3980BPrpijXAeJ/K9bcNDy45NL8LnxgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2CcV6qsr/a/K5rEWizn75tAYg1ZQk4LfQHwihnL1AneAF9OQinW5GkG+QpXfaOw+oUVam+g7hjaRJ2wSjROSbtOnNRXme1lCY6vnLtjvka8nq7mYNWiPXNGM7AWh1JOCBpBUXpOh8/d72gVzw48RUlXwyJ0LcUx5P9AVDjz1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdekeqBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40892C4CEEF;
	Mon,  5 May 2025 22:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483968;
	bh=/joEZPBd8kB3980BPrpijXAeJ/K9bcNDy45NL8LnxgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdekeqBCi6PHHaCW2pfNMDqyRA5tWEKygtrEI3oVNl4qqjJRFSvOQ3PVQyZHjMwsp
	 8Kq9gdoN0DUQj5MHxgxv0aVCDj4k5eAPeme7K9NcDcI1Cm8M6Gcs9J27moiNS3uohM
	 zUM/Ehnk/pFm5POoZByDvA9O+GK69AdFsnZaoauUgs5zXGYfNKWT0yWwJLYNT1rhm4
	 uQ3GUV53squPNuZIGQuP+K/WQeQpBbOM1sXAG6VdSTSmsD8Uwojgq008+w9hMo0xA+
	 5uZ6rEkN6RaEa1DquzXXEszQcbbmzTcYExsucIQDr9v/cv9kCUt8U+NBh23d5KJb6D
	 rJWNx28DgLR6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Wajdeczko?= <michal.wajdeczko@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	=?UTF-8?q?Piotr=20Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 297/642] drm/xe/vf: Retry sending MMIO request to GUC on timeout error
Date: Mon,  5 May 2025 18:08:33 -0400
Message-Id: <20250505221419.2672473-297-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>

[ Upstream commit ba757a65d2a28d46a8ccf50538f4f05036983f1b ]

Add support to allow retrying the sending of MMIO requests
from the VF to the GUC in the event of an error. During the
suspend/resume process, VFs begin resuming only after the PF has
resumed. Although the PF resumes, the GUC reset and provisioning
occur later in a separate worker process.

When there are a large number of VFs, some may attempt to resume
before the PF has completed its provisioning. Therefore, if a
MMIO request from a VF fails during this period, we will retry
sending the request up to GUC_RESET_VF_STATE_RETRY_MAX times,
which is set to a maximum of 10 attempts.

Signed-off-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
Cc: Michał Wajdeczko <michal.wajdeczko@intel.com>
Cc: Michał Winiarski <michal.winiarski@intel.com>
Cc: Piotr Piórkowski <piotr.piorkowski@intel.com>
Reviewed-by: Piotr Piorkowski <piotr.piorkowski@intel.com>
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250224102807.11065-3-satyanarayana.k.v.p@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_vf.c b/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
index 9c30cbd9af6e1..1c764f200b2a5 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
@@ -47,12 +47,19 @@ static int guc_action_vf_reset(struct xe_guc *guc)
 	return ret > 0 ? -EPROTO : ret;
 }
 
+#define GUC_RESET_VF_STATE_RETRY_MAX	10
 static int vf_reset_guc_state(struct xe_gt *gt)
 {
+	unsigned int retry = GUC_RESET_VF_STATE_RETRY_MAX;
 	struct xe_guc *guc = &gt->uc.guc;
 	int err;
 
-	err = guc_action_vf_reset(guc);
+	do {
+		err = guc_action_vf_reset(guc);
+		if (!err || err != -ETIMEDOUT)
+			break;
+	} while (--retry);
+
 	if (unlikely(err))
 		xe_gt_sriov_err(gt, "Failed to reset GuC state (%pe)\n", ERR_PTR(err));
 	return err;
-- 
2.39.5


