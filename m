Return-Path: <stable+bounces-247749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMJ0Ch4aB2rnrgIAu9opvQ
	(envelope-from <stable+bounces-247749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:05:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA0F55028A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CD923189E80
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C8A3C5552;
	Fri, 15 May 2026 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/FpgMTE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE523CFF68
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849030; cv=none; b=b3QAPWE9zc4/PNwsK+wXc1G4FOe69ZqyJBr4k4mJ/LcDCpeJHfS8gRaDBjv2rm5LsTy0NTmrVlk0ElbcfiLrLQOT5+Mp3K8SByjksbTyBBUuBcsk5aO1En2l0AQnRClwiNfsS8I23v+QuM/jcbba3tZtItwn9NNMl5/PHQDZHDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849030; c=relaxed/simple;
	bh=Nj+EYu08ehZSGEHy+AEsaZh1G029liuTkPJQYY5oTrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipgQiP/QhXceyQ+YgRJo01MILPZQBy+/dFa2yAvejCVHIoY2yxJG0TG8O6aN3yCPSYEQzXjHuZnewgXzKV7HryavRoEI1CcjVZ4ZA+6/l/jf8tevLOIT1R+/eYWqFnliO/7QH+hBKmDKs+GyJmNRRKwQEVDzoDHveqgbW1y3JSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/FpgMTE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so151018325e9.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778849027; x=1779453827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuXpdMtSnDfGpZVmjIfUouOlQ5gFe/YG7aOKwEOn+Uk=;
        b=T/FpgMTE5c9jmR4FLF2nYPrNC9pINsk4x7PIyaWRvzeX2wfgG87jPrmuE0+2bn3zef
         0qQlHML+epYpThwe/GVw1q8fD/dAHzxdX0ob/EtRAqWV2DqFaUQQxzgCk+LSkAB3ABJP
         +R0hq+nMo0vYhWeB3m8J5XarSH1XVW1uoTTdRoEkaqi2PSio3BARQXl75+zk0EmJvYD9
         YkBIxP89YN1+OYKcQwiVjYKtoAxbkh9xufS+0CITsb1HbitorcC8fe2md8ZlobbToeWQ
         EDGkFC10+5Rub783drwe+5t1OopJWXUWMYSbB3E3roBvFndYBkJeQhgGlc+pzpdHrhbF
         +jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849027; x=1779453827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GuXpdMtSnDfGpZVmjIfUouOlQ5gFe/YG7aOKwEOn+Uk=;
        b=ISWzrZVOJK0oSPdQrdoJELsqL58j3GeVYY90O04pFej+L8mE3fARhBaYTaqJaNOFpt
         4NZSp0oXMw0cfW1N2yxT5nAeTd0CDjbUYUOIj+1AxiyklqO4WsTEwGMShAqNViB+aixp
         zBqR6iSbEh7b7hqkvbcsRA/gMY+JgNfSIIMvEVjTd56Tze94fcUM4rNGMPgFesBmLDOL
         gM4h1BhzojjKuEt/3ZLsKGH7sEra8OPC0qOYQXtyqzgOSy3W0biNgKk//KF+qJSy5Faw
         O/smFv47y67d/LxCTiQQf2q02C1zbU3KCZ9kdj/+meU8+rxGSZiZQinQKW25u53noPAP
         T4gg==
X-Gm-Message-State: AOJu0Yx6GLy3sX2SZzy78yyyzboPGTulXte2neWy5Wm1myKynkEz7LlR
	vUz38ys2rDnvjxmWmhwUBgJKVZ+4ErmF0RS/nrWIU3zE3/ZccdlUecb2+shsu8aW
X-Gm-Gg: Acq92OHMFV37fwIxPotCSJ5MXk8Wtle93xLTJclPvmuWlwxizFOrLJEig+Q7qG32UCN
	U3dixVCvKkTeSw4DRPRdQL+XGKgpgkmS4eOV9BZGuL3s/h11uCI5U1AXFVpBY3VKp4JqiJ7QOhm
	ilIAhtBAn2NfcwKO9kOG1u5W96y4tUMdEzHVpGp4tHBHN+VLN71F8IQVA2T/ntckeaTtTqnwril
	0w6N66Tw9Cc4NiG0rGZ8+lVi4Lb2V3vTDelQSUzHPGVXj5biTYiKChuTaE94lL0GgXbSQetCtvV
	ordqXBOtTP5nEH+MYFdW7oSjmuLjqlF/O4+zt35oQ+3kOK/+z9qfE9ZGTPUiZUfKvf4sxoJB8Xu
	R3X8X0IJr8FIfreowERZNyK5mGxbHWi6xwo+g/PyW2awDXVrTcx5DO1mmUZ2wQrFVmoGdSoVC0H
	ZgS7UvMn+5ZVsMC+7p2BJpL9Nt0/E1+Q==
X-Received: by 2002:a05:600c:8b18:b0:485:3b9e:caa7 with SMTP id 5b1f17b1804b1-48fe6515983mr57198095e9.23.1778849027404;
        Fri, 15 May 2026 05:43:47 -0700 (PDT)
Received: from fedora ([156.207.183.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm100188115e9.1.2026.05.15.05.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:43:47 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	avagin@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
Subject: [PATCH v4 2/9] mm: add atomic VMA flags and set VM_MAYBE_GUARD as such
Date: Fri, 15 May 2026 15:42:12 +0300
Message-ID: <20260515124218.151966-4-elaidya225@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515124218.151966-2-elaidya225@gmail.com>
References: <20260515124218.151966-2-elaidya225@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AFA0F55028A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,gmail.com,oracle.com,suse.de,suse.cz,linux.dev,linux.alibaba.com,arm.com,google.com,lwn.net,efficios.com,suse.com,redhat.com,goodmis.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-247749-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elaidya225@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

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
(cherry picked from commit 568822502383acd57d7cc1c72ee43932c45a9524)
Signed-off-by: Ahmed Elaidy <elaidya225@gmail.com>

Cc: stable@vger.kernel.org # 6.18.x
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
2.54.0


