Return-Path: <stable+bounces-128012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39AFA7ADEC
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D34E7A28EB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B786B1FAC33;
	Thu,  3 Apr 2025 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aabU8eKX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A31FA14B;
	Thu,  3 Apr 2025 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707756; cv=none; b=kBKOxHTbya1hMFz2G+NW3EwemVY08ZGSUYgbtzkhH1PukaJ6KwtNXrG77R9l46kKhcQiSbuDtGa5g7LULS3xIPe+2wxT1laQiZ0G9XEEOV7lBZ3owYImKfPkk8fL72gdefGRyMMzVcCVctV8Y5WsGDpYWGARuMg5olffKh90UbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707756; c=relaxed/simple;
	bh=RsSQvyW3QrtSAJP9FCcNN6N/x+TyIyFZQExTiaNbHWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=knazLaDeHVT+fQ/xLkEt7J/eegwgCupWSc2HpSYzXIXVVtnuWX2V3wlbcI4MiXWXFc9ynXcadkwxzLtAVUNNDHOIhVzV5PSaB3l48G5PwJyANUhQStlfeR+/akNFr84LaVLe1tKH82f0Hp6uKWBrBisj6UOhNknsT+/BXwrWg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aabU8eKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1B9C4CEE3;
	Thu,  3 Apr 2025 19:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707756;
	bh=RsSQvyW3QrtSAJP9FCcNN6N/x+TyIyFZQExTiaNbHWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aabU8eKXa4/EKYkYOBXlQP1pqE86+RQXx3U+ec8Xujoj1A2/0/B7kEmkO7eagjvZf
	 1IrptqutgJqtzH8HpGzPlmZr0QgHWcCLkZ4nN+JE6/hUTxsZ/Jhg9t/9HK9tEugCmY
	 YHWLgSTvEsfKa4kitl81dibDsZE28Xe21mS2URUOrQ0qYdQbnCOEiznMzB7uJ/ieOR
	 DH4+FNwAyZWAXS40okIHgN4WotkKDXBSMRD9Rz2U0wACXcx43yYfHEiUebZ5t0aqXL
	 rSvHL+P1qMLN+uXYjAIC/4om+nkKzNdXaAuQh6xG2q+9L5qbBG9q1oiIeWHmTfHVjI
	 FuxjdT6zc81Dg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 13/37] drm/debugfs: fix printk format for bridge index
Date: Thu,  3 Apr 2025 15:14:49 -0400
Message-Id: <20250403191513.2680235-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

[ Upstream commit 72443c730b7a7b5670a921ea928e17b9b99bd934 ]

idx is an unsigned int, use %u for printk-style strings.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20250214-drm-assorted-cleanups-v7-1-88ca5827d7af@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 536409a35df40..6b2178864c7ee 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -748,7 +748,7 @@ static int bridges_show(struct seq_file *m, void *data)
 	unsigned int idx = 0;
 
 	drm_for_each_bridge_in_chain(encoder, bridge) {
-		drm_printf(&p, "bridge[%d]: %ps\n", idx++, bridge->funcs);
+		drm_printf(&p, "bridge[%u]: %ps\n", idx++, bridge->funcs);
 		drm_printf(&p, "\ttype: [%d] %s\n",
 			   bridge->type,
 			   drm_get_connector_type_name(bridge->type));
-- 
2.39.5


