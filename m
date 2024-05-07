Return-Path: <stable+bounces-43435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890968BF2C2
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A15F1F21AB4
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE031A2C10;
	Tue,  7 May 2024 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GDYRA7PX"
X-Original-To: stable@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040F91A2C06;
	Tue,  7 May 2024 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123786; cv=none; b=O47M24ecYjpO5wgxAr/X+8prRSPkU6nJ+NoG9XgDMyFBiWsp74fkSI8kDZGTgvQwUb/vNaN+fW1tpDAHYDXOkwCEc+CboycPYKXT7SdbUVp2BOjIp7O6dBPohf5VEoUs86zNOyp2CSwn7gWBSmewASaNhS7/FIrHc6q7mQp4a3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123786; c=relaxed/simple;
	bh=W4CvRIluG6tZP/2Olqj+oh3nl1PvWT5AaGD2q1molKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMB0J/MoOVvw5jq3EARweuu/Xn1v6VX7uO88paWSf74iGp5r4sf6eMOe500VXtRXN2/1A9TNSiGS+IYCkRaxacPMnmR4dUrpakD4FeVhknIHuynwU+l5VmFT2WxU4m/CfWd88jKREhT+y+V/NSiAR/22GxfiAmp4i17cz4WihdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GDYRA7PX; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715123780; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ot252tbl7SBLqukvaIH9QV/q4GG5yoGHVQJ2MVuayfg=;
	b=GDYRA7PX62xTD6CX6y0IbiRSSVXLxM7W905mUeY0+i7OK+8w4AdpN+l4kdlBf+5KH/tR2hr983Z3ujXv4Ioxk2UhUdIXPhJynWuQ8KRGk2KzvLISGeNAG1h42UUNVN7CnysJCLiNivj/QWs4yiK6ydEritLa8X3HvXOSwVP0sOU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W61JUjF_1715123777;
Received: from 30.25.231.12(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W61JUjF_1715123777)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 07:16:19 +0800
Message-ID: <bcd90345-18ea-486b-9e6b-352b2f2d2e08@linux.alibaba.com>
Date: Wed, 8 May 2024 07:16:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.6 21/43] erofs: reliably distinguish block based
 and fscache mode
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Baokun Li <libaokun1@huawei.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
 xiang@kernel.org, linux-erofs@lists.ozlabs.org
References: <20240507231033.393285-1-sashal@kernel.org>
 <20240507231033.393285-21-sashal@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240507231033.393285-21-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/5/8 07:09, Sasha Levin wrote:
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

Please help drop this patch, you should backport the dependency
commit 07abe43a28b2 ("erofs: get rid of erofs_fs_context")

in advance.

Thanks,
Gao Xiang

