Return-Path: <stable+bounces-217934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBEWJIn4nWlzSwQAu9opvQ
	(envelope-from <stable+bounces-217934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 20:14:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 093A118BBC5
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 20:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09FA230862CD
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 19:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD61B3644DE;
	Tue, 24 Feb 2026 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dB55znbb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35C364054;
	Tue, 24 Feb 2026 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960438; cv=none; b=ikPAPPe5lcvRsdRn1t+apohL4XTJLlXd06LoTcKd7AKQlMGF84Ds3GtdSAVTWB5s+gNtMDwC8OC2V6m58m62lpw7UGGjdEYgoUmDeBVn7dG+5WPzU7ZwBpp+o2rNrKXV4ZHW2KbkD9PxiBa1jTxoouU7ErIAdBZvm9mcrRq1ujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960438; c=relaxed/simple;
	bh=dg7HxhNXmUcEH4vTFxKqrO2V+Bz7+KLiEfgpi4a7mRY=;
	h=Date:To:From:Subject:Message-Id; b=G/RKrO0KmT7T4y9kii2zRwO5npSCax2AObFoTtzBf8ZkTMolEwlbwHEy2Uh276w4pi9lZGIJYtgeusJeAFX7u0miUXLfSvHRVNlfoJWkmKtJm92gTc9B7DKdv6f9rhiIcsmjE78C3VsYMkHllQBs9Btvl/ClCl2jm1fq8iYs6GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dB55znbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6192C116D0;
	Tue, 24 Feb 2026 19:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771960437;
	bh=dg7HxhNXmUcEH4vTFxKqrO2V+Bz7+KLiEfgpi4a7mRY=;
	h=Date:To:From:Subject:From;
	b=dB55znbb5+/njDheMSrwrv48/7r1N9dO5ya6w11rE9PXZEcbsVjkHSVM7KBDTr37m
	 eFuVJmuB36EL+XL6UM+oFHSWqABki5YFVEtCkIlAtTn7Mg/jqFYGtKrQvVo4YhRMO6
	 L3fbSVNneHVKfAKqvtDEcOFtdAr4gP+0KwN3If2A=
Date: Tue, 24 Feb 2026 11:13:57 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,ryabinin.a.a@gmail.com,kees@kernel.org,gregkh@linuxfoundation.org,ernesto.martinezgarcia@tugraz.at,elver@google.com,dvyukov@google.com,andreyknvl@gmail.com,glider@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-kfence-disable-kfence-upon-kasan-hw-tags-enablement.patch removed from -mm tree
Message-Id: <20260224191357.C6192C116D0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217934-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,kernel.org,linuxfoundation.org,tugraz.at,google.com,linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tugraz.at:email,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 093A118BBC5
X-Rspamd-Action: no action


The quilt patch titled
     Subject: mm/kfence: disable KFENCE upon KASAN HW tags enablement
has been removed from the -mm tree.  Its filename was
     mm-kfence-disable-kfence-upon-kasan-hw-tags-enablement.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Alexander Potapenko <glider@google.com>
Subject: mm/kfence: disable KFENCE upon KASAN HW tags enablement
Date: Fri, 13 Feb 2026 10:54:10 +0100

KFENCE does not currently support KASAN hardware tags.  As a result, the
two features are incompatible when enabled simultaneously.

Given that MTE provides deterministic protection and KFENCE is a
sampling-based debugging tool, prioritize the stronger hardware
protections.  Disable KFENCE initialization and free the pre-allocated
pool if KASAN hardware tags are detected to ensure the system maintains
the security guarantees provided by MTE.

Link: https://lkml.kernel.org/r/20260213095410.1862978-1-glider@google.com
Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Signed-off-by: Alexander Potapenko <glider@google.com>
Suggested-by: Marco Elver <elver@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ernesto Martinez Garcia <ernesto.martinezgarcia@tugraz.at>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/kfence/core.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/mm/kfence/core.c~mm-kfence-disable-kfence-upon-kasan-hw-tags-enablement
+++ a/mm/kfence/core.c
@@ -13,6 +13,7 @@
 #include <linux/hash.h>
 #include <linux/irq_work.h>
 #include <linux/jhash.h>
+#include <linux/kasan-enabled.h>
 #include <linux/kcsan-checks.h>
 #include <linux/kfence.h>
 #include <linux/kmemleak.h>
@@ -917,6 +918,20 @@ void __init kfence_alloc_pool_and_metada
 		return;
 
 	/*
+	 * If KASAN hardware tags are enabled, disable KFENCE, because it
+	 * does not support MTE yet.
+	 */
+	if (kasan_hw_tags_enabled()) {
+		pr_info("disabled as KASAN HW tags are enabled\n");
+		if (__kfence_pool) {
+			memblock_free(__kfence_pool, KFENCE_POOL_SIZE);
+			__kfence_pool = NULL;
+		}
+		kfence_sample_interval = 0;
+		return;
+	}
+
+	/*
 	 * If the pool has already been initialized by arch, there is no need to
 	 * re-allocate the memory pool.
 	 */
_

Patches currently in -mm which might be from glider@google.com are



