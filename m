Return-Path: <stable+bounces-125967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B2A6E30B
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 20:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BD57A733A
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F27264A99;
	Mon, 24 Mar 2025 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxeKfIbU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9426462B
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843106; cv=none; b=WMCqDjPSvXFIseMD5u04C+E8U4Zm2JYRU4VPAx83EpkoxaK/59tSxEU1JxHqse6gmAilUkKM68RvtTpKQ3/onKCBkGRDzhPr7o9yNBlEZ15jOkopY3a3GJrJwHPEkwvqpC/Xeb7OIE287UI9tDDjlibc1ZwOdd/T+NEm4HYtqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843106; c=relaxed/simple;
	bh=Q7l0bPxhib36OdUmoQBMWy8qlueln10RqMQcD5wIO3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlX2iur2BA6I2nkcxkfogwssycp/B6rK4KdwZOQsTlJ3q9QzAN8JcIulcQeRixSw8/EBDRR8nnTTqdW26C30mSwS6yIqOqqyWuBpwP612Kz3HRaL7iPdIiTGj4lik1WjdfQ+BwHqJUToR2aO7n0LNZgUDh6UofooCHYKnthem+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxeKfIbU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso2738474a12.0
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742843103; x=1743447903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1D4NkEr8gujRTnPZj34eouJ74fd4DLJ++1KSExb1fNU=;
        b=FxeKfIbUPoAvt+HZi7dDi+KLbJXKSr9hSBAiof5mEGApkwoL3t/HpQ0+6MKBDPiV+U
         l4dyTdrksPrE8YIh1VfNYtLnem0qGbHY4sk4Wgo/mpbfuPo0xNqHtIQjbWTk19bIPTQy
         9jDC2FHy29zbyxNBuaD6TY+TBpmj9556TPfLJ22F/hiC6RstXHqG1ZCgdHjlAMeBN2BF
         bDaBBY2FwDedvx1EN65cfeGn1flNkutKZRcbbXd2lw4d4JfN9cuXUc4Io3D7Sx8Ka4nR
         Mfl67/m92MK9T6NcMDAYax+QEedSJI0t99Je51byfb8iczqT7ce1K13OsXrkdABGqOWO
         cS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742843103; x=1743447903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D4NkEr8gujRTnPZj34eouJ74fd4DLJ++1KSExb1fNU=;
        b=AKEjlkA7Qeo4DvcegNBCBZwnhlCaPx9hqYHE56DPmsvBWka25TUZLHavq6rj4G/UZe
         Ikqu61nGjuIbEG43lKaZJPcaNfBhwgSuy1pTd6QHdBwog4CXWaX2oXZHURzhH86ueqz+
         cZlMrp9TSqJ3jU8+3K+WfbihAY8u1RqoVk7fTLx3M2c37U4qwmEIRr+5RPb4TU8YVyi0
         +3ET6CsdLgla0u+lSKpgJWMQ2rIZkUW2oGc5/Fbut3CbSGfdrsk97mtAn6vdD57yDt+b
         E/IjQrVr9X+SZRle7JhXyJ17YLkgFTb9AGjAaOlobweeQfFoUYPuKgDHd28Itl2i5DPt
         H5HA==
X-Forwarded-Encrypted: i=1; AJvYcCUVygGZ2kjNI8NKIQ1ZSDyxjiMqDQ36I2cxXrxdOZdwYyNK77lOjNN9+hlQnn4AMDCAcXoZgMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdViGlMvzQtxIkaukhizaym/Y/jYQpBxpNGD0WmY123OpIMaq3
	qdnU2rsBICZK1uQj8NpFIDVuUukbICoDFenb2TERgh2UoyRbaU4=
X-Gm-Gg: ASbGncsdBwPYZmKsLXGZxik5jJ90+DZrDg1yGy+nMpoQPC/0+V+o/dwRhJVC3q6opur
	jh8+1h2oLZN3karRT0T+DpbrNxYyFoXWD/XqVxln0uHu8W2yDErLTAg2PZEany/DHZ4di1IPMUr
	Y11CTjuwWJ3nwfXg4CFOLDI96+27of6BEp3ty3MMpfTaFtjUxPMuTSFTPg9+q+gPVCzpHwwMWtI
	BOG6BUT0pl/md9dQFtGG/uDWD0OxL2IqwpgsY3JqyXLc3gnVVm6IPJNF3zgS6oPHo3qE14fP3m0
	9+YMoPL7y4OhGxNrSjY7xJjMepI6ubo5/SYUGMrNzi0h
