Return-Path: <stable+bounces-19316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AC184E8B3
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 20:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C47AB2BD8A
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 19:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F397A3612E;
	Thu,  8 Feb 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DCXalARj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849728699
	for <stable@vger.kernel.org>; Thu,  8 Feb 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418484; cv=none; b=eIKRATTwyHKViqUFXzf2qtYWsupdAnv1RUz2PoDGfpkruYbUK6OwXQUn9suMLLQn6L68K/Qs+MFq49Rt4s9fMxiWXaHZJ5NchlvHBqXaTjZtNdfbXFDX8fK27vJ8s1RNZnt9OiInTYj0VOf/DF5TEHisUTnAS66lgTw21AnQE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418484; c=relaxed/simple;
	bh=NnYU8qEe5kZlLQ+tWzXSgZvB+BuAAeEdx9WZmAjZ1Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksSJkGNrGOHbKFogb5+o0+XkXXRZuxbXJXFlmtnA5ZUnXQJcD9Ym7q6HAmnjD6/sBN3qp26jK/9kyoqqj+w+ek6b9ZxseOO72R5y7gUI5hYqmZaNSuIcq6jpvTPvHBgAMNRAizUThqpWYUiyQC2Gr1k1OQnpSDwxFuOEtJwE0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DCXalARj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C744BC433C7;
	Thu,  8 Feb 2024 18:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707418484;
	bh=NnYU8qEe5kZlLQ+tWzXSgZvB+BuAAeEdx9WZmAjZ1Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCXalARjN22Gq2/ku6FyZ9YDYxGIa3EPZRzzAb0TTYIRz+ROrVoYiLP5aai9x+PSu
	 /JsfpW0psl7/idgbDA0DiJqeIRSqHrYeatrppizRlRx/d7mnh0tY9AoqZIgSfXOYJh
	 D1m3459EQJCl6eBA3XwyNotCT+T6o0RhsK6vPsdQ=
Date: Thu, 8 Feb 2024 18:54:41 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Apply e08ff622c91a to 6.6.y
Message-ID: <2024020833-flammable-default-afb2@gregkh>
References: <CANiq72mVfUT6VGcDqKGEEwNZo97pKq1roPMMk4qBvuq2tizwrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mVfUT6VGcDqKGEEwNZo97pKq1roPMMk4qBvuq2tizwrQ@mail.gmail.com>

On Thu, Feb 08, 2024 at 07:29:13PM +0100, Miguel Ojeda wrote:
> Hi Greg, Sasha,
> 
> Please consider applying commit e08ff622c91a to 6.6.y. It requires the
> following chain:
> 
>     828176d037e2 ("rust: arc: add explicit `drop()` around `Box::from_raw()`")
>     ae6df65dabc3 ("rust: upgrade to Rust 1.72.1")
>     c61bcc278b19 ("rust: task: remove redundant explicit link")
>     a53d8cdd5a0a ("rust: print: use explicit link in documentation")
>     e08ff622c91a ("rust: upgrade to Rust 1.73.0")
> 
> which applies cleanly to 6.6.y. This upgrades the Rust compiler
> version from 1.71.1 to 1.73.0 (2 version upgrades + 3 prerequisites
> for the upgrades), fixing a couple issues with the Rust compiler
> version currently used in 6.6.y. In particular:
> 
>   - A build error with `CONFIG_RUST_DEBUG_ASSERTIONS` enabled
> (`.eh_frame` section unexpected generation). This is solved applying
> up to ae6df65dabc3.
> 
>   - A developer-only Make target error (building `.rsi` single-target
> files, i.e. the equivalent to requesting a preprocessed file in C).
> This is solved applying all of them.

All now queued up, thanks!

greg k-h

