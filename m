Return-Path: <stable+bounces-46945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3F98D0BEA
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18929285AD2
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69A26A039;
	Mon, 27 May 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GtOwNoYn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FA917E90E;
	Mon, 27 May 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837260; cv=none; b=G9RilGO++UO9Rdn0Crunwmz5L5nGS/Uequ/VUqzSctE1HqWYm1tVrZHSu2rxL3QlorFeVshkf5s45E6JFZG3FTnHzzkLQ0q+Er3gNGxTsMMjmKtqG3FODLUYdkBJ9W43ZzH6oFZ8cD7WNpNQFF5hfqt7+lYVNyDp/yj19UtWuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837260; c=relaxed/simple;
	bh=nkNZpNxtSWn/yDmUoltT1sxPxx7WIIpqbVjZq2Pi+lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iq0OG+w5k0VINNzLmY62Jsv5CSgSTMzznrwTHWq3G+m+OAoxpLkh32NCMhUEP6+vK6YauMG6ZCUxzGpHNtRdi9xbv6h6qC+i9HxRXKY3EBDIkFi4GwD5t1tZuir4iziY4MoW7WkTgeqNcByQYUl+NQec9cuB2HWy+LGPveh+r2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GtOwNoYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AEAC2BBFC;
	Mon, 27 May 2024 19:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837260;
	bh=nkNZpNxtSWn/yDmUoltT1sxPxx7WIIpqbVjZq2Pi+lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GtOwNoYno+cxSwhwyuS1s4L1O3h0xgJjxs/jfevz53jXZSjHLgISxpAKvlnD4zrJO
	 gunwfdUKgsgsAA72xyFVOEwp5ZnW1je+EbRqJMPAYHN+ceJf8snZRz2GjjXnfGF8/h
	 ShLsab9spZEjpC0BkJw/APDP1+eLMouNy/a9GgOQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Duoming Zhou <duoming@zju.edu.cn>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 373/427] lib/test_hmm.c: handle src_pfns and dst_pfns allocation failure
Date: Mon, 27 May 2024 20:57:00 +0200
Message-ID: <20240527185634.272059402@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit c2af060d1c18beaec56351cf9c9bcbbc5af341a3 ]

The kcalloc() in dmirror_device_evict_chunk() will return null if the
physical memory has run out.  As a result, if src_pfns or dst_pfns is
dereferenced, the null pointer dereference bug will happen.

Moreover, the device is going away.  If the kcalloc() fails, the pages
mapping a chunk could not be evicted.  So add a __GFP_NOFAIL flag in
kcalloc().

Finally, as there is no need to have physically contiguous memory, Switch
kcalloc() to kvcalloc() in order to avoid failing allocations.

Link: https://lkml.kernel.org/r/20240312005905.9939-1-duoming@zju.edu.cn
Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Cc: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_hmm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 717dcb8301273..b823ba7cb6a15 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1226,8 +1226,8 @@ static void dmirror_device_evict_chunk(struct dmirror_chunk *chunk)
 	unsigned long *src_pfns;
 	unsigned long *dst_pfns;
 
-	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL);
-	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL);
+	src_pfns = kvcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | __GFP_NOFAIL);
+	dst_pfns = kvcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | __GFP_NOFAIL);
 
 	migrate_device_range(src_pfns, start_pfn, npages);
 	for (i = 0; i < npages; i++) {
@@ -1250,8 +1250,8 @@ static void dmirror_device_evict_chunk(struct dmirror_chunk *chunk)
 	}
 	migrate_device_pages(src_pfns, dst_pfns, npages);
 	migrate_device_finalize(src_pfns, dst_pfns, npages);
-	kfree(src_pfns);
-	kfree(dst_pfns);
+	kvfree(src_pfns);
+	kvfree(dst_pfns);
 }
 
 /* Removes free pages from the free list so they can't be re-allocated */
-- 
2.43.0




