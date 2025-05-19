Return-Path: <stable+bounces-144730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD8CABB36D
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 04:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78FD7AA0B2
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 02:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69AC1DBB13;
	Mon, 19 May 2025 02:41:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2324A94F;
	Mon, 19 May 2025 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747622480; cv=none; b=mkl9NDZV7ZMOv9Z6UanQkVOQh3Se9hiJEkIChvkdaHag4DNrZqjiihxcNljJY0fkGuiAqLgq31/bBd6UcC1x73Asgq8bcoM9RTRoowm7TVGZqcOOi67zyex8bD5zB1k4QWHNMpAR3SHvWPLdBvWSkntqrRfV5c/YZgyIAD3N7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747622480; c=relaxed/simple;
	bh=FvP3hUURlzaObOTyBgrf0qa89O3CbPtk5X36mTObOys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XYrQZrQi77KdS5IS17Wy+pl8QSlea34X3MKzFT6kHo4PUid/iPP4qZ5q1xHzZ+xhtIh4YK8aOE2HZKSAxaBRg213iv44e2tUr+NnhV1O+4dUjK/4Xd9HfXjmYPGmTq6vgTV82eliJswtzytznbathyGv8+GNiX/Ms1475dkEmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowAAHGvVEmipoO59DAQ--.10155S2;
	Mon, 19 May 2025 10:41:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm: radeon: ci_dpm: Add error handling in ci_enable_vce_dpm()
Date: Mon, 19 May 2025 10:40:35 +0800
Message-ID: <20250519024036.1119-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHGvVEmipoO59DAQ--.10155S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1DZr4ruF1fXF43tF4fZrb_yoW8WFW8p3
	yDWFyYyrZ5Aay8WanFyw4DAryruws7JFWxJFsFk345uw4ayFy8JF13XryayFy0vr92gFya
	vrn2k3WkZr4UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOtC7UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwHA2gqdbeYjQAAsb

The ci_enable_vce_dpm() calls ci_send_msg_to_smc_with_parameter()
but does not check the return value. A proper implementation can be
found in the ci_upload_dpm_level_enable_mask().

Add a check after calling ci_send_msg_to_smc_with_parameter(), return
-EINVAL if the sending fails.

Fixes: cc8dbbb4f62a ("drm/radeon: add dpm support for CI dGPUs (v2)")
Cc: stable@vger.kernel.org # v3.12
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 3877863c6893..c4faaa16a5c4 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -3945,6 +3945,7 @@ static int ci_enable_vce_dpm(struct radeon_device *rdev, bool enable)
 	struct ci_power_info *pi = ci_get_pi(rdev);
 	const struct radeon_clock_and_voltage_limits *max_limits;
 	int i;
+	PPSMC_Result result;
 
 	if (rdev->pm.dpm.ac_power)
 		max_limits = &rdev->pm.dpm.dyn_state.max_clock_voltage_on_ac;
@@ -3962,9 +3963,11 @@ static int ci_enable_vce_dpm(struct radeon_device *rdev, bool enable)
 			}
 		}
 
-		ci_send_msg_to_smc_with_parameter(rdev,
-						  PPSMC_MSG_VCEDPM_SetEnabledMask,
-						  pi->dpm_level_enable_mask.vce_dpm_enable_mask);
+		result = ci_send_msg_to_smc_with_parameter(rdev,
+				PPSMC_MSG_VCEDPM_SetEnabledMask,
+				pi->dpm_level_enable_mask.vce_dpm_enable_mask);
+		if (result != PPSMC_Result_OK)
+			return -EINVAL;
 	}
 
 	return (ci_send_msg_to_smc(rdev, enable ?
-- 
2.42.0.windows.2


