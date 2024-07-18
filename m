Return-Path: <stable+bounces-60561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A61934EFE
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 16:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832D4283919
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26913CA8A;
	Thu, 18 Jul 2024 14:17:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C14DDB8;
	Thu, 18 Jul 2024 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721312277; cv=none; b=UurF1KEIPPsK9thxl8NYjHeMewVRUiQqV2RKTowPYdc2zg5v8Wc2UlLBJPwTSdxVSHdNpMpESgxJHNGOsJoHd+TI2vHJ0bE79pvG6d65y0+nuwUUDEZJxtFvl36tAfdeEnz48oxpPm65o6sAuNYXJENRXHlOYJbO9HyezHhZYAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721312277; c=relaxed/simple;
	bh=RcoV8/M0MDaBl/W7j/eL2SU1pdRDKJ0SgHyHMsP5GQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A+MrRlspS3E/7pkDHfYLacfqM8osPwvtaYJLgJTaX8nI7zSvDvPDML6BRplwEyjftB5ZrQNuP8J03SNkFvLDoWJMn2VVhYSRGFQ4uws29Hc+wS9cjuQATYpGC+EWghTnkPXvAizI6/ofaKG0iVw1WAykAy4RPl7ndtL+A5ro8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowACXd0wHJJlmgs0TBA--.3468S2;
	Thu, 18 Jul 2024 22:17:47 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	lijo.lazar@amd.com,
	make24@iscas.ac.cn,
	asad.kamal@amd.com,
	le.ma@amd.com,
	kenneth.feng@amd.com,
	evan.quan@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/amd/amdgpu: Fix uninitialized variable warnings
Date: Thu, 18 Jul 2024 22:17:35 +0800
Message-Id: <20240718141735.884347-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXd0wHJJlmgs0TBA--.3468S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtryrKF48CrW7ZFWxKFWDXFb_yoW3uFg_Kr
	4UJasrGr9rAF1qgr1UZayFvFy2yF98uF4kta4ktFyFv3y7X343Xr93WFykXF1ruF43C3Zr
	Aa4UWr15AwsIkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbZmitUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Return 0 to avoid returning an uninitialized variable r.

Cc: stable@vger.kernel.org
Fixes: 230dd6bb6117 ("drm/amd/amdgpu: implement mode2 reset on smu_v13_0_10")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- added Cc stable line.
---
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index 04c797d54511..0af648931df5 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -91,7 +91,7 @@ static int smu_v13_0_10_mode2_suspend_ip(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.hw = false;
 	}
 
-	return r;
+	return 0;
 }
 
 static int
-- 
2.25.1


