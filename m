Return-Path: <stable+bounces-141127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B8EAAB0D4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC4A3A97C9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C06326066;
	Tue,  6 May 2025 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUTXCooE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39D2BE110;
	Mon,  5 May 2025 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485252; cv=none; b=nwivD3Yjr1nOtLtFHSRAfEXXdfB5p4YCqqJ9wJB31UcIdcG2Thir7Sy9aHMcUPRaKtApFJyQt/MEDimSXK4vjwDJvZ72QA6LPLtgMEMiiu5gQ0T3upvhNzh//FkOKYxc+uLLbrWaRBSwirhQWyxlZ2ZB+8np+4E+6fsLvq0izTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485252; c=relaxed/simple;
	bh=W46LSlL8PNcCg/BgoRCw2sj0WkVz49Qmr0jlJ6VpNFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qse4d0rqyKd7xMw8VOuSKoIT3e4/nYE60f3f5j4z6MfOhXT4hwIZCxlqoGjWjca/wM4+FXIaMWhV8D+mHrHROVaB7um/d8r78L6NW65bqp39pqA3MuIJokYFALoO+8e8TOur5qceCqrRvCy6mDB6FqMKsZkwE3jrihKNAjj5vBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUTXCooE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D92C4CEEF;
	Mon,  5 May 2025 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485251;
	bh=W46LSlL8PNcCg/BgoRCw2sj0WkVz49Qmr0jlJ6VpNFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUTXCooEf3zQTEsG/QY0k3fG3qJu0OQe/hSRJt2h63nkkOKXwJ6+8Y1XyklNNgOoe
	 lyMq8S+yobVLaXIh7npMfGFy2f+JauNVpVYAPMn0Eme/G4zyRTZpQLdxSa4raKwPha
	 VYsqmZoowqaw5+jht7AgeNHkXTTNcuS+ejhG9B7dGJTvZBAGN69SulhZ4tRpB5SpjR
	 Uf3bMxSSOTawXRcuK6AUwBd5nmHwt9SqOg3nSl7IKRjYAVzXUMkku7Tu6lWLECFGxW
	 /x1eQ9Fx5ou1vFKkvIFt3W59ENgxazsjoii0rB4OU+bxe+RsmUEFPDVi26/jAW3P4/
	 4ZnG3YVCjeBrQ==
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
Subject: [PATCH AUTOSEL 6.12 236/486] drm/xe/vf: Retry sending MMIO request to GUC on timeout error
Date: Mon,  5 May 2025 18:35:12 -0400
Message-Id: <20250505223922.2682012-236-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index f982d6f9f218d..7ddbfeaf494ac 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
@@ -46,12 +46,19 @@ static int guc_action_vf_reset(struct xe_guc *guc)
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


