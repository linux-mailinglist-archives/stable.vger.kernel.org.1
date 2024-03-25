Return-Path: <stable+bounces-32196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6015388A812
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 17:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8761D1C62737
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 16:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13412EBD6;
	Mon, 25 Mar 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8usXHRi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4912EBDD
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374094; cv=none; b=gtvRHLJn2URdMwhKN/im5a2jjb3j/NEd2aCduaZRkMa0VUDiWVKnJiRxhTPFqaG505JJMAhrnG7toc1WEnxH65VgM6FybdxlMKLd5a8qhh4glfLAv6BMFUDXbHsYg9HzvQNnNq1/6Fw8JyF8JWDupb3lAgYfHbNrxjj3FodwDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374094; c=relaxed/simple;
	bh=PiNEWr5x90esMmfh7ZHofO9+fLGzeXqEHD3NoBMXM3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLciCQSxHxO37T3i0B2TU9QCRTL8hiL7brf6DulsUlBGKi5eGLmJgOMf4bE0E+heDQm0LWJdrZfMclCsxw+Yu4pKwRboYPX2zKafY5kBuXtunmrtBBI3c9pRKqfMmVH/7E3X5/ryhhHkt87LoywSCTfPJZaVJrc9BxsbUxyh7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8usXHRi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711374091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIOwlwxzzcSMslwXLrjLWmaoHhvyTmqwx/xJnqLqn6Y=;
	b=i8usXHRiutGSrxgWoIYw8wHsRLmDdT1h/SB8GATI/QZOyNxElDILwUP0gAkQLncAH9Bnru
	glUgUBNWoZN4csFdhzLuSrXDNCs8QuFXMEHww466KSJjJCEz4cm6jToe8gggYSnKq4Ba0A
	mvdCQnbuKUThmYxToNncQN+f8nIsBVc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-beZWhhHSNDqBQcS9cJvtwA-1; Mon,
 25 Mar 2024 09:41:29 -0400
X-MC-Unique: beZWhhHSNDqBQcS9cJvtwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6DE438035AB;
	Mon, 25 Mar 2024 13:41:28 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.143])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AAFEF2166B5D;
	Mon, 25 Mar 2024 13:41:25 +0000 (UTC)
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
Subject: [PATCH v1 1/3] mm/secretmem: fix GUP-fast succeeding on secretmem folios
Date: Mon, 25 Mar 2024 14:41:12 +0100
Message-ID: <20240325134114.257544-2-david@redhat.com>
In-Reply-To: <20240325134114.257544-1-david@redhat.com>
References: <20240325134114.257544-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

folio_is_secretmem() states that secretmem folios cannot be LRU folios:
so we may only exit early if we find an LRU folio. Yet, we exit early if
we find a folio that is not a secretmem folio.

Consequently, folio_is_secretmem() fails to detect secretmem folios and,
therefore, we can succeed in grabbing a secretmem folio during GUP-fast,
crashing the kernel when we later try reading/writing to the folio, because
the folio has been unmapped from the directmap.

Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/lkml/CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com/
Debugged-by: Miklos Szeredi <miklos@szeredi.hu>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/secretmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index 35f3a4a8ceb1..6996f1f53f14 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -16,7 +16,7 @@ static inline bool folio_is_secretmem(struct folio *folio)
 	 * We know that secretmem pages are not compound and LRU so we can
 	 * save a couple of cycles here.
 	 */
-	if (folio_test_large(folio) || !folio_test_lru(folio))
+	if (folio_test_large(folio) || folio_test_lru(folio))
 		return false;
 
 	mapping = (struct address_space *)
-- 
2.43.2


