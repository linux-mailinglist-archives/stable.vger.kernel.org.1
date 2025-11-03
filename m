Return-Path: <stable+bounces-192201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D75C2BD78
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 13:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CB604E8FB4
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7A2DF150;
	Mon,  3 Nov 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUnAt2vc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F512C325F
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174050; cv=none; b=kSRb5HJOn7n45JVjIrOwjTX8SUctHI0SElLSeknWljuB9PWuNzNRCO1unw2mpATcEbIvmSh4fQztrG8sWmnAHZgir6/vKUMV6UbjvVpOqGzc0eTymSud0RfyLXZED85eZyCK4b00OK17IHJz4rxB3L/orsByx2EQLxajKDx6i1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174050; c=relaxed/simple;
	bh=6mGgl52IcVIKbbdqOyq7czHoo45cmyuoonWeI0P8oFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bey2AqQknN3jDYJ7l3/2SI4bceme/9GzSfkSuo0dSBlEYIeFkP9rdhnAtvzPWFc08LK6Gi5p8Ey5jhUW1lsTuIAbitDo7S02BWnVFq52vgigo0MUpsTHi8x6U7KvCFBDVxT44vtLzlwHWSwCybgrSlF6aSpesA6JafbNR+ZOFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUnAt2vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13327C4CEFD;
	Mon,  3 Nov 2025 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174050;
	bh=6mGgl52IcVIKbbdqOyq7czHoo45cmyuoonWeI0P8oFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pUnAt2vcxyOV29MxztHKVtc42LmUQPdjqF86aVPG81MeWF2mzSEfENqOZnZEALSAZ
	 iXRH+Ugoj9BTXA+o2wOq51/wR9Vbj4MnboCj2hicN1zZP+3A3nW3JMhtpmm57qxAo9
	 LmNC1miL78ApY+VmyoAU2JzD1fBhDwQxAWeqRA75rBXE4+BNgl7E/z44ehDMCfVVi/
	 go1WZAoyxwgiuZpzDcqqwQadWzr/8HOdFruQ+8xskJj2+jiDWb/kPabRci4Epad0od
	 kFuoJwy09UwUR+fF6YD8f5hMHsmfOsd3E/4ucmxY4FcvRXgQXGS4J6E6ABwmE+fzhu
	 IGtfU+zUPbrgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/sysfb: Do not dereference NULL pointer in plane reset
Date: Mon,  3 Nov 2025 07:47:27 -0500
Message-ID: <20251103124727.4003872-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110310-heavily-unsavory-7385@gregkh>
References: <2025110310-heavily-unsavory-7385@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 14e02ed3876f4ab0ed6d3f41972175f8b8df3d70 ]

The plane state in __drm_gem_reset_shadow_plane() can be NULL. Do not
deref that pointer, but forward NULL to the other plane-reset helpers.
Clears plane->state to NULL.

v2:
- fix typo in commit description (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: b71565022031 ("drm/gem: Export implementation of shadow-plane helpers")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/dri-devel/aPIDAsHIUHp_qSW4@stanley.mountain/
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.15+
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patch.msgid.link/20251017091407.58488-1-tzimmermann@suse.de
[ removed drm_format_conv_state_init() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_gem_atomic_helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index 5d4b9cd077f7a..e0ea3c661cb77 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -301,7 +301,11 @@ EXPORT_SYMBOL(drm_gem_destroy_shadow_plane_state);
 void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
 				  struct drm_shadow_plane_state *shadow_plane_state)
 {
-	__drm_atomic_helper_plane_reset(plane, &shadow_plane_state->base);
+	if (shadow_plane_state) {
+		__drm_atomic_helper_plane_reset(plane, &shadow_plane_state->base);
+	} else {
+		__drm_atomic_helper_plane_reset(plane, NULL);
+	}
 }
 EXPORT_SYMBOL(__drm_gem_reset_shadow_plane);
 
-- 
2.51.0


