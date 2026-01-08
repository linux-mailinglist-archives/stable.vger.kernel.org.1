Return-Path: <stable+bounces-206317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0D0D03946
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 15:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7510C3021958
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8664A2E0B;
	Thu,  8 Jan 2026 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="saRz9EMw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5648695D
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870444; cv=none; b=AZjdyTDSMTNCNwxUiHCtj4fy7knmap0QrMB9SJqZsb3qoSLhFa0yiF/0SnneOLdBewTYBBP/gaqbkk2DbIl0PvHpJTXbj7wMN6SbyWg0vWXFYPB0EcmKZhFNzTryT68rak6UcQCQpjPy0s0nFf19sW4HjDQJvBAExJUGPfyy2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870444; c=relaxed/simple;
	bh=liq+GdjYI0by+wF9p0Fa+ty1m6hASgGa1b5yDXI+Pd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWS8GnZa67ZRyBvpDyi1zGIyVfCIZh2SuBCu7xfrhKoTWQtiuOfD1yzsgg2dX2OVVdpNwsCOEKLQ7pTsCT3XxXXSH6z/d0+zaMRvxsuGyNXebjvk1OPHbOieve2SYEL0vNXL6CjRBy2Oa6wYINkeU6t7DBwlGo/n/cryhrGTos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=saRz9EMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6226EC116C6;
	Thu,  8 Jan 2026 11:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767870443;
	bh=liq+GdjYI0by+wF9p0Fa+ty1m6hASgGa1b5yDXI+Pd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saRz9EMw/LHtksXCEnkmUeXGIJS08Nfk2A0/kPZoaFpkJInGAxFuy9gjS51/IYp69
	 6N1y9pBBIIyjTd+w55DgiNGi6h8jX0WcCgW16mIsmlsfyP6bPvzw1h9UQlQFky8aGB
	 jX0+UvvepvM4q7lNKwF2pLVSSEkPEMdGi1+t2j30=
Date: Thu, 8 Jan 2026 12:07:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [6.6-stable 0/2] mm: two fixes for bdi min_ratio and max_ratio
 knob
Message-ID: <2026010849-omission-sublet-23e3@gregkh>
References: <20251211023507.82177-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211023507.82177-1-jefflexu@linux.alibaba.com>

On Thu, Dec 11, 2025 at 10:35:05AM +0800, Jingbo Xu wrote:
> Have no idea why stable branch missed the "fix" tag.

Because that does not guarantee a patch will ever be backported.  See:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly in the future.

thanks,

greg k-h

