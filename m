Return-Path: <stable+bounces-53802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A9D90E723
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D611C21203
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2380631;
	Wed, 19 Jun 2024 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="fAkkt5ML";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ppuEa6mT"
X-Original-To: stable@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A6C7E0E8
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789764; cv=none; b=OTYjCySUNMLkcpDT6lpGbveslMV2aM178CI0dDDdCTzLwhgsaYRubOzE4YOUPCsrpe19pLcTDHv3+vkE+/EixrAsJxyg+v+KtEFHTml8fBhtCYH2E8RL9W3PIqoNJYgXklzCkPMaicEx6UBq/r9Hncx4GvZDZu+NobSGLWPQiGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789764; c=relaxed/simple;
	bh=KK3UDnBSkRHivPMXDbmpimNBus/HWtjAu1XQz4lN4E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAJ88XJtoeEuwzIwlPYIm9k4B2iZMpP/f8y8jyrAApaw/qDWF8nVZCW3E/18SXaCsu1gwo5mvaogZ7PhwbTb8EgIX1dUTPeATXrcbKl9py0Nk3dZLGp7I4Xmq/66z/bXEH3ie4bnECaI4tOAwYTMCUYSZ8sVQ1TLCkw/qmu+YYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=fAkkt5ML; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ppuEa6mT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EF69911403BB;
	Wed, 19 Jun 2024 05:36:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 19 Jun 2024 05:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1718789760; x=1718876160; bh=k/6zXxUosv
	qDfEjmhjqrubZXOaHrSkFU0NFJYQMroak=; b=fAkkt5ML4K86Rbv9322bXfOTkB
	1H5OaoP26nPBkFRObFIexT/f4EbkvzMuvtifY6VteMWkE6U7FIkNc/N30bNkFpl1
	Su2flXXst4ghSXFfmV4ouTb5QOxyjL/kWDXEYmrivfV1KUk8XcwRFSlhQpmJOIg3
	c0l3ge5mZJtnvk46jsHhRUm+5HoHutoUEIBUxiqjsXbEduXYmw+4xjSlSj0ZRRBW
	KjAYbG4DkJtyP2zlDA0Gacu7NtpOtM1tyEEsjchWU6BA4AuA1AvmNiDvmWgX5Gln
	HD599TtCZ963KGUPJgZh+BojutN+CIeW0D30tyX6kW7dBTnXIJuRVfRWGHoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718789760; x=1718876160; bh=k/6zXxUosvqDfEjmhjqrubZXOaHr
	SkFU0NFJYQMroak=; b=ppuEa6mTmH6kBrxuKCubck7NcEOuOudkHEeUhIptzs00
	qvcSTNLidvkKIM2g4Tkt1ROON7pwrrI14qTdes9QQYoOallUbZa4V9MLxv7FccIH
	h9i0NvxhIeUYNhsCULUtiqEwjvPNHwTAgVS71xs8UCsrHtGtxL343rZ8LyQuMPO1
	Rxu7Kgc4WwxKAB1JWuimA6sOKHo0DWLNl8E0NndSUwArtunFYW2uaNyX5v2l7oTj
	QDoxDXHLU1/JNeoi8yahVTmA+XiRDhtP16Ivz56D6bXpm4n+uO9uC9mW8DttHUEo
	l6OG1KwqKBJZsqAeAe4FxMk51dEcqKfbsAHOMgCfzg==
X-ME-Sender: <xms:gKZyZu5qGodyS_TgYlBbWOkJyz5Io4f69kIBLITm2B463Sc5owV-nQ>
    <xme:gKZyZn53r4FGtPk52SwMRzrRhEWCKi62sgYynngq-_8-859jlbC7htY9_O8dxK0iK
    747Z5tX5ecjcg>
X-ME-Received: <xmr:gKZyZtdsmUAK6H1In2dAwqh75i4NkZh2KylWh2cKTcc3TG3AksAyfEjkwEG718qdjZ-I3-7Oac9wG14V40PJ_1L4gGewB1kwl850lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeftddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:gKZyZrLtM2YTy6l9SPcdLCzjSo174JH8DTdCuxmoA9do7XTtn5t8TQ>
    <xmx:gKZyZiLlBeQHJqjv449csZqpDHkCIHYWcN9YPTQsxATtE1Lz2iuEEQ>
    <xmx:gKZyZsy3nZqn6jdBxXXvHF_CZ218vvbDl35ewpUtUPThhhm1lU0znQ>
    <xmx:gKZyZmIb9lJlApyACQfCF3GHQ4cvGTZ3djWrzJPTdNpbbORaJOpBkw>
    <xmx:gKZyZh856cI_BUDNX3idjNKHdHQK7L4Nr0C6ZzxANEV7joz17y3ZtS-X>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jun 2024 05:35:59 -0400 (EDT)
Date: Wed, 19 Jun 2024 11:35:58 +0200
From: Greg KH <greg@kroah.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@vger.kernel.org, Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/memory-failure: fix handling of dissolved but
 not taken off from buddy pages
Message-ID: <2024061952-whomever-proposal-48ac@gregkh>
References: <2024061351-brick-halved-4e61@gregkh>
 <20240614073231.2801594-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614073231.2801594-1-linmiaohe@huawei.com>

