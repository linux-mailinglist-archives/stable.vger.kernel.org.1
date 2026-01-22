Return-Path: <stable+bounces-211243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ou8BJdHcmnpfAAAu9opvQ
	(envelope-from <stable+bounces-211243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:51:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2615369434
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 051587A5B4B
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6B534F257;
	Thu, 22 Jan 2026 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZ2GtT73"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF613280335
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092186; cv=none; b=M3j8jXa8beOTh586zpza8kv3jUrXlNCExEGmcGdS0/FgK2XsJ7ZAe4TdFKdR1KLLJ8SJTpPdNcXirlGnUa4KpN3IUi/vcKkP81XQqdQli7//3VWbyrIh6+KE8jmIDwz226mVazq4eM6dRKo+uTml02nL+LoujqxSNI4CLv8MAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092186; c=relaxed/simple;
	bh=cz+JlD34fRs/pROTZrvc12hKh4tyzrxS8BcTZwwO9EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQxiH6IsEnAvTdPR+P9+yV1cvORlYP4Vb4/OLeMxbwvL/4vyZitssFamfw7PH0e1dutQqRPaDli1EJbBNXgT0UehuOPTYlsSa9RWQvNXFXLWNxaedX3kdp/HJ1FskkBbuE9soFGHtaqf3+nDW/L/xpRvmhq+ghJ0J70npbAeFJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZ2GtT73; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso537615b3a.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 06:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769092183; x=1769696983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2bB6UcFN/QmZIeetEeQNfw5hOnI8IdcR9tXmdiu+0M=;
        b=cZ2GtT73IE/jaGvvMsPsZTLe50F1yM+v7+yIoUXsN499U0soDLin9rr9XOMv4QiU92
         2nh0ypIcb4Q9s1k7+cod5dMj4VFVE6d0jhV7dgA9D0mE5mEaoLis9txYihldq2nqAv/s
         kHSjntWak2qaVQXMb4DsV8YTXR76oJs0pylzNKYrzAEDzAm+XfKu6G3uTLN7DO9nQMY0
         zCpLqTRTKygMEOG1mZhEP2Xmd8jNNbWdh/JWtO2179mxnZ/KHcHaVhAUUBrNWGYIz/fQ
         oNylTf3b0pIGlPCUFK1OL+TBS4LLPenWFHwmf+oAdMCzNQhGa5FX86DM2eNq+bf9jXTO
         ooBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769092183; x=1769696983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2bB6UcFN/QmZIeetEeQNfw5hOnI8IdcR9tXmdiu+0M=;
        b=qH7MYHMFrPkzT0pB3guv2CA/6zJ/MLTafhGrYVsbDsPydD/cz8dVwTIyXSTdkzleXO
         upfNNDzYmZ3ocHxAuKT3cbolgZk4XEhK0xXYfVShYJ00O6ZkSWIxain+qZ6y/xMSgAVy
         Z7lClzPIOksQb+P0Fd3KstRPwhyzGZKYyF7piKuTFm6xWjpC/a9SNNtzik9dUW6F8Hff
         yMX/o4tmDKK6HcIyjcWn72Votw6f8WxNcI2JRQRKOIbSkw0ibwtOSTrRKjGztyO05lxT
         LVGbk3CH9wb4qtzNLAnABAECmRie6n5ahxsybLOhe3vAvwBrp8oZaFD2+rjLLqzocSNW
         2ciw==
X-Forwarded-Encrypted: i=1; AJvYcCWIkk9wqeVTO09FmDFYrA8SlLsksbnfT/D3s0ZpfqjhsUWuKryylzhWDdw8YnM0It1fsTUbqgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXQKgw9pl/s8sRm31bF9POGvYXMwo4LnSG8ULIacGNSYPDhUYt
	bjfAachn1qyrf1jDVk2rOzBBCPDuh9LBkYChdeJjN1OeI098M7A4ZbEs
X-Gm-Gg: AZuq6aLZWsaoQ8xDCRBc/BNesHM+eARJnci0wfQInTAJXM4JyZfVYVHhvlwCkd6OO2m
	ggFo5gaTnbGkJ0hiqauJzj57bDj5C9oP+vpxa22udXvvO+f8uSY6cpQpD3CS7ZiitkkkY5///2+
	4jfDe1ujt2Wrx/dxdzAoDItB0jIlDqMmtfqOMxWCDAZ+rC9U6BCYZig5Py104xxkZybxja0PJYg
	62ies+C6aZA3fiz8kT2q8ik/wByd8UlHNARcMPrEXGY3lRI+3SOPwc29KUObXTAl4xk+mWmReSY
	1p+em6t5m/slkdQTv+csWqK+YiYhpzd107xBMrICJucwrtEdrdAJ4ByBX4krUJMLfP/D2k4eqRU
	+i0f9BSX05z4kldC1lXiYh7GdW7biYMp3mpEuXEg2Bud2/1Tz6fwUtfzhiJKE8LytJumPgkGRFt
	E+AO+lNtWr+OY=
X-Received: by 2002:a05:6a21:3984:b0:38d:eeca:b330 with SMTP id adf61e73a8af0-38e00d1557amr21189377637.40.1769092183005;
        Thu, 22 Jan 2026 06:29:43 -0800 (PST)
Received: from inspiron ([111.125.231.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf354b3bsm11023239a12.24.2026.01.22.06.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 06:29:42 -0800 (PST)
Date: Thu, 22 Jan 2026 19:59:33 +0530
From: Prithvi <activprithvi@gmail.com>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@lst.de, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] scsi: target: Fix recursive locking in
 __configfs_open_file()
Message-ID: <20260122142933.662srnqeqmx7eqk3@inspiron>
References: <20260108191523.303114-1-activprithvi@gmail.com>
 <20260115032012.yb5ylmumcirrmsbr@inspiron>
 <20260122095634.GA15012@yadro.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122095634.GA15012@yadro.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211243-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lst.de,evilplan.org,lists.linux.dev,linuxfoundation.org,gmail.com,kernel.org,syzkaller.appspotmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[activprithvi@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f6e8174215573a84b797];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 2615369434
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 12:56:34PM +0300, Dmitry Bogdanov wrote:
> On Thu, Jan 15, 2026 at 08:50:12AM +0530, Prithvi wrote:
> > 
> > On Fri, Jan 09, 2026 at 12:45:23AM +0530, Prithvi Tambewagh wrote:
> > > In flush_write_buffer, &p->frag_sem is acquired and then the loaded store
> > > function is called, which, here, is target_core_item_dbroot_store().
> > > This function called filp_open(), following which these functions were
> > > called (in reverse order), according to the call trace:
> > >
> > > down_read
> > > __configfs_open_file
> > > do_dentry_open
> > > vfs_open
> > > do_open
> > > path_openat
> > > do_filp_open
> > > file_open_name
> > > filp_open
> > > target_core_item_dbroot_store
> > > flush_write_buffer
> > > configfs_write_iter
> > >
> > > Hence ultimately, __configfs_open_file() was called, indirectly by
> > > target_core_item_dbroot_store(), and it also attempted to acquire
> > > &p->frag_sem, which was already held by the same thread, acquired earlier
> > > in flush_write_buffer. This poses a possibility of recursive locking,
> > > which triggers the lockdep warning.
> > >
> > > Fix this by modifying target_core_item_dbroot_store() to use kern_path()
> > > instead of filp_open() to avoid opening the file using filesystem-specific
> > > function __configfs_open_file(), and further modifying it to make this
> > > fix compatible.
> > >
> > > Reported-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=f6e8174215573a84b797
> > > Tested-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> > > ---
> > >  drivers/target/target_core_configfs.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> > > index b19acd662726..f29052e6a87d 100644
> > > --- a/drivers/target/target_core_configfs.c
> > > +++ b/drivers/target/target_core_configfs.c
> > > @@ -108,8 +108,8 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
> > >                                       const char *page, size_t count)
> > >  {
> > >       ssize_t read_bytes;
> > > -     struct file *fp;
> > >       ssize_t r = -EINVAL;
> > > +     struct path path = {};
> > >
> > >       mutex_lock(&target_devices_lock);
> > >       if (target_devices) {
> > > @@ -131,17 +131,18 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
> > >               db_root_stage[read_bytes - 1] = '\0';
> > >
> > >       /* validate new db root before accepting it */
> > > -     fp = filp_open(db_root_stage, O_RDONLY, 0);
> > > -     if (IS_ERR(fp)) {
> > > +     r = kern_path(db_root_stage, LOOKUP_FOLLOW, &path);
> > > +     if (r) {
> > >               pr_err("db_root: cannot open: %s\n", db_root_stage);
> > >               goto unlock;
> > >       }
> > > -     if (!S_ISDIR(file_inode(fp)->i_mode)) {
> > > -             filp_close(fp, NULL);
> > > +     if (!d_is_dir(path.dentry)) {
> > > +             path_put(&path);
> > >               pr_err("db_root: not a directory: %s\n", db_root_stage);
> > > +             r = -ENOTDIR;
> > >               goto unlock;
> > >       }
> > > -     filp_close(fp, NULL);
> > > +     path_put(&path);
> > >
> > >       strscpy(db_root, db_root_stage);
> > >       pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);
> > >
> > > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > > --
> > > 2.34.1
> > >
> 
> You missed the very significant thing in the commit message - that this
> lockdep warning is due to try to write its own filename to dbroot file:
> 
> 	db_root: not a directory: /sys/kernel/config/target/dbroot
> 
> That is why the semaphore is the same - it is of the same file.
> 
> Without that explanation nobody understands wheter it is a false positive or not.
> 
> The fix itself looks good.
> 
> Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com> 

Hello Dmitry,

Thanks a lot for the feedback! I missed out this curcial explanation in the
commit message. I will update the commit message and send a v2 patch for 
the same.

Best Regards,
Prithvi

