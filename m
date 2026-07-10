Return-Path: <stable+bounces-273135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id czK/K7VrUGqOygIAu9opvQ
	(envelope-from <stable+bounces-273135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 05:49:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E547370D8
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 05:49:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=aaTcHP7m;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273135-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273135-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7C063025E5F
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 03:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B96730F7FF;
	Fri, 10 Jul 2026 03:48:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20B261B9E;
	Fri, 10 Jul 2026 03:48:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783655337; cv=none; b=nRLNYh7jYbFhsb6QzKFazp4FYDl78o6cSfKN3VuRAoG0sNyn+hrlbdlmRwcBEGC0dpJ2Tqs2IHNHODS5EyaYYklbJtb0KTdIrpElnQmziCa06lzGljaNtEJXTb937y2G65YT8DSJsgWEhr4Q6uIvxocSahVPAdZop8pCbzC6su4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783655337; c=relaxed/simple;
	bh=VktXdXLHfpiEZs8SUpasfK6oGF1OWwLCtlzh6CoP3qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBqgr3LF8Nvp1Ar9oDZ+UEd2ymeeStQYbBqo7jycjraPsVqT8kZzuMQhwCvsNmQj6bvjTMwVULOzJLVwIquzJtl+g7SD3MFkDOpIE9ywMZ7QqRU97Q9QYsU5yKcbi/yxqpQHCNtIthX+89ytNk94rMGslQY2aHf+6zkoIHCN0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aaTcHP7m; arc=none smtp.client-ip=115.124.30.98
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783655332; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8AK1eIZIM4gwAkDFaNwngBUDojHeaE9xY2rmvZIuvwQ=;
	b=aaTcHP7mIXj8NMnWxso3iw5oFZq3wyEP8yC3H1T9vlILknFW56KNBICbreZpwhuWhZYEfIMNjGQiRpQ9Q5yNSX6dFbrN+4erwcxIG2XiB5/lNkA3hKqns7aN0gB9cmgtWyvEHU3HE3ttHJ82mvr/2y21smZewslS6N9aX7R1LoU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X6mK60X_1783655330;
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X6mK60X_1783655330 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jul 2026 11:48:50 +0800
Message-ID: <c820fc9c-8e5a-4708-a773-3b005bcdb541@linux.alibaba.com>
Date: Fri, 10 Jul 2026 11:48:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable v2] mm/khugepaged: write all dirty file folios when
 collapsing
To: Pedro Falcato <pfalcato@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>
Cc: stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Song Liu <song@kernel.org>,
 Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>,
 Gregg Leventhal <gleventhal@janestreet.com>,
 Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260708151357.353173-1-pfalcato@suse.de>
 <ak556WxAZCyqQqbf@pedro-suse.lan>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ak556WxAZCyqQqbf@pedro-suse.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:stable@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:willy@infradead.org,m:song@kernel.org,m:ehagberg@janestreet.com,m:ziy@nvidia.com,m:gleventhal@janestreet.com,m:lance.yang@linux.dev,m:linux-mm@kvack.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273135-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23E547370D8



On 7/9/26 12:28 AM, Pedro Falcato wrote:
> Seems that I accidentally dropped linked list Cc's here, see
> https://lore.kernel.org/stable/20260708151357.353173-1-pfalcato@suse.de/
> 
> On Wed, Jul 08, 2026 at 04:13:57PM +0100, Pedro Falcato wrote:
>> [There is no upstream commit, as this code was removed by upstream
>>   commit 044925f9b565 ("mm: fs: remove filemap_nr_thps*() functions and their users")]
>>
>> As-is, khugepaged and writable-file opening exclude each other. A file
>> cannot be open writeable and have THPs (because the filesystem is not aware
>> of them). khugepaged will never collapse file pages for files that are
>> opened writeable. On an open(O_RDWR/O_WRONLY), the page cache for that
>> particular file is dropped. This is fine because nothing could've been
>> dirtied.
>>
>> However, there is an edge-case: collapse_file() might not be able to
>> coexist with concurrent writers, but it can coexist with dirty folios
>> (from previous writers). Therefore, the following can happen:
>>
>> open(file, O_RDWR)
>> write(file)
>> close(file)
>> madvise(file_mapping, MADV_COLLAPSE, some non-dirty range)
>> open(file, O_RDWR)
>>   nr_thps > 0
>>    truncate_inode_pages()
>>      /* THPs are cleared out, but so are the dirty folios */
>>
>> When this edge-case happens, there is data loss, as the dirty folios are
>> fully discarded.
>>
>> Fix it by fully writing back the page cache (and waiting) when collapsing
>> file THPs. Doing so provides the guarantee that no dirty folio will be
>> observed while there are active THPs. To fully ensure this is safe, the
>> invalidate_lock needs to be held while doing the writeout, so that
>> do_dentry_open()'s page cache truncation excludes this write-and-wait.
>>
>> As a side effect, move the nr_thps counter bumping outside the i_pages
>> lock. This is correct since the counter itself is an atomic_t and the
>> producer <-> consumer correctness is provided by a full memory barrier:
>> smp_mb() in collapse_file()/memory barrier implied by full ordering in
>> get_write_access() -> atomic_inc_unless_negative().
>>
>> Cc: stable@vger.kernel.org
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Song Liu <song@kernel.org>
>> Cc: Eric Hagberg <ehagberg@janestreet.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>> Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
>> Closes: https://lore.kernel.org/linux-mm/CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
>> Tested-by: Zi Yan <ziy@nvidia.com>
>> Tested-by: Lance Yang <lance.yang@linux.dev>
>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>> ---

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

