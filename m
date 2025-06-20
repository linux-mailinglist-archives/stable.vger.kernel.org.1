Return-Path: <stable+bounces-155161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F77AE1F3A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671674A0CBB
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5B12DCC13;
	Fri, 20 Jun 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LbrOdfGm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5192D5434
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434265; cv=none; b=qlYbjPsxtXUh6PFL4gcs1bmZ6WciqPSbF6mhyGfODlY3dgQgCfsijGaMmloiQVst6PG1DttBWuMPJRFYO8llKhTqTFmVFLmK68JqknOm7T8ZEZsHNynQMcjLZD180ixgPAHKVHPrwdsuFClZxND9CBQBgaKeX/R5jxYpm/DqWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434265; c=relaxed/simple;
	bh=4aY1f3YplQpBbkKu2WUnkfs5UjAYv/8vKMlGN25xAKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwNXuCpZgOdiW4H9bI4QYoAVLDgHQSgwwM960HL7b/BDvhmp7R5yBEbsB3ONicLRHtNYnJCzPLd4jGaoZzs1KtQBn/zng8Jpr8UCRLs0PXdmVJlTIRQVAIPtgHceyQr8hmRNBiMin99r6P7TrmZHZh2PgeCVJFJ8tkz8LCXSEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LbrOdfGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E8BC4CEE3;
	Fri, 20 Jun 2025 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750434265;
	bh=4aY1f3YplQpBbkKu2WUnkfs5UjAYv/8vKMlGN25xAKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbrOdfGmQTvkWNXIJHLChJGklIi0RV10zjWgrl7L0ahDMofqAMrn1/P7nPhNLPBcL
	 VBV56E+srYwBGGJt+MFYLIJuevcOQnyBC3sdl/a87Mv5q8nvpYJjwrvJyQxTCSstgZ
	 LhIrkYLq4h3Jp0Rt/dWMMZ6PMGNjYMeDOQ/zxttA=
Date: Fri, 20 Jun 2025 17:44:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Airlie <airlied@gmail.com>
Cc: stable <stable@vger.kernel.org>
Subject: Re: two nouveau patches for 6.15 stable
Message-ID: <2025062013-grew-cloud-68b9@gregkh>
References: <CAPM=9twiDpukMfKMOqSLXGHDfnQxGFjNnau1_XRt8pueL4MkoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9twiDpukMfKMOqSLXGHDfnQxGFjNnau1_XRt8pueL4MkoQ@mail.gmail.com>

On Fri, Jun 13, 2025 at 04:08:50PM +1000, Dave Airlie wrote:
> Hey,
> 
> Can we please get
> 
> 4570355f8eaa476164cfb7ca959fdbf0cebbc9eb
> Author: Zhi Wang <zhiw@nvidia.com>
> Date:   Thu Feb 27 01:35:53 2025 +0000
> 
>     drm/nouveau/nvkm: factor out current GSP RPC command policies
> 
> a738fa9105ac2897701ba4067c33e85faa27d1e2
> Author: Zhi Wang <zhiw@nvidia.com>
> Date:   Thu Feb 27 01:35:54 2025 +0000
> 
>     drm/nouveau/nvkm: introduce new GSP reply policy NVKM_GSP_RPC_REPLY_POLL
> 
> Into 6.15 stable they fix a major regression in suspend/resume on nouveau.

Now applied, thanks.

greg k-h

