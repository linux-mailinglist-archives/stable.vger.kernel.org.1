Return-Path: <stable+bounces-81559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE5994555
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7D91F26175
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BF41991D5;
	Tue,  8 Oct 2024 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KyMYLYbW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5021779B1;
	Tue,  8 Oct 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383207; cv=none; b=RFjf2HM/sAFRBW+w7Q2I/6aGz7Jzd5IR2qbp+xW1R8OuIc+Wd51HRNVtOeg0m4Xl8z4izAHlS27/fJ2SNK8ynW4UH+p06aTCbIIssUkeMVIC8hOpqoEq8L0MGA2FOOORDD6ULjkTyS3UMw6UnP6DERazUsczynOBbusxJZF7vEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383207; c=relaxed/simple;
	bh=VOWj/ElEg+xJ7SgTIJkX2eslYN+7n8APMcouViACqhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKCyjp6lrH9WNaZtCuuyCbE/QSpl96NPVTxdgsl/7b/xjcWLQN1EVQ9REODpaMJypSp3NCP0xlZP3mSL39HYs8/BZS4Pgx/l8maVMQQJhBZytO7d8VIJ+kBb/18bPbI3LnQUNoKHtTVg/YHE306F0f2SPnIqjZXq8coBzIfPQGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KyMYLYbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FED8C4CEC7;
	Tue,  8 Oct 2024 10:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728383206;
	bh=VOWj/ElEg+xJ7SgTIJkX2eslYN+7n8APMcouViACqhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KyMYLYbWGKxKrms3/FiRt+LplHUgSgYyuPZZRrElIgWhfnpiei8oTiGItxR37Awdm
	 k502SHHPaH4/AHsYLM+jjjYWcwWYjCaZx0e4lcSqIOZo5jGVti/Kgtw0y4Onc+c7CN
	 YZkqyvHB47BSdNuyDnRQiLhg4qYHhDbXbBN+pleY=
Date: Tue, 8 Oct 2024 12:26:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: stable@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.1.y 1/5] erofs: get rid of erofs_inode_datablocks()
Message-ID: <2024100829-unplowed-vending-675b@gregkh>
References: <20241008065708.727659-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008065708.727659-1-hsiangkao@linux.alibaba.com>

On Tue, Oct 08, 2024 at 02:57:04PM +0800, Gao Xiang wrote:
> commit 4efdec36dc9907628e590a68193d6d8e5e74d032 upstream.
> 
> erofs_inode_datablocks() has the only one caller, let's just get
> rid of it entirely.  No logic changes.
> 
> Reviewed-by: Yue Hu <huyue2@coolpad.com>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Stable-dep-of: 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
> Link: https://lore.kernel.org/r/20230204093040.97967-1-hsiangkao@linux.alibaba.com
> [ Gao Xiang: apply this to 6.6.y to avoid further backport twists
>              due to obsoleted EROFS_BLKSIZ. ]
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Obsoleted EROFS_BLKSIZ impedes efforts to backport
>  9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
>  9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
> 
> To avoid further bugfix conflicts due to random EROFS_BLKSIZs
> around the whole codebase, just backport the dependencies for 6.1.y.

all now queued up, thanks.

greg k-h

