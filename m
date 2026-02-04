Return-Path: <stable+bounces-213377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H1PAiFDg2nqkgMAu9opvQ
	(envelope-from <stable+bounces-213377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 14:01:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98514E61F2
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 14:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08B01307D4E4
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE983E95B8;
	Wed,  4 Feb 2026 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XOm7frjJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD63F23AF
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209822; cv=none; b=CO+1p2/Z8rH12Pq/qv8nw+TFToOBI4J4S51gDYDjtGefy4zsBIhf+1FDvGiq7t2mBxMad3l2rB1JWvUgE/Gsl0a3eCPmGNSyNUEDGnQMS7hs0gyHCtEvJlp69aeKPJd1YkJM5+ChmVpF49Fty3yCQVu/jcfSRvEOORHhTRpalkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209822; c=relaxed/simple;
	bh=Rf8id0nHjDJXUac6IzxYUmRAht59ZMbwWCcvLZAdOdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fXQyXDTIbxaH9D+78pvCFCFTTZbrbYg90QB0fprnsJDev5SpFj3l6NG3OzD5p40MehEgSD5hzdKGwwf8Iw8PFh9no8TMYXNg7/43dRWG0DwDY2AvmA/XwqCrBhAujSqKkEOP2XyIbtvIGM3N222q6vXhiw28OvPmOoBcJjYXYV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XOm7frjJ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so77403455e9.2
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 04:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770209820; x=1770814620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uX/13QD1pht1i/ZEkncKyeU1jXZZG85yse+sUATL6IU=;
        b=XOm7frjJPTaIAG7RgoqSRbo24gfGCVzR9dSLzWOurdGpAnoa5dKiQ46jPWNh/CeIpK
         mAoawvSgIok99uO9DgJVsywPSw/wIejD+9eXdrUem7pAKwRt15FYhntz5E5iMq7m9th7
         etCbKQnPHhkcE5v5kbsDUnkFOYsQOLWIilpRpiLG3imh0ufTXT7PG1NbD+ZU97ZHO8KI
         ptZ4yGIvylgphVlTWZN/DHUjqaZk2Dh1mO1alU4x274RxLfnbJo/EiayM387fUMyE6y8
         KOZq6Pn6crSBqgQh6R43bVzARgfraAbyDqMUzCWZbmL2yVgFNyCPzILq69z54N5CjKju
         1Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770209820; x=1770814620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX/13QD1pht1i/ZEkncKyeU1jXZZG85yse+sUATL6IU=;
        b=lQZ7hVIqziSU8WWoINy7HUy5Lp47K2W8PqDgpRSkALjg7m+7oIF0SsTXfF0KPczF43
         V9VkA09rUKEWYc2xFx7t2mEe9HSP4DFSSQpwhqGzvjEzr4oxdKoO676sRFcmEvWamQbm
         XM6VXBs0HApqHo+uZTzea1FBC0ydUBu3/WETxP1WMrtIw8z9yo5ZNXJ8xT54RHgKhLHQ
         2+KVwiVkX8uYHTFc/7uR1NuCxNb1msu9AfK9GHfB+bjUEfuC/W2hUB5BEDuC+DmxQDNH
         K/IfNx0wk1pDvq3XzfDgsNkNV+ndC1N1Y6K5bYfMNV1RKNOVoaTtvB29zQaQPNuAByZp
         3Vng==
X-Gm-Message-State: AOJu0YxshQsrBbBHRnDBrlg95jx3374dHBJWjajU474SYtA59ufAu3my
	TN9eOPEaSgVa6A2hA74TK2JquLRocXq4KWVgITE6po2gbgwBvvLI1PeDd2KZ1XlvbJvvnatezc2
	Vt2YK5YlmD+oyWQLvY4+xoHlQE9FbJFmdMNorcFe6GBYrqC7id60tnh+O5mUJeAE+1qlTtOrpod
	MwqGdDZ7OQaieT+oSB0gITozfFhTjxN0U=
X-Received: from wmnv6.prod.google.com ([2002:a05:600c:4446:b0:480:4a03:7b7a])
 (user=pimyn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b0f:b0:471:1717:411
 with SMTP id 5b1f17b1804b1-4830e97b082mr45247335e9.24.1770209819997; Wed, 04
 Feb 2026 04:56:59 -0800 (PST)
Date: Wed,  4 Feb 2026 13:56:53 +0100
In-Reply-To: <2026020339-trickery-vegan-e9c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026020339-trickery-vegan-e9c3@gregkh>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260204125653.1415809-1-pimyn@google.com>
Subject: [PATCH 5.15.y] mm/kfence: randomize the freelist on initialization
From: Pimyn Girgis <pimyn@google.com>
To: stable@vger.kernel.org
Cc: Pimyn Girgis <pimyn@google.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>, Greg KH <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213377-lists,stable=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[linux-foundation.org:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[dvyukov.google.com:query timed out,elver.google.com:query timed out,glider.google.com:query timed out,ernesto.martinezgarcia.tugraz.at:query timed out,gregkh.linuxfoundation.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pimyn@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tugraz.at:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: 98514E61F2
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
 mm/kfence/core.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index c49bc76b3a38..f94413a503f5 100644
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
@@ -576,13 +576,28 @@ static bool __init kfence_init_pool(void)
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
 			goto err;
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
 
@@ -597,6 +612,7 @@ static bool __init kfence_init_pool(void)
 	return true;
 
 err:
+	addr += 2 * i * PAGE_SIZE;
 	/*
 	 * Only release unprotected pages, and do not try to go back and change
 	 * page attributes due to risk of failing to do so as well. If changing
-- 
2.53.0.rc2.204.g2597b5adb4-goog


