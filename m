Return-Path: <stable+bounces-214434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHXdB6NohGlK2wMAu9opvQ
	(envelope-from <stable+bounces-214434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 10:53:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 981ABF10D7
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 10:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B31BB3003D08
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 09:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8FB3A1E71;
	Thu,  5 Feb 2026 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9uWMtCs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB372D6409
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770285216; cv=none; b=iKCeL1vvWrlAPlIr/cLB6VRq5h8OvflLEwK8Sdcy01GXQNmg6CrTjXNkYGhSbNPUBI0br21RjS2TiITwYJ8E4mmpFfh+7Qm90ap8ux6RmU+7BPQOrev6zKC6mZWg1MuNTWFvWuDDOabkDt1wTkvYOSp9XTuQ/kt6uJqkcCPv9vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770285216; c=relaxed/simple;
	bh=nrLmXI00R22/uTzGDWoYGQOtxvzoA9Jtfjuq8R2VEFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i9JOw2zHSDsm9ut08oo0vYfnPAAhJVbX8QF+Rpmaw44k0MWnunQqUk/m7CasKnpvsnvW1doe1dY01IP/N17gXvG99GaZ1u+VebwM86nquYduFgQWWrM0q8MzOkn5vlroM+UU7vh3MkEqJ1nLGE73YGgAjFmReEWY7zlcO7w1NtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9uWMtCs; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-432db1a9589so557234f8f.0
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 01:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770285214; x=1770890014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYgfYWIutLhTE2tDgvjPMDw6no3HeV4x5//st/pkrho=;
        b=M9uWMtCsw0uy1z8nVJ//JBcEjM3rMQT9/E9cxlDF8ot1PpuCBiag4uc5XHMXm9CeFX
         4Glydfw0l66MXLnR9FBVuu5B0n9TlOoe6gIx2DeDaRDfNC7CGnLxNNWvjvgO0wzWFVab
         Uvgx+ycCkH1+RcBWz2Du3OH8mNlHstDCHIlBWXASZ++9mDsfJ4ddbbVRr7zP2yJDs1uO
         49LthvvJUZwrdTkQEAaSCcYvXwU4dPj+KMXDWwu3hn1ee6o2zdBWVYzh82R6dLpou30s
         J4oBM0LfI6S0o8R4rTakOUTpUbw9GPmBdIGSC+WU3DQk1r8KR5zl+eBI8O/2iOQklnW/
         Buew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770285214; x=1770890014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYgfYWIutLhTE2tDgvjPMDw6no3HeV4x5//st/pkrho=;
        b=iDqom5aUTmPbhqZWvIGibbGSNcfGc04cuO2cX2MSmWYT0/6aBmVdMCk072KmS2Nesr
         iVHT4bTYPqQtJ/h5F0aH3OXLhmkRMg33sBmYxX/JiScneYS6TxZmsRNoWoM2Y7ay5j59
         2+FyTmmQXGlv7WVn1usj+cVQ44XDgiPgbVvp/6rkxrXHluqpYNSrCYxIH0BJz4jBW9SF
         6dSlzASq6Ogx46IwJM1LM5Hn79bjub+qKA23K4gK1OTsXpSxH7iih+rUaCuhkfQ8gP59
         t6AvYXCTNf1DkHRPKWlOxfFy8dsbwAT/DRxFFYAi1DwMKkOIg8mnOVoJTXzKfwmKWDgm
         JO1w==
X-Gm-Message-State: AOJu0YxbM3Ea0GfZnYPv8rZfyLNwIE2i0XUhccO+2kESwGbrWO8XueOu
	lA72EulbExZw+SoTEWD+hT2sdSe8LkdoHuxZ6stZhtxnzYQFlpRha2g4MjRkiZ8jB7IZGx8cy7f
	pKd0IGxyAHMONJVrUSbTHkbxNyzOyqE03CpD5/15fQmyo1sLp4oZMYeQwzAvjoSKhI6WsvqoYdr
	XL8zrm4A+qhRIUz2jkAMZtsJwrnRd0aDk=
X-Received: from wrs7.prod.google.com ([2002:a05:6000:647:b0:436:2782:284c])
 (user=pimyn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1849:b0:432:c092:ee50
 with SMTP id ffacd0b85a97d-4361805da87mr8689162f8f.50.1770285214205; Thu, 05
 Feb 2026 01:53:34 -0800 (PST)
Date: Thu,  5 Feb 2026 10:53:23 +0100
In-Reply-To: <2026020339-trickery-vegan-e9c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026020339-trickery-vegan-e9c3@gregkh>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260205095323.3149138-1-pimyn@google.com>
Subject: [PATCH 5.15.y v2] mm/kfence: randomize the freelist on initialization
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214434-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pimyn@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tugraz.at:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: 981ABF10D7
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
---
 mm/kfence/core.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index c49bc76b3a38..e1a555eeec45 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -520,7 +520,7 @@ static bool __init kfence_init_pool(void)
 {
 	unsigned long addr = (unsigned long)__kfence_pool;
 	struct page *pages;
-	int i;
+	int i, rand;
 	char *p;
 
 	if (!__kfence_pool)
@@ -576,13 +576,30 @@ static bool __init kfence_init_pool(void)
 		INIT_LIST_HEAD(&meta->list);
 		raw_spin_lock_init(&meta->lock);
 		meta->state = KFENCE_OBJECT_UNUSED;
-		meta->addr = addr; /* Initialize for validation in metadata_to_pageaddr(). */
-		list_add_tail(&meta->list, &kfence_freelist);
+		/* Use addr to randomize the freelist. */
+		meta->addr = i;
 
 		/* Protect the right redzone. */
-		if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
+		if (unlikely(!kfence_protect(addr + 2 * i * PAGE_SIZE + PAGE_SIZE))) {
+			addr += 2 * i * PAGE_SIZE;
 			goto err;
+		}
+	}
+
+	for (i = CONFIG_KFENCE_NUM_OBJECTS; i > 0; i--) {
+		rand = get_random_u32() % i;
+		swap(kfence_metadata[i - 1].addr, kfence_metadata[rand].addr);
+	}
 
+	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
+		struct kfence_metadata *meta_1 = &kfence_metadata[i];
+		struct kfence_metadata *meta_2 = &kfence_metadata[meta_1->addr];
+
+		list_add_tail(&meta_2->list, &kfence_freelist);
+	}
+
+	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
+		kfence_metadata[i].addr = addr;
 		addr += 2 * PAGE_SIZE;
 	}
 
-- 
2.53.0.rc2.204.g2597b5adb4-goog


