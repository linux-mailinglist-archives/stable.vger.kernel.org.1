Return-Path: <stable+bounces-211609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNeFB05rd2nCfQEAu9opvQ
	(envelope-from <stable+bounces-211609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:25:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D29B88CC1
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC0C5301ECFB
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98FE3019D9;
	Mon, 26 Jan 2026 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z5u1cMvS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7AE335BA1
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433745; cv=none; b=ibgtlFwZnHtximRwr9QH0EtMC5fpKrNjjkreEdVNYjQGHsE6oWu1T5YjzpUagOTJlEUMgECtpC0uUKDiHkRB4YZoZcDG5jUweMx16+qTce0zc3Fie2/6C5DGD8gEf3iDFDvwOXK9QfedrPfpHAysFapyEGT5vHaaoZ70tDhSuCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433745; c=relaxed/simple;
	bh=nB3MwEnHAhPg0SMEPwwPP3kSf0eARtipyShDBaue0Nw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VRRl2fmMSjrKV2fKaNxTdq2Qk8TC2hpnZVjGXUpbbFrT4A29zJPFpC7g+knlzLTnycjPBhbA73Urc0YJtnUNiEd7Gp0ZwUFresdljoldDsr0kpNxC4kjyGj8GlAtGDXe6F9D4VMFjLuXqFouzXctA0X/dQ1UbLbkolFatGB1jkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z5u1cMvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD57FC116C6;
	Mon, 26 Jan 2026 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769433745;
	bh=nB3MwEnHAhPg0SMEPwwPP3kSf0eARtipyShDBaue0Nw=;
	h=Subject:To:Cc:From:Date:From;
	b=z5u1cMvSc0gK1YlK9KlUx0+88+lJwTjnMmvxUJ1YJBnIGlUICh1OZXkcV71Mrjmtr
	 Kpm7kN2uqBDMqXVh3BHJb5OPSNQ5CRoE0f1ATYf38AmpQxW77198W6qTX4m+04ZgA4
	 sKQTRd8uR5YAmtJ1y63edfBQhSCZ7ozHpVY3czuU=
Subject: FAILED: patch "[PATCH] mm: take into account mm_cid size for mm_struct static" failed to apply to 6.12-stable tree
To: mathieu.desnoyers@efficios.com,aboorvad@linux.ibm.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,brauner@kernel.org,broonie@kernel.org,christian.koenig@amd.com,cl@linux.com,david@redhat.com,dennis@kernel.org,hannes@cmpxchg.org,liam.howlett@oracle.com,linmiaohe@huawei.com,liumartin@google.com,lorenzo.stoakes@oracle.com,mhiramat@kernel.org,mhocko@suse.com,mjguzik@gmail.com,paulmck@kernel.org,peterz@infradead.org,richard.weiyang@gmail.com,rientjes@google.com,roman.gushchin@linux.dev,rostedt@goodmis.org,rppt@kernel.org,shakeel.butt@linux.dev,sj@kernel.org,stable@vger.kernel.org,surenb@google.com,sweettea-kernel@dorminy.me,tglx@kernel.org,tj@kernel.org,vbabka@suse.cz,viro@zeniv.linux.org.uk,willy@infradead.org,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Jan 2026 14:22:17 +0100
Message-ID: <2026012617-cider-appease-fe6a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211609-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[efficios.com,linux.ibm.com,linux-foundation.org,linux.alibaba.com,kernel.org,amd.com,linux.com,redhat.com,cmpxchg.org,oracle.com,huawei.com,google.com,suse.com,gmail.com,infradead.org,linux.dev,goodmis.org,vger.kernel.org,dorminy.me,suse.cz,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D29B88CC1
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x be31340a4cc259340044b7fc4f7e97f58c74ee8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012617-cider-appease-fe6a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be31340a4cc259340044b7fc4f7e97f58c74ee8e Mon Sep 17 00:00:00 2001
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Wed, 24 Dec 2025 12:33:58 -0500
Subject: [PATCH] mm: take into account mm_cid size for mm_struct static
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Both init_mm and efi_mm static definitions need to make room for the 2
mm_cid cpumasks.

This fixes possible out-of-bounds accesses to init_mm and efi_mm.

Add a space between # and define for the mm_alloc_cid() definition to make
it consistent with the coding style used in the rest of this header file.

Link: https://lkml.kernel.org/r/20251224173358.647691-4-mathieu.desnoyers@efficios.com
Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Christan König <christian.koenig@amd.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Liam R . Howlett" <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Martin Liu <liumartin@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: SeongJae Park <sj@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 110b319a2ffb..aa4639888f89 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1368,7 +1368,7 @@ extern struct mm_struct init_mm;
 
 #define MM_STRUCT_FLEXIBLE_ARRAY_INIT				\
 {								\
-	[0 ... sizeof(cpumask_t)-1] = 0				\
+	[0 ... sizeof(cpumask_t) + MM_CID_STATIC_SIZE - 1] = 0	\
 }
 
 /* Pointer magic because the dynamic array size confuses some compilers. */
@@ -1500,7 +1500,7 @@ static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *
 	mm_init_cid(mm, p);
 	return 0;
 }
-#define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
+# define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
 
 static inline void mm_destroy_cid(struct mm_struct *mm)
 {
@@ -1514,6 +1514,8 @@ static inline unsigned int mm_cid_size(void)
 	return cpumask_size() + bitmap_size(num_possible_cpus());
 }
 
+/* Use 2 * NR_CPUS as worse case for static allocation. */
+# define MM_CID_STATIC_SIZE	(2 * sizeof(cpumask_t))
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p) { }
 static inline int mm_alloc_cid(struct mm_struct *mm, struct task_struct *p) { return 0; }
@@ -1522,6 +1524,7 @@ static inline unsigned int mm_cid_size(void)
 {
 	return 0;
 }
+# define MM_CID_STATIC_SIZE	0
 #endif /* CONFIG_SCHED_MM_CID */
 
 struct mmu_gather;


