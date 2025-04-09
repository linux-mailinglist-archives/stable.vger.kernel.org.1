Return-Path: <stable+bounces-131980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E1A82DA8
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 19:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B48C7AC3D0
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F25270EC2;
	Wed,  9 Apr 2025 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZ+wfKJh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB42276056
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219854; cv=none; b=jb8LpUajboqleTqFMVrcgznTiKbd+2rqHyWTty2IHeijk6xOlJIUMJkEXt0E/EPwXla1bl+Q9B+95yZz+syiVzJApkTN9cC+bhYNgUp0mfundscMSKOeta8FLPsiC1BVmtPg94xTlutOt5i5FTHLW2VJEoqFuCE/xndGeMBrSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219854; c=relaxed/simple;
	bh=aw3wX6eyPROsxcJExM63NBEeA9/tyTtp89PgqxCVbj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XXNyEAVf02/rNkSgbo5iT5n6yRqJnspuT9AB1VOburWHQUmsgce+LuaNPykvL+CVJ1No0EKRvx5WKd+DhH+m0FINL7hhi1/Ys4KHySiCI/6cTDOdoPlVcZWNQSaC0a1McxPLGNZUdNY+XbwDsrVjE08MgBSZbSn37b3mnzFqpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KZ+wfKJh; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3912fc9861cso2882727f8f.1
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744219850; x=1744824650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFuCrVcielRSxkqN5LBqmHKeHllW5E8rT4ctitcywvo=;
        b=KZ+wfKJhrIG2IuWOGMpSmLGqrQKPUb0Pq2w+e5A+MDZ27u2FX+ijFznugBeQK9sZZf
         3jYWAGat5WvZNEnIp/rY/SEhWzQql+U2f7Kqfoy9zN8JHatp7/n/QzjsgiLnUU56Dbea
         z0i/2xjHDd5VNjWz1Kt/z6EbXZywg2LqIzao7KL32Nf8jMfI4ZdsWeCqLQX4e1w7MLV/
         xuR2pFr0ae7fqkBRYVS+tmXFYKi8nBWntYsX4wVTpoa72mFgzEbCoHmhK3VS6S+fo+tA
         FNDcXBvsYYrjKEz6mQAFimLOus+EAV1ni4cZhBNbS1uIQsGvrXbpGa588ESfXIOkZrHx
         4Gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744219850; x=1744824650;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jFuCrVcielRSxkqN5LBqmHKeHllW5E8rT4ctitcywvo=;
        b=bHta03ypBWhHXi3lW4q3+iPClMXP9mMDylnKLkRYA10RUwZSYb5SMo4hvRkrJz6m+P
         UoMPm8CyO3RoSURlhdeIn0cj2LVtC6Vv8uuYVJWN6S66eLKdwl0XgyDbG8TLDLFFTkn1
         01Mi3MfsdxUERQKnZ1wHGr505VjWWPEdGSjyR652Cue1x7XvNPPStrFcqzGzZwX/foNQ
         8NNRB+ghELHHPPkhSPUnFI7ToCTXwW0mzcjLc20dA7Z0khKSRPhP8T1hStUGklxVb/Iy
         GNwSl3k7YqsjNNV0IdS7jCvtF5Txmnrzice5FR5H4abNa4urpK6pIKtIXi1vWTuqbQbX
         dhGw==
X-Forwarded-Encrypted: i=1; AJvYcCWdpHEzmqd9t4JVzQ1kgv5UaMAsrT1pcZw6DCfHW0zHnNGLWNf9osEQH4QEgTRHyjX+nuxExQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0eFsxSoRANYjj46a6ujsfx1pNxYnDUbiZV092MDgy0l4IFWjq
	lFosmeOKkF9+RLMe29VxbLLTY94kDfW3O2npQgvgJvz6QtM1FFt3YAHwnZSSc8SgZy0/xggURkV
	R90fDqY5Clg==
