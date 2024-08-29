Return-Path: <stable+bounces-71529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5828964B77
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846A1281D8C
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE021B2EF9;
	Thu, 29 Aug 2024 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HioPLcVT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02834DA14
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948262; cv=none; b=tpYRQrL6/lCuz0btnKiuyjsaVXjyrDnrHT1n/qLXb4BL6G8uumW6naYHMfQNowQZl2gr/gFtWHqEcdt1hH2ZnXs3J2gkKG/UACi4ah488k3yQ61YdLAioj/EPZN0lmgqSTutVj2gaESBXdj1/I5PZte/j5EhYALa4mxIUe4aCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948262; c=relaxed/simple;
	bh=uI3fhOdIkJqZZ/0SyocXr0nunsHjKM8f+IIsrcCFrEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhoXtX8T02I06eAOH4luaQ0DAk7NJeDk9XaN868NzSDPuAK+J04d9cb/KtLA9kJy0BAX8ekc83SCh1k/MT4fTOqf6BNWOCF5F/0/ZtWPsyW4LsOkxR5XQW8yiAcCqxnk6DraySFn/BtsKMXEUQMBbQ+/fmL/FHxAoKqAti7LgGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HioPLcVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1065C4CEC1;
	Thu, 29 Aug 2024 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724948262;
	bh=uI3fhOdIkJqZZ/0SyocXr0nunsHjKM8f+IIsrcCFrEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HioPLcVTAWzguEEbPCS9lo8yWxkNLsG8s8tsn9bShPL+c5C3XiMNsKXWn00bi2NWI
	 tqe8BiQwdVh4HTQWb7HfhlRxx7qE8S57zTlJrWuga7hhUMm+l9s8a9wbu+mnpd5BaW
	 SPsWR3zNf0m45duTgK33YlJNWBXymdFITcaEvarY=
Date: Thu, 29 Aug 2024 18:17:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Anders Blomdell <anders.blomdell@gmail.com>
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: Fwd: [PATCH 3/9] xfs: xfs_finobt_count_blocks() walks the wrong
 btree
Message-ID: <2024082928-unguarded-explore-0689@gregkh>
References: <172437083802.56860.3620518618047728107.stgit@frogsfrogsfrogs>
 <25fab507-bf7f-446f-9ea1-cec08e9ebf1d@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25fab507-bf7f-446f-9ea1-cec08e9ebf1d@gmail.com>

On Thu, Aug 29, 2024 at 02:08:37PM +0200, Anders Blomdell wrote:
> Dave forgot to mark the original patch for stable, so after consulting with Dave, here it comes
> 
> @Greg: you might want to add the patch to all versions that received 14dd46cf31f4  ("xfs: split xfs_inobt_init_cursor")
> (which I think is v6.9 and v6.10)

What is the git commit id of this in Linus's tree?

thanks,

greg k-h

