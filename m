Return-Path: <stable+bounces-81565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180709945FE
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A13B23195
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A4518C901;
	Tue,  8 Oct 2024 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ey89Sl4H"
X-Original-To: stable@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8163C0C;
	Tue,  8 Oct 2024 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385394; cv=none; b=W/bNEaO/h7tNcVESHN15/6qhjs4jAcd2tbhszW/cHLBnbJ0cNxnq/lTHsNsAYYlvWmfkBAJhXzM8WdWC1GacuhRAcPtFVicEvc6f4o9UyrhVbw6bAObV40wevmE4xUiFYmA/e8r/TnRv8z6sqp9KXY4y3sCJbqt+8m8u1z7Bk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385394; c=relaxed/simple;
	bh=T1qucypxGrzdy/JwejJ9FcnMR0qbG3OvHF1gn7AG6E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hC5XFgKs9jtMKFEEmFr5Voi6n5J3FrDNqNqFH8ptbYEgYX2SKiaTe+weza2zt0xT1uioNKPNHUXxJC0ENxKKWGJwwbSrciTGKqjDBplXPD9EUWGiAfS3VB4BgTbe1NIXPEhMedtKl+2r0kyRm+A12iaxnieZ15CbaFFeqS+ToW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ey89Sl4H; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728385388; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BhEeEmz5Ayr7UdeKSQa+kZhHdOTpdr9AhSIJbiGT5Vg=;
	b=Ey89Sl4HvVwci/Thiuqki3Os2LYG0d4yIZ2QWpu8eij9TxHH0tP9KNF6nh/AJTZ/Sh7QzLl2SXYDGLZ/zitT5Gu0EjIcIDBrMNo6fZsYRIXGR43YIMe78nrjVAcvzydPkPxQaLsB/epqnJSL0F+SWdd0PF5GxgFZbfZk15FkbY4=
Received: from 30.221.129.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGeblGu_1728385386)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 19:03:07 +0800
Message-ID: <4276433b-976e-4e27-9568-ab02e6759905@linux.alibaba.com>
Date: Tue, 8 Oct 2024 19:03:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y 1/5] erofs: get rid of erofs_inode_datablocks()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20241008065708.727659-1-hsiangkao@linux.alibaba.com>
 <2024100829-unplowed-vending-675b@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024100829-unplowed-vending-675b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/8 18:26, Greg Kroah-Hartman wrote:
> On Tue, Oct 08, 2024 at 02:57:04PM +0800, Gao Xiang wrote:
>> commit 4efdec36dc9907628e590a68193d6d8e5e74d032 upstream.
>>
>> erofs_inode_datablocks() has the only one caller, let's just get
>> rid of it entirely.  No logic changes.
>>
>> Reviewed-by: Yue Hu <huyue2@coolpad.com>
>> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> Reviewed-by: Chao Yu <chao@kernel.org>
>> Stable-dep-of: 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
>> Link: https://lore.kernel.org/r/20230204093040.97967-1-hsiangkao@linux.alibaba.com
>> [ Gao Xiang: apply this to 6.6.y to avoid further backport twists
>>               due to obsoleted EROFS_BLKSIZ. ]
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> Obsoleted EROFS_BLKSIZ impedes efforts to backport
>>   9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
>>   9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
>>
>> To avoid further bugfix conflicts due to random EROFS_BLKSIZs
>> around the whole codebase, just backport the dependencies for 6.1.y.
> 
> all now queued up, thanks.

Thanks Greg, I'd like to avoid obsoleted EROFS_BLKSIZ
conflicts for 6.1.y anymore (and just a few dependencies
to avoid this), so that will save the future bugfix
backport efforts around the 6.1.y codebase.

For more older stable versions, I will manually handle
conflicts later since more non-trivial dependencies need
otherwise but I think bugfixes for older stable versions
will become fewer and fewer...

Thanks,
Gao Xiang

> 
> greg k-h


