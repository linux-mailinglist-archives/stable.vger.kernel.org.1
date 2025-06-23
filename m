Return-Path: <stable+bounces-155299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6071AE35C8
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FB23AF1EE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 06:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97D21DED4A;
	Mon, 23 Jun 2025 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RbhJ0y1Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5FBA33;
	Mon, 23 Jun 2025 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660580; cv=none; b=Dz+hM/nyNHptgvAy2FjiePd5x49P5TGed56OIHMc+o36sHfFc87UVCBjIgwANNu++X+sqM7UNj+L8j9brhvkuimOsAMSpKyqDn0lInITfBvczfPndKcjxxbH/sYi/2zQROBsemyOMw8ESNVpYBv2gxvW7V5gQkHFLwZTt+7FeTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660580; c=relaxed/simple;
	bh=8b+HPIK6yQZ/vLRYSKJsS1JqmZCJLFPN2lhsJM8Jyzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGpZQBhnLUsHZXow9xUW69juWx/uDqBH0z53UxSrP3EAF8ZC3wDl6OKvA8f8sUne+LbEpUoLKvwgU0CHHKkAD0ZMBPgQZCfZXzpgrFNuCnsUs3iSHYcImB1zKHWvfa558f2Rhm5KAlR7vx8OBFmgiZyAfxq5hcy4+WdFKgSUYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RbhJ0y1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC4AC4CEED;
	Mon, 23 Jun 2025 06:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750660578;
	bh=8b+HPIK6yQZ/vLRYSKJsS1JqmZCJLFPN2lhsJM8Jyzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbhJ0y1ZHtKN2wgPY3Z/gM7unGcI6MuZrgm0uRYeonIMcWRjbjse6/Er77Ex8lEaU
	 G0dnUeh3mb1tRs4nM8SHJopybMi/ShOsFmDv1PmZuyRmiuilgYj/Ii/v1aw5lbRGay
	 RyGrlgi462xWkx8c3xBmQwUwpzzPHn7l8I9IhvjM=
Date: Mon, 23 Jun 2025 08:36:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Aaron Kling <webgeek1234@gmail.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 6.6] Revert "cpufreq: tegra186: Share policy per cluster"
Message-ID: <2025062347-snaking-daytime-b878@gregkh>
References: <20250605125341.357211-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605125341.357211-1-jonathanh@nvidia.com>

On Thu, Jun 05, 2025 at 01:53:41PM +0100, Jon Hunter wrote:
> This reverts commit ac64f0e893ff370c4d3426c83c1bd0acae75bcf4 which is
> upstream commit be4ae8c19492cd6d5de61ccb34ffb3f5ede5eec8.
> 
> This commit is causing a suspend regression on Tegra186 Jetson TX2 with
> Linux v6.12.y kernels. This is not seen with Linux v6.15 that includes
> this change but indicates that there are there changes missing.
> Therefore, revert this change.

But this is the 6.6.y tree, not 6.12.y tree.  So is this still a
regression in 6.6.y?

thanks,

greg k-h

