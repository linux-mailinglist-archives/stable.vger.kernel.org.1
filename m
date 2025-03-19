Return-Path: <stable+bounces-124989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA79FA68F67
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A6E3B79D6
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CE51C9B62;
	Wed, 19 Mar 2025 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T9P9zCYm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366301DED54;
	Wed, 19 Mar 2025 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394874; cv=none; b=OiICuHWg1uNIcg1Z0aSU9YBKrVfqOoXcisY204RUAe+8TrKspYLBo9QG3AhrDWJe/q8YVjw+0bvtU4apZsauiQ0ZctItNqFpc4IfsiBriOYp1L62GioreEb+RHnRQArGHViD9kk6n0cOLoc3YK6r5gw5E1Ok6dxeY3ITEmDyha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394874; c=relaxed/simple;
	bh=3uYHLPjmKLXebJAww9FgkSQ9HSQi9XKjKY0m7Tmy3O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLBFVtGjUQxVsVVSq2Bh4UVJK+0sljobho0juTf/q6WpC1RQWxcmzc2DgelzgUbsJMLIomHhnKlrXfv8e3cWU0kIRsgLVW5Bm98Q6lsMX/Mn1YiLOZn/wAM921X89nPzjt56pr6yqaXWQLxQrWHYI8woB6qhAOgDQH0a+kxTl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T9P9zCYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04068C4CEE8;
	Wed, 19 Mar 2025 14:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394874;
	bh=3uYHLPjmKLXebJAww9FgkSQ9HSQi9XKjKY0m7Tmy3O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9P9zCYm1UCnjivhnEsKgN0jrIt2/G9xLN/9PSy8VSvnARwWLmpJcjz5rVqLBOIyB
	 d+z8+SEZsN64mENKjD8yG7L1QaJ2LrCv3BTcX+Sl1+YHvwvWofjYXUoTqTAQliVnXh
	 N950XYBWZAK2XzOW6gHpr34IAS/hQYsnMgZ/P1LI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 030/241] Drivers: hv: vmbus: Dont release fb_mmio resource in vmbus_free_mmio()
Date: Wed, 19 Mar 2025 07:28:20 -0700
Message-ID: <20250319143028.460965594@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kelley <mhklinux@outlook.com>

[ Upstream commit 73fe9073c0cc28056cb9de0c8a516dac070f1d1f ]

The VMBus driver manages the MMIO space it owns via the hyperv_mmio
resource tree. Because the synthetic video framebuffer portion of the
MMIO space is initially setup by the Hyper-V host for each guest, the
VMBus driver does an early reserve of that portion of MMIO space in the
hyperv_mmio resource tree. It saves a pointer to that resource in
fb_mmio. When a VMBus driver requests MMIO space and passes "true"
for the "fb_overlap_ok" argument, the reserved framebuffer space is
used if possible. In that case it's not necessary to do another request
against the "shadow" hyperv_mmio resource tree because that resource
was already requested in the early reserve steps.

However, the vmbus_free_mmio() function currently does no special
handling for the fb_mmio resource. When a framebuffer device is
removed, or the driver is unbound, the current code for
vmbus_free_mmio() releases the reserved resource, leaving fb_mmio
pointing to memory that has been freed. If the same or another
driver is subsequently bound to the device, vmbus_allocate_mmio()
checks against fb_mmio, and potentially gets garbage. Furthermore
a second unbind operation produces this "nonexistent resource" error
because of the unbalanced behavior between vmbus_allocate_mmio() and
vmbus_free_mmio():

[   55.499643] resource: Trying to free nonexistent
			resource <0x00000000f0000000-0x00000000f07fffff>

Fix this by adding logic to vmbus_free_mmio() to recognize when
MMIO space in the fb_mmio reserved area would be released, and don't
release it. This filtering ensures the fb_mmio resource always exists,
and makes vmbus_free_mmio() more parallel with vmbus_allocate_mmio().

Fixes: be000f93e5d7 ("drivers:hv: Track allocations of children of hv_vmbus in private resource tree")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250310035208.275764-1-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20250310035208.275764-1-mhklinux@outlook.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/vmbus_drv.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 0f6cd44fff292..6e55a1a2613d3 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2262,12 +2262,25 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 	struct resource *iter;
 
 	mutex_lock(&hyperv_mmio_lock);
+
+	/*
+	 * If all bytes of the MMIO range to be released are within the
+	 * special case fb_mmio shadow region, skip releasing the shadow
+	 * region since no corresponding __request_region() was done
+	 * in vmbus_allocate_mmio().
+	 */
+	if (fb_mmio && start >= fb_mmio->start &&
+	    (start + size - 1 <= fb_mmio->end))
+		goto skip_shadow_release;
+
 	for (iter = hyperv_mmio; iter; iter = iter->sibling) {
 		if ((iter->start >= start + size) || (iter->end <= start))
 			continue;
 
 		__release_region(iter, start, size);
 	}
+
+skip_shadow_release:
 	release_mem_region(start, size);
 	mutex_unlock(&hyperv_mmio_lock);
 
-- 
2.39.5




