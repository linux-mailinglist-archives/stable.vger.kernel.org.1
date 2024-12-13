Return-Path: <stable+bounces-104008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800FD9F0AA8
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B1B2813F8
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA9A1DD86E;
	Fri, 13 Dec 2024 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1dAqZRq0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA041BE251
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088515; cv=none; b=L2xdDUDbIDduwLiBwuOy1Bm6Jl8ktSTxTgeEYLPPLPJF90Qg2xFaDio6TNjaMuE5b9qu7kAehxUt5x9WqMBcKaP5tZf4QDX1qyScdNXWTemOQknWEm25kM3JJGB8roj5Fc1sWhgDB8yNvnr/8Cxwc/9awOzLbWaQRvvSywlylU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088515; c=relaxed/simple;
	bh=SYNM/f+g81kHUJfvtU64Te+tXwsfMoFcPTrMIUZ5000=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YthYi6x4c+RnXAYx0P8D4LetRSJBlNIgC6SB75OuGNuwPVMu75mpm1FvoLd6T7uuow+OCQycld9v5xs5ATHum40dRrpuV9m8i9oVIRyzLlHTFdQaMg4gmtNDDv54cLGPNU0e80VIktv7H+dPqbsWRi1TIyb0VzkksXr1fzJeWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1dAqZRq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA747C4CED0;
	Fri, 13 Dec 2024 11:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734088514;
	bh=SYNM/f+g81kHUJfvtU64Te+tXwsfMoFcPTrMIUZ5000=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1dAqZRq0ur4tMbJwbL6JmauvVeSDm6l1nzNH2w0AANgew+bx50aDvplJrUWvBj81t
	 Xzch8bycAMDPuDBx43BVw4i/WqE3ajqbnxAF6EcTYJzpbiahkxeJ6irdJ7MKfDfNm8
	 70ITCqrIoXDsL2/mdLO6wwqJtRCXl6ksa6KASuQ4=
Date: Fri, 13 Dec 2024 12:15:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: guocai.he.cn@windriver.com
Cc: stable@vger.kernel.org, peili.dev@gmail.com, dave.kleikamp@oracle.com
Subject: Re: [PATCH 5.15] jfs: Fix shift-out-of-bounds in dbDiscardAG
Message-ID: <2024121304-shortwave-upbeat-658e@gregkh>
References: <20241213054350.3113655-1-guocai.he.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213054350.3113655-1-guocai.he.cn@windriver.com>

On Fri, Dec 13, 2024 at 01:43:50PM +0800, guocai.he.cn@windriver.com wrote:
> From: Pei Li <peili.dev@gmail.com>
> 
> [ Upstream commit 7063b80268e2593e58bee8a8d709c2f3ff93e2f2 ]
> 
> When searching for the next smaller log2 block, BLKSTOL2() returned 0,
> causing shift exponent -1 to be negative.
> 
> This patch fixes the issue by exiting the loop directly when negative
> shift is found.
> 
> Reported-by: syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=61be3359d2ee3467e7e4
> Signed-off-by: Pei Li <peili.dev@gmail.com>
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
> ---
>  fs/jfs/jfs_dmap.c | 2 ++
>  1 file changed, 2 insertions(+)


Now deleted, please see:
        https://lore.kernel.org/r/2024121322-conjuror-gap-b542@gregkh
for what you all need to do, TOGETHER, to get this fixed and so that I
can accept patches from your company in the future.

thanks,

greg k-h

