Return-Path: <stable+bounces-253687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOlOLLHPD2rHPwYAu9opvQ
	(envelope-from <stable+bounces-253687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 05:38:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9355AE5DC
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 05:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2DFC3019521
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 03:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA5328850D;
	Fri, 22 May 2026 03:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="XAAerBj4"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E23438BE;
	Fri, 22 May 2026 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779421097; cv=none; b=D1guUe8NuheQSoNVljBgwKoORD17s0zxVJhRp5L13eX5yZ0c827PP6qJ5Tl4un04Cg1mO1VOVOAVDe+VYUNjuONhH49NWfW9sXnWYO9JEQK90S12h/evrInFySVkYTjeUXTKoJdeyJCCe7QChHf/r3FWcn1VzyCyaPe1mW98R/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779421097; c=relaxed/simple;
	bh=qc2fMa6n9sD9Hhbu80rmC7L/gSX83lEikgoOFmfmJS8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SymV97MV4sB2KBOAF6eol9UVb7vbXYKeVLazJe+T0MQJ8mPBkNS6zIpz6j6IKCM+WMSB80iPLpTMiWIEXvKO5V6dsNGtj4M0gPdr4XiUXHzvhUCVH0mt189YaMIdqa26pG5q250xm5ubqSDBOHQ9GTGhHryFAVtTzFdkllRhjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=XAAerBj4; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3f63bb888;
	Fri, 22 May 2026 11:32:57 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] drm/radeon: Use kvfree instead of kfree in radeon_gpu_reset
Date: Fri, 22 May 2026 11:32:54 +0800
Message-Id: <20260522033254.3602281-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e4dbe4a6e03a2kunma43dd79261302
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBlJVhpIHh8ZS0pPH0hKHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=XAAerBj4UO150YsFWbPnbkZhMrbQTXJwizec3Wkq69Ho74iOHFV0p5Xd291/8vm5XadLKLeclBN3AsIgvGralV4mf6hFPuRPjFNkVxbLfdNy5+HNEMfGgL2+qsfJiJ4eL8kg7X6vxQu7ts+RscOBqJ4kJGuOdxaNxWnCyIb5ez8=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=t85wgIYDJDkRWKpC2Gn2UjV3gwyPjPlbrb7Fn29A06U=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,seu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253687-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:dkim]
X-Rspamd-Queue-Id: 2B9355AE5DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

radeon_ring_backup() internally allocates ring_data buffers using
kvmalloc_array(), which may use vmalloc() for large allocations. Using
kfree() to release vmalloc-backed ring_data buffers in
radeon_gpu_reset() will lead to memory corruption.

Use kvfree() to safely handle both kmalloc and vmalloc allocations.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc3.

Runtime validation was not attempted because a targeted reproducer for
this GPU reset error path was not available. Compile-tested only.

Fixes: 2098105ec65c ("drm: drop drm_[cm]alloc* helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/gpu/drm/radeon/radeon_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 705c012fcf9e..1f0f0d0eb673 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1800,7 +1800,7 @@ int radeon_gpu_reset(struct radeon_device *rdev)
 					    ring_sizes[i], ring_data[i]);
 		} else {
 			radeon_fence_driver_force_completion(rdev, i);
-			kfree(ring_data[i]);
+			kvfree(ring_data[i]);
 		}
 	}
 
-- 
2.34.1


