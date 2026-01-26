Return-Path: <stable+bounces-211607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ONIHKxqd2nCfQEAu9opvQ
	(envelope-from <stable+bounces-211607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:22:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB7E88C6B
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DBD53019C88
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276963385AE;
	Mon, 26 Jan 2026 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtwcXwrC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0A63375C3
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433737; cv=none; b=cbanui8pdPs1HIeSMK2oAsIhqnPSQBvrH8LoiIqC40nv9fMctDFHMBsYtHLLQRw/am3/avMmDdbOJlKjAhrchmW7tPexvSv5BX/9caLyjCCZof+ZVi03E0SYyuTtu8NHzARE+AfgYeU5OKi9n6jQJmnMaTYjReaz/kOfaItpPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433737; c=relaxed/simple;
	bh=PeYLkrkth5xA8FsqIL4au5lK1zLTVvA87l8O8jK3N+I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DwulpdAbVq/GAjGuLCLf6SVzd6dl8KSylR+oo8NxWDLVYtWXe0H0FqQ+0ybVVHyXPttauUSm8QM5tjaWd/KqXR0qgeOQp4c/01vi7JTVzAZGC+j+w+aMJek+J52l4bgWNbCWeEb/1ZCwlmlJFTQ6XjUdhJfotyY2mRqQaRJRO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gtwcXwrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3004DC16AAE;
	Mon, 26 Jan 2026 13:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769433737;
	bh=PeYLkrkth5xA8FsqIL4au5lK1zLTVvA87l8O8jK3N+I=;
	h=Subject:To:Cc:From:Date:From;
	b=gtwcXwrCepf7HDqfYAiS+7c321en6Jghle/cEfp7KjlqjOKGuK41vAIBbTjqMMyzK
	 U0HD8MV4AbEjPh8EmcJSnLulH+rf+P9BaGDz7DsaYo2r49mchS8ghuHa6dh24Ysx7H
	 02Yz6PKSeoL4TPfpRvLUXOxueys0ThUU5xcPe0OI=
Subject: FAILED: patch "[PATCH] mm: rename cpu_bitmap field to flexible_array" failed to apply to 6.6-stable tree
To: mathieu.desnoyers@efficios.com,aboorvad@linux.ibm.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,brauner@kernel.org,broonie@kernel.org,christian.koenig@amd.com,cl@linux.com,david@redhat.com,dennis@kernel.org,hannes@cmpxchg.org,liam.howlett@oracle.com,linmiaohe@huawei.com,liumartin@google.com,lorenzo.stoakes@oracle.com,mhiramat@kernel.org,mhocko@suse.com,mjguzik@gmail.com,paulmck@kernel.org,peterz@infradead.org,richard.weiyang@gmail.com,rientjes@google.com,roman.gushchin@linux.dev,rostedt@goodmis.org,rppt@kernel.org,shakeel.butt@linux.dev,sj@kernel.org,stable@vger.kernel.org,surenb@google.com,sweettea-kernel@dorminy.me,tglx@kernel.org,tj@kernel.org,vbabka@suse.cz,viro@zeniv.linux.org.uk,willy@infradead.org,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Jan 2026 14:22:04 +0100
Message-ID: <2026012604-january-twelve-0f4b@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211607-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DB7E88C6B
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6ac433f8b2590b09ca00863d218665729ac985f7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012604-january-twelve-0f4b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6ac433f8b2590b09ca00863d218665729ac985f7 Mon Sep 17 00:00:00 2001
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Wed, 24 Dec 2025 12:33:57 -0500
Subject: [PATCH] mm: rename cpu_bitmap field to flexible_array
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The cpu_bitmap flexible array now contains more than just the cpu_bitmap.
In preparation for changing the static mm_struct definitions to cover for
the additional space required, change the cpu_bitmap type from "unsigned
long" to "char", require an unsigned long alignment of the flexible array,
and rename the field from "cpu_bitmap" to "flexible_array".

Introduce the MM_STRUCT_FLEXIBLE_ARRAY_INIT macro to statically initialize
the flexible array.  This covers the init_mm and efi_mm static
definitions.

This is a preparation step for fixing the missing mm_cid size for static
mm_struct definitions.

Link: https://lkml.kernel.org/r/20251224173358.647691-3-mathieu.desnoyers@efficios.com
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

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index f5ff6e84a9b7..17b5f3415465 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -74,10 +74,10 @@ struct mm_struct efi_mm = {
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 	.user_ns		= &init_user_ns,
-	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
 #ifdef CONFIG_SCHED_MM_CID
 	.mm_cid.lock		= __RAW_SPIN_LOCK_UNLOCKED(efi_mm.mm_cid.lock),
 #endif
+	.flexible_array		= MM_STRUCT_FLEXIBLE_ARRAY_INIT,
 };
 
 struct workqueue_struct *efi_rts_wq;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 42af2292951d..110b319a2ffb 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1329,7 +1329,7 @@ struct mm_struct {
 	 * The mm_cpumask needs to be at the end of mm_struct, because it
 	 * is dynamically sized based on nr_cpu_ids.
 	 */
-	unsigned long cpu_bitmap[];
+	char flexible_array[] __aligned(__alignof__(unsigned long));
 };
 
 /* Copy value to the first system word of mm flags, non-atomically. */
@@ -1366,19 +1366,24 @@ static inline void __mm_flags_set_mask_bits_word(struct mm_struct *mm,
 			 MT_FLAGS_USE_RCU)
 extern struct mm_struct init_mm;
 
+#define MM_STRUCT_FLEXIBLE_ARRAY_INIT				\
+{								\
+	[0 ... sizeof(cpumask_t)-1] = 0				\
+}
+
 /* Pointer magic because the dynamic array size confuses some compilers. */
 static inline void mm_init_cpumask(struct mm_struct *mm)
 {
 	unsigned long cpu_bitmap = (unsigned long)mm;
 
-	cpu_bitmap += offsetof(struct mm_struct, cpu_bitmap);
+	cpu_bitmap += offsetof(struct mm_struct, flexible_array);
 	cpumask_clear((struct cpumask *)cpu_bitmap);
 }
 
 /* Future-safe accessor for struct mm_struct's cpu_vm_mask. */
 static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 {
-	return (struct cpumask *)&mm->cpu_bitmap;
+	return (struct cpumask *)&mm->flexible_array;
 }
 
 #ifdef CONFIG_LRU_GEN
@@ -1469,7 +1474,7 @@ static inline cpumask_t *mm_cpus_allowed(struct mm_struct *mm)
 {
 	unsigned long bitmap = (unsigned long)mm;
 
-	bitmap += offsetof(struct mm_struct, cpu_bitmap);
+	bitmap += offsetof(struct mm_struct, flexible_array);
 	/* Skip cpu_bitmap */
 	bitmap += cpumask_size();
 	return (struct cpumask *)bitmap;
diff --git a/mm/init-mm.c b/mm/init-mm.c
index a514f8ce47e3..c5556bb9d5f0 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -47,7 +47,7 @@ struct mm_struct init_mm = {
 #ifdef CONFIG_SCHED_MM_CID
 	.mm_cid.lock = __RAW_SPIN_LOCK_UNLOCKED(init_mm.mm_cid.lock),
 #endif
-	.cpu_bitmap	= CPU_BITS_NONE,
+	.flexible_array	= MM_STRUCT_FLEXIBLE_ARRAY_INIT,
 	INIT_MM_CONTEXT(init_mm)
 };
 


