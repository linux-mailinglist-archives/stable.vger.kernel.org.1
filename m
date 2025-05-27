Return-Path: <stable+bounces-146472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8ACAC534D
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD8407AA19B
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150FB27FD5D;
	Tue, 27 May 2025 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Unqkr5u8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF02827FD58;
	Tue, 27 May 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364324; cv=none; b=XTq0EGqeScvAoaCyefngwMH9NF1IX/SI7ITiXdbe+lu5TgiswBdV2h+sFgEnfxNAdUfZROxjp7Rgye5Trda3UeBlEEdcD3WE9qaVTjaroIjhIjpRX1He/yJEZiPeJLJ/rDSXEyKGehGR/vEeTyEXobB3hw5I8feK8jArX8fOw1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364324; c=relaxed/simple;
	bh=XxDJS6jL99qxG1FeDk3hYZWJCTNJUJEuTQf/bhlvyGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNafk65ToVDKOfn64vpunxOvG54cGeqh2t3iJG6tq4vGpfVpqB//DaZ1k+iYwyGWBqZ4RhlfqjaUCXGLzIsqSiEL6W1HEZveL1zSkKi/w0+4JB4N6pc8A7POUDEL+CMfYqXhTOMbYbWmxv1lHJFBFS2mxQFuCfK6oBu1rskIiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Unqkr5u8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AC4C4CEE9;
	Tue, 27 May 2025 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748364324;
	bh=XxDJS6jL99qxG1FeDk3hYZWJCTNJUJEuTQf/bhlvyGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Unqkr5u8oB+R9X0M3pwJ1KecgLtev7LgdHqlJyJ0ZHC8SANV6U2SLxR92r0JcaAEB
	 coWzc7yHL4xA2ZROL54T4klYkbqGUGSqip93J4eFjEChEQ1ZTAS+eb3/SHQ+BGlCyq
	 zI4h2NDQJTePuiwN0CmLnKct6/m6BMIyCMOl2pFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Christoph Hellwig <hch@infradead.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 020/626] dma/mapping.c: dev_dbg support for dma_addressing_limited
Date: Tue, 27 May 2025 18:18:33 +0200
Message-ID: <20250527162445.879790757@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Balbir Singh <balbirs@nvidia.com>

[ Upstream commit 2042c352e21d19eaf5f9e22fb6afce72293ef28c ]

In the debug and resolution of an issue involving forced use of bounce
buffers, 7170130e4c72 ("x86/mm/init: Handle the special case of device
private pages in add_pages(), to not increase max_pfn and trigger
dma_addressing_limited() bounce buffers"). It would have been easier
to debug the issue if dma_addressing_limited() had debug information
about the device not being able to address all of memory and thus forcing
all accesses through a bounce buffer. Please see[2]

Implement dev_dbg to debug the potential use of bounce buffers
when we hit the condition. When swiotlb is used,
dma_addressing_limited() is used to determine the size of maximum dma
buffer size in dma_direct_max_mapping_size(). The debug prints could be
triggered in that check as well (when enabled).

Link: https://lore.kernel.org/lkml/20250401000752.249348-1-balbirs@nvidia.com/ [1]
Link: https://lore.kernel.org/lkml/20250310112206.4168-1-spasswolf@web.de/ [2]

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>
Cc: Christoph Hellwig <hch@infradead.org>

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20250414113752.3298276-1-balbirs@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/mapping.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 864a1121bf086..f7366083b4d00 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -905,7 +905,7 @@ EXPORT_SYMBOL(dma_set_coherent_mask);
  * the system, else %false.  Lack of addressing bits is the prime reason for
  * bounce buffering, but might not be the only one.
  */
-bool dma_addressing_limited(struct device *dev)
+static bool __dma_addressing_limited(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -917,6 +917,15 @@ bool dma_addressing_limited(struct device *dev)
 		return false;
 	return !dma_direct_all_ram_mapped(dev);
 }
+
+bool dma_addressing_limited(struct device *dev)
+{
+	if (!__dma_addressing_limited(dev))
+		return false;
+
+	dev_dbg(dev, "device is DMA addressing limited\n");
+	return true;
+}
 EXPORT_SYMBOL_GPL(dma_addressing_limited);
 
 size_t dma_max_mapping_size(struct device *dev)
-- 
2.39.5




