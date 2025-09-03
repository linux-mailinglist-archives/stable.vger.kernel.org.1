Return-Path: <stable+bounces-177599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BA1B41BFD
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 12:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73246207F41
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 10:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A7D2EB873;
	Wed,  3 Sep 2025 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FIPF1vm0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q4mLxMEX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VD5BFBjg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7W3XEY+J"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0622E9EB8
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895845; cv=none; b=vCOpWZ8AetaFUovq7CEioVETfofRNHpyMDvX3+RM0kGBQe3bzhBqW6lKQVw28XNRPwbEcqoQzkSm21JaxJE4HcnkAkJEVZkEXTgrqzjx2SttGhHDqQOjTdAhh2CTypCbd3lRnOdL4E5IMp1D2VNgozMSWwTZPWAPXnnFx9GE1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895845; c=relaxed/simple;
	bh=5xeov8tdbtyifs0qpjcIjtyjXAzBQZopq1EQM3OD9EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5Jb0xIMMrwIaXVIcKCCJuGaeFEBPnEpLc9fFxQymr8b/VNWZ7FEecz7mHftHqXwyJnUDSr3jf3a+Z1QNTG1Kcx1XBzspDS/KAr8CNNrpsSv7RolLhybxcxp0yvR8/mPnFyrRqto/iDtEF1oXVxrnOEaHS2vuy3aphLbZJPO3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FIPF1vm0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q4mLxMEX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VD5BFBjg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7W3XEY+J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D34642120B;
	Wed,  3 Sep 2025 10:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756895841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0aUIYAsJSOWaWKTIHPRDvMqMwz2KHcD8wUdjEHXaSo0=;
	b=FIPF1vm0cU4PtcOsj647Kos9GiBz70LDZ4TYNiy87ot/Smda3rW5/IeNjgivCqr4UAN6BL
	xAWfdPkCtfj4KVDq87ba6PNj7PzgcdmWJTqFyX67/GKuhXX1CyPZVpTTO7vxi91pQ3w+wv
	venglkSeueP3YEvwcsDfhm+8+uEsFlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756895841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0aUIYAsJSOWaWKTIHPRDvMqMwz2KHcD8wUdjEHXaSo0=;
	b=Q4mLxMEXpkbJuEnMmft6A1J1g77txZEeT7s8DTQk5JCY6vxWgxWJXO3Qy4raa70RxhbTPu
	WPPI+YBYh0CyBSAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VD5BFBjg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7W3XEY+J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756895840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0aUIYAsJSOWaWKTIHPRDvMqMwz2KHcD8wUdjEHXaSo0=;
	b=VD5BFBjgpocM2MusGNFJGX2rvdiS5Y9IrfzzSc7LD1s1elPGM34rLCE3LhgWSgyLsSxrpy
	uBT7ONqDheJWD0uxYezaMpk9ah/6ReS+arUZ6CZVQN/DjJJoycwB/27pkCf6G8ym8Y6U0v
	XDYPRGreiExplxLwBejzwoJmoVK9lyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756895840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0aUIYAsJSOWaWKTIHPRDvMqMwz2KHcD8wUdjEHXaSo0=;
	b=7W3XEY+JOrMyJ+ku07ldt5bOdL/DDz05KLqD8tBvKw+Nz2x75h5xHNLidusEWdOcI8FvZ5
	10hrm5IALRzAwyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C69C813A31;
	Wed,  3 Sep 2025 10:37:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RGN6MGAauGhYCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Sep 2025 10:37:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67A4DA0809; Wed,  3 Sep 2025 12:37:20 +0200 (CEST)
Date: Wed, 3 Sep 2025 12:37:20 +0200
From: Jan Kara <jack@suse.cz>
To: Shashank A P <shashank.ap@samsung.com>
Cc: Jan Kara <jack@suse.cz>, jack@suse.com, linux-kernel@vger.kernel.org, 
	shadakshar.i@samsung.com, thiagu.r@samsung.com, hy50.seo@samsung.com, 
	kwangwon.min@samsung.com, alim.akhtar@samsung.com, h10.kim@samsung.com, 
	kwmad.kim@samsung.com, selvarasu.g@samsung.com, stable@vger.kernel.org
Subject: Re: [PATCH] fs: quota: create dedicated workqueue for
 quota_release_work
Message-ID: <vpv4mxr565y5ykjvqntl6ke43sojcuqfc74ai5bfs6zg7e6qze@3qlidrkuvn22>
References: <CGME20250901092950epcas5p35accdcb60fe3ba58772289058a12f8a1@epcas5p3.samsung.com>
 <20250901092905.2115-1-shashank.ap@samsung.com>
 <ufb72d6p54cxyzcy5glrfzaz7xm3inzp44k6rdff5on3daua4s@u2rf7xt4hdie>
 <49611228-50a8-416b-ac3d-d8b2869c2fe1@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49611228-50a8-416b-ac3d-d8b2869c2fe1@samsung.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D34642120B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,intel.com:email,suse.com:email]
X-Spam-Score: -4.01

