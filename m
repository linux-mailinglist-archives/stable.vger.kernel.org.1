Return-Path: <stable+bounces-212776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNaSNxBme2l2EQIAu9opvQ
	(envelope-from <stable+bounces-212776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 14:52:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB5DB09D3
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 14:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E761C304EA84
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740CC341046;
	Thu, 29 Jan 2026 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGkdnfNY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02A325498
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769694595; cv=none; b=bAoMcSEssWZmRBUSqDyeoA9m6C/0oT3HWHDXJeD/GhKXT5j7FMPZrlS3TXaspCM08rtRvsi7wg2guTIHRwcIfD792JTzznLin/L9Dag7IJafHP0zZkl92SrfcpUDXGhBoJ+/r0wcZ1EwHs6/FQVVYojkcm7oEzH1NONJBT6pYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769694595; c=relaxed/simple;
	bh=2xZSRJHHmdboCugVEUKL+Afar9NGlC9UFADcCPB8rOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4scbTy17H23kxPRMYrDgJgQqq6vT9F6q6pQ4QUPy8ugfMSOsij47gDVP1xNC8YSE3EIq/KKId7jBm3ROkaqxkX3ICHxrRNvjsv7qHLXDISSyBQ1czAtaJhksnUlgUS/kdM9vWBh9Yqpg9bPY+jAZDeKUiddEqD8PKuUMJXFYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGkdnfNY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8217f2ad01eso831930b3a.2
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 05:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769694591; x=1770299391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa6Pc/7YQxTkk1AR/CK47HEuWzh3zruMmwF2wm/H0lA=;
        b=RGkdnfNYKv+wa33NKm86JeRBY1qbJ/rLJ3/METsgCdIjQ3B8/Jw6QyhrbtShvxmdhv
         Z3ChhnaKuxr04lnp8oXGiDVt//f5LfnBHFqoCo/XZlr+zcv4E5lRzWOk3hDIavmW/m7R
         aWsbg2VIpDqqsmod3lXML6zd6RNjyIw0IGc64CZxDWYUcE3snh6FYcfiPzzPXYxWOR97
         JqglYWLaiyOpZC7Oujc9QpCxnhF5hrKKdYwmNqKyZOq02uD2g/DABG1yXhHI2fft1Nb2
         dygRdO7YeDRrVRVjpKvuznL8ZjKRxu6DwYgHwqyYi2ugf2HJokcW+CjTK1SH6FVoDmO2
         xRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769694591; x=1770299391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qa6Pc/7YQxTkk1AR/CK47HEuWzh3zruMmwF2wm/H0lA=;
        b=bCsRmx9nzBOsqXezfUmXr/WUoU+BdNGtsw8TOxNiezpe0Z8Ek1K6n3JRatfY63Nobj
         cKSTeXImJmxUVOwxXcwi9Psilg7F6RlVfyspr5Sq/jvticvrXIUfIX8Se9arOelKBy9N
         LJj+6C8JAhL4HzL7g58x5GFujmnl8NbIo3Esadm7svnSObwPX/Fg9VMqAiFNj4kQkisn
         mXtDWJCRhGqvR92WNJpF/MzxmOQJsNopkJ7oBhMKNw46Q0dNfd+AJ1YSjtqCxxUVXlNz
         8tkeiD30RoJUoJyRrK3Mz7b4CATlCTRo05mxE2ISsn0ATofjELce2XX6GjgI8GbrrsXd
         M/TA==
X-Forwarded-Encrypted: i=1; AJvYcCVqgSgZ1r1h3w98fzI6rP26NOl9EX145UrKjW2SW/0z9apujq6PMMbXBD6kgjBgkNJHMwXNID8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjxGQtR9vPMq2XrKQCEM11bJ+tmGcJPucKTHsU09tQgXUBkuDF
	E+YU+bcbNhPOTtP72yTukdpDNK0SYHTqwBeMm2ZJsS8eVau0C3HEc8Dw
X-Gm-Gg: AZuq6aKYNwaxnAUk0STAtzyj1JKIr5LX+cehtt2Yoqk4hrvby63QjDnz89VRjD1a/sW
	Qo/uoav0wdd+5R1C+UEJ0rbM+Kal1KJibioBLD71bl6eKLS2VmWDk0TsTiCS0C+9gqFeRt9CZ7S
	nf0WHsHxGhwuKOZgB83LIM/SAj/Zaa5tnL2thWfDn+aVMunqH07JKgO33yaBvJdPOAxDs2saebY
	2FAKxn4VyhEBUCsvTegjXKPvWKNg9hE/OEpyG9WE/KYIGd96PE7CR7d8mGh13ybrLTxbGoVhz56
	gm0dCLYvhB8p+EI8dxrBemDpfRI11PnGO8LoQYG4k272/4hH6UMECzwrYDKXlOvXqyEko1Q936u
	cnOKGccjn3fh8ZjEh6O2KUkKiQHXstj1A7uU0nf/cLT1219LgXH1AQ/BL6wkMdIl2fErYyY6Bkj
	ILg4jQmQEbeW0=
X-Received: by 2002:a05:6a21:6009:b0:350:3436:68de with SMTP id adf61e73a8af0-38ec6583a23mr8026625637.53.1769694590569;
        Thu, 29 Jan 2026 05:49:50 -0800 (PST)
Received: from inspiron ([111.125.210.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eef44sm53768715ad.11.2026.01.29.05.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 05:49:50 -0800 (PST)
Date: Thu, 29 Jan 2026 19:19:42 +0530
From: Prithvi <activprithvi@gmail.com>
To: martin.petersen@oracle.com, d.bogdanov@yadro.com, bvanassche@acm.org
Cc: linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] scsi: target: fix recursive locking in
 __configfs_open_file()
Message-ID: <20260129134942.nooyuvarh6vr32eu@inspiron>
References: <20260122154051.64132-1-activprithvi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122154051.64132-1-activprithvi@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212776-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linuxfoundation.org,gmail.com,kernel.org,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[activprithvi@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,f6e8174215573a84b797];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 8AB5DB09D3
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:10:51PM +0530, Prithvi Tambewagh wrote:
> In flush_write_buffer, &p->frag_sem is acquired and then the loaded store
> function is called, which, here, is target_core_item_dbroot_store().
> This function called filp_open(), following which these functions were
> called (in reverse order), according to the call trace:
> 
> down_read
> __configfs_open_file
> do_dentry_open
> vfs_open
> do_open
> path_openat
> do_filp_open
> file_open_name
> filp_open
> target_core_item_dbroot_store
> flush_write_buffer
> configfs_write_iter
> 
> target_core_item_dbroot_store() tries to validate the new file path by
> trying to open the file path provided to it; however, in this case,
> the bug report shows:
> 
> db_root: not a directory: /sys/kernel/config/target/dbroot
> 
> indicating that the same configfs file was tried to be opened, on which
> it is currently working on. Thus, it is trying to acquire frag_sem
> semaphore of the same file of which it already holds the semaphore obtained
> in flush_write_buffer(), leading to acquiring the semaphore in a nested
> manner and a possibility of recursive locking.
> 
> Fix this by modifying target_core_item_dbroot_store() to use kern_path()
> instead of filp_open() to avoid opening the file using filesystem-specific
> function __configfs_open_file(), and further modifying it to make this
> fix compatible.
> 
> Reported-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f6e8174215573a84b797
> Tested-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> ---
> Changes since v1:
>  - Update commit message to reflect the fact that same file, which code was 
>    currently operating on, was tried to be opened again, leading to 
>    acquiring the same semaphore in nested manner & possibility of recursive
>    locking.
> 
> v1 link: https://lore.kernel.org/all/20260108191523.303114-1-activprithvi@gmail.com/T/ 
> 
>  drivers/target/target_core_configfs.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> index b19acd662726..f29052e6a87d 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -108,8 +108,8 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
>  					const char *page, size_t count)
>  {
>  	ssize_t read_bytes;
> -	struct file *fp;
>  	ssize_t r = -EINVAL;
> +	struct path path = {};
>  
>  	mutex_lock(&target_devices_lock);
>  	if (target_devices) {
> @@ -131,17 +131,18 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
>  		db_root_stage[read_bytes - 1] = '\0';
>  
>  	/* validate new db root before accepting it */
> -	fp = filp_open(db_root_stage, O_RDONLY, 0);
> -	if (IS_ERR(fp)) {
> +	r = kern_path(db_root_stage, LOOKUP_FOLLOW, &path);
> +	if (r) {
>  		pr_err("db_root: cannot open: %s\n", db_root_stage);
>  		goto unlock;
>  	}
> -	if (!S_ISDIR(file_inode(fp)->i_mode)) {
> -		filp_close(fp, NULL);
> +	if (!d_is_dir(path.dentry)) {
> +		path_put(&path);
>  		pr_err("db_root: not a directory: %s\n", db_root_stage);
> +		r = -ENOTDIR;
>  		goto unlock;
>  	}
> -	filp_close(fp, NULL);
> +	path_put(&path);
>  
>  	strscpy(db_root, db_root_stage);
>  	pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);
> 
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> -- 
> 2.34.1
> 

Hello all,

Just a gentle ping on this thread

Thanks,
Prithvi

