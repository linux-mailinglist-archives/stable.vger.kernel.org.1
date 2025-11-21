Return-Path: <stable+bounces-195668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC1EC79580
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F926380056
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6ED33E366;
	Fri, 21 Nov 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SZD5Z4T9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896D3176E1;
	Fri, 21 Nov 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731324; cv=none; b=S+SYRrzKA2iZcyKIyoXpXN56CfRqUJj3MYyxck6zrRQjTsor8TL6p/2SyTG6MVfS4+vK+DtYtl7r/MOE6gmTpuru67cyuJCkc9UAJflUFLlNzatZZxTkiSDbdtblY2EdbvcwBnQipXJ6Q7Hz3w1u18BHwhfDT5w4lJvD36qZ3CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731324; c=relaxed/simple;
	bh=TLf4y0pdkawNAOuFJsP6O3yD+K3m1KAFiAuEeeKUyFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUK3WGzsrh3Uhh/fhN+Hx2AgWUf3/npe6JDbenU2wpMv4QgAA7sL8SjNZVerownvof6zhFKuC1boAvei6+FU15X6aa/rfe92hPwTEBG6d1z6GO6zhYdlqzdydaRWMnAP3L6PeZeVW2z6J0sstd6aBpPJNKDJ3H4mbfWHWNDddBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SZD5Z4T9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFE5C4CEF1;
	Fri, 21 Nov 2025 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763731324;
	bh=TLf4y0pdkawNAOuFJsP6O3yD+K3m1KAFiAuEeeKUyFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZD5Z4T90EPsvPXmogNVNTrciMkfm5qPZWSdd0FobejYdI5qc98kUvwFV0HCqUm07
	 dKCUKVLL7YlD7W9ETGty247Z7eLqnfa0t8VHjD/flrKJnBPK9B0xu448ChwI24iyOW
	 eMYwxVD29mm2h8v2Pdxq7hMzfLUixcZjXZwHoCZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Barry Song <baohua@kernel.org>,
	Qinxin Xia <xiaqinxin@huawei.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 6.17 169/247] dma-mapping: benchmark: Restore padding to ensure uABI remained consistent
Date: Fri, 21 Nov 2025 14:11:56 +0100
Message-ID: <20251121130200.785523551@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130154.587656062@linuxfoundation.org>
References: <20251121130154.587656062@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qinxin Xia <xiaqinxin@huawei.com>

commit 23ee8a2563a0f24cf4964685ced23c32be444ab8 upstream.

The padding field in the structure was previously reserved to
maintain a stable interface for potential new fields, ensuring
compatibility with user-space shared data structures.
However,it was accidentally removed by tiantao in a prior commit,
which may lead to incompatibility between user space and the kernel.

This patch reinstates the padding to restore the original structure
layout and preserve compatibility.

Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
Cc: stable@vger.kernel.org
Acked-by: Barry Song <baohua@kernel.org>
Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
Reported-by: Barry Song <baohua@kernel.org>
Closes: https://lore.kernel.org/lkml/CAGsJ_4waiZ2+NBJG+SCnbNk+nQ_ZF13_Q5FHJqZyxyJTcEop2A@mail.gmail.com/
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20251028120900.2265511-2-xiaqinxin@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/map_benchmark.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/map_benchmark.h
+++ b/include/linux/map_benchmark.h
@@ -27,5 +27,6 @@ struct map_benchmark {
 	__u32 dma_dir; /* DMA data direction */
 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
 	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
+	__u8 expansion[76]; /* For future use */
 };
 #endif /* _KERNEL_DMA_BENCHMARK_H */



