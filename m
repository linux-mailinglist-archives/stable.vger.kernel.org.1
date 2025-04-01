Return-Path: <stable+bounces-127339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00FBA77DD0
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 16:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187BA188E25E
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4DE203714;
	Tue,  1 Apr 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkrE0Kkn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855D156677
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518008; cv=none; b=Ozf70MouHvnm7/ZxDfJt4JYpDtLfhl8pw0QuYt1L3uqFqcJ37fap8MLj+AI3++RnUsq5koZ6lZ9Fd5j2CX8SkgljSwY7MuByQHTXvnqDpMsnTDq8FS/H/eGt6bHRMPCYLVQz3jvzy8/B/7hVEKW0b4kJzm2z0XIY/wnVoC8/8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518008; c=relaxed/simple;
	bh=1qV+NGwYbZPu0XItFUpoWENdE3DurPgEaHJba+V/ZL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRgB+ApSX1mPxj8hebqy8JJ7h6pKZutsZkO4EmCrOV9x8iO9CIf28JEfyKtKgsTbaSmooTz5IPOwHEB2s8+N44EhP4YRtWM9fV3o8CuQty4yObNf+uolo1AWpCzhj1SttWTzENsJhQsquXT71RP1x5mOJc2BNCSE1Cbi7wgBUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkrE0Kkn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743518006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rLhS4YZ2gbexqMjUMzexxo96ApT7iR1NdQR/sJS2UMs=;
	b=TkrE0Kkn6QZL2xMva5vnlC485vWki3SXtImZaJFS7+HcJm8yf/e6f9RzRJhixuCdFZevJ3
	5auDuC2jr/aGZiIKZ+PfipY7mqqD4l1sH6gzd4a+bQJKWtt85OX8CQMXF1lauGl7RUEI5C
	PNtPhlF4pOwvkCTz5FjhWIfdn4LDc9A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-dc8XINrfPASWmIiH99ajuQ-1; Tue, 01 Apr 2025 10:33:23 -0400
X-MC-Unique: dc8XINrfPASWmIiH99ajuQ-1
X-Mimecast-MFC-AGG-ID: dc8XINrfPASWmIiH99ajuQ_1743518003
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so33232935e9.3
        for <stable@vger.kernel.org>; Tue, 01 Apr 2025 07:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743518002; x=1744122802;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLhS4YZ2gbexqMjUMzexxo96ApT7iR1NdQR/sJS2UMs=;
        b=cWdQFxc4FeCRwnU/yJqJKNIzXHG2xu/GhljXjdsCmUyyrw7r7TBhoFe6tD+KMX8lbm
         wl+xYckEQBjENLWbeHimq8Dz/Wh32wXVpjoOiG+T+VwXYGyBmmQM+u7Tc3T5eYJxanPB
         CV1VGp9YwvbKTTtwZ5vzUoy0pve6YR9P5pPu+pUeHYZrzHs/7P4j3M4F6xk/pE5qWlTn
         9dTPGm4i5FAjEJETvz65MolIqTHG3xpM72EwW0XJf2WoYoWXyugPXc391z4hyAGD8yq/
         PajkeXPKsxHW8AarU3eIxnX+F22iF4b+urXrotXi6rCI6CUzU3bYqrbYdfZlaK8i55kg
         uTlw==
X-Forwarded-Encrypted: i=1; AJvYcCXYexxBs8TBL68igYPwKWjqjwSHR/BY81eHK5c7WAW7VN7NS9TdCort0u3Z426DMYsfGTx7hyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfV/ZGiA1Hug1niC93sXz8yg0a5Dqg4rLRYklmBzzxv5vj+/lw
	p8oxSfMDm/DLMJzQkr4eGVsN9fIXdyNXJWdo4VUT+CHyesjdIp49za1MULgjEzkD3mpeq6k/F6o
	JSsxtKLzyemA0f5X6dV22jkMsoA7ZzGyawIHcW9VDQr95ZAAOQWG3cA==
