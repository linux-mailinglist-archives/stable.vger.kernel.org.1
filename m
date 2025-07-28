Return-Path: <stable+bounces-164957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 109E9B13C8D
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAF5188BC9E
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E38A26E71A;
	Mon, 28 Jul 2025 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxJzPDn2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF996262FC8
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711192; cv=none; b=sexuzN3b4uvDfkQIJkInau0Rpf39sTuYP0U1du73QDHFvvcK52DFP+mioGGXMN/bLPpFT2WIhgIlfaJ12mIXQl2r7E9rSjOTXBrWttLYxHTRPIQQj28jtZ23GKY2ArgrKECHEdey0PZ2Z2YznL3JT89nssuO43ENUAzjKg6We5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711192; c=relaxed/simple;
	bh=MGQtVJZZWIKHzNg+D9IrbIvJaJoejjZJSmKqwCgWIps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JwMz/p91xngiq/Lm6OhNLlgdtcKMw5V33JLngt/pqz+JPmFeEcjxRK0YKVHG6EiqCtNyKkssfJzYLQ9XL87tMNa5dk4EtFVje6Zx1jSAJdWfMpCYzqkPqc/RebcImn1OWarNj2Gns0O/noQpZ0IVRyAqfYz8wFhP/b1zD6+Ac3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxJzPDn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6241AC4CEEF;
	Mon, 28 Jul 2025 13:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753711192;
	bh=MGQtVJZZWIKHzNg+D9IrbIvJaJoejjZJSmKqwCgWIps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxJzPDn2iv7A7thczohJyPsMd11zAKTqEPkPIrz/IQUSSPgV8mpSA0ejBNVSyUAOo
	 S41DIodkJRUTaspYzfHVjTNDkZn6XhPh7y/GL6XKNx3cD0RH6gKjavcNvGLJJse5hl
	 qV7GSnSEkdCmjN9bFOXod42UWbCKkEbqphgpLuPtMwvyvvKZ1qjXgVmojiQrvslvyH
	 HA+r3n7vBzZyppOnHnLKzn/kPV5NEVhsP4p/DSxtcTBigKLShdmuOvqodeeaddACIW
	 w+Mw4R66Mw8EQMJDOdbwjZM9qamUz15UAV7DjMAgxpFqg6U3DuRAifpQsWFUknuRDQ
	 QcOj6WiogK6aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Thomas Zimmermann <tzimmermann@suse.d>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 1/2] drm/shmem-helper: Remove obsoleted is_iomem test
Date: Mon, 28 Jul 2025 09:59:46 -0400
Message-Id: <20250728135947.2330347-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072830-reveler-drop-down-d571@gregkh>
References: <2025072830-reveler-drop-down-d571@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

[ Upstream commit eab10538073c3ff9e21c857bd462f79f2f6f7e00 ]

Everything that uses the mapped buffer should be agnostic to is_iomem.
The only reason for the is_iomem test is that we're setting shmem->vaddr
to the returned map->vaddr. Now that the shmem->vaddr code is gone, remove
the obsoleted is_iomem test to clean up the code.

Acked-by: Maxime Ripard <mripard@kernel.org>
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.d>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250322212608.40511-7-dmitry.osipenko@collabora.com
Stable-dep-of: 6d496e956998 ("Revert "drm/gem-shmem: Use dma_buf from GEM object instance"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index d99dee67353a..de197a932852 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -340,12 +340,6 @@ int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
 
 	if (drm_gem_is_imported(obj)) {
 		ret = dma_buf_vmap(obj->dma_buf, map);
-		if (!ret) {
-			if (drm_WARN_ON(obj->dev, map->is_iomem)) {
-				dma_buf_vunmap(obj->dma_buf, map);
-				return -EIO;
-			}
-		}
 	} else {
 		pgprot_t prot = PAGE_KERNEL;
 
-- 
2.39.5


