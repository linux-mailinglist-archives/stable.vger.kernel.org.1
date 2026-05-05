Return-Path: <stable+bounces-243985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHOXOs+H+Wmx9QIAu9opvQ
	(envelope-from <stable+bounces-243985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 08:01:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BFC4C7116
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 08:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A330B300AEE5
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DCB3C278B;
	Tue,  5 May 2026 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Trql7OUU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682B13C2777
	for <stable@vger.kernel.org>; Tue,  5 May 2026 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960767; cv=none; b=XhmDbTsUPewmexmKFcliPZ+rBiO1RM+oeBFddUTXZwp9o2Hik8OTqm4QI7FLlTUV6OyZkWKXZv9zLUcQf62wZMT8ZnFA4sznq71O9HWND+n+BwKdOP/CaPit46G2xpNdU+6kvzYvxcmg+RFCAVyQHJ1us3FXnBBHh7kmk0R2euM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960767; c=relaxed/simple;
	bh=wVyt7nfeITp2MQHbtqceSjBnGKzAR+D2Doz4Cjba5ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShHPRT+KFk1VQqHqH6wFfiyL/lunoxs1SZKUyJ58rM0BDLR+OT8HdUxzIoppMCA1MswlnopaKWrEmwDUOKVByeF6BJPwVY7itZoxnG1mHhUE+bs7qvDKLA/plWv617PJ0OYZMJUW3eQLMsji973mrwumm4LZ3WRBiAv6ymPDTK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Trql7OUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90CDC2BCC7;
	Tue,  5 May 2026 05:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777960767;
	bh=wVyt7nfeITp2MQHbtqceSjBnGKzAR+D2Doz4Cjba5ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Trql7OUUwtYR9JwYjFtUYoflg8l/nLXm2WvYo3PTAIcqt0mccSAwAHFdvqw2KBC8n
	 vW/Vl0yOt59ShMQC6APE6IDsoZq7EE6s2vS29CSKojRezu9g7BBlwDlHH+jvggwn74
	 RkxVtoP9rCMQMJbjlnLAeRdpNu41r6OocHgE5+JVcC0Oonp/lhc2AHf3qKBDuoJ8Y/
	 3isiJXKdACxC8f8R9cduEmapALcEb2jYqUdHJHLytnfUAxLWmkFyPvR6Coi1fOESIU
	 JpVak0i8xBdhqnK5oJWQVHdsfogiTGv5oYITrvWCOJ6q6LF6qfE0Ummg12F6c0+hIg
	 PMIabFz7x2vWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] dma-mapping: add __dma_from_device_group_begin()/end()
Date: Tue,  5 May 2026 01:59:20 -0400
Message-ID: <20260505055921.224904-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505055921.224904-1-sashal@kernel.org>
References: <2026050156-defendant-fretful-734b@gregkh>
 <20260505055921.224904-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58BFC4C7116
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243985-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]

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
index 7331be3cdb53d..7c5fa3874f100 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -7,6 +7,7 @@
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/bug.h>
+#include <linux/cache.h>
 
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
@@ -585,6 +586,18 @@ static inline int dma_get_cache_alignment(void)
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


