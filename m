Return-Path: <stable+bounces-220600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJwvG347o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:01:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 481A41C684B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 912C43091C9B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3666D3E27E9;
	Sat, 28 Feb 2026 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSIAMWeK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7EE3E27E2;
	Sat, 28 Feb 2026 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300484; cv=none; b=oLVHR/fjqtc+wU7pfhm62FBOa9T7+58cVW90Ei78ChkIp4z+2ODffIGbqs78AFcsAmvH+O5mvKzHuH4kOndF8fJQavv9VrCSI/y6g35GBBKrAthEObSzifxVwmRzKqY7CouFzOwQRC//qExzHs417n5iYJ5zjyA4T9kvBS76Gtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300484; c=relaxed/simple;
	bh=woVw7RupdfUN26E495+pHA7Ft8zUjT4p/GDj8wqKJGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMwmyzMd5tDnrEiWeZkWh0A+D7/HNH+9NWrXNYkTTu4VyPZoo427Jzfq4sKRZwKAfOtj7V57WxmiXgW50DK0gbmPTtnT8FV7vH2eNRxrEmJc1mwTyYyGIa5ClNDfKsG6FG3BItBNBMe7SuMafdgSZcxuBgjO9uTFyRnWOhoj6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSIAMWeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCECC19423;
	Sat, 28 Feb 2026 17:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300483;
	bh=woVw7RupdfUN26E495+pHA7Ft8zUjT4p/GDj8wqKJGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSIAMWeKWNwLIqPbS9a4/AbpnzfYp7+aTrbvovTaKLVxn49QaQb2gbYR11izTyFpv
	 z4Rc2RNzDU4CPQMH5hhzWYmUw5zadeTckYIRJRke8T16QfzqAeEAd9ri+rvjEmZlM1
	 im4q10bDO4nsZoIvk7n8ckQmF3WB5khDh/w9cVv3fabjIHJI7A27dmizuUVa8Sjm2v
	 bfwZ3wmNI7QRvEoPxyn6vjeYPjr/inkTsGkGIvLsZIzaLMYH5q9pORZrbsKHb1mJLW
	 s7Mf6wXqh+Xrx2Y9+vMV3pGAsH7Ldyc9h1yKGBTAJq5CpfnJAW8izLB22h43rGVBv3
	 QoUEIyP9AFiyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 521/844] drm/tests: shmem: Hold reservation lock around vmap/vunmap
Date: Sat, 28 Feb 2026 12:27:14 -0500
Message-ID: <20260228173244.1509663-522-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220600-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.freedesktop.org:email,suse.de:email,collabora.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 481A41C684B
X-Rspamd-Action: no action

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit cda83b099f117f2a28a77bf467af934cb39e49cf ]

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
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patch.msgid.link/20251212160317.287409-4-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c     | 33 ++++++++++++++++++++++
 drivers/gpu/drm/tests/drm_gem_shmem_test.c |  6 ++--
 include/drm/drm_gem_shmem_helper.h         |  9 ++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index f13eb5f36e8a9..b7064b8333e89 100644
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
@@ -894,6 +896,37 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
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
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index 1d50bab51ef3f..3e7c6f20fbcca 100644
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
index 589f7bfe7506e..6924ee226655a 100644
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
2.51.0


