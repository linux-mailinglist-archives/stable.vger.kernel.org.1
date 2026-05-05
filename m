Return-Path: <stable+bounces-243938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMYlJ7g2+Wki6wIAu9opvQ
	(envelope-from <stable+bounces-243938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 02:15:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 205754C52CF
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 02:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1BF63020A58
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 00:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A73217648;
	Tue,  5 May 2026 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNCmr+PL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8BC1E1A3D
	for <stable@vger.kernel.org>; Tue,  5 May 2026 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940127; cv=none; b=YI7CMVAxSMX0ix1SkaW3KRf/hmyPNr+Oanhp2XSGx1flXxtak1D4VrEVhnFQDwugkl64CAeG1u2fGQGgVkzpUqMio+4xhA/x8gdXoszJm09Hy2dNSov33MTw4fYlujnq4+6GPqpiVTFU/pIo6J6MawYLWp6KDL5ul/MBtIkK/Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940127; c=relaxed/simple;
	bh=HLL9ku8m3uPy7sS0RnzhtHIey5up0W1P9wBMKGbRuWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciQntFbdLb+6j1rhuYtWGMl0PKGXSAMIpyOnRxQqRRwUZZOEJlQWqa14IrtsYmeiWGK4qpAZAuU+sejJuJw46g+t2guZ2WxU/Z/336oZ7a2NpMu9tUf0Ya+MLwbdC5V7hySRIJI4B8TUSR8pD4qMCm+rGct2uZeUPE5D4irMulw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNCmr+PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751D8C2BCB8;
	Tue,  5 May 2026 00:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777940126;
	bh=HLL9ku8m3uPy7sS0RnzhtHIey5up0W1P9wBMKGbRuWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNCmr+PLDZU9ddPiQNd5Cy5lnmAvmVtfG4jHnwkQ5BFCNdIaZGAjvmi5PwuvdGK1p
	 ZXFTkCb46PNicHOmLIBAhLkobcIUmiMfg5lEMJh4u4AHj6U41qFGEyEO5iz95K0J64
	 51okuAVsbl/33RFF29r+TBhFzfIxU6lGUC6IET0xk/W8ToDZL+oKyZadZC6U2EmnMP
	 cHBymT5zbMdEt9UKXeLmzXTqjyG7CtmxYW7m9fIMgXrAiAG62qHh5zJU9gkzJQqc7t
	 zDeRAtKa+UJNdZJF5aiqj8P443F5JrY4Ca/mRBbPzrU4WWO3mEB9Qz/SAZXy+gTJK8
	 pIA96RQ5sJ60Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] dma-mapping: add __dma_from_device_group_begin()/end()
Date: Mon,  4 May 2026 20:15:21 -0400
Message-ID: <20260505001522.124823-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050159-extinct-precision-0d22@gregkh>
References: <2026050159-extinct-precision-0d22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 205754C52CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243938-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,samsung.com:email]

From: "Michael S. Tsirkin" <mst@redhat.com>

[ Upstream commit ca085faabb42c31ee204235facc5a430cb9e78a9 ]

When a structure contains a buffer that DMA writes to alongside fields
that the CPU writes to, cache line sharing between the DMA buffer and
CPU-written fields can cause data corruption on non-cache-coherent
platforms.

Add __dma_from_device_group_begin()/end() annotations to ensure proper
alignment to prevent this:

struct my_device {
	spinlock_t lock1;
	__dma_from_device_group_begin();
	char dma_buffer1[16];
	char dma_buffer2[16];
	__dma_from_device_group_end();
	spinlock_t lock2;
};

Message-ID: <19163086d5e4704c316f18f6da06bc1c72968904.1767601130.git.mst@redhat.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Stable-dep-of: 3023c050af36 ("hwmon: (powerz) Avoid cacheline sharing for DMA buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/dma-mapping.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 3e63046b899bc..f46a0848cb247 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -7,6 +7,7 @@
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/bug.h>
+#include <linux/cache.h>
 
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
@@ -710,6 +711,18 @@ static inline int dma_get_cache_alignment(void)
 }
 #endif
 
+#ifdef ARCH_HAS_DMA_MINALIGN
+#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
+#else
+#define ____dma_from_device_aligned
+#endif
+/* Mark start of DMA buffer */
+#define __dma_from_device_group_begin(GROUP)			\
+	__cacheline_group_begin(GROUP) ____dma_from_device_aligned
+/* Mark end of DMA buffer */
+#define __dma_from_device_group_end(GROUP)			\
+	__cacheline_group_end(GROUP) ____dma_from_device_aligned
+
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
-- 
2.53.0


