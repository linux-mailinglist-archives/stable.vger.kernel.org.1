Return-Path: <stable+bounces-177497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 260E6B405BF
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02EA56575C
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A61A3054F4;
	Tue,  2 Sep 2025 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hmwtlyoD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r+uD5WzL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hmwtlyoD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r+uD5WzL"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244E5307AD7
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820845; cv=none; b=GbIyDdUmcQHFk+7PXfDlecvHgNJwbQjF5KNABpVd0lZgxfHcP9FjDHBRbr7b03Vv05mM0xA1nlJPriiO/PgrWAsBSQ3j5TNemYZByNbZaTk9CwilYIC9rCbaAFefQTmPis4+nvkzjk+zplAvby5fIECT1po3Yl0kjk6JUxmGSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820845; c=relaxed/simple;
	bh=E1iDV2jdVHvYPW6AbnlI+lsQWvIiTGOi+hZjLgN3oWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuwH33ZO9+2o87qfhnUWXooCJqRMFQyerZmlNn9M2/PGkjeg31jQkdIqOWOow5Oxx2uZho72kLUnIfhMfvYSaRDdI+bH8IFSjjvov51t3Cdragsiq4RaEAQyC3eusG/IAfprkz/nhhhIYeeCn4vFTVLdHCqnWKknJs+OA8qJGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hmwtlyoD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r+uD5WzL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hmwtlyoD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r+uD5WzL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F6D71F452;
	Tue,  2 Sep 2025 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756820842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUP+jDkLYAcvHMZoNfo3+aWkCxWsUnenhaP136B6SY8=;
	b=hmwtlyoDxf9IyGtzbkq2encQug20a8icIyopGBfWgdw7tG9O6ofRyNJ41iZZayfnDtQIS8
	T4X1bLmPprkZrUG7YsKLp0qyC8tfv2Dh8xnmnZFxiyUBPxq9zdDp2gxgpf5/f/RHEswobT
	bBM1jJ6pfQK7dWDSWk2uAhfa8zorxzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756820842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUP+jDkLYAcvHMZoNfo3+aWkCxWsUnenhaP136B6SY8=;
	b=r+uD5WzLCNjOHuF/UQGoxvcwKA2TBdBg2/f2iFZT29a3lF91XbPwzzGpyoDJewENpSkRCe
	wbfdT2/4qqPDHYAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756820842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUP+jDkLYAcvHMZoNfo3+aWkCxWsUnenhaP136B6SY8=;
	b=hmwtlyoDxf9IyGtzbkq2encQug20a8icIyopGBfWgdw7tG9O6ofRyNJ41iZZayfnDtQIS8
	T4X1bLmPprkZrUG7YsKLp0qyC8tfv2Dh8xnmnZFxiyUBPxq9zdDp2gxgpf5/f/RHEswobT
	bBM1jJ6pfQK7dWDSWk2uAhfa8zorxzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756820842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUP+jDkLYAcvHMZoNfo3+aWkCxWsUnenhaP136B6SY8=;
	b=r+uD5WzLCNjOHuF/UQGoxvcwKA2TBdBg2/f2iFZT29a3lF91XbPwzzGpyoDJewENpSkRCe
	wbfdT2/4qqPDHYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62C9113882;
	Tue,  2 Sep 2025 13:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lck9GGr1tmjPYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Sep 2025 13:47:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0D584A0A9F; Tue,  2 Sep 2025 15:47:18 +0200 (CEST)
Date: Tue, 2 Sep 2025 15:47:18 +0200
From: Jan Kara <jack@suse.cz>
To: Shashank A P <shashank.ap@samsung.com>
Cc: jack@suse.com, linux-kernel@vger.kernel.org, shadakshar.i@samsung.com, 
	thiagu.r@samsung.com, hy50.seo@samsung.com, kwangwon.min@samsung.com, 
	alim.akhtar@samsung.com, h10.kim@samsung.com, kwmad.kim@samsung.com, 
	selvarasu.g@samsung.com, stable@vger.kernel.org
