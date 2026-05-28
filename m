Return-Path: <stable+bounces-254745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PFILNz0F2rNXQgAu9opvQ
	(envelope-from <stable+bounces-254745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:55:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEE35EE117
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9AE493074626
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 07:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D01D350D7D;
	Thu, 28 May 2026 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D4FqUE9p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85927F01E
	for <stable@vger.kernel.org>; Thu, 28 May 2026 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954642; cv=none; b=SJQnWH2chjLJJ9QAeFRLcLtEGKj1gzDoijUqxr3T+y4Bp1ID9wkMqcrztTfdGlSGkafMWUqN4G37KZ+UtShusBZsezruVynf4ZDKZKnBXX/yIg0ZqQVEHh836b/qUlBBJiDAs9eLtDmAi+NsuguNrCLRjxR0EwiSiYGq4fhqji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954642; c=relaxed/simple;
	bh=7HZ+umvtfHB+JJBQolNw1gUzI4fyFTQxAKyfufWgn8o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rILpBNIysGkv97nxgEofeNTlOu/fPbwIRnuhX5mNuzMOaGXc5zzC3zGfLRw7JIsrTE5Grdt0sSz8awhoV+kWOaRTNhXYUbk+5K2+huIzzwrE6sLvxWYQjtO5GwpH0V3eIoLHoja+xVKFkU2+jdIkqUyN38h9cenuV2MB01tba9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D4FqUE9p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C8C1F000E9;
	Thu, 28 May 2026 07:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779954640;
	bh=K1/rSQPjfV9FZgQacZwwxVcyZrFfRLGFn2MIjjx6c/4=;
	h=Subject:To:Cc:From:Date;
	b=D4FqUE9p1KcDclH/7lGDjf9B3oq5GsseObxTjeN2mXNrXfny0E4bN/VlXJ6L8qy3c
	 xVgiZYSwtHNdATikSgX1qlx+3KieFgYMwDA2qMsMO2k1fEU2cTJXRrsLysWa1zXX0B
	 v6WAPj8L8kbQ6BwfsCotrwj7AiDBre9+/pKi4KBk=
Subject: FAILED: patch "[PATCH] mm/memory: fix spurious warning when unmapping" failed to apply to 6.6-stable tree
To: apopple@nvidia.com,aarsenovic@baylibre.com,akpm@linux-foundation.org,balbirs@nvidia.com,david@kernel.org,jgg@ziepe.ca,jhubbard@nvidia.com,leon@kernel.org,liam@infradead.org,ljs@kernel.org,matthew.brost@intel.com,mhocko@suse.com,peterx@redhat.com,rppt@kernel.org,shuah@kernel.org,stable@vger.kernel.org,surenb@google.com,thomas.hellstrom@linux.intel.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 09:49:44 +0200
Message-ID: <2026052844-trance-donation-2634@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254745-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AFEE35EE117
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x be3f38d05cc5a7c3f13e51994c5dd043ab604d28
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052844-trance-donation-2634@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be3f38d05cc5a7c3f13e51994c5dd043ab604d28 Mon Sep 17 00:00:00 2001
From: Alistair Popple <apopple@nvidia.com>
Date: Fri, 1 May 2026 16:51:16 +1000
Subject: [PATCH] mm/memory: fix spurious warning when unmapping
 device-private/exclusive pages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Device private and exclusive entries are only supported for anonymous
folios.  This condition is tested in __migrate_device_pages() and
make_device_exclusive() using folio_test_anon().  However the unmap path
tests this assumption using vma_is_anonymous().

This is wrong because whilst anonymous VMAs can only contain folios where
folio_test_anon() is true the opposite relation does not hold.  A folio
for which folio_test_anon() is true does not imply vma_is_anonymous() is
true.  Such a condition can occur if for example a folio is part of a
private filebacked mapping.

In this case vma_is_anonymous() is false as the mapping is filebacked, but
folio_test_anon() may be true, thus permitting devices to migrate the
folio to device private memory.  This can lead to the following spurious
warnings during process teardown:

[  772.737706] ------------[ cut here ]------------
[  772.739201] WARNING: mm/memory.c:1754 at unmap_page_range.cold+0x26/0x18a, CPU#17: hmm-tests/2041
[  772.742050] Modules linked in: test_hmm nvidia_uvm(O) nvidia(O)
[  772.743959] CPU: 17 UID: 0 PID: 2041 Comm: hmm-tests Tainted: G        W  O        7.0.0+ #387 PREEMPT(full)
[  772.747104] Tainted: [W]=WARN, [O]=OOT_MODULE
[  772.748509] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[  772.752117] RIP: 0010:unmap_page_range.cold+0x26/0x18a
[  772.753780] Code: 7e fe ff ff 48 89 4c 24 78 4c 89 44 24 38 e8 f2 ff b1 00 48 8b 4c 24 78 4c 8b 44 24 38 48 8b 44 24 18 48 83 78 48 00 74 04 90 <0f> 0b 90 48 89 ca b8 ff ff 37 00 48 c1 ea 03 48 c1 e0 2a 80 3c 02
[  772.759602] RSP: 0018:ffff888112607550 EFLAGS: 00010286
[  772.761310] RAX: ffff88811bbf4dc0 RBX: dffffc0000000000 RCX: ffffea03e9bfffd8
[  772.763583] RDX: 1ffff1102377e9c1 RSI: 0000000000000008 RDI: ffff88811bbf4e08
[  772.765914] RBP: 0000000000000006 R08: ffff8881059f7448 R09: ffffed10224c0e68
[  772.768184] R10: ffff888112607347 R11: 0000000000000001 R12: 0000000000000001
[  772.770461] R13: ffffea03e9bfffc0 R14: ffff888112607908 R15: ffffea03e9bfffc0
[  772.772782] FS:  00007f327caa2780(0000) GS:ffff888427b7d000(0000) knlGS:0000000000000000
[  772.775328] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  772.777187] CR2: 00007f327ca89000 CR3: 00000001994d5000 CR4: 00000000000006f0
[  772.779135] Call Trace:
[  772.779792]  <TASK>
[  772.780317]  ? dmirror_interval_invalidate+0x1a3/0x290 [test_hmm]
[  772.781873]  ? vm_normal_page_pud+0x2b0/0x2b0
[  772.782992]  ? __rwlock_init+0x150/0x150
[  772.784006]  ? lock_release+0x216/0x2b0
[  772.785008]  ? __mmu_notifier_invalidate_range_start+0x505/0x6e0
[  772.786522]  ? lock_release+0x216/0x2b0
[  772.787498]  ? unmap_single_vma+0xb6/0x210
[  772.788573]  unmap_vmas+0x27d/0x520
[  772.789506]  ? unmap_single_vma+0x210/0x210
[  772.790607]  ? mas_update_gap.part.0+0x620/0x620
[  772.791834]  unmap_region+0x19e/0x350
[  772.792769]  ? remove_vma+0x130/0x130
[  772.793684]  ? mas_alloc_nodes+0x1f2/0x300
[  772.794730]  vms_complete_munmap_vmas+0x8c1/0xe20
[  772.795926]  ? unmap_region+0x350/0x350
[  772.796917]  do_vmi_align_munmap+0x36a/0x4e0
[  772.798018]  ? lock_release+0x216/0x2b0
[  772.799024]  ? vma_shrink+0x620/0x620
[  772.799983]  do_vmi_munmap+0x150/0x2c0
[  772.800939]  __vm_munmap+0x161/0x2c0
[  772.801872]  ? expand_downwards+0xd60/0xd60
[  772.802948]  ? clockevents_program_event+0x1ef/0x540
[  772.804217]  ? lock_release+0x216/0x2b0
[  772.805158]  __x64_sys_munmap+0x59/0x80
[  772.805776]  do_syscall_64+0xfc/0x670
[  772.806336]  ? irqentry_exit+0xda/0x580
[  772.806976]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  772.807772] RIP: 0033:0x7f327cbb2717
[  772.808323] Code: 73 01 c3 48 8b 0d f9 76 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 76 0d 00 f7 d8 64 89 01 48
[  772.811337] RSP: 002b:00007ffde7f57d38 EFLAGS: 00000202 ORIG_RAX: 000000000000000b
[  772.812564] RAX: ffffffffffffffda RBX: 00007f327cc9c000 RCX: 00007f327cbb2717
[  772.813733] RDX: 0000000000000000 RSI: 0000000000400000 RDI: 00007f327c289000
[  772.814867] RBP: 0000000000421360 R08: 000000000000001a R09: 0000000000000000
[  772.815991] R10: 0000000000000003 R11: 0000000000000202 R12: 00007ffde7f57d74
[  772.817121] R13: 00007f327c689010 R14: 0000000000100000 R15: 00007f327c289000
[  772.818272]  </TASK>
[  772.818614] irq event stamp: 0
[  772.819159] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  772.820174] hardirqs last disabled at (0): [<ffffffff82a57ab3>] copy_process+0x19f3/0x6440
[  772.821511] softirqs last  enabled at (0): [<ffffffff82a57b00>] copy_process+0x1a40/0x6440
[  772.822869] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  772.823871] ---[ end trace 0000000000000000 ]---

