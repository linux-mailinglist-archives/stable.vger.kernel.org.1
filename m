Return-Path: <stable+bounces-36392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B20F389BD62
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C54528311C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3195D90B;
	Mon,  8 Apr 2024 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeUWNnbv"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7295BAF0
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572672; cv=none; b=EK3PhAjZuFjs+ihYuuyaEtrLnx/eOHX5yqga7nPOpOghQfm4mD+O+OH7rtMrZF0NKTvXC8iZrDJnCrrvo0TRXMZO4N9t1HShUzzvGLQ4IiFl3xbyM/nglCpEZRd93BWZ7jAcS7R/jbbmC4NSgTbJ5gytTr5FcqP6+vsxdfIB398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572672; c=relaxed/simple;
	bh=Tl5QhODOeVdDZv9sZ6ix4ouVPJAOySQ26WnztsFVbl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laPtk0vAreNv/4zd7zmq/Mcg9imbkWMxMQpq7dreEbgF2qtqKVd+1awxHTW8qxk5ZiPUjwphhrorVRjOEdX5VdZMdnLMRtIkBKRnduRuhEpygx5KlGhDsz8zGpf/+ZggPKUqipyt/IC6wK7SwZkJCSJ0uDaFAbuzsgCipJVcy50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OeUWNnbv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712572670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nW2pKvwGTZg6E4DTgFqw9UH7euxhi+itw2Bw0XJf1kY=;
	b=OeUWNnbvj1HGJ9rc+Ys9jKZBdpeGkpALTuWjgCBiOBdtUXB/PhBtEPSlReR4vMFEucOg/q
	3Aeo4yFAfTXJu9uU+Mj4cyBoQoGTrjyQI/U2RaoE7TQiorEqdBg/xyEnPJwYUVW4xj67Vm
	HqbSo/dil+sPARlolgjDngbPYHiP+Fw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-L1laYOePNKGxYwODNG67sA-1; Mon, 08 Apr 2024 06:37:46 -0400
X-MC-Unique: L1laYOePNKGxYwODNG67sA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A22880021A;
	Mon,  8 Apr 2024 10:37:46 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7469B40F178;
	Mon,  8 Apr 2024 10:37:44 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 5.15.y] mm/secretmem: fix GUP-fast succeeding on secretmem folios
Date: Mon,  8 Apr 2024 12:37:39 +0200
Message-ID: <20240408103739.100897-1-david@redhat.com>
In-Reply-To: <2024040823-spilt-marsupial-8d2f@gregkh>
References: <2024040823-spilt-marsupial-8d2f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

folio_is_secretmem() currently relies on secretmem folios being LRU
folios, to save some cycles.

However, folios might reside in a folio batch without the LRU flag set, or
temporarily have their LRU flag cleared.  Consequently, the LRU flag is
unreliable for this purpose.

In particular, this is the case when secretmem_fault() allocates a fresh
page and calls filemap_add_folio()->folio_add_lru().  The folio might be
added to the per-cpu folio batch and won't get the LRU flag set until the
batch was drained using e.g., lru_add_drain().

Consequently, folio_is_secretmem() might not detect secretmem folios and
GUP-fast can succeed in grabbing a secretmem folio, crashing the kernel
when we would later try reading/writing to the folio, because the folio
has been unmapped from the directmap.

Fix it by removing that unreliable check.

Link: https://lkml.kernel.org/r/20240326143210.291116-2-david@redhat.com
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/lkml/CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com/
Debugged-by: Miklos Szeredi <miklos@szeredi.hu>
Tested-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 65291dcfcf8936e1b23cfd7718fdfde7cfaf7706)
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/secretmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index 988528b5da43..48ffe325184c 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -14,10 +14,10 @@ static inline bool page_is_secretmem(struct page *page)
 	 * Using page_mapping() is quite slow because of the actual call
 	 * instruction and repeated compound_head(page) inside the
 	 * page_mapping() function.
-	 * We know that secretmem pages are not compound and LRU so we can
+	 * We know that secretmem pages are not compound, so we can
 	 * save a couple of cycles here.
 	 */
-	if (PageCompound(page) || !PageLRU(page))
+	if (PageCompound(page))
 		return false;
 
 	mapping = (struct address_space *)
-- 
2.44.0


