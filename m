Return-Path: <stable+bounces-92131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC99C3F76
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 14:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C006285195
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6E119DF98;
	Mon, 11 Nov 2024 13:22:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7E19DF60
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331335; cv=none; b=iLG5BdyYRT+uDQHa0W5xQCHW5fCWRl52+kNb3Kp4e/3A03sJMf+zmsYjIehWUIj3ByPG5ADfhGvMIYOy8kAz1DhBIGfJ/Rjpazto8HqOFtZgMhuko+nzHu/ktwG7upMIpAiVfhnAv6tSrDLX8BS1dinUBY3xDGPLNlWqcJYjcbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331335; c=relaxed/simple;
	bh=b9LP7sxnIeCp5pj3LeCOcIuAorNG655jYUdY07CtN1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQ/zNRsmlkI+p3R/iqgXGK/rnKh/JG7DtAECrn9FMLjm3pXzYtlw+EciRmJQOJcLTyhKcTDU8etctoI60xVUdFHhTQ2NaP0RX3YZKqS+hbk7jo/6xzV8CzZjKL4dcdORnedtkJRb8Vxl39+hnEww7qgb1wsIcTz6KThuq0DHcjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F336C4CED5;
	Mon, 11 Nov 2024 13:22:12 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm: Remove redundant statement in drm_crtc_helper_set_mode()
Date: Mon, 11 Nov 2024 21:21:49 +0800
Message-ID: <20241111132149.1113736-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit dbbfaf5f2641a ("drm: Remove bridge support from legacy helpers")
removes the drm_bridge_mode_fixup() call in drm_crtc_helper_set_mode(),
which makes the subsequent "encoder_funcs = encoder->helper_private" be
redundant, so remove it.

Cc: stable@vger.kernel.org
Fixes: dbbfaf5f2641a ("drm: Remove bridge support from legacy helpers")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/gpu/drm/drm_crtc_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 0955f1c385dd..39497493f74c 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -334,7 +334,6 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
 		if (!encoder_funcs)
 			continue;
 
-		encoder_funcs = encoder->helper_private;
 		if (encoder_funcs->mode_fixup) {
 			if (!(ret = encoder_funcs->mode_fixup(encoder, mode,
 							      adjusted_mode))) {
-- 
2.43.5