X-Google-Smtp-Source: AGHT+IEAjwrqLFoiH/0ZHVnp3sZtImdFm68nF2q/PLvbHbDW9xNJVCBl1ROjEeMNco+/iZr0FnW+jw==
X-Received: by 2002:a17:907:6eaa:b0:ac3:c6e:ffcf with SMTP id a640c23a62f3a-ac3cdb2c47fmr1538333666b.3.1742843102385;
        Mon, 24 Mar 2025 12:05:02 -0700 (PDT)
Received: from p183 ([178.172.147.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e5152sm719172166b.47.2025.03.24.12.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 12:05:01 -0700 (PDT)
Date: Mon, 24 Mar 2025 22:04:59 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: gregkh@linuxfoundation.org
Cc: yebin10@huawei.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] proc: fix UAF in proc_get_inode()" failed
 to apply to 5.4-stable tree
Message-ID: <c6523853-eef1-4dfd-ba1f-84dee4c51775@p183>
References: <2025032409-unnamable-entertain-9026@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025032409-unnamable-entertain-9026@gregkh>

5.4 should do use_pde/unuse_pde in proc_get_inode() like the original patch did:

https://lore.kernel.org/linux-fsdevel/20250301034024.277290-1-yebin@huaweicloud.com/

On Mon, Mar 24, 2025 at 08:33:09AM -0700, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x 654b33ada4ab5e926cd9c570196fefa7bec7c1df
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032409-unnamable-entertain-9026@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 654b33ada4ab5e926cd9c570196fefa7bec7c1df Mon Sep 17 00:00:00 2001
> From: Ye Bin <yebin10@huawei.com>
> Date: Sat, 1 Mar 2025 15:06:24 +0300
> Subject: [PATCH] proc: fix UAF in proc_get_inode()
> 
> Fix race between rmmod and /proc/XXX's inode instantiation.
> 
> The bug is that pde->proc_ops don't belong to /proc, it belongs to a
> module, therefore dereferencing it after /proc entry has been registered
> is a bug unless use_pde/unuse_pde() pair has been used.
> 
> use_pde/unuse_pde can be avoided (2 atomic ops!) because pde->proc_ops
> never changes so information necessary for inode instantiation can be
> saved _before_ proc_register() in PDE itself and used later, avoiding
> pde->proc_ops->...  dereference.
> 
>       rmmod                         lookup
> sys_delete_module
>                          proc_lookup_de
> 			   pde_get(de);
> 			   proc_get_inode(dir->i_sb, de);
>   mod->exit()
>     proc_remove
>       remove_proc_subtree
>        proc_entry_rundown(de);
>   free_module(mod);
> 
>                                if (S_ISREG(inode->i_mode))
> 	                         if (de->proc_ops->proc_read_iter)
>                            --> As module is already freed, will trigger UAF
> 
> BUG: unable to handle page fault for address: fffffbfff80a702b
> PGD 817fc4067 P4D 817fc4067 PUD 817fc0067 PMD 102ef4067 PTE 0
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 26 UID: 0 PID: 2667 Comm: ls Tainted: G
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> RIP: 0010:proc_get_inode+0x302/0x6e0
> RSP: 0018:ffff88811c837998 EFLAGS: 00010a06
> RAX: dffffc0000000000 RBX: ffffffffc0538140 RCX: 0000000000000007
> RDX: 1ffffffff80a702b RSI: 0000000000000001 RDI: ffffffffc0538158
> RBP: ffff8881299a6000 R08: 0000000067bbe1e5 R09: 1ffff11023906f20
> R10: ffffffffb560ca07 R11: ffffffffb2b43a58 R12: ffff888105bb78f0
> R13: ffff888100518048 R14: ffff8881299a6004 R15: 0000000000000001
> FS:  00007f95b9686840(0000) GS:ffff8883af100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffbfff80a702b CR3: 0000000117dd2000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  proc_lookup_de+0x11f/0x2e0
>  __lookup_slow+0x188/0x350
>  walk_component+0x2ab/0x4f0
>  path_lookupat+0x120/0x660
>  filename_lookup+0x1ce/0x560
>  vfs_statx+0xac/0x150
>  __do_sys_newstat+0x96/0x110
>  do_syscall_64+0x5f/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [adobriyan@gmail.com: don't do 2 atomic ops on the common path]
> Link: https://lkml.kernel.org/r/3d25ded0-1739-447e-812b-e34da7990dcf@p183
> Fixes: 778f3dd5a13c ("Fix procfs compat_ioctl regression")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 8ec90826a49e..a3e22803cddf 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -559,10 +559,16 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
>  	return p;
>  }
>  
> -static inline void pde_set_flags(struct proc_dir_entry *pde)
> +static void pde_set_flags(struct proc_dir_entry *pde)
>  {
>  	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
>  		pde->flags |= PROC_ENTRY_PERMANENT;
> +	if (pde->proc_ops->proc_read_iter)
> +		pde->flags |= PROC_ENTRY_proc_read_iter;
> +#ifdef CONFIG_COMPAT
> +	if (pde->proc_ops->proc_compat_ioctl)
> +		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
> +#endif
>  }
>  
>  struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
> @@ -626,6 +632,7 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
>  	p->proc_ops = &proc_seq_ops;
>  	p->seq_ops = ops;
>  	p->state_size = state_size;
> +	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL(proc_create_seq_private);
> @@ -656,6 +663,7 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
>  		return NULL;
>  	p->proc_ops = &proc_single_ops;
>  	p->single_show = show;
> +	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL(proc_create_single_data);
> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index 626ad7bd94f2..a3eb3b740f76 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -656,13 +656,13 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
>  
>  	if (S_ISREG(inode->i_mode)) {
>  		inode->i_op = de->proc_iops;
> -		if (de->proc_ops->proc_read_iter)
> +		if (pde_has_proc_read_iter(de))
>  			inode->i_fop = &proc_iter_file_ops;
>  		else
>  			inode->i_fop = &proc_reg_file_ops;
>  #ifdef CONFIG_COMPAT
> -		if (de->proc_ops->proc_compat_ioctl) {
> -			if (de->proc_ops->proc_read_iter)
> +		if (pde_has_proc_compat_ioctl(de)) {
> +			if (pde_has_proc_read_iter(de))
>  				inode->i_fop = &proc_iter_file_ops_compat;
>  			else
>  				inode->i_fop = &proc_reg_file_ops_compat;
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 1695509370b8..77a517f91821 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -85,6 +85,20 @@ static inline void pde_make_permanent(struct proc_dir_entry *pde)
>  	pde->flags |= PROC_ENTRY_PERMANENT;
>  }
>  
> +static inline bool pde_has_proc_read_iter(const struct proc_dir_entry *pde)
> +{
> +	return pde->flags & PROC_ENTRY_proc_read_iter;
> +}
> +
> +static inline bool pde_has_proc_compat_ioctl(const struct proc_dir_entry *pde)
> +{
> +#ifdef CONFIG_COMPAT
> +	return pde->flags & PROC_ENTRY_proc_compat_ioctl;
> +#else
> +	return false;
> +#endif
> +}
> +
>  extern struct kmem_cache *proc_dir_entry_cache;
>  void pde_free(struct proc_dir_entry *pde);
>  
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index 0b2a89854440..ea62201c74c4 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -20,10 +20,13 @@ enum {
>  	 * If in doubt, ignore this flag.
>  	 */
>  #ifdef MODULE
> -	PROC_ENTRY_PERMANENT = 0U,
> +	PROC_ENTRY_PERMANENT		= 0U,
>  #else
> -	PROC_ENTRY_PERMANENT = 1U << 0,
> +	PROC_ENTRY_PERMANENT		= 1U << 0,
>  #endif
> +
> +	PROC_ENTRY_proc_read_iter	= 1U << 1,
> +	PROC_ENTRY_proc_compat_ioctl	= 1U << 2,
>  };
>  
>  struct proc_ops {
> 

