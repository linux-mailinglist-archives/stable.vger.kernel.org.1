Return-Path: <stable+bounces-140286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC44AAA70A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7D61620A4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1F427F16D;
	Mon,  5 May 2025 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAL5jiSh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493227F166;
	Mon,  5 May 2025 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484562; cv=none; b=WolR/yRRT16iDfSwYI6G2An/qTiFAAcTsct7k7S9G1BimyFauMOIJrsI8uUrnx8JyE1YbvB8dgYov4nlH9ysJ/eTj0IwcopwGDUhmw5q3uvEKcU3egI1V/ihfbqLhyEkOmySmeyQqrIXtZyxOzUL7tMW2Ri/Wu0HgPANey5rHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484562; c=relaxed/simple;
	bh=F973BCTRSrl66uFyaTkGbQP5pwTjAHxZzTa3RasnXYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fYXy80CAvZxETfSFI80dqXZb2SvkKLXpQv8U9ldpT/++K4KqI8EPVRLockAM8pE+cZiucPm6d9GncaXUxLRKDh3H34dYScJECy0oQ2kYlGiZI9DhXEbwHNuc/hOoLyVs7Mt+LiFDWWLi56NJ1SB6LuGLPtO7sj+bpZRh9kKbNPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAL5jiSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEA0C4CEEF;
	Mon,  5 May 2025 22:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484562;
	bh=F973BCTRSrl66uFyaTkGbQP5pwTjAHxZzTa3RasnXYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAL5jiShD1jcoT9NJeWEkRHNGDEhJGshphEFvLPE18TbeZ+RorTjxlKy1alBHDKFq
	 wUU66NfQCjGdm0FflVZGGiJJekR7NI+szq+SJKBvV7Jk8eSRZGH9OrgRVhchGdTP9z
	 R0KIU31RD0fVUMCj3OwBdDcEqy+xnd/MsUzfNi1IC5ZP9XIUJ3z4/C/8VY4xImzKLq
	 AohA9l+StxIqvExexq3mx/FkkYvO5J0XVtTdA3ffw9CKQrZPLbMMIYNfraEntzl9wY
	 oLO52wmA5y9HEuPNudmFEKseyL7Iankf46TXnHrX5TvtvWPd/jjsor0MJerMtpZQ7Y
	 ZNYlSU9ZrL9gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 538/642] drm/xe: Fix PVC RPe and RPa information
Date: Mon,  5 May 2025 18:12:34 -0400
Message-Id: <20250505221419.2672473-538-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Rodrigo Vivi <rodrigo.vivi@intel.com>

[ Upstream commit 8a734b9359cfa1bdb805f5ca23e20bd99dd18a0a ]

A simple lazy buggy copy and paste of the PVC comment has brought
the attention to the incorrect masks of the PVC register for RPa
and RPe. So, let's fix them all.

Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Reviewed-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250109195219.658557-1-rodrigo.vivi@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc_pc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index f382f5d53ca8b..2276d85926fcb 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -371,16 +371,17 @@ static void tgl_update_rpa_value(struct xe_guc_pc *pc)
 	u32 reg;
 
 	/*
-	 * For PVC we still need to use fused RP1 as the approximation for RPe
-	 * For other platforms than PVC we get the resolved RPe directly from
+	 * For PVC we still need to use fused RP0 as the approximation for RPa
+	 * For other platforms than PVC we get the resolved RPa directly from
 	 * PCODE at a different register
 	 */
-	if (xe->info.platform == XE_PVC)
+	if (xe->info.platform == XE_PVC) {
 		reg = xe_mmio_read32(&gt->mmio, PVC_RP_STATE_CAP);
-	else
+		pc->rpa_freq = REG_FIELD_GET(RP0_MASK, reg) * GT_FREQUENCY_MULTIPLIER;
+	} else {
 		reg = xe_mmio_read32(&gt->mmio, FREQ_INFO_REC);
-
-	pc->rpa_freq = REG_FIELD_GET(RPA_MASK, reg) * GT_FREQUENCY_MULTIPLIER;
+		pc->rpa_freq = REG_FIELD_GET(RPA_MASK, reg) * GT_FREQUENCY_MULTIPLIER;
+	}
 }
 
 static void tgl_update_rpe_value(struct xe_guc_pc *pc)
@@ -394,12 +395,13 @@ static void tgl_update_rpe_value(struct xe_guc_pc *pc)
 	 * For other platforms than PVC we get the resolved RPe directly from
 	 * PCODE at a different register
 	 */
-	if (xe->info.platform == XE_PVC)
+	if (xe->info.platform == XE_PVC) {
 		reg = xe_mmio_read32(&gt->mmio, PVC_RP_STATE_CAP);
-	else
+		pc->rpe_freq = REG_FIELD_GET(RP1_MASK, reg) * GT_FREQUENCY_MULTIPLIER;
+	} else {
 		reg = xe_mmio_read32(&gt->mmio, FREQ_INFO_REC);
-
-	pc->rpe_freq = REG_FIELD_GET(RPE_MASK, reg) * GT_FREQUENCY_MULTIPLIER;
+		pc->rpe_freq = REG_FIELD_GET(RPE_MASK, reg) * GT_FREQUENCY_MULTIPLIER;
+	}
 }
 
 static void pc_update_rp_values(struct xe_guc_pc *pc)
-- 
2.39.5


