Return-Path: <stable+bounces-253584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PbJKjYlD2paGgYAu9opvQ
	(envelope-from <stable+bounces-253584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:31:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1254F5A8616
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C38D3168802
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5FC3446C7;
	Thu, 21 May 2026 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgIn6fhM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707DA3431E3
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374739; cv=none; b=jTI2ctpdqI97u5vIVWl/hAcngIYg9XWu4lpI2DFa3Fm1qDhMLo8L+BqmcL/bUD2NZJ/npAqAUN+NUPbYILMAMBUkUx3nbZKHv58BV7WWn/w3XbJTS2LRPZlwkBkQOianl/vhzfSAQohBNNLJ9zEtKIs4hxg97yEDweVNAQ6o6+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374739; c=relaxed/simple;
	bh=1FDax2ITlPGkK9GWM4Kk5hh5Iu9Jo/XTctQgyZ3HFd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aExYs5xkLutCzTSDN9BB5zpZd76iRyRGNSwawflXw90NBvwYSosmydiAUtFsSc43cpS0Z9y+Mp9hsMfoeefqPO0F1Tis2en3PFhzrfuco5IQIEvCNpzx4DDL3CV8E9lyTmVfVZJdFUeHiadH2V1xr3BWm93qrrxWh0BPFcOWCPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgIn6fhM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso47090415e9.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779374737; x=1779979537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIWgYSgSur7+TFprKVyhVWjT/8EMs0z3uzklm4FTqYA=;
        b=OgIn6fhMMtxL5dR/Ife+0IdHFexxa8j1dKQ/YRPGSkVGvAKgnqMu95v6kAam1OYWlW
         w8Cu3Pxl7nxqKpW5hgElRKsu8iiKyIGd8NlI3q4dErLwn1FzDi/mNUGYyHZyEIp3+FmO
         aNt+81ELjVONAB72TZ9tpgY5yDngxcSsvXUk+iFPh5yOjSJPk7WOZ0KaJ+0hxe+OwDXT
         6/afSbsBvIGAbhi4xYmU1u073v+zSKjW8vYY6d8BjyIFWcjylzltizNw0qVqyEmix1Qm
         tX6OvGb8he4fSj2KmtqpmCP6meGKX5uXedNdTyqMAH5ikbXJkQcNVMVG57/IIx5wUHul
         R8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374737; x=1779979537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIWgYSgSur7+TFprKVyhVWjT/8EMs0z3uzklm4FTqYA=;
        b=Vk0lxBj5zltxt/SIokYNEhSWhuWUEEUFK/qvOqj5OOfPfSM4t2hi0E5lQS9oLCE7hl
         ny1XNFI86V4gy7hksyksnXp+gojcHInLlnKZXlt06moz5Mg75IeMBqx2V1Zj/AjPAcGe
         S47Gx/kD8q4MZ3gIqQk+4ccTVjGQKFTajVeE7XjQqLocP6kEMSzFf9M/S135IcE2nxxs
         xcrpkzXjk2PrlQlPtOcyJH51GvYLsVthiJdvP1SXV1uCGYjNITyCrBWR+zLHyR2JiIhI
         0Eq72VQNahCmlYN93w2gV10CqZYc0L4TlGaLey0HtiaB9dXaDiqwnA8UaSHoUOzotLN7
         WWoA==
X-Forwarded-Encrypted: i=1; AFNElJ/rFl50sdo8GtOK0XOnAfgANijNsyOfZ7BHh3AaYvpibCC4evtoRl0yqwnRbQ8VF+JDv018vsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3s238mdsW/MdgOXi/VLs/d1SMTAvikxfO3wmj3AqZnby5yTR
	HFyD1HfLPzK5p4qdEnTZJvvNGRUEguvwVJT1CtIIsApR784B6goGHdw7
X-Gm-Gg: Acq92OEGnVGerBepEiu82yPqA5RCFYCB9VHUTm7OSavbyBxrAcDN8K/tok5VkzTkpOC
	lAtSapBIDoB5xGtQ+a779a33PneQ1mbod6kUc5DR8bcy1MTBAcmiC5rslsXnbDbGuKIuX+V41GZ
	Pa0iY3NQepT3e/H/cDUEr0inlOtD8FQhtlrs7NWtS4IO5dtOAn+dYLSlMxIP8iwNPrhAxkK5+HO
	SPkoqTR9LRL0cmVyqE2fmDLgWg6mbRVVndBgQHoVm3bL7r64jUi8x9iCok/bO8a7R54r9E7k1Ry
	Hv0wmyWLREDO4EjSy2SSkrWDhAkAi1zpTG3tg8WfBPYJZLAEwPGn+34sAz384drKdJ3MiHknTuC
	2WYuZjh6uQ43FqJGlZPXD2Yth106c+W7DlWf1s1lC8qVKe1D/pPOkuidFBwdw/PHazMKJ5W/4Nh
	OWHQ7WK3D9Ikfk76zwXZdEEqMrSwSWfvu/s8GeoiT9kuiEgYSkuOfza/GHTP5dpEuc56zR/gQ=
X-Received: by 2002:a05:600c:37c4:b0:489:1f08:91b with SMTP id 5b1f17b1804b1-490360a87a0mr49352355e9.16.1779374736601;
        Thu, 21 May 2026 07:45:36 -0700 (PDT)
Received: from f (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903cadc125sm24701585e9.10.2026.05.21.07.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:45:36 -0700 (PDT)
Date: Thu, 21 May 2026 16:45:28 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	thomas.weissschuh@linutronix.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Subject: Re: [PATCH] fs: Fix lock leak in replace_fd()
Message-ID: <m3xus4s4xup32v7ijjolq6p3tlrj3bpwettldpqwxcwxanfvyt@5ihbtgch7liv>
References: <20260521074934.49256-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521074934.49256-1-zenghongling@kylinos.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253584-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,linutronix.de,vger.kernel.org,126.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1254F5A8616
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:49:34PM +0800, Hongling Zeng wrote:
> In replace_fd(), the function acquires files->file_lock but then has
> two return paths that don't release the lock:
> - When do_dup2() fails (returns negative error)
> - When do_dup2() succeeds (returns 0)
> 
> Both of these paths return directly without unlocking files->file_lock,
> causing a lock leak and potential deadlock.
> 
> Fix this by making both error and success paths go through the
> out_unlock label to ensure the lock is always released.

do_dup2 always releases the lock regardless of return value, so this
patch cannot be correct.

that aside, there is another consumer which would also need patching if
the issue was real

> 
> Fixes: 708c04a5c2b7 ("fs: always return zero on success from replace_fd()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  fs/file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 2c81c0b162d0..d0f019fb0568 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1361,8 +1361,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
>  		goto out_unlock;
>  	err = do_dup2(files, file, fd, flags);
>  	if (err < 0)
> -		return err;
> -	return 0;
> +		goto out_unlock;
>  
>  out_unlock:
>  	spin_unlock(&files->file_lock);
> -- 
> 2.25.1
> 

