Return-Path: <stable+bounces-179248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4333DB52CBD
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 11:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFED1167073
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE3B2E888C;
	Thu, 11 Sep 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="uBd9UPu9"
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19420297C;
	Thu, 11 Sep 2025 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581888; cv=none; b=Wj6TBxyc7iMn5kJObxzVxAsIAYEnp4mE7TwUvV4YueSCWuVlSa7w1qBvnP9JnAqj1RpJ4t9pRun4mEeCOpQ3Et+/ie0BF7HhZB+dsQebAz1jL3Pbrj3dt/d+mdT0Qe14DkT8g+v0Tv3Yuu8Epkb4gbndmNcb/7DjkiLGrnW64n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581888; c=relaxed/simple;
	bh=Y0jxY2UoGEBpb56GCXKheJ9DTcUI1kAj+ihi2goW6+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FxrjNlzhDZr+hRn2whnf1HvjqzO4K7226n2wJUsuB2JQOIMbzgw3JrmFslAxd4HxEy2cJgrd83npVqVWx8AHtINL4bAehrimIyGRXa245bNIs3xDNVaVeE4NU8IC4FfaHy2oC3oKYsrlvqLtX4ouk7zn09hJh4Fbl08EyxklqMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=uBd9UPu9; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1757581407;
	bh=Y0jxY2UoGEBpb56GCXKheJ9DTcUI1kAj+ihi2goW6+I=;
	h=From:To:Cc:Subject:Date:From;
	b=uBd9UPu9moXhzylPqquHlyLDxSoAqx82lR9v9p91PQDAfO12PjF6yW14I+2OGOSHC
	 YqaUX/eR1GsA3aIQoNm6PtnGCaKk8qxwtYvExcs+iRHuhoaUIJhM6P9aBL0pf3XWKV
	 76Mo7ypL4pTlCYq5LJS3lv/OB1sIJggOA857zS78Jd+nLGpKOXqZerEVmnKOdy4gZg
	 GZSLZjdiWODE5I8jvy0UNLxeM5f26tDYKJcLYrOOosCtSsrYRiDR5ZMH0xHMAJpRSG
	 L5jAzojK349rq70qBF56JVjRLbYsPOOcjGIUtoD9Jc03sMqnF/RP6PqqeqJecxZKdi
	 cNeXD/wTn+iSg==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 6E1E11F9EE;
	Thu, 11 Sep 2025 12:03:27 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 12:03:25 +0300 (MSK)
Received: from rbta-msk-lt-169874.astralinux.ru (rbta-msk-lt-169874.astralinux.ru [10.190.6.151])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4cMs5l6T3Bz2xBx;
	Thu, 11 Sep 2025 12:02:51 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Shuicheng Lin <shuicheng.lin@intel.com>
Subject: [PATCH 6.12] drm/xe/hw_engine_group: Avoid call kfree() for drmm_kzalloc()
Date: Thu, 11 Sep 2025 12:01:15 +0300
Message-Id: <20250911090116.47103-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/09/11 08:15:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 66 0.3.66 fc5dda3b6b70d34b3701db39319eece2aeb510fb, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;lore.kernel.org:7.1.1;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 196178 [Sep 11 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/09/11 07:23:00 #27808108
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/09/11 08:15:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Shuicheng Lin <shuicheng.lin@intel.com>

commit 4846856c3a4afa882b6d1b842ed2fad6f3781f4d upstream.

Memory allocated with drmm_kzalloc() should not be freed using
kfree(), as it is managed by the DRM subsystem. The memory will
be automatically freed when the associated drm_device is released.
These 3 group pointers are allocated using drmm_kzalloc() in
hw_engine_group_alloc(), so they don't require manual deallocation.

Fixes: 67979060740f ("drm/xe/hw_engine_group: Fix potential leak")
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://lore.kernel.org/r/20250724193854.1124510-2-shuicheng.lin@intel.com
(cherry picked from commit f98de826b418885a21ece67f0f5b921ae759b7bf)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
 drivers/gpu/drm/xe/xe_hw_engine_group.c | 28 ++++++-------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_engine_group.c b/drivers/gpu/drm/xe/xe_hw_engine_group.c
index 82750520a90a..d0f1bf32cdd5 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_group.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine_group.c
@@ -84,25 +84,18 @@ int xe_hw_engine_setup_groups(struct xe_gt *gt)
 	enum xe_hw_engine_id id;
 	struct xe_hw_engine_group *group_rcs_ccs, *group_bcs, *group_vcs_vecs;
 	struct xe_device *xe = gt_to_xe(gt);
-	int err;
 
 	group_rcs_ccs = hw_engine_group_alloc(xe);
-	if (IS_ERR(group_rcs_ccs)) {
-		err = PTR_ERR(group_rcs_ccs);
-		goto err_group_rcs_ccs;
-	}
+	if (IS_ERR(group_rcs_ccs))
+		return PTR_ERR(group_rcs_ccs);
 
 	group_bcs = hw_engine_group_alloc(xe);
-	if (IS_ERR(group_bcs)) {
-		err = PTR_ERR(group_bcs);
-		goto err_group_bcs;
-	}
+	if (IS_ERR(group_bcs))
+		return PTR_ERR(group_bcs);
 
 	group_vcs_vecs = hw_engine_group_alloc(xe);
-	if (IS_ERR(group_vcs_vecs)) {
-		err = PTR_ERR(group_vcs_vecs);
-		goto err_group_vcs_vecs;
-	}
+	if (IS_ERR(group_vcs_vecs))
+		return PTR_ERR(group_vcs_vecs);
 
 	for_each_hw_engine(hwe, gt, id) {
 		switch (hwe->class) {
@@ -125,15 +118,6 @@ int xe_hw_engine_setup_groups(struct xe_gt *gt)
 	}
 
 	return 0;
-
-err_group_vcs_vecs:
-	kfree(group_vcs_vecs);
-err_group_bcs:
-	kfree(group_bcs);
-err_group_rcs_ccs:
-	kfree(group_rcs_ccs);
-
-	return err;
 }
 
 /**
-- 
2.39.2