X-Gm-Gg: ASbGnct0llx8xSWgeUcu+whGbPkb1aPhOQxMVlnKNMspBGLOrSEAOA4H8TpFCVH55JU
	nQdNpz6rrroGyujSG7UybQaHePJ7ndpire8vNKy9GmpqSFAVC16CqkFmq0hZOoq6iQow2p99wWG
	nCjnEM4WEKiNGOfLvaHH3nw4ZVlJDz0hmiXuRhspvUqqvJdLwdWr5GASMKj4ChfpzvNuUqNAM05
	U5MGhcNzVdUfLAXs3tEw5RUqSY/TRZ3Jb+GUvu7l7F6WxUIcABJpDUvX+MdLIbS+oMOGrxcsUSK
	ybFve/3AhP0IgTo2FmWWAdtNk0PdZiYZTB1PG2xRxhJtY1lqCdtAIRVpfkXXLODZJkr46vtDw9a
	7y35sj+YuQ/RIAnwPoXP8hkmkp4gXMV07wipYrfc1
X-Received: by 2002:a05:600c:6748:b0:43c:eea9:f438 with SMTP id 5b1f17b1804b1-43db6247dd7mr145919405e9.15.1743518002601;
        Tue, 01 Apr 2025 07:33:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNhzaVlgu9DU/geLuwD47lPxBtoCagRnXFrCfvHssM2drvLkFRwfHnuIV1F5YdQjnlbSU6zQ==
X-Received: by 2002:a05:600c:6748:b0:43c:eea9:f438 with SMTP id 5b1f17b1804b1-43db6247dd7mr145918915e9.15.1743518002159;
        Tue, 01 Apr 2025 07:33:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:4d00:6ac5:30d:1611:918f? (p200300cbc7074d006ac5030d1611918f.dip0.t-ipconnect.de. [2003:cb:c707:4d00:6ac5:30d:1611:918f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efeb11sm203009095e9.22.2025.04.01.07.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 07:33:21 -0700 (PDT)
Message-ID: <26870d6f-8bb9-44de-9d1f-dcb1b5a93eae@redhat.com>
Date: Tue, 1 Apr 2025 16:33:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Jinjiang Tu <tujinjiang@huawei.com>, yangge1116@126.com,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
 aneesh.kumar@linux.ibm.com, liuzixing@hygon.cn,
 Kefeng Wang <wangkefeng.wang@huawei.com>
References: <1720075944-27201-1-git-send-email-yangge1116@126.com>
 <4119c1d0-5010-b2e7-3f1c-edd37f16f1f2@huawei.com>
 <91ac638d-b2d6-4683-ab29-fb647f58af63@redhat.com>
 <076babae-9fc6-13f5-36a3-95dde0115f77@huawei.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <076babae-9fc6-13f5-36a3-95dde0115f77@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.03.25 12:16, Jinjiang Tu wrote:
> 
> 在 2025/3/26 20:46, David Hildenbrand 写道:
>> On 26.03.25 13:42, Jinjiang Tu wrote:
>>> Hi,
>>>
>>
>> Hi!
>>
>>> We notiched a 12.3% performance regression for LibMicro pwrite
>>> testcase due to
>>> commit 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before
>>> adding to LRU batch").
>>>
>>> The testcase is executed as follows, and the file is tmpfs file.
>>>       pwrite -E -C 200 -L -S -W -N "pwrite_t1k" -s 1k -I 500 -f $TFILE
>>
>> Do we know how much that reflects real workloads? (IOW, how much
>> should we care)
> 
> No, it's hard to say.
> 
>>
>>>
>>> this testcase writes 1KB (only one page) to the tmpfs and repeats
>>> this step for many times. The Flame
>>> graph shows the performance regression comes from
>>> folio_mark_accessed() and workingset_activation().
>>>
>>> folio_mark_accessed() is called for the same page for many times.
>>> Before this patch, each call will
>>> add the page to cpu_fbatches.activate. When the fbatch is full, the
>>> fbatch is drained and the page
>>> is promoted to active list. And then, folio_mark_accessed() does
>>> nothing in later calls.
>>>
>>> But after this patch, the folio clear lru flags after it is added to
>>> cpu_fbatches.activate. After then,
>>> folio_mark_accessed will never call folio_activate() again due to the
>>> page is without lru flag, and
>>> the fbatch will not be full and the folio will not be marked active,
>>> later folio_mark_accessed()
>>> calls will always call workingset_activation(), leading to
>>> performance regression.
>>
>> Would there be a good place to drain the LRU to effectively get that
>> processed? (we can always try draining if the LRU flag is not set)
> 
> Maybe we could drain the search the cpu_fbatches.activate of the local cpu in __lru_cache_activate_folio()? Drain other fbatches is meaningless .

So the current behavior is that folio_mark_accessed() will end up calling folio_activate()
once, and then __lru_cache_activate_folio() until the LRU was drained (which can
take a looong time).

The old behavior was that folio_mark_accessed() would keep calling folio_activate() until
the LRU was drained simply because it was full of "all the same pages" ?. Only *after*
the LRU was drained, folio_mark_accessed() would actually not do anything (desired behavior).

So the overhead comes primarily from __lru_cache_activate_folio() searching through
the list "more" repeatedly because the LRU does get drained less frequently; and
it would never find it in there in this case.

So ... it used to be suboptimal before, now it's more suboptimal I guess?! :)

We'd need a way to better identify "this folio is already queued for activation". Searching
that list as well would be one option, but the hole "search the list" is nasty.

Maybe we can simply set the folio as active when staging it for activation, after having
cleared the LRU flag? We already do that during folio_add.

As the LRU flag was cleared, nobody should be messing with that folio until the cache was
drained and the move was successful.


Pretty sure this doesn't work, but just to throw out an idea:

 From c26e1c0ceda6c818826e5b89dc7c7c9279138f80 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 1 Apr 2025 16:31:56 +0200
Subject: [PATCH] test

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/swap.c | 21 ++++++++++++++++-----
  1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index fc8281ef42415..bbf9aa76db87f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -175,6 +175,8 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
  	folios_put(fbatch);
  }
  
+static void lru_activate(struct lruvec *lruvec, struct folio *folio);
+
  static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
  		struct folio *folio, move_fn_t move_fn,
  		bool on_lru, bool disable_irq)
