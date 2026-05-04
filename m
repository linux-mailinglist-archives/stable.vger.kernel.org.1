Return-Path: <stable+bounces-243179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKf5CCan+GlexgIAu9opvQ
	(envelope-from <stable+bounces-243179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:03:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8234BE6BC
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58C843008C08
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55F3D3308;
	Mon,  4 May 2026 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G0EkTB7e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41710347BA9;
	Mon,  4 May 2026 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903219; cv=none; b=X1j7Rsuuaw22vOZzWezLK/xFmll2ZKCDHkaIj3Dq+uN4FvtceMG5ZXNER0fg2RAFV1Yb//NKtcemo7aE6Wm/5lC7jI0oqYYA7OYbpzt4rVYBgzYOiH+bA9Vyv2+HSwgrjL+QMbb4HdbCQg5Oy8/X4i6/PkbNlppufpblw8rmdzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903219; c=relaxed/simple;
	bh=p5REswEx8k5wjJk/7DGmuDz+Mno1SYjoAA1PYZ29q1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9B4LdNum7Jamy8lHeDhiad3ayai10+IeZUtVEXzqsWZ7VsfsYlpXODyaqdyC4VjI88+aCXwcCWgY6MyWt4ovUxmwxhlTsx7eCh4cWvf6C7LjVlsVKwGVmLYdH5MEQuq+C4pwv4BNF/qPKVB56ODfIw8GCw45ydtZY8t6q1Heuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G0EkTB7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92217C2BCB8;
	Mon,  4 May 2026 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903218;
	bh=p5REswEx8k5wjJk/7DGmuDz+Mno1SYjoAA1PYZ29q1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0EkTB7eQl3I3UBOkTxWlWFqIUJLvLX8XeDL6DUoexW/Ms8vMXURbldjXAkScWT64
	 TbdzTMI7WNwaD4PrOrCZUr/SH4V0MpT+QVYVb3F9QJxfq/fXuTxil/YELp53nvmOjy
	 Jy9e8s0hH9vvwoSQQ9A0oE8nWxLeI9+0/m0oPWd4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marco Elver <elver@google.com>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: [PATCH 7.0 150/307] slub: fix data loss and overflow in krealloc()
Date: Mon,  4 May 2026 15:50:35 +0200
Message-ID: <20260504135148.428451749@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: AC8234BE6BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243179-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sashiko.dev:url]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Elver <elver@google.com>

commit 082a6d03a2d685a83a332666b500ad3966349588 upstream.

Commit 2cd8231796b5 ("mm/slub: allow to set node and align in
k[v]realloc") introduced the ability to force a reallocation if the
original object does not satisfy new alignment or NUMA node, even when
the object is being shrunk.

This introduced two bugs in the reallocation fallback path:

1. Data loss during NUMA migration: The jump to 'alloc_new' happens
   before 'ks' and 'orig_size' are initialized. As a result, the
   memcpy() in the 'alloc_new' block would copy 0 bytes into the new
   allocation.

2. Buffer overflow during shrinking: When shrinking an object while
   forcing a new alignment, 'new_size' is smaller than the old size.
   However, the memcpy() used the old size ('orig_size ?: ks'), leading
   to an out-of-bounds write.

The same overflow bug exists in the kvrealloc() fallback path, where the
old bucket size ksize(p) is copied into the new buffer without being
bounded by the new size.

A simple reproducer:

	// e.g. add to lkdtm as KREALLOC_SHRINK_OVERFLOW
	while (1) {
		void *p = kmalloc(128, GFP_KERNEL);
		p = krealloc_node_align(p, 64, 256, GFP_KERNEL, NUMA_NO_NODE);
		kfree(p);
	}

demonstrates the issue:

  ==================================================================
  BUG: KFENCE: out-of-bounds write in memcpy_orig+0x68/0x130

  Out-of-bounds write at 0xffff8883ad757038 (120B right of kfence-#47):
   memcpy_orig+0x68/0x130
   krealloc_node_align_noprof+0x1c8/0x340
   lkdtm_KREALLOC_SHRINK_OVERFLOW+0x8c/0xc0 [lkdtm]
   lkdtm_do_action+0x3a/0x60 [lkdtm]
   ...

  kfence-#47: 0xffff8883ad756fc0-0xffff8883ad756fff, size=64, cache=kmalloc-64

  allocated by task 316 on cpu 7 at 97.680481s (0.021813s ago):
   krealloc_node_align_noprof+0x19c/0x340
   lkdtm_KREALLOC_SHRINK_OVERFLOW+0x8c/0xc0 [lkdtm]
   lkdtm_do_action+0x3a/0x60 [lkdtm]
   ...
  ==================================================================

Fix it by moving the old size calculation to the top of __do_krealloc()
and bounding all copy lengths by the new allocation size.

Fixes: 2cd8231796b5 ("mm/slub: allow to set node and align in k[v]realloc")
Cc: stable@vger.kernel.org
Reported-by: https://sashiko.dev/#/patchset/20260415143735.2974230-1-elver%40google.com
Signed-off-by: Marco Elver <elver@google.com>
Link: https://patch.msgid.link/20260416132837.3787694-1-elver@google.com
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/slub.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6569,16 +6569,6 @@ __do_krealloc(const void *p, size_t new_
 	if (!kasan_check_byte(p))
 		return NULL;
 
-	/*
-	 * If reallocation is not necessary (e. g. the new size is less
-	 * than the current allocated size), the current allocation will be
-	 * preserved unless __GFP_THISNODE is set. In the latter case a new
-	 * allocation on the requested node will be attempted.
-	 */
-	if (unlikely(flags & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
-		     nid != page_to_nid(virt_to_page(p)))
-		goto alloc_new;
-
 	if (is_kfence_address(p)) {
 		ks = orig_size = kfence_ksize(p);
 	} else {
@@ -6597,6 +6587,16 @@ __do_krealloc(const void *p, size_t new_
 		}
 	}
 
+	/*
+	 * If reallocation is not necessary (e. g. the new size is less
+	 * than the current allocated size), the current allocation will be
+	 * preserved unless __GFP_THISNODE is set. In the latter case a new
+	 * allocation on the requested node will be attempted.
+	 */
+	if (unlikely(flags & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
+		     nid != page_to_nid(virt_to_page(p)))
+		goto alloc_new;
+
 	/* If the old object doesn't fit, allocate a bigger one */
 	if (new_size > ks)
 		goto alloc_new;
@@ -6631,7 +6631,7 @@ alloc_new:
 	if (ret && p) {
 		/* Disable KASAN checks as the object's redzone is accessed. */
 		kasan_disable_current();
-		memcpy(ret, kasan_reset_tag(p), orig_size ?: ks);
+		memcpy(ret, kasan_reset_tag(p), min(new_size, (size_t)(orig_size ?: ks)));
 		kasan_enable_current();
 	}
 
@@ -6865,7 +6865,7 @@ void *kvrealloc_node_align_noprof(const
 		if (p) {
 			/* We already know that `p` is not a vmalloc address. */
 			kasan_disable_current();
-			memcpy(n, kasan_reset_tag(p), ksize(p));
+			memcpy(n, kasan_reset_tag(p), min(size, ksize(p)));
 			kasan_enable_current();
 
 			kfree(p);