Subject: Re: [PATCH] fs: quota: create dedicated workqueue for
 quota_release_work
Message-ID: <ufb72d6p54cxyzcy5glrfzaz7xm3inzp44k6rdff5on3daua4s@u2rf7xt4hdie>
References: <CGME20250901092950epcas5p35accdcb60fe3ba58772289058a12f8a1@epcas5p3.samsung.com>
 <20250901092905.2115-1-shashank.ap@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901092905.2115-1-shashank.ap@samsung.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 01-09-25 14:59:00, Shashank A P wrote:
> There is a kernel panic due to WARN_ONCE when panic_on_warn is set.
> 
> This issue occurs when writeback is triggered due to sync call for an
> opened file(ie, writeback reason is WB_REASON_SYNC). When f2fs balance
> is needed at sync path, flush for quota_release_work is triggered.
> By default quota_release_work is queued to "events_unbound" queue which
> does not have WQ_MEM_RECLAIM flag. During f2fs balance "writeback"
> workqueue tries to flush quota_release_work causing kernel panic due to
> MEM_RECLAIM flag mismatch errors.
> 
> This patch creates dedicated workqueue with WQ_MEM_RECLAIM flag
> for work quota_release_work.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 4 PID: 14867 at kernel/workqueue.c:3721 check_flush_dependency+0x13c/0x148
> Call trace:
>  check_flush_dependency+0x13c/0x148
>  __flush_work+0xd0/0x398
>  flush_delayed_work+0x44/0x5c
>  dquot_writeback_dquots+0x54/0x318
>  f2fs_do_quota_sync+0xb8/0x1a8
>  f2fs_write_checkpoint+0x3cc/0x99c
>  f2fs_gc+0x190/0x750
>  f2fs_balance_fs+0x110/0x168
>  f2fs_write_single_data_page+0x474/0x7dc
>  f2fs_write_data_pages+0x7d0/0xd0c
>  do_writepages+0xe0/0x2f4
>  __writeback_single_inode+0x44/0x4ac
>  writeback_sb_inodes+0x30c/0x538
>  wb_writeback+0xf4/0x440
>  wb_workfn+0x128/0x5d4
>  process_scheduled_works+0x1c4/0x45c
>  worker_thread+0x32c/0x3e8
>  kthread+0x11c/0x1b0
>  ret_from_fork+0x10/0x20
> Kernel panic - not syncing: kernel: panic_on_warn set ...
> 
> Fixes: ac6f420291b3 ("quota: flush quota_release_work upon quota writeback")
> CC: stable@vger.kernel.org
> Signed-off-by: Shashank A P <shashank.ap@samsung.com>

Thanks. It seems a bit unfortunate that we have to create a separate
workqueue just for this but I don't see a different easy solution. So I've
added your patch to my tree.

								Honza

> ---
>  fs/quota/dquot.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index df4a9b348769..d0f83a0c42df 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -162,6 +162,9 @@ static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
>  /* SLAB cache for dquot structures */
>  static struct kmem_cache *dquot_cachep;
>  
> +/* workqueue for work quota_release_work*/
> +struct workqueue_struct *quota_unbound_wq;
> +
>  void register_quota_format(struct quota_format_type *fmt)
>  {
>  	spin_lock(&dq_list_lock);
> @@ -881,7 +884,7 @@ void dqput(struct dquot *dquot)
>  	put_releasing_dquots(dquot);
>  	atomic_dec(&dquot->dq_count);
>  	spin_unlock(&dq_list_lock);
> -	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
> +	queue_delayed_work(quota_unbound_wq, &quota_release_work, 1);
>  }
>  EXPORT_SYMBOL(dqput);
>  
> @@ -3041,6 +3044,11 @@ static int __init dquot_init(void)
>  
>  	shrinker_register(dqcache_shrinker);
>  
> +	quota_unbound_wq = alloc_workqueue("quota_events_unbound",
> +					   WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
> +	if (!quota_unbound_wq)
> +		panic("Cannot create quota_unbound_wq\n");
> +
>  	return 0;
>  }
>  fs_initcall(dquot_init);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

