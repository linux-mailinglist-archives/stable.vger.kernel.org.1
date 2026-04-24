Return-Path: <stable+bounces-241047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMTTERfd62llSQAAu9opvQ
	(envelope-from <stable+bounces-241047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:13:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A97F54636EC
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4482301A3B5
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7881A349B1C;
	Fri, 24 Apr 2026 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHLKQaah"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34AA194C96
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065218; cv=none; b=fVdh5RUN/evdhBJN9Xnhj4Z1Rk8/c+RpUJf3z2Q3bsPjXl5lXBpgLBjzGWiYg5slnFtEfHNaug07C5IA6W1e3Qo5R3YviAxoOo0xqrTJ0wwoXKakN5EiIOQx8f7cElX4Ue3HJqDpImTQu3NGz3OZYhTrqfMLZCJV06bzQas4QvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065218; c=relaxed/simple;
	bh=FzMzHmtbI8oB/rlsfSwC8oQ0pBth+pEhPk+lZtcOxX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGxvH+QEatM7bB2wcIloBfA/2/2OTkeSBL5uiaOeowgRvGj2yBfhLZweaOvHit3X1IprTWe4FPmvuKhFOP9JaXxacTyN43WUplcPYB5P5sGMEZusFo7pHHx7z4fIlKmTlxuUDzOM3TYyD4mdc6WLSDgaeDmprnNFjNXdjvDX+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHLKQaah; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43eb05b1875so4863452f8f.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065215; x=1777670015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTAGPteg+C41GDghxdfX+CinkzFS5bGpJnmRmtrlucU=;
        b=UHLKQaahRmACNTfZ0okTu5OuIeILcvMvW4Ed3qfutQVioZe+Ko4GVQQMwiKmCu1wO3
         VZDUpSXxNqZTgEncdJ8xjWw2wp3rD6sP222We0ukoql0KEKHhb5m6SbP1GMt+9/P9D3V
         h3PuR37v9JX15zdt6Rcx4U6eRedWo+wXsZp32dgt6eV2E1hxAmT93cwmT2cvWEadN08G
         0Q+FT3hi74+8W8SuY6WbdDbgAojKcM3orw1lwhBLhX9UYY7a4RKJK274nvO1qcnt9vpf
         4LbMuWuoAX1JugFZHaVuVeZpwzNGB7Q8xDHeirZFZKFj4bDaoxC/bbPSvi8fAJQSzE0e
         U2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065215; x=1777670015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xTAGPteg+C41GDghxdfX+CinkzFS5bGpJnmRmtrlucU=;
        b=cPdW/RbqvUy75Q/ktePDyNfArQp8ix/5cUTab7VTnA6ElXwVhAA//OjuWBP9ooGz5O
         nE7Tgn0CDNr9CnyJwZQ967Ipe9nVUlIaIt+lvdJG5Sf0a74t7D5P3IKTvVigZvCpDH/Z
         o1NOX/UlQcoEa6OmD48khCBN1TkjMWdB53p6JEZHIIdU05Oisvr4QFxXHWohSHDpy0JF
         CtbRlRXPqMwWyJBiXyUfqPNg8bKngtYFlH2Lq/NL0lzWN21KhLkvvefvOP/NuUOexwYI
         Chyg71sSP8xpra2dXKbL5S7mjvXjy4LJPYXIGNrHv0cARGELizrenwuJ3hAdC9A4a5gZ
         FQzg==
X-Gm-Message-State: AOJu0Yxu3zUi5dLgf0pnj7V+yeutK8kY7HRwCxiUyyO+3S8DixOXXZhv
	96vAnqm2TfdG4WoigvNzx5+S0LfJ+Zx6506VFvrbsG89//RjnMUzN8mshI7c7mVy
X-Gm-Gg: AeBDievde3sjYxb3S6wB0hxEUJ91LrwdM8kpN3+YITzErXU1d2dGXqJpRWbmsaf4Kpq
	EuDwOTPH9SqIRB/DUWwzJ4yEa2APKB3KzxycIJdJoNRPcojIFaODHyIRCQ+CZul2s8HoyMWBy+Z
	zmnGNQO6pGhw/ByT4KuCeHZm6dpBIXEQzmP1VEykgCK3Apg+/vj7ahkMDpMELJ3peYzp/DbPGv1
	nPVZ5CbH4eABcHG91I1/jk87TY9LaCl3wEU5AAzEX9zYrok5pRK30NUpPdH0gR6Ck1wr1abLrHj
	twpE1qNP9VILtIitU2nMi70B8IXXddeF9kEBH3OiCp7alk1Ty3P77ocuXsbt8d04O38Bu9Xmbt4
	fno/ykZcziT/4HfCJQNHxTu/L4Z3IScgIvvpGVCn2DDx60Un2ZCi3YnrYhux5SQxbdoh2tTnjYx
	sL9UykCUDAhA8S/wNYvhBOkostl83r3A==
X-Received: by 2002:a05:6000:2082:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-4411c18f7c5mr32364551f8f.37.1777065214727;
        Fri, 24 Apr 2026 14:13:34 -0700 (PDT)
Received: from fedora ([156.207.128.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm63845677f8f.3.2026.04.24.14.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:13:34 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	avagin@gmail.com,
	Pedro Falcato <pfalcato@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
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
	Ahmed Elaidy <elaidya225@gmail.com>
Subject: [PATCH v1 2/9] mm: add atomic VMA flags and set VM_MAYBE_GUARD as such
Date: Sat, 25 Apr 2026 00:12:36 +0300
Message-ID: <20260424211315.1072123-3-elaidya225@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424211315.1072123-1-elaidya225@gmail.com>
References: <20260424211315.1072123-1-elaidya225@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A97F54636EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,oracle.com,gmail.com,suse.de,suse.cz,kernel.org,linux.dev,linux.alibaba.com,arm.com,google.com,lwn.net,efficios.com,suse.com,redhat.com,goodmis.org,nvidia.com];
	TAGGED_FROM(0.00)[bounces-241047-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elaidya225@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

This patch adds the ability to atomically set VMA flags with only the mmap
read/VMA read lock held.

As this could be hugely problematic for VMA flags in general given that
all other accesses are non-atomic and serialised by the mmap/VMA locks, we
implement this with a strict allow-list - that is, only designated flags
are allowed to do this.

We make VM_MAYBE_GUARD one of these flags.

Link: https://lkml.kernel.org/r/97e57abed09f2663077ed7a36fb8206e243171a9.1763460113.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
(cherry picked from commit 568822502383acd57d7cc1c72ee43932c45a9524)
Signed-off-by: Ahmed Elaidy <elaidya225@gmail.com>
---
 include/linux/mm.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f1787efaedc5..a96c99066351 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -501,6 +501,9 @@ extern unsigned int kobjsize(const void *objp);
 /* This mask represents all the VMA flag bits used by mlock */
 #define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
 
+/* These flags can be updated atomically via VMA/mmap read lock. */
+#define VM_ATOMIC_SET_ALLOWED VM_MAYBE_GUARD
+
 /* Arch-specific flags to clear when updating VM flags on protection change */
 #ifndef VM_ARCH_CLEAR
 # define VM_ARCH_CLEAR	VM_NONE
@@ -843,6 +846,47 @@ static inline void vm_flags_mod(struct vm_area_struct *vma,
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
-- 
2.53.0


