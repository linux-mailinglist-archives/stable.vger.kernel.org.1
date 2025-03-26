Return-Path: <stable+bounces-126707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC277A716D4
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 13:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C80188EB76
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA97A1E1E0E;
	Wed, 26 Mar 2025 12:42:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1421E1DEC;
	Wed, 26 Mar 2025 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992972; cv=none; b=kLeumHLsuzH064FavB8o2m8n5Naz2LNLXvQaa6xCq1fNcICL9b2MY1fU/FXT56VRRdn2+SCl+l4+9jKmfXgKfflvGH1DeOlmM6BFlATxZEoZhw6U8+V+4W6BHJPggiC9JK6SaS7x6mX0po5MSM3zKIBhrn+0Xk3b7rP0imnqqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992972; c=relaxed/simple;
	bh=9PLfRglBIRDWW4vWcZCofYESNHEJ70S3FZVGIXq2CMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YEEuLA0p0JYvU2CFT6ej8O2XAzSp/disQFXdIhqNIqBr114gW84rMTL1dXuslrJVv9gYjnET620SsiUuGCUQ26gkK3kWAmTByaT+1sC6qDM2S78f/IyxyymXQIFAKeBbROSeIXjKAKHpVSeT+IjON55/5o2OuUrLC9aQ+uiXyBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZN5th4xjjzvWpl;
	Wed, 26 Mar 2025 20:38:36 +0800 (CST)
Received: from kwepemo200002.china.huawei.com (unknown [7.202.195.209])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D8251400F4;
	Wed, 26 Mar 2025 20:42:33 +0800 (CST)
Received: from [10.174.179.13] (10.174.179.13) by
 kwepemo200002.china.huawei.com (7.202.195.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Mar 2025 20:42:32 +0800
Message-ID: <4119c1d0-5010-b2e7-3f1c-edd37f16f1f2@huawei.com>
Date: Wed, 26 Mar 2025 20:42:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V4] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: <yangge1116@126.com>, <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <21cnbao@gmail.com>, <david@redhat.com>,
	<baolin.wang@linux.alibaba.com>, <aneesh.kumar@linux.ibm.com>,
	<liuzixing@hygon.cn>, Kefeng Wang <wangkefeng.wang@huawei.com>
References: <1720075944-27201-1-git-send-email-yangge1116@126.com>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <1720075944-27201-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemo200002.china.huawei.com (7.202.195.209)

Hi,

We notiched a 12.3% performance regression for LibMicro pwrite testcase due to
commit 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before adding to LRU batch").

The testcase is executed as follows, and the file is tmpfs file.
    pwrite -E -C 200 -L -S -W -N "pwrite_t1k" -s 1k -I 500 -f $TFILE

this testcase writes 1KB (only one page) to the tmpfs and repeats this step for many times. The Flame
graph shows the performance regression comes from folio_mark_accessed() and workingset_activation().

folio_mark_accessed() is called for the same page for many times. Before this patch, each call will
add the page to cpu_fbatches.activate. When the fbatch is full, the fbatch is drained and the page
is promoted to active list. And then, folio_mark_accessed() does nothing in later calls.

But after this patch, the folio clear lru flags after it is added to cpu_fbatches.activate. After then,
folio_mark_accessed will never call folio_activate() again due to the page is without lru flag, and
the fbatch will not be full and the folio will not be marked active, later folio_mark_accessed()
calls will always call workingset_activation(), leading to performance regression.

In addition, folio_mark_accessed() calls __lru_cache_activate_folio(). This function does as
follow comments:

/*
	 * Search backwards on the optimistic assumption that the folio being
	 * activated has just been added to this batch.
*/

However, after this patch, folio without lru flag may be in other fbatch too, such as cpu_fbatches.activate.

