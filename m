Return-Path: <stable+bounces-5142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A9880B43E
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF28E2810BE
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DCC11703;
	Sat,  9 Dec 2023 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EYs89VUS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0273C6ABB
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 12:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A29EC433C8;
	Sat,  9 Dec 2023 12:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702125381;
	bh=Z7pvnBY64/n8n2wE7kj3r27XdBkm5moUUQxIUvp35kI=;
	h=Subject:To:Cc:From:Date:From;
	b=EYs89VUSEXYMHni7POhVlRKigvp2j4vbtaNekLmtTB/FO/g2PFZ7F+Pl4vYhbys1j
	 NsaS8m1eWMBPT7J5CrRSoXdqQ0WpFiwoW4+a7ch72EPag5q29nSY52AladLRCB+XVP
	 8iDzSaZbrfRIIje2MU0qf1Lfpgbms1TU+io2W3BE=
Subject: FAILED: patch "[PATCH] mm/memory_hotplug: fix error handling in" failed to apply to 6.1-stable tree
To: sumanthk@linux.ibm.com,agordeev@linux.ibm.com,akpm@linux-foundation.org,aneesh.kumar@linux.ibm.com,anshuman.khandual@arm.com,david@redhat.com,gerald.schaefer@linux.ibm.com,gor@linux.ibm.com,hca@linux.ibm.com,lkp@intel.com,mhocko@suse.com,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Dec 2023 13:36:18 +0100
Message-ID: <2023120918-qualify-refutable-6c2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f42ce5f087eb69e47294ababd2e7e6f88a82d308
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120918-qualify-refutable-6c2a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

f42ce5f087eb ("mm/memory_hotplug: fix error handling in add_memory_resource()")
1a8c64e11043 ("mm/memory_hotplug: embed vmem_altmap details in memory block")
2d1f649c7c08 ("mm/memory_hotplug: support memmap_on_memory when memmap is not aligned to pageblocks")
85a2b4b08f20 ("mm/memory_hotplug: allow architecture to override memmap on memory support check")
e3c2bfdd33a3 ("mm/memory_hotplug: allow memmap on memory hotplug request to fallback")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f42ce5f087eb69e47294ababd2e7e6f88a82d308 Mon Sep 17 00:00:00 2001
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
Date: Mon, 20 Nov 2023 15:53:53 +0100
Subject: [PATCH] mm/memory_hotplug: fix error handling in
 add_memory_resource()

In add_memory_resource(), creation of memory block devices occurs after
successful call to arch_add_memory().  However, creation of memory block
devices could fail.  In that case, arch_remove_memory() is called to
perform necessary cleanup.

Currently with or without altmap support, arch_remove_memory() is always
passed with altmap set to NULL during error handling.  This leads to
freeing of struct pages using free_pages(), eventhough the allocation
might have been performed with altmap support via
altmap_alloc_block_buf().

Fix the error handling by passing altmap in arch_remove_memory(). This
ensures the following:
* When altmap is disabled, deallocation of the struct pages array occurs
  via free_pages().
* When altmap is enabled, deallocation occurs via vmem_altmap_free().

Link: https://lkml.kernel.org/r/20231120145354.308999-3-sumanthk@linux.ibm.com
Fixes: a08a2ae34613 ("mm,memory_hotplug: allocate memmap from the added memory range")
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: kernel test robot <lkp@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bb908289679e..7a5fc89a8652 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1458,7 +1458,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	/* create memory block devices after memory was added */
 	ret = create_memory_block_devices(start, size, params.altmap, group);
 	if (ret) {
-		arch_remove_memory(start, size, NULL);
+		arch_remove_memory(start, size, params.altmap);
 		goto error_free;
 	}
 


