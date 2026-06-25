Return-Path: <stable+bounces-268430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZWgOD/4nPWpLyAgAu9opvQ
	(envelope-from <stable+bounces-268430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:07:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C56546C5E7A
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:07:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=IJqKBAx6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268430-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268430-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 404333008262
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718782D0C84;
	Thu, 25 Jun 2026 13:07:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000C23E25B;
	Thu, 25 Jun 2026 13:07:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392827; cv=none; b=mDs79XCgwfPIp9SeJBTXkEB5CLh1FVOKdDDHn7NJnwa82YU9LGMptM4kwF0Asg+FRqFRLA5u6IqvRgM28svAog5JsklvxkYKXQs4nih/DjH7uSmy91yxaha2JXN6QlZ+S4SCw4AhjZiAZosDdYmDE0ZmancIz6m0dtvWapSgoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392827; c=relaxed/simple;
	bh=KfFSjPyxJW9XOXc7Pt9MTgiXNPISibjF7cmapKm5L6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW5RZewB4Uy+X0W+ujdpgYJFRI4NsV4V9s45Le+ZqytHVqQaN2TlOELvQQRrsdiOvc91Iguhqh1PYQoYKABLGtx+MmvYmUUz89XNZZpoc0cwLZ3Jy8wjpxF/y4rdpsBmwgxo/g8/ZBb7dRVOn1QLaSO87A+VT0f0uCdHH5dCsh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IJqKBAx6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7941F000E9;
	Thu, 25 Jun 2026 13:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782392826;
	bh=vayaskE3V6A3mcI4Mk0d3Gu7RAvazZI9SeY0d8AUv0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IJqKBAx60mBV0CdUMIPME4iwckmnsq1TYkf8rgX+6nK1ct0GWm2VvoA4FlMj0+Ah9
	 qnEkAyWbeM0qrs1BRlHoVmBr+DRihcH1qMV9XJe0SZuAQzhJYfchyfaVAPFu/rn7bR
	 97E5rIFPyEQjBf9O/mxroYGDlQKvvvUM59VWjFKI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Stoakes <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Andrei Vagin <avagin@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Jann Horn <jannh@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Liam Howlett <liam.howlett@oracle.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ahmed Elaidy <elaidya225@gmail.com>
Subject: [PATCH 6.18 35/60] mm: add atomic VMA flags and set VM_MAYBE_GUARD as such
Date: Thu, 25 Jun 2026 14:03:20 +0100
Message-ID: <20260625125650.732740428@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-268430-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ljs@kernel.org,m:pfalcato@suse.de,m:vbabka@suse.cz,m:david@kernel.org,m:lance.yang@linux.dev,m:avagin@gmail.com,m:baolin.wang@linux.alibaba.com,m:baohua@kernel.org,m:dev.jain@arm.com,m:jannh@google.com,m:corbet@lwn.net,m:liam.howlett@oracle.com,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:mhocko@suse.com,m:rppt@kernel.org,m:npache@redhat.com,m:ryan.roberts@arm.com,m:rostedt@goodmis.org,m:surenb@google.com,m:ziy@nvidia.com,m:akpm@linux-foundation.org,m:elaidya225@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,suse.de,suse.cz,linux.dev,gmail.com,linux.alibaba.com,arm.com,google.com,lwn.net,oracle.com,efficios.com,suse.com,redhat.com,goodmis.org,nvidia.com,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C56546C5E7A

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

commit 568822502383acd57d7cc1c72ee43932c45a9524 upstream.

This patch adds the ability to atomically set VMA flags with only the mmap
read/VMA read lock held.

As this could be hugely problematic for VMA flags in general given that
all other accesses are non-atomic and serialised by the mmap/VMA locks, we
implement this with a strict allow-list - that is, only designated flags
are allowed to do this.

We make VM_MAYBE_GUARD one of these flags.

Link: https://lkml.kernel.org/r/97e57abed09f2663077ed7a36fb8206e243171a9.1763460113.git.ljs@kernel.org
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ahmed Elaidy <elaidya225@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -501,6 +501,9 @@ extern unsigned int kobjsize(const void
 /* This mask represents all the VMA flag bits used by mlock */
 #define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
 
+/* These flags can be updated atomically via VMA/mmap read lock. */
+#define VM_ATOMIC_SET_ALLOWED VM_MAYBE_GUARD
+
 /* Arch-specific flags to clear when updating VM flags on protection change */
 #ifndef VM_ARCH_CLEAR
 # define VM_ARCH_CLEAR	VM_NONE
@@ -843,6 +846,47 @@ static inline void vm_flags_mod(struct v
 	__vm_flags_mod(vma, set, clear);
 }
 
+static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
+				       int bit)
+{
+	const vm_flags_t mask = BIT(bit);
+
+	/* Only specific flags are permitted */
+	if (WARN_ON_ONCE(!(mask & VM_ATOMIC_SET_ALLOWED)))
+		return false;
+
+	return true;
+}
+
+/*
+ * Set VMA flag atomically. Requires only VMA/mmap read lock. Only specific
+ * valid flags are allowed to do this.
+ */
+static inline void vma_flag_set_atomic(struct vm_area_struct *vma, int bit)
+{
+	/* mmap read lock/VMA read lock must be held. */
+	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
+		vma_assert_locked(vma);
+
+	if (__vma_flag_atomic_valid(vma, bit))
+		set_bit(bit, &ACCESS_PRIVATE(vma, __vm_flags));
+}
+
+/*
+ * Test for VMA flag atomically. Requires no locks. Only specific valid flags
+ * are allowed to do this.
+ *
+ * This is necessarily racey, so callers must ensure that serialisation is
+ * achieved through some other means, or that races are permissible.
+ */
+static inline bool vma_flag_test_atomic(struct vm_area_struct *vma, int bit)
+{
+	if (__vma_flag_atomic_valid(vma, bit))
+		return test_bit(bit, &vma->vm_flags);
+
+	return false;
+}
+
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
 {
 	vma->vm_ops = NULL;



