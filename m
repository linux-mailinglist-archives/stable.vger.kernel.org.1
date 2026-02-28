Return-Path: <stable+bounces-220602-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOrHFGs7o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220602-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:00:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D10021C6834
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFC3630A11CD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EAB3E281B;
	Sat, 28 Feb 2026 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG9IgV0n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB883E2814;
	Sat, 28 Feb 2026 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300485; cv=none; b=m7zY4kab3TFETPFXWg0lRzKhpAIlQ+oblNCvJdGWATlzKto3YtIAkJyKqRxrlx8WVogK8MqbDHSoibeKAJ8gRkPrYxcdicdhuP/FqxhpEV2sCWlM/YAcK1lWTz3s0B5tRLBTt2bWG86UgFhgJhDejvWyOsS015r8u5B9uvSnFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300485; c=relaxed/simple;
	bh=oJ+fRIDJzuhUNlGePCiimaDZMppSI5Nw9MhP5u2/hUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5Z3jnbs1aVkM0daZ7mekNF7dOsaI7/PO1e3btnuuqRPIFoI6ZA79lAtPNIjxuWUFXAE79a/8alV5QeVKRnXuOO2WvNPL3DlL/l0HnWspNXzFCJxTbkpAKaabuffFBTE2LhoEDBJcQGHVcbe0/WUtaJ5EgjxpKqlj7aBOyNcwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG9IgV0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD7AC116D0;
	Sat, 28 Feb 2026 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300485;
	bh=oJ+fRIDJzuhUNlGePCiimaDZMppSI5Nw9MhP5u2/hUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aG9IgV0nIxZd1rBB/gUbbRM23Rs5hvY0OPqFpqupsHkwPAJL5NMvqUGK6rTd8jTre
	 CQW0BJmd8KVyb79a2+zAFR4G2Q/LANoTsNdbZ6StXg9ECOoQyKJPrDjnu8PzXp5qLK
	 ckJlQwunjZvLCod2y/Kwpos3a9SzVxgZOfhyxGH5GmdNS03V2XcyLYVP2hCuyPyIqu
	 OZbnYZDKNQIO0fpvtr1tbBSYiH8VCEzjg6ILleBRVUJwsNpblO5uk4CFLcubxRD3FZ
	 MKDoUTWGQ2CB6KNt6MA2NMHtiyB94pYb7ffWF1Yp+C3uwEB9bnXC8W8Bvp2ZRIzTlG
	 RLTGrLh0HA8Ng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 523/844] drm/tests: shmem: Hold reservation lock around purge
Date: Sat, 28 Feb 2026 12:27:16 -0500
Message-ID: <20260228173244.1509663-524-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220602-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.freedesktop.org:email,msgid.link:url,suse.de:email,collabora.com:email]
X-Rspamd-Queue-Id: D10021C6834
X-Rspamd-Action: no action

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 3f41307d589c2f25d556d47b165df808124cd0c4 ]

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
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patch.msgid.link/20251212160317.287409-6-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c     | 15 +++++++++++++++
 drivers/gpu/drm/tests/drm_gem_shmem_test.c |  4 +++-
 include/drm/drm_gem_shmem_helper.h         |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 1dfc9c4089587..0db3fe08a57b7 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -940,6 +940,21 @@ int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv)
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
index d639848e3c8ea..4b459f21acfd9 100644
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
index 3dd93e2df7092..8d56970d7eed1 100644
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
2.51.0


