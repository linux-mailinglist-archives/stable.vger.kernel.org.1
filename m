Return-Path: <stable+bounces-155109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA16AE194A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91CC5A5342
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC01277CA9;
	Fri, 20 Jun 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yWkPF11D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30A255250
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750416966; cv=none; b=pAQAHnrsewAxTlE41qF9XANrsZ/fjwS9cMmPG98kMA098j7IOGNC4Uhv6IrSHAncWUWCU4t/hu+5f+Ok63uw2AVVFTB38DVSvh9vogssDz3THgOKC3LX3yBaBstmUtfk7W5nSkBT7qNHFtoIEMwe9mVGV2/xIDxid1xCdTRXsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750416966; c=relaxed/simple;
	bh=EsF6dhdV0hcPdZX5hyLDetI/d07wXKNWUdVotxLh8tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdvEsgq1+kbqRVX+oJcYZhUpVVR+c/kivO2TV1upqRT3CGykY5pFx0R+BSCboDSCMteOcC6SoCYScQkP45Oy1/cK5IvE8sDpxs+yn8vk8qwuWvoyP+xsFHFwJREzjUF6nXrDoY96MVsuaizdhHf4/jqKerWpvw9vXamjvyyxbh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yWkPF11D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8E5C4CEED;
	Fri, 20 Jun 2025 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750416966;
	bh=EsF6dhdV0hcPdZX5hyLDetI/d07wXKNWUdVotxLh8tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yWkPF11DbHLhgrZK/dgSMv6ak/kRNuUJoXGJ7h5sHGOU61TC6PH0NXQwkpqMdxD/2
	 NwGZR3hje6/GMfk4MI5kbYr+IB+FM1xwpuxtHxCZVyL13AQ7C14sMQ5LwT7CtULlBA
	 zkYB3Rt7vQipqZ3F/QXHG9u8wSp3UyALHSK/ojDI=
Date: Fri, 20 Jun 2025 12:56:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shivank Garg <shivankg@amd.com>
Cc: stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alistair Popple <apopple@nvidia.com>,
	Dave Kleikamp <shaggy@kernel.org>,
	Donet Tom <donettom@linux.ibm.com>, Jane Chu <jane.chu@oracle.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.15.y 1/2] mm: add folio_expected_ref_count() for
 reference count calculation
Message-ID: <2025062048-front-wake-5de8@gregkh>
References: <2025062039-policy-handheld-01c6@gregkh>
 <20250620102817.1185620-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620102817.1185620-1-shivankg@amd.com>

On Fri, Jun 20, 2025 at 10:28:16AM +0000, Shivank Garg wrote:
> Patch series " JFS: Implement migrate_folio for jfs_metapage_aops" v5.
> 
> This patchset addresses a warning that occurs during memory compaction due
> to JFS's missing migrate_folio operation.  The warning was introduced by
> commit 7ee3647243e5 ("migrate: Remove call to ->writepage") which added
> explicit warnings when filesystem don't implement migrate_folio.
> 
> The syzbot reported following [1]:
>   jfs_metapage_aops does not implement migrate_folio
>   WARNING: CPU: 1 PID: 5861 at mm/migrate.c:955 fallback_migrate_folio mm/migrate.c:953 [inline]
>   WARNING: CPU: 1 PID: 5861 at mm/migrate.c:955 move_to_new_folio+0x70e/0x840 mm/migrate.c:1007
>   Modules linked in:
>   CPU: 1 UID: 0 PID: 5861 Comm: syz-executor280 Not tainted 6.15.0-rc1-next-20250411-syzkaller #0 PREEMPT(full)
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
>   RIP: 0010:fallback_migrate_folio mm/migrate.c:953 [inline]
>   RIP: 0010:move_to_new_folio+0x70e/0x840 mm/migrate.c:1007
> 
> To fix this issue, this series implement metapage_migrate_folio() for JFS
> which handles both single and multiple metapages per page configurations.
> 
> While most filesystems leverage existing migration implementations like
> filemap_migrate_folio(), buffer_migrate_folio_norefs() or
> buffer_migrate_folio() (which internally used folio_expected_refs()),
> JFS's metapage architecture requires special handling of its private data
> during migration.  To support this, this series introduce the
> folio_expected_ref_count(), which calculates external references to a
> folio from page/swap cache, private data, and page table mappings.
> 
> This standardized implementation replaces the previous ad-hoc
> folio_expected_refs() function and enables JFS to accurately determine
> whether a folio has unexpected references before attempting migration.
> 
> Implement folio_expected_ref_count() to calculate expected folio reference
> counts from:
> - Page/swap cache (1 per page)
> - Private data (1)
> - Page table mappings (1 per map)
> 
> While originally needed for page migration operations, this improved
> implementation standardizes reference counting by consolidating all
> refcount contributors into a single, reusable function that can benefit
> any subsystem needing to detect unexpected references to folios.
> 
> The folio_expected_ref_count() returns the sum of these external
> references without including any reference the caller itself might hold.
> Callers comparing against the actual folio_ref_count() must account for
> their own references separately.
> 
> Link: https://syzkaller.appspot.com/bug?extid=8bb6fd945af4e0ad9299 [1]
> Link: https://lkml.kernel.org/r/20250430100150.279751-1-shivankg@amd.com
> Link: https://lkml.kernel.org/r/20250430100150.279751-2-shivankg@amd.com
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Dave Kleikamp <shaggy@kernel.org>
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: Jane Chu <jane.chu@oracle.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/mm.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>  mm/migrate.c       | 22 ++++---------------
>  2 files changed, 59 insertions(+), 18 deletions(-)
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