X-Google-Smtp-Source: AGHT+IGOHH9oihfNAW2IS+f2IzXxx5SZ5pL5GY7qNP9YIhIPG4cLX1oYAQZci0raRdZxy6hcKyk1fZ5uOCFrjw==
X-Received: from wmbev15.prod.google.com ([2002:a05:600c:800f:b0:43d:7e5:30f0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40dc:b0:391:ba6:c066 with SMTP id ffacd0b85a97d-39d87ac7fc2mr3710134f8f.35.1744219850563;
 Wed, 09 Apr 2025 10:30:50 -0700 (PDT)
Date: Wed, 09 Apr 2025 17:30:48 +0000
In-Reply-To: <20250408185009.GF816@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407180154.63348-1-hannes@cmpxchg.org> <D91FIQHR9GEK.3VMV7CAKW1BFO@google.com>
 <20250408185009.GF816@cmpxchg.org>
X-Mailer: aerc 0.20.0
Message-ID: <D92AC0P9594X.3BML64MUKTF8Z@google.com>
Subject: Re: [PATCH 1/2] mm: page_alloc: speed up fallbacks in rmqueue_bulk()
From: Brendan Jackman <jackmanb@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Mel Gorman <mgorman@techsingularity.net>, Carlos Song <carlos.song@nxp.com>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, kernel test robot <oliver.sang@intel.com>, 
	<stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue Apr 8, 2025 at 6:50 PM UTC, Johannes Weiner wrote:
>> >	/*
>> >	 * Find the largest available free page in the other list. This roughl=
y
>> >	 * approximates finding the pageblock with the most free pages, which
>> >	 * would be too costly to do exactly.
>> >	 */
>> >	for (current_order =3D MAX_PAGE_ORDER; current_order >=3D min_order;
>> >				--current_order) {
>>=20
>> IIUC we could go one step further here and also avoid repeating this
>> iteration? Maybe something for a separate patch though?
>
> That might be worth a test, but agree this should be a separate patch.
>
> AFAICS, in the most common configurations MAX_PAGE_ORDER is only one
> step above pageblock_order or even the same. It might not be worth the
> complication.

Oh yeah, makes sense.

>>         /*
>> -        * Try the different freelists, native then foreign.
>> +        * First try the freelists of the requested migratetype, then tr=
y
>> +        * fallbacks. Roughly, each fallback stage poses more of a fragm=
entation
>> +        * risk.
>
> How about "then try fallback modes with increasing levels of
> fragmentation risk."

Yep, nice thanks.

>>          * The fallback logic is expensive and rmqueue_bulk() calls in
>>          * a loop with the zone->lock held, meaning the freelists are
>> @@ -2332,7 +2329,7 @@ __rmqueue(struct zone *zone, unsigned int order, i=
nt migratetype,
>>         case RMQUEUE_CLAIM:
>>                 page =3D __rmqueue_claim(zone, order, migratetype, alloc=
_flags);
>>                 if (page) {
>> -                       /* Replenished native freelist, back to normal m=
ode */
>> +                       /* Replenished requested migratetype's freelist,=
 back to normal mode */
>>                         *mode =3D RMQUEUE_NORMAL;
>
> This line is kind of long now. How about:
>
> 			/* Replenished preferred freelist, back to normal mode */

Yep, sounds good - it's still 81 characters, the rest of this file
sticks to 80 for comments, I guess I'll leave it to Andrew to decide if
that is an issue?

> But yeah, I like your proposed changes. Would you care to send a
> proper patch?

Sure, pasting below. Andrew, could you fold this in? Also, I haven't
done this style of patch sending before, please let me know if I'm doing
something to make your life difficult.

> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Aside from the commen stuff fixed by the patch below:

Reviewed-by: Brendan Jackman <jackmanb@google.com>

---

From 8ff20dbb52770d082e182482d2b47e521de028d1 Mon Sep 17 00:00:00 2001     =
                                                                           =
                                                                           =
                                                        =20
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 9 Apr 2025 17:22:14 +000
Subject: [PATCH] page_alloc: speed up fallbacks in rmqueue_bulk() - comment=
 updates

Tidy up some terminology and redistribute commentary.                      =
                                                                           =
                                                                           =
                                                                           =
                                    =20
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dfb2b3f508af4..220bd0bcc38c3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2183,21 +2183,13 @@ try_to_claim_block(struct zone *zone, struct page *=
page,
 }
 =20
 /*
- * Try finding a free buddy page on the fallback list.
- *
- * This will attempt to claim a whole pageblock for the requested type
- * to ensure grouping of such requests in the future.
- *
- * If a whole block cannot be claimed, steal an individual page, regressin=
g to
- * __rmqueue_smallest() logic to at least break up as little contiguity as
- * possible.
+ * Try to allocate from some fallback migratetype by claiming the entire b=
lock,
+ * i.e. converting it to the allocation's start migratetype.
  *
  * The use of signed ints for order and current_order is a deliberate=20
  * deviation from the rest of this file, to make the for loop
  * condition simpler.
  */
-
-/* Try to claim a whole foreign block, take a page, expand the remainder *=
/
 static __always_inline struct page *
 __rmqueue_claim(struct zone *zone, int order, int start_migratetype,
                                                unsigned int alloc_flags)
@@ -2247,7 +2239,10 @@ __rmqueue_claim(struct zone *zone, int order, int st=
art_migratetype,
        return NULL;
 }
 =20
-/* Try to steal a single page from a foreign block */
+/*
+ * Try to steal a single page from some fallback migratetype. Leave the re=
st of
+ * the block as its current migratetype, potentially causing fragmentation=
.
+ */
 static __always_inline struct page *
 __rmqueue_steal(struct zone *zone, int order, int start_migratetype)
 {
@@ -2307,7 +2302,8 @@ __rmqueue(struct zone *zone, unsigned int order, int =
migratetype,
        }
 =20
        /*
-        * Try the different freelists, native then foreign.
+        * First try the freelists of the requested migratetype, then try
+        * fallbacks modes with increasing levels of fragmentation risk.
         *
         * The fallback logic is expensive and rmqueue_bulk() calls in
         * a loop with the zone->lock held, meaning the freelists are
@@ -2332,7 +2328,7 @@ __rmqueue(struct zone *zone, unsigned int order, int =
migratetype,
        case RMQUEUE_CLAIM:
                page =3D __rmqueue_claim(zone, order, migratetype, alloc_fl=
ags);
                if (page) {
-                       /* Replenished native freelist, back to normal mode=
 */
+                       /* Replenished preferred freelist, back to normal m=
ode. */
                        *mode =3D RMQUEUE_NORMAL;
                        return page;
                }

base-commit: aa42382db4e2a4ed1f4ba97ffc50e2ce45accb0c
--=20
2.49.0.504.g3bcea36a83-goog



