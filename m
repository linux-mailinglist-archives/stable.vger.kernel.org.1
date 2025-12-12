Return-Path: <stable+bounces-200923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A05CB9370
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 17:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 860C5303B2FB
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35071DE3DC;
	Fri, 12 Dec 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="il4rUj9A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0KfMqNmk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="il4rUj9A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0KfMqNmk"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0359D44C8F
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765555411; cv=none; b=EjrkesRi4M1lhFVmmMCuhxu3O4PDacH+qi5zSR0Yz+0eaOuDmT+hXhcYcsDcQPRQD1OAB0xTygIfrJylRdmC2PRRTI9u7ER4+B0zjegkCZCuh5A8JkgtsCAEJAAEaux5A1uOS0GiBIRwonCREiSBpkuzMYLvM+JIEDczkssqrVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765555411; c=relaxed/simple;
	bh=9OwkLACLs0nf2Adv16OQvwHjm2ZGicrAq/XGVU7RY70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWVIrOy8Voe9EVCt9NE3T+BfY7hFUdwmts1dpTg8vRwub7PGh6B4OKCXD/xIVKbKYZAlvwHMGfFerJHuOsEebqI5/ViGEGDWHv+I4130ZQr1KPbROPmG8fUwKcJ11FHEf4wQQILG/8Jbi8o6/Jhw6ip64qs8Q+DO/6GPc+EABPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=il4rUj9A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0KfMqNmk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=il4rUj9A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0KfMqNmk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A87F85BE0B;
	Fri, 12 Dec 2025 16:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765555402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fXAT/4wwdOWreSHFTmvbCltmq8SGyHUwO/24POMzkA=;
	b=il4rUj9ACd/QRCIoOd7bmvpybNt0OscLQt5SQd8Bdc/e1NT1KewTNmNBy4kvTobmzmEMwg
	caY326OduXPFmTARuctOs/mato7ufpl/44/u4NHBuI3CtOpKbFbSqjdmgmpbDK8/d0g/Lz
	sRVKinEj0+DGVqAy9R0i6ZdXs9efWss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765555402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fXAT/4wwdOWreSHFTmvbCltmq8SGyHUwO/24POMzkA=;
	b=0KfMqNmkk5L1jzmzSJdaphbn7S9tvvFvpgfaWowaPtqk+tcXHppV0fVFM6FO5K7wxtFbgx
	FOv68tAHV/6Iu4Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765555402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fXAT/4wwdOWreSHFTmvbCltmq8SGyHUwO/24POMzkA=;
	b=il4rUj9ACd/QRCIoOd7bmvpybNt0OscLQt5SQd8Bdc/e1NT1KewTNmNBy4kvTobmzmEMwg
	caY326OduXPFmTARuctOs/mato7ufpl/44/u4NHBuI3CtOpKbFbSqjdmgmpbDK8/d0g/Lz
	sRVKinEj0+DGVqAy9R0i6ZdXs9efWss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765555402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fXAT/4wwdOWreSHFTmvbCltmq8SGyHUwO/24POMzkA=;
	b=0KfMqNmkk5L1jzmzSJdaphbn7S9tvvFvpgfaWowaPtqk+tcXHppV0fVFM6FO5K7wxtFbgx
	FOv68tAHV/6Iu4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 486373EA65;
	Fri, 12 Dec 2025 16:03:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EFEWEMo8PGlnGgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 12 Dec 2025 16:03:22 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: boris.brezillon@collabora.com,
	dmitry.osipenko@collabora.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 3/5] drm/tests: shmem: Hold reservation lock around vmap/vunmap
