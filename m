Return-Path: <stable+bounces-117653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D6A3B6FA
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4D37A7072
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4231DEFF9;
	Wed, 19 Feb 2025 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vE0+oIV0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC11DF24B;
	Wed, 19 Feb 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955955; cv=none; b=Mr/5CsAqYytzRbjSWVUuVSOVv43uM24jCFJPflwOiFYljrjaJBgVZRyTeg+7BUJqOsFj8r8NBnwrhY5s6D4eU2yPFAZCElmvQT/OLwjFFhYSwDpZVQfzTZdsqf++Zb/38gU7E4Y42bX23cTlYKe5BRAkT4I156e/iiIbDq8hRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955955; c=relaxed/simple;
	bh=OzgjzxWMptRT/6VQgWAM5lqvOEXU+WFMszy4pijZ1Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCnkI4eOZ+Sg1NQAuC8TdkNh4DvPTlyZkbXkIdhgNheoyBzBVWTwogabaYh4B9qR7NOwJoIp+Lo86fYqqMBIsjECfv1FdSRc81zlgmrwYnazkpwAf0A02zyZym+St5XQPl8HkzgmU/92SwpA+h8MrYHy3UEnxXeeVg5kT4TwswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vE0+oIV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAD8C4CED1;
	Wed, 19 Feb 2025 09:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955954;
	bh=OzgjzxWMptRT/6VQgWAM5lqvOEXU+WFMszy4pijZ1Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vE0+oIV018FAH2eoEfuALUQd6vL+hUD18Q6HrT+rk+0hkJeilOayXe/57bMkT3lfA
	 fp29hzfV5DJ0zhntoTP5au5lNzi1dB3i4QfPYWyua7lWIw8QmUrvzdDBotC+KDNdTQ
	 vFIx4M5+YQRvHfZZ2UKWwJlpKD/TbPb1iNFXmq20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Lucas Stach <l.stach@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 016/578] drm/etnaviv: Fix page property being used for non writecombine buffers
Date: Wed, 19 Feb 2025 09:20:20 +0100
Message-ID: <20250219082653.530036426@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sui Jingfeng <sui.jingfeng@linux.dev>

[ Upstream commit 834f304192834d6f0941954f3277ae0ba11a9a86 ]

In the etnaviv_gem_vmap_impl() function, the driver vmap whatever buffers
with write combine(WC) page property, this is incorrect. Cached buffers
should be mapped with the cached page property and uncached buffers should
be mapped with the uncached page property.

Fixes: a0a5ab3e99b8 ("drm/etnaviv: call correct function when trying to vmap a DMABUF")
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 23d5058eca8d8..740680205e8d6 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -342,6 +342,7 @@ void *etnaviv_gem_vmap(struct drm_gem_object *obj)
 static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 {
 	struct page **pages;
+	pgprot_t prot;
 
 	lockdep_assert_held(&obj->lock);
 
@@ -349,8 +350,19 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 	if (IS_ERR(pages))
 		return NULL;
 
-	return vmap(pages, obj->base.size >> PAGE_SHIFT,
-			VM_MAP, pgprot_writecombine(PAGE_KERNEL));
+	switch (obj->flags & ETNA_BO_CACHE_MASK) {
+	case ETNA_BO_CACHED:
+		prot = PAGE_KERNEL;
+		break;
+	case ETNA_BO_UNCACHED:
+		prot = pgprot_noncached(PAGE_KERNEL);
+		break;
+	case ETNA_BO_WC:
+	default:
+		prot = pgprot_writecombine(PAGE_KERNEL);
+	}
+
+	return vmap(pages, obj->base.size >> PAGE_SHIFT, VM_MAP, prot);
 }
 
 static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
-- 
2.39.5




