Return-Path: <stable+bounces-210091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3B5D384E2
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 19:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2122300A35B
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823E534105D;
	Fri, 16 Jan 2026 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Jdrht576"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA62868B2;
	Fri, 16 Jan 2026 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589427; cv=none; b=Sn6cxeURHhn0UAhX0gRXFWbbtj730NhivYgFUo2+x5Ugen/PKY/ubVllEFa0jzeanCK0uLvS2s8GNh8NVn4Wv4daa7TfNsTrKFRUPETUvLmoZiEyBEV7ReZEaFoZB3woywqtA7vkEj9fydGSjnTgelBRaZj1JxK8DqwQX1mlPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589427; c=relaxed/simple;
	bh=7jwFSSSjGxKZppfWK4YKLXt+V3s2PudBMkLYMK3Q4ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNHsCqd+rH5/YS9rQKyNTYs052HdZaKFjIu1Ke6vFGWFLJ2TIzwtgzY/eCEnRJWc+V7O8uz/U0I4RXQDeLBXi9OsyBLC0B4t8PrTSCoCwigPTMFt790kaBOO8nDdekULCAmUs9k06GvjYeZCQ7AOopnMQ2GcwboQVPrqqfmYYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Jdrht576; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7498F406E9AB;
	Fri, 16 Jan 2026 18:50:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7498F406E9AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1768589413;
	bh=MUcGpwGAa2HHj5AwDRnfAQJfhTuI6RfA98FpDXOSu7o=;
	h=From:To:Cc:Subject:Date:From;
	b=Jdrht576bmc/E2N7PQrTT3WPk3QtAlXNLNEL7FuXujN4DR0tqgDS8pDrsYrgi9jh3
	 IYa6D1QEDIQ/GhfK65HQxeeyJhQ9Is2ZVG74QqVxTpoXMhOwob3UtheISp+36aWlFJ
	 VncOH8fRaAP4wZLsbSksiaPNAl4IxMAR8TCAdAXs=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Christian Koenig <christian.koenig@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Simon Richter <Simon.Richter@hogyros.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1] drm/ttm: fix up length check inside ttm_bo_vm_access()
Date: Fri, 16 Jan 2026 21:50:06 +0300
Message-ID: <20260116185007.1243557-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No upstream commit exists for this patch.

Commit 491adc6a0f99 ("drm/ttm: Avoid NULL pointer deref for evicted BOs")
added the validation of bo->resource but in the context of 6.1.y and older
stable kernels the pointer is still dereferenced before that check.

It's been unseen and manifests as a stable kernel's issue only because
another upstream commit e3c92eb4a84f ("drm/ttm: rework on ttm_resource to
use size_t type") refactored the code a bit and, specifically, changed
bo->resource->num_pages to bo->base.size at some places.  That commit is
rather intrusive and not handy to be backported to stable kernels so
implement the adaptive fix directly.

Since bo->resource->num_pages is calculated as PFN_UP(bo->base.size) in
older kernels as well, extract this single conversion from that commit.
Thus the problem indicated by commit 491adc6a0f99 ("drm/ttm: Avoid NULL
pointer deref for evicted BOs") would be actually fixed as intended.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: 491adc6a0f99 ("drm/ttm: Avoid NULL pointer deref for evicted BOs")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

Fresher stables starting from 6.6.y are not affected with this as they
have e3c92eb4a84f.

The backport of 491adc6a0f99 ("drm/ttm: Avoid NULL pointer deref for
evicted BOs") is currently in 5.10-5.15 queues and it may be fixed up in
place.

 drivers/gpu/drm/ttm/ttm_bo_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 1f543bd04fcf..51d0f5d23b1c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -412,7 +412,7 @@ int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
 		 << PAGE_SHIFT);
 	int ret;
 
-	if (len < 1 || (offset + len) >> PAGE_SHIFT > bo->resource->num_pages)
+	if (len < 1 || (offset + len) > bo->base.size)
 		return -EIO;
 
 	ret = ttm_bo_reserve(bo, true, false, NULL);
-- 
2.51.0


