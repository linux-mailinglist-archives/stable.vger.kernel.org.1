Return-Path: <stable+bounces-272931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QMGDDmCjT2r9lQIAu9opvQ
	(envelope-from <stable+bounces-272931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 15:34:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C71737319E3
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 15:34:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Gt8hAhG4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uMacfiTg;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Gt8hAhG4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uMacfiTg;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272931-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272931-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4C9B3032B5C
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 13:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF35296BD2;
	Thu,  9 Jul 2026 13:34:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14308292B2E
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:34:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604053; cv=none; b=Ak1dc4/8g5lbghQuGb1Vw1HtzbnjhBRAb6oNTKr5O0/DzEDThmwznQru6pUl7EkeI7XaExx1OfqeCAfDcBUiK+k23zhbAbYuZ7uo4Qu8sUPh5vLC25kVjdE2c9yiFACkPmLJ2RVv35EYU7jPeJKl7n9jlFv7I57sDoWmbQOK8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604053; c=relaxed/simple;
	bh=FOVocem26volhUw/xQd0rQdWKak4frEjmSSDaUnue3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHr9H+cPHZJdCQvGjYXgUAnIggTYMX7UovL7PXHXAMbfHW/p2ll3XkAoo4ys9gRHdNoTBxENCSccC3is2q6Ey3AyABPwziUiesJURtSAV2DhBFlT8uFXXN7FjXDBNh7NOUwvSu/+L7cuJqhFOmtWVlCBjjg5HraWE9Co5URgqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gt8hAhG4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uMacfiTg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gt8hAhG4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uMacfiTg; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2807376217;
	Thu,  9 Jul 2026 13:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783604050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iFNxf5m7YMuDO/IyYdV/vAHX6m8ysI7NHGcCx7xYyRo=;
	b=Gt8hAhG4KiR9wHyeAQa/rRLvs6jySQT2HBFPyxTZaG3l65QX2sixfAUumblmOfDBfa/xmX
	cbWxbzgc4ONkGVZ+E8VqORVm3fx12p3uq6MVsaPsWprhE3Zrz3FmEgn6y/bqQfZvpaIKPJ
	YY/6/p0rMyic73SxF8FWnRaI57Xzjuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783604050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iFNxf5m7YMuDO/IyYdV/vAHX6m8ysI7NHGcCx7xYyRo=;
	b=uMacfiTgd4jCNytnhnO2jPgT/+e0PzmWksDoP2QwizMgfyyc0r8107xBDRZkwZWZcb92SN
	o9DiIAm7H6nD60AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783604050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iFNxf5m7YMuDO/IyYdV/vAHX6m8ysI7NHGcCx7xYyRo=;
	b=Gt8hAhG4KiR9wHyeAQa/rRLvs6jySQT2HBFPyxTZaG3l65QX2sixfAUumblmOfDBfa/xmX
	cbWxbzgc4ONkGVZ+E8VqORVm3fx12p3uq6MVsaPsWprhE3Zrz3FmEgn6y/bqQfZvpaIKPJ
	YY/6/p0rMyic73SxF8FWnRaI57Xzjuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783604050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iFNxf5m7YMuDO/IyYdV/vAHX6m8ysI7NHGcCx7xYyRo=;
	b=uMacfiTgd4jCNytnhnO2jPgT/+e0PzmWksDoP2QwizMgfyyc0r8107xBDRZkwZWZcb92SN
	o9DiIAm7H6nD60AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0AD2779AA;
	Thu,  9 Jul 2026 13:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PUzAOlGjT2qNNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 Jul 2026 13:34:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9D9FDA12D7; Thu, 09 Jul 2026 15:34:05 +0200 (CEST)
Date: Thu, 9 Jul 2026 15:34:05 +0200
From: Jan Kara <jack@suse.cz>
To: Guanghui Yang <3497809730@qq.com>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Zhang Yi <yi.zhang@huawei.com>, Harshad Shirwadkar <harshadshirwadkar@gmail.com>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ext4: propagate errors from fast commit range replay
Message-ID: <jonvdfonxtxglhvygdcrwuqznlgqeuc6ymrwdsymkm6kvkwdho@rxtdidtkswpi>
References: <tencent_E3622146846A84C75C31C7D32AC4D5AD0605@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E3622146846A84C75C31C7D32AC4D5AD0605@qq.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:3497809730@qq.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:libaokun@linux.alibaba.com,m:jack@suse.cz,m:ojaswin@linux.ibm.com,m:ritesh.list@gmail.com,m:yi.zhang@huawei.com,m:harshadshirwadkar@gmail.com,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:riteshlist@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[qq.com];
	FORGED_SENDER(0.00)[jack@suse.cz,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272931-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,vger.kernel.org:from_smtp,suse.cz:from_mime,suse.cz:email,suse.cz:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qq.com:email,rxtdidtkswpi:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,linux.alibaba.com,suse.cz,linux.ibm.com,gmail.com,huawei.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C71737319E3

On Wed 08-07-26 08:12:04, Guanghui Yang wrote:
> ext4_fc_replay() stops replaying fast commit tags only when a tag
> handler returns a negative error. However, ext4_fc_replay_add_range()
> and ext4_fc_replay_del_range() currently return 0 from their common
> exit paths even after internal failures.
> 
> This hides errors from ext4_fc_record_modified_inode(),
> ext4_map_blocks(), ext4_find_extent(), ext4_ext_insert_extent(),
> ext4_ext_replay_update_ex(), and ext4_ext_remove_space(). As a result,
> a failed ADD_RANGE or DEL_RANGE replay can be treated as successful and
> the replay code may continue with subsequent fast commit tags.
> 
> This is particularly problematic for DEL_RANGE because it may already
> have marked blocks as free before ext4_ext_remove_space() fails. If the
> error is swallowed, replay may continue from a partially applied range
> operation.
> 
> Return the saved error from the common exit paths and make the
> ERR_PTR() cases in ADD_RANGE store PTR_ERR() before jumping to out.
> 
> Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanghui Yang <3497809730@qq.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 8e2259799614..fbb486d917b0 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -2196,8 +2196,11 @@ static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
>  		if (ret == 0) {
>  			/* Range is not mapped */
>  			path = ext4_find_extent(inode, cur, path, 0);
> -			if (IS_ERR(path))
> +			if (IS_ERR(path)) {
> +				ret = PTR_ERR(path);
> +				path = NULL;
>  				goto out;
> +			}
>  			memset(&newex, 0, sizeof(newex));
>  			newex.ee_block = cpu_to_le32(cur);
>  			ext4_ext_store_pblock(
> @@ -2209,8 +2212,11 @@ static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
>  			path = ext4_ext_insert_extent(NULL, inode,
>  						      path, &newex, 0);
>  			up_write((&EXT4_I(inode)->i_data_sem));
> -			if (IS_ERR(path))
> +			if (IS_ERR(path)) {
> +				ret = PTR_ERR(path);
> +				path = NULL;
>  				goto out;
> +			}
>  			goto next;
>  		}
>  
> @@ -2257,10 +2263,11 @@ static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
>  	}
>  	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
>  					sb->s_blocksize_bits);
> +	ret = 0;
>  out:
>  	ext4_free_ext_path(path);
>  	iput(inode);
> -	return 0;
> +	return ret;
>  }
>  
>  /* Replay DEL_RANGE tag */
> @@ -2320,9 +2327,10 @@ ext4_fc_replay_del_range(struct super_block *sb, u8 *val)
>  	ext4_ext_replay_shrink_inode(inode,
>  		i_size_read(inode) >> sb->s_blocksize_bits);
>  	ext4_mark_inode_dirty(NULL, inode);
> +	ret = 0;
>  out:
>  	iput(inode);
> -	return 0;
> +	return ret;
>  }
>  
>  static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
> 
> base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