On Fri, Jun 14, 2024 at 03:32:31PM +0800, Miaohe Lin wrote:
> When I did memory failure tests recently, below panic occurs:
> 
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8cee00
> flags: 0x6fffe0000000000(node=1|zone=2|lastcpupid=0x7fff)
> raw: 06fffe0000000000 dead000000000100 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000009 00000000ffffffff 0000000000000000
> page dumped because: VM_BUG_ON_PAGE(!PageBuddy(page))
> ------------[ cut here ]------------
> kernel BUG at include/linux/page-flags.h:1009!
> invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> RIP: 0010:__del_page_from_free_list+0x151/0x180
> RSP: 0018:ffffa49c90437998 EFLAGS: 00000046
> RAX: 0000000000000035 RBX: 0000000000000009 RCX: ffff8dd8dfd1c9c8
> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff8dd8dfd1c9c0
> RBP: ffffd901233b8000 R08: ffffffffab5511f8 R09: 0000000000008c69
> R10: 0000000000003c15 R11: ffffffffab5511f8 R12: ffff8dd8fffc0c80
> R13: 0000000000000001 R14: ffff8dd8fffc0c80 R15: 0000000000000009
> FS:  00007ff916304740(0000) GS:ffff8dd8dfd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055eae50124c8 CR3: 00000008479e0000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  __rmqueue_pcplist+0x23b/0x520
>  get_page_from_freelist+0x26b/0xe40
>  __alloc_pages_noprof+0x113/0x1120
>  __folio_alloc_noprof+0x11/0xb0
>  alloc_buddy_hugetlb_folio.isra.0+0x5a/0x130
>  __alloc_fresh_hugetlb_folio+0xe7/0x140
>  alloc_pool_huge_folio+0x68/0x100
>  set_max_huge_pages+0x13d/0x340
>  hugetlb_sysctl_handler_common+0xe8/0x110
>  proc_sys_call_handler+0x194/0x280
>  vfs_write+0x387/0x550
>  ksys_write+0x64/0xe0
>  do_syscall_64+0xc2/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff916114887
> RSP: 002b:00007ffec8a2fd78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000055eae500e350 RCX: 00007ff916114887
> RDX: 0000000000000004 RSI: 000055eae500e390 RDI: 0000000000000003
> RBP: 000055eae50104c0 R08: 0000000000000000 R09: 000055eae50104c0
> R10: 0000000000000077 R11: 0000000000000246 R12: 0000000000000004
> R13: 0000000000000004 R14: 00007ff916216b80 R15: 00007ff916216a00
>  </TASK>
> Modules linked in: mce_inject hwpoison_inject
> ---[ end trace 0000000000000000 ]---
> 
> And before the panic, there had an warning about bad page state:
> 
> BUG: Bad page state in process page-types  pfn:8cee00
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8cee00
> flags: 0x6fffe0000000000(node=1|zone=2|lastcpupid=0x7fff)
> page_type: 0xffffff7f(buddy)
> raw: 06fffe0000000000 ffffd901241c0008 ffffd901240f8008 0000000000000000
> raw: 0000000000000000 0000000000000009 00000000ffffff7f 0000000000000000
> page dumped because: nonzero mapcount
> Modules linked in: mce_inject hwpoison_inject
> CPU: 8 PID: 154211 Comm: page-types Not tainted 6.9.0-rc4-00499-g5544ec3178e2-dirty #22
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x83/0xa0
>  bad_page+0x63/0xf0
>  free_unref_page+0x36e/0x5c0
>  unpoison_memory+0x50b/0x630
>  simple_attr_write_xsigned.constprop.0.isra.0+0xb3/0x110
>  debugfs_attr_write+0x42/0x60
>  full_proxy_write+0x5b/0x80
>  vfs_write+0xcd/0x550
>  ksys_write+0x64/0xe0
>  do_syscall_64+0xc2/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f189a514887
> RSP: 002b:00007ffdcd899718 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f189a514887
> RDX: 0000000000000009 RSI: 00007ffdcd899730 RDI: 0000000000000003
> RBP: 00007ffdcd8997a0 R08: 0000000000000000 R09: 00007ffdcd8994b2
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdcda199a8
> R13: 0000000000404af1 R14: 000000000040ad78 R15: 00007f189a7a5040
>  </TASK>
> 
> The root cause should be the below race:
> 
>  memory_failure
>   try_memory_failure_hugetlb
>    me_huge_page
>     __page_handle_poison
>      dissolve_free_hugetlb_folio
>      drain_all_pages -- Buddy page can be isolated e.g. for compaction.
>      take_page_off_buddy -- Failed as page is not in the buddy list.
> 	     -- Page can be putback into buddy after compaction.
>     page_ref_inc -- Leads to buddy page with refcnt = 1.
> 
> Then unpoison_memory() can unpoison the page and send the buddy page back
> into buddy list again leading to the above bad page state warning.  And
> bad_page() will call page_mapcount_reset() to remove PageBuddy from buddy
> page leading to later VM_BUG_ON_PAGE(!PageBuddy(page)) when trying to
> allocate this page.
> 
> Fix this issue by only treating __page_handle_poison() as successful when
> it returns 1.
> 
> Link: https://lkml.kernel.org/r/20240523071217.1696196-1-linmiaohe@huawei.com
> Fixes: ceaf8fbea79a ("mm, hwpoison: skip raw hwpoison page in freeing 1GB hugepage")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 8cf360b9d6a840700e06864236a01a883b34bbad)
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory-failure.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index be58ce999259..9a51e75d079a 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1110,7 +1110,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>  		 * subpages.
>  		 */
>  		put_page(hpage);
> -		if (__page_handle_poison(p) >= 0) {
> +		if (__page_handle_poison(p) > 0) {
>  			page_ref_inc(p);
>  			res = MF_RECOVERED;
>  		} else {
> @@ -1888,7 +1888,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  	 */
>  	if (res == 0) {
>  		unlock_page(head);
> -		if (__page_handle_poison(p) >= 0) {
> +		if (__page_handle_poison(p) > 0) {
>  			page_ref_inc(p);
>  			res = MF_RECOVERED;
>  		} else {
> -- 
> 2.33.0
> 
> 

Now queued up, thanks.

greg k-h

