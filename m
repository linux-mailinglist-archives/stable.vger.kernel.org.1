Return-Path: <stable+bounces-223710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGzVKvIBr2lmLgIAu9opvQ
	(envelope-from <stable+bounces-223710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 18:22:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 289BD23D985
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 18:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12543304EA76
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE273ECBCD;
	Mon,  9 Mar 2026 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N96n+U84"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB53E7157
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076740; cv=none; b=Q8OKomI3cUM5BDcvpu6+CSGKtdWKWcyQvfF7fWP9RUVULjKg+phE4gxHF1TNz+alyJLiuGcHYtVxcZVFLfNawywrl/RlUsamXKI+4pXZ5fDOwMKkerIL8juUn6nWgb0J880pMA87TjvijCm8pX8MC6T6Pf/2tyOHKAoGjUnPUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076740; c=relaxed/simple;
	bh=LXPNVRwLDXG7DMw6P813qP1/gF0eFehhSZzvYzJcUjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ8SAoYd/l9Iz2Ciw8Xl36JNjwVfOZEJIRImonRGBKBXLMiKZWKNNstUf75G+IhOltl4wu3v2jxV39wgwJHaenqt6Wr4akr+mbkxM8LQRkwYwzuhY1vPAfcYhoewjS+VY6iegCTxpxSu/3pm9Pu4PuC+a2x2XAamNB3m+JmT/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N96n+U84; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48534e9076fso11609175e9.0
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773076736; x=1773681536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cptXPxAdAWXaSBoqhq6AwKwxFicTFTDFRJrNRG70crI=;
        b=N96n+U849zivqSiLo+DHRXCIl/CDi5Jgsad2miJ2EXVLvLBvI5KggInqN3AVmvkweB
         ZjgDHLP1uKI071LWz7W2ihvqgR8PnzcGjXm6iK8US+CwuqRX7G3fjTUdp1RFA9va+DT5
         JyMtMjdvWGKcd1Yc32JeAkR+BBotZiISk7EGOIiuoB5Dff0+aWouhleq7w5R6+/3LIiM
         0Au5JCFXRjwyKCrJ/W+LEbgq985N6LRgWIiF9RJ/o/cFNqsMFVG7HxpSecIlaS59wrvZ
         A5jFA6KhZl8/kjIQs4bBXVvZeBW2L8tLcT0cFP5aRFoOdcPs3/jFoJs+yzUIzlvTKvgC
         KYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076736; x=1773681536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cptXPxAdAWXaSBoqhq6AwKwxFicTFTDFRJrNRG70crI=;
        b=hkoW8HgQfC/o8BHvBHnQadscIznrXfL2dQWqstPYS31bukaukOPeQNMRk75mwq68VW
         KqF0HjV6+rd6gSKB9eE50zrMynlpGGCxKwbBVVKcjjaVhgyN3P75ySVT+gM8tfLMUtes
         Im0PGjlUyeSgjKfZF/zQ3ckxNze0vov1xrfWKx412jCX1K6dynQZrra/pogxS4moLYk6
         NdiSvc4SzUT6sRh+mHAdSaNd5+GYSh946T9SqQyUaOZAoHO/WUsb4NVtLyslCxnqIp2q
         lB+fTisbJQK/aWj+9GEJgEpYgqZRS0PlnLphGkHtloxakH9Qc5NARPCioSCnPaxdOIks
         BnuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOgWSGVNaOVH0VesDc+McOmxu2K+CEnVEVsw33wqCQuQsw7IozRmVlXKvo7QGeiWMqOQL2wXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYSKhgVVpv3Tv+IjRRGtoyZ/4f+/uIdlb0j+FaI08lRH6FZBwb
	KCZ03ZbpUQ/ugZiVTHwAs67M2UPkNpe3jWHXFnfz102QeHhjv8YzCtUUebagwMbWJ9Y=
X-Gm-Gg: ATEYQzyTTEVfqStKrdbKKLrO3r+ys1zSsz3plGa8uNlQqatDa3ljGVuY4dPNatyqN9b
	oKZuUFhG4Qqa8uFgYqyI54MhuFDbuw+v2K83cPQUDivWcF8505TOJy+RlrzJSyF8dlqe8FukliE
	7g5IfgfDYrnVKmP1382cDvr8ti14BcqVqGNR/CxQqQTJf34e1nnODA3XtyODcNed+Pb+p1bRe6J
	Rmi5XBvtIoMg3UlW/ewY6GnH6gbdCfVKR1fh/eFdz6n6PLd0fnXmqFn2zPmJ8ZMGNyO/F8iAlfg
	oddbVtl6kHsD9U97XmqdphAtrs7VtMonMzOv1evo4VWvYzQm9bMzJDlruFCbW/WVNhycVymdNzB
	WM3h3RD69t+OKjxUSCY3E7T/39oakLv4L4UBGckH0UAJ9nvU6YewjoM1zb8zhiE0ck/yBwE2N6H
	xadFdHIgQTorl84FRo4adujRkXEU2p8yLa+OuABPUadAEkQKODR+PB9bs=
X-Received: by 2002:a05:600c:8708:b0:485:3c8f:e4c5 with SMTP id 5b1f17b1804b1-4853c8fe526mr44746275e9.17.1773076736115;
        Mon, 09 Mar 2026 10:18:56 -0700 (PDT)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6402:5e5c:35f2:2762:2c6d:a7fe])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94e7b5208basm8541666241.9.2026.03.09.10.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:18:55 -0700 (PDT)