Date: Fri, 12 Dec 2025 17:00:34 +0100
Message-ID: <20251212160317.287409-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212160317.287409-1-tzimmermann@suse.de>
References: <20251212160317.287409-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[collabora.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Acquire and release the GEM object's reservation lock around vmap and
vunmap operations. The tests use vmap_locked, which led to errors such
as show below.

[  122.292030] WARNING: CPU: 3 PID: 1413 at drivers/gpu/drm/drm_gem_shmem_helper.c:390 drm_gem_shmem_vmap_locked+0x3a3/0x6f0

[  122.468066] WARNING: CPU: 3 PID: 1413 at drivers/gpu/drm/drm_gem_shmem_helper.c:293 drm_gem_shmem_pin_locked+0x1fe/0x350

[  122.563504] WARNING: CPU: 3 PID: 1413 at drivers/gpu/drm/drm_gem_shmem_helper.c:234 drm_gem_shmem_get_pages_locked+0x23c/0x370

[  122.662248] WARNING: CPU: 2 PID: 1413 at drivers/gpu/drm/drm_gem_shmem_helper.c:452 drm_gem_shmem_vunmap_locked+0x101/0x330

Only export the new vmap/vunmap helpers for Kunit tests. These are
not interfaces for regular drivers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 954907f7147d ("drm/shmem-helper: Refactor locked/unlocked functions")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/drm_gem_shmem_helper.c     | 33 ++++++++++++++++++++++
 drivers/gpu/drm/tests/drm_gem_shmem_test.c |  6 ++--
 include/drm/drm_gem_shmem_helper.h         |  9 ++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index dc94a27710e5..06ef4e5adb7d 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -15,6 +15,8 @@
 #include <asm/set_memory.h>
 #endif
 
+#include <kunit/visibility.h>
+
 #include <drm/drm.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
@@ -893,6 +895,37 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_no_map);
 
+/*
+ * Kunit helpers
+ */
+
+#if IS_ENABLED(CONFIG_KUNIT)
+int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map)
+{
+	struct drm_gem_object *obj = &shmem->base;
+	int ret;
+
+	ret = dma_resv_lock_interruptible(obj->resv, NULL);
+	if (ret)
+		return ret;
+	ret = drm_gem_shmem_vmap_locked(shmem, map);
+	dma_resv_unlock(obj->resv);
+
+	return ret;
+}
+EXPORT_SYMBOL_IF_KUNIT(drm_gem_shmem_vmap);
+
+void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map)
+{
+	struct drm_gem_object *obj = &shmem->base;
+
+	dma_resv_lock_interruptible(obj->resv, NULL);
+	drm_gem_shmem_vunmap_locked(shmem, map);
+	dma_resv_unlock(obj->resv);
+}
+EXPORT_SYMBOL_IF_KUNIT(drm_gem_shmem_vunmap);
+#endif
+
 MODULE_DESCRIPTION("DRM SHMEM memory-management helpers");
 MODULE_IMPORT_NS("DMA_BUF");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index 1d50bab51ef3..3e7c6f20fbcc 100644
--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -19,6 +19,8 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_kunit_helpers.h>
 
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
 #define TEST_SIZE		SZ_1M
 #define TEST_BYTE		0xae
 
@@ -176,7 +178,7 @@ static void drm_gem_shmem_test_vmap(struct kunit *test)
 	ret = kunit_add_action_or_reset(test, drm_gem_shmem_free_wrapper, shmem);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	ret = drm_gem_shmem_vmap_locked(shmem, &map);
+	ret = drm_gem_shmem_vmap(shmem, &map);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	KUNIT_ASSERT_NOT_NULL(test, shmem->vaddr);
 	KUNIT_ASSERT_FALSE(test, iosys_map_is_null(&map));
@@ -186,7 +188,7 @@ static void drm_gem_shmem_test_vmap(struct kunit *test)
 	for (i = 0; i < TEST_SIZE; i++)
 		KUNIT_EXPECT_EQ(test, iosys_map_rd(&map, i, u8), TEST_BYTE);
 
-	drm_gem_shmem_vunmap_locked(shmem, &map);
+	drm_gem_shmem_vunmap(shmem, &map);
 	KUNIT_EXPECT_NULL(test, shmem->vaddr);
 	KUNIT_EXPECT_EQ(test, refcount_read(&shmem->vmap_use_count), 0);
 }
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 589f7bfe7506..6924ee226655 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -303,4 +303,13 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
 	.gem_prime_import       = drm_gem_shmem_prime_import_no_map, \
 	.dumb_create            = drm_gem_shmem_dumb_create
 
+/*
+ * Kunit helpers
+ */
+
+#if IS_ENABLED(CONFIG_KUNIT)
+int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map);
+void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map);
+#endif
+
 #endif /* __DRM_GEM_SHMEM_HELPER_H__ */
-- 
2.52.0


