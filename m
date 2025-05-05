Return-Path: <stable+bounces-139655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E311AA90AF
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6354C1896E3D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FE71F5402;
	Mon,  5 May 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O0ozi0Yy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eDLxeXUj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O0ozi0Yy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eDLxeXUj"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A141E5711
	for <stable@vger.kernel.org>; Mon,  5 May 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746440143; cv=none; b=LbOHmkv1/KpJyQyxpuKkdxGTIgb7/nLrZG8psdj9Ywfyn61yHlD1gZ6Cf+qykTP2cIzhOvcQ71UVB/wWL9WNqlLuy3NPitNSTbJMswGozDlONGGL0ir6GLhRFKd3MmSnOhdceBS7uA4Apxm1tz7/qzSQfL+5rKOiXNLBByR1Gjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746440143; c=relaxed/simple;
	bh=snF7aYKt9AG7vZEbsjnjM619XOg20nFrINAofsqZ3EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7TbR2X3TSBvHkB7r4q2XnAPFuknayC2t/bC+EepOZXUkRVHz5m0V2OtLhzyUgN+OPDLIyjogVIQBM5RcZCo5AcYrCZIzogBxKH1AA1VUoAM8szxh8LV7u+XUix87lYeNsSx9b/yK29ROe/1gn443nkYhmVWJ5QPxz9ioMGJwvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O0ozi0Yy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eDLxeXUj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O0ozi0Yy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eDLxeXUj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B96F2123E;
	Mon,  5 May 2025 10:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746440140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAbhV4/tIIoCKneizhnsh4v1nbNLXfelEvALszEo3qE=;
	b=O0ozi0YyzWYSTL0UO+7fxLULKwVHY6hkMpYmnJ9lQXlqajfflFZXVGUrQ72JkscFGb5Oi9
	5bUt1SS680pAqOfdaH87LsjNaMazqH1mz3RfuzpTIGr0HUhJn9KFt4hNB2cj0ISC5hSMWP
	jinslxMrb9FGkdemw4eLbvR7m9KKm74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746440140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAbhV4/tIIoCKneizhnsh4v1nbNLXfelEvALszEo3qE=;
	b=eDLxeXUjjaD/AUu9uRgIG/wA3Epgy07dGouxPaahhKorPQ09YfpJCRDAgUjk1rsxHQuVxz
	tQ6g8Pi9dd595dAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=O0ozi0Yy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eDLxeXUj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746440140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAbhV4/tIIoCKneizhnsh4v1nbNLXfelEvALszEo3qE=;
	b=O0ozi0YyzWYSTL0UO+7fxLULKwVHY6hkMpYmnJ9lQXlqajfflFZXVGUrQ72JkscFGb5Oi9
	5bUt1SS680pAqOfdaH87LsjNaMazqH1mz3RfuzpTIGr0HUhJn9KFt4hNB2cj0ISC5hSMWP
	jinslxMrb9FGkdemw4eLbvR7m9KKm74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746440140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAbhV4/tIIoCKneizhnsh4v1nbNLXfelEvALszEo3qE=;
	b=eDLxeXUjjaD/AUu9uRgIG/wA3Epgy07dGouxPaahhKorPQ09YfpJCRDAgUjk1rsxHQuVxz
	tQ6g8Pi9dd595dAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7A6D13883;
	Mon,  5 May 2025 10:15:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cLiDOMuPGGhCegAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 May 2025 10:15:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E484EA0670; Mon,  5 May 2025 12:15:38 +0200 (CEST)
Date: Mon, 5 May 2025 12:15:38 +0200
From: Jan Kara <jack@suse.cz>
To: Andrey Kriulin <kitotavrik.s@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Andrey Kriulin <kitotavrik.media@gmail.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Josef Bacik <josef@toxicpanda.com>, NeilBrown <neilb@suse.de>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: minix: Fix handling of corrupted directories
Message-ID: <a6log74bqsrkzlrckh3gbzpi4mxuj45mr7tddtghck76oum4io@pmks35zdahqn>
References: <20250502164337.62895-1-kitotavrik.media@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502164337.62895-1-kitotavrik.media@gmail.com>
X-Rspamd-Queue-Id: 0B96F2123E
X-Spam-Score: -2.51
X-Rspamd-Action: no action
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
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,infradead.org,toxicpanda.com,suse.de,suse.cz,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 02-05-25 19:43:36, Andrey Kriulin wrote:
> If the directory is corrupted and the number of nlinks is less than 2 
> (valid nlinks have at least 2), then when the directory is deleted, the
> minix_rmdir will try to reduce the nlinks(unsigned int) to a negative
> value.
> 
> Make nlinks validity check for directory in minix_lookup.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Kriulin <kitotavrik.media@gmail.com>

Thanks for the patch. One comment below.

> diff --git a/fs/minix/namei.c b/fs/minix/namei.c
> index 8938536d8..5717a56fa 100644
> --- a/fs/minix/namei.c
> +++ b/fs/minix/namei.c
> @@ -28,8 +28,13 @@ static struct dentry *minix_lookup(struct inode * dir, struct dentry *dentry, un
>  		return ERR_PTR(-ENAMETOOLONG);
>  
>  	ino = minix_inode_by_name(dentry);
> -	if (ino)
> +	if (ino) {
>  		inode = minix_iget(dir->i_sb, ino);
> +		if (S_ISDIR(inode->i_mode) && inode->i_nlink < 2) {
> +			iput(inode);
> +			return ERR_PTR(-EIO);
> +		}
> +	}
>  	return d_splice_alias(inode, dentry);
>  }

I don't think this is the best place to handle such check. IMO it would be
more logical to do it in minix_iget() - V[12]_minix_iget() to be more
precise - to properly catch all the paths where the inode is loaded into
memory. This way your check will not happen for the root directory inode
for example.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

