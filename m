Return-Path: <stable+bounces-188037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBE4BF0C84
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44B5F4EB1E4
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0831246783;
	Mon, 20 Oct 2025 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T+/gzaFU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D1208D0;
	Mon, 20 Oct 2025 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959036; cv=none; b=N+a+gv+1hcOkh6E1lInT8AUpTr9iBChvd/jdonOdSHwATbR4uZh6/X8uTcCuQnMOGHfidmBuyOIx9WavjUw7rjL0Rat5yvRdU0eIQ7OZL3F0+pA/UqcrEZdhDsXE9MHX1XMuSCnKFVmXwK5ij31spYXTkyMHTsxAOqPNRfBOCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959036; c=relaxed/simple;
	bh=TSbmKbsnr+avsjQaaO7wq/0jRqFL/RY167AdevoNFQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acW1/VD6g68kad3DoW8R0iBWNgwXs0FEyrZj3lXQ/QdXFqMuOnmjrS4PCNmkMpfFHDOnzPwuFmEyIl3JKul0Fd555w6qJbo7hiGtmX8iL5EKG0UOCd5NvIFllsBo+Y/XX3rjs3ZGw9GOAIIEQn9jVKPg0TxhW+FW6YMMhLtHOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T+/gzaFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B32C113D0;
	Mon, 20 Oct 2025 11:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760959036;
	bh=TSbmKbsnr+avsjQaaO7wq/0jRqFL/RY167AdevoNFQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+/gzaFUI/5qXMrR+Ex4Rn67ne7yv//C6OyMcA3Jc5ad69gm4sDsuUdk+ycejc5qd
	 Cj9bKQcErNjiZNbVeITNp/g4gJA9BuGPjulpoYV/1b1yVMf3F3Pyo1kVOG+QnjMkrA
	 CgncLTbyrKXfk7eBIee1OQM2DGJ8dC3J3XJzI5jI=
Date: Mon, 20 Oct 2025 13:17:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: stable@vger.kernel.org, tglx@linutronix.de, Julia.Lawall@inria.fr,
	akpm@linux-foundation.org, anna-maria@linutronix.de, arnd@arndb.de,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, luiz.dentz@gmail.com, marcel@holtmann.org,
	maz@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
	sboyd@kernel.org, viresh.kumar@linaro.org
Subject: Re: [PATCH 6.1.y 00/12] timers: Provide timer_shutdown[_sync]()
Message-ID: <2025102001-unlaced-playroom-f60b@gregkh>
References: <20251010150252.1115788-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010150252.1115788-1-aha310510@gmail.com>

On Sat, Oct 11, 2025 at 12:02:40AM +0900, Jeongjun Park wrote:
> The "timers: Provide timer_shutdown[_sync]()" patch series implemented a
> useful feature that addresses various bugs caused by attempts to rearm
> shutdown timers.
> 
> https://lore.kernel.org/all/20221123201306.823305113@linutronix.de/
> 
> However, this patch series was not fully backported to versions prior to
> 6.2, requiring separate patches for older kernels if these bugs were
> encountered.
> 
> The biggest problem with this is that even if these bugs were discovered
> and patched in the upstream kernel, if the maintainer or author didn't
> create a separate backport patch for versions prior to 6.2, the bugs would
> remain untouched in older kernels.
> 
> Therefore, to reduce the hassle of having to write a separate patch, we
> should backport the remaining unbackported commits from the
> "timers: Provide timer_shutdown[_sync]()" patch series to versions prior
> to 6.2.

Thanks for doing this, all now queued up.

greg k-h

