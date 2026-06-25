Return-Path: <stable+bounces-268463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kVi5M44oPWqVyAgAu9opvQ
	(envelope-from <stable+bounces-268463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:09:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BFA6C5F4B
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:09:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="B/c7UUbz";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268463-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268463-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64A613049706
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34432ECE91;
	Thu, 25 Jun 2026 13:08:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A8F28751B;
	Thu, 25 Jun 2026 13:08:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392939; cv=none; b=lH5Px+M1HOikX4NQHjQ+cFQM9cvNQGd2Y7KqKzukQmUS4V09U4jw/53FCQnTxpyNS41JVSZpzxbQUSXy9uegjf0A6ktb7g9rZPsCsHdfo8GFS65dk8ngNAUKrFPMXY6RiY3h16PszG85UURiR/xna6KnsUQaZNydy3NenugYj1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392939; c=relaxed/simple;
	bh=2Xkdz8U6YWN9dlGsgaLyy1BzZzOw+TMKTLNnHS4ajuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLztIgZv4JBX6zDhAVh77IDd5jY8zc07Ag/n7s8rEvYmZYfmg44Zt67j9+q0UcUj/DHqUBy7A/epWVTErRHcjPAnAtWWTLQdFCg2MXHYzslc4ApN/cUKQorkWHSHLbJ8U3gff66dW1uDgjVN3RFQOsOgv83QdZV3XpmLxPii0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B/c7UUbz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC33B1F000E9;
	Thu, 25 Jun 2026 13:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782392935;
	bh=PcXuE1OwINzyCK6VE9Gdcs+F2erLcX6mG0QApTD+yr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B/c7UUbz2FgUUDI40ttwWjOuTK+V7i1CaXNmQneocd3suo61A+OvldCphIL11DZ+z
	 M7jbLItklbS5D4DbhD7KE0QzXvU0nhjClPcEd/MkoaKdc2K0naNCG3044RuEsuk5Lo
	 kuoMTusMKE94rwg0WxzxqIx7naKAX5RhMGL0XA2g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Chris Mason <clm@meta.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Liam Howlett <liam.howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 60/60] mm: do not copy page tables unnecessarily for VM_UFFD_WP
Date: Thu, 25 Jun 2026 14:03:45 +0100
Message-ID: <20260625125654.507572774@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625125645.554579168@linuxfoundation.org>
References: <20260625125645.554579168@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268463-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:lorenzo.stoakes@oracle.com,m:clm@meta.com,m:david@kernel.org,m:pfalcato@suse.de,m:liam.howlett@oracle.com,m:mhocko@suse.com,m:rppt@kernel.org,m:surenb@google.com,m:vbabka@suse.cz,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email,linux-foundation.org:email,suse.cz:email,vger.kernel.org:from_smtp,oracle.com:email,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47BFA6C5F4B

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

commit 35e247032606f06c2f19d90a6562bc315206b7a7 upstream.

Commit ab04b530e7e8 ("mm: introduce copy-on-fork VMAs and make
VM_MAYBE_GUARD one") aggregates flags checks in vma_needs_copy(),
including VM_UFFD_WP.

However in doing so, it incorrectly performed this check against src_vma.
This check was done on the assumption that all relevant flags are copied
upon fork.

However the userfaultfd logic is very innovative in that it implements
custom logic on fork in dup_userfaultfd(), including a rather well hidden
case where lacking UFFD_FEATURE_EVENT_FORK causes VM_UFFD_WP to not be
propagated to the destination VMA.

And indeed, vma_needs_copy(), prior to this patch, did check this property
on dst_vma, not src_vma.

Since all the other relevant flags are copied on fork, we can simply fix
this by checking against dst_vma.

While we're here, we fix a comment against VM_COPY_ON_FORK (noting that it
did indeed already reference dst_vma) to make it abundantly clear that we
must check against the destination VMA.

Link: https://lkml.kernel.org/r/20260114110006.1047071-1-lorenzo.stoakes@oracle.com
Fixes: ab04b530e7e8 ("mm: introduce copy-on-fork VMAs and make VM_MAYBE_GUARD one")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Chris Mason <clm@meta.com>
Closes: https://lore.kernel.org/all/20260113231257.3002271-1-clm@meta.com/
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Acked-by: Pedro Falcato <pfalcato@suse.de>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm.h |    6 +++++-
 mm/memory.c        |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -540,7 +540,11 @@ extern unsigned int kobjsize(const void
 /*
  * Flags which should result in page tables being copied on fork. These are
  * flags which indicate that the VMA maps page tables which cannot be
- * reconsistuted upon page fault, so necessitate page table copying upon
+ * reconsistuted upon page fault, so necessitate page table copying upon fork.
+ *
+ * Note that these flags should be compared with the DESTINATION VMA not the
+ * source, as VM_UFFD_WP may not be propagated to destination, while all other
+ * flags will be.
  *
  * VM_PFNMAP / VM_MIXEDMAP - These contain kernel-mapped data which cannot be
  *                           reasonably reconstructed on page fault.
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1479,7 +1479,11 @@ copy_p4d_range(struct vm_area_struct *ds
 static bool
 vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
-	if (src_vma->vm_flags & VM_COPY_ON_FORK)
+	/*
+	 * We check against dst_vma as while sane VMA flags will have been
+	 * copied, VM_UFFD_WP may be set only on dst_vma.
+	 */
+	if (dst_vma->vm_flags & VM_COPY_ON_FORK)
 		return true;
 	/*
 	 * The presence of an anon_vma indicates an anonymous VMA has page



