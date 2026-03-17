Return-Path: <stable+bounces-226421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAtLLhKIuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:57:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A81C2AEB3D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77A9B3040FE7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF473F0778;
	Tue, 17 Mar 2026 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Atf4ByIp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36FB3F54B8;
	Tue, 17 Mar 2026 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766633; cv=none; b=Usw87qRjW1PeU2ygpV/2h5dMVbWWXpmC6v5CCR4/gvgKIXc8pQEK2rXtjpYhrUciA9/Eu1psYNd8WaWLsfcPza2RbywXxLNzX4ulji4+X9EYD6kaUpcveSb/7FCQxXrhtRUKT417DR1715LXm1WGRF/Xy9zhn9/extP0L1XHcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766633; c=relaxed/simple;
	bh=kJBcu3hVyXcpBcpBTddZP+6NC0Ry3e8b7yapqhyAAaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm2GVkzQRJgA32dyZXUUgcsf+RrYrmQWLb7Ca9aogpPbyrRSX3NB8NXNWn/tmjfjcFxeP6Ayo8g9XJkaAJ74VnFsLuQfD+FH8IUi8PZgKRh3GDoxj/wor367mcakR3ee/QvVj5v8+q6Xh+FgHgVV3lzvy1m2NYxKu0GjG1GBGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Atf4ByIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32295C4CEF7;
	Tue, 17 Mar 2026 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766632;
	bh=kJBcu3hVyXcpBcpBTddZP+6NC0Ry3e8b7yapqhyAAaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Atf4ByIp/Qv3sYY7fPnCjCtvAJK+T4Bcy0KVthtxvv7TSkxfb3wgTvQ1ZNaaGlV7H
	 JtLLu/kKd5z4Q1OtkpC72X528Jcj7JpwrGS854Kta3/zfmk7k9okZDR/6/m9dTs2QN
	 2qcJcdm3LvATjYZzQCrsMh6NVBajq6roTUG/bT2U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Hao Li <hao.li@linux.dev>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: [PATCH 6.19 288/378] slab: distinguish lock and trylock for sheaf_flush_main()
Date: Tue, 17 Mar 2026 17:34:05 +0100
Message-ID: <20260317163017.606702276@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226421-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,oracle.com:email,msgid.link:url,suse.cz:email]
X-Rspamd-Queue-Id: 5A81C2AEB3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlastimil Babka <vbabka@suse.cz>

commit 48647d3f9a644d1e81af6558102d43cdb260597b upstream.

sheaf_flush_main() can be called from __pcs_replace_full_main() where
it's fine if the trylock fails, and pcs_flush_all() where it's not
expected to and for some flush callers (when destroying the cache or
memory hotremove) it would be actually a problem if it failed and left
the main sheaf not flushed. The flush callers can however safely use
local_lock() instead of trylock.

The trylock failure should not happen in practice on !PREEMPT_RT, but
can happen on PREEMPT_RT. The impact is limited in practice because when
a trylock fails in the kmem_cache_destroy() path, it means someone is
using the cache while destroying it, which is a bug on its own. The memory
hotremove path is unlikely to be employed in a production RT config, but
it's possible.

To fix this, split the function into sheaf_flush_main() (using
local_lock()) and sheaf_try_flush_main() (using local_trylock()) where
both call __sheaf_flush_main_batch() to flush a single batch of objects.
This will also allow lockdep to verify our context assumptions.

The problem was raised in an off-list question by Marcelo.

Fixes: 2d517aa09bbc ("slab: add opt-in caching layer of percpu sheaves")
Cc: stable@vger.kernel.org
Reported-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Hao Li <hao.li@linux.dev>
Link: https://patch.msgid.link/20260211-b4-sheaf-flush-v1-1-4e7f492f0055@suse.cz
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/slub.c |   47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2730,19 +2730,19 @@ static void __kmem_cache_free_bulk(struc
  * object pointers are moved to a on-stack array under the lock. To bound the
  * stack usage, limit each batch to PCS_BATCH_MAX.
  *
- * returns true if at least partially flushed
+ * Must be called with s->cpu_sheaves->lock locked, returns with the lock
+ * unlocked.
+ *
+ * Returns how many objects are remaining to be flushed
  */
-static bool sheaf_flush_main(struct kmem_cache *s)
+static unsigned int __sheaf_flush_main_batch(struct kmem_cache *s)
 {
 	struct slub_percpu_sheaves *pcs;
 	unsigned int batch, remaining;
 	void *objects[PCS_BATCH_MAX];
 	struct slab_sheaf *sheaf;
-	bool ret = false;
 
-next_batch:
-	if (!local_trylock(&s->cpu_sheaves->lock))
-		return ret;
+	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 	sheaf = pcs->main;
@@ -2760,10 +2760,37 @@ next_batch:
 
 	stat_add(s, SHEAF_FLUSH, batch);
 
-	ret = true;
+	return remaining;
+}
 
-	if (remaining)
-		goto next_batch;
+static void sheaf_flush_main(struct kmem_cache *s)
+{
+	unsigned int remaining;
+
+	do {
+		local_lock(&s->cpu_sheaves->lock);
+
+		remaining = __sheaf_flush_main_batch(s);
+
+	} while (remaining);
+}
+
+/*
+ * Returns true if the main sheaf was at least partially flushed.
+ */
+static bool sheaf_try_flush_main(struct kmem_cache *s)
+{
+	unsigned int remaining;
+	bool ret = false;
+
+	do {
+		if (!local_trylock(&s->cpu_sheaves->lock))
+			return ret;
+
+		ret = true;
+		remaining = __sheaf_flush_main_batch(s);
+
+	} while (remaining);
 
 	return ret;
 }
@@ -6215,7 +6242,7 @@ alloc_empty:
 	if (put_fail)
 		 stat(s, BARN_PUT_FAIL);
 
-	if (!sheaf_flush_main(s))
+	if (!sheaf_try_flush_main(s))
 		return NULL;
 
 	if (!local_trylock(&s->cpu_sheaves->lock))



