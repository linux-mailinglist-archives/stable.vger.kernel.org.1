Return-Path: <stable+bounces-23587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F09A8629FC
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 11:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72291F21228
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 10:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9AEF9F2;
	Sun, 25 Feb 2024 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bElAIKkS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC23EAFA
	for <stable@vger.kernel.org>; Sun, 25 Feb 2024 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708857949; cv=none; b=WRdvRjNbxHeQaXftBu1Mcd9TcGNLli2xQNOFRvf9CN86wrsSpmR0qWSK9yxZi4ka2w41POci5RaMrhQSo2aW2XVWE2rF7KS1xvtuszKCTnX1Qv5St3Gi0GdMf9qJ8WSK6fqqpNda0AeqJm+7KPmODxUg/qlgXzFhG2M0ntvCWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708857949; c=relaxed/simple;
	bh=xaEEwq+zhwXXlXUsjzZ1qKHdigMxUKVoFzGsp+eDLQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWCwj/zQS5bhbL3vacOcBhGASMWmWNqJs2jpf4iHMmUkPxeuDYWZvAuHxqS1Tr0+gGq+lZDrM6iB06AmaDljOT8xkOIK9CPJsNDC4rg7dss9WrWICnSINzizO2lOD2RA3vJKwkGNLIShrsruIZ/+K9cI2ogVqLFr4EszaxTPthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bElAIKkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C45C433C7;
	Sun, 25 Feb 2024 10:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708857949;
	bh=xaEEwq+zhwXXlXUsjzZ1qKHdigMxUKVoFzGsp+eDLQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bElAIKkS0nZ5nI2Igh69rC7Xfk/xt7Sv1fU0GpVr6WHie65ArcfLGblmx6+f/eKmd
	 1pSeTX+oGvXb8s3DWKZG03NiGEHdFFSX/1jgRFPa/78p05yW8jC5DAwAZD1GaVUSXk
	 Y92kQYZ+TjMbOJNcWv1CPzKKjKWU02x1ncaGURW4=
Date: Sun, 25 Feb 2024 11:45:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: stable@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	Juhyung Park <qkrwngud825@gmail.com>,
	Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Subject: Re: [PATCH 5.10.y] erofs: fix lz4 inplace decompression
Message-ID: <2024022527-voicing-overbite-04be@gregkh>
References: <2024012650-altitude-gush-572f@gregkh>
 <20240224063248.2157885-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224063248.2157885-1-hsiangkao@linux.alibaba.com>

On Sat, Feb 24, 2024 at 02:32:48PM +0800, Gao Xiang wrote:
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
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Link: https://lore.kernel.org/r/20231206045534.3920847-1-hsiangkao@linux.alibaba.com
> ---
> Adapt 5.10.y codebase due to non-trivial conflicts out of
> recent new features & cleanups.

Both now queued up, thanks.

greg k-h

