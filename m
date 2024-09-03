Return-Path: <stable+bounces-72754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F769690F9
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 03:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED711F24C2D
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 01:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111F81C68B0;
	Tue,  3 Sep 2024 01:33:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41054185947;
	Tue,  3 Sep 2024 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327234; cv=none; b=rDbeX+gCcnhlYlQXSMGlNibO43WrUyxrQSxCdErKHotebR45ZnHOwX5kd7va+VUuRcvClQoBM2KkBLhdOXC3sstdDvGEKN48sbscsroWdq2k17qNPd+R6/x767N26iF7FvgCNgFY/9rudS5bXgPBgHZtrMrwT8TEpg3gfhhYAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327234; c=relaxed/simple;
	bh=L6008oDfcpGOdp3sZj7mO4v81wzU3PhcgEhuJkxXEyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ATKRoF9QpiuArZNrZ/t2Rz69hEhEj5bFq1ejIche3Tzmk8Bc3xgfUw7sRcCVfwVOsmpYq1xfW2uyi7xSE5OJHBvdrDN8wNkOdp8zL1JahXpTtETs7IG2HkT1qAL6Eg6bKSFCkAWXu9z5I8n3INpAErt9Tr/7or0uyWPGgsVvm+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAC3aKhhZ9ZmJHyyAA--.34444S2;
	Tue, 03 Sep 2024 09:33:33 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	make24@iscas.ac.cn,
	airlied@redhat.com,
	bskeggs@redhat.com,
	akpm@linux-foundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND] drm/nouveau: fix a possible null pointer dereference
Date: Tue,  3 Sep 2024 09:33:19 +0800
Message-Id: <20240903013319.4142585-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3aKhhZ9ZmJHyyAA--.34444S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFykCryUWr4DuFyDCF1ftFb_yoW8GFWkpF
	srG34YyFW5JFZruF18Ja4avF15G3W7JF1xuw10van3C3ZayryUtryrXryYgryfAFW3Kr12
	qwnFvFy7WF12krJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In ch7006_encoder_get_modes(), the return value of drm_mode_duplicate() is
used directly in drm_mode_probed_add(), which will lead to a NULL pointer
dereference on failure of drm_mode_duplicate(). Add a check to avoid npd.

Cc: stable@vger.kernel.org
Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/i2c/ch7006_drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/i2c/ch7006_drv.c
index 131512a5f3bd..48bf6e4e8bdb 100644
--- a/drivers/gpu/drm/i2c/ch7006_drv.c
+++ b/drivers/gpu/drm/i2c/ch7006_drv.c
@@ -229,6 +229,7 @@ static int ch7006_encoder_get_modes(struct drm_encoder *encoder,
 {
 	struct ch7006_priv *priv = to_ch7006_priv(encoder);
 	const struct ch7006_mode *mode;
+	struct drm_display_mode *encoder_mode = NULL;
 	int n = 0;
 
 	for (mode = ch7006_modes; mode->mode.clock; mode++) {
@@ -236,8 +237,11 @@ static int ch7006_encoder_get_modes(struct drm_encoder *encoder,
 		    ~mode->valid_norms & 1<<priv->norm)
 			continue;
 
-		drm_mode_probed_add(connector,
-				drm_mode_duplicate(encoder->dev, &mode->mode));
+		encoder_mode = drm_mode_duplicate(encoder->dev, &mode->mode);
+		if (!encoder_mode)
+			return 0;
+
+		drm_mode_probed_add(connector, encoder_mode);
 
 		n++;
 	}
-- 
2.25.1


