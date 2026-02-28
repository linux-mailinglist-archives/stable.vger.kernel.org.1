Return-Path: <stable+bounces-220545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFGLEVFNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 980991C8260
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9B7B35D2A7E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D133D247C;
	Sat, 28 Feb 2026 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEZrIwLM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B13D2468;
	Sat, 28 Feb 2026 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300428; cv=none; b=s3QdmucI3zHq70NDbuNKEQCm7r4eEfCWq7nrSqescxi/uOEvgqlIqvVTA5zzOJhcX0CXhDJovhmvaRkVjDoqU4wYAqfZECwPwmA7ks+Jpv+g3Z5B6k4iDItJSjUkjXkDJqI5dvYdakRqECVJlSpbRueiN5jX0ChQNgA9yqKmpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300428; c=relaxed/simple;
	bh=Uir/nTXAjJY5kvnSsz0oWmIUwVbzB1gRI+aYvUOgwgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdIkCtHEkW7R9J7nOJ4/09bI+BMMFrFFcn0wCtnPIP3bzTAB/fLH8HiljoOeP3qdhWd6bhewItEZiCS+Jsq8/WP0Y2ISC71z9JB29SzKqeXNO06CxEjTRQj8yMDPqZO74xVtPUoA5LLJ6M6z4y9radj8K4te4j0hIoBqTRlT13k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEZrIwLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F311C116D0;
	Sat, 28 Feb 2026 17:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300428;
	bh=Uir/nTXAjJY5kvnSsz0oWmIUwVbzB1gRI+aYvUOgwgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gEZrIwLMV5zRfSiHxFJARNE2FRf3Iux8ViarxlEBPFMIXZjOj01H72oIUNXnoYyGr
	 WFHpinq341fpYNohzV9OQMDVJ5fIvGXb/KVM/R1fr29fBRXnXpCzyOYoTRVL6kACNw
	 C0tTey+/CU0mikgj4Wk1FS2x99xtNSmfEuNB3mVPj967Ke0Hu+98bHsIPdVPpS9xUT
	 XoBJHp/QFMCDQSXXldD6TGkzX5O9efF3Bm6pqFbDuNV5P2a1gt4pe+D7y5LGIWjfMU
	 3r4MOiql6hL+ibzA60iy44oCRbgkMkj+iqzIldnfSKoraTEeC1BhG7swak+9i4tDlp
	 KhyW6F/xmlqhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stian Halseth <stian@itx.no>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nathaniel Roach <nroach44@nroach44.id.au>,
	Han Gao <gaohan@iscas.ac.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 466/844] sparc: Fix page alignment in dma mapping
Date: Sat, 28 Feb 2026 12:26:19 -0500
Message-ID: <20260228173244.1509663-467-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220545-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 980991C8260
X-Rspamd-Action: no action

From: Stian Halseth <stian@itx.no>

[ Upstream commit d5b5e8149af0f5efed58653cbebf1cb3258ce49a ]

'phys' may include an offset within the page, while previously used
'base_paddr' was already page-aligned. This caused incorrect DMA mapping
in dma_4u_map_phys and dma_4v_map_phys.

Fix both functions by masking 'phys' with IO_PAGE_MASK, covering both
generic SPARC code and sun4v.

Fixes: 38c0d0ebf520 ("sparc: Use physical address DMA mapping")
Reported-by: Stian Halseth <stian@itx.no>
Closes: https://github.com/sparclinux/issues/issues/75
Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Stian Halseth <stian@itx.no>
Tested-by: Nathaniel Roach <nroach44@nroach44.id.au>
Tested-by: Han Gao <gaohan@iscas.ac.cn> # on SPARC Enterprise T5220
[mszyprow: adjusted commit description a bit]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20260218120056.3366-2-stian@itx.no
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/iommu.c     | 2 ++
 arch/sparc/kernel/pci_sun4v.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 46ef88bc9c26e..7613ab0ffb89d 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -312,6 +312,8 @@ static dma_addr_t dma_4u_map_phys(struct device *dev, phys_addr_t phys,
 	if (direction != DMA_TO_DEVICE)
 		iopte_protection |= IOPTE_WRITE;
 
+	phys &= IO_PAGE_MASK;
+
 	for (i = 0; i < npages; i++, base++, phys += IO_PAGE_SIZE)
 		iopte_val(*base) = iopte_protection | phys;
 
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 791f0a76665f6..58ca4148f86be 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -410,6 +410,8 @@ static dma_addr_t dma_4v_map_phys(struct device *dev, phys_addr_t phys,
 
 	iommu_batch_start(dev, prot, entry);
 
+	phys &= IO_PAGE_MASK;
+
 	for (i = 0; i < npages; i++, phys += IO_PAGE_SIZE) {
 		long err = iommu_batch_add(phys, mask);
 		if (unlikely(err < 0L))
-- 
2.51.0


