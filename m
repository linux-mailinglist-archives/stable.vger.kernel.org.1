Return-Path: <stable+bounces-170057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B57B2A193
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1CB189767C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A67318E377;
	Mon, 18 Aug 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="dFV7u55Z"
X-Original-To: stable@vger.kernel.org
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B02264B2
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519716; cv=none; b=Kb5suUPBlGms+ZpIY3eEWflICpohaoY1VRWDMmYZc0ZEQ61kfOiqFqPDQLhGKJWYO1hzhz/D7eSk7XZ+yfSecfenlKNsmnPHxrFMovZUoEJSsjPWZ4f6hV5q4Zd93Qo9E64xjUzx+wuLbz6BcThR90Nml21xpnjpcz4Q08oSupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519716; c=relaxed/simple;
	bh=9RIMRZmyhs+tNT3Fpwt3pcnoQAdBQfHL2vgHdqGHdUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKqFdaB1RMJVNMNMom4LovC+ALU739rkXLX5WBWSafxWW436Qh2fQWf/FbrrW4swL/dGTL3LMmHcxkmAGEzOJRL5LoRpzPOMnh7X6iCP940W1KRvq0RD4h1dYLsvgcT/6bFH0fdy87xzUcD8fSIvb2mGgFqgbT4UTAEWC/8gmxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=dFV7u55Z; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=56m7NlCI9xO34e2Vwp7nPmJKNMoZiYEdCHcWLlguiPA=;
	b=dFV7u55ZxlWnHiiGqWsdKyh1OmSa2Dss8e9hz3WfdFWBNaEVc3rIoGiYm2GyohC53pmh7Nq3P
	QTS4TDXEWaHc8n6R2O/5pfMGxzxJU3Qf+NJIKyapDnbJ8XPPV4ov41/HTdSUhNLa8vkExWI/9uw
	2m/0DoMXpN3HV6wDaRmBhG8=
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4c5BfH07ZwzYm8gX;
	Mon, 18 Aug 2025 20:21:43 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 20:21:51 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 20:21:50 +0800
From: wangzijie <wangzijie1@honor.com>
To: <wangzijie1@honor.com>
CC: <polynomial-c@gmx.de>, <stable@vger.kernel.org>
Subject: Re: [PATCH RESEND v2] proc: fix missing pde_set_flags() for net proc files
Date: Mon, 18 Aug 2025 20:21:50 +0800
Message-ID: <20250818122150.958567-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250818121009.957696-1-wangzijie1@honor.com>
References: <20250818121009.957696-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a011.hihonor.com
 (10.68.31.243)

> To avoid potential UAF issues during module removal races, we use pde_set_flags()
> to save proc_ops flags in PDE itself before proc_register(), and then use
> pde_has_proc_*() helpers instead of directly dereferencing pde->proc_ops->*.
> 
> However, the pde_set_flags() call was missing when creating net related proc files.
> This omission caused incorrect behavior which FMODE_LSEEK was being cleared
> inappropriately in proc_reg_open() for net proc files. Lars reported it in this link[1].
> 
> Fix this by ensuring pde_set_flags() is called when register proc entry, and add
> NULL check for proc_ops in pde_set_flags().
> 
> [1]: https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/
> 
> Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al)
> Cc: stable@vger.kernel.org
> Reported-by: Lars Wendler <polynomial-c@gmx.de>
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
>  fs/proc/generic.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 76e800e38..003031839 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -367,6 +367,23 @@ static const struct inode_operations proc_dir_inode_operations = {
>  	.setattr	= proc_notify_change,
>  };
>  
> +static void pde_set_flags(struct proc_dir_entry *pde)
> +{
> +	if (!pde->proc_ops)
> +		return;
> +
> +	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
> +		pde->flags |= PROC_ENTRY_PERMANENT;
> +	if (pde->proc_ops->proc_read_iter)
> +		pde->flags |= PROC_ENTRY_proc_read_iter;
> +#ifdef CONFIG_COMPAT
> +	if (pde->proc_ops->proc_compat_ioctl)
> +		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
> +#endif
> +	if (pde->proc_ops->proc_lseek)
> +		pde->flags |= PROC_ENTRY_proc_lseek;
> +}
> +
>  /* returns the registered entry, or frees dp and returns NULL on failure */
>  struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>  		struct proc_dir_entry *dp)
> @@ -374,6 +391,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>  	if (proc_alloc_inum(&dp->low_ino))
>  		goto out_free_entry;
>  
> +	pde_set_flags(dp);
> +
>  	write_lock(&proc_subdir_lock);
>  	dp->parent = dir;
>  	if (pde_subdir_insert(dir, dp) == false) {
> @@ -561,20 +580,6 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
>  	return p;
>  }
>  
> -static void pde_set_flags(struct proc_dir_entry *pde)
> -{
> -	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
> -		pde->flags |= PROC_ENTRY_PERMANENT;
> -	if (pde->proc_ops->proc_read_iter)
> -		pde->flags |= PROC_ENTRY_proc_read_iter;
> -#ifdef CONFIG_COMPAT
> -	if (pde->proc_ops->proc_compat_ioctl)
> -		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
> -#endif
> -	if (pde->proc_ops->proc_lseek)
> -		pde->flags |= PROC_ENTRY_proc_lseek;
> -}
> -
>  struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
>  		struct proc_dir_entry *parent,
>  		const struct proc_ops *proc_ops, void *data)
> @@ -585,7 +590,6 @@ struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
>  	if (!p)
>  		return NULL;
>  	p->proc_ops = proc_ops;
> -	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL(proc_create_data);
> @@ -636,7 +640,6 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
>  	p->proc_ops = &proc_seq_ops;
>  	p->seq_ops = ops;
>  	p->state_size = state_size;
> -	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL(proc_create_seq_private);
> @@ -667,7 +670,6 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
>  		return NULL;
>  	p->proc_ops = &proc_single_ops;
>  	p->single_show = show;
> -	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL(proc_create_single_data);
> -- 
> 2.25.1

Please igonore this, I will send it again correctly.

