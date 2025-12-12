Return-Path: <stable+bounces-200922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA54BCB9369
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 17:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC8AF303FE7A
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 16:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9F7223DE5;
	Fri, 12 Dec 2025 16:03:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE51B81D3
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765555405; cv=none; b=i5burTd2Dob2fAL35hIMOXjKkjcypOp3enxZlHR9w3Fb+Pe+YXC5nIe2WDDzty4y4Np7FIWVnQI32PlhCeDOoH9lVSxIJ0yUBuDGk2S5UxtIOONrXFLxyp8nTDAR/BLJTl7hWHqz9Ud9TsTpovz5ewFIarFzAlc3r4Ac/TkYbQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765555405; c=relaxed/simple;
	bh=IxpCP6Ir5aqkUew6WkXBRHBfgVdCsD1X/21j7hNlMmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcokvcojPHzURP2o2yRqIRrwbzBVtxU932tRt8QHmoS5Ex5exFvPXE1XT50ZmfZVMiFQ4rsYX7eCzyFaX9npe1r+VR7woWfbY2uI6fGkT4K3OUXZGDaPbVt0SOhm76EeU+WvzdYIopYxJ3NyS9fSKAKLSNlKuDOnXivYK5aEPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40D525BD06;
	Fri, 12 Dec 2025 16:03:22 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 016233EA63;
	Fri, 12 Dec 2025 16:03:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kEiIOsk8PGlnGgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 12 Dec 2025 16:03:21 +0000
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
Subject: [PATCH 2/5] drm/tests: shmem: Add clean-up action to unpin pages
Date: Fri, 12 Dec 2025 17:00:33 +0100
Message-ID: <20251212160317.287409-3-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 40D525BD06
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action

Automatically unpin pages on cleanup. The test currently fails with
the error

[   58.246263] drm-kunit-mock-device drm_gem_shmem_test_get_sg_table.drm-kunit-mock-device: [drm] drm_WARN_ON(refcount_read(&shmem->pages_pin_count))

while cleaning up the GEM object. The pin count has to be zero at this
point.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: d586b535f144 ("drm/shmem-helper: Add and use pages_pin_count")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/tests/drm_gem_shmem_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index 872881ec9c30..1d50bab51ef3 100644
--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -34,6 +34,9 @@ KUNIT_DEFINE_ACTION_WRAPPER(sg_free_table_wrapper, sg_free_table,
 KUNIT_DEFINE_ACTION_WRAPPER(drm_gem_shmem_free_wrapper, drm_gem_shmem_free,
 			    struct drm_gem_shmem_object *);
 
+KUNIT_DEFINE_ACTION_WRAPPER(drm_gem_shmem_unpin_wrapper, drm_gem_shmem_unpin,
+			    struct drm_gem_shmem_object *);
+
 /*
  * Test creating a shmem GEM object backed by shmem buffer. The test
  * case succeeds if the GEM object is successfully allocated with the
@@ -212,6 +215,9 @@ static void drm_gem_shmem_test_get_sg_table(struct kunit *test)
 	ret = drm_gem_shmem_pin(shmem);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
+	ret = kunit_add_action_or_reset(test, drm_gem_shmem_unpin_wrapper, shmem);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	sgt = drm_gem_shmem_get_sg_table(shmem);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
 	KUNIT_EXPECT_NULL(test, shmem->sgt);
-- 
2.52.0


