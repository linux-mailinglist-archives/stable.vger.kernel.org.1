Return-Path: <stable+bounces-216278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDT/BMVYj2lqQQEAu9opvQ
	(envelope-from <stable+bounces-216278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:00:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C8566138729
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8707300D0FD
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1EB365A0E;
	Fri, 13 Feb 2026 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0Ge89QPA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338013C918;
	Fri, 13 Feb 2026 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002034; cv=none; b=WQg4ZN/5u3t9iz3F6FHOqaG0wstxhzVJzV0MAzOZoyafixoK9yBqdybsTyw71o9bMRiLrTTPwWQMLpGep8Owc1PxVYyuGtvU/HmKwqocAu2I3seZu0nvxu2J3n+mH/qovDzt0sIpNwFeuyPIEMH1vgte+jeRJTExjzk8iqh6pn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002034; c=relaxed/simple;
	bh=+XQe6fr29lEjr0WSxqgTZAv3iy32NQLaSOVMW++pPQs=;
	h=Date:To:From:Subject:Message-Id; b=EBi3+/9CgmanpSYTrHA1Y1wMZdy6twY09Qqu8S24a0AikjawNww1AM+eDHiMQWL+cPwitV4brktz4dxZ4Bxp8UpmKzptTtn9zVVCVobNnowbeIs4ka02OjrwqOr8OMRZ92IshRQcyuyR/bKjlVBW7dnDgaokdDQUtHU5PBBkpuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0Ge89QPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7C1C116C6;
	Fri, 13 Feb 2026 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771002034;
	bh=+XQe6fr29lEjr0WSxqgTZAv3iy32NQLaSOVMW++pPQs=;
	h=Date:To:From:Subject:From;
	b=0Ge89QPAA/k4Nq+SPuW56oBgP7OH2VUWbeJPHweVZw4Y40wzJptmvQ3pKkJ9GYPlf
	 PQ4TsK2CZSqgxFLiY7vROmSa2kW0RWNm8AzcHp8JVNU2hV8gJulPkefHMCx2wb+t9u
	 wYB8xVK96lpFVZAIelZZMEsIbW/CXCCG0KOoVYv8=
Date: Fri, 13 Feb 2026 09:00:33 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,ryabinin.a.a@gmail.com,kees@kernel.org,gregkh@linuxfoundation.org,ernesto.martinezgarcia@tugraz.at,elver@google.com,dvyukov@google.com,andreyknvl@gmail.com,glider@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-kfence-disable-kfence-upon-kasan-hw-tags-enablement.patch added to mm-hotfixes-unstable branch
Message-Id: <20260213170034.4F7C1C116C6@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	RSPAMD_URIBL_FAIL(0.00)[linuxfoundation.org:query timed out,tugraz.at:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216278-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,kernel.org,linuxfoundation.org,tugraz.at,google.com,linux-foundation.org];
	RSPAMD_EMAILBL_FAIL(0.00)[elver.google.com:query timed out,ryabininaa.gmail.com:query timed out,akpm.linux-foundation.org:query timed out,andreyknvl.gmail.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN_FAIL(0.00)[74.135.232.172.asn.rspamd.com:query timed out];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C8566138729
X-Rspamd-Action: no action


The patch titled
     Subject: mm/kfence: disable KFENCE upon KASAN HW tags enablement
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-kfence-disable-kfence-upon-kasan-hw-tags-enablement.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-kfence-disable-kfence-upon-kasan-hw-tags-enablement.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

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
@@ -912,6 +913,20 @@ void __init kfence_alloc_pool_and_metada
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

mm-kfence-disable-kfence-upon-kasan-hw-tags-enablement.patch


