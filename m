Return-Path: <stable+bounces-126055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9AFA6FEB7
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F339219A1F92
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6951D28134D;
	Tue, 25 Mar 2025 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yNgzU4Cu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24424281343;
	Tue, 25 Mar 2025 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905517; cv=none; b=Aq9gJantie5qPDYM8JN5JSkPTyj82ZcJTJPkwqwOyeQL1uYdod3NhpdUwoiXbOtdhuXHQTCuska3NOq4Fh0Wj0+IpN4ylwdvzaqX06viQ9pjVv5pYgc9Lu5OoK0F/P7lM01P7PYQnab5sW74wPkKcNbLL7iZSbuJjRnE2JGrGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905517; c=relaxed/simple;
	bh=A7xboqGXZT48vD00SuwEPTNnlf5P6JcQbpkCdfJ+jho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRLdojN5YNj4lT7cjNgAnx0fZt4CaEzrF7DCbrq4hrK8HY36PDbNSX1qBIV+DrnZNDouTZPWpGa6WZjQ7SmtS63pPCR0/yDLfwTHEDJQCoaZBbh3H/gowagOVeXHi8KRB9ZTwUCakMuCHZ2hZfeEqsgDkTHwhslI1UWJSdNTXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yNgzU4Cu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B7CC4CEED;
	Tue, 25 Mar 2025 12:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742905517;
	bh=A7xboqGXZT48vD00SuwEPTNnlf5P6JcQbpkCdfJ+jho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yNgzU4CuINsJ6eJNchxp7nhTQ2yLb+dohsS/uEa+Z7H1+evpIa7MR1O6D4+ImpBB0
	 Yl5s0klz+7NsbnU3xxDgEuObbkLoMecrpBO6Doej4hkE63AaQciWMm5K2mmU7jvs26
	 D+VJKyxhA7LXJwZJQO0FQYMDtpAzTYUJcu7NgAIY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 018/198] Drivers: hv: vmbus: Dont release fb_mmio resource in vmbus_free_mmio()
Date: Tue, 25 Mar 2025 08:19:40 -0400
Message-ID: <20250325122157.118159038@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
References: <20250325122156.633329074@linuxfoundation.org>
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
index a2191bc5c1535..dfbfdbf9cbd72 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2409,12 +2409,25 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
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




