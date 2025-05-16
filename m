Return-Path: <stable+bounces-144591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8CBAB9A03
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 12:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC834A7B8F
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9843233706;
	Fri, 16 May 2025 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qs7y4MPx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NLdK9TgS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qs7y4MPx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NLdK9TgS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F01B21ABDA
	for <stable@vger.kernel.org>; Fri, 16 May 2025 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390982; cv=none; b=knE+Is7xkmavkOEJk/6vAGH5HNfHyTHRwXBmThhsM0/SgKc4OwHTbyMHcAuqL8S49h/+iy4gS9vsZMNIOf3YdpfNjrl8QGcQHNwXLq2m6ive/KAujsDlyHGIY8cDHSdhQIELeEaY4Q9nh5M2pZHNat8IqVw2smxOhcRIKcST16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390982; c=relaxed/simple;
	bh=2RML4bc73QeojdsIhKSTiERj8sZUEd792kGhlylelEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF0m2wLF4K9hppvO2JibFplI0ckUqBVL0XC2zLCWgod1w48YU7IHfi5xubwHl10cy7FsrIKv2LGnZ2Bfiu7kOErPIqABpSvvQ94DaNEKtqEs2nRF3b/0JtTccMf99Xb3Av8YvsScsM8116SuaLPgXJT07g2cZO9NIs0mFRHZREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qs7y4MPx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NLdK9TgS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qs7y4MPx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NLdK9TgS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F04A2126F;
	Fri, 16 May 2025 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747390978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OWrJPjWlYuwuMcb4sBTH247o2s/AahWTBVUEKMJk8Ao=;
	b=qs7y4MPxGbRdL1PI5KsFP/sKCIizSwmP7t50XAKq6TPqxpO8uTrjqsM9MKREie2u8y6Gn0
	DINBVB6avH8QT/F2qL+tVNUb4b+Hg9/GklsbvlkBryU7pU9E7yXw7MpXzY4pzPi8t4szGV
	LzsDDeiVwzJzmRrZ/qstSwr88C63w+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747390978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OWrJPjWlYuwuMcb4sBTH247o2s/AahWTBVUEKMJk8Ao=;
	b=NLdK9TgS2yfzomDgInwe0WAHze51rwAvhLcsoXa7lGaKu7KF1MmkL5cNe+ztYgr0Yy/3Cr
	MjdhEF02MH9GBPAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qs7y4MPx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NLdK9TgS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747390978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OWrJPjWlYuwuMcb4sBTH247o2s/AahWTBVUEKMJk8Ao=;
	b=qs7y4MPxGbRdL1PI5KsFP/sKCIizSwmP7t50XAKq6TPqxpO8uTrjqsM9MKREie2u8y6Gn0
	DINBVB6avH8QT/F2qL+tVNUb4b+Hg9/GklsbvlkBryU7pU9E7yXw7MpXzY4pzPi8t4szGV
	LzsDDeiVwzJzmRrZ/qstSwr88C63w+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747390978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OWrJPjWlYuwuMcb4sBTH247o2s/AahWTBVUEKMJk8Ao=;
	b=NLdK9TgS2yfzomDgInwe0WAHze51rwAvhLcsoXa7lGaKu7KF1MmkL5cNe+ztYgr0Yy/3Cr
	MjdhEF02MH9GBPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B6FF13411;
	Fri, 16 May 2025 10:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zqEeEgISJ2jufgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 16 May 2025 10:22:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6E823A09DD; Fri, 16 May 2025 12:22:53 +0200 (CEST)
Date: Fri, 16 May 2025 12:22:53 +0200
From: Jan Kara <jack@suse.cz>
To: Andrey Kriulin <kitotavrik.s@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Josef Bacik <josef@toxicpanda.com>, NeilBrown <neilb@suse.de>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3] fs: minix: Fix handling of corrupted directories
Message-ID: <enhxf3daymfubn226ha4ywvh74k3zhacdya2mgfln7g2kzsq6x@llwzvp3vejsk>
References: <20250515175500.12128-1-kitotavrik.s@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515175500.12128-1-kitotavrik.s@gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6F04A2126F
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action

On Thu 15-05-25 20:54:57, Andrey Kriulin wrote:
> If the directory is corrupted and the number of nlinks is less than 2
> (valid nlinks have at least 2), then when the directory is deleted, the
> minix_rmdir will try to reduce the nlinks(unsigned int) to a negative
> value.
> 
> Make nlinks validity check for directories.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Kriulin <kitotavrik.s@gmail.com>

This patch is mostly fine (see just one nit below).

> ---
> v3: Move nlinks validaty check to minix_rmdir and minix_rename per Jan
> Kara <jack@suse.cz> request.
> v2: Move nlinks validaty check to V[12]_minix_iget() per Jan Kara
> <jack@suse.cz> request. Change return error code to EUCLEAN. Don't block
> directory in r/o mode per Al Viro <viro@zeniv.linux.org.uk> request.
> 
>  fs/minix/namei.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/minix/namei.c b/fs/minix/namei.c
> index 8938536d8d3c..5a1e5f8ef443 100644
> --- a/fs/minix/namei.c
> +++ b/fs/minix/namei.c
> @@ -161,8 +161,12 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
>  static int minix_rmdir(struct inode * dir, struct dentry *dentry)
>  {
>  	struct inode * inode = d_inode(dentry);
> -	int err = -ENOTEMPTY;
> +	int err = -EUCLEAN;
>  
> +	if (inode->i_nlink < 2)

This should be <= 2 as well?

								Honza

> +		return err;
> +
> +	err = -ENOTEMPTY;
>  	if (minix_empty_dir(inode)) {
>  		err = minix_unlink(dir, dentry);
>  		if (!err) {
> @@ -235,6 +239,10 @@ static int minix_rename(struct mnt_idmap *idmap,
>  	mark_inode_dirty(old_inode);
>  
>  	if (dir_de) {
> +		if (old_dir->i_nlink <= 2) {
> +			err = -EUCLEAN;
> +			goto out_dir;
> +		}
>  		err = minix_set_link(dir_de, dir_folio, new_dir);
>  		if (!err)
>  			inode_dec_link_count(old_dir);
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

