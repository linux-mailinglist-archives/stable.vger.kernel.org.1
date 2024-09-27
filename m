Return-Path: <stable+bounces-78158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9416D988B57
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E9B0B2597B
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 20:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156EA1C2DBB;
	Fri, 27 Sep 2024 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4/PpyEy"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF11C2329
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469615; cv=none; b=cRF4d95L+aXD6Okeruw4IGsoZtfnQUz9ui4ymWvau6P395SK4JLLigeShiTZcQRLPaUbPdEq/5jJULyxpbkdpR9cGXajWcdpMEYxPEXgvI3qxJlUvp/HiexiDz42MljEYJ8oOtphEN1yu7cHatqbKIqYmNZfOh90zpimNQbBixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469615; c=relaxed/simple;
	bh=sqgzfonPHEkQo5wKiEeEuNAU2dhBeoHHLU5S4ow0UWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXHKVdVsZSgGTsoo+Am0MoX/cw3mRlY2I9GT63hbLBkSHoE7ttdG0XFJpRSmqAAEHxDcFtbwoZvNjDT2YDiAF9eDDVVYrlDNU/1TH0nEagv1ZS/qdsaUop+XjO7FJC7rHzGBhe3xEqAS0wUZ6iF9xoeNDZer5uJDn70N2EYDPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4/PpyEy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727469613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yRSI0RXAYJUqZWDNqYmjtNLAHKeav7N5jvF/NFDhhMM=;
	b=T4/PpyEyVLwm8uHmz1az/pMX4q2fEweBMrsG9t6P/5wGXxec5xm656oucPorwKQ+oITEyF
	T2ZehdYFqbzjSqptFqei8Tygr1kds1a4mDM3hKl5rUjqCrmQ2KB+vKyiHMRkSBy0Kw/A8i
	lpXedI3kDD2rIdo6pxolU4Cz5aZRcOw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-IDD_XYF6N_OKUqGWhIqPIw-1; Fri,
 27 Sep 2024 16:40:10 -0400
X-MC-Unique: IDD_XYF6N_OKUqGWhIqPIw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D83C1934C81;
	Fri, 27 Sep 2024 20:40:08 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C21219560A3;
	Fri, 27 Sep 2024 20:40:05 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: Stefan Agner <stefan@agner.ch>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/vblank: Require a driver register vblank support for 0 or all CRTCs
Date: Fri, 27 Sep 2024 16:39:47 -0400
Message-ID: <20240927203946.695934-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently, there's nothing actually stopping a driver from only registering
vblank support for some of it's CRTCs and not for others. As far as I can
tell, this isn't really defined behavior on the C side of things - as the
documentation explicitly mentions to not use drm_vblank_init() if you don't
have vblank support - since DRM then steps in and adds its own vblank
emulation implementation.

So, let's fix this edge case and check to make sure it's all or none.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 3ed4351a83ca ("drm: Extract drm_vblank.[hc]")
Cc: Stefan Agner <stefan@agner.ch>
Cc: Daniel Vetter <daniel.vetter@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.13+
---
 drivers/gpu/drm/drm_vblank.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 94e45ed6869d0..4d00937e8ca2e 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -525,9 +525,19 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
  */
 int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 {
+	struct drm_crtc *crtc;
 	int ret;
 	unsigned int i;
 
+	// Confirm that the required vblank functions have been filled out for all CRTCS
+	drm_for_each_crtc(crtc, dev) {
+		if (!crtc->funcs->enable_vblank || !crtc->funcs->disable_vblank) {
+			drm_err(dev, "CRTC vblank functions not initialized for %s, abort\n",
+				crtc->name);
+			return -EINVAL;
+		}
+	}
+
 	spin_lock_init(&dev->vbl_lock);
 	spin_lock_init(&dev->vblank_time_lock);
 

base-commit: 22512c3ee0f47faab5def71c4453638923c62522
-- 
2.46.1


