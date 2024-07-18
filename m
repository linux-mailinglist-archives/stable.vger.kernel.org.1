Return-Path: <stable+bounces-60560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B751B934EF0
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 16:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52B01C2188E
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115B1140E37;
	Thu, 18 Jul 2024 14:12:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7284DF5;
	Thu, 18 Jul 2024 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311923; cv=none; b=Mt/9pI0LJNbl9QOPMyK8hZsaTCrDtR8/JbhzbQG5uFXW8kFqtphJ6Bsx0Fz+vuYxxl4HPb0ben3slTj6la5SzlDueBs6Uy+zJkjj9Vj5AFsvGsuz4JLzeXBl6N6WMk6MUjZ0zn1askV1yjHzdBp9/HnhkhFBJ7TGVcaDVyYyFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311923; c=relaxed/simple;
	bh=doTpESTqeubI6mB28UxNmhl+1oSmC1LfNMwJTifaYZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FllIuN88LQkcnrxBpcUcpFLR4tVZ20ViDR3QjoTjtc719YPXQE+2Bk33En2mYwRu/bCFaxeO4A9fiYl3uTDVVhS4r4BlGSECDz0Bax9T4WienxiOamx5Vo+UPixLSxuC3id6KwGxt6OCJDQZgG6LelVPQJGuwNWyl84+jkDPLtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowABHTMieIplmbo8TBA--.5572S2;
	Thu, 18 Jul 2024 22:11:52 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	srinivasan.shanmugam@amd.com,
	chenjiahao16@huawei.com,
	aurabindo.pillai@amd.com,
	make24@iscas.ac.cn,
	Jammy.Zhou@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/amdgpu: fix a possible null pointer dereference
Date: Thu, 18 Jul 2024 22:11:41 +0800
Message-Id: <20240718141141.872558-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABHTMieIplmbo8TBA--.5572S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4UAFy5KF45Aw4rCFWDXFb_yoWkAwc_CF
	WUZFZxXw43AFnYyr47Zw4SvwnIva4UAr4ktr1Sqa9av34xX3W7Jry5JF9YqF1fuF93CFnF
	q34Ygw1rA3ZrCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In amdgpu_connector_add_common_modes(), the return value of drm_cvt_mode()
is assigned to mode, which will lead to a NULL pointer dereference on
failure of drm_cvt_mode(). Add a check to avoid npd.

Cc: stable@vger.kernel.org
Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v3:
- added Cc stable line.
Changes in v2:
- modified the patch according to suggestions;
- added Fixes line.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 9caba10315a8..25b51b600f6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -458,6 +458,9 @@ static void amdgpu_connector_add_common_modes(struct drm_encoder *encoder,
 			continue;
 
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
+		if (!mode)
+			return;
+
 		drm_mode_probed_add(connector, mode);
 	}
 }
-- 
2.25.1


