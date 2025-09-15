Return-Path: <stable+bounces-179650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 980F8B585B5
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 22:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A8507A2C33
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 20:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA7528C5B8;
	Mon, 15 Sep 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmx2116K"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0342286898
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966966; cv=none; b=Nv41A8DRFjzfDYF1/jGan3hFhWUHhUZ4wbKwgg3OA44t18n/eqNpokkHnLrnHMFMdiFg7vorRSGeXu/gdzUDvQ4GPKcfKsPfiHq4DNlbL7oCXhnlI77YkHytZV/KSOQZzAUkVMQM+pk38a4d3UB+X500u7ReVNRxIJzHp+PLN/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966966; c=relaxed/simple;
	bh=GJlUdQQFEEyij2bCCUq4jMjDPlMzhjEk2ZEz0qtOETA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PgbAo8fczujcn/saNS87chlugqh/jlVXzbo2W3J1VLZ4mt4nTpLXiUWR0R44K0n1/OdKzinDgNQF9YOrJai66UNIr2o7igsmTAJSf/QDOyVS6iOPHCnZOlRLSEuCM2WIpc9fOZbRZIk9opZFF+SSsznHrCQ+DOoKFab25ThE7RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cmx2116K; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32e64d4923fso942000a91.0
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757966964; x=1758571764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibj1DZeI6DujSHcNfRa4mHa6id37sgMiM15loCqZ4m8=;
        b=cmx2116KC4Si12WHcWX1tHWWiKg7uMwEQDsvO0qnGa9jLCKKESJDUk1fN0ClUJ0FTA
         le1bIY3F+UEAWNKLDysRuKkDDIasY0i49omri4b1JGR+H2DRG94qHEyNwGw/+BHZAOAB
         pj1SnGQC/rmnbEPF77NytKecsaZQjUlKpOHBia9prRhlOTS370pEIdRvVjDr+hRW4D1K
         uHwo3bU9nZPc1HlDapItmOe9BflzfTXPrtW4+7N23GGbIVV4s2ne4OAnwGdSkDqObJti
         z7p/J3N3lIBV7DeHqA00c0RfIImltXbtrPlTUpzZSrL6AjGsP4rPSBSzlQNJvoiZ/2vx
         XOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966964; x=1758571764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibj1DZeI6DujSHcNfRa4mHa6id37sgMiM15loCqZ4m8=;
        b=EWlmLSS7ZbCt7tWF9OXZ0yTcL5fc0rldo0MkaVte6ZDhT8/1eMIDJcdvKO8A9hI2bg
         rmXnh2+2gHBEsMlFhMINw1wyQL0iU25sIqH3+urTd2HEK8hn6PogsBXk1MRNgsmGM9cg
         GgJGfUKFmbzZtkVkB0UAEIuw/YzlrTeb5KEmpbT4mrI8lDIR4y80UPkQS2d3BZqvuFRa
         9ltmNzTslRyVj5ycUq3xHVPE7c0vsLVFkj+gsXpTBtHVDP2OYm7lao+z9K8NghZX3sJg
         FHIL4QP5UoxrVJUAMtCLSPGZSlqGqrHTZwxfOIJOxXJQMiLMcvgfflu7a8DZEB+gqVqm
         RuIA==
X-Forwarded-Encrypted: i=1; AJvYcCUFaqlVr5hnxyMPxVF62hPjwrPlEDq1plonnKGbc791afO40GXDQdYbRg1jsdKvx8JhIovSSac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNX+Y6/AybpiySsYSjpvvYR/402U3L4/kMfFpH3wrF3OZtn3pp
	AMEs/JctlxlQuTIk2SnS8k4KOpqdtTFnYn0lUDtv565adm0zQHKyCRKFxKBLROmZ8Yv68M4hUYJ
	2xKe9IA==
X-Google-Smtp-Source: AGHT+IE9+G8Ng/84dVBNdtIEgBnECFOfJf1D0wcN0DZsNSGryUzvVxVuPH4z3IvZrC3hI4ZRRiLJKETXuFA=
X-Received: from pjhu61.prod.google.com ([2002:a17:90a:51c3:b0:32e:18f2:7a47])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5786:b0:329:e2b1:def3
 with SMTP id 98e67ed59e1d1-32de4ec338bmr15775459a91.10.1757966964082; Mon, 15
 Sep 2025 13:09:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:09:17 -0700
In-Reply-To: <20250915200918.3855580-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915200918.3855580-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915200918.3855580-2-surenb@google.com>
Subject: [PATCH 1/2] slab: prevent warnings when slab obj_exts vector
 allocation fails
From: Suren Baghdasaryan <surenb@google.com>
To: vbabka@suse.cz
Cc: akpm@linux-foundation.org, cl@gentwo.org, rientjes@google.com, 
	roman.gushchin@linux.dev, harry.yoo@oracle.com, shakeel.butt@linux.dev, 
	alexei.starovoitov@gmail.com, usamaarif642@gmail.com, 00107082@163.com, 
	souravpanda@google.com, kent.overstreet@linux.dev, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When object extension vector allocation fails, we set slab->obj_exts to
OBJEXTS_ALLOC_FAIL to indicate the failure. Later, once the vector is
successfully allocated, we will use this flag to mark codetag references
stored in that vector as empty to avoid codetag warnings.

slab_obj_exts() used to retrieve the slab->obj_exts vector pointer checks
slab->obj_exts for being either NULL or a pointer with MEMCG_DATA_OBJEXTS
bit set. However it does not handle the case when slab->obj_exts equals
OBJEXTS_ALLOC_FAIL. Add the missing condition to avoid extra warning.

Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext allocations")
Reported-by: Shakeel Butt <shakeel.butt@linux.dev>
Closes: https://lore.kernel.org/all/jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org # v6.10+
---
 mm/slab.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index c41a512dd07c..b930193fd94e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -526,8 +526,12 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 	unsigned long obj_exts = READ_ONCE(slab->obj_exts);
 
 #ifdef CONFIG_MEMCG
-	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS),
-							slab_page(slab));
+	/*
+	 * obj_exts should be either NULL, a valid pointer with
+	 * MEMCG_DATA_OBJEXTS bit set or be equal to OBJEXTS_ALLOC_FAIL.
+	 */
+	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS) &&
+		       obj_exts != OBJEXTS_ALLOC_FAIL, slab_page(slab));
 	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
 #endif
 	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
-- 
2.51.0.384.g4c02a37b29-goog


