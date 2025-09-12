Return-Path: <stable+bounces-179344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96917B54CEE
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 14:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B0A5C0053
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D9E3009F4;
	Fri, 12 Sep 2025 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="gfHV1WBQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03233302145;
	Fri, 12 Sep 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678644; cv=none; b=FlOu0jJSh7xB87vo/M2SunCSqiFV8bqtdu83klrP2SOs4ZrvwFDatRgVm02WM0oVby6at42iyUi17DIgqB9J4KJdJ20BSIgo7yXGWWCgWogE4uSuzPSCHQro/dZ+dhprXNwigRWDBMOF9JHUys8ftOfJ3NTakeRk07qKLzdHZEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678644; c=relaxed/simple;
	bh=Vl0rIhp9sKRA8jG8SKikvBPaeIGGXcTgtzw0C36iPxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B0rnwAUUqQfrFsNflPsDpCWBXSPJ/+/vTOltym3innZODQPM0QzUOJhGnRJ8I5w49DqISqJ2wC1IFNxY/P9NlS7vkIhjfExSOqr68urVtm6OW42qJftv3q82G40qyhU9vaCmIQA7oE2zy8c5QkVNTyXKy/JvI5/IV9U1xhYxhyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=gfHV1WBQ; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1757678631;
	bh=Vl0rIhp9sKRA8jG8SKikvBPaeIGGXcTgtzw0C36iPxg=;
	h=From:To:Cc:Subject:Date:From;
	b=gfHV1WBQahPia/jamv6MnG3iWzPa6LuhUIkTFVPMREL3VneFzZFl0tFb3R970jXOR
	 QmBDnaH84AsYY1McHqq5n3cvaEFz0atmLh5NlPsJsdufxG1Z60cKspEbEJAxEGhZru
	 sIMoBmN7DkpYAXdXqKfawljDZdSiDK432fzKx46Hz2DOg4LWWRZARPVp83TAzvGX9d
	 oF1jq8yggZUxxTeagWK/dOL3j1ZWWW1Cumrc7gr/mU2QBwYYDMN1lBOJQ7NCQ6ctoC
	 1oVDXW4524v5LxLbd6qDan9E9JtamR794apUI/Diq9ycCjRG8H74KMceea4VzSXlO0
	 EdCC7Jx/Zu+jg==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id DC9F31FA00;
	Fri, 12 Sep 2025 15:03:51 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri, 12 Sep 2025 15:03:50 +0300 (MSK)
Received: from rbta-msk-lt-169874.astralinux.site (unknown [10.198.57.215])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4cNY3S5GmNz2xBx;
	Fri, 12 Sep 2025 15:03:16 +0300 (MSK)
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
	Francois Dugast <francois.dugast@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v2 6.12 1/3] drm/managed: Add DRM-managed alloc_ordered_workqueue
Date: Fri, 12 Sep 2025 15:01:59 +0300
Message-Id: <20250912120202.240305-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/09/12 10:31:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 66 0.3.66 fc5dda3b6b70d34b3701db39319eece2aeb510fb, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;patchwork.freedesktop.org:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 196220 [Sep 12 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/09/12 09:49:00 #27811571
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/09/12 11:18:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Louis Chauvet <louis.chauvet@bootlin.com>

commit c367b772e6d89d8c7b560c7df7e3803ce6b8bcea upstream.

Add drmm_alloc_ordered_workqueue(), a helper that provides managed ordered
workqueue cleanup. The workqueue will be destroyed with the final
reference of the DRM device.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20250116-google-vkms-managed-v9-3-3e4ae1bd05a0@bootlin.com
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
 drivers/gpu/drm/drm_managed.c |  8 ++++++++
 include/drm/drm_managed.h     | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_managed.c b/drivers/gpu/drm/drm_managed.c
index 79ce86a5bd67..cc4c463daae7 100644
--- a/drivers/gpu/drm/drm_managed.c
+++ b/drivers/gpu/drm/drm_managed.c
@@ -310,3 +310,11 @@ void __drmm_mutex_release(struct drm_device *dev, void *res)
 	mutex_destroy(lock);
 }
 EXPORT_SYMBOL(__drmm_mutex_release);
+
+void __drmm_workqueue_release(struct drm_device *device, void *res)
+{
+	struct workqueue_struct *wq = res;
+
+	destroy_workqueue(wq);
+}
+EXPORT_SYMBOL(__drmm_workqueue_release);
diff --git a/include/drm/drm_managed.h b/include/drm/drm_managed.h
index f547b09ca023..53017cc609ac 100644
--- a/include/drm/drm_managed.h
+++ b/include/drm/drm_managed.h
@@ -127,4 +127,16 @@ void __drmm_mutex_release(struct drm_device *dev, void *res);
 	drmm_add_action_or_reset(dev, __drmm_mutex_release, lock);	     \
 })									     \
 
+void __drmm_workqueue_release(struct drm_device *device, void *wq);
+
+#define drmm_alloc_ordered_workqueue(dev, fmt, flags, args...)					\
+	({											\
+		struct workqueue_struct *wq = alloc_ordered_workqueue(fmt, flags, ##args);	\
+		wq ? ({										\
+			int ret = drmm_add_action_or_reset(dev, __drmm_workqueue_release, wq);	\
+			ret ? ERR_PTR(ret) : wq;						\
+		}) :										\
+			wq;									\
+	})
+
 #endif
-- 
2.39.2


