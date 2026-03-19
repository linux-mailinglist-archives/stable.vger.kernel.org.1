Return-Path: <stable+bounces-227283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DZXFDfvu2liqQIAu9opvQ
	(envelope-from <stable+bounces-227283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:42:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7B42CB4BA
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD9DB3021D00
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DACC3BED29;
	Thu, 19 Mar 2026 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ULJsmgJE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sRerEnp9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ULJsmgJE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sRerEnp9"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181023C3453
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773924144; cv=none; b=pr9PEbMDLyomTPx6b7qR9dXz13dh7qKHeLlfed7sULtWjEYgbDp022dbbjJ4L81TCnMQuk09IcRLxMXh1BFxczMTdtGHolh8hmuksMv8bX2UZiKQ94B+Ltqqi986XZmJsCRY0PgsOtJ1ds/mucmYrZsySAvggdP+EdSCpEKa3aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773924144; c=relaxed/simple;
	bh=GhDpWeb0maRZry/oxI6ymaw7q0PAfT5+R2cF0l4DVTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUz+N6L+5atG1hYRzSvtGL+qEtImviHeei1UZrFNhrAwHyQo082kGs+EQmNVhVGDEasWFtw926Pn/XBpmxxajbnk4a/+GtVS9OqjHETnDu/FyTa+8e9k5A541SUXfgZ9yF8ykhK1Ttf2iXrAXn/fip5pOknu8BSKR9zx4BRmPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ULJsmgJE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sRerEnp9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ULJsmgJE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sRerEnp9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 58F414D210;
	Thu, 19 Mar 2026 12:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773924141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6AoZNlVdKxsvWwANC3n5EknvxexPRfqPaI5D6JlP+2Y=;
	b=ULJsmgJEa8cb1NBlM3IEejlguIJRBJfI21FC108MrPNhTP2G7YAj98aRhYINdrPpJAHg1/
	0cbhYLG0gFomrtytQAMA5SY2t+1Q+wmKXklmYzk2sZLLkzYRagzmi0wwmPZenedEqIi9xP
	bli7Xs4VPSGYr5pVBwUveJINMkXKCds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773924141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6AoZNlVdKxsvWwANC3n5EknvxexPRfqPaI5D6JlP+2Y=;
	b=sRerEnp94W5mjGienLeW2I83tku/tZu4Clk9Z2bDEHC5yBcJQdWl5qRzeRAYUtVrD/Lwfw
	sDda74Rkjrt645DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773924141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6AoZNlVdKxsvWwANC3n5EknvxexPRfqPaI5D6JlP+2Y=;
	b=ULJsmgJEa8cb1NBlM3IEejlguIJRBJfI21FC108MrPNhTP2G7YAj98aRhYINdrPpJAHg1/
	0cbhYLG0gFomrtytQAMA5SY2t+1Q+wmKXklmYzk2sZLLkzYRagzmi0wwmPZenedEqIi9xP
	bli7Xs4VPSGYr5pVBwUveJINMkXKCds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773924141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6AoZNlVdKxsvWwANC3n5EknvxexPRfqPaI5D6JlP+2Y=;
	b=sRerEnp94W5mjGienLeW2I83tku/tZu4Clk9Z2bDEHC5yBcJQdWl5qRzeRAYUtVrD/Lwfw
	sDda74Rkjrt645DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B56A4273B;
	Thu, 19 Mar 2026 12:42:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eqtbEi3vu2l/BQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Mar 2026 12:42:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0BB35A0B32; Thu, 19 Mar 2026 13:42:17 +0100 (CET)
Date: Thu, 19 Mar 2026 13:42:17 +0100
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, david@kernel.org, therealgraysky@proton.me, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] writeback: skip sync(2) inode writeback for
 filesystems with no data integrity guarantees
