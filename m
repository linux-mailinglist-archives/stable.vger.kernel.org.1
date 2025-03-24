Return-Path: <stable+bounces-125936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A95A6DEF0
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80950188A3FB
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2D3261386;
	Mon, 24 Mar 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="REeHxGFN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B96B25C6FE
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830901; cv=none; b=r7qjpBpLA9GY6W0zuyU6mdm12t3glqlmvlk1bnCBQm/SSU6s5dW2tA3r63pC1OhrTINICYGpbHLaP4Qh/YoN6fEecGpziZHIBj2cFKD85yrii/mrtgOLS3d5GXyxQExIDRiV6VnqoiOjXA6goPjPqzfg5fTGXeHbnvv6BeNYMjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830901; c=relaxed/simple;
	bh=QVTm47hCWyFpTi7vNG6nBqh3kzQ9FkVlnlHOizho6o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KogKlsfPqAesGrrH3flnjO/Gadx8SRMn7EtwukLiFfQanhVK//dN/gG5EL2DjSiuuaGe8jmVHqm4gW1hUMjEsgKuM4DLFflrdi0HJLJsGa0Wrcj3lG2DLvSPEJtjqoy1+PzkGTiug8lhSSrZfznWApPHxnSSiI59NMlXksi3+ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=REeHxGFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10F4C4CEDD;
	Mon, 24 Mar 2025 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830901;
	bh=QVTm47hCWyFpTi7vNG6nBqh3kzQ9FkVlnlHOizho6o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REeHxGFNeTlMIyQLaiFBihW0pxIxwFaWo9TmYTzWjLOggmizErb7rlVMaX6MS00Mn
	 UmvNrzZ2oDXJZslfiZ0d+Q+IfnEbLAaJf06kRciVYEp79lVqwLCY1OpIJMRGSGpBH7
	 Anpy0yWH41Al0/3KLuzTxnyf6E8rCBazKozzzKH0=
Date: Mon, 24 Mar 2025 08:40:18 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
	clm@meta.com, ct@flyingcircus.io, david@fromorbit.com,
	dhowells@redhat.com, dqminh@cloudflare.com, kasong@tencent.com,
	ryncsn@gmail.com, sam@gentoo.org, stable@vger.kernel.org,
	willy@infradead.org
Subject: Re: [PATCH 6.1.y] Revert "xfs: Support large folios"
Message-ID: <2025032453-knee-apron-a85e@gregkh>
References: <CAHk-=whVD8B=jJveFQGggyHD7srr_43aR96qZicETSNBJ65Akw@mail.gmail.com>
 <20250324030231.14056-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324030231.14056-1-laoar.shao@gmail.com>

On Mon, Mar 24, 2025 at 11:02:31AM +0800, Yafang Shao wrote:
> This reverts commit 6795801366da0cd3d99e27c37f020a8f16714886.
> 
> Even after resolving the page cache corruption issue [0], problems persist
> with XFS large folios. Recently, we encountered random core dumps in one of
> our Hadoop services. These core dumps occurred sporadically over several
> weeks, and it took significant effort to pinpoint XFS large folios as the
> root cause. After reverting the related commit, the issues disappeared
> entirely. Given these issues, it seems premature to adopt large folios on
> stable kernels. Therefore, we propose reverting this change.
> 
> Link: https://lore.kernel.org/all/20241001210625.95825-1-ryncsn@gmail.com/ [0]
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  fs/xfs/xfs_icache.c | 2 --
>  1 file changed, 2 deletions(-)

I need this to be acked by the xfs stable maintainers before I can take
it to the 6.1.y tree.

thanks,

greg k-h

