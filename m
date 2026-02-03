Return-Path: <stable+bounces-213243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKKMGTEBgmmYNgMAu9opvQ
	(envelope-from <stable+bounces-213243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:07:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F19BDA581
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B16830D2C2E
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BE23A63ED;
	Tue,  3 Feb 2026 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6QpwryM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745DF38E128
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127557; cv=none; b=eY9ckaYp4u91P/PtPH+d4csJj/9NFss9gJueEeh7LS9heI9knBFAP8aI3BxyI/zG5uDwHy9UNm9D3LrhWbTK+iMaZi0lb5DYREfnPGNjr4RXsatyF36n3V629nvbJGYzVKloFhHRzVL+nVUv9TyZEGOSPKGBOxyaFRKfDB7YWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127557; c=relaxed/simple;
	bh=oVVxFm4gVS9z7FfnVCEYd1Mdx5eFwfLGswCyuVBW1NU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uh3WzduZ6RiNyrOMUbPqCLXL3xwK4lPrir/xv3fgoulgfZrRYsPUG1H8qChYLZX5KLun++OWp02V2WB5M3hndfFGXjlglkcWUq69hSjHjpEgNXR/UDf67ZRI1UQSyaatZCnn9f0TH83xiX+M56KvD+aL56FT5a6kcw9iqxY6n64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b6QpwryM; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-4325b81081aso7405510f8f.3
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 06:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770127554; x=1770732354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TT6nTdA7PpihxQ8IxcbxHm7m3K3oc/2I1j70EmZzmI=;
        b=b6QpwryM1E0kp4qvEYIDLL36wKpFZdAFbJ7l52SR7K2FWLxMCo1+XQ8n3Y8iJ1PC6/
         1Rq3VDYl3FFjbSp9uuV3h1J/NqL8Xv3oK6YYqrvEioyKs8RPP7vbJjhAXulHsfDcv2SU
         5fh3NZRaxqoy/BMGsq5SyMt3UQhXFJSOd8vkhagAWmcsROtQ9zM/K+ZljG+gRvSsNFZH
         hLgqwpwvAggc4MEtokQLvNO6Ut9uWH/1khjgfYWPiyiwQCg5fceczxfZ1G24qGDgvKrx
         Km40GgsXfYS8hy5BEiH10dbJFpQKMY4CFBMbuFm1c1q+QBd62nN0TAk8xJ+noARnq5lw
         3lTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770127554; x=1770732354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TT6nTdA7PpihxQ8IxcbxHm7m3K3oc/2I1j70EmZzmI=;
        b=bTM7qAT/qIiTUAK+s1UiOERwI4OMeYz0mhzodfQr1YWMA6iHuNzOtomAnoKRMpQnuL
         hq3E45IlVeGihrX/v+GQ6XN0bu7+E3FlYi9ImYS6bBw49Xcpd0zp4N4ffK9MPc2MpwFs
         hKi2ow/cA1MfNXy4Uvpaq8dWtGjqsY5VUYddsOOQHvxm0hzUI/1LMFmBem+sbANUA3dF
         vvp6SfzH/k6V+70ddreGFs/oXFdrg+H+7L6SXwYIECYsRaMm70Q/IyRepDJWPGmgtZq0
         743p79AH1JIzmbznN7LrCLegOvGWjIGHvRQfcr1dEAaG/eYKPSvOjUF7Te1+u3b8hSW6
         ZzlA==
X-Gm-Message-State: AOJu0YyTq/CK3c305JpRF9r/FKoMzu+RktvDiSzjkYNPbKGnqY3ZJ0E9
	kYGlJCsZWUCQ3yxW9EnHwa0IK7pIDKAKXQJo05ItIsOUx70UuIaWnzR0DdC8AkYaOVtaU/r6SwK
	q1ohk/Z2O+9dHQgmd7ZFM9ypAEe2Loq2rb9MLIDgcH3821lg+jl4h+kXfecSwx8RplISqin1Hfu
	LzSo/M14dMN7FU4bOaJr9tlGPFSH5HAEQ=
X-Received: from wrye6.prod.google.com ([2002:a05:6000:1946:b0:435:bdf7:529a])
 (user=pimyn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2892:b0:435:9882:234e
 with SMTP id ffacd0b85a97d-435f3ad85d7mr19187802f8f.59.1770127553672; Tue, 03
 Feb 2026 06:05:53 -0800 (PST)
Date: Tue,  3 Feb 2026 15:05:50 +0100
In-Reply-To: <2026020338-hemstitch-magnolia-fb91@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026020338-hemstitch-magnolia-fb91@gregkh>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203140550.3372395-1-pimyn@google.com>
Subject: [PATCH 6.6.y] mm/kfence: randomize the freelist on initialization
From: Pimyn Girgis <pimyn@google.com>
To: stable@vger.kernel.org
Cc: Pimyn Girgis <pimyn@google.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>, Greg KH <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213243-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pimyn@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,tugraz.at:email]
X-Rspamd-Queue-Id: 8F19BDA581
X-Rspamd-Action: no action

Randomize the KFENCE freelist during pool initialization to make
allocation patterns less predictable.  This is achieved by shuffling the
order in which metadata objects are added to the freelist using
get_random_u32_below().

Additionally, ensure the error path correctly calculates the address range
to be reset if initialization fails, as the address increment logic has
been moved to a separate loop.

Link: https://lkml.kernel.org/r/20260120161510.3289089-1-pimyn@google.com
Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Signed-off-by: Pimyn Girgis <pimyn@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 870ff19251bf3910dda7a7245da826924045fedd)
Signed-off-by: Pimyn Girgis <pimyn@google.com>

