Return-Path: <stable+bounces-169935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCE6B29BAF
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E02E74E2385
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 08:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185ED2882CD;
	Mon, 18 Aug 2025 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuJu2Guw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83F42F8BD1;
	Mon, 18 Aug 2025 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504524; cv=none; b=HVRJF39S1axWc5uA4Oy0QLEE0Qk/t3cWEp6ZQ6VI/AJPf+ER0Mx5PWfoEFq6WhJNBF4FXdX5mRCWYBhegboKvwuEYsvEqEfv+pUCRm6ZWfEOT6n/dfX1VDF8y5sXTWTTrigILc899FxUb8g7/yY7dto9kV1Ip5hUWLN/a2mhDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504524; c=relaxed/simple;
	bh=3gbMwLWpeu6BfJ+2J8ZRRqoihf6t7/L0bmG1IBQ4ZrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqB42bR2ugkAWog9NCPBAydxVU3/pHbzuo5U4igh1p4Lx1v+VUzufRMlfM+gXW+f0qp1IF0KR5Fj+7l+oWqiZRZQzfpgqEr14rPBoiXyJhgKcAYSq1tQAeexRgPixxOSk816C1mexj5HQGrXoyfb2XbHJBUQ5s3q9Y+WbRGlTlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuJu2Guw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4420C116C6;
	Mon, 18 Aug 2025 08:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755504523;
	bh=3gbMwLWpeu6BfJ+2J8ZRRqoihf6t7/L0bmG1IBQ4ZrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZuJu2GuwEpqNR+e8nYaIPgor20+hVY7Hnhgmu+mawgs1vHbsrpa4hUDvnyS4lbDIf
	 eQ6yDaxwA5hHw2qsq5p5vf/iJ3kbcBt4VQ/B0M3jxwZ3iO19/0wxa0fJvDYB2RQRlV
	 qUxVT/GBhAKPjS7C3LkLhPwUSBcya/v1sp5afXhu3BMdYXcRQMtg5o2Wrz3U/BMVwm
	 pS5707AzTtEgZLfAV01CsuYSgz6CuvzouIqn+484I95HLXbnw1K7YS68twbvfXMSiC
	 CSNzATmUu3OxD2/vu+b+L2sIZLKrtiSv1pHN+VnBjNHmQBADfa4BotpG+bqgdoCoyC
	 R9h6By5t78+gA==
Message-ID: <c3866652-dcba-4cc7-b2b3-8c33a8898ccd@kernel.org>
Date: Mon, 18 Aug 2025 10:08:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] proc: fix wrong behavior of FMODE_LSEEK clearing for net
 related proc file
To: wangzijie <wangzijie1@honor.com>, jirislaby@kernel.org
Cc: adobriyan@gmail.com, akpm@linux-foundation.org, ast@kernel.org,
 gregkh@linuxfoundation.org, kirill.shutemov@linux.intel.com,
 polynomial-c@gmx.de, regressions@lists.linux.dev,
 rick.p.edgecombe@intel.com, stable@vger.kernel.org, viro@zeniv.linux.org.uk
References: <f2ff00e6-a931-4c61-a43d-fb3e450f7ffd@kernel.org>
 <20250818080125.843285-1-wangzijie1@honor.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250818080125.843285-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 08. 25, 10:01, wangzijie wrote:
>> Hi,
>>
>> On 18. 08. 25, 6:05, wangzijie wrote:
>>> For avoiding pde->proc_ops->... dereference(which may cause UAF in rmmod race scene),
>>> we call pde_set_flags() to save this kind of information in PDE itself before
>>> proc_register() and call pde_has_proc_XXX() to replace pde->proc_ops->... dereference.
>>> But there has omission of pde_set_flags() in net related proc file create, which cause
>>> the wroing behavior of FMODE_LSEEK clearing in proc_reg_open() for net related proc file
>>> after commit ff7ec8dc1b64("proc: use the same treatment to check proc_lseek as ones for
>>> proc_read_iter et.al"). Lars reported it in this link[1]. So call pde_set_flags() when
>>> create net related proc file to fix this bug.
>>
>> I wonder, why is pde_set_flags() not a part of proc_register()?
> 
> Not all proc_dir_entry have proc_ops, so you mean this will be a better modification?
> 
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 76e800e38..d52197c35 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -367,6 +367,20 @@ static const struct inode_operations proc_dir_inode_operations = {
>          .setattr        = proc_notify_change,
>   };
> 
> +static void pde_set_flags(struct proc_dir_entry *pde)
> +{
> +       if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
> +               pde->flags |= PROC_ENTRY_PERMANENT;
> +       if (pde->proc_ops->proc_read_iter)
> +               pde->flags |= PROC_ENTRY_proc_read_iter;
> +#ifdef CONFIG_COMPAT
> +       if (pde->proc_ops->proc_compat_ioctl)
> +               pde->flags |= PROC_ENTRY_proc_compat_ioctl;
> +#endif
> +       if (pde->proc_ops->proc_lseek)
> +               pde->flags |= PROC_ENTRY_proc_lseek;
> +}
> +
>   /* returns the registered entry, or frees dp and returns NULL on failure */
>   struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>                  struct proc_dir_entry *dp)
> @@ -374,6 +388,9 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>          if (proc_alloc_inum(&dp->low_ino))
>                  goto out_free_entry;
> 
> +       if (dp->proc_ops)
> +               pde_set_flags(dp);


This occurs much saner and better to me. But I am no FS fellow. It's up 
to them to tell if it is the right thing to do.

(The above hunks are missing removal of pde_set_flags() from the 
original location and removal of now unnecessary calls of 
pde_set_flags(). But I assume you would do that in a real/submitted patch.)

thanks,
-- 
js
suse labs


