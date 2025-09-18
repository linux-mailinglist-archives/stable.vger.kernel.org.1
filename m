Return-Path: <stable+bounces-180561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D92B86083
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 18:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00AE0162FBF
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD503161BB;
	Thu, 18 Sep 2025 16:25:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B1A14B06C;
	Thu, 18 Sep 2025 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212743; cv=none; b=k0atL0BJkjperEk0+b0Wk0ea3sn9BfZ++6vg9IGA1Wvb6k5ClntvG13jxkpYtWPoYjOHxedVngCShwZv7NZW52GCvQ075R+UVkumXR+Ri57y9bVptMoCLonB57StvGRmSjrZ3k9wnuQDcKSJ/PeZEonYg6ZAVJDAfl/1uQR92II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212743; c=relaxed/simple;
	bh=yoJm0h0nEd1ymiNbwpGC0swfY0I68k78+ZMpOcMi0mI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ieWIstLSZyM6jUlAMAPuSfC0JwGBefqV3YusInBpNmYb6k25gyGiGLoFseybssCCa2TZw6qjmfPpFxPGIamFdLHlkF+JaaRXelsQnjupJYYxsw5XXgKVyML3mBH5zIgXW1KWJII0dNvv7vgCKvZSdh753DacVnvyG1Jd3/XGsYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79777176C;
	Thu, 18 Sep 2025 09:25:32 -0700 (PDT)
Received: from 010265703453.cambridge.arm.com (010265703453.cambridge.arm.com [10.1.33.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A7FB73F673;
	Thu, 18 Sep 2025 09:25:39 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] perf/arm-cmn: Fix CMN S3 DTM offset
Date: Thu, 18 Sep 2025 17:25:31 +0100
Message-Id: <f1248eedc2d082c80f5299747acedc8decb94c70.1758212731.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CMN S3's DTM offset is different between r0px and r1p0, and it
turns out this was not a error in the earlier documentation, but
does actually exist in the design. Lovely.

Cc: stable@vger.kernel.org
Fixes: 0dc2f4963f7e ("perf/arm-cmn: Support CMN S3")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 50695b95fbfd..6698f0ec94e9 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -65,7 +65,7 @@
 /* PMU registers occupy the 3rd 4KB page of each node's region */
 #define CMN_PMU_OFFSET			0x2000
 /* ...except when they don't :( */
-#define CMN_S3_DTM_OFFSET		0xa000
+#define CMN_S3_R1_DTM_OFFSET		0xa000
 #define CMN_S3_PMU_OFFSET		0xd900
 
 /* For most nodes, this is all there is */
@@ -233,6 +233,9 @@ enum cmn_revision {
 	REV_CMN700_R1P0,
 	REV_CMN700_R2P0,
 	REV_CMN700_R3P0,
+	REV_CMNS3_R0P0 = 0,
+	REV_CMNS3_R0P1,
+	REV_CMNS3_R1P0,
 	REV_CI700_R0P0 = 0,
 	REV_CI700_R1P0,
 	REV_CI700_R2P0,
@@ -425,8 +428,8 @@ static enum cmn_model arm_cmn_model(const struct arm_cmn *cmn)
 static int arm_cmn_pmu_offset(const struct arm_cmn *cmn, const struct arm_cmn_node *dn)
 {
 	if (cmn->part == PART_CMN_S3) {
-		if (dn->type == CMN_TYPE_XP)
-			return CMN_S3_DTM_OFFSET;
+		if (cmn->rev >= REV_CMNS3_R1P0 && dn->type == CMN_TYPE_XP)
+			return CMN_S3_R1_DTM_OFFSET;
 		return CMN_S3_PMU_OFFSET;
 	}
 	return CMN_PMU_OFFSET;
-- 
2.34.1


