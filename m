Return-Path: <stable+bounces-93518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1387E9CDE09
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C693E282ED1
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F41B3942;
	Fri, 15 Nov 2024 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x4LNzfPx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QIfRwJrQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x4LNzfPx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QIfRwJrQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF242AE77;
	Fri, 15 Nov 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731672476; cv=none; b=Y3U/EERQxSPni0uegnjQOh0eQCukTjNV8/J24CpOZvQLWDtw/IYBAEQrWV1CMonUFVy1J87mVzS1yZX7bbW8AYred4oeVFpLJm0A78+w5nXGm0GjbgF7XhWCmiDAsOOVW41RPO8De1yEWK6ilrjYlfrKAINqW0gc9WMUqgSunSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731672476; c=relaxed/simple;
	bh=cv94k1575k0plV/WED/gqUUaR4Yw6Ouxz4HY0kEdPR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx7KJapw3W7U/8vpAT/1VYqjptX5We6oHKRErE83lJNWfjYUM0UXzDkyjeg0ZfwMlTgjd12LJDYntKU8Ij2uB2C5ww403IUjZRSYITMCy+rBiWBuGCheerpbU/EdYHzsBpfl2Si2pp8ImvWFG2y7FPPSLQAgETF8jJz3jPjRlCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x4LNzfPx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QIfRwJrQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x4LNzfPx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QIfRwJrQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B838D211D3;
	Fri, 15 Nov 2024 12:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731672471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBl56xsKRUMmVc6dc6zpJ+ftP08kymo5S6Py3Oxuduc=;
	b=x4LNzfPxOkftZYpQ/hCBpLwvyD01qHMs8ghTQB8+GvYbiFLxO/Qmjg+CiwHNw79Hz9NAZK
	CXbHccEyOT+oCWlMHw4o7trMiuU8rjoKqmjWps4SAMO6vVdx/oOAKlII6koN8WOtfGpYBf
	IxCe5GFkhkfXp7wPa8PxA8s88U5Y/qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731672471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBl56xsKRUMmVc6dc6zpJ+ftP08kymo5S6Py3Oxuduc=;
	b=QIfRwJrQZVnsXAYD/WAlEGD0OfIB53OtrfP34C7hbdtrE0939BQul23wxD2ufH7BWsWOII
	QBqkxViM88jRBkDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731672471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBl56xsKRUMmVc6dc6zpJ+ftP08kymo5S6Py3Oxuduc=;
	b=x4LNzfPxOkftZYpQ/hCBpLwvyD01qHMs8ghTQB8+GvYbiFLxO/Qmjg+CiwHNw79Hz9NAZK
	CXbHccEyOT+oCWlMHw4o7trMiuU8rjoKqmjWps4SAMO6vVdx/oOAKlII6koN8WOtfGpYBf
	IxCe5GFkhkfXp7wPa8PxA8s88U5Y/qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731672471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBl56xsKRUMmVc6dc6zpJ+ftP08kymo5S6Py3Oxuduc=;
	b=QIfRwJrQZVnsXAYD/WAlEGD0OfIB53OtrfP34C7hbdtrE0939BQul23wxD2ufH7BWsWOII
	QBqkxViM88jRBkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD20D134B8;
	Fri, 15 Nov 2024 12:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wec8Kpc5N2fEeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Nov 2024 12:07:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 64202A0986; Fri, 15 Nov 2024 13:07:51 +0100 (CET)
Date: Fri, 15 Nov 2024 13:07:51 +0100
From: Jan Kara <jack@suse.cz>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCHv2 5.15] udf: Allocate name buffer in directory iterator
 on heap
