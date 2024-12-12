Return-Path: <stable+bounces-100901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B79EE628
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 13:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BC71889193
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121B1212D66;
	Thu, 12 Dec 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBfsFa6T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A0B212B29
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004839; cv=none; b=Y6yUWgG29/PCzVwJwH8PAwz6gNxo4zWIF5YzD/+vhZ9qOqwlAJnhBg7pYZN7GwpH38YwGEWyX03hSJSCW+vnGAMC5nCllXkh4unS3/HOE5sxQM5N0BrCFcRmQtKfx9XimmO67rS3cOK4rhtnIuzno1EiZ2L9XK7cDSE/jU2DUQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004839; c=relaxed/simple;
	bh=uh2EBzreshuOh5xCHWfNE63+Y57d2xGVDa0C+v4HnRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3qJDTZpwAM3xhDQGDy9NtecUn9LzpzJhjlGFEhzOnlnCKxF7Zcaj9SgKSTjHfb+Uw62ABfydT46P/esASWNT7u3jbAZ4b7IVBN3oxZvp9RB29hGKw7ncZ7fHOnJ5Gn2AOuTqk5be9ONH2cpqyx4l7i+52BEa0t3o3aiSEJqy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBfsFa6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6489C4CECE;
	Thu, 12 Dec 2024 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734004839;
	bh=uh2EBzreshuOh5xCHWfNE63+Y57d2xGVDa0C+v4HnRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBfsFa6T6Fd/nPnI2msExrEY7ZwhJf+r/BJfDhVzv/PdOD1XV2LL2RzcJsnUKV0PY
	 1Nx0h8Is11fRWMTssb1M6r12yFL7+SbRKq7PMPjNLSrFqjkkCybszykefBNE6+TxJB
	 fKM010MLZ7GFLXZcrTiZtK1aG2EX7eH5fvWoBHoI=
Date: Thu, 12 Dec 2024 13:00:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, pkaligineedi@google.com,
	hramamurthy@google.com
Subject: Re: [PATCH 5.15 v2] gve: Fixes for napi_poll when budget is 0
Message-ID: <2024121214-surplus-imitation-df99@gregkh>
References: <20241210235914.638427-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210235914.638427-1-ziweixiao@google.com>

On Tue, Dec 10, 2024 at 11:59:14PM +0000, Ziwei Xiao wrote:
> Netpoll will explicitly pass the polling call with a budget of 0 to
> indicate it's clearing the Tx path only. For the gve_rx_poll and
> gve_xdp_poll, they were mistakenly taking the 0 budget as the indication
> to do all the work. Add check to avoid the rx path and xdp path being
> called when budget is 0. And also avoid napi_complete_done being called
> when budget is 0 for netpoll.
> 
> The original fix was merged here:
> https://lore.kernel.org/r/20231114004144.2022268-1-ziweixiao@google.com
> Resend it since the original one was not cleanly applied to 5.15 kernel.
> 
> commit 278a370c1766 ("gve: Fixes for napi_poll when budget is 0")
> 
> Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> ---
>  Changes in v2:
>  * Add the original git commit id

In the future, please add it in a way that we can figure it out (see the
hundreds of examples on the mailing list for how it is done.)

thanks,

greg k-h

