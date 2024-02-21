Return-Path: <stable+bounces-21795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E97385D2D8
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 09:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE09285D1B
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 08:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A47C3B793;
	Wed, 21 Feb 2024 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M09DeEGv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DC3CF46
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505432; cv=none; b=VQ59ewgciqjYuxwU9tnQy0awUe5eYjtY0k4etU8Agq9RTYbYUNajjCqfeUgs+0pwQNVracs6VHMxLPal6VP9qwMMN7J+ekGyLUDm14HzO6wZQHsSF/th/NS/O36OgoeiSDwHS2Ybu/WYY0w8qrDochBIF6JzfT2h5HpJMoxQvIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505432; c=relaxed/simple;
	bh=gKDscZBweOwp0nbcrsrzE/SazZ/sJA4Q/hYs8vQaUpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfqxPsXxRh30LVqamjNyOklBDd9b1/YiSHFDFn1zCGZz83tPtfIxFdpYn1DCtfxHLPK3Lk3W7LCbfPYPrLFUsKagFnC4j5dVmNpmJ5W2EPWZ1Gr9sDSgWbAnMkDIocCIum52JKUvwGx/ATwVz1HBv9PuxL3D/6IpUaFNzmHxrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M09DeEGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B129C433C7;
	Wed, 21 Feb 2024 08:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708505431;
	bh=gKDscZBweOwp0nbcrsrzE/SazZ/sJA4Q/hYs8vQaUpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M09DeEGvTGwbM+8mFcpE8Rvpj6zKy4UzM4Y90qrDiIFxp5W4/1Pyv9SfPwk+Pzlf6
	 /ZQOP/HbZG1Igedwie5y8Zf1XTCRjpMx1IDERZKH62mUyrM46NCC3vG+o86W3wGVxm
	 1/5Hdk4/tY64W3fs0sKvyQMmsPgydx3H9v8P7TOQ=
Date: Wed, 21 Feb 2024 09:50:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: He Gao <hegao@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1] Backport the fix for CVE-2024-23851 to v6.1
Message-ID: <2024022153-onyx-shindig-26ac@gregkh>
References: <20240220232339.3846310-1-hegao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220232339.3846310-1-hegao@google.com>

On Tue, Feb 20, 2024 at 11:23:38PM +0000, He Gao wrote:
> This is the fix of CVE-2024-23851 for kernel v6.1.
> 
> Upstream commit: https://github.com/torvalds/linux/commit/bd504bcfec41a503b32054da5472904b404341a4
> 
> Changed argument name "blk_mode_t" back to "fmode_t" for the old version. The argument
> is not affected by the patch.

What needed to be changed?  The original applied just fine.

And what about 6.6.y and 6.7.y?

thanks,

greg k-h

