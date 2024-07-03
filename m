Return-Path: <stable+bounces-57644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B97925D5A
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777DB28AE9B
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6AB181B88;
	Wed,  3 Jul 2024 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c5Z7/Vp3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA918132E;
	Wed,  3 Jul 2024 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005502; cv=none; b=R9p8DSAdwdazcNt1EYKz2m9shin9b/5apjkrqa7E6it4B/ssP7CFuFtXatxpBtoWcqkh3MQsdCUPj+TIFdqCnOMIX/XcHl9aWvJXABqdMQi7Y7DRU0jEyxPj+cx9T7ZdXMY8ouvbtNHckHr6Xn5ZqtWUbFvrDj6Yv1joBhax8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005502; c=relaxed/simple;
	bh=nGGsFBHoJo+sW7HqGLdZMoHInnmMw8UUu5bDY5qpAQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/6CetiXmxMhu/JyIj/vA2sb2V5rvFAL2LJlVeq5VNIHARpCC4yHErNsdAiVMtH4rHwkZvRRR8XuRG/ckF0l0fXleBrHmBs4hJgdBtOl2HULqmLM99ivQhugv/mkQh4ry9ktopKAMnLIqmSh9AecqUiVsSM8F/NbxKnClMbqckI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c5Z7/Vp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B07C2BD10;
	Wed,  3 Jul 2024 11:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005502;
	bh=nGGsFBHoJo+sW7HqGLdZMoHInnmMw8UUu5bDY5qpAQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5Z7/Vp3xjSYas/QTStN61c/Aotv0VxIU9d9TQnawYqK9Aakm+059VfLDzXfa/Snh
	 W4LegbfitAuAVAROSdzjCM4vkz3rB/RBYiaMIQGHe+X8ayq57PxpSgyq6PM9Kz5kKC
	 nnYosu/GMs2JwuZU0MGCrzlHJ+/nTPUf8rh49FgI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adam Miotk <adam.miotk@arm.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 102/356] drm/bridge/panel: Fix runtime warning on panel bridge release
Date: Wed,  3 Jul 2024 12:37:18 +0200
Message-ID: <20240703102916.960621135@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Miotk <adam.miotk@arm.com>

[ Upstream commit ce62600c4dbee8d43b02277669dd91785a9b81d9 ]

Device managed panel bridge wrappers are created by calling to
drm_panel_bridge_add_typed() and registering a release handler for
clean-up when the device gets unbound.

Since the memory for this bridge is also managed and linked to the panel
device, the release function should not try to free that memory.
Moreover, the call to devm_kfree() inside drm_panel_bridge_remove() will
fail in this case and emit a warning because the panel bridge resource
is no longer on the device resources list (it has been removed from
there before the call to release handlers).

Fixes: 67022227ffb1 ("drm/bridge: Add a devm_ allocator for panel bridge.")
Signed-off-by: Adam Miotk <adam.miotk@arm.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240610102739.139852-1-adam.miotk@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/panel.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index b32295abd9e75..e67bcbef0e8ed 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -253,9 +253,12 @@ EXPORT_SYMBOL(drm_panel_bridge_remove);
 
 static void devm_drm_panel_bridge_release(struct device *dev, void *res)
 {
-	struct drm_bridge **bridge = res;
+	struct drm_bridge *bridge = *(struct drm_bridge **)res;
 
-	drm_panel_bridge_remove(*bridge);
+	if (!bridge)
+		return;
+
+	drm_bridge_remove(bridge);
 }
 
 /**
-- 
2.43.0




