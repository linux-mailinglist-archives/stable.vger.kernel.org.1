Return-Path: <stable+bounces-200924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F25E2CB9373
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 17:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF7A13007CA3
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5131DE3DC;
	Fri, 12 Dec 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FDkhG08i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WBB9/0i6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FDkhG08i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WBB9/0i6"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9779344C8F
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765555417; cv=none; b=DWSAKcDCtnDgZlYfKmk0rA6P8/nztQm+ti6jF9PNGccoEU57QlsLlZrJPFqPFaOoYmS54eJdd5NvVDrND2PJ3atzd5gbCNgC9zVTuPltoa2RXOyeCyxGikoApkPEeLPR9m+fivs1czOs++dPfSgyCKhv4u//VFEkhdPrg5/hYNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765555417; c=relaxed/simple;
	bh=d1yQP7zu5Ax/3QaGHcEr/MtzAXL71yP/mB02LLtFd9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gx1duTrLb9DgaaVHWnbKM05efWd34HRot0x18ZRH8p39pHfDIBASvgxINRqJws5AVbxCZZ9/9rcWoGb+7x+KsBXRaLDq/FDBAB2rd9mFT5ReSuA1SL+swBn6kbeIsLUihZf5F0KwI0K8i3UIZd30MFxKbpZS/oYSvpKIBIM7Ujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FDkhG08i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WBB9/0i6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FDkhG08i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WBB9/0i6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B6225BEF2;
	Fri, 12 Dec 2025 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765555403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ebCr+xKPFF6rrikhA7bRNgLHI24kb/JRFADX2M+0bPM=;
	b=FDkhG08ixQEeqGtK6ZhT9sRZ/hiFk0ImE5deyN8o6TiIWOKtw+XgGo/SOZ9+PoKlCNWoTQ
	u4KvptxApfkNzMBXTKeLd/ihPBKALsVNoIxenbweAf6NST9CO+kkp4b3bDacm1i0NF/p8C
	CjVUnqRqcN2uf1GjLl6lvSuB0BINhXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765555403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ebCr+xKPFF6rrikhA7bRNgLHI24kb/JRFADX2M+0bPM=;
	b=WBB9/0i6NUxlF1k6aKrLNwlNqYsAbAuIpAB7P82dp/vtsXVAJTfgySALze609dR06TsKnv
	i7bzSpizzVRWjpCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765555403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ebCr+xKPFF6rrikhA7bRNgLHI24kb/JRFADX2M+0bPM=;
	b=FDkhG08ixQEeqGtK6ZhT9sRZ/hiFk0ImE5deyN8o6TiIWOKtw+XgGo/SOZ9+PoKlCNWoTQ
	u4KvptxApfkNzMBXTKeLd/ihPBKALsVNoIxenbweAf6NST9CO+kkp4b3bDacm1i0NF/p8C
	CjVUnqRqcN2uf1GjLl6lvSuB0BINhXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765555403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ebCr+xKPFF6rrikhA7bRNgLHI24kb/JRFADX2M+0bPM=;
	b=WBB9/0i6NUxlF1k6aKrLNwlNqYsAbAuIpAB7P82dp/vtsXVAJTfgySALze609dR06TsKnv
	i7bzSpizzVRWjpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0B833EA63;
	Fri, 12 Dec 2025 16:03:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8FhfOco8PGlnGgAAD6G6ig
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
Subject: [PATCH 4/5] drm/tests: shmem: Hold reservation lock around madvise
Date: Fri, 12 Dec 2025 17:00:35 +0100
Message-ID: <20251212160317.287409-5-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[collabora.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLwtd9qf4a971hssh5godp6qbx)];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

Acquire and release the GEM object's reservation lock around calls
to the object's madvide operation. The tests use
drm_gem_shmem_madvise_locked(), which led to errors such as show below.

[   58.339389] WARNING: CPU: 1 PID: 1352 at drivers/gpu/drm/drm_gem_shmem_helper.c:499 drm_gem_shmem_madvise_locked+0xde/0x140

Only export the new helper drm_gem_shmem_madvise() for Kunit tests.
This is not an interface for regular drivers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 954907f7147d ("drm/shmem-helper: Refactor locked/unlocked functions")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/drm_gem_shmem_helper.c     | 15 +++++++++++++++
 drivers/gpu/drm/tests/drm_gem_shmem_test.c |  8 ++++----
 include/drm/drm_gem_shmem_helper.h         |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 06ef4e5adb7d..4ffcf6ed46f5 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -924,6 +924,21 @@ void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem, struct iosys_map *
 	dma_resv_unlock(obj->resv);
 }
 EXPORT_SYMBOL_IF_KUNIT(drm_gem_shmem_vunmap);
+
+int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv)
+{
+	struct drm_gem_object *obj = &shmem->base;
+	int ret;
+
+	ret = dma_resv_lock_interruptible(obj->resv, NULL);
+	if (ret)
+		return ret;
+	ret = drm_gem_shmem_madvise_locked(shmem, madv);
+	dma_resv_unlock(obj->resv);
+
+	return ret;
+}
+EXPORT_SYMBOL_IF_KUNIT(drm_gem_shmem_madvise);
 #endif
 
 MODULE_DESCRIPTION("DRM SHMEM memory-management helpers");
diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index 3e7c6f20fbcc..d639848e3c8e 100644
--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -292,17 +292,17 @@ static void drm_gem_shmem_test_madvise(struct kunit *test)
 	ret = kunit_add_action_or_reset(test, drm_gem_shmem_free_wrapper, shmem);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	ret = drm_gem_shmem_madvise_locked(shmem, 1);
+	ret = drm_gem_shmem_madvise(shmem, 1);
 	KUNIT_EXPECT_TRUE(test, ret);
 	KUNIT_ASSERT_EQ(test, shmem->madv, 1);
 
 	/* Set madv to a negative value */
-	ret = drm_gem_shmem_madvise_locked(shmem, -1);
+	ret = drm_gem_shmem_madvise(shmem, -1);
 	KUNIT_EXPECT_FALSE(test, ret);
 	KUNIT_ASSERT_EQ(test, shmem->madv, -1);
 
 	/* Check that madv cannot be set back to a positive value */
-	ret = drm_gem_shmem_madvise_locked(shmem, 0);
+	ret = drm_gem_shmem_madvise(shmem, 0);
 	KUNIT_EXPECT_FALSE(test, ret);
 	KUNIT_ASSERT_EQ(test, shmem->madv, -1);
 }
@@ -330,7 +330,7 @@ static void drm_gem_shmem_test_purge(struct kunit *test)
 	ret = drm_gem_shmem_is_purgeable(shmem);
 	KUNIT_EXPECT_FALSE(test, ret);
 
-	ret = drm_gem_shmem_madvise_locked(shmem, 1);
+	ret = drm_gem_shmem_madvise(shmem, 1);
 	KUNIT_EXPECT_TRUE(test, ret);
 
 	/* The scatter/gather table will be freed by drm_gem_shmem_free */
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 6924ee226655..3dd93e2df709 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -310,6 +310,7 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
 #if IS_ENABLED(CONFIG_KUNIT)
 int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map);
 void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map);
+int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv);
 #endif
 
 #endif /* __DRM_GEM_SHMEM_HELPER_H__ */
-- 
2.52.0