@@ -191,6 +193,10 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
  	else
  		local_lock(&cpu_fbatches.lock);
  
+	/* We'll only perform the actual list move deferred. */
+	if (move_fn == lru_activate)
+		folio_set_active(folio);
+
  	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) || folio_test_large(folio) ||
  	    lru_cache_disabled())
  		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
@@ -299,12 +305,14 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
  {
  	long nr_pages = folio_nr_pages(folio);
  
-	if (folio_test_active(folio) || folio_test_unevictable(folio))
-		return;
-
+	/*
+	 * We set the folio active after clearing the LRU flag, and set the
+	 * LRU flag only after moving it to the right list.
+	 */
+	VM_WARN_ON_ONCE(!folio_test_active(folio));
+	VM_WARN_ON_ONCE(folio_test_unevictable(folio));
  
  	lruvec_del_folio(lruvec, folio);
-	folio_set_active(folio);
  	lruvec_add_folio(lruvec, folio);
  	trace_mm_lru_activate(folio);
  
@@ -342,7 +350,10 @@ void folio_activate(struct folio *folio)
  		return;
  
  	lruvec = folio_lruvec_lock_irq(folio);
-	lru_activate(lruvec, folio);
+	if (!folio_test_unevictable(folio)) {
+		folio_set_active(folio);
+		lru_activate(lruvec, folio);
+	}
  	unlock_page_lruvec_irq(lruvec);
  	folio_set_lru(folio);
  }
-- 
2.48.1


-- 
Cheers,

David / dhildenb


