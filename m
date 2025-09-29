Return-Path: <stable+bounces-181949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAF4BA9E0A
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 17:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A76E173C96
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 15:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1C73074B6;
	Mon, 29 Sep 2025 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai5JSo7z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D9530B520
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161257; cv=none; b=KTQ3Qhcok2fmVS4B2n2w+7gv1bBfabt0knVhI5h0Ht/fyuHbZk9AnQAe9NrzDNdLwlrnDI82Li6I/WMWEIpnAcJvpiWMfEClmTMJ4tveu8iISR9Jyw7FVZoTARsZr5Cf3DhwB04p10DzwDc0KI23m15d+rHvbl1wlo4YrBN6VCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161257; c=relaxed/simple;
	bh=1sgpF2bI8rK8MTu4hZLFvvYX/glp3S5AUL3GAJHaBm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjECduxKFEbFAqtBlaaiT0NNVq/lsI5ETgUYSlSwzzSudrGcGKVUqqruadHPTVuJrZFE97vAujWPmPfu0Mx9lhRwUCccSi0lxOEcqXJGYSAEVSdmUy7a9kaRgHpLU58bUX+k4qctVvzjtEcGyJA4iKFFRuMB6QxdhXm7eLy2HJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ai5JSo7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E3FC4CEF4;
	Mon, 29 Sep 2025 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759161256;
	bh=1sgpF2bI8rK8MTu4hZLFvvYX/glp3S5AUL3GAJHaBm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ai5JSo7zUk3to/LzSUvUGHBklP7YShOsCjmo/QW+YodDNDC2ysAQtarB5xoO4TN0u
	 GyKFSCRZsJjNnH/LXWNGx/QlL0nTzxNyz8DMeCnwiddeF6ToRh7JjLGg+j8ZJJh1Lu
	 I3ajADpO5kp2UXM1NgPlwH4sh7xnAyWZjeu61ibBFNlFA0GuOgj/qRwD9B7jR/8hRL
	 xrBd5qd4ROh5mIFCgrVwhs00YQjGvV/Wbe8bmc29n0V/Z+AQslOJViYVenpzlskGvc
	 XnrjsE5YouCabI6wO229S+rJrUZmLJtSxF8I0JXgTWCYg1JQYoKhdF2a57/zfxHJnN
	 5ROSEnnlQ4WpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nirmoy Das <nirmoyd@nvidia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>,
	Dave Airlie <airlied@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	dri-devel@lists.freedesktop.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/ast: Use msleep instead of mdelay for edid read
Date: Mon, 29 Sep 2025 11:54:09 -0400
Message-ID: <20250929155412.141429-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092921-consensus-mystified-6396@gregkh>
References: <2025092921-consensus-mystified-6396@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nirmoy Das <nirmoyd@nvidia.com>

[ Upstream commit c7c31f8dc54aa3c9b2c994b5f1ff7e740a654e97 ]

The busy-waiting in `mdelay()` can cause CPU stalls and kernel timeouts
during boot.

Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Carol L Soto csoto@nvidia.com<mailto:csoto@nvidia.com>
Fixes: 594e9c04b586 ("drm/ast: Create the driver for ASPEED proprietory Display-Port")
Cc: KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.19+
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/r/20250917194346.2905522-1-nirmoyd@nvidia.com
[ Applied change to ast_astdp_read_edid() instead of ast_astdp_read_edid_block() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ast/ast_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index a4a23b9623ad3..7d2fb34c72b75 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -51,7 +51,7 @@ int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata)
 			 *	  of right-click of mouse.
 			 * 2. The Delays are often longer a lot when system resume from S3/S4.
 			 */
-			mdelay(j+1);
+			msleep(j + 1);
 
 			if (!(ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1,
 							ASTDP_MCU_FW_EXECUTING) &&
-- 
2.51.0


