Return-Path: <stable+bounces-81332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE9099309F
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475DB282221
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7190D1D8DF9;
	Mon,  7 Oct 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oBfXmxxJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD961D8A06
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313582; cv=none; b=iOc0aE8nm7kdVo8VBjxeUqLL1oKm9zrHYptW9r1vQ1LO2OKCo0vgR7W35k/9nHq1uRKmfbMLQB/fgutYaSzOZL33lM18VU+S7RwVchMi8kuYqCihwX1Hm1LiREyGo7h9iWLhl0obr7/eUciPS0vB+YCQsGCcTqpnFrNKcuA1hEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313582; c=relaxed/simple;
	bh=hv1nMbZfKSgcRI7jIb61P1v2KVqBu76rp+muM+USUZM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l7qO3gz9SUExGMkWlfvSTRzZ2S7/F6t4J5bnMoKUsER1pqhTIZPAF9e0ft5Nposi5rEWWW0nOzdJdrLuB8+HwT4w3xQ1L60xp5uUe5RjP7jYw+uWVkJGa7zEys+ILxlmdbeA42yFMeysLZPctwq9FeZGhqgCyOCDKjQk4R7vcqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oBfXmxxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F339C4CEC6;
	Mon,  7 Oct 2024 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728313582;
	bh=hv1nMbZfKSgcRI7jIb61P1v2KVqBu76rp+muM+USUZM=;
	h=Subject:To:Cc:From:Date:From;
	b=oBfXmxxJkwllBD3d7Jmxh8Gwm+VkWlnAQQSdAg3R1Lltnw2leZgDr/gDpj0vvLZf0
	 Eo6DSnpTn+LUwcgPBq3OMJWfqZ1mNVmZXBqfhojYaDWkMsFCNdquYxppTY2Dc79DZt
	 EsGdaShWnNyXRqxUBLzxkFricD35OYMqMyM0jWt4=
Subject: FAILED: patch "[PATCH] mm: z3fold: deprecate CONFIG_Z3FOLD" failed to apply to 6.1-stable tree
To: yosryahmed@google.com,akpm@linux-foundation.org,aneesh.kumar@kernel.org,arnd@arndb.de,chenhuacai@kernel.org,chris@chrisdown.name,christophe.leroy@csgroup.eu,hannes@cmpxchg.org,hch@lst.de,kernel@xen0n.name,linmiaohe@huawei.com,mpe@ellerman.id.au,naveen.n.rao@linux.ibm.com,nphamcs@gmail.com,npiggin@gmail.com,senozhatsky@chromium.org,stable@vger.kernel.org,vitaly.wool@konsulko.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:06:11 +0200
Message-ID: <2024100711-ebook-refund-46f3@gregkh>
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
git cherry-pick -x 7a2369b74abf76cd3e54c45b30f6addb497f831b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100711-ebook-refund-46f3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

