Return-Path: <stable+bounces-210136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECA2D38D24
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 08:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B1F301AD1E
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 07:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9FA31A81F;
	Sat, 17 Jan 2026 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iXaBmfJi"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B5427587D;
	Sat, 17 Jan 2026 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768635962; cv=none; b=qCRuWp9PJGJwm6PH+Z3/cDHYQ9r39YzWsEVRB/rue7p/priZ6/L/wYDvc9lqhWpwfl61MCWC7eusVXDE0GYq5o/Eq77rvoilhisT+b8Fg74ElxAUkwoKRwBA6O4dokIeCVjqRlxiwNN1APGb4xvDqgcAtBHdYoF5mZ4LKz7MlnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768635962; c=relaxed/simple;
	bh=ZxcnvxL7JRXkCVv+Q+OSEzpE3H+78lyYf8OwIHvxJSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WjDkUl1lC92+DFoCmy5FHDfV/6H/algPV64PNT2D8RQUyXYeFZ/oOiAiV1FwCx0moFoUzcOW1zAqrMOUvZ3LdrO3HlXIBC/qA1kctF2NPUW8l5j7wY+x2YFggCztX+fxP9q86UQuOOXm3DnqsiD0pP+38ISPjpShNvaRzk01gd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iXaBmfJi; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CTksVfBTpsba5iXLLBdG+mDlVrrmby9B2lx45VJNH2M=;
	b=iXaBmfJiJaJeJ5OctQb1DHAkyZ+pSIvjQvhuFwwUTpSGm9+BfBGVMd9f1wm6tKzZk6r2eDv/p
	78stdI8SQSxtXi00Iw3sGB+yz7KCjL97ksWAo/mcJuvDMtotDeJvkFg3ZZGIBIo5efnouEo6SO7
	t9INatzz91ZItizIvhTXFMY=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dtTF91pFvz12LFm;
	Sat, 17 Jan 2026 15:41:49 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id F14B840539;
	Sat, 17 Jan 2026 15:45:49 +0800 (CST)
Received: from [10.67.111.31] (10.67.111.31) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 17 Jan
 2026 15:45:49 +0800
Message-ID: <e835a856-4e2d-42dc-b3ab-79aa341e0783@huawei.com>
Date: Sat, 17 Jan 2026 15:45:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2,stable/linux-6.6.y] fbdev: Fix out-of-bounds issue in
 sys_fillrect()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
	<linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<stable@vger.kernel.org>, Lu Jialin <lujialin4@huawei.com>
References: <20251217094530.1685998-1-gubowen5@huawei.com>
 <2025121715-vindicate-valium-1118@gregkh>
Content-Language: en-US
From: Gu Bowen <gubowen5@huawei.com>
In-Reply-To: <2025121715-vindicate-valium-1118@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh100007.china.huawei.com (7.202.181.92)

Hi Greg,

On 12/17/2025 5:34 PM, Greg Kroah-Hartman wrote:
> On Wed, Dec 17, 2025 at 05:45:30PM +0800, Gu Bowen wrote:
>> This issue has already been fixed by commit eabb03293087 ("fbdev:
>> Refactoring the fbcon packed pixel drawing routines") on v6.15-rc1, but it
>> still exists in the stable version.
> 
> Why not take the refactoring changes instead?  That is almost always the
> proper thing to do, one-off changes are almost always wrong and cause
> extra work in the long-term.
> 
> Please try backporting those changes instead please.
> 
> thanks,
> 
> greg k-h

As you've suggested, I understand the preference to keep stable branches 
aligned with upstream when possible. However, I find that the 
refactoring touches many areas of the codebase that have diverged 
between mainline and stable-6.6, resulting in extensive merge conflicts. 
In addition, I cannot be certain that backporting 3000+ lines of 
refactoring code to a stable branch might introduce unknown risks.

Given the current situation, I have another simpler patch solution that 
is easy to maintain, and perhaps it could be merged into the stable branch:

void sys_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
  ...
  while (height--) {
  	dst += dst_idx >> (ffs(bits) - 1);
+	long dst_offset;
+	dst_offset = (unsigned long)dst - (unsigned long)p->screen_base;
+	if (dst_offset < 0 || dst_offset >= p->fix.smem_len)
+		return;
  	dst_idx &= (bits - 1);
  	fill_op32(p, dst, dst_idx, pat, width*bpp, bits);
  ...


BR,
Guber

