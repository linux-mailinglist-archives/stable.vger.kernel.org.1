Return-Path: <stable+bounces-16015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3D583E72D
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1E81C27BCB
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7371F54FA7;
	Fri, 26 Jan 2024 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GHWlMs+s"
X-Original-To: stable@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB455A78A
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312647; cv=none; b=VaDTWRpqR+P9e+4O4P1YdOMIUSc5kz1RMw6BSGPyZtzXNBZSb5emRYq2DF18erxcqdFo3aBYR0iCuNWBIxfEU8cWuaWY+H8ampYBahgBeHDaQmMy0tDZdKRUaP4s5c94+j0dUUWRcBgGof5Ynqh3dA9fBB40WE2M/nRvtK3y2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312647; c=relaxed/simple;
	bh=fj3MSFClJte99hOXnCS8Y0hmkJsTuo6w/gDJXUxLltc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hy5y+6qBuOin/iBx60o8BsA5EqJWQH+Pb5zgDhcvbssLC74PpD/OgpYWut61gtmdgnWRdCUNDxhO7C9YJNnhs7yKP0G4CttpDYRm3o66R6m0HhtYsu7jtb0Ane1n9NBDOw3cWsdqJkpvqBWIHw/JbbG1Kaem1w2D/XHQDFYhtIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GHWlMs+s; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706312641; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5f7pPleCw0YoUejgUmF4DnKes6pNbfN6NcDovMuweJk=;
	b=GHWlMs+spoMD5vyEyyUWgXWbO4iIkk2HOY0NOgcWQyD6db0uSAg/G0705E3duCP5wiOCKbwfO8vI+dUNrkaSdq8jxLZRmAgp5r2tT37f8kAUz3hldA1rLR56yDOyruPxZkIBpzsupPbi2OribTheNvs8e9D6VR6iUjvOPDuOIJU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.OwAwe_1706312640;
Received: from 192.168.71.5(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.OwAwe_1706312640)
          by smtp.aliyun-inc.com;
          Sat, 27 Jan 2024 07:44:01 +0800
Message-ID: <3fe3c62d-1e80-47e7-b71e-a96f3648803b@linux.alibaba.com>
Date: Sat, 27 Jan 2024 07:43:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] erofs: fix lz4 inplace decompression"
 failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org, xiang@kernel.org, qkrwngud825@gmail.com,
 stable@vger.kernel.org, zhaoyifan@sjtu.edu.cn
References: <2024012648-backwater-colt-7290@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024012648-backwater-colt-7290@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

On 2024/1/27 06:07, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 3c12466b6b7bf1e56f9b32c366a3d83d87afb4de
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012648-backwater-colt-7290@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Possible dependencies:
> 
> 3c12466b6b7b ("erofs: fix lz4 inplace decompression")
> 123ec246ebe3 ("erofs: get rid of the remaining kmap_atomic()")
> ab749badf9f4 ("erofs: support unaligned data decompression")
> 10e5f6e482e1 ("erofs: introduce z_erofs_fixup_insize")
> d67aee76d418 ("erofs: tidy up z_erofs_lz4_decompress")
> 7e508f2ca8bb ("erofs: rename lz4_0pading to zero_padding")
> eaa9172ad988 ("erofs: get rid of ->lru usage")
> 622ceaddb764 ("erofs: lzma compression support")
> 966edfb0a3dc ("erofs: rename some generic methods in decompressor")
> 386292919c25 ("erofs: introduce readmore decompression strategy")
> 8f89926290c4 ("erofs: get compression algorithms directly on mapping")
> dfeab2e95a75 ("erofs: add multiple device support")
> e62424651f43 ("erofs: decouple basic mount options from fs_context")
> 5b6e7e120e71 ("erofs: remove the fast path of per-CPU buffer decompression")

I will take time on LTS versions manually soon.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h

