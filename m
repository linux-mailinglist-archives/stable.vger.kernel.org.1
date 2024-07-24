Return-Path: <stable+bounces-61262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D6F93AF3A
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 11:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C62A1F21414
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 09:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0457B15534D;
	Wed, 24 Jul 2024 09:45:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EAB153BF0;
	Wed, 24 Jul 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814337; cv=none; b=nEvFJusZActT6lsXqcN3zWyd7VqYDoTU4Z4lgC9N2DM8/0NKLEyB23bLRkoGZp/bfxTrE/HTlGuxgCCHleNFSC1brUB6ceqfkQZFTTDV+Egt4FkhcCqHwy77q8w6Qv1vhHFF0zzUrrq1AoDMjku04+PZf5IHowIF3UP2XbtiPBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814337; c=relaxed/simple;
	bh=WMYzfkLIBlWOfPjI/UlFiYOKuB4gfY5GcCGozVoNhqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t/hBD8H2rtp5zdIXLuZaXDGB35PSm74Eq5hZDnzm2v3TxJ2ZJGgDrXUUndzYa17zQW/oeQ0NlI+X+/u7POB7rd9Kw68fD/fa2qbvNncHe3C7cjIrj3nf/j0fr/9GmhEGVFv573XP26gydNWsbOOFy/poecRVsFzcN62dUJ2EU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADHrTgizaBmZ1u6AA--.42715S2;
	Wed, 24 Jul 2024 17:45:13 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sam@ravnborg.org,
	noralf@tronnes.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/client: fix null pointer dereference in drm_client_modeset_probe
Date: Wed, 24 Jul 2024 17:45:05 +0800
Message-Id: <20240724094505.1514854-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHrTgizaBmZ1u6AA--.42715S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw45GFyUJr18CFWDKF18AFb_yoW8Jw48pr
	43Gr90yF4YvF9FkFs2va97CFy7Z3W3JF48GF17Aan3u3Z0qry2yFyYvF15WFy7Gry3JF1U
	tFnIyFW2qF18CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In drm_client_modeset_probe(), the return value of drm_mode_duplicate() is
assigned to modeset->mode, which will lead to a possible NULL pointer
dereference on failure of drm_mode_duplicate(). Add a check to avoid npd.

Cc: stable@vger.kernel.org
Fixes: cf13909aee05 ("drm/fb-helper: Move out modeset config code")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v3:
- modified patch as suggestions, returned error directly when failing to 
get modeset->mode.
Changes in v2:
- added the recipient's email address, due to the prolonged absence of a 
response from the recipients.
- added Cc stable.
---
 drivers/gpu/drm/drm_client_modeset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 31af5cf37a09..750b8dce0f90 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -880,6 +880,9 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 
 			kfree(modeset->mode);
 			modeset->mode = drm_mode_duplicate(dev, mode);
+			if (!modeset->mode)
+				return 0;
+
 			drm_connector_get(connector);
 			modeset->connectors[modeset->num_connectors++] = connector;
 			modeset->x = offset->x;
-- 
2.25.1