7a2369b74abf ("mm: z3fold: deprecate CONFIG_Z3FOLD")
04cb7502a5d7 ("zsmalloc: use all available 24 bits of page_type")
43d746dc49bb ("mm/zsmalloc: use a proper page type")
8db00ad56461 ("mm: allow reuse of the lower 16 bit of the page type with an actual type")
6d21dde7adc0 ("mm: update _mapcount and page_type documentation")
ff202303c398 ("mm: convert page type macros to enum")
46df8e73a4a3 ("mm: free up PG_slab")
d99e3140a4d3 ("mm: turn folio_test_hugetlb into a PageType")
fd1a745ce03e ("mm: support page_mapcount() on page_has_type() pages")
29cfe7556bfd ("mm: constify more page/folio tests")
443cbaf9e2fd ("crash: split vmcoreinfo exporting code out from crash_core.c")
85fcde402db1 ("kexec: split crashkernel reservation code out from crash_core.c")
55c49fee57af ("mm/vmalloc: remove vmap_area_list")
d093602919ad ("mm: vmalloc: remove global vmap_area_root rb-tree")
7fa8cee00316 ("mm: vmalloc: move vmap_init_free_space() down in vmalloc.c")
4a693ce65b18 ("kdump: defer the insertion of crashkernel resources")
9f2a63523582 ("Merge tag 'mm-nonmm-stable-2024-01-09-10-33' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a2369b74abf76cd3e54c45b30f6addb497f831b Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 4 Sep 2024 23:33:43 +0000
Subject: [PATCH] mm: z3fold: deprecate CONFIG_Z3FOLD

The z3fold compressed pages allocator is rarely used, most users use
zsmalloc.  The only disadvantage of zsmalloc in comparison is the
dependency on MMU, and zbud is a more common option for !MMU as it was the
default zswap allocator for a long time.

Historically, zsmalloc had worse latency than zbud and z3fold but offered
better memory savings.  This is no longer the case as shown by a simple
recent analysis [1].  That analysis showed that z3fold does not have any
advantage over zsmalloc or zbud considering both performance and memory
usage.  In a kernel build test on tmpfs in a limited cgroup, z3fold took
3% more time and used 1.8% more memory.  The latency of zswap_load() was
7% higher, and that of zswap_store() was 10% higher.  Zsmalloc is better
in all metrics.

Moreover, z3fold apparently has latent bugs, which was made noticeable by
a recent soft lockup bug report with z3fold [2].  Switching to zsmalloc
not only fixed the problem, but also reduced the swap usage from 6~8G to
1~2G.  Other users have also reported being bitten by mistakenly enabling
z3fold.

Other than hurting users, z3fold is repeatedly causing wasted engineering
effort.  Apart from investigating the above bug, it came up in multiple
development discussions (e.g.  [3]) as something we need to handle, when
there aren't any legit users (at least not intentionally).

The natural course of action is to deprecate z3fold, and remove in a few
cycles if no objections are raised from active users.  Next on the list
should be zbud, as it offers marginal latency gains at the cost of huge
memory waste when compared to zsmalloc.  That one will need to wait until
zsmalloc does not depend on MMU.

Rename the user-visible config option from CONFIG_Z3FOLD to
CONFIG_Z3FOLD_DEPRECATED so that users with CONFIG_Z3FOLD=y get a new
prompt with explanation during make oldconfig.  Also, remove
CONFIG_Z3FOLD=y from defconfigs.

[1]https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com/
[2]https://lore.kernel.org/lkml/EF0ABD3E-A239-4111-A8AB-5C442E759CF3@gmail.com/
[3]https://lore.kernel.org/lkml/CAJD7tkbnmeVugfunffSovJf9FAgy9rhBVt_tx=nxUveLUfqVsA@mail.gmail.com/

[arnd@arndb.de: deprecate ZSWAP_ZPOOL_DEFAULT_Z3FOLD as well]
  Link: https://lkml.kernel.org/r/20240909202625.1054880-1-arnd@kernel.org
Link: https://lkml.kernel.org/r/20240904233343.933462-1-yosryahmed@google.com
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Chris Down <chris@chrisdown.name>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Vitaly Wool <vitaly.wool@konsulko.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index b4252c357c8e..75b366407a60 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -96,7 +96,6 @@ CONFIG_ZPOOL=y
 CONFIG_ZSWAP=y
 CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD=y
 CONFIG_ZBUD=y
-CONFIG_Z3FOLD=y
 CONFIG_ZSMALLOC=m
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MEMORY_HOTPLUG=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 544a65fda77b..d39284489aa2 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -81,7 +81,6 @@ CONFIG_MODULE_SIG_SHA512=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ZSWAP=y
-CONFIG_Z3FOLD=y
 CONFIG_ZSMALLOC=y
 # CONFIG_SLAB_MERGE_DEFAULT is not set
 CONFIG_SLAB_FREELIST_RANDOM=y
diff --git a/mm/Kconfig b/mm/Kconfig
index 1aa282e35dc7..09aebca1cae3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -146,12 +146,15 @@ config ZSWAP_ZPOOL_DEFAULT_ZBUD
 	help
 	  Use the zbud allocator as the default allocator.
 
-config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
-	bool "z3fold"
-	select Z3FOLD
+config ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
+	bool "z3foldi (DEPRECATED)"
+	select Z3FOLD_DEPRECATED
 	help
 	  Use the z3fold allocator as the default allocator.
 
+	  Deprecated and scheduled for removal in a few cycles,
+	  see CONFIG_Z3FOLD_DEPRECATED.
+
 config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
 	bool "zsmalloc"
 	select ZSMALLOC
@@ -163,7 +166,7 @@ config ZSWAP_ZPOOL_DEFAULT
        string
        depends on ZSWAP
        default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
-       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
+       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
        default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
        default ""
 
@@ -177,15 +180,25 @@ config ZBUD
 	  deterministic reclaim properties that make it preferable to a higher
 	  density approach when reclaim will be used.
 
-config Z3FOLD
-	tristate "3:1 compression allocator (z3fold)"
+config Z3FOLD_DEPRECATED
+	tristate "3:1 compression allocator (z3fold) (DEPRECATED)"
 	depends on ZSWAP
 	help
+	  Deprecated and scheduled for removal in a few cycles. If you have
+	  a good reason for using Z3FOLD over ZSMALLOC, please contact
+	  linux-mm@kvack.org and the zswap maintainers.
+
 	  A special purpose allocator for storing compressed pages.
 	  It is designed to store up to three compressed pages per physical
 	  page. It is a ZBUD derivative so the simplicity and determinism are
 	  still there.
 
+config Z3FOLD
+	tristate
+	default y if Z3FOLD_DEPRECATED=y
+	default m if Z3FOLD_DEPRECATED=m
+	depends on Z3FOLD_DEPRECATED
+
 config ZSMALLOC
 	tristate
 	prompt "N:1 compression allocator (zsmalloc)" if (ZSWAP || ZRAM)