在 2024/7/4 14:52, yangge1116@126.com 写道:
> From: yangge <yangge1116@126.com>
>
> If a large number of CMA memory are configured in system (for example, the
> CMA memory accounts for 50% of the system memory), starting a virtual
> virtual machine with device passthrough, it will
> call pin_user_pages_remote(..., FOLL_LONGTERM, ...) to pin memory.
> Normally if a page is present and in CMA area, pin_user_pages_remote()
> will migrate the page from CMA area to non-CMA area because of
> FOLL_LONGTERM flag. But the current code will cause the migration failure
> due to unexpected page refcounts, and eventually cause the virtual machine
> fail to start.
>
> If a page is added in LRU batch, its refcount increases one, remove the
> page from LRU batch decreases one. Page migration requires the page is not
> referenced by others except page mapping. Before migrating a page, we
> should try to drain the page from LRU batch in case the page is in it,
> however, folio_test_lru() is not sufficient to tell whether the page is
> in LRU batch or not, if the page is in LRU batch, the migration will fail.
>
> To solve the problem above, we modify the logic of adding to LRU batch.
> Before adding a page to LRU batch, we clear the LRU flag of the page so
> that we can check whether the page is in LRU batch by folio_test_lru(page).
> It's quite valuable, because likely we don't want to blindly drain the LRU
> batch simply because there is some unexpected reference on a page, as
> described above.
>
> This change makes the LRU flag of a page invisible for longer, which
> may impact some programs. For example, as long as a page is on a LRU
> batch, we cannot isolate it, and we cannot check if it's an LRU page.
> Further, a page can now only be on exactly one LRU batch. This doesn't
> seem to matter much, because a new page is allocated from buddy and
> added to the lru batch, or be isolated, it's LRU flag may also be
> invisible for a long time.
>
> Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: yangge <yangge1116@126.com>
> ---
>   mm/swap.c | 43 +++++++++++++++++++++++++++++++------------
>   1 file changed, 31 insertions(+), 12 deletions(-)
>
> V4:
>     Adjust commit message according to David's comments
> V3:
>     Add fixes tag
> V2:
>     Adjust code and commit message according to David's comments
>
> diff --git a/mm/swap.c b/mm/swap.c
> index dc205bd..9caf6b0 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -211,10 +211,6 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
>   	for (i = 0; i < folio_batch_count(fbatch); i++) {
>   		struct folio *folio = fbatch->folios[i];
>   
> -		/* block memcg migration while the folio moves between lru */
> -		if (move_fn != lru_add_fn && !folio_test_clear_lru(folio))
> -			continue;
> -
>   		folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
>   		move_fn(lruvec, folio);
>   
> @@ -255,11 +251,16 @@ static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
>   void folio_rotate_reclaimable(struct folio *folio)
>   {
>   	if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
> -	    !folio_test_unevictable(folio) && folio_test_lru(folio)) {
> +	    !folio_test_unevictable(folio)) {
>   		struct folio_batch *fbatch;
>   		unsigned long flags;
>   
>   		folio_get(folio);
> +		if (!folio_test_clear_lru(folio)) {
> +			folio_put(folio);
> +			return;
> +		}
> +
>   		local_lock_irqsave(&lru_rotate.lock, flags);
>   		fbatch = this_cpu_ptr(&lru_rotate.fbatch);
>   		folio_batch_add_and_move(fbatch, folio, lru_move_tail_fn);
> @@ -352,11 +353,15 @@ static void folio_activate_drain(int cpu)
>   
>   void folio_activate(struct folio *folio)
>   {
> -	if (folio_test_lru(folio) && !folio_test_active(folio) &&
> -	    !folio_test_unevictable(folio)) {
> +	if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
>   		struct folio_batch *fbatch;
>   
>   		folio_get(folio);
> +		if (!folio_test_clear_lru(folio)) {
> +			folio_put(folio);
> +			return;
> +		}
> +
>   		local_lock(&cpu_fbatches.lock);
>   		fbatch = this_cpu_ptr(&cpu_fbatches.activate);
>   		folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
> @@ -700,6 +705,11 @@ void deactivate_file_folio(struct folio *folio)
>   		return;
>   
>   	folio_get(folio);
> +	if (!folio_test_clear_lru(folio)) {
> +		folio_put(folio);
> +		return;
> +	}
> +
>   	local_lock(&cpu_fbatches.lock);
>   	fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate_file);
>   	folio_batch_add_and_move(fbatch, folio, lru_deactivate_file_fn);
> @@ -716,11 +726,16 @@ void deactivate_file_folio(struct folio *folio)
>    */
>   void folio_deactivate(struct folio *folio)
>   {
> -	if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
> -	    (folio_test_active(folio) || lru_gen_enabled())) {
> +	if (!folio_test_unevictable(folio) && (folio_test_active(folio) ||
> +	    lru_gen_enabled())) {
>   		struct folio_batch *fbatch;
>   
>   		folio_get(folio);
> +		if (!folio_test_clear_lru(folio)) {
> +			folio_put(folio);
> +			return;
> +		}
> +
>   		local_lock(&cpu_fbatches.lock);
>   		fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate);
>   		folio_batch_add_and_move(fbatch, folio, lru_deactivate_fn);
> @@ -737,12 +752,16 @@ void folio_deactivate(struct folio *folio)
>    */
>   void folio_mark_lazyfree(struct folio *folio)
>   {
> -	if (folio_test_lru(folio) && folio_test_anon(folio) &&
> -	    folio_test_swapbacked(folio) && !folio_test_swapcache(folio) &&
> -	    !folio_test_unevictable(folio)) {
> +	if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
> +	    !folio_test_swapcache(folio) && !folio_test_unevictable(folio)) {
>   		struct folio_batch *fbatch;
>   
>   		folio_get(folio);
> +		if (!folio_test_clear_lru(folio)) {
> +			folio_put(folio);
> +			return;
> +		}
> +
>   		local_lock(&cpu_fbatches.lock);
>   		fbatch = this_cpu_ptr(&cpu_fbatches.lru_lazyfree);
>   		folio_batch_add_and_move(fbatch, folio, lru_lazyfree_fn);