# Conflicts:
#	mm/kfence/core.c
---
 mm/kfence/core.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 937bbae2611f..16a6ecca95fc 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -577,7 +577,7 @@ static unsigned long kfence_init_pool(void)
 {
 	unsigned long addr;
 	struct page *pages;
-	int i;
+	int i, rand;
 
 	if (!arch_kfence_init_pool())
 		return (unsigned long)__kfence_pool;
@@ -626,13 +626,27 @@ static unsigned long kfence_init_pool(void)
 		INIT_LIST_HEAD(&meta->list);
 		raw_spin_lock_init(&meta->lock);
 		meta->state = KFENCE_OBJECT_UNUSED;
-		meta->addr = addr; /* Initialize for validation in metadata_to_pageaddr(). */
-		list_add_tail(&meta->list, &kfence_freelist);
+		/* Use addr to randomize the freelist. */
+		meta->addr = i;
 
 		/* Protect the right redzone. */
-		if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
+		if (unlikely(!kfence_protect(addr + 2 * i * PAGE_SIZE + PAGE_SIZE)))
 			goto reset_slab;
+	}
+
+	for (i = CONFIG_KFENCE_NUM_OBJECTS; i > 0; i--) {
+		rand = get_random_u32_below(i);
+		swap(kfence_metadata_init[i - 1].addr, kfence_metadata_init[rand].addr);
+	}
 
+	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
+		struct kfence_metadata *meta_1 = &kfence_metadata_init[i];
+		struct kfence_metadata *meta_2 = &kfence_metadata_init[meta_1->addr];
+
+		list_add_tail(&meta_2->list, &kfence_freelist);
+	}
+	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
+		kfence_metadata_init[i].addr = addr;
 		addr += 2 * PAGE_SIZE;
 	}
 
@@ -645,6 +659,7 @@ static unsigned long kfence_init_pool(void)
 	return 0;
 
 reset_slab:
+	addr += 2 * i * PAGE_SIZE;
 	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
 		struct slab *slab = page_slab(nth_page(pages, i));
 
-- 
2.53.0.rc1.225.gd81095ad13-goog


