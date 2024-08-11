Return-Path: <stable+bounces-66345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADC094DFE7
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 05:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF095B211A8
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 03:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A5CEEDD;
	Sun, 11 Aug 2024 03:54:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFFF7F6;
	Sun, 11 Aug 2024 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723348478; cv=none; b=FzGqa7XMR4QLL6wGNselLUMIRQANwE6X+6NkgFXDIteDMb8G45S4m/BBuNNGpgKAruLclXWobMF6ceypdUAuHUZ923g52IinMrd6fYBGv71f727dU5Bv7bXxWnr+gLS7CJhr0b48NuY6sYs1upAUmF5lew+PGPcvKE79rt2R49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723348478; c=relaxed/simple;
	bh=L6008oDfcpGOdp3sZj7mO4v81wzU3PhcgEhuJkxXEyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aiHfAY9cZfB1pdad6oL7/yYG8NemFRi9RifFZqtg3nOIlNLYMmKHoPMSiEzZTNQN4inbtSDQ09qHdfijfiPt6do7+qjpagtAa0spbg8qhXIHNZ2er/ZkAtCpAwaTWtfkmVBUszVYlyBO4rPwL5Yb4ZsjUhmOSfFgjcD+C6SiREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAB3X8DlNbhmsMVFBQ--.9898S2;
	Sun, 11 Aug 2024 11:54:22 +0800 (CST)
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
Date: Sun, 11 Aug 2024 11:54:12 +0800
Message-Id: <20240811035412.3483463-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3X8DlNbhmsMVFBQ--.9898S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFykCryUWr4DuFyDCF1ftFb_yoW8GFWkpF
	srG34YyFW5JFZruF18Ja4avF15G3W7JF1xuw10van3C3ZayryUtryrXryYgryfAFW3Kr12
	qwnFvFy7WF12krJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAxhLUUUUU=
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


