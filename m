Return-Path: <stable+bounces-78159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B53B988B77
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 22:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63EC1B24E34
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 20:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B265C1C175B;
	Fri, 27 Sep 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0Um2wev"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30EF1C1ADA
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469995; cv=none; b=chR8rNzPahT3GrVMK5vIrXwdHxYXWRYs9YIALneadFc0slCeOBZ9d8YLn/w5Y0UdKBO+NFQhW2l8K49zC+gVs8UB0jdxWuFsWg6AggdljNrvfVBLGp/oniQM00pBwvSkLUQ8pdcs1kqdbz1bEZvHnZcxczSxFV9HLXR+6sisxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469995; c=relaxed/simple;
	bh=X0Tu1fbU3iFzETxLdIRaXrvnVItQS17Cn5VyrEtUYCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTIsymHanJAbIVaV2ea8jCmFWy5CiaZxZB6JjB6/lJPH5YmTTQYL6R7IK+euWv+3WoQreD0jCJpqVhS5c86xYbhwsg936P0ImR8EGwEwjwhZd0PghMJskaA2WESqfRM9rymi/cT24mmBmnNYLIj5pTHycR31dJt1vEEKcdWNvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0Um2wev; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727469992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UW32wAnMjxA4S/oz9w5qOVbyTn2kSOgb6EUyptzsUfM=;
	b=S0Um2wevOgp29MVB7IwDsMlOTYIo7a0OFRVKGutD3dPr+oxn6k5mxvaiTLJck9DtxguqX1
	Oo1nOGa17IAFnbIXHcBUxVYkYa5L5HLMf/UpfKDXmZxYDSDkMbc9JPvoL+y3jjeJobYef8
	gwF6iWehrdvNVgZOVUYSN2WF/N1EOMc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-KIOkFG8FM3Wgg1-uDgKCGg-1; Fri,
 27 Sep 2024 16:46:29 -0400
X-MC-Unique: KIOkFG8FM3Wgg1-uDgKCGg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06F9519103FE;
	Fri, 27 Sep 2024 20:46:28 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A19C219560A3;
	Fri, 27 Sep 2024 20:46:25 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sean Paul <seanpaul@chromium.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/atomic_helper: Add missing NULL check for drm_plane_helper_funcs.atomic_update
Date: Fri, 27 Sep 2024 16:46:16 -0400
Message-ID: <20240927204616.697467-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Something I discovered while writing rvkms since some versions of the
driver didn't have a filled out atomic_update function - we mention that
this callback is "optional", but we don't actually check whether it's NULL
or not before calling it. As a result, we'll segfault if it's not filled
in.

  rvkms rvkms.0: [drm:drm_atomic_helper_commit_modeset_disables] modeset on [ENCODER:36:Virtual-36]
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  PGD 0 P4D 0
  Oops: Oops: 0010 [#1] PREEMPT SMP NOPTI
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240813-1.fc40 08/13/2024
  RIP: 0010:0x0

So, let's fix that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: c2fcd274bce5 ("drm: Add atomic/plane helpers")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v3.19+
---
 drivers/gpu/drm/drm_atomic_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 43cdf39019a44..b3c507040c6d6 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2797,7 +2797,8 @@ void drm_atomic_helper_commit_planes(struct drm_device *dev,
 
 			funcs->atomic_disable(plane, old_state);
 		} else if (new_plane_state->crtc || disabling) {
-			funcs->atomic_update(plane, old_state);
+			if (funcs->atomic_update)
+				funcs->atomic_update(plane, old_state);
 
 			if (!disabling && funcs->atomic_enable) {
 				if (drm_atomic_plane_enabling(old_plane_state, new_plane_state))
@@ -2889,7 +2890,8 @@ drm_atomic_helper_commit_planes_on_crtc(struct drm_crtc_state *old_crtc_state)
 		if (disabling && plane_funcs->atomic_disable) {
 			plane_funcs->atomic_disable(plane, old_state);
 		} else if (new_plane_state->crtc || disabling) {
-			plane_funcs->atomic_update(plane, old_state);
+			if (plane_funcs->atomic_update)
+				plane_funcs->atomic_update(plane, old_state);
 
 			if (!disabling && plane_funcs->atomic_enable) {
 				if (drm_atomic_plane_enabling(old_plane_state, new_plane_state))

base-commit: 22512c3ee0f47faab5def71c4453638923c62522
-- 
2.46.1


