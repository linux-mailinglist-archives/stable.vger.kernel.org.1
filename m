Return-Path: <stable+bounces-186155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F96BE3CA9
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DCE5E00D5
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF7633CE80;
	Thu, 16 Oct 2025 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OmGPvwfd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C22E6135;
	Thu, 16 Oct 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622453; cv=none; b=mdXXqZw4Nb5peUzwGo7bcZJDkLo8DRk4EHj3+NIQTlqddPIvL7suKK/Vwe6no063tta+re2dU1V8oSrxwu92AcW3xIpgZKhEzHLe/RlWlKpoO7eSj/QY3aFv13KwT2mDNYomAN6Tzdpnor8dKZvTesHjpDKEWxp0YDxFzJfXyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622453; c=relaxed/simple;
	bh=22Y6S1BXOtAy3RcxX0ZOt/8AllGNdZVHUuA3OGZB44o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Euv526K5WQOY15asK2auoVVbGgsT1JR3RYaXw+38qdQBLxmM0Q1LCnfqcp1udSGgC9ikcYJ3bVxZ7Rl3MAm7DS0C66pya7blq44ACnrOcXwZ5axcS4bJ6sztsRciKkJGzccTF4n42dBjJ0PCwi7LqkjvsdVYV6LFJJS7afBc2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OmGPvwfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDDDC4CEF1;
	Thu, 16 Oct 2025 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760622453;
	bh=22Y6S1BXOtAy3RcxX0ZOt/8AllGNdZVHUuA3OGZB44o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmGPvwfdOB0eGfmNA85LOOYs7UZoiWl2gFkTrAPj7S58pm/cT6I6QmtCJLgmQB4wb
	 nDnf2bkZp7wBZBhu2y2ozN6+mzLhfbugW9YGxLa8iPTQxY5IWNFkLab9Rdmr0qx7y1
	 7hIIxSuTl/ayi2bs1PxuSFxzHaKbeOQ1llHS8yTQ=
Date: Thu, 16 Oct 2025 15:47:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rust: device: fix device context of Device::parent()
Message-ID: <2025101623-handoff-silver-92f7@gregkh>
References: <20251016133251.31018-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016133251.31018-1-dakr@kernel.org>

On Thu, Oct 16, 2025 at 03:31:44PM +0200, Danilo Krummrich wrote:
> Regardless of the DeviceContext of a device, we can't give any
> guarantees about the DeviceContext of its parent device.
> 
> This is very subtle, since it's only caused by a simple typo, i.e.
> 
> 	 Self::from_raw(parent)
> 
> which preserves the DeviceContext in this case, vs.
> 
> 	 Device::from_raw(parent)
> 
> which discards the DeviceContext.
> 
> (I should have noticed it doing the correct thing in auxiliary::Device
> subsequently, but somehow missed it.)
> 
> Hence, fix both Device::parent() and auxiliary::Device::parent().
> 
> Cc: stable@vger.kernel.org
> Fixes: a4c9f71e3440 ("rust: device: implement Device::parent()")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/auxiliary.rs | 8 +-------
>  rust/kernel/device.rs    | 4 ++--
>  2 files changed, 3 insertions(+), 9 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

