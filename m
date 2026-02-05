Return-Path: <stable+bounces-214515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNAZConHhGk45QMAu9opvQ
	(envelope-from <stable+bounces-214515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:38:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE0AF550A
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E68B304521D
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED299439003;
	Thu,  5 Feb 2026 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tC/edo4r"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5548B3AEF2C
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309259; cv=none; b=cQj6qD4QDNTGFMaL7HDkHfyb3H1mXdO3qqkEi3nZ8hVnfJ46EZIwrpca0cYaUOU1+jJR+y+VSUXu3kHestmzYyvIzWvrKDYtTNyOn5cADK7CvDdtqa11zSrO6ZT2o+v+TKabg+wcJhU88FtewBz9MnGpncllFG2iSlALXKT0cmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309259; c=relaxed/simple;
	bh=/wDE+cE7uiJ8n1QkajYg+fwfUlIWBLKJTaivqxyMyf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gDRwtO0bp4xAyVkfvRsOhZxN23QmhWljuTTsEJC8m+GBc7d9QRL2+B+2dTdqbWfCVvFMrnB+b1VvvUZlUf6N+bdVoNxgue8W1s56WVp3e4+BHwIZU6YlUufAvVhxJtG2u5+lzJhuLBUlAy1RQQrwbtB+VX+MlhFs7Eeq/011nxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tC/edo4r; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47ee056e5cfso11084235e9.1
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 08:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770309258; x=1770914058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nHzaZyCZK3wRH/vTBcov5W3g7DWvdB2qmrJEWrmlz2A=;
        b=tC/edo4rkeilknH21FrYadROl1NKKlW5nEmUdsfXFl8LIFh1sqLH77eTHWl2tLvl22
         P/1m4vG67zQkfMKBrBhPr8FPX9zTAqVM8tlOLrAFOlTnsCXpjuRYvdJ4TPswKLul1mkA
         qPZBRbm2Nca0Hm2AcXkUYRBnGzVsMQBSsLKbTgUDd0j8DCDsszlKu3Honx1NYKtgpo0U
         Tpn1SoJuJXfMYpXDn/auvIoqAYHVSRzE7VNbrfKXs4eM3fTZRCoEkGKlRyR2UHgMYi3Z
         K9NOm3Z+Rrx3yHgYj7Nn0ZEpDNeZ+PljurVhwzK0vfoJE26qFXmeKaKw3FSmVnS/mOMX
         zV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770309258; x=1770914058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHzaZyCZK3wRH/vTBcov5W3g7DWvdB2qmrJEWrmlz2A=;
        b=HBhItUZQTpWIu/E+boW1DggoS1PY1hgdJ0s4T5JSw5qY0NiXAtPUsOL3Gcr2coSczy
         bQJrsmcJL4fNYeZZueJTGc3fOK3o1fw2GsuSFmfd7TzViazepd/RU5y+KgEL1alDuA44
         tY5LbIGNJy+r9ChtH1jvwYAVVvYZTRVP7A/EYAHu9bKnygcTbaLZs2n+M9CIV9afjMMj
         V85DTkAp4NyTA/TrJ6hIAgko8Dveo/vrCLnH6janbjp0QNf2xClb53SwkrZIy/Fk2FMi
         A1yvRdTdd/LF/vSSzn90Flewjkhi24hWAnLLMvfwiVjoE3CpNW/Hm1bCk5+jqUfsSIOo
         H6oA==
X-Gm-Message-State: AOJu0YxLEY5J/YrSfMZukiE7ytVMEO+7KOD+r02mjr2LFslLJkW05HdM
	Ft7VLsmVSFjU9zI43XhSxS+iTD8ctcb2NZKZxWBnHlhCIpyKhElvZW6hhVnfBtrA4frcAaSv9Dy
	sEs8JlW5dkYtJ3zJaJATzjT0CVMuNImiZ7CTDBDE6AKWQ2DeqTUBN+u8X0acElNolbAnooRdoct
	Xui5Cbj9O/DOYOg1KnlQZxNBzfF1wNlJo=
X-Received: from wmat22.prod.google.com ([2002:a05:600c:6d16:b0:480:4a2f:4187])
 (user=pimyn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4fcc:b0:480:1d0b:2d15
 with SMTP id 5b1f17b1804b1-4830e9926c0mr111732865e9.27.1770309257555; Thu, 05
 Feb 2026 08:34:17 -0800 (PST)
Date: Thu,  5 Feb 2026 17:33:34 +0100
In-Reply-To: <2026020339-trickery-vegan-e9c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026020339-trickery-vegan-e9c3@gregkh>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260205163334.3374729-1-pimyn@google.com>
Subject: [PATCH 5.15.y v4] mm/kfence: randomize the freelist on initialization
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214515-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CE0AF550A
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
v2: handle addr calculation for error path  within appropriate loop
v3: clarify v2 changes in patch changelogs
v4: clarify v3 changes in patch changelogs
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


