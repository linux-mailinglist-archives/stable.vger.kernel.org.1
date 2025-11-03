Return-Path: <stable+bounces-192219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D895C2CB43
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 16:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8387A5634A2
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36A0314B74;
	Mon,  3 Nov 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5ZC/Kpf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CAF314B62
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182389; cv=none; b=qofzkIsYgSCL9wUyYMt8256S1l6Ox8yNMIGYoUUjgn4ql9kGVjWX3cKPFVbZPDQoru2yDyRtgPuNP6lHurYFQPJejItXiZS1kH/p4e8Q8MR1MoPSzaslPk7oAYta2bysytOxG0iueOeF8ukt/9a3lpMB6AqWqa7FOcK9opLazLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182389; c=relaxed/simple;
	bh=UUqsee495JRS8IW4t4pXuwYF8l1FpPDNqaSiU+RJxBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRAkjAvjdUdELEnOJtfEyex0ZEWImzJLudqqYdGbL+cetPFBatyirYBHapv8Km/hGoDR97T+S38veBznQQHbCHvsPCg0W+ycwnFkBvpQmLbJ9Ds4IvET2nCK0/vEc/5Q4621Pcp1jSsnzS+SdqFrH+cDhqztjNCyFxMBPgvMpHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5ZC/Kpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423ABC4CEE7;
	Mon,  3 Nov 2025 15:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762182389;
	bh=UUqsee495JRS8IW4t4pXuwYF8l1FpPDNqaSiU+RJxBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5ZC/KpfXe975m4ril33dGJtq7jBwI9v1fYYq6NIfC5c/k8vZNcqD65qF8/Q0Z6TB
	 i4EH8/iuBnVdDZmUwZZ2yJUVFVwLY6nJFhOaeH0PQli/ugugRJGRYcDR/cRbod1Lw/
	 pugxAR52uOCpRJdd3IiNha//D54giJtpQi/0v8Xj9kKdPhifNVe/03AqQG3NmP44ab
	 6TIEzYIUd0XTFBc5BIujouF6SwtYtFRSlJlcq5Mud6jMo/vZR13GgHY0NvWu9zHCrj
	 z66B9TOxQw8zUSewmAnQrWxybfizACJKgybxf07qZjOHRrR1BQLqHkftpa21hGqxzk
	 8bsoq3p2guDSg==
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
Subject: [PATCH 5.15.y] drm/sysfb: Do not dereference NULL pointer in plane reset
Date: Mon,  3 Nov 2025 10:06:26 -0500
Message-ID: <20251103150626.4044944-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110314-plank-canned-8743@gregkh>
References: <2025110314-plank-canned-8743@gregkh>
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
index e570398abd78e..8fcffe66e9e6b 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -282,7 +282,11 @@ EXPORT_SYMBOL(drm_gem_destroy_shadow_plane_state);
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


