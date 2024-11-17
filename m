Return-Path: <stable+bounces-93737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E142B9D0615
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 22:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E12EB21F97
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A001DBB32;
	Sun, 17 Nov 2024 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQs9H4LE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69584A3E
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878010; cv=none; b=Uiqf9tKUJgrQGk3zgF10ZV3aEFbYSt8rM3Lj4jb4e2BWGYBcUgJEhEvA+eC/JK28/F88izbl5RAJB3EnJpIYwcdi+r+9bqqoZUNvBRXZdHXYXpuGVzujxBpMpDv/dI5FoYi701akYpiETK+6hBWExNdonhOq+WSVoPUrX8n+9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878010; c=relaxed/simple;
	bh=nEc9pGmzV2O30S8FZK3tGv5OwZdXJitUrPWWvLnuf1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjuUZI2CffNfamuQwfDNVWs7HzhaRXUuAcAwDtNSTr7C7zFCl7BQBYEN59uQQFdB1DK1K8ZIkQ8kV7BwpUxAaHh7UlhKNXBv7BHg+FlhXtirsgMdrJd6utvqeeKcaqMlLFTXWkvzXGGDGDTMoA7YnYYx2xbv/1O5M+LZEBa6Qvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQs9H4LE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D413C4CECD;
	Sun, 17 Nov 2024 21:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731878010;
	bh=nEc9pGmzV2O30S8FZK3tGv5OwZdXJitUrPWWvLnuf1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQs9H4LENqsV2vvsdsGplh3CWJqfbrQHDTyK+t57hskVFo4DD9VvPPQUdMa88WMDI
	 8SGEFLXQfWanq7FQZi0sEdZ2evZ0OA09tk4b/Ui4ou6Z8J+E6fNpI9wXn/8xGeDZ4I
	 ePu8nPT4LbyyC+diLYgHXiKeIjHyXyq+x5IVCK84=
Date: Sun, 17 Nov 2024 22:13:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: mmc: core: add devm_mmc_alloc_host (5.10.y)
Message-ID: <2024111756-blatancy-repulsive-c757@gregkh>
References: <b5016bde-5d0a-428d-9136-cbbc15f2d70f@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5016bde-5d0a-428d-9136-cbbc15f2d70f@stanley.mountain>

On Fri, Nov 15, 2024 at 05:29:38PM +0300, Dan Carpenter wrote:
> Hi Sasha,
> 
> The 5.10.y kernel backported commit 80df83c2c57e ("mmc: core:
> add devm_mmc_alloc_host") but not the fix for it.
> 
> 71d04535e853 ("mmc: core: fix return value check in devm_mmc_alloc_host()")
> 
> The 6.6.y kernel was released with both commits so it's not affected and none
> of the other stable trees include the buggy commit so they're not affected
> either.  Only 5.10.y needs to be fixed.

Now queued up, thanks.

greg k-h

