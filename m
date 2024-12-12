Return-Path: <stable+bounces-100881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22EE9EE461
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CD3281567
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61535210F62;
	Thu, 12 Dec 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CYtJLipE"
X-Original-To: stable@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1110F2
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000137; cv=none; b=cY2bM+S5YTlRwPcr35A3CqAMDgmjzE2WWpPi6Hx0P0cNEwHi4VpiD4N8hJezN3nXfCYeHEkaQtW20lIEGy3I4+wHessFVNZxbnQSizHIdmvaYEhDOG8Vn/ejB0mmCzPJx8k9edE2N9zJ1KhTJ8Wm8PCGy/PWzbGJjHhEh4yUhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000137; c=relaxed/simple;
	bh=mEMYLumDS3fnyu+W7E5zx3Z9NHmq0n781dP5vrtDlhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsA3rP1CwL9UedBErq7ShIrUWjVyw/pViz636mvVuppx+qYkwEsObY8D0smKV5UZDkRvSOjD/P2w1Ue7/HXKr5k7IfLm9Kt6FNH7r6zFuhJGVpgcugKLPydXBvuqJuI3Egd2RzVuaRxNrQUH3hUU4PBsjzBZQQ68xwwVrlmajr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CYtJLipE; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734000132; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4yldQ1PfQ+DK5I4Zq2UeI6r5GYQZt6sA4uVpKGSyBWg=;
	b=CYtJLipEL8aqQ2BEld4A8zNiLUjFlnV/tXppmHSvmFkrIi1YFbCnMPiKip/EInO8W7zmA4ly7AnZ/7e6rcVYmtBwu588ncx7I2Qp1AXRW9fP8JIP4Xa4oNZGCRRxaDdNkjEDqeoWtp/qsp2cTb+D1q692M+hwYoKLBR4t4ALpQk=
Received: from 30.221.147.123(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WLLRM4Y_1734000118 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 18:42:11 +0800
Message-ID: <0f122ee5-56e3-45b0-b531-455fcf9cea3c@linux.alibaba.com>
Date: Thu, 12 Dec 2024 18:41:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ocfs2 broken for me in 6.6.y since 6.6.55
To: Thomas Voegtle <tv@lio96.de>, Heming Zhao <heming.zhao@suse.com>,
 Su Yue <glass.su@suse.com>
Cc: stable@vger.kernel.org
References: <21aac734-4ab5-d651-cb76-ff1f7dffa779@lio96.de>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <21aac734-4ab5-d651-cb76-ff1f7dffa779@lio96.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

See: https://lore.kernel.org/ocfs2-devel/20241205104835.18223-1-heming.zhao@suse.com/T/#t

On 2024/12/12 18:32, Thomas Voegtle wrote:
> 
> Hi,
> 
> ocfs2 on a drbd device, writing something to it, then unmount ends up in:
> 
> 
> [ 1135.766639] OCFS2: ERROR (device drbd0): ocfs2_block_group_clear_bits:
> Group descriptor # 4128768 has bit count 32256 but claims 33222 are freed.
> num_bits 996
> [ 1135.766645] On-disk corruption discovered. Please run fsck.ocfs2 once
> the filesystem is unmounted.
> [ 1135.766647] (umount,10751,3):_ocfs2_free_suballoc_bits:2490 ERROR:
> status = -30
> [ 1135.766650] (umount,10751,3):_ocfs2_free_clusters:2573 ERROR: status =
> -30
> [ 1135.766652] (umount,10751,3):ocfs2_sync_local_to_main:1027 ERROR:
> status = -30
> [ 1135.766654] (umount,10751,3):ocfs2_sync_local_to_main:1032 ERROR:
> status = -30
> [ 1135.766656] (umount,10751,3):ocfs2_shutdown_local_alloc:449 ERROR:
> status = -30
> [ 1135.965908] ocfs2: Unmounting device (147,0) on (node 2)
> 
> 
> This is since 6.6.55, reverting this patch helps:
> 
> commit e7a801014726a691d4aa6e3839b3f0940ea41591
> Author: Heming Zhao <heming.zhao@suse.com>
> Date:   Fri Jul 19 19:43:10 2024 +0800
> 
>     ocfs2: fix the la space leak when unmounting an ocfs2 volume
> 
>     commit dfe6c5692fb525e5e90cefe306ee0dffae13d35f upstream.
> 
> 
> Linux 6.1.119 is also broken, but 6.12.4 is fine.
> 
> I guess there is something missing?
> 
> 
>     Thomas


