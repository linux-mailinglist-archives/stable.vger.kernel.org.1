Return-Path: <stable+bounces-213239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOlIOw/+gWk7NQMAu9opvQ
	(envelope-from <stable+bounces-213239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 14:54:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ECCDA342
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 14:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C505E3009F0E
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BE63A0B3A;
	Tue,  3 Feb 2026 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TsKEZ+2o"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A55396D2C
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126773; cv=none; b=rMhecZdvHBakuVtZAu4gzF9S8GY1R5MI4QUwrc4tr61uAo5alc8BGuFLfPdhNzCRgRIaqHHsKeZbXAhmYU0hTTBbbd4BJCeM0BgYJdsZ9CuU/E4I/hfC7ZvC1HpODa132cY1yElPxQ6MYtvTQQDUJTpgfaa+V7S1R16paNMS82Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126773; c=relaxed/simple;
	bh=2z5FwiPiuwzGc9ToeOlFUmiMGXzk64GxkpwDtwDOPbM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=exnSUFI7BmuowOQ1O3vE+I6evxTQxNzL987e1k7kEwb6OzwJP542EJwoRd852tte0VZ4scqaO0UeeE59tSFH+SMKPeUZd2F+fBl6kkL7nuVKkiuhg28n/Iajj/Fl1N1huPGFCL9Ohq+i6m1OjRX9gTifrkOYRWGrP3fnSLy/wug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TsKEZ+2o; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4804157a3c9so66034795e9.1
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 05:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770126770; x=1770731570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIqi14pUOzb20i/BwJ2P3uTEnStPTQkLq69XoCoeyDg=;
        b=TsKEZ+2oUNhG+3O2mtLw3YQtpWm7xCCmkeDr8IXquMxYf36wrGkt+XEBNrohHZRAYG
         XfAiBliX3QxXr5DbhzocI9YpEN57pVvzNXj/zWX43SG68qTWzGIqvbm07ZMHVNGEj1eP
         P8/pzGFSXch77oKwOYNf1fhKpe+EyXeyOxPzQd9Crq7GT9RtACv91A6O66zTPgq6H0S2
         05bk9Ehe4Q79ak+snSbrcM6HPpIUzOwULwN1ngnUYLg87YnTYQPhrPPmvJPcXCR2gDHj
         6R4beY+zi4MWtlzicBzPXJ1p5rStsB6Rmoqw37Le65PBaXwsLd77kU8K3LADQzAvcAhA
         rPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770126770; x=1770731570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIqi14pUOzb20i/BwJ2P3uTEnStPTQkLq69XoCoeyDg=;
        b=aJO+2Zby6kzQh78cdnmm/FLbem0mUujMveP76IgujG7XiS90hyatb2wIx5x8adytNA
         W+vrYgDjTTa97/23ZGJwULoDwgC1dNshUFI6YEAGFzhHD0Qt+iLdqKqgmkHp0FCOIpMg
         ATs9e3IdsbiD4REgo0T/PUV9IBXxMMVuX0ZZ5O93WAwGIESh4KwHfJJs7IhtmDb2dnDK
         ykdh8Q5910oJ20HWz2TY+LjNCFEZVlLJI4wQIJ87CXkgGm5BY884mwrYQrrfm+ueWdi5
         /ZbFd44HAbqIKH0d/kBpUqvUz1fUDTmTGWvFVKqh+bnMpVahjF4jXjkmvG70AXSyuZJZ
         zbZQ==
X-Gm-Message-State: AOJu0Yyi21uJ83UbUb/o3HvECvIwM0ILcYnRvO8HqGOkPITMR5pgyIK5
	qNccHdZYidjNGYdolSJ/KlcLNxKydpYNrYHWUjfjDqEMxFcNmfJL0qC+0dgz3+iX/5sLFWn1LSP
	RaghVzusnPO09eCaFprtXEDNIg5/WemdNkzxPIL2b/00o3Hp8UKyNACMoSTvehKzN54pd5V1JD9
	e+c92lVz96g3amHOPXCrkbrthXSTWraWY=
X-Received: from wmbgx26.prod.google.com ([2002:a05:600c:859a:b0:477:aa9e:db24])
 (user=pimyn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:474f:b0:47b:de05:aa28
 with SMTP id 5b1f17b1804b1-482db45927bmr219594635e9.2.1770126770105; Tue, 03
 Feb 2026 05:52:50 -0800 (PST)
Date: Tue,  3 Feb 2026 14:52:35 +0100
In-Reply-To: <2026020338-reformer-sensitize-b6b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026020338-reformer-sensitize-b6b7@gregkh>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203135235.3307499-1-pimyn@google.com>
Subject: [PATCH 6.12.y] mm/kfence: randomize the freelist on initialization
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213239-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pimyn@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 10ECCDA342
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
index 102048821c22..b301ca337508 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -596,7 +596,7 @@ static unsigned long kfence_init_pool(void)
 {
 	unsigned long addr;
 	struct page *pages;
-	int i;
+	int i, rand;
 
 	if (!arch_kfence_init_pool())
 		return (unsigned long)__kfence_pool;
@@ -645,13 +645,27 @@ static unsigned long kfence_init_pool(void)
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
 
@@ -664,6 +678,7 @@ static unsigned long kfence_init_pool(void)
 	return 0;
 
 reset_slab:
+	addr += 2 * i * PAGE_SIZE;
 	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
 		struct slab *slab = page_slab(nth_page(pages, i));
 
-- 
2.53.0.rc1.225.gd81095ad13-goog