Fix this by using the same check for folio_test_anon() in
zap_nonpresent_ptes(). Also add a hmm-test case for this.

Link: https://lore.kernel.org/20260501065116.2057242-1-apopple@nvidia.com
Fixes: 999dad824c39 ("mm/shmem: persist uffd-wp bit across zapping for file-backed")
Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reported-by: Arsen Arsenović <aarsenovic@baylibre.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory.c b/mm/memory.c
index c51ad671b95f..86a973119bd4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1755,7 +1755,7 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		 * consider uffd-wp bit when zap. For more information,
 		 * see zap_install_uffd_wp_if_needed().
 		 */
-		WARN_ON_ONCE(!vma_is_anonymous(vma));
+		WARN_ON_ONCE(!folio_test_anon(folio));
 		rss[mm_counter(folio)]--;
 		folio_remove_rmap_pte(folio, page, vma);
 		folio_put(folio);
diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index 788689497e92..77fb4c5d871b 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -985,6 +985,56 @@ TEST_F(hmm, migrate)
 	hmm_buffer_free(buffer);
 }
 
+/*
+ * Migrate private file memory to device private memory.
+ */
+TEST_F(hmm, migrate_file_private)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+	int fd;
+
+	npages = ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size = npages << self->page_shift;
+
+	fd = hmm_create_file(size);
+	ASSERT_GE(fd, 0);
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = fd;
+	buffer->size = size;
+	buffer->mirror = malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr = mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] = i;
+
+	/* Migrate memory to device. */
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
 /*
  * Migrate anonymous memory to device private memory and fault some of it back
  * to system memory, then try migrating the resulting mix of system and device


