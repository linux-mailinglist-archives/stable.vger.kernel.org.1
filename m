Return-Path: <stable+bounces-139968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6329BAAA315
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC1A1A844FE
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666E02EDB07;
	Mon,  5 May 2025 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN9+Bjy0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FEF27933C;
	Mon,  5 May 2025 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483795; cv=none; b=HFm2EV43q7x6/oqAXG0HrHgwpfDX54M/l0ycdJSexJo0w5oQWlz249/9tCcjGYYsUAEXAXBijOPx18Bm3RSUoxnAU7XYIepPXV0p8H4XXdEcNXmJELgg7zzCyptOWyou4MRy6WhTnBvKbVbkejCuVi46LVrRy9L0plBwnse3tbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483795; c=relaxed/simple;
	bh=BkhcAlPlBh84hHlB+fG4PpMxy+yV46nOJg864LsmRAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AvVFyGepVE6a15dygTYXkI74xKrsG5bXsdNI8mGA0sROpR8+c4lT1MIp/mxBvb4tlzKRWLajwEafaaAooMIZtvFn347hqVFX+QPeERw5TgnxFHzgBdruf5fi2u5xIbZvWZg64Qo2zNtLYrW8GsVrYi3MRz4uH4Ry5PRD29Btb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN9+Bjy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E936C4CEED;
	Mon,  5 May 2025 22:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483795;
	bh=BkhcAlPlBh84hHlB+fG4PpMxy+yV46nOJg864LsmRAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RN9+Bjy0FByy9WrrjnidYQWVDKExvJzqEiKNMamje+KWCaEKkxIBWbH11YkbDatdu
	 gmvLQbeWe44pbHW01dPGq7JUm54lBt5G0uC+YDX8CEoOp3I6kEIliCkqQDBU4UjYtn
	 lN/bPnNsq/uTpQVR7T/NjdQ7r4QtRpPv+LI493oyEmgBF66tx4rQpK+UcHQ+UGQo5m
	 7cFf3/C/GOaLBlA2M1bGhIFVJbHMAz0/kKPxG9kKrs8t6K14PzilqtxaDwfw6A4cFm
	 mDmDb2gn1LfPqU6a3wRoc0WAirHD5EQ2iJkhng/gmLRMIKntnrpqE3fiRCSWZkBIrX
	 PyYyZBlwFeFXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tao Zhou <tao.zhou1@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	ganglxie@amd.com,
	Stanley.Yang@amd.com,
	lijo.lazar@amd.com,
	candice.li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 221/642] drm/amdgpu: increase RAS bad page threshold
Date: Mon,  5 May 2025 18:07:17 -0400
Message-Id: <20250505221419.2672473-221-sashal@kernel.org>
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

From: Tao Zhou <tao.zhou1@amd.com>

[ Upstream commit 334dc5fcc3f177823115ec4e075259997c16d4a7 ]

For default policy, driver will issue an RMA event when the number of
bad pages is greater than 8 physical rows, rather than reaches 8
physical rows, don't rely on threshold configurable parameters in
default mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 52c16bfeccaad..12ffe4a963d31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -748,7 +748,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	/* Modify the header if it exceeds.
 	 */
 	if (amdgpu_bad_page_threshold != 0 &&
-	    control->ras_num_bad_pages >= ras->bad_page_cnt_threshold) {
+	    control->ras_num_bad_pages > ras->bad_page_cnt_threshold) {
 		dev_warn(adev->dev,
 			"Saved bad pages %d reaches threshold value %d\n",
 			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
@@ -806,7 +806,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	 */
 	if (amdgpu_bad_page_threshold != 0 &&
 	    control->tbl_hdr.version == RAS_TABLE_VER_V2_1 &&
-	    control->ras_num_bad_pages < ras->bad_page_cnt_threshold)
+	    control->ras_num_bad_pages <= ras->bad_page_cnt_threshold)
 		control->tbl_rai.health_percent = ((ras->bad_page_cnt_threshold -
 						   control->ras_num_bad_pages) * 100) /
 						   ras->bad_page_cnt_threshold;
@@ -1451,7 +1451,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 				  res);
 			return -EINVAL;
 		}
-		if (ras->bad_page_cnt_threshold > control->ras_num_bad_pages) {
+		if (ras->bad_page_cnt_threshold >= control->ras_num_bad_pages) {
 			/* This means that, the threshold was increased since
 			 * the last time the system was booted, and now,
 			 * ras->bad_page_cnt_threshold - control->num_recs > 0,
-- 
2.39.5