On Wed 03-09-25 14:01:46, Shashank A P wrote:
> On 9/2/2025 7:17 PM, Jan Kara wrote:
> > On Mon 01-09-25 14:59:00, Shashank A P wrote:
> >> There is a kernel panic due to WARN_ONCE when panic_on_warn is set.
> >>
> >> This issue occurs when writeback is triggered due to sync call for an
> >> opened file(ie, writeback reason is WB_REASON_SYNC). When f2fs balance
> >> is needed at sync path, flush for quota_release_work is triggered.
> >> By default quota_release_work is queued to "events_unbound" queue which
> >> does not have WQ_MEM_RECLAIM flag. During f2fs balance "writeback"
> >> workqueue tries to flush quota_release_work causing kernel panic due to
> >> MEM_RECLAIM flag mismatch errors.
> >>
> >> This patch creates dedicated workqueue with WQ_MEM_RECLAIM flag
> >> for work quota_release_work.
> >>
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 4 PID: 14867 at kernel/workqueue.c:3721 check_flush_dependency+0x13c/0x148
> >> Call trace:
> >>   check_flush_dependency+0x13c/0x148
> >>   __flush_work+0xd0/0x398
> >>   flush_delayed_work+0x44/0x5c
> >>   dquot_writeback_dquots+0x54/0x318
> >>   f2fs_do_quota_sync+0xb8/0x1a8
> >>   f2fs_write_checkpoint+0x3cc/0x99c
> >>   f2fs_gc+0x190/0x750
> >>   f2fs_balance_fs+0x110/0x168
> >>   f2fs_write_single_data_page+0x474/0x7dc
> >>   f2fs_write_data_pages+0x7d0/0xd0c
> >>   do_writepages+0xe0/0x2f4
> >>   __writeback_single_inode+0x44/0x4ac
> >>   writeback_sb_inodes+0x30c/0x538
> >>   wb_writeback+0xf4/0x440
> >>   wb_workfn+0x128/0x5d4
> >>   process_scheduled_works+0x1c4/0x45c
> >>   worker_thread+0x32c/0x3e8
> >>   kthread+0x11c/0x1b0
> >>   ret_from_fork+0x10/0x20
> >> Kernel panic - not syncing: kernel: panic_on_warn set ...
> >>
> >> Fixes: ac6f420291b3 ("quota: flush quota_release_work upon quota writeback")
> >> CC: stable@vger.kernel.org
> >> Signed-off-by: Shashank A P <shashank.ap@samsung.com>
> > Thanks. It seems a bit unfortunate that we have to create a separate
> > workqueue just for this but I don't see a different easy solution. So I've
> > added your patch to my tree.
> >
> > 								Honza
> 
> Hi Jan Kara,
> Thanks for your comments.
> 
> We've got a below kernel warning from kernel test 
> robot(lkp@intel.com)that related to the changes, and we need your 
> suggestions to resolve this warning as its merged already in your tree.
> 
> Should we post a new patch version to fix this warning, or can you 
> please incorporate the fix while applying it to linux-next?
> 
> 
> sparse warnings: (new ones prefixed by >>)
>  >> fs/quota/dquot.c:166:25: sparse: sparse: symbol 'quota_unbound_wq' 
> was not declared. Should it be static?
> 
> https://lore.kernel.org/all/202509031153.0ACADDn6-lkp@intel.com/

Thanks for noticing. Somehow I didn't get this notification. Anyway, I've
fixed up the commit in my tree to declare quota_unbound_wq as static.

								Honza

> >> ---
> >>   fs/quota/dquot.c | 10 +++++++++-
> >>   1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> >> index df4a9b348769..d0f83a0c42df 100644
> >> --- a/fs/quota/dquot.c
> >> +++ b/fs/quota/dquot.c
> >> @@ -162,6 +162,9 @@ static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
> >>   /* SLAB cache for dquot structures */
> >>   static struct kmem_cache *dquot_cachep;
> >>   
> >> +/* workqueue for work quota_release_work*/
> >> +struct workqueue_struct *quota_unbound_wq;
> >> +
> >>   void register_quota_format(struct quota_format_type *fmt)
> >>   {
> >>   	spin_lock(&dq_list_lock);
> >> @@ -881,7 +884,7 @@ void dqput(struct dquot *dquot)
> >>   	put_releasing_dquots(dquot);
> >>   	atomic_dec(&dquot->dq_count);
> >>   	spin_unlock(&dq_list_lock);
> >> -	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
> >> +	queue_delayed_work(quota_unbound_wq, &quota_release_work, 1);
> >>   }
> >>   EXPORT_SYMBOL(dqput);
> >>   
> >> @@ -3041,6 +3044,11 @@ static int __init dquot_init(void)
> >>   
> >>   	shrinker_register(dqcache_shrinker);
> >>   
> >> +	quota_unbound_wq = alloc_workqueue("quota_events_unbound",
> >> +					   WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
> >> +	if (!quota_unbound_wq)
> >> +		panic("Cannot create quota_unbound_wq\n");
> >> +
> >>   	return 0;
> >>   }
> >>   fs_initcall(dquot_init);
> >> -- 
> >> 2.34.1
> >>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

