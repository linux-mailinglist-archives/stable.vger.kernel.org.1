Return-Path: <stable+bounces-20551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1F85A807
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8114B23F80
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FD73A29A;
	Mon, 19 Feb 2024 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yoW9aPZt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139533308A;
	Mon, 19 Feb 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358452; cv=none; b=o8sO9cpaMAItgVk36DZG5nwK0kfUuyDlpgjxvorr9dwHWy/rIA1MYqjGtwvIjJ0SXtYARgv5r9U70dsMwtzHFOhHAwWGUD9FiHD0YlHH1Jv4GecNi0XH0z8DTbBUxWql31SvMWGIoc8Jz1xr099zl6e7kL0XtcyCct+MlMYEJrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358452; c=relaxed/simple;
	bh=XrQRGn6VBlAeXKrkMPyzXVTh0fuJumVoCgYU7KdWSRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYr36uFW5EeAk5R1hkNXwDd0x+xRNRnFbVdDg0FiYgqAV/KEMd2sUS2kzUp0yO05OqRrZjbA6Q9XDo4mVsfuMU9/tP9HwHi4BSXprlfoYNyHrxd60gOKf7rZ8estkkrNABeN23NALgUpS1Wp9hT25a8z6ZxNywfPXTgXwcXQPh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yoW9aPZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B92AC433F1;
	Mon, 19 Feb 2024 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708358451;
	bh=XrQRGn6VBlAeXKrkMPyzXVTh0fuJumVoCgYU7KdWSRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yoW9aPZtQgpBhlcHVIp/2CQKcryMe13IXxYVUuG2XtUEJAFYlAiGmyWYowy3omzN2
	 DXWkZuu0XaMTSlaOTFd9oem712pAnUw+eC+vy8iL6aMmxDQGS9zd7gcGTtgq7fGtF5
	 ZmFsCFcKP7i1tRYz6HJxhkH3LLNW8Orew8kkSXEw=
Date: Mon, 19 Feb 2024 17:00:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Paasch <cpaasch@apple.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>
Subject: Re: [PATCH stable] mptcp: introduce explicit flag for first subflow
 disposal
Message-ID: <2024021938-charbroil-riddance-30e5@gregkh>
References: <20240129173829.62287-1-cpaasch@apple.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129173829.62287-1-cpaasch@apple.com>

On Mon, Jan 29, 2024 at 09:38:29AM -0800, Christoph Paasch wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> This is a partial backport of the upstram commit 39880bd808ad ("mptcp:
> get rid of msk->subflow"). It's partial to avoid a long a complex
> dependency chain not suitable for stable.
> 
> The only bit remaning from the original commit is the introduction of a
> new field avoid a race at close time causing an UaF:

Thanks, now queued up!

greg k-h

