Return-Path: <stable+bounces-118660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668EFA4098A
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EA6703D58
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7694419DF61;
	Sat, 22 Feb 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E5aLz22E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94B3224
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740238797; cv=none; b=nUffOlHLXOvuhZxR7Tk0mK2P8VND5tfpfiDkaKuohXFHFWF2GibTwWRbZYV7xemLv4VACCGdwI8/Ro/qKrv/i5bhEJRfJjuOXB0KxTVHG70zops0O+/eT/t69UTRxgZmM/8c0Bm9qleT2NAkB4HADqpeV1wykjYCnLzWxnAl9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740238797; c=relaxed/simple;
	bh=Mo3O7K93QkVZa8/8o/d7LnyjBjcBez6980ZKXAlh03I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvqVKemWNp7T2a2OGX+XpRzaY0JNUyICioYPUp/q6gy6EwN/e9Nnq4bSIeKtCPCudtRgBiRaNkGMuvzkZdRhJaYy4hOtCgfEnBRZjxM3Z2ewyQgxncruJSlO8CqUhqDilgfoyq9hqY1Nn0e5N6ALW9llfnfir7R9jBYz2nn02EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E5aLz22E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDF7C4CED1;
	Sat, 22 Feb 2025 15:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740238796;
	bh=Mo3O7K93QkVZa8/8o/d7LnyjBjcBez6980ZKXAlh03I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5aLz22EMO9tJL8EfDqs2fGvJnAbW1otrt9/2QcGurZiiXMplUcBmS6qg41AwS6o4
	 PBxFzQjAn27bu7ODSwm77ZgdpW4jNxfM970YM5ddiaWULDSEuCwLoHR2Go/wPd4w8Q
	 x3GRK6OzllxFz1SGhy5oHU0ybetKwG5AxRYawrRA=
Date: Sat, 22 Feb 2025 16:39:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	NoisyCoil <noisycoil@disroot.org>
Subject: Re: Apply 3 commits for 6.13.y
Message-ID: <2025022246-limit-armadillo-8340@gregkh>
References: <CANiq72kaO+YcvaHJLRrRw1=KteApRnRM0iPuSwgFkaCf2BR01w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kaO+YcvaHJLRrRw1=KteApRnRM0iPuSwgFkaCf2BR01w@mail.gmail.com>

On Sat, Feb 22, 2025 at 04:12:56PM +0100, Miguel Ojeda wrote:
> Hi Greg, Sasha,
> 
> Please consider applying the following commits for 6.13.y:
> 
>     27c7518e7f1c ("rust: finish using custom FFI integer types")
>     1bae8729e50a ("rust: map `long` to `isize` and `char` to `u8`")
>     9b98be76855f ("rust: cleanup unnecessary casts")
> 
> They should apply cleanly.
> 
> This backports the custom FFI integer types, which in turn solves a
> build failure under `CONFIG_RUST_FW_LOADER_ABSTRACTIONS=y`.
> 
> I will have to send something similar to 6.12.y, but it requires more
> commits -- I may do the `alloc` backport first we discussed the other
> day.

All now queued up, thanks.

greg k-h

