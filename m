Return-Path: <stable+bounces-67506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E2D950887
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215E91C20F22
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 15:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED69B1A01B0;
	Tue, 13 Aug 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNS9y8wc"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6BD19EED6
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561685; cv=none; b=newP+QvEg6ScOfmj0NAfVvJIynyms+pbwm/AP4WlTCrreThSkpqoVNQFjxzYYGt/S6NpChRup9nSOxrNb1Zc1qxIe4A2nQLEOegDIxS3jN63856NnJ+83Vl8fJxPRj5ZuXR7hjQHD0OCbfviXdZcbuv2wP1urPF3U/qydsK8uJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561685; c=relaxed/simple;
	bh=0SUSjI1aRMV7yB5WWwbS893feIJjVQdA6vnvqLmSMKo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LlxzkApYfH/Lr2JCvZ32aVOFVuT0KLZ/g89UIGzOyrH18fNBcfUg4oN05x58wrZN0iOVi2AtQu/50nQWylmCzKqO3ltxc1px/jWG6vAM/5brlzV3qRWP0Ho0kc0UDy3fQLaxvxd0gep1UK0KDqMBSSZ04Rn9g8nmQR1wdWruLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNS9y8wc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6902dc6d3ffso138540717b3.2
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723561683; x=1724166483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HItAAQ4Cu003jbkia8AheTp1hPIpjiafpUpcTgjSBk4=;
        b=WNS9y8wcbuMuoJOr1DOvA7F1bTyw6Adta3B6GYyLlE73jeBxUScLWdnrV1/cGUNdKi
         0+MIzYCUjWgmEJR+UTR5bcqWcW7k27/A/2jgM+bboMhG4rrYX5am4sS2mXu/Y7bu1ENT
         1XLL9lA7TmI+XXmhIgredCJPAvHN4AeO6gdeXfsiY0CuR4yXgfkj/bkbhMVz7bu0QE/m
         tdeDxz8zi0ZJTS7beShTKR8sMSNhsuIbdTRkidXUa/W7EzuXE9mpaoxAPu0yGD8IzG7n
         x4h3EBJdBP4kEfqw+NVv3aKC4UryL67F8xJUI64M3pCnGOsSGtmJM8+SGFES4mmM1l18
         mn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723561683; x=1724166483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HItAAQ4Cu003jbkia8AheTp1hPIpjiafpUpcTgjSBk4=;
        b=PmnDjnPmfM6WPTDzodne4gq+jLe/U5CPWk3P1Cs4OMWkwqdm9CnUyZbEcEUKkTMW/B
         a+mh9cupt+ODTnR+KJzR9MsJKiIrlTRA9EqRa+ZHJx2A3YKPlEtjoRv6YLGo9zrvR5/5
         K1UPCrU+3129h8qccJ2rMR7XSQKYlAMlMDmTS1DMmDX3rBkeh44H50tLRPFdTuVxQBsn
         OHzwX7gCKeHtd2ZpdiLCyyoDfVyeEAP0FSkwh5JquMhm6H16i0Q6hynnLKZsnmOy+hjw
         UnSjW3RQF1lfL2Ha1Kaa1SIR7dt79+8ijD1rN4w4qt9q5ajcoQljFXWKDiVnCiOaxI0y
         YAIg==
X-Forwarded-Encrypted: i=1; AJvYcCVq8vOSCys3u61KpFrDs5QbDIEk6BPwoEJWhWc9sWCTTKXfpMXgkw4YpeSLIw4FRHXXxNv11CHanxV7nw8dpBWDbeUGmPVo
X-Gm-Message-State: AOJu0Yz7WhRx6i/PjXT1j+E6KGZkSlckTdw4huQR6ALeNs5e++A/MuRJ
	PX8mfEHyPf03d03UmXGusO+dIyx32UfLHnRsmh8sU0wNojHBHds/I4XGJ6JQIiOml8JDT3Fqq+z
	srQ==
X-Google-Smtp-Source: AGHT+IG/nKnomNtLuqj0m6U9iTDpGVWXD3ZvVIbVbvNz/CQySgPPuus4RRP2iUTRkRmZvV/6nAgz4mxWbJE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b416:2d8c:d850:78])
 (user=surenb job=sendgmr) by 2002:a0d:d146:0:b0:6a9:3d52:79e9 with SMTP id
 00721157ae682-6a975ab0573mr1862217b3.4.1723561683324; Tue, 13 Aug 2024
 08:08:03 -0700 (PDT)
Date: Tue, 13 Aug 2024 08:07:57 -0700
In-Reply-To: <20240813150758.855881-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813150758.855881-1-surenb@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813150758.855881-2-surenb@google.com>
Subject: [PATCH v3 2/2] alloc_tag: mark pages reserved during CMA activation
 as not tagged
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, david@redhat.com, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, surenb@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

During CMA activation, pages in CMA area are prepared and then freed
without being allocated. This triggers warnings when memory allocation
debug config (CONFIG_MEM_ALLOC_PROFILING_DEBUG) is enabled. Fix this
by marking these pages not tagged before freeing them.

Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved pages as empty")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org # v6.10
---
Changes since v2 [1]:
- Add and use clear_page_tag_ref helper, per David Hildenbrand

https://lore.kernel.org/all/20240812192428.151825-1-surenb@google.com/

 mm/mm_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 907c46b0773f..13c4060bb01a 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2245,6 +2245,8 @@ void __init init_cma_reserved_pageblock(struct page *page)
 
 	set_pageblock_migratetype(page, MIGRATE_CMA);
 	set_page_refcounted(page);
+	/* pages were reserved and not allocated */
+	clear_page_tag_ref(page);
 	__free_pages(page, pageblock_order);
 
 	adjust_managed_page_count(page, pageblock_nr_pages);
-- 
2.46.0.76.ge559c4bf1a-goog


