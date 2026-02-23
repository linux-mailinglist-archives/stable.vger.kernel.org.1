Return-Path: <stable+bounces-217690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPczKwvOm2kH7gMAu9opvQ
	(envelope-from <stable+bounces-217690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 04:48:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42273171ABD
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 04:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E56BC3013D60
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 03:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72C531A571;
	Mon, 23 Feb 2026 03:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn+WqJAI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B853C275AFB
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818496; cv=none; b=hOJiu7IRoWm20k4Bt/IM8tPxH2edJlCEZjmHgL5dHnEUHbOQnD30jyPSDukIgQkHe6EasowTfCn2Wch8+Ecs7xHoZnmzb3T03Gf9gWBjsgPcwrM9/LtJPxptct9LXQ8Wvu3vDaxmFmt2u4vNuOaiR+XJNmzcX3rlqnQd0WpXp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818496; c=relaxed/simple;
	bh=SF93mBnv6b6pLe/1HBoftNRah+ZLiF1OcBwwqbvPe6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ft51bIm+XC/aLNS6AUp+bndGKpxl1k4l7Gxo3+58fIbVA7h9e7O9KDBlXOLcAholOoXdTXf57vERkXJr8aIV6II93F8APF4o9oyjac3hZldsUGYfUjILLQbPCT9C39fTyaWuY3M4fNzGXwWokzEU0KgU8X/izRM9Vwz/fWTzjgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kn+WqJAI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab232cc803so18447015ad.3
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 19:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818494; x=1772423294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4rzQ0T621GZSjBat75RSIcrNnampDyhuho7rtv7pj0=;
        b=kn+WqJAIJ/4YHgC84EqeJVuE0n4c+IV1m44Cj81aoaJ0joDEls+GVbdMq6YNMXCLWY
         ALy6uiwRdoGfNuImrkaPD1T9XhkN5x/5XyJGQHrwiigHgKHkveltqmgeOMPDbChCdN3O
         f9kqH9az3Z/5mBBfDeOq0ARYAqcVBGfY05GRGe8qWxXkI0Wwu9pKh8i6is9+Yp9c64Eg
         w7pEnjyiUBmsyVdGR7sRb41Ohqb/ypkDF5rleXmrcFluW4yYHewuYGsEn/7dC3XLpcSF
         ZgzlHW1JRLHIUekk2DT0AMN/A3nBYosdPEwvh+xFcEjII2ziyKIZLFIo1VFyMAFUc4mT
         sNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818494; x=1772423294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4rzQ0T621GZSjBat75RSIcrNnampDyhuho7rtv7pj0=;
        b=ciywSnib30++1ITCi/RMBrpb/V6xnoUAE4f2mpTuNc4Xtq6XG8rXYZkd25Ak4ZhRaC
         vud5ydMZg9GRbv+maTT42Q+YXXYfOnIiU5KMkq/j0iTno1HNGNo3T9PdyR1+ABk5tkta
         U0OyIsHkL5ETVguX4t/zAeCa0Eii4zT8kR1YQ77wDHKGgrQIOyyaSOCN3fxKbcmoht6Y
         6lg+9L8PWr85aweBXIX6xY14rpi5WDoqutgniw42DVtXswdlq+HRTTNahLgySteE9aDU
         ywZQt/JW78Qz+Av78gHMWaFzyw5FCwolNeV2AiE9v0s+hb0xTomrP2DvalkcsiiGPtxH
         Ft4A==
X-Forwarded-Encrypted: i=1; AJvYcCUTE5wd5WUTMjAiLeDfBqMkFPpNbzGIPz8eki93pajRbn//RPk/0hEflvuhdBpCwQOY+jDOVpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+YoKgxvzDgqDWHJCYYTK3wzULXHVQ8oK1d9maUoJl/h/SkDsj
	dVwMowV2LiR08QULpomhpu1CLAVmhgFY/+pW8F7AYltjRo8K6NmZvoJ6
X-Gm-Gg: ATEYQzw1Fei4o/bQZsSW01CFFZsffrFI1ufPrjq5o9/3nd3eZdFauCaQsolG4P54Mga
	vHDO0M/pITzZ36YhPjMTsxh9878oap6HLS9UX248UP26NnxXXszFQRKufTFlBK0Q5k0NN0f08LM
	dXKeAkZj6HDTWVwMtz5RMuWrPN6ys+EGkjEoAEq8n2TUcBA0agtj5UUvt0x4JmfEGT54Q2K5Q8P
	BnkZ0zE+P3DEYgDSB9fECxGqTCS0EEfrSH1gLZaI/UbbeGwcaI0HYhZZnENb35QsSRVlg0QhFGH
	p2KWNalIFa5V5m16VAaeBWanPZeP1kqpQE0nXXV3xqi6fjpmioJhRuqhGo4VfhffgQx2x0Bshp8
	mGJMONkXJb75WCVMU6vWLZ0Q984VxXGRG1zmPdiN/aoPWyjkmm3pJvF3AFobKbJeBkILPQPkzp9
	qa473UM83Hz0xFCW32q6hYiSg=
X-Received: by 2002:a17:902:ecc6:b0:2aa:d7fe:8603 with SMTP id d9443c01a7336-2ad74419e3emr70224515ad.8.1771818493881;
        Sun, 22 Feb 2026 19:48:13 -0800 (PST)
Received: from inspiron ([111.125.235.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75027641sm67314185ad.64.2026.02.22.19.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:48:13 -0800 (PST)
Date: Mon, 23 Feb 2026 09:18:05 +0530
From: Prithvi <activprithvi@gmail.com>
To: martin.petersen@oracle.com, d.bogdanov@yadro.com, bvanassche@acm.org,
	viro@zeniv.linux.org.uk
Cc: linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] scsi: target: fix recursive locking in
 __configfs_open_file()
Message-ID: <20260223034805.yhzmheiwndxtj5zu@inspiron>
References: <20260216062002.61937-1-activprithvi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216062002.61937-1-activprithvi@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e854293d7f44b5a5];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linuxfoundation.org,gmail.com,kernel.org,syzkaller.appspotmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217690-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[activprithvi@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f6e8174215573a84b797];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yadro.com:email,appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42273171ABD
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 11:50:02AM +0530, Prithvi Tambewagh wrote:
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
> Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> ---
> Changes since v3:
>  - Add LOOKUP_DIRECTORY flag in call to kern_path() so as to check presence 
>    of directory checks more efficiently
> 
> v3 link: https://lore.kernel.org/all/20260205162624.117957-1-activprithvi@gmail.com/T/#m175d152067817dd6e9dc1821b6fbf626e47a4007
> 
> 
> Note:
> I checked out and found that when I try to test on commit 3a8660878839faadb4f1a6dd72c3179c1df56787
> (latest commit on which bug dashboard reports the bug on, in upstream repository) 
> syzbot uses, in its kernel config:
> 
> CONFIG_CC_VERSION_TEXT="gcc (Debian 12.2.0-14+deb12u1) 12.2.0"
> 
> Ref: https://syzkaller.appspot.com/x/.config?x=e854293d7f44b5a5
> Syzbot Reply: https://lore.kernel.org/all/6767d8ea.050a0220.226966.0021.GAE@google.com/T/#m62bc76de5549460ae98e843bb120712548489794
> 
> While when #syz test (i.e. on HEAD commit of upstream) is used, it uses, in
> its kernel config:
> 
> CONFIG_CC_VERSION_TEXT="gcc (Debian 14.2.0-19) 14.2.0"
> 
> Ref: https://syzkaller.appspot.com/x/.config?x=99ac58566e9eb044
> Syzbot reply: https://lore.kernel.org/all/6767d8ea.050a0220.226966.0021.GAE@google.com/T/#me8b79610e4c18a8d8a7d8d6bc249d1c7cf2f8819
> 
> However in both cases it uses:
> 
> gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> Probably due to mismatch in compiler version which syzbot actually uses and 
> whats present in kernel config, the build fails for the first case. However, 
> the patch succeeds in fixing the bug in second case.
> 
> Earlier for v1 patch (sine v2 patch involved minor change to commit message 
> and v3 involved adding a missed out Reviewed-by tag) patch the kernel builds 
> as well as testing succeeded since syzbot used this in its kernel config:
> 
> CONFIG_CC_VERSION_TEXT="gcc (Debian 12.2.0-14+deb12u1) 12.2.0"
> 
> as well as used the compiler:
> 
> gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40 
> 
> Changes since v2:
>  - Add Reviewed-by tag received from Dmitry Bogdanov, which was accidentally
>    left to be added in v2 patch.
> 
> v2 link: https://lore.kernel.org/linux-scsi/20260122154051.64132-1-activprithvi@gmail.com/T/#u
> Reference for Reviewed-by Tag: https://lore.kernel.org/all/20260108191523.303114-1-activprithvi@gmail.com/T/#mb22d0fc06e747e2b2df8320a15afd2a0670fd0e7
> 
> 
> Changes since v1:
>  - Update commit message to reflect the fact that same file, which code was 
>    currently operating on, was tried to be opened again, leading to 
>    acquiring the same semaphore in nested manner & possibility of recursive
>    locking.
> 
> v1 link: https://lore.kernel.org/all/20260108191523.303114-1-activprithvi@gmail.com/T/
> 
>  drivers/target/target_core_configfs.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> index b19acd662726..f94c242eff97 100644
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
> @@ -131,17 +131,14 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
>  		db_root_stage[read_bytes - 1] = '\0';
>  
>  	/* validate new db root before accepting it */
> -	fp = filp_open(db_root_stage, O_RDONLY, 0);
> -	if (IS_ERR(fp)) {
> +	r = kern_path(db_root_stage, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
> +	if (r) {
>  		pr_err("db_root: cannot open: %s\n", db_root_stage);
> +		if (r == -ENOTDIR)
> +			pr_err("db_root: not a directory: %s\n", db_root_stage);
>  		goto unlock;
>  	}
> -	if (!S_ISDIR(file_inode(fp)->i_mode)) {
> -		filp_close(fp, NULL);
> -		pr_err("db_root: not a directory: %s\n", db_root_stage);
> -		goto unlock;
> -	}
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

Hello everyone,

Just a gentle ping on this v4 patch; it incorporates Al Viro's suggestion 
from v3 to use LOOKUP_DIRECTORY flag in kern_path(). Kindly let me know if 
anything else is needed from my side or any feedback is to be addressed.

Thanks,
Prithvi

