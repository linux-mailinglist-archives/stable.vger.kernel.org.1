Return-Path: <stable+bounces-220599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL/aCmtPo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:26:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 508181C8578
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E43B311B08B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9133E1F54;
	Sat, 28 Feb 2026 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekzoLZrs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59213E1F4B;
	Sat, 28 Feb 2026 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300482; cv=none; b=h+JJ6+G8w64pSor+EffyOJO7OORij2Wq/iqR/OgaaPCp3DzXXi0jfrFQQ7I6z/C2T5eVXlBIfMOesYmG+jlBOdCNVSZBVl+8ukCBxsLV0XJv0kDY+dAzhE3nmyEQuHfux6tdFPngyMmod3k2PH89RA8ngx9qW8/KvF+FDbO5Tgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300482; c=relaxed/simple;
	bh=felfZVWaTMWH2Djom74FA5Dp7sfnSOwZg8jUAQkEqq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQqtsy+aFv4uXYWnuWreWLY7sJzO2AN8q43rUiseHW4HCFM/UDFn98fEKp+/qpBAHWdDB8BWG9pdP8N5pmS+MzYcxm/16QD9WnNgzlegUa/0DT1/8hk7/g/U1dHxDAXwWo0VwvkJxaD7P+gUTwKYOPLcz79bsHNjoPPrScuXAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekzoLZrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0522BC19424;
	Sat, 28 Feb 2026 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300482;
	bh=felfZVWaTMWH2Djom74FA5Dp7sfnSOwZg8jUAQkEqq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekzoLZrskDG0s+Q5Y05jlY86xokE4O+E7hGQa2JtjWGz0JtshxGQueTxkQiAxD9xh
	 49RU1jKFlfgTJX3dwh76jePTu5W+cUAMyc5DzanWc2+0iZLWLrKPWcz8acItWtfm2V
	 lb6ECNGgRh/IpN2fxO3K75pwCjN69Z1MfsCr3HFj19107BUQParaWuf9G3a7j/lZiX
	 WEZMbbCdnDR6aEg8UdlvcSn70ck7ZHfaVaeLmWQFvun2S9hZ3RFepn/LGHVyMLLNu5
	 GyBRA0cwznEbv6/VIApntSCFDQ1cpeTcTjyuf0l9rxlt9y9tEZ7CtSztZfD1lNt2r+
	 LZyiBy2NgBqdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 520/844] drm/tests: shmem: Add clean-up action to unpin pages
Date: Sat, 28 Feb 2026 12:27:13 -0500
Message-ID: <20260228173244.1509663-521-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220599-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,collabora.com:email,suse.de:email]
X-Rspamd-Queue-Id: 508181C8578
X-Rspamd-Action: no action

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit b47b9ecef309459278eb52f02b50eefdeaac4f6d ]

Automatically unpin pages on cleanup. The test currently fails with
the error

[   58.246263] drm-kunit-mock-device drm_gem_shmem_test_get_sg_table.drm-kunit-mock-device: [drm] drm_WARN_ON(refcount_read(&shmem->pages_pin_count))

while cleaning up the GEM object. The pin count has to be zero at this
point.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: d586b535f144 ("drm/shmem-helper: Add and use pages_pin_count")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patch.msgid.link/20251212160317.287409-3-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tests/drm_gem_shmem_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index 872881ec9c30d..1d50bab51ef3f 100644
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
2.51.0


