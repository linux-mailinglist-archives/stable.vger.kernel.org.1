Return-Path: <stable+bounces-139007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2368AA3DA3
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573A316F165
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 00:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A4029372A;
	Tue, 29 Apr 2025 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKy73oKd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5DA2DAF93;
	Tue, 29 Apr 2025 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970708; cv=none; b=chM7S5+a+tnxizdq2u8c7DIj9nqL80q+IBPH6K35lgyut/70tcrvs4teOkdbYl0AziI4Ax5ESGdV/iyf1emQNaOgZj4O5BBT4x40Y08zaqBKi9gF3u+Cv3LXRHlphRCY28U8/Dho1Wotrun4RJnpg4aGpW/xgkvZsm2c42mXXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970708; c=relaxed/simple;
	bh=2hhM63m6Ix9ZtRt71NCJYFUVpCIBG/ABtk15UHjrBVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8bWmpzCa+dl8F5wE1rtRJZXSVPE9HlcdeBg2DWMDE2GV1vDLStlBayBwO/5+q3u98qP9gv5ygt0AM9/uaXN3siuslVzV2pB5eLbjPK7n+rzbSvToyCLV8R9xA9HNL14SjppVbaRO5P5d/81NwibpqgE5SYpeqEmeOhUUWc3WAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKy73oKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3891DC4CEEB;
	Tue, 29 Apr 2025 23:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970708;
	bh=2hhM63m6Ix9ZtRt71NCJYFUVpCIBG/ABtk15UHjrBVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKy73oKd+lBdzHnGS+HEfJkVffjAz7HDAqNnMlbC2pkC7bDWuM9CmeqaNo5JP36qY
	 nPKgQwdRcG32o5fYnTbTNdB1DvnqQRjXIBUKudOj8wYLUh0Gir9KzQTlBGSAAykaRr
	 K4wDNKBi85tG5Q3a5cSeBk7zz6CLGVl5fU6QNavEGkXRRKDOIWT5eecugiaWjYsdmH
	 kRR0DAGiJ+Fr2sCOonVxeb3h91gupDVsBM1bA5OxFNw10UvMJhdtTemR/ZHn04A3fQ
	 5nq7Y307kMSsU9bynMdu0W4vbCBDC6Wt3AOdpkBWGU9qa7rC2e2yONgbmi/5qjJdmP
	 IpWb/NlxpeUYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Balbir Singh <balbirs@nvidia.com>,
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
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 12/37] dma/mapping.c: dev_dbg support for dma_addressing_limited
Date: Tue, 29 Apr 2025 19:50:57 -0400
Message-Id: <20250429235122.537321-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
Content-Transfer-Encoding: 8bit

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


