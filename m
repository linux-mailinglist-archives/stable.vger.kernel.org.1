Return-Path: <stable+bounces-43436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE668BF2CD
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A147C1C2234F
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059BC13AA5A;
	Tue,  7 May 2024 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FB66OVWl"
X-Original-To: stable@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931212BE80;
	Tue,  7 May 2024 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124007; cv=none; b=Pn843AQun5nJK25kzNeZWMsFZymNvPNbut/z21WMujR6VAcp227n1NnGQsd0I+a4wKDgOcAo4pXBlhsuUC1gbgIS8WXtF4OwAv0I5/7JyNxJR0elKBSDuIjeCQBBQxivk9Z6Um2/gIYuY/nbrS85DQv+/N/sCUVoUhq8wLbjexw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124007; c=relaxed/simple;
	bh=kHS9g9RwmKOf15zpnBSFQy0orV9EnY5jccmGnQvCJl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etBEq1fwnLcVkOTgDudGLpVyKCxIjj1BnYfJYveoBWvrjG7B0gxlQnY16WTGNseQ4aOcOH2zFyd8gnlBLnrjrK5eLNWPdYMLHwvOAsNUmUHmcr3X4cdJVvHUiM+DKYai8kuyU5ZMoSEf1VgCV2PLxj+mYe8Ep6UuZGoyEh2l+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FB66OVWl; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715123996; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=e0zrxwPcAb6kwy18tLfS3CmdjXGu2j+7ybZ31BCE1es=;
	b=FB66OVWllglJrtsVgitdr4BBAFSOJsBaZztYNNhtXW8dxHbHjVUuAsWqekWUXTz3pCER7z9lCNl0lxrDvK160MtUtI1/+OsEI+yk/0tf7V3hCHytjVEztSDPszc58oMe9uiK5sG4CN9CveCAkN1Qzcoth2IuaKHjdBcSVfjVNu4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W61IPVB_1715123993;
Received: from 30.25.231.12(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W61IPVB_1715123993)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 07:19:55 +0800
Message-ID: <aca15d22-e2f9-4d09-b022-f290d9c902c9@linux.alibaba.com>
Date: Wed, 8 May 2024 07:19:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.8 26/52] erofs: reliably distinguish block based
 and fscache mode
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Baokun Li <libaokun1@huawei.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
 xiang@kernel.org, linux-erofs@lists.ozlabs.org
References: <20240507230800.392128-1-sashal@kernel.org>
 <20240507230800.392128-26-sashal@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240507230800.392128-26-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/5/8 07:06, Sasha Levin wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> [ Upstream commit 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606 ]
> 
> When erofs_kill_sb() is called in block dev based mode, s_bdev may not
> have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
> it will be mistaken for fscache mode, and then attempt to free an anon_dev
> that has never been allocated, triggering the following warning:
> 
> ============================================
> ida_free called for id=0 which is not allocated.
> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
> Modules linked in:
> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
> RIP: 0010:ida_free+0x134/0x140
> Call Trace:
>   <TASK>
>   erofs_kill_sb+0x81/0x90
>   deactivate_locked_super+0x35/0x80
>   get_tree_bdev+0x136/0x1e0
>   vfs_get_tree+0x2c/0xf0
>   do_new_mount+0x190/0x2f0
>   [...]
> ============================================
> 
> Now when erofs_kill_sb() is called, erofs_sb_info must have been
> initialised, so use sbi->fsid to distinguish between the two modes.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Link: https://lore.kernel.org/r/20240419123611.947084-3-libaokun1@huawei.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>


Please help drop this patch for now too, you should backport
the dependency commit
07abe43a28b2 ("erofs: get rid of erofs_fs_context") in advance.

Otherwise it doesn't work and break the functionality.

Thanks,
Gao Xiang


