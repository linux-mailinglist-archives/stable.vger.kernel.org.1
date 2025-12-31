Return-Path: <stable+bounces-204321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4DBCEB4FB
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 06:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67D2E301C3C2
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 05:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8209B30FF06;
	Wed, 31 Dec 2025 05:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="VZUpGGyF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8FC2882B2
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 05:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767160278; cv=none; b=LVJRUdMK1peE4ps0ZRDv/Gx7S/f4ta5rZpA8rxAmMq38Bv6fQ6KBUxR8D7L4mCswNJSfqU6ilGbiqbk8aRht0iTlMTlw2eBeoz6fFifuAmgzifkPiZcYrKm6pZwK2TVFIxyabOcbxAfnoQ+sx9gKqJJ5pPfekcRoxjneWwHviNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767160278; c=relaxed/simple;
	bh=N055S3vS4koRLN1D1ZMjGSavsqXYIXx7Nfs7oOR+ZO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ImdA7AbPbOWLijOqldpL5CR3RqLL8VlkeWiZC0JfSziFqrT54xzGqmWqvO0LiPaLykfpN5sN5V/ZwN8gXPB7d6MOCR5T8zZfpeYgvdM7L2eKmDau4YdAEBEBLj51DNQK8bc5MgZ6cVbQDidjkAgGLEgDkNXl/n1T/Pq+xvP4KYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=VZUpGGyF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29f08b909aeso23244245ad.2
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 21:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1767160276; x=1767765076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ox1sScn4c4CV8wT4gbWelZga9X+ZR/e5mSgfUmub5LY=;
        b=VZUpGGyFEFVn7tPMRjIHMsKCSL7GTP9Bwic0164Xzj4Z0HqUPI8hgbiQKnAERnP431
         WDTf+levYltJ7Y+qwMhoIECIGvyTk6E+Cc8NLxBz6Vg6qDwCYp/QvI+oM2A3djXdeHw8
         Z6xiuE+hMMVhay8tBm5c1W20UrZIa+w+8h0AWXcp8txQ8AoVRja4nBSLfOpg2I5DNpW9
         iHV3tp/hZu0glnd4fUde29Y6x18ODGezftuwmXw2dWngWsp99NGaK8JVRkC15fZOjz74
         ygR0Oxrxvt8ncls1Fy6VhiZpNXU9zkwB0z9cX0maznx5J9gdD5BVzLpz0m1J5Tet8eL8
         IpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767160276; x=1767765076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ox1sScn4c4CV8wT4gbWelZga9X+ZR/e5mSgfUmub5LY=;
        b=U8f9FVglVZirNBLkOMj2etJbs7kqqOK3Vwna1h2N5fg0pbc+a4QmHBt0A9fGfv4UTD
         Gqd0aihk/ecvwYtwvAPAVXS+pvyfHZVEcZ/flnmUPyjo/MJjdGZeQ7ViLq12nv8nofZU
         CACuLtrmogohXXUetm0JxKSVA6DFAnxBkrvlF8DOORhTz2ybuVzTlXzUI8agTo7KcA4C
         q+mrVrxwmuRNm5CarSv+lD/26NbpC6j5NHSa7kRlfTLoPdLqorjZk62gQ+ZM2eecW3NC
         n9y2tjlI3aSBZ1PHWlnxaFmU02h8JuDnniViw5UmZFrtQ2LGOdyHFCxJ3szUysxUFzbO
         6Bfg==
X-Forwarded-Encrypted: i=1; AJvYcCWvPq4RsleAuRSyH0m62kNyBYUdpLDIVAZ21YpJJTweV/pju2h1wdjSb3RXv6DhCIQFVyAC76g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNPpkgwldJ2ohgVyIi0CDoNCLRpEdlwVxXv3mw/fn2VumGCbnS
	sUIjN5fAOkYz3DFdtMUEjEZP/gkSpMZc/LIFji07cxwQxTxpfMLDPg2iLlM5ErhmRwQ=
