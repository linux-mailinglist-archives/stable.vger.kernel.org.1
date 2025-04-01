Return-Path: <stable+bounces-127344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0677BA77F83
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 17:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 497807A484C
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1D920C037;
	Tue,  1 Apr 2025 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTyDpid+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A69620B7E1;
	Tue,  1 Apr 2025 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522635; cv=none; b=EmK0wEu2xttIhz8Xs1RBgHwmGypFIxl7OTIbcTHLLRW7EgXQ1BvqrBQ/YIcNWsrMl6ferdj6FZg1KHsFNc46iMXsI2QbIhx+evrANj6x5JoXmS/pq707hx8nSwV3mwhsaVTEZYtyuQGU4YJdfxoArzyGw9OOhNalAoqPNnwvsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522635; c=relaxed/simple;
	bh=gYoukKHnDUOM6u2YKu1ZpCRz3rOvp1lz5uAnmvY09/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj7NBh37JM4ayWt8LiARKuj9HCbQer3ECNcZXcfTKplZHw6S8c87/WKS9CYVMsUNoI0uN4NGyfTDaYCgE7GheZHuda47+iOrl9HIrXS04rgcD2tWC0hgjMgakB9yLxcyqJnniqDnCW9bpe8dq7XzsX4dbT6kOoJ6is+YRDBVt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTyDpid+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9D4C4CEE5;
	Tue,  1 Apr 2025 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743522635;
	bh=gYoukKHnDUOM6u2YKu1ZpCRz3rOvp1lz5uAnmvY09/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sTyDpid+KeK5rLPbVBILu5FqsB3JOGpe3xSlVjHKIjh0C5XxjeBN77pXmiaKf/Ume
	 TPgBOS13AOkCISAdnej8KC10cpi3lwa6OP8IvGnDhI7jfQS0uk0pSsMiltzg88CqQC
	 qf4vV3TXv1MFuo4fx9EUfYL99dbl99/tz5SfLYfqtT3Ax7FrIi+QFvls4f8mnpgJur
	 RFWA5Vg6xtUMfb4xdqa0DAdfTllZyDTbiYJwBT26NHjq0AO9dfc1yPPuJAtX/8g472
	 kMeBIbFVBjywa/9bhTg0XNpzTDZ9+nrmJPDxWJ/p2jNZRpliXFxN/sahVhLlYhy2m/
	 p1Gz2dAb3hk0A==
Date: Tue, 1 Apr 2025 05:50:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] kernfs: fix potential NULL dereference in mmap handler
Message-ID: <Z-wLSic0zBiCDrkC@slm.duckdns.org>
References: <20250401151859.2842-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401151859.2842-1-vulab@iscas.ac.cn>

On Tue, Apr 01, 2025 at 11:18:59PM +0800, Wentao Liang wrote:
> The kernfs_fop_mmap() invokes the '->mmap' callback without verifying its
> existence. This leads to a NULL pointer dereference when the kernfs node
> does not define the operation, resulting in an invalid memory access.
> 
> Add a check to ensure the '->mmap' callback is present before invocation.
> Return -EINVAL when uninitialized to prevent the invalid access.

I think that's already checked through KERNFS_HAS_MMAP.

Thanks.

-- 
tejun

