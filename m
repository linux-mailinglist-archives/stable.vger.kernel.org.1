Return-Path: <stable+bounces-68759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B49533D4
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC871F27086
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D7117BEAD;
	Thu, 15 Aug 2024 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KHjacXmt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ADD1AC896;
	Thu, 15 Aug 2024 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731575; cv=none; b=gIHRrlDVRvQgUSR/2g6gUAtINAYdamhRPVSxORsKyorV5RWXWZYG9bjZFyB1NsQgSep6Dwp6KhkC0klhgHOIx3uFqP0XBOz9P8aVoGsC7pMmCZaIlp+yOc1h74UiYPQvAf8QKcVcqL66YqBeXHPRmo6qUArJyySrqG+m1bdjyeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731575; c=relaxed/simple;
	bh=cwbMljZC8LdXJwRMhd6WEpyNTK9735YULmfFgu+drnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVLF+KAK07clr1lcPPyHWHpxMCoNLaB1oKivkOvg4jJC88h9cpgwEQrlYBIEaqWVBN5kvnpvbtGAdKZ7I2mad4v11N81rEadsSKllm6QGmJUEAZlcISHs7Gpz+bRJ2Eu74z86StdJOGfIOtrcJ684AtVx2MCs6yRFnAlkkt7Nzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KHjacXmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3C6C32786;
	Thu, 15 Aug 2024 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731575;
	bh=cwbMljZC8LdXJwRMhd6WEpyNTK9735YULmfFgu+drnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHjacXmtWAX1noLFFfe/GOpxJVytojIZ0vhfqHw1IjK1fo+VyD8QlhN+dT07AhTPm
	 81uU2J8sfW9C/VXegGB4ErqJOflI2jr9wE7Lc66hf8vDsdqtJHuptwlJVoocHp1DW3
	 B3/pFwcNaI87z6hCgWZSBTIJD4vqjwqde7TpgK2M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Skeggs <bskeggs@nvidia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 173/259] drm/nouveau: prime: fix refcount underflow
Date: Thu, 15 Aug 2024 15:25:06 +0200
Message-ID: <20240815131909.457857417@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <dakr@kernel.org>

[ Upstream commit a9bf3efc33f1fbf88787a277f7349459283c9b95 ]

Calling nouveau_bo_ref() on a nouveau_bo without initializing it (and
hence the backing ttm_bo) leads to a refcount underflow.

Instead of calling nouveau_bo_ref() in the unwind path of
drm_gem_object_init(), clean things up manually.

Fixes: ab9ccb96a6e6 ("drm/nouveau: use prime helpers")
Reviewed-by: Ben Skeggs <bskeggs@nvidia.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240718165959.3983-2-dakr@kernel.org
(cherry picked from commit 1b93f3e89d03cfc576636e195466a0d728ad8de5)
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_prime.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_prime.c b/drivers/gpu/drm/nouveau/nouveau_prime.c
index 25cbe4ef383bd..ea7cd8aee68f6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_prime.c
+++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
@@ -83,7 +83,8 @@ struct drm_gem_object *nouveau_gem_prime_import_sg_table(struct drm_device *dev,
 	 * to the caller, instead of a normal nouveau_bo ttm reference. */
 	ret = drm_gem_object_init(dev, &nvbo->bo.base, size);
 	if (ret) {
-		nouveau_bo_ref(NULL, &nvbo);
+		drm_gem_object_release(&nvbo->bo.base);
+		kfree(nvbo);
 		obj = ERR_PTR(-ENOMEM);
 		goto unlock;
 	}
-- 
2.43.0




