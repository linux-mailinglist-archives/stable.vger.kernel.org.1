Return-Path: <stable+bounces-206255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D42CD01608
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 08:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 014F63001BD0
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 07:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E14275B15;
	Thu,  8 Jan 2026 07:18:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B431CBEB9;
	Thu,  8 Jan 2026 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767856723; cv=none; b=PbZeeeVX+IS1GjiUrYobo8hulsSM7yydcIHvAzGNoMRmIFaGT2wGoo6yx4h62zrA3+rVe8yN7E/BdLFHbE2QBPVEQRxiNLGPVfZzjUpL2/L0c65GMqNgQV2dPVLjhkLlQLnooCLXvLcL/Xr8PIJ9KudT3R2D2PECPftEmI47CJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767856723; c=relaxed/simple;
	bh=8QuzmeNFhbL/VxHTcYfk1nMRykk78lEwqijmZZEgFpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dn01qFhYcyPcER3eRUb/5CIF82+R6uVBrSMayCVRCb7rVKKivToGuXJ/PhbFJUFKk654j+NpOlmHG5Jw0SxLWmiuGxMrB5B+7qoCn49BxcNtZ1HqnAQZKmlLotcUrBCMLAhW4IhwsDAsOad+k0BTzJff/u3j6o3z9VpryjU/t3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-05 (Coremail) with SMTP id zQCowACHHRFAWl9pfor3Aw--.56272S2;
	Thu, 08 Jan 2026 15:18:24 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: Felix.Kuehling@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	ozeng@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/amdkfd: fix a memory leak in device_queue_manager_init()
Date: Thu,  8 Jan 2026 15:18:22 +0800
Message-Id: <20260108071822.297364-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHHRFAWl9pfor3Aw--.56272S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyUKw1rXw1fAFy3try3XFb_yoW8Zw1kpF
	Z3Ja45J348tr429asrZayUCa43Gw4fGr93WrWxK3s2gr4avr98Xrn5Xr4rW3yrKrWxCF4j
	q3yrKFW5tr10yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiCQ4BE2le-Z5SAQABsT

If dqm->ops.initialize() fails, add deallocate_hiq_sdma_mqd()
to release the memory allocated by allocate_hiq_sdma_mqd().
Move deallocate_hiq_sdma_mqd() up to ensure proper function
visibility at the point of use.

Fixes: 11614c36bc8f ("drm/amdkfd: Allocate MQD trunk for HIQ and SDMA")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
Chnages in v3:
- recheck the patch format.
Changes in v2:
- Move deallocate_hiq_sdma_mqd() up. Thanks, Felix!
- Add a Fixes tag.
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d7a2e7178ea9..8af0929ca40a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2919,6 +2919,14 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
+				    struct kfd_mem_obj *mqd)
+{
+	WARN(!mqd, "No hiq sdma mqd trunk to free");
+
+	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
+}
+
 struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 {
 	struct device_queue_manager *dqm;
@@ -3042,19 +3050,14 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		return dqm;
 	}
 
+	if (!dev->kfd->shared_resources.enable_mes)
+		deallocate_hiq_sdma_mqd(dev, &dqm->hiq_sdma_mqd);
+
 out_free:
 	kfree(dqm);
 	return NULL;
 }
 
-static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
-				    struct kfd_mem_obj *mqd)
-{
-	WARN(!mqd, "No hiq sdma mqd trunk to free");
-
-	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
-}
-
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
 {
 	dqm->ops.stop(dqm);
-- 
2.25.1