X-Gm-Gg: AY/fxX75XmBzZ8AYnvG12fbtb8jeiZeHezIJWJNbGVZOArFT1j2Tf2PC9omL8CfascC
	f0cBd/Quqc4AToGvzlYBc6aOdCSiRzOutzD53Ksdu5ThaXKJk8JqjDVKOk6OBezyjBIpF3nnusg
	LqIqAlWQH+xqkO8rYW38rj/Qf6CTV0idmr2h6cknB2aEVSwIcySh7qh76seHa8nM/Ddp/9wL50O
	PFmKGB0Lw4YpaldBi6F7gpdyj13a79HUUgRmLQBBO5Z8J3dbR3oa7wUqWxn0JxjIBC0CyOoi02L
	AXtPL5d3eqrfo1BMizW58AiYlBeexFs0mm5x6RQGIXxtBAcB46igA+t0mrICFFftOjbKrQAqPxS
	Yd3Ft4s+9DXDEAGKMXcmUJJh9tYW+VM8sii03jGq80W045kZ9nAMDJQAK5Pdb/bupvI9+4c+ikq
	XqbCm4cWeL
X-Google-Smtp-Source: AGHT+IH+SJCLRGbFnHD/9ov5lxSc2acUFHvTWvu9Zh+w1Qf+XfCP+KEdc52eyzfiW6cDM59bSGcPFA==
X-Received: by 2002:a17:902:c405:b0:297:df7c:ed32 with SMTP id d9443c01a7336-2a2f1f7c269mr251956935ad.0.1767160275921;
        Tue, 30 Dec 2025 21:51:15 -0800 (PST)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2a2f3c6b7b0sm318073125ad.16.2025.12.30.21.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 21:51:15 -0800 (PST)
From: Shenghao Yang <me@shenghaoyang.info>
To: Ruben Wauters <rubenru09@aol.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shenghao Yang <me@shenghaoyang.info>,
	stable@vger.kernel.org
Subject: [PATCH] drm/gud: fix NULL fb and crtc dereferences on USB disconnect
Date: Wed, 31 Dec 2025 13:50:26 +0800
Message-ID: <20251231055039.44266-1-me@shenghaoyang.info>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On disconnect drm_atomic_helper_disable_all() is called which
sets both the fb and crtc for a plane to NULL before invoking a commit.

This causes a kernel oops on every display disconnect.

Add guards for those dereferences.

Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
---
 drivers/gpu/drm/gud/gud_pipe.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 76d77a736d84..4b77be94348d 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -457,27 +457,20 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_crtc *crtc = new_plane_state->crtc;
-	struct drm_crtc_state *crtc_state;
+	struct drm_crtc_state *crtc_state = NULL;
 	const struct drm_display_mode *mode;
 	struct drm_framebuffer *old_fb = old_plane_state->fb;
 	struct drm_connector_state *connector_state = NULL;
 	struct drm_framebuffer *fb = new_plane_state->fb;
-	const struct drm_format_info *format = fb->format;
+	const struct drm_format_info *format;
 	struct drm_connector *connector;
 	unsigned int i, num_properties;
 	struct gud_state_req *req;
 	int idx, ret;
 	size_t len;
 
-	if (drm_WARN_ON_ONCE(plane->dev, !fb))
-		return -EINVAL;
-
-	if (drm_WARN_ON_ONCE(plane->dev, !crtc))
-		return -EINVAL;
-
-	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
-
-	mode = &crtc_state->mode;
+	if (crtc)
+		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 
 	ret = drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
 						  DRM_PLANE_NO_SCALING,
@@ -492,6 +485,9 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 	if (old_plane_state->rotation != new_plane_state->rotation)
 		crtc_state->mode_changed = true;
 
+	mode = &crtc_state->mode;
+	format = fb->format;
+
 	if (old_fb && old_fb->format != format)
 		crtc_state->mode_changed = true;
 
@@ -598,7 +594,7 @@ void gud_plane_atomic_update(struct drm_plane *plane,
 	struct drm_atomic_helper_damage_iter iter;
 	int ret, idx;
 
-	if (crtc->state->mode_changed || !crtc->state->enable) {
+	if (!crtc || crtc->state->mode_changed || !crtc->state->enable) {
 		cancel_work_sync(&gdrm->work);
 		mutex_lock(&gdrm->damage_lock);
 		if (gdrm->fb) {
-- 
2.52.0


