Return-Path: <stable+bounces-221290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEjdJd6To2khHQUAu9opvQ
	(envelope-from <stable+bounces-221290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:18:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B0E1CA1FE
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADADB300D74D
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF49C248F73;
	Sun,  1 Mar 2026 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrSha0dq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BA123D2B1
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327899; cv=none; b=LWAmO3w0Sq78PQJ3QXI/P2HBsHmu6A4/uyZlQaTXoUuFwfSCoV5Aw1hdLll8OyeAQBc+x7ntW/dMGLUJvdcsm9tcOO13V6+mgNjXGfmuOaSC7quQORS74o7JiXPxO68Q3JWsENLly7XI73u2/9TBLGMCml6NqjfetYGKt7Cu+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327899; c=relaxed/simple;
	bh=lsIbGmiWoOru57VkZQvCM79Jvm739R72uwqiiqErrOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDteQjayWibcO+zQ2Q8a9FIDAumPToukLaVAzwX77+UKJ5fcecsZ1HFrydqjGESrVzoops4dwxMAHwigS/aRalLWL10aM28Gb+G070JfGclpv5dSVPKxyhxV4xcaTcRiFUGvutTVSCrXdIao6Ef9rwN/Gbft+ekc0kGMVZarMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrSha0dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3B3C19421;
	Sun,  1 Mar 2026 01:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327899;
	bh=lsIbGmiWoOru57VkZQvCM79Jvm739R72uwqiiqErrOg=;
	h=From:To:Cc:Subject:Date:From;
	b=BrSha0dqx/sSVtvMUc4QP3Oo7urQmNyRmEMrOxVRDwx3JOtgF710z5a6viBCrFykW
	 DChO/Gf1lSsYdn1QEiUsOTL4XNxbyKjMTdZtjxKAIddUuw3vpiQJlCsPVlYGeyUI5K
	 WUGQjko0MpMrItaKe1DkIZ7egS8QswVJ55K4HtbjrUzDP69PiZGP6OtJxJscfWQBjr
	 48tCJdC7vLLileWlY9GsXJ5syqP0nna4L5WZCgYz/BWLkB7X3n5glIUYLAWiGvOgt/
	 uBrhA5FG+kWzYNBr02XudKPI1EbZYOQHfGAbocbLYNneC5LstE3DCtgqc9I3an7ioi
	 KnDB+rmPZZI8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: FAILED: Patch "drm/tests: shmem: Swap names of export tests" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:18:17 -0500
Message-ID: <20260301011817.1672535-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221290-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 45B0E1CA1FE
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 89f23d42006630dd94c01a8c916f8c648141ad8e Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 12 Dec 2025 17:00:32 +0100
Subject: [PATCH] drm/tests: shmem: Swap names of export tests

GEM SHMEM has 2 helpers for exporting S/G tables. Swap the names of
the rsp. tests, so that each matches the helper it tests.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 93032ae634d4 ("drm/test: add a test suite for GEM objects backed by shmem")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patch.msgid.link/20251212160317.287409-2-tzimmermann@suse.de
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





