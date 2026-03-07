Return-Path: <stable+bounces-223408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ga9IkWbq2kLewEAu9opvQ
	(envelope-from <stable+bounces-223408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 04:28:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE61229E88
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 04:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F277D30465F0
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 03:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4BE30DED5;
	Sat,  7 Mar 2026 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXvemofJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EE52FDC57;
	Sat,  7 Mar 2026 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854081; cv=none; b=jlE67jlrl1PO0k5peb/oqmzb65+V9VEfY6k6Q91OeUIrI3ZJgto4KS4sUzyQo0ag8ARStieeTLkv4jLpStabiCF15tg968SbN3Ns89JXfwjl4uT5qQ2tBT9t55yECVRnh36AmZzuig8ZWCBdUvaukciWhpBaeX0Wk17+9M5DI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854081; c=relaxed/simple;
	bh=XSY0RglEN64n9U43+fR8Oah0dHCIZP40nqmbgL8bEdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Br7kzc8Asp9pdeatS1fPUCxKGvCI2wStCRgV50qz+0zDnbKn1VEoSCE4RdCApGv9PvtaDUr5gh92yn6SvHnZaUXHlROvdtQnJ+QPubjufAtehHBZ0LaxaNqkiL9y8ux66p1KiWB9N+ptlwLQCgDKwyAjjXO5EmIrM+UulrtE4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXvemofJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7688C19422;
	Sat,  7 Mar 2026 03:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772854081;
	bh=XSY0RglEN64n9U43+fR8Oah0dHCIZP40nqmbgL8bEdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXvemofJV3TLQz/8HqUT4pHQ9j+A+om0GqwG8KoD8BAR9KEOOIyGHzQoD9I59E2+g
	 DGSV485DaT66aPMYg8swPqZsVCFMYhLUgHn41efx6RkbWoZDtSQJon/e/+rZN0udwX
	 Wfjl5c5L3gxNBXEhmrEj3FM0UlED/2BaTEFKWxM+lkGPWrk55jRtkAQ36UGzeFbzDA
	 AmKq83K3dGMzPYWVJglGFQW2Jb+3ZTHdoV+FOVuJoV4dG7JjA9vfwU02YwGkeBCSSJ
	 PjgRCYwtuTJUgmYh7FnynTNcDyyFVaF+ZDo84NPK38Qe5znSyTWUUZAbP+NFx6nPNl
	 cYN+dN3v3qY7A==
From: SeongJae Park <sj@kernel.org>
To: Jianhui Zhou <jianhuizzzzz@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jonas Zhou <jonaszhou@zhaoxin.com>,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: fix hugetlb fault mutex hash calculation
Date: Fri,  6 Mar 2026 19:27:57 -0800
Message-ID: <20260307032759.100915-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306140332.171078-1-jianhuizzzzz@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DCE61229E88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223408-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Action: no action

Hello Jianhui,

On Fri,  6 Mar 2026 22:03:32 +0800 Jianhui Zhou <jianhuizzzzz@gmail.com> wrote:

> In mfill_atomic_hugetlb(), linear_page_index() is used to calculate the
> page index for hugetlb_fault_mutex_hash(). However, linear_page_index()
> returns the index in PAGE_SIZE units, while hugetlb_fault_mutex_hash()
> expects the index in huge page units (as calculated by
> vma_hugecache_offset()). This mismatch means that different addresses
> within the same huge page can produce different hash values, leading to
> the use of different mutexes for the same huge page. This can cause
> races between faulting threads, which can corrupt the reservation map
> and trigger the BUG_ON in resv_map_release().
> 
> Fix this by replacing linear_page_index() with vma_hugecache_offset()
> and applying huge_page_mask() to align the address properly. To make
> vma_hugecache_offset() available outside of mm/hugetlb.c, move it to
> include/linux/hugetlb.h as a static inline function.
> 
> Fixes: 60d4d2d2b40e ("userfaultfd: hugetlbfs: add __mcopy_atomic_hugetlb for huge page UFFDIO_COPY")
> Reported-by: syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f525fd79634858f478e7
> Cc: stable@vger.kernel.org
> Signed-off-by: Jianhui Zhou <jianhuizzzzz@gmail.com>
> ---
[...]
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
[...]
> +static inline pgoff_t vma_hugecache_offset(struct hstate *h,
> +		struct vm_area_struct *vma, unsigned long address)
> +{
> +	return linear_page_index(vma, address);
> +}
> +

I just found this patch makes UML build fails as below.

    $ make ARCH=um O=.kunit olddefconfig
    Building with:
    $ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=8
    ERROR:root:In file included from ../io_uring/rsrc.c:9:
    ../include/linux/hugetlb.h: In function ‘vma_hugecache_offset’:
    ../include/linux/hugetlb.h:1214:16: error: implicit declaration of function ‘linear_page_index’ [-Wimplicit-function-declaration]
     1214 |         return linear_page_index(vma, address);
          |                ^~~~~~~~~~~~~~~~~

Maybe we need to include pagemap.h?  I confirmed below attaching patch fix the
error on my setup.


Thanks,
SJ

[...]
=== >8 ===
From f55581ba154d6c8aaaf1f1d33cc317b5bf463147 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Fri, 6 Mar 2026 19:23:28 -0800
Subject: [PATCH] mm/hugetlb: include pagemap.h to fix build error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Without this, UML build fails as below:

    $ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=8
    ERROR:root:In file included from ../io_uring/rsrc.c:9:
    ../include/linux/hugetlb.h: In function ‘vma_hugecache_offset’:
    ../include/linux/hugetlb.h:1214:16: error: implicit declaration of function ‘linear_page_index’ [-Wimplicit-function-declaration]
     1214 |         return linear_page_index(vma, address);
          |                ^~~~~~~~~~~~~~~~~

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/hugetlb.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3f994f3e839cf..63426bd716839 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -15,6 +15,7 @@
 #include <linux/gfp.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/nodemask.h>
+#include <linux/pagemap.h>
 
 struct mmu_gather;
 struct node;
-- 
2.47.3