Message-ID: <k7ln2mcmll3t4zic3smao6hvvxprmpsax45fh6mwn4en6f6m42@sdpuqd2pqiwy>
References: <20260318225604.71545-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318225604.71545-1-joannelkoong@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227283-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:dkim,proton.me:email,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BE7B42CB4BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed 18-03-26 15:56:04, Joanne Koong wrote:
> Add SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
> guarantee data persistence on sync (eg fuse) and skip sync(2) inode
> writeback for superblocks with this flag set.
> 
> There was a recent report [1] for a suspend-to-RAM hang on fuse-overlayfs with
> firefox + youtube in wb_wait_for_completion() from the pm_fs_sync_work_fn()
> path:
> 
> Workqueue: pm_fs_sync pm_fs_sync_work_fn
> Call Trace:
>  <TASK>
>  __schedule+0x457/0x1720
>  schedule+0x27/0xd0
>  wb_wait_for_completion+0x97/0xe0
>  sync_inodes_sb+0xf8/0x2e0
>  __iterate_supers+0xdc/0x160
>  ksys_sync+0x43/0xb0
>  pm_fs_sync_work_fn+0x17/0xa0
>  process_one_work+0x193/0x350
>  worker_thread+0x1a1/0x310
>  kthread+0xfc/0x240
>  ret_from_fork+0x243/0x280
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> This can happen in two ways:
> a) systemd freezes the user session cgroups first (which freezes the fuse daemon)
> before invoking the kernel suspend. The suspend triggers the wb_workfn() ->
> write_inode() path, where fuse issues a synchronous setattr request to the
> frozen daemon, which cannot process the request
> b) if a dirty folio is already under writeback and needs to have writeback
> issued again, in writeback_get_folio() -> folio_prepare_writeback(), we
> unconditionally wait on writeback to finish, but for buggy/faulty fuse
> servers, the request may never be processed
> 
> The correct fix is for sync(2) to skip the sync_inodes_sb() path entirely for
> any filesystems that do not have data integrity guarantees.
> 
> A prior commit (commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY
> mappings in wait_sb_inodes()")) added the AS_NO_DATA_INTEGRITY mapping flag to
> skip sync(2) waits for mappings without data integrity semantics, but it still
> allowed wb_workfn() worker threads to be kicked off for the writeback.
> 
> This patch improves upon that by replacing the per-inode AS_NO_DATA_INTEGRITY
> mapping flag with a flag at the superblock level, and using that superblock
> flag to skip the sync_inodes_sb() path entirely if there are no data integrity
> guarantees. The flag belongs at the superblock level because data integrity is
> a filesystem-wide property, not a per-inode one. Having the flag at the
> superblock level allows sync_inodes_one_sb() to skip the entire filesystem
> efficiently, rather than iterating every dirty inode only to skip each one
> individually.
> 
> This patch restores fuse to its prior behavior before tmp folios were removed,
> where sync was essentially a no-op.
> 
> [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a-asuvfrbKXbEwwDSctvemF+6zfhdnuzO65Pt8HsFSRw@mail.gmail.com/T/#m632c4648e9cafc4239299887109ebd880ac6c5c1
> 
> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
> Reported-by: John <therealgraysky@proton.me>
> Tested-by: John <therealgraysky@proton.me>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

I'd note that previously, if the FUSE server was not broken, although
sync(2) would not provide any data integrity guarantee, it would still
flush the data so practically, there would be no user observable difference
unless you really did powerfail testing. So some users might be
unpleasantly surprised by sync(2) suddently not doing anything on FUSE
filesystems. Maybe for SB_I_NO_DATA_INTEGRITY filesystems we should at
least kick flush worker to do writeback in the background?

								Honza

> ---
>  fs/fs-writeback.c              |  7 +------
>  fs/fuse/file.c                 |  4 +---
>  fs/fuse/inode.c                |  1 +
>  fs/sync.c                      |  2 +-
>  include/linux/fs/super_types.h |  1 +
>  include/linux/pagemap.h        | 11 -----------
>  6 files changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 7c75ed7e8979..154249e4e5ce 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2775,13 +2775,8 @@ static void wait_sb_inodes(struct super_block *sb)
>  		 * The mapping can appear untagged while still on-list since we
>  		 * do not have the mapping lock. Skip it here, wb completion
>  		 * will remove it.
> -		 *
> -		 * If the mapping does not have data integrity semantics,
> -		 * there's no need to wait for the writeout to complete, as the
> -		 * mapping cannot guarantee that data is persistently stored.
>  		 */
> -		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
> -		    mapping_no_data_integrity(mapping))
> +		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
>  			continue;
>  
>  		spin_unlock_irq(&sb->s_inode_wblist_lock);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a9c836d7f586..f6240f24b814 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3202,10 +3202,8 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
>  
>  	inode->i_fop = &fuse_file_operations;
>  	inode->i_data.a_ops = &fuse_file_aops;
> -	if (fc->writeback_cache) {
> +	if (fc->writeback_cache)
>  		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
> -		mapping_set_no_data_integrity(&inode->i_data);
> -	}
>  
>  	INIT_LIST_HEAD(&fi->write_files);
>  	INIT_LIST_HEAD(&fi->queued_writes);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e57b8af06be9..c795abe47a4f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1709,6 +1709,7 @@ static void fuse_sb_defaults(struct super_block *sb)
>  	sb->s_export_op = &fuse_export_operations;
>  	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
>  	sb->s_iflags |= SB_I_NOIDMAP;
> +	sb->s_iflags |= SB_I_NO_DATA_INTEGRITY;
>  	if (sb->s_user_ns != &init_user_ns)
>  		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
>  	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
> diff --git a/fs/sync.c b/fs/sync.c
> index 942a60cfedfb..88c08e2f76b2 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -73,7 +73,7 @@ EXPORT_SYMBOL(sync_filesystem);
>  
>  static void sync_inodes_one_sb(struct super_block *sb, void *arg)
>  {
> -	if (!sb_rdonly(sb))
> +	if (!sb_rdonly(sb) && !(sb->s_iflags & SB_I_NO_DATA_INTEGRITY))
>  		sync_inodes_sb(sb);
>  }
>  
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
> index fa7638b81246..383050e7fdf5 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -338,5 +338,6 @@ struct super_block {
>  #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
>  #define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
>  #define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
> +#define SB_I_NO_DATA_INTEGRITY	0x00008000 /* fs cannot guarantee data persistence on sync */
>  
>  #endif /* _LINUX_FS_SUPER_TYPES_H */
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ec442af3f886..31a848485ad9 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,7 +210,6 @@ enum mapping_flags {
>  	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
>  	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
>  				   account usage to user cgroups */
> -	AS_NO_DATA_INTEGRITY = 11, /* no data integrity guarantees */
>  	/* Bits 16-25 are used for FOLIO_ORDER */
>  	AS_FOLIO_ORDER_BITS = 5,
>  	AS_FOLIO_ORDER_MIN = 16,
> @@ -346,16 +345,6 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
>  	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
>  }
>  
> -static inline void mapping_set_no_data_integrity(struct address_space *mapping)
> -{
> -	set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> -}
> -
> -static inline bool mapping_no_data_integrity(const struct address_space *mapping)
> -{
> -	return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> -}
> -
>  static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
>  {
>  	return mapping->gfp_mask;
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

