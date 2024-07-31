Return-Path: <stable+bounces-64875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D67943B5D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0011C20D7A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF03916FF3B;
	Thu,  1 Aug 2024 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4qDBRG4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C79C16F8F3;
	Thu,  1 Aug 2024 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471265; cv=none; b=Sg4oYWAwn0ERrY2G5iD0/0vB71FMzDRkRWEJlnkxFzAc4B78TugL9efJJEh8a57Vb9MksBoVo93Zru/v2cb3gTr8HhYoY3JSNYaiF+Ra3iwkOwUGx08KJQsFW7S9CRb+rD6mS0PSaJMVO+IUUzzW4fkWtcV1z4XxzNCI/IThmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471265; c=relaxed/simple;
	bh=97K/HdG3hH8WQviln1ac0JDeb9uAWkepWOzNcKijcpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TT+YpTZPv8Jiqan7haggWPFeuD3DZPwHvsEED0ThJuxYgzMkgVksFEZjU6I9KYPKdUeH6JIC/iqm6Bs93U2exSgOELE4fbT/+gGMHjNLfbLrtpN832cr3FC1PmKqdVSFlffy7h+V6iQA7BW1V826Mh6t3rw+zaU4Ja4qQrF4WnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4qDBRG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97DDC4AF0C;
	Thu,  1 Aug 2024 00:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471265;
	bh=97K/HdG3hH8WQviln1ac0JDeb9uAWkepWOzNcKijcpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W4qDBRG4j6cIy+TwjlVqz8h4g2jaZyUb1RKTCVBnZFgYHpM83Z9lOXLlRbnmcP2l0
	 W+9AKc8n6w1yV42K7OFR7OzUgnJQD2oU39u+3n3gOsXxvD+FvzNZpY47Ek8psDw7vz
	 3dStHy8w2XEkErrmJqkWZmsL0J0H64drgAtO6LmAwVKwCp0WeK3sREs1DMYDDJwguv
	 vgrJUhAghuiGW39PrN/B2xWO8418M6hBTwEUzxMcn/1TXfxNupgHsRbfVXw5OZ7Vbm
	 nPNes4Knp889iC5tNIQCjWvCJaoe+qLSGQtF/1mh1ZBBhtPAIImowFhg+2PvEhtxSW
	 e61aWaDhVOCbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Auld <matthew.auld@intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 050/121] drm/xe/mmio: move mmio_fini over to devm
Date: Wed, 31 Jul 2024 19:59:48 -0400
Message-ID: <20240801000834.3930818-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Matthew Auld <matthew.auld@intel.com>

[ Upstream commit a0b834c8957a7d2848face008a12382a0ad11ffc ]

Not valid to touch mmio once the device is removed, so make sure we
unmap on removal and not just when driver instance goes away. Also set
the mmio pointers to NULL to hopefully catch such issues more easily.

Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240522102143.128069-32-matthew.auld@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_mmio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
index 334637511e750..2ebb2f0d6874e 100644
--- a/drivers/gpu/drm/xe/xe_mmio.c
+++ b/drivers/gpu/drm/xe/xe_mmio.c
@@ -386,13 +386,16 @@ void xe_mmio_probe_tiles(struct xe_device *xe)
 	}
 }
 
-static void mmio_fini(struct drm_device *drm, void *arg)
+static void mmio_fini(void *arg)
 {
 	struct xe_device *xe = arg;
 
 	pci_iounmap(to_pci_dev(xe->drm.dev), xe->mmio.regs);
 	if (xe->mem.vram.mapping)
 		iounmap(xe->mem.vram.mapping);
+
+	xe->mem.vram.mapping = NULL;
+	xe->mmio.regs = NULL;
 }
 
 int xe_mmio_init(struct xe_device *xe)
@@ -417,7 +420,7 @@ int xe_mmio_init(struct xe_device *xe)
 	root_tile->mmio.size = SZ_16M;
 	root_tile->mmio.regs = xe->mmio.regs;
 
-	return drmm_add_action_or_reset(&xe->drm, mmio_fini, xe);
+	return devm_add_action_or_reset(xe->drm.dev, mmio_fini, xe);
 }
 
 u8 xe_mmio_read8(struct xe_gt *gt, struct xe_reg reg)
-- 
2.43.0


