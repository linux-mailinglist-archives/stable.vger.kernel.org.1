Return-Path: <stable+bounces-220601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCsmAnY7o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:01:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E5C1C683D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 122AA309754E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9FD3E2801;
	Sat, 28 Feb 2026 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob1Dmt9l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15FD3E27F8;
	Sat, 28 Feb 2026 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300484; cv=none; b=hqSmVCfsffsh3SYHpNBXLbH3eO2kpAPFq87cTxMfjPnjjlkFVCwOGk0/pYjWQcDI9cjOoAn0zYedbUgIiOAnqgF/BlT7Gwfpwmg7DCgO4/rCjFTW1+uDCjMA/V1K/XyXv5Uiufuc6GWMKBtQzOQfop1lK+yfv5/XwFugrGSRLXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300484; c=relaxed/simple;
	bh=PaP8xmVX6DAgu/ZJhy0ky3LLPoRAImQyNvWyoInYIuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVPcxP2UkRzsKl+EkW9Hp/zkm5xEL33Lf6i1GIwnZYLdLiWBsyT21HrE3OT3l5EkMu5XGTEmVG6vgDAEmKarm2vYAaVknzXV728etot+1k//QUov7uK9k6U2tddlwNQqQQnn8wymP62ZhGOVpWDhSvY6aUiHNOygOSV3VM0eVKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob1Dmt9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAD8C19424;
	Sat, 28 Feb 2026 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300484;
	bh=PaP8xmVX6DAgu/ZJhy0ky3LLPoRAImQyNvWyoInYIuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ob1Dmt9lzTs+pbuQ6WZZkbgrKQou6kvYtcc/Wys3HWB+c2/PHSLc2jhHt7WSUlEPU
	 CRkdfX094goLOuCZ5hzeILbO4llx7mO9L7sgzw5MtH2bFgar3bjjIhREjhfcp9SVGD
	 3Vxjoq3/LAmHGjDpdXC2zJkdaYF1+b+U3i87g+VHXoGk/lCc2HguqG1yzE3zO2cmU9
	 +89k0pdhNrD4K5SN5/lytGMblPyRP7CawMgBwnCzH5SjF1s8YwPtRdW7gqp8dOVsE0
	 EYeVI/S6/oMlczxVD6ICT017b6AunL5W96abozb/XWQ0D3i/gI3i2t+OpiGzfMwm4L
	 HGady3S1/RTVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 522/844] drm/tests: shmem: Hold reservation lock around madvise
Date: Sat, 28 Feb 2026 12:27:15 -0500
Message-ID: <20260228173244.1509663-523-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220601-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.freedesktop.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,collabora.com:email,msgid.link:url,suse.de:email]
X-Rspamd-Queue-Id: B3E5C1C683D
X-Rspamd-Action: no action

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 607d07d8cc0b835a8701259f08a03dc149b79b4f ]

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
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patch.msgid.link/20251212160317.287409-5-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c     | 15 +++++++++++++++
 drivers/gpu/drm/tests/drm_gem_shmem_test.c |  8 ++++----
 include/drm/drm_gem_shmem_helper.h         |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index b7064b8333e89..1dfc9c4089587 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -925,6 +925,21 @@ void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem, struct iosys_map *
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
index 3e7c6f20fbcca..d639848e3c8ea 100644
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
index 6924ee226655a..3dd93e2df7092 100644
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
2.51.0


