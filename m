Return-Path: <stable+bounces-58730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E9C92B860
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9004E1F21742
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4B6152787;
	Tue,  9 Jul 2024 11:33:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9855E4C;
	Tue,  9 Jul 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524822; cv=none; b=Khzwz+Eg9u2hKYUGHuxrtnUWQXWn4haF0ZZtt3NFXdh2mN6zdOcw7mvw6HhluDxdJM5K4uPsIvgbQYvTJwagbxDDJdd/4U3Fhzfykwda0gMr+Nk083nPsuyBrPSntFLMeZzWIhHOI1zr9RhqagPG1PiprdGTtvoTrDMD2TVUdy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524822; c=relaxed/simple;
	bh=+qzS59c3fdH5vXtrObTlu3zWUbvBHhppuPkCToi9+CY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EhVc2nAFon7cI1OKLzA/0/fslq+P8Y4rst1gq3qaTbpzPbf2up4XMOHVaSwKVIVa02grJ7S63NU7CprnBF/LTWESvxWDq7lXtlYuZ5PYuLMkYhCFIDYrWNlFYv+WSIz+v1OdzFMJSndl19NyOBRPxySzBvgdIBsoKnz2pyvSISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowABXeiz5H41mOeXVFA--.41574S2;
	Tue, 09 Jul 2024 19:33:23 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: patrik.r.jakobsson@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	daniel.vetter@ffwll.ch,
	alan@linux.intel.com,
	airlied@redhat.com,
	akpm@linux-foundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4] drm/gma500: fix null pointer dereference in cdv_intel_lvds_get_modes
Date: Tue,  9 Jul 2024 19:33:11 +0800
Message-Id: <20240709113311.37168-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXeiz5H41mOeXVFA--.41574S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1rJF1DtF1UKw43Xr1rCrg_yoW8Xr18pr
	W7GFyYyr4FqF9FgFW8CF18WFW5G3W3J3W8KrykXws3u3Z0yryUXr95u3y3Xry3AFZxGrZY
	yrnxtFW3GayUAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In cdv_intel_lvds_get_modes(), the return value of drm_mode_duplicate()
is assigned to mode, which will lead to a NULL pointer dereference on
failure of drm_mode_duplicate(). Add a check to avoid npd.

Cc: stable@vger.kernel.org
Fixes: 6a227d5fd6c4 ("gma500: Add support for Cedarview")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v4:
- revised the recipient email list, apologize for the inadvertent mistake.
Changes in v3:
- added the recipient's email address, due to the prolonged absence of a 
response from the recipients.
Changes in v2:
- modified the patch according to suggestions from other patchs;
- added Fixes line;
- added Cc stable;
- Link: https://lore.kernel.org/lkml/20240622072514.1867582-1-make24@iscas.ac.cn/T/
---
 drivers/gpu/drm/gma500/cdv_intel_lvds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
index f08a6803dc18..3adc2c9ab72d 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -311,6 +311,9 @@ static int cdv_intel_lvds_get_modes(struct drm_connector *connector)
 	if (mode_dev->panel_fixed_mode != NULL) {
 		struct drm_display_mode *mode =
 		    drm_mode_duplicate(dev, mode_dev->panel_fixed_mode);
+		if (!mode)
+			return 0;
+
 		drm_mode_probed_add(connector, mode);
 		return 1;
 	}
-- 
2.25.1


