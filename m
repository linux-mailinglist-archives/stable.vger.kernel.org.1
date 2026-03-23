Return-Path: <stable+bounces-227956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBeGJmYgwWmTQwQAu9opvQ
	(envelope-from <stable+bounces-227956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:13:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB1B2F0FB5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA567301AAAB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964DE33F5AB;
	Mon, 23 Mar 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opD1lgWS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2FA3328FA
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263992; cv=none; b=AXpyqAM5OCgd5aS5SJS5vcZEE9L60TK/b4j2etbofs2xOtEB8JzRg8xG+Myg4Pmma70lINfraeswSaUFYRF30dljJQCe22J1+ATWPM6Xj2dDiCqEg+EEKFpwNaLlbuAyH90Pyi5KjINkMojW8lnK524qHtapp5hrcY/qPgzurRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263992; c=relaxed/simple;
	bh=eZt29KyQXd3NrSDSkRLSRVVGIq5fT7OnarGlrAFYGrk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uIKqc5uUmvY+U3Si7RNB0oT63ReAI/EpJ42LbcpYZi26CTzs9XO//jxAIdLhdBmww2oT1mQhs5aFGXH+QY1I7kzbA0pCXo6m5+qEhbjJI8Ctub8PfuPLYILSZ0c7rpw3uWwWLox052esJ7WIhmFCWJO9yHcmNm5SNt9Q+v57kP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opD1lgWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB977C4CEF7;
	Mon, 23 Mar 2026 11:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263992;
	bh=eZt29KyQXd3NrSDSkRLSRVVGIq5fT7OnarGlrAFYGrk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=opD1lgWSAnk2iyt7Wa7X+UVO5+t9ztJr23x5L4EMfopaIrTggB+WvfWdiwcetFnUi
	 WWhsQbHF9LAMSfNFo4nuBuRIfiBzZNpboQf7qWuzjyXBvk9lngIagV587jDKgS73pe
	 qZVYZ3vjANNAjl3YcWaX0Lx0ohnXyh0nzMpWQ5glyNWbtvlo54xDhnUJlwsndery1Y
	 SArRf3sFwzFNtuBZuFTWsL+3iuqc82JMEfv/LtTxlMRSnG7zuryAruA07y7tatsTn6
	 I/c8ZjCV9qHTGDJLHJ+4YrS76qC1txmRZyDge2vmSU0MlVScifniW8/SihZLF+N8kt
	 HEMg0OGxnl7xg==
Message-ID: <ead2d70c-e7fc-479e-876f-3a28d5c03219@kernel.org>
Date: Mon, 23 Mar 2026 19:06:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix use-after-free of sbi in
 f2fs_compress_write_end_io()
To: George Saad <geoo115@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
References: <2026032354-country-saddlebag-5331@gregkh>
 <20260323104425.780693-1-geoo115@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260323104425.780693-1-geoo115@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227956-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BB1B2F0FB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 18:44, George Saad wrote:
> In f2fs_compress_write_end_io(), dec_page_count(sbi, type) at line 1492
> can bring the F2FS_WB_CP_DATA counter to zero, unblocking
> f2fs_wait_on_all_pages() in f2fs_put_super() on a concurrent unmount
> CPU. The unmount path then proceeds to call
> f2fs_destroy_page_array_cache(sbi) and kfree(sbi). Meanwhile, the bio
> completion callback is still executing: when it reaches
> page_array_free(sbi, ...), it dereferences sbi->page_array_slab_size
> and sbi->page_array_slab within the now-freed f2fs_sb_info structure.
> 
> This is the same class of bug as CVE-2026-23234 (which fixed the
> equivalent race in f2fs_write_end_io() in data.c), but in the
> compressed writeback completion path that was not covered by that fix.
> 
> Fix this by caching sbi->page_array_slab and sbi->page_array_slab_size
> into local variables at function entry, before dec_page_count(). At
> function entry, sbi is guaranteed valid because the F2FS_WB_CP_DATA
> counter is still nonzero (this invocation has not yet decremented it),
> preventing the unmount path from proceeding past
> f2fs_wait_on_all_pages(). The cached values are then used in place of
> the post-decrement sbi dereference.
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Cc: stable@vger.kernel.org
> Signed-off-by: George Saad <geoo115@gmail.com>
> ---
> Changes in v3:
> - Add Cc: stable@vger.kernel.org for backport to affected stable kernels
> 
> Changes in v2:
> - Fix Fixes: tag commit hash (4c8ff7095bef, verified in Linus's tree)
> 
>  fs/f2fs/compress.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 7b68bf229..c3d837df3 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1479,11 +1479,20 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
>  {
>  	struct page *page = &folio->page;
>  	struct f2fs_sb_info *sbi = bio->bi_private;
> +	struct kmem_cache *pa_slab = sbi->page_array_slab;
> +	unsigned int pa_slab_size = sbi->page_array_slab_size;
>  	struct compress_io_ctx *cic = folio->private;
>  	enum count_type type = WB_DATA_TYPE(folio,
>  				f2fs_is_compressed_page(folio));
>  	int i;
>  
> +	/*
> +	 * Cache sbi fields before dec_page_count(), which may unblock
> +	 * f2fs_wait_on_all_pages() in the unmount path, allowing
> +	 * f2fs_put_super() to free sbi.  At this point sbi is still
> +	 * valid because the F2FS_WB_CP_DATA counter is nonzero.
> +	 */
> +
>  	if (unlikely(bio->bi_status != BLK_STS_OK))
>  		mapping_set_error(cic->inode->i_mapping, -EIO);
>  
> @@ -1500,7 +1509,10 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
>  		end_page_writeback(cic->rpages[i]);
>  	}
>  
> -	page_array_free(sbi, cic->rpages, cic->nr_rpages);
> +	if (likely(sizeof(struct page *) * cic->nr_rpages <= pa_slab_size))
> +		kmem_cache_free(pa_slab, cic->rpages);

After sbi is freed, sbi->page_array_slab should be destroyed as well, so
pa_slab points to a freed memory, right?

Thanks,

> +	else
> +		kfree(cic->rpages);
>  	kmem_cache_free(cic_entry_slab, cic);
>  }
>  