Date: Mon, 9 Mar 2026 14:18:51 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: Paulo Alcantara <pc@manguebit.org>
Cc: smfrench@gmail.com, David Howells <dhowells@redhat.com>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] smb: client: fix atomic open with O_DIRECT & O_SYNC
Message-ID: <nqw7sckluzinkdiqxcjx67tukzy5torrcniktahhqzyyjtzdkw@gjgrgc3xm37g>
References: <20260307212016.1328931-1-pc@manguebit.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307212016.1328931-1-pc@manguebit.org>
X-Rspamd-Queue-Id: 289BD23D985
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223710-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,talpey.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:email,talpey.com:email]
X-Rspamd-Action: no action

Acked-by: Henrique Carvalho <henrique.carvalho@suse.com>

On Sat, Mar 07, 2026 at 06:20:16PM -0300, Paulo Alcantara wrote:
> When user application requests O_DIRECT|O_SYNC along with O_CREAT on
> open(2), CREATE_NO_BUFFER and CREATE_WRITE_THROUGH bits were missed in
> CREATE request when performing an atomic open, thus leading to
> potentially data integrity issues.
> 
> Fix this by setting those missing bits in CREATE request when
> O_DIRECT|O_SYNC has been specified in cifs_do_create().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
> Reviewed-by: David Howells <dhowells@redhat.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  fs/smb/client/cifsglob.h | 10 ++++++++++
>  fs/smb/client/dir.c      |  1 +
>  fs/smb/client/file.c     | 18 +++---------------
>  3 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index 6f9b6c72962b..2f4470f9df58 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -2375,4 +2375,14 @@ static inline bool cifs_forced_shutdown(const struct cifs_sb_info *sbi)
>  	return cifs_sb_flags(sbi) & CIFS_MOUNT_SHUTDOWN;
>  }
>  
> +static inline int cifs_open_create_options(unsigned int oflags, int opts)
> +{
> +	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
> +	if (oflags & O_SYNC)
> +		opts |= CREATE_WRITE_THROUGH;
> +	if (oflags & O_DIRECT)
> +		opts |= CREATE_NO_BUFFER;
> +	return opts;
> +}
> +
>  #endif	/* _CIFS_GLOB_H */
> diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> index 953f1fee8cb8..4bc217e9a727 100644
> --- a/fs/smb/client/dir.c
> +++ b/fs/smb/client/dir.c
> @@ -308,6 +308,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
>  		goto out;
>  	}
>  
> +	create_options |= cifs_open_create_options(oflags, create_options);
>  	/*
>  	 * if we're not using unix extensions, see if we need to set
>  	 * ATTR_READONLY on the create call
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index cffcf82c1b69..13dda87f7711 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -584,15 +584,8 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
>   *********************************************************************/
>  
>  	disposition = cifs_get_disposition(f_flags);
> -
>  	/* BB pass O_SYNC flag through on file attributes .. BB */
> -
> -	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
> -	if (f_flags & O_SYNC)
> -		create_options |= CREATE_WRITE_THROUGH;
> -
> -	if (f_flags & O_DIRECT)
> -		create_options |= CREATE_NO_BUFFER;
> +	create_options |= cifs_open_create_options(f_flags, create_options);
>  
>  retry_open:
>  	oparms = (struct cifs_open_parms) {
> @@ -1314,13 +1307,8 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
>  		rdwr_for_fscache = 1;
>  
>  	desired_access = cifs_convert_flags(cfile->f_flags, rdwr_for_fscache);
> -
> -	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
> -	if (cfile->f_flags & O_SYNC)
> -		create_options |= CREATE_WRITE_THROUGH;
> -
> -	if (cfile->f_flags & O_DIRECT)
> -		create_options |= CREATE_NO_BUFFER;
> +	create_options |= cifs_open_create_options(cfile->f_flags,
> +						   create_options);
>  
>  	if (server->ops->get_lease_key)
>  		server->ops->get_lease_key(inode, &cfile->fid);
> -- 
> 2.53.0
> 
> 

