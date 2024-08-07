Return-Path: <stable+bounces-65704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9954394AB86
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3F51C209AD
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B593EA9A;
	Wed,  7 Aug 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K2VLXtVE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931584E04;
	Wed,  7 Aug 2024 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043183; cv=none; b=RY0enhFUVMcc5aLva0czi6awvPXUpxb+tSzCWeDbbJs3B5r4VeZ6Pkh2r6sUuaKVwiPi1zKpfwEohgxVPptc8BfDqYhhsoSnyDe12lX72y1LurbMa2nIkbEw0SNuMLItpFkRWqp8/Ak2BhmpnI7ap+E7ro4V2+Dm0ovYlwfWuuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043183; c=relaxed/simple;
	bh=+vFBXxipEjrFCJvLnzLYpc+dK3RoRklLUEviDbYb3T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHolDybl5VWUF5OlzD8DIM5iDqMguokpLgxngLrM+1yx0gNx4IGGvKXkJMZBfOWTUWM4OysgjGO7pOMK1rHWbhMKZWjt1gJPeyBxCaozcbvaXok/+gAv45Sez6gEPafLFXcaeJEv0qnf7n8sCmfhV60HX9rZidgOs6+mZU16lb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K2VLXtVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C274C32781;
	Wed,  7 Aug 2024 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043183;
	bh=+vFBXxipEjrFCJvLnzLYpc+dK3RoRklLUEviDbYb3T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K2VLXtVErXcgmD68XBukF08lzIMTVLRoZ7cEC6PUgyjKzgjjempH5dYnZgDMXZgS9
	 /ZkWYv6Cstqbehz9zIHT8c2aDzIJ91StHzSbzP7tI4D3Jw8JSWNPv23BzTxtm/5bOd
	 hYe8TR3+0EmBKoK6leEth6US3023Ksd5WrVqGpX4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Danilo Krummrich <dakr@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.10 104/123] nouveau: set placement to original placement on uvmm validate.
Date: Wed,  7 Aug 2024 17:00:23 +0200
Message-ID: <20240807150024.217976046@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
References: <20240807150020.790615758@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Airlie <airlied@redhat.com>

commit 9c685f61722d30a22d55bb8a48f7a48bb2e19bcc upstream.

When a buffer is evicted for memory pressure or TTM evict all,
the placement is set to the eviction domain, this means the
buffer never gets revalidated on the next exec to the correct domain.

I think this should be fine to use the initial domain from the
object creation, as least with VM_BIND this won't change after
init so this should be the correct answer.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: <stable@vger.kernel.org> # v6.6
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240515025542.2156774-1-airlied@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1803,6 +1803,7 @@ nouveau_uvmm_bo_validate(struct drm_gpuv
 {
 	struct nouveau_bo *nvbo = nouveau_gem_object(vm_bo->obj);
 
+	nouveau_bo_placement_set(nvbo, nvbo->valid_domains, 0);
 	return nouveau_bo_validate(nvbo, true, false);
 }
 



