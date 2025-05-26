Return-Path: <stable+bounces-146383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74654AC4286
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 17:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354B8179D4B
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CD02116F6;
	Mon, 26 May 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z30MtVp0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v3sq5DWo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z30MtVp0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v3sq5DWo"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981542110E
	for <stable@vger.kernel.org>; Mon, 26 May 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274236; cv=none; b=jMrweJtQIU5js2wP8PQuapvlPwNVkI/CCt4dLiFjVCLYwhar5ReCwQkjKe0bIHFmhGec6eCAe3xB585SzVOmXuQkUwHCXkc9+EP8b+QDaQT17srUMvl3OAZmVdW2UH2rmRj6k6SyJLGzhMKBS0o+HtzC/vkAVRYlY8qSsX89GAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274236; c=relaxed/simple;
	bh=xv8AfnRqO38sP4oCPFhVGu0YRZHZcgLKvWORuSlKXcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1Q2qM09DVV6+FTTexWywPGuX/nF25wQxnzaeGsAligHsnUfed4/s11EKxZSCT+4D8d77E4uaJNjKv0cthaCmHZFumwguUFXLnrhufM6xp+KaftzHMNLT5+6jJG6/s7iq55fZAHxvzpSJ6rbWvCZC9Ou9hPl64Tol06DHGnh2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z30MtVp0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v3sq5DWo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z30MtVp0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v3sq5DWo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A48F021C91;
	Mon, 26 May 2025 15:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748274232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Lsl2PZ+AkyJHQ1VSXVGBjHiRRbFkhaTxU7k6S3dk54=;
	b=Z30MtVp0j/pj5sTUfXqeCDyK5Uc9i6r/h2J8LQg6y4ERuJtBucOXmHizjJ1uyCu6DE5CEY
	FhGp/UA2ot76UG+dVMqK+PT4F7yTijIagsZLGnRixvhujL+tY7+ss637sHeabmYroQU/eD
	rOYZndyai2ocJzoYmen9CdqefGCmIQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748274232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Lsl2PZ+AkyJHQ1VSXVGBjHiRRbFkhaTxU7k6S3dk54=;
	b=v3sq5DWoP+QeAVXnS3qF8bMNFjewCP/hFG9PgcvTvl+8Gqu7V0QNo0EhVcc35mVAWIreZC
	SZPldEvrfHF3ksDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748274232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Lsl2PZ+AkyJHQ1VSXVGBjHiRRbFkhaTxU7k6S3dk54=;
	b=Z30MtVp0j/pj5sTUfXqeCDyK5Uc9i6r/h2J8LQg6y4ERuJtBucOXmHizjJ1uyCu6DE5CEY
	FhGp/UA2ot76UG+dVMqK+PT4F7yTijIagsZLGnRixvhujL+tY7+ss637sHeabmYroQU/eD
	rOYZndyai2ocJzoYmen9CdqefGCmIQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748274232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Lsl2PZ+AkyJHQ1VSXVGBjHiRRbFkhaTxU7k6S3dk54=;
	b=v3sq5DWoP+QeAVXnS3qF8bMNFjewCP/hFG9PgcvTvl+8Gqu7V0QNo0EhVcc35mVAWIreZC
	SZPldEvrfHF3ksDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86B721397F;
	Mon, 26 May 2025 15:43:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 94J5IDiMNGgJZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 May 2025 15:43:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1640AA09B7; Mon, 26 May 2025 17:43:52 +0200 (CEST)
Date: Mon, 26 May 2025 17:43:52 +0200
From: Jan Kara <jack@suse.cz>
To: Andrey Kriulin <kitotavrik.s@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Josef Bacik <josef@toxicpanda.com>, NeilBrown <neilb@suse.de>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v4] fs: minix: Fix handling of corrupted directories
Message-ID: <zafsc24r3f4jes3jqbrvwuwust3h22c74icypwd2he2bihqzrp@vhb6qlu6bxqa>
References: <20250526033230.1664-1-kitotavrik.s@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526033230.1664-1-kitotavrik.s@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Mon 26-05-25 06:32:29, Andrey Kriulin wrote:
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

OK, I'm fine with this. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v4: Add nlinks check for parent dirictory to minix_rmdir per Jan
> Kara <jack@suse.cz> request.
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
> index 8938536d8d3c..ab86fd16e548 100644
> --- a/fs/minix/namei.c
> +++ b/fs/minix/namei.c
> @@ -161,8 +161,12 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
>  static int minix_rmdir(struct inode * dir, struct dentry *dentry)
>  {
>  	struct inode * inode = d_inode(dentry);
> -	int err = -ENOTEMPTY;
> +	int err = -EUCLEAN;
>  
> +	if (inode->i_nlink < 2 || dir->i_nlink <= 2)
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

