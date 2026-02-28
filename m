Return-Path: <stable+bounces-220598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPDUFqE+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:14:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD63A1C6BBD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68FB432FB852
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171293E1F38;
	Sat, 28 Feb 2026 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZX0vlMQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EC3E1F2A;
	Sat, 28 Feb 2026 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300481; cv=none; b=SJm4dITCD06sH9eBMB5FT6m71q5vgG4SHAA2VQhGIPbR7s4Q5YPhmM3ZyzVL3II/MU4VlJqcMVBWLQZcavUR9+ailAA6rqoNZzFoLCgOZ6WWdipTsf1uotfjqQ6Sfb3WGk9RaYAsNTdxJjcvrz+M24tX2weqhcHHIqNKzroezhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300481; c=relaxed/simple;
	bh=zyf+gpSoNDKeLFptf7hUU0gxUFJbg75B1a0fm/er4Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeJbWw/w5uGXisg210297drJIl/gJJVnYJealCc8RIZz9otw39k9ggjE+oqsix0RuVRRFo3EOxKGqr/0tAHtswH7NWSdAKfdgmUuHtGYp7i6q75LnAzDNS7YAETzw+adH+87mBb9HJkagoMwecnWqfkCDpqzR759vgvHXetHVgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZX0vlMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1321FC116D0;
	Sat, 28 Feb 2026 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300481;
	bh=zyf+gpSoNDKeLFptf7hUU0gxUFJbg75B1a0fm/er4Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZX0vlMQ2yt/2BC6R/t6rDgHPcI27zP4BiUt8oTlQ4H5giBWdLafokz/ZBCp4Rg6S
	 qKfppMUfkbStQdnLqIICuar16jqabYyouafVwas7qWfheoEXh2qu3SWS/mxmPohivP
	 JwhsEX14v3wMnSjG9mukR8z7vE7juXUdqhx2UcmDcEwekuxefj51nyKJJRGAc70vPz
	 gzAwROOJnGq5y+B0kQtonvELFGfY8JQIyHKWp82X/t+LAgRTS/gAublX6aEvmjIxJY
	 ukZ0iaVeMKOV2lsi33uRhLveQtATta1dM/bQeDbDoikXaFEIGgjnGoymAa6cz8rMnU
	 IRXJ/yv2+U+TA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 519/844] drm/tests: shmem: Swap names of export tests
Date: Sat, 28 Feb 2026 12:27:12 -0500
Message-ID: <20260228173244.1509663-520-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220598-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,collabora.com:email,lists.freedesktop.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD63A1C6BBD
X-Rspamd-Action: no action

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 89f23d42006630dd94c01a8c916f8c648141ad8e ]

GEM SHMEM has 2 helpers for exporting S/G tables. Swap the names of
the rsp. tests, so that each matches the helper it tests.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 93032ae634d4 ("drm/test: add a test suite for GEM objects backed by shmem")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patch.msgid.link/20251212160317.287409-2-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tests/drm_gem_shmem_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index 68f2c31623547..872881ec9c30d 100644
--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -194,7 +194,7 @@ static void drm_gem_shmem_test_vmap(struct kunit *test)
  * scatter/gather table large enough to accommodate the backing memory
  * is successfully exported.
  */
-static void drm_gem_shmem_test_get_pages_sgt(struct kunit *test)
+static void drm_gem_shmem_test_get_sg_table(struct kunit *test)
 {
 	struct drm_device *drm_dev = test->priv;
 	struct drm_gem_shmem_object *shmem;
@@ -236,7 +236,7 @@ static void drm_gem_shmem_test_get_pages_sgt(struct kunit *test)
  * backing pages are pinned and a scatter/gather table large enough to
  * accommodate the backing memory is successfully exported.
  */
-static void drm_gem_shmem_test_get_sg_table(struct kunit *test)
+static void drm_gem_shmem_test_get_pages_sgt(struct kunit *test)
 {
 	struct drm_device *drm_dev = test->priv;
 	struct drm_gem_shmem_object *shmem;
@@ -366,8 +366,8 @@ static struct kunit_case drm_gem_shmem_test_cases[] = {
 	KUNIT_CASE(drm_gem_shmem_test_obj_create_private),
 	KUNIT_CASE(drm_gem_shmem_test_pin_pages),
 	KUNIT_CASE(drm_gem_shmem_test_vmap),
-	KUNIT_CASE(drm_gem_shmem_test_get_pages_sgt),
 	KUNIT_CASE(drm_gem_shmem_test_get_sg_table),
+	KUNIT_CASE(drm_gem_shmem_test_get_pages_sgt),
 	KUNIT_CASE(drm_gem_shmem_test_madvise),
 	KUNIT_CASE(drm_gem_shmem_test_purge),
 	{}
-- 
2.51.0


