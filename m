Return-Path: <stable+bounces-32325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B85988C52F
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 15:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3349E1F342BC
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E610E13C3C6;
	Tue, 26 Mar 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYLjZs5n"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58178F6B
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463562; cv=none; b=hKKGaRKhRl1dIRHVMNFaWurbFmlc7TP+sEbSIsUBZGllrexjwLyQ9Tr7K/zK71Rf1X6WU6NXu1cw4BlpNDuK7P66GAxpIBV2Bxu/6yP4iSgSQ1WmWA1UPMc84brgzcjQ3ggcPT0d3QtDAxd1Fi0W2hnc1O0102eTbeV65EoYpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463562; c=relaxed/simple;
	bh=3BfObOBItLmXWASUgTdfkgiwVlyf/Sm1OH87Hu2jEv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFx2BO4OeZZmw0Xow/cdiK1JF2D23vcOo3YEs9YZRxBLdv9XJYbO4u/DJKjnKvqdEMEHIaVHRVExtMFr+0Xrydnb3fbkq8XnuhlCen/MKdewaHeJviEAVDtQBUnQeuJFShZmm/N3qLDuosqY7L9zAC1babPaQwTJLdxxCKzk2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYLjZs5n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711463559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCQ18XUYGXxAblag6bvSJIJrwTPD6Hhm3KxukBaiG2A=;
	b=DYLjZs5ne/eHCxw0GqeLeS1bdf8OiMhRlVhzxUK+SKVLARiRLACY7/j4IY43C0TsLws1hw
	mgFz9653whmLKfHuoBh9qtGKA/khsXBAoiw5gZU8TfU/ZdqVqdOm8G5evntLXImG1xRcke
	4Hdx2KeiaJLbXAmshHlEiHuvOrZBPSI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-SUIk7uSiPqOSHPDYataC4g-1; Tue,
 26 Mar 2024 10:32:38 -0400
X-MC-Unique: SUIk7uSiPqOSHPDYataC4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95BD23C0C889;
	Tue, 26 Mar 2024 14:32:37 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6784340C6CBE;
	Tue, 26 Mar 2024 14:32:34 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mm/secretmem: fix GUP-fast succeeding on secretmem folios
Date: Tue, 26 Mar 2024 15:32:08 +0100
Message-ID: <20240326143210.291116-2-david@redhat.com>
In-Reply-To: <20240326143210.291116-1-david@redhat.com>
References: <20240326143210.291116-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

folio_is_secretmem() currently relies on secretmem folios being LRU folios,
to save some cycles.

However, folios might reside in a folio batch without the LRU flag set, or
temporarily have their LRU flag cleared. Consequently, the LRU flag is
unreliable for this purpose.

In particular, this is the case when secretmem_fault() allocates a
fresh page and calls filemap_add_folio()->folio_add_lru(). The folio might
be added to the per-cpu folio batch and won't get the LRU flag set until
the batch was drained using e.g., lru_add_drain().

Consequently, folio_is_secretmem() might not detect secretmem folios
and GUP-fast can succeed in grabbing a secretmem folio, crashing the
kernel when we would later try reading/writing to the folio, because
the folio has been unmapped from the directmap.

Fix it by removing that unreliable check.

Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/lkml/CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com/
Debugged-by: Miklos Szeredi <miklos@szeredi.hu>
Tested-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/secretmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index 35f3a4a8ceb1..acf7e1a3f3de 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -13,10 +13,10 @@ static inline bool folio_is_secretmem(struct folio *folio)
 	/*
 	 * Using folio_mapping() is quite slow because of the actual call
 	 * instruction.
-	 * We know that secretmem pages are not compound and LRU so we can
+	 * We know that secretmem pages are not compound, so we can
 	 * save a couple of cycles here.
 	 */
-	if (folio_test_large(folio) || !folio_test_lru(folio))
+	if (folio_test_large(folio))
 		return false;
 
 	mapping = (struct address_space *)
-- 
2.43.2


