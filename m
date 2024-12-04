Return-Path: <stable+bounces-98269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE009E3739
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 11:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01D0B2516C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 10:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6C81A0B07;
	Wed,  4 Dec 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DzJe1ISN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Sf2Njho";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nqygL3p6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5nJfIlNF"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091EF199EA8
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306895; cv=none; b=syC5dTd0Qnk3kFRw8SSQbi+4eOnxt804nNWR8YQhAzfJ1ztuMVWJufGHcA28NtxXLSu1V+V5ebxF1xswFtoWZ6XCYWj0Tr6h1e4r2w2tJUniAYxtIAqFrV+Ejv9mPTDOz73mC+iw61TST3At1aFAVL9Pny15wUL9Kd2gJ6R6Z+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306895; c=relaxed/simple;
	bh=Zazrb4J8g3ClxvwCQ/DO89s1q9XaA80PgAC+QPgX8Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egPzu9Aw89hqL3Edwzs+dBhUaZC1rI6qwv2vV4e6edaOu5QiyLriTe1yxoS2jBAXPiIhfHqTbg6e0JJAcMbm36bmx0AVAqJy3RxB9tnwglUW1KKOw4ePr766H5A+nTBSMLCrGrICZywD3QxwTIXtfkvpxwyZXCoda/M/89dwObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DzJe1ISN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Sf2Njho; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nqygL3p6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5nJfIlNF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB1211F365;
	Wed,  4 Dec 2024 10:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733306892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB1JejBL752uPr6dQ98f6dTDLRVpGbyFkH26mYiKGNE=;
	b=DzJe1ISN+6RgEveA+d99YQzCBMufnXFvJPWrMf9sE2U0O42dgmgfGGGeTF6FBeS77yQZDg
	f2kKipmJSKOT0S3VscQdsr+xRvV7tEJrkWbrmDyEM7efsKeKMvDSUAHuTiiOGGrSjhUsiF
	sqdABqOzmXp343FkGqrGCvrBvLeEMFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733306892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB1JejBL752uPr6dQ98f6dTDLRVpGbyFkH26mYiKGNE=;
	b=2Sf2NjhoebeUzhmLZ24056rDicZCfzBKC0tkOOXBWBfkoFPbx3/m6crN20r0/6IoMVPd33
	1z+PHvffrZf7vUBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nqygL3p6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5nJfIlNF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733306891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB1JejBL752uPr6dQ98f6dTDLRVpGbyFkH26mYiKGNE=;
	b=nqygL3p661HwuL1iWlgZ9P+9NYwLLZf2wjfd48VkGXLuNv+kny3CZdxf6cZnlaj8PXXehr
	29QUqPaju3/pJwO1MsjfXpTVsm/zJaRcpJI3tyYbusZcvZG2uD7GqlC9BMz60qtuPHJ2lD
	CLwRe7y7RsUV1JNx5y9wYB4dlyTnNj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733306891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB1JejBL752uPr6dQ98f6dTDLRVpGbyFkH26mYiKGNE=;
	b=5nJfIlNF1bWR2h8AtY7UyDg57APLG7gI1hhssrB2+gvGjC9kz2rFF/hWvJq7sLqcNUCr1b
	1UeIzrIxHhWQ2vCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1D661396E;
	Wed,  4 Dec 2024 10:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y2geNwsqUGfXeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 10:08:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A0548A0918; Wed,  4 Dec 2024 11:08:11 +0100 (CET)
Date: Wed, 4 Dec 2024 11:08:11 +0100
From: Jan Kara <jack@suse.cz>
To: Jakub Acs <acsjakub@amazon.com>
Cc: gregkh@linuxfoundation.org, acsjakub@amazon.de, jack@suse.cz,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 6.1] udf: Fold udf_getblk() into udf_bread()
Message-ID: <20241204100811.c7kvouk3es7oryx6@quack3>
References: <2024112908-stillness-alive-c9d1@gregkh>
 <20241204093226.60654-1-acsjakub@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204093226.60654-1-acsjakub@amazon.com>
X-Rspamd-Queue-Id: EB1211F365
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,syzkaller.appspot.com:url,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 04-12-24 09:32:26, Jakub Acs wrote:
> commit 32f123a3f34283f9c6446de87861696f0502b02e upstream.
> 
> udf_getblk() has a single call site. Fold it there.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> 
> [acsjakub: backport-adjusting changes]
> udf_getblk() has changed between 6.1 and the backported commit namely
> in commit 541e047b14c8 ("udf: Use udf_map_block() in udf_getblk()")
> 
> Backport using the form of udf_getblk present in 6.1., that means use
> udf_get_block() instead of udf_map_block() and use dummy in buffer_new()
> and buffer_mapped().
> 
> Closes: https://syzkaller.appspot.com/bug?extid=a38e34ca637c224f4a79
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> ---
> While doing the backport I have noticed potential side effect of the
> upstream commit (present in the mainline):
> 
> If we take the if-branch of 'if (map.oflags & UDF_BLK_NEW)', we will
> return the bh without the 'if (bh_read(bh, 0) >= 0)' check. Prior to
> the folding, the check wouldn't be skipped, was this intentional by the
> upstream commit?

Absolutely. bh_read() is pointless if you fill in the buffer contents
yourself (as we do in the 'if (map.oflags & UDF_BLK_NEW)' branch).

								Honza

> ---
>  fs/udf/inode.c | 46 +++++++++++++++++++++-------------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index d7d6ccd0af06..626450101412 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -369,29 +369,6 @@ static int udf_get_block(struct inode *inode, sector_t block,
>  	return err;
>  }
>  
> -static struct buffer_head *udf_getblk(struct inode *inode, udf_pblk_t block,
> -				      int create, int *err)
> -{
> -	struct buffer_head *bh;
> -	struct buffer_head dummy;
> -
> -	dummy.b_state = 0;
> -	dummy.b_blocknr = -1000;
> -	*err = udf_get_block(inode, block, &dummy, create);
> -	if (!*err && buffer_mapped(&dummy)) {
> -		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
> -		if (buffer_new(&dummy)) {
> -			lock_buffer(bh);
> -			memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
> -			set_buffer_uptodate(bh);
> -			unlock_buffer(bh);
> -			mark_buffer_dirty_inode(bh, inode);
> -		}
> -		return bh;
> -	}
> -
> -	return NULL;
> -}
>  
>  /* Extend the file with new blocks totaling 'new_block_bytes',
>   * return the number of extents added
> @@ -1108,10 +1085,29 @@ struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
>  			      int create, int *err)
>  {
>  	struct buffer_head *bh = NULL;
> +	struct buffer_head dummy;
>  
> -	bh = udf_getblk(inode, block, create, err);
> -	if (!bh)
> +	dummy.b_state = 0;
> +	dummy.b_blocknr = -1000;
> +
> +	*err = udf_get_block(inode, block, &dummy, create);
> +	if (*err || !buffer_mapped(&dummy))
> +		return NULL
> +
> +	bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
> +	if (!bh) {
> +		*err = -ENOMEM;
>  		return NULL;
> +	}
> +
> +	if (buffer_new(&dummy)) {
> +		lock_buffer(bh);
> +		memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
> +		set_buffer_uptodate(bh);
> +		unlock_buffer(bh);
> +		mark_buffer_dirty_inode(bh, inode);
> +		return bh;
> +	}
>  
>  	if (bh_read(bh, 0) >= 0)
>  		return bh;
> 
> base-commit: e4d90d63d385228b1e0bcf31cc15539bbbc28f7f
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

