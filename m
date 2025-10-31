Return-Path: <stable+bounces-191810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93ACC24F0A
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 13:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBC74609E9
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C67347FC5;
	Fri, 31 Oct 2025 12:10:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3114345726
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912615; cv=none; b=o/U2NPs4JOhnACf47E5rwQjk2auhgapooNxeA5fAGeqU5kiPn+8I8zFg2vwQAQXYLajgW6XmBF2g5+ux5Ooc/xRfW/VwXLTXAfCocdsYmTml13TupL5DX2NsT4pqcCeXekIBR7s731Dn0X6C80v9SRlJ0k8ufH4Q9zbBW2InBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912615; c=relaxed/simple;
	bh=lkAHTmhNMxqkX+eVSbbiNIZj9cWdHWyf6xYu3kI0alM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pI4lTora/cA+Lja5abwDPxfIPkGalArkri8nV3lFp33OasJLJKbpMWn0VRIBxHQib3bQcsNUjR1GVqcQC3uhxiNZeQSElaQ+gp6P/muBZFmvEVhEu62QMLir6tXnim5pzFYmaWF6fH0nGqTUc58fNgP+7QN2fl5NnCHcRZtqou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-294fb21b160so14032405ad.1
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 05:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761912613; x=1762517413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0WbfK5vwuoBUWDeRvrXFDT7iz9UNmzAdlRjdob6MPo=;
        b=aZ+X2sCs5AYD2Ci68sJcNcKYdAc1ZkkWgAMducV15+4OkBSwfZSVEnGJDa9PT73N62
         PRUxVexdqPGALwioEdgk/GJXOUCRlSrRjWQHdsE54SZ8dEklfQkrba3xkuAo4kUSvkyB
         0G0HZ2hjdaFUPAi7JrmPm1HuqfPsPj2T06bkHE9z9VjY75HsPITRq8TSqgh8ZLZGKCeV
         PrxMUSv6rX9xbRr+cozPW13IcHUJ5ccFiGeuPV5ZMbT3FcPQaNbYMNEWG6B9vp7TiZ9V
         2iKHmxyVvZcG8XcqFkWXkDUMA/hmK0/V+b33yhlsm38YOWJOY9CLWeGh12BnRbcHPDFD
         gKeA==
X-Forwarded-Encrypted: i=1; AJvYcCVwGyR9xnRMypzGCePpFmwgq3NewuI0qzWXTOj4Zde4dp2CZ+mal6dLNBQpkH3utHs4wHiRmBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt9xIp5G59vdhYeQ6ahiv7Luza3Zt55bY4zgGA1xh6X7OA61df
	WvwwhEvYyb7m4R+ogMvoAYDB20g0c0UrLNmDXyoU5Dj7NC0Cm7Kh47lf
X-Gm-Gg: ASbGncvmwaLF7VbrOkFrNwHqPtBmy+truH//tsT6dvHhwZljRwQzK63u0agmuJAHrO0
	u0dJ5Kwlv0PT+rNuOJbKF+xJIt93ppGi9GqUWs++v5dQHmqO3m+B9HEZUTRHnd7WP9Q1SGw0TgN
	rfm+FWDn9icDOe7WCrYfZ1quuxS400NpHJPRx1X9wtXGWxHiXV784JnoaCk/4ja6JA1ivvYX/Dl
	hRFj7g2wGZ3e465EjffpfJ9h6NkuchhxpsRtib2BPqkyZZvnwTqVoKlbuoDZqmL1uIUshIDE91k
	8fFq7X/ckmX7ghTYN5JyKYwmVDjv8hIqSEonQe8UavpjFaVF+04fc0UrSUZYC7fOLflYoAsDaY7
	6672cyBuSpgYeC392jRHz5ynz6mc/NJiLTVB1otu6lH0at+kGgZGxsbNrDvZfknEhsCrWwPR5aa
	VmnQ7ar/AUM+i5k1Sy45PksBx1PQ==
X-Google-Smtp-Source: AGHT+IFkZYYrPO9da+1rqdpxHxQzVGAbYeTTm9iNmfhwPCVX2eqm9vtdFUdqrf7DEDE/y6nY5qWI1A==
X-Received: by 2002:a17:902:8ec9:b0:269:8059:83ab with SMTP id d9443c01a7336-2951a50e59amr30879555ad.51.1761912612853;
        Fri, 31 Oct 2025 05:10:12 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269b95bdsm21683055ad.93.2025.10.31.05.10.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Oct 2025 05:10:12 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	rppt@kernel.org,
	willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	big-sleep-vuln-reports@google.com,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v2 1/1] mm/secretmem: fix use-after-free race in fault handler
Date: Fri, 31 Oct 2025 20:09:55 +0800
Message-ID: <20251031120955.92116-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When a page fault occurs in a secret memory file created with
`memfd_secret(2)`, the kernel will allocate a new folio for it, mark the
underlying page as not-present in the direct map, and add it to the file
mapping.

If two tasks cause a fault in the same page concurrently, both could end
up allocating a folio and removing the page from the direct map, but only
one would succeed in adding the folio to the file mapping. The task that
failed undoes the effects of its attempt by (a) freeing the folio again
and (b) putting the page back into the direct map. However, by doing
these two operations in this order, the page becomes available to the
allocator again before it is placed back in the direct mapping.

If another task attempts to allocate the page between (a) and (b), and
the kernel tries to access it via the direct map, it would result in a
supervisor not-present page fault.

Fix the ordering to restore the direct map before the folio is freed.

Cc: <stable@vger.kernel.org>
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v1 -> v2:
 - Collect Reviewed-by from Mike and Lorenzo - thanks!
 - Collect Acked-by from David - thanks!
 - Update the changelog as Mike suggested
 - https://lore.kernel.org/linux-mm/aQSIdCpf-2pJLwAF@kernel.org/

 mm/secretmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index c1bd9a4b663d..37f6d1097853 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		__folio_mark_uptodate(folio);
 		err = filemap_add_folio(mapping, folio, offset, gfp);
 		if (unlikely(err)) {
-			folio_put(folio);
 			/*
 			 * If a split of large page was required, it
 			 * already happened when we marked the page invalid
 			 * which guarantees that this call won't fail
 			 */
 			set_direct_map_default_noflush(folio_page(folio, 0));
+			folio_put(folio);
 			if (err == -EEXIST)
 				goto retry;
 
-- 
2.49.0


