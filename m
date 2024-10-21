Return-Path: <stable+bounces-87043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EDD9A608C
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 11:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5751C21EFE
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2161A1E32C6;
	Mon, 21 Oct 2024 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bqQGBwON"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD70194AD9
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503980; cv=none; b=EtouBU7mLwBfTWoXeGzrtVE5/oga3NCbIeNJ1cmJbB+TGZbmRE3r4mKcq/NedoRy4MjCn2mHfGOtCuF68ib02pPVGgpKPQnYGUl3mt9eryJBZkX8npN0lK7FMzIv6LH8WpAlkmA7/WDmhirXRH7Suj8thnH4zH8G8eyaCM06ul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503980; c=relaxed/simple;
	bh=CsE4HY6cWbiHxv4gCvkP6PANNBfvolPgW7c7uOOgQOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2EOKKX1FlsZkvM9Nfj+xLO/RELqLgwBZdXQO15C6ZR3uuqSy1gCybbTVb3UcyOVsOB1t2yfzolypsUeSm7fCrTvFrNVd1zjyCwMA/XJtq9orwwu4KcP/HYt2J64HAC9Ts7XjxWbvtztnw44VY/LYwVqqLqUmiAma6/yldN/kVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bqQGBwON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C91FC4CEC3;
	Mon, 21 Oct 2024 09:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729503980;
	bh=CsE4HY6cWbiHxv4gCvkP6PANNBfvolPgW7c7uOOgQOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqQGBwON5mW2wA1fXfC/1pbuke/yb5dR6lpPeKqYhXdwUizWGRn7GHLLoMoY6sHhq
	 R1TPouIsPYPevwJ4yQkLTyV2My59qdP2+EE0r6HySVS1MiNBkxyA7qCTdV1whpiyJM
	 Y7FGsi6accKWSoLENi0EZj1jBdLNvAaH0VCW5bqo=
Date: Mon, 21 Oct 2024 11:46:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: stable@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	Juhyung Park <qkrwngud825@gmail.com>,
	Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Subject: Re: [PATCH 5.4.y] erofs: fix lz4 inplace decompression
Message-ID: <2024102112-blip-payback-3e36@gregkh>
References: <20241021084429.3742972-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021084429.3742972-1-hsiangkao@linux.alibaba.com>

On Mon, Oct 21, 2024 at 04:44:29PM +0800, Gao Xiang wrote:
> commit 3c12466b6b7bf1e56f9b32c366a3d83d87afb4de upstream.
> 
> Currently EROFS can map another compressed buffer for inplace
> decompression, that was used to handle the cases that some pages of
> compressed data are actually not in-place I/O.
> 
> However, like most simple LZ77 algorithms, LZ4 expects the compressed
> data is arranged at the end of the decompressed buffer and it
> explicitly uses memmove() to handle overlapping:
>   __________________________________________________________
>  |_ direction of decompression --> ____ |_ compressed data _|
> 
> Although EROFS arranges compressed data like this, it typically maps two
> individual virtual buffers so the relative order is uncertain.
> Previously, it was hardly observed since LZ4 only uses memmove() for
> short overlapped literals and x86/arm64 memmove implementations seem to
> completely cover it up and they don't have this issue.  Juhyung reported
> that EROFS data corruption can be found on a new Intel x86 processor.
> After some analysis, it seems that recent x86 processors with the new
> FSRM feature expose this issue with "rep movsb".
> 
> Let's strictly use the decompressed buffer for lz4 inplace
> decompression for now.  Later, as an useful improvement, we could try
> to tie up these two buffers together in the correct order.
> 
> Reported-and-tested-by: Juhyung Park <qkrwngud825@gmail.com>
> Closes: https://lore.kernel.org/r/CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com
> Fixes: 0ffd71bcc3a0 ("staging: erofs: introduce LZ4 decompression inplace")
> Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 backend")
> Cc: stable <stable@vger.kernel.org> # 5.4+
> Tested-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> Link: https://lore.kernel.org/r/20231206045534.3920847-1-hsiangkao@linux.alibaba.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> The remaining stable patch to address the issue "CVE-2023-52497" for
> 5.4.y, which is the same as the 5.10.y one [1].

Now queued up, thanks.

greg k-h

