Return-Path: <stable+bounces-204745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A25CF3601
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88B7B3014DE5
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C15337BBF;
	Mon,  5 Jan 2026 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Udj3d+ah"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150F337BBA
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613851; cv=none; b=XGxG5NfnqgXZJXzZfJp+P7mrJERrhaYxWND2scG7FGjIoOcPrSYnsJgYldWuPfCXxzGsDWrjr6IK+/LLWGA77YwtxtaXKC52TjRYSTsNZjKKQRafoCog48u+ol+oCGZWNtsp3wZ+GxgxcJz3likQgsUyEjOfAkOWHaPGdkOFNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613851; c=relaxed/simple;
	bh=wLzoiOAv+b3Xnym+UBkZQripuQsSHHHja0RM+fgrE6k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AHKvGolPEU7yoV9KGVwZ04h0oaNkSFPkc9JcwE775bBbSwWotqBr5HbhnuuOSs81O4lsbQNiYkvaf+v4sjQv3Yz9iPQCW7KnvKzeyON7JOzv4viLBDLX8N7JwHZaFip2tPi59BtQQUxReWXenZTvw6JvMOrqu4XzYT8quGMcowg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Udj3d+ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB20C116D0;
	Mon,  5 Jan 2026 11:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767613850;
	bh=wLzoiOAv+b3Xnym+UBkZQripuQsSHHHja0RM+fgrE6k=;
	h=Subject:To:Cc:From:Date:From;
	b=Udj3d+ah47K2RoH3QeBSPTPzyaC1FIT3D60UEkAm4jx0Afk6E2bQu28BijMAQGqeb
	 wpTUKBn7TGhJtl1ZH8peuJJdMa6+IBQvagkga8H5+Bbks9cgF99mypODyE+tP/POOg
	 2be36z1LKOdr0MZrXFNn5po+we2fp+HkrJmPTvwM=
Subject: FAILED: patch "[PATCH] mm: consider non-anon swap cache folios in" failed to apply to 6.6-stable tree
To: bijan311@gmail.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,david@kernel.org,liam.howlett@oracle.com,lorenzo.stoakes@oracle.com,mhocko@suse.com,rppt@kernel.org,ryncsn@gmail.com,shivankg@amd.com,stable@vger.kernel.org,surenb@google.com,vbabka@suse.cz,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:50:45 +0100
Message-ID: <2026010545-tracing-morbidly-6a4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f183663901f21fe0fba8bd31ae894bc529709ee0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010545-tracing-morbidly-6a4d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f183663901f21fe0fba8bd31ae894bc529709ee0 Mon Sep 17 00:00:00 2001
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Tue, 16 Dec 2025 14:07:27 -0600
Subject: [PATCH] mm: consider non-anon swap cache folios in
 folio_expected_ref_count()

Currently, folio_expected_ref_count() only adds references for the swap
cache if the folio is anonymous.  However, according to the comment above
the definition of PG_swapcache in enum pageflags, shmem folios can also
have PG_swapcache set.  This patch makes sure references for the swap
cache are added if folio_test_swapcache(folio) is true.

This issue was found when trying to hot-unplug memory in a QEMU/KVM
virtual machine.  When initiating hot-unplug when most of the guest memory
is allocated, hot-unplug hangs partway through removal due to migration
failures.  The following message would be printed several times, and would
be printed again about every five seconds:

[   49.641309] migrating pfn b12f25 failed ret:7
[   49.641310] page: refcount:2 mapcount:0 mapping:0000000033bd8fe2 index:0x7f404d925 pfn:0xb12f25
[   49.641311] aops:swap_aops
[   49.641313] flags: 0x300000000030508(uptodate|active|owner_priv_1|reclaim|swapbacked|node=0|zone=3)
[   49.641314] raw: 0300000000030508 ffffed312c4bc908 ffffed312c4bc9c8 0000000000000000
[   49.641315] raw: 00000007f404d925 00000000000c823b 00000002ffffffff 0000000000000000
[   49.641315] page dumped because: migration failure

When debugging this, I found that these migration failures were due to
__migrate_folio() returning -EAGAIN for a small set of folios because the
expected reference count it calculates via folio_expected_ref_count() is
one less than the actual reference count of the folios.  Furthermore, all
of the affected folios were not anonymous, but had the PG_swapcache flag
set, inspiring this patch.  After applying this patch, the memory
hot-unplug behaves as expected.

I tested this on a machine running Ubuntu 24.04 with kernel version
6.8.0-90-generic and 64GB of memory.  The guest VM is managed by libvirt
and runs Ubuntu 24.04 with kernel version 6.18 (though the head of the
mm-unstable branch as a Dec 16, 2025 was also tested and behaves the same)
and 48GB of memory.  The libvirt XML definition for the VM can be found at
[1].  CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_MOVABLE is set in the guest
kernel so the hot-pluggable memory is automatically onlined.

Below are the steps to reproduce this behavior:

1) Define and start and virtual machine
  host$ virsh -c qemu:///system define ./test_vm.xml # test_vm.xml from [1]
  host$ virsh -c qemu:///system start test_vm

2) Setup swap in the guest
  guest$ sudo fallocate -l 32G /swapfile
  guest$ sudo chmod 0600 /swapfile
  guest$ sudo mkswap /swapfile
  guest$ sudo swapon /swapfile

3) Use alloc_data [2] to allocate most of the remaining guest memory
  guest$ ./alloc_data 45

4) In a separate guest terminal, monitor the amount of used memory
  guest$ watch -n1 free -h

5) When alloc_data has finished allocating, initiate the memory
hot-unplug using the provided xml file [3]
  host$ virsh -c qemu:///system detach-device test_vm ./remove.xml --live

After initiating the memory hot-unplug, you should see the amount of
available memory in the guest decrease, and the amount of used swap data
increase.  If everything works as expected, when all of the memory is
unplugged, there should be around 8.5-9GB of data in swap.  If the
unplugging is unsuccessful, the amount of used swap data will settle below
that.  If that happens, you should be able to see log messages in dmesg
similar to the one posted above.

Link: https://lkml.kernel.org/r/20251216200727.2360228-1-bijan311@gmail.com
Link: https://github.com/BijanT/linux_patch_files/blob/main/test_vm.xml [1]
Link: https://github.com/BijanT/linux_patch_files/blob/main/alloc_data.c [2]
Link: https://github.com/BijanT/linux_patch_files/blob/main/remove.xml [3]
Fixes: 86ebd50224c0 ("mm: add folio_expected_ref_count() for reference count calculation")
Signed-off-by: Bijan Tabatabai <bijan311@gmail.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Shivank Garg <shivankg@amd.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 15076261d0c2..6f959d8ca4b4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2459,10 +2459,10 @@ static inline int folio_expected_ref_count(const struct folio *folio)
 	if (WARN_ON_ONCE(page_has_type(&folio->page) && !folio_test_hugetlb(folio)))
 		return 0;
 
-	if (folio_test_anon(folio)) {
-		/* One reference per page from the swapcache. */
-		ref_count += folio_test_swapcache(folio) << order;
-	} else {
+	/* One reference per page from the swapcache. */
+	ref_count += folio_test_swapcache(folio) << order;
+
+	if (!folio_test_anon(folio)) {
 		/* One reference per page from the pagecache. */
 		ref_count += !!folio->mapping << order;
 		/* One reference from PG_private. */