Message-ID: <20241115120751.fnsvzo4453ab7hnt@quack3>
References: <20241115060859.2453211-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115060859.2453211-1-senozhatsky@chromium.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 15-11-24 15:08:48, Sergey Senozhatsky wrote:
> From: Jan Kara <jack@suse.cz>
> 
> [ Upstream commit 0aba4860b0d0216a1a300484ff536171894d49d8 ]
> 
> Currently we allocate name buffer in directory iterators (struct
> udf_fileident_iter) on stack. These structures are relatively large
> (some 360 bytes on 64-bit architectures). For udf_rename() which needs
> to keep three of these structures in parallel the stack usage becomes
> rather heavy - 1536 bytes in total. Allocate the name buffer in the
> iterator from heap to avoid excessive stack usage.
> 
> Link: https://lore.kernel.org/all/202212200558.lK9x1KW0-lkp@intel.com
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> [ senozhatsky: explicitly include slab.h to address build
>   failure reported by sashal@ ]
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Mauke beat you to this, Greg already queued up his patches :)

[1] https://lore.kernel.org/all/20241114212657.306989-1-hauke@hauke-m.de

								Honza
> ---
>  fs/udf/directory.c | 24 ++++++++++++++++--------
>  fs/udf/udfdecl.h   |  2 +-
>  2 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/udf/directory.c b/fs/udf/directory.c
> index e97ffae07833..a30898debdd1 100644
> --- a/fs/udf/directory.c
> +++ b/fs/udf/directory.c
> @@ -19,6 +19,7 @@
>  #include <linux/bio.h>
>  #include <linux/crc-itu-t.h>
>  #include <linux/iversion.h>
> +#include <linux/slab.h>
>  
>  static int udf_verify_fi(struct udf_fileident_iter *iter)
>  {
> @@ -248,9 +249,14 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
>  	iter->elen = 0;
>  	iter->epos.bh = NULL;
>  	iter->name = NULL;
> +	iter->namebuf = kmalloc(UDF_NAME_LEN_CS0, GFP_KERNEL);
> +	if (!iter->namebuf)
> +		return -ENOMEM;
>  
> -	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
> -		return udf_copy_fi(iter);
> +	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
> +		err = udf_copy_fi(iter);
> +		goto out;
> +	}
>  
>  	if (inode_bmap(dir, iter->pos >> dir->i_blkbits, &iter->epos,
>  		       &iter->eloc, &iter->elen, &iter->loffset) !=
> @@ -260,17 +266,17 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
>  		udf_err(dir->i_sb,
>  			"position %llu not allocated in directory (ino %lu)\n",
>  			(unsigned long long)pos, dir->i_ino);
> -		return -EFSCORRUPTED;
> +		err = -EFSCORRUPTED;
> +		goto out;
>  	}
>  	err = udf_fiiter_load_bhs(iter);
>  	if (err < 0)
> -		return err;
> +		goto out;
>  	err = udf_copy_fi(iter);
> -	if (err < 0) {
> +out:
> +	if (err < 0)
>  		udf_fiiter_release(iter);
> -		return err;
> -	}
> -	return 0;
> +	return err;
>  }
>  
>  int udf_fiiter_advance(struct udf_fileident_iter *iter)
> @@ -307,6 +313,8 @@ void udf_fiiter_release(struct udf_fileident_iter *iter)
>  	brelse(iter->bh[0]);
>  	brelse(iter->bh[1]);
>  	iter->bh[0] = iter->bh[1] = NULL;
> +	kfree(iter->namebuf);
> +	iter->namebuf = NULL;
>  }
>  
>  static void udf_copy_to_bufs(void *buf1, int len1, void *buf2, int len2,
> diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
> index f764b4d15094..d35aa42bb577 100644
> --- a/fs/udf/udfdecl.h
> +++ b/fs/udf/udfdecl.h
> @@ -99,7 +99,7 @@ struct udf_fileident_iter {
>  	struct extent_position epos;	/* Position after the above extent */
>  	struct fileIdentDesc fi;	/* Copied directory entry */
>  	uint8_t *name;			/* Pointer to entry name */
> -	uint8_t namebuf[UDF_NAME_LEN_CS0]; /* Storage for entry name in case
> +	uint8_t *namebuf;		/* Storage for entry name in case
>  					 * the name is split between two blocks
>  					 */
>  };
> -- 
> 2.47.0.338.g60cca15819-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

