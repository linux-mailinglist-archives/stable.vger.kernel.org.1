Return-Path: <stable+bounces-271616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id krZWHX8xR2qLUAAAu9opvQ
	(envelope-from <stable+bounces-271616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 05:50:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C2D6FE441
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 05:50:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=IudMrMT9;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271616-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271616-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5455B3042E4C
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 03:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5654D31A575;
	Fri,  3 Jul 2026 03:50:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9F314B73;
	Fri,  3 Jul 2026 03:50:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783050615; cv=none; b=lnr8S3bvDMzApCDZgg2JL1G5johc0ZS6O5VVvRhHeRFgVt6ICUcFH9Hc5vrFeEaMmI2ax5gf1qPREZNFPdSe2xTxkgMBRKKQu3hamPDBRGcQ417EnGKYPVoCPLfeYVMTrS4cvkUp8nvRK44wKe/le3mKPfynNr7BFmVyYxyHwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783050615; c=relaxed/simple;
	bh=C1Dk6PWrUq2lHI+FnCZhVqWbxD0AEvUeWEEaklxKxC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ug8g4Gp/unsOw2YZqixa2z6eNJzJMM/pdWzlUnk/uHnOM2vJpAn5Oq96wjRFT9TDANQjiStdbQ+X91YXrBrtkn5WLDAWG/tT8EtDuFqgrea1KoV4PNnWiFhTbTcylhzQEXb7bs58nniKAtZQJA/g6v+uStCOAWkg3GazrZT/zTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IudMrMT9; arc=none smtp.client-ip=115.124.30.113
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783050596; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XG2onznUxb2a1bjAl7eu7EX+0tUl3lnnp+uaCTwK2zc=;
	b=IudMrMT9+lPk1sjRVPyycDCCyf5DE6rFfCYTLCCHBEhqu4HBFQRp3hZpI+loW/JaeuHt2TARZBBjgm/m+aejPG6mpROYxCORikNgIFDBsQdeSILWGIVmNuetTBL3Y/v6wedKyB6XteJlkOhYRzbBcwGVwujQOvc0/b1ghi0QQkQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X6Hnc.J_1783050593;
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X6Hnc.J_1783050593 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jul 2026 11:49:54 +0800
Message-ID: <110e92b2-f7a6-487a-94a2-25ef1242afb7@linux.alibaba.com>
Date: Fri, 3 Jul 2026 11:49:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when
 collapsing
To: Pedro Falcato <pfalcato@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Song Liu <song@kernel.org>,
 Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>,
 Gregg Leventhal <gleventhal@janestreet.com>
References: <20260702165409.164568-1-pfalcato@suse.de>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260702165409.164568-1-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:willy@infradead.org,m:song@kernel.org,m:ehagberg@janestreet.com,m:ziy@nvidia.com,m:gleventhal@janestreet.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271616-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1C2D6FE441



On 7/3/26 12:54 AM, Pedro Falcato wrote:
> As-is, khugepaged and writable-file opening exclude each other. A file
> cannot be open writeable and have THPs (because the filesystem is not aware
> of them). khugepaged will never collapse file pages for files that are
> opened writeable. On an open(O_RDWR/O_WRONLY), the page cache for that
> particular file is dropped. This is fine because nothing could've been
> dirtied.
> 
> However, there is an edge-case: collapse_file() might not be able to
> coexist with concurrent writers, but it can coexist with dirty folios
> (from previous writers). Therefore, the following can happen:
> 
> open(file, O_RDWR)
> write(file)
> close(file)
> madvise(file_mapping, MADV_COLLAPSE, some non-dirty range)
> open(file, O_RDWR)
>   nr_thps > 0
>    truncate_inode_pages()
>      /* THPs are cleared out, but so are the dirty folios */
> 
> When this edge-case happens, there is data loss, as the dirty folios are
> fully discarded.
> 
> Fix it by fully writing back the page cache (and waiting) when collapsing
> file THPs. Doing so provides the guarantee that no dirty folio will be
> observed while there are active THPs. To fully ensure this is safe, the
> invalidate_lock needs to be held while doing the writeout, so that
> do_dentry_open()'s page cache truncation excludes this write-and-wait.

Thanks for explaining the race, and it looks reasonable to me. One nit 
below.

> Cc: stable@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Song Liu <song@kernel.org>
> Cc: Eric Hagberg <ehagberg@janestreet.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
> Closes: https://lore.kernel.org/linux-mm/CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
> Tested-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
> This patch is written against 7.1.0 (because the code no longer exists in mainline).
> 
> Zi, I kept your Tested-by, but I had to move some things around and
> use the invalidate lock. Please re-test if you can.
> 
>   mm/khugepaged.c | 39 +++++++++++++++++++++++++--------------
>   1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b8452dbdb043..0707d719a270 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2094,32 +2094,43 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>   		goto xa_unlocked;
>   	}
>   
> -	if (!is_shmem) {
> +xa_locked:
> +	xas_unlock_irq(&xas);
> +xa_unlocked:
> +
> +	/*
> +	 * If collapse is successful, flush must be done now before copying.
> +	 * If collapse is unsuccessful, does flush actually need to be done?
> +	 * Do it anyway, to clear the state.
> +	 */
> +	try_to_unmap_flush();
> +
> +	if (result == SCAN_SUCCEED && !is_shmem) {

Actually, the operations below only for those mappings that do not 
support large folios. For mappings with large folio support, 
filemap_nr_thps() always returns 0, so the race described in the commit 
message won't happen. We can add mapping_large_folio_support() here to 
filter them out.

if (result == SCAN_SUCCEED && !is_shmem && 
!mapping_large_folio_support(mapping)) {

Otherwise LGTM.

