Return-Path: <stable+bounces-200925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81296CB937C
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 17:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8627D303BE0C
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDD31DE3DC;
	Fri, 12 Dec 2025 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U2BPTY3U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+enmYD1w";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U2BPTY3U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+enmYD1w"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB51B81D3
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765555423; cv=none; b=TVGkqG/FWCR+7YPxjgAFgO2XtGXI2dShdv8Es/TE0XSeFplyJy6zsYPNJaOSW0D/cad4HRbRIZg+SuyHeAkjuRqWDSMMhekWrYMOt/FAMdogOBIor/7CZKS1kxqiOS++XxO1svhOYsXdG11mrP9VP2piraN96KgY9TPBRmIRNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765555423; c=relaxed/simple;
	bh=Lb8L6CuW96cqgepaI4INZwZGW32esvJC0ZtSnqELMFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yt5F9xzVyQOOpGsajkC99jjyq0OcV6wkj5iqmQO9XqOL4wnMbtufaJtlFHxGyAa0RLmE4ENLNXxosd2+2Nj/YkMALm7fDR6crUjWivAxSFbwcEDEJLgGcD+rV9duNoNyEoz8E4W6bYRP1iomLPLsFqawtJwJwqkXF9MV+FiTqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U2BPTY3U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+enmYD1w; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U2BPTY3U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+enmYD1w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82B045BF06;
	Fri, 12 Dec 2025 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765555403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RYw9zlcLR57EMyllJB4vm9RSxFZ5urZZHZtBvSnlIs=;
	b=U2BPTY3UDoHu9wiPaeux3ss+rT5tE0SRR0/PTgJf0hhuD6JK/aWDojC+2Crjjf0NivH6ql
	HIXuKY0o5JqDveSsrCuE+ecdvsmhJwJ3ivJetJKmuvSoHaEoKx52BEFMPJYyVNkiHn7GWs
	n5f53E0JO1zaOlRFS/ql1pRCZBLqME4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765555403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RYw9zlcLR57EMyllJB4vm9RSxFZ5urZZHZtBvSnlIs=;
	b=+enmYD1wYDdqE44j2P6EYha7p65Bq1iGFcR23VEDVBnAnkPRinQGALVfttrRK2/lEDXr4d
	Svro+V+EuLgsxDDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765555403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RYw9zlcLR57EMyllJB4vm9RSxFZ5urZZHZtBvSnlIs=;
	b=U2BPTY3UDoHu9wiPaeux3ss+rT5tE0SRR0/PTgJf0hhuD6JK/aWDojC+2Crjjf0NivH6ql
	HIXuKY0o5JqDveSsrCuE+ecdvsmhJwJ3ivJetJKmuvSoHaEoKx52BEFMPJYyVNkiHn7GWs
	n5f53E0JO1zaOlRFS/ql1pRCZBLqME4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765555403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RYw9zlcLR57EMyllJB4vm9RSxFZ5urZZHZtBvSnlIs=;
	b=+enmYD1wYDdqE44j2P6EYha7p65Bq1iGFcR23VEDVBnAnkPRinQGALVfttrRK2/lEDXr4d
	Svro+V+EuLgsxDDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41EB53EA65;
	Fri, 12 Dec 2025 16:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eO/jDss8PGlnGgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 12 Dec 2025 16:03:23 +0000
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
Subject: [PATCH 5/5] drm/tests: shmem: Hold reservation lock around purge
Date: Fri, 12 Dec 2025 17:00:36 +0100
Message-ID: <20251212160317.287409-6-tzimmermann@suse.de>
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

Acquire and release the GEM object's reservation lock around calls
to the object's purge operation. The tests use
drm_gem_shmem_purge_locked(), which led to errors such as show below.

[   58.709128] WARNING: CPU: 1 PID: 1354 at drivers/gpu/drm/drm_gem_shmem_helper.c:515 drm_gem_shmem_purge_locked+0x51c/0x740

Only export the new helper drm_gem_shmem_purge() for Kunit tests.
This is not an interface for regular drivers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 954907f7147d ("drm/shmem-helper: Refactor locked/unlocked functions")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/drm_gem_shmem_helper.c     | 15 +++++++++++++++
 drivers/gpu/drm/tests/drm_gem_shmem_test.c |  4 +++-
 include/drm/drm_gem_shmem_helper.h         |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 4ffcf6ed46f5..dfc24392cb61 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -939,6 +939,21 @@ int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv)
 	return ret;
 }
 EXPORT_SYMBOL_IF_KUNIT(drm_gem_shmem_madvise);
+
+int drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
+{
+	struct drm_gem_object *obj = &shmem->base;
+	int ret;
+
+	ret = dma_resv_lock_interruptible(obj->resv, NULL);
+	if (ret)
+		return ret;
+	drm_gem_shmem_purge_locked(shmem);
+	dma_resv_unlock(obj->resv);
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(drm_gem_shmem_purge);
 #endif
 
 MODULE_DESCRIPTION("DRM SHMEM memory-management helpers");
diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index d639848e3c8e..4b459f21acfd 100644
--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -340,7 +340,9 @@ static void drm_gem_shmem_test_purge(struct kunit *test)
 	ret = drm_gem_shmem_is_purgeable(shmem);
 	KUNIT_EXPECT_TRUE(test, ret);
 
-	drm_gem_shmem_purge_locked(shmem);
+	ret = drm_gem_shmem_purge(shmem);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	KUNIT_EXPECT_NULL(test, shmem->pages);
 	KUNIT_EXPECT_NULL(test, shmem->sgt);
 	KUNIT_EXPECT_EQ(test, shmem->madv, -1);
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 3dd93e2df709..8d56970d7eed 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -311,6 +311,7 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
 int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map);
 void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map);
 int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv);
+int drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem);
 #endif
 
 #endif /* __DRM_GEM_SHMEM_HELPER_H__ */
-- 
2.52.0


