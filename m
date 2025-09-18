Return-Path: <stable+bounces-174487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E83B36365
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD631896DAE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73DA343214;
	Tue, 26 Aug 2025 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vEzJWets"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63819322A1E;
	Tue, 26 Aug 2025 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214522; cv=none; b=V6hyDyFjl8URqH8FEXr1MUm+otNZ8z8buKUC17IxT2cZlSAS6HFCX4lhIlHauNhmlKaUdijusxA9sAwYxA/pLVQVdxZCbO9QdwTaz5XddhK22xcpaWOhnMpU2P2zH2scU4Y0NeUh1G7eY3phuqdZpnTexL2exKf2qtVwmvpnKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214522; c=relaxed/simple;
	bh=+NcZmecy0kUWG56/viLpnzJqLLwN09pEaM7b0CQhxw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQ+uoDc1RtswaIztnKfBYhy5wyp+pINDeBvMMpG77P5xJyhn3WFHcV5L83E9KEoPHsHOT9BN2J+nGmVi6OVbTbLv30f5pzKzWXQSFAPV/vy4SRabVTl/LoGiI8YGfPf1MwJ+owdMZC0h2F2C4WCfr5GdUl7zptHitEaL81GyR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vEzJWets; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC93C113CF;
	Tue, 26 Aug 2025 13:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214522;
	bh=+NcZmecy0kUWG56/viLpnzJqLLwN09pEaM7b0CQhxw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vEzJWetsrC/U44cZCevtkJOzHp1EobekKxiw6FQTXPhG4d2FyCgrAu6knwHn/JjpT
	 DqmOOVR/J/Ot+XIYj4XzOIAOJoirx4jD/S3PqI8kge9l/os8Sn8epmeOpkCHV2Jzod
	 TYZSshLDFhF0yRMQQu+9+i8IE/FSdl+mNMtDzoEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 169/482] drm/ttm: Respect the shrinker core free target
Date: Tue, 26 Aug 2025 13:07:02 +0200
Message-ID: <20250826110934.986358578@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit eac21f8ebeb4f84d703cf41dc3f81d16fa9dc00a ]

Currently the TTM shrinker aborts shrinking as soon as it frees pages from
any of the page order pools and by doing so it can fail to respect the
freeing target which was configured by the shrinker core.

We use the wording "can fail" because the number of freed pages will
depend on the presence of pages in the pools and the order of the pools on
the LRU list. For example if there are no free pages in the high order
pools the shrinker core may require multiple passes over the TTM shrinker
before it will free the default target of 128 pages (assuming there are
free pages in the low order pools). This inefficiency can be compounded by
the pool LRU where multiple further calls into the TTM shrinker are
required to end up looking at the pool with pages.

Improve this by never freeing less than the shrinker core has requested.

At the same time we start reporting the number of scanned pages (freed in
this case), which prevents the core shrinker from giving up on the TTM
shrinker too soon and moving on.

v2:
 * Simplify loop logic. (Christian)
 * Improve commit message.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Link: https://lore.kernel.org/r/20250603112750.34997-2-tvrtko.ursulin@igalia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 393b97b4a991..a223208b83e0 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -592,7 +592,6 @@ void ttm_pool_fini(struct ttm_pool *pool)
 	synchronize_shrinkers();
 }
 
-/* As long as pages are available make sure to release at least one */
 static unsigned long ttm_pool_shrinker_scan(struct shrinker *shrink,
 					    struct shrink_control *sc)
 {
@@ -600,9 +599,12 @@ static unsigned long ttm_pool_shrinker_scan(struct shrinker *shrink,
 
 	do
 		num_freed += ttm_pool_shrink();
-	while (!num_freed && atomic_long_read(&allocated_pages));
+	while (num_freed < sc->nr_to_scan &&
+	       atomic_long_read(&allocated_pages));
 
-	return num_freed;
+	sc->nr_scanned = num_freed;
+
+	return num_freed ?: SHRINK_STOP;
 }
 
 /* Return the number of pages available or SHRINK_EMPTY if we have none */
-- 
2.39.5




