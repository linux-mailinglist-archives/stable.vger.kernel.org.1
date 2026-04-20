Return-Path: <stable+bounces-239196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFp3HHZS5mkDuwEAu9opvQ
	(envelope-from <stable+bounces-239196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:21:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E442F579
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0842532CA152
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39364C77CC;
	Mon, 20 Apr 2026 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/pXVG8Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9566A4C77C0;
	Mon, 20 Apr 2026 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691988; cv=none; b=lnkVyu6JPcytmAImrMAPGtRRuNuTZxtBisVYPrFHmISDKY7Dj+keEmj3xClFVmLcEULh9JrL8Y+BCm1zivvVxXVGM/rBSGg4Jrio3luzN96YpO69VvoaK9sSjqefY+eTVydvKpoic2NQWvbfUKoW5UWcnwssAh2Ibq9icGotVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691988; c=relaxed/simple;
	bh=1WGq4LRQ0F/X8uRpfClHUYUe2fVIot6ENV9suzAP3HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A78W2lpQKUdgqlQTNzA4PhaUnkaVrB8CZrFGzUP2j4rTTVLHeVAd5nFWNI10t2hPz7bEPUi7QTpDYTjr9JmDKYn9hGe2kfNzrcxYRJVJ4pKYXGZMKZZwKIOAMk+F/7QDvs6AaAGD5ZrhzDSPacYgVyinLKDhfSTeeKkTI0REOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/pXVG8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAD5C2BCB4;
	Mon, 20 Apr 2026 13:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691988;
	bh=1WGq4LRQ0F/X8uRpfClHUYUe2fVIot6ENV9suzAP3HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/pXVG8QPZeQW0GWCBFd3TRUpkeGdnPXamOgAIHqfySY3+7UhXEe3+P5ntL1zee1s
	 L6vMYbB8S3vYfQwXmRjIMIfpkn42bXQla9EBX57Vbi0vUZWSXNZ5zDzhVBd8ppgKnz
	 qA68dOrRHlkpAku58D/yZQUT4aQF1iVghmnGzsqdHHjTpRzjZlGtTcyqjID4wbcVqa
	 Dt2e9zaEknDsTDgrsB/el4dA/BGhjnqCVpwidLcQznsNZM2E0gb695QURm8RlpkJ1x
	 macQu3xw/9dKZNpmT5ZhKXpdElroVsflnBkOgkfeI11RBW2S2/sTuitIVVsoJzGv6O
	 QYVR2NivXYGqw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Harry Yoo <harry@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>,
	someguy@effective-light.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] dma-debug: suppress cacheline overlap warning when arch has no DMA alignment requirement
Date: Mon, 20 Apr 2026 09:21:42 -0400
Message-ID: <20260420132314.1023554-308-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,samsung.com,effective-light.com,lists.linux.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239196-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: CA8E442F579
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

[ Upstream commit 3d48c9fd78dd0b1809669ec49c4d0997b8127512 ]

When CONFIG_DMA_API_DEBUG is enabled, the DMA debug infrastructure
tracks active mappings per cacheline and warns if two different DMA
mappings share the same cacheline ("cacheline tracking EEXIST,
overlapping mappings aren't supported").

On x86_64, ARCH_KMALLOC_MINALIGN defaults to 8, so small kmalloc
allocations (e.g. the 8-byte hub->buffer and hub->status in the USB
hub driver) frequently land in the same 64-byte cacheline.  When both
are DMA-mapped, this triggers a false positive warning.

This has been reported repeatedly since v5.14 (when the EEXIST check
was added) across various USB host controllers and devices including
xhci_hcd with USB hubs, USB audio devices, and USB ethernet adapters.

The cacheline overlap is only a real concern on architectures that
require DMA buffer alignment to cacheline boundaries (i.e. where
ARCH_DMA_MINALIGN >= L1_CACHE_BYTES).  On architectures like x86_64
where dma_get_cache_alignment() returns 1, the hardware is
cache-coherent and overlapping cacheline mappings are harmless.

Suppress the EEXIST warning when dma_get_cache_alignment() is less
than L1_CACHE_BYTES, indicating the architecture does not require
cacheline-aligned DMA buffers.

Verified with a kernel module reproducer that performs two kmalloc(8)
allocations back-to-back and DMA-maps both:

  Before: allocations share a cacheline, EEXIST fires within ~50 pairs
  After:  same cacheline pair found, but no warning emitted

Fixes: 2b4bbc6231d7 ("dma-debug: report -EEXIST errors in add_dma_entry")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215740
Suggested-by: Harry Yoo <harry@kernel.org>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20260327124156.24820-1-mikhail.v.gavrilov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 kernel/dma/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 43d6a996d7a78..596ea7abbda15 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -614,6 +614,7 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 	} else if (rc == -EEXIST &&
 		   !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 		   !(entry->is_cache_clean && overlap_cache_clean) &&
+		   dma_get_cache_alignment() >= L1_CACHE_BYTES &&
 		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
 		     is_swiotlb_active(entry->dev))) {
 		err_printk(entry->dev, entry,
-- 
2.53.0


