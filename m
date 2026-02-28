Return-Path: <stable+bounces-220935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCthIK5co2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:22:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E08B11C8F5E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A64E34984C0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF354508F2;
	Sat, 28 Feb 2026 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BebEBhlR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B4340A51;
	Sat, 28 Feb 2026 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301282; cv=none; b=tqfNoDtS/0VvP0103SJJRw6Akw33dbEXzA2dGKYbZkXx+3ZJqlZqlTQbe4U3Ki9PGH3WZHrn44BJU44joWGA2Kt1ycJcnMHchVkoS+QD8HRbk+Oui3riKfEokBJkaZMr36q5mss7lnSb6JrfLByKLhBwmxMTTkAHarCPpgmDbhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301282; c=relaxed/simple;
	bh=zyf+gpSoNDKeLFptf7hUU0gxUFJbg75B1a0fm/er4Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUr+I7Zy1BztQFHI+zdUaAgMw1PAF2Al/OmhOuj6QJ1OUMEWvbRyq1kPLEB4Nh8TuQjhWLrTw57RezvQTR4f3KneQjhM/yYwWgPA3Qdo+K3fDoVeC4VE5d0+D0aChmbJeOw7ERzJUdc7Xs1GgpuzlC0vB7yf0oQb3apY5B1BPlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BebEBhlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0850C116D0;
	Sat, 28 Feb 2026 17:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301282;
	bh=zyf+gpSoNDKeLFptf7hUU0gxUFJbg75B1a0fm/er4Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BebEBhlR8tEY/wx70W2yquRwuf/d+N8t1IJACOzkleeE64ITs5Is8iLLIVMhA9wa7
	 mLAgXdVwLliSb06YHtGem5ilKVy4ZKd4klMq5muOzTcf3plGNcakvOCg3TzolNdUja
	 73fO9B+bIVYNPTnvuI2+VJfKd/fsc1IxiJuoSsjwo7EivBU4fvGji4U4xkGHInzgx+
	 x/JNIPW3ixxJyaj9nOdqnrFELwKnFxRLFcNLT8hrCrhRkJMGkAnYaRoSUL6U8SRpsw
	 xvaL9ivlCeVuS0hr+zXmifBUCvNqUAsRUlAcobUBdBiy/q648kwIZ8h/masPuejZqq
	 WlupLo5Y0iOFw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 466/752] drm/tests: shmem: Swap names of export tests
Date: Sat, 28 Feb 2026 12:42:57 -0500
Message-ID: <20260228174750.1542406-466-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220935-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,suse.de:email,msgid.link:url,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: E08B11C8F5E
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


