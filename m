Return-Path: <stable+bounces-114888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E88A30844
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C72D164595
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F1E1F4295;
	Tue, 11 Feb 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P6M8u9KX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0326BDA9
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268996; cv=none; b=e85nOTHQ7AN3tJdj72Y2RbV37Cg8WszbGTvM4ixDtSuL+XJtxFTClWGKgZFjYulPVmZlphMYiQzagWplg7DBr2LNJK4pV5a+HGOKacuCXmXeJZhrdgaZnx+F/RaZdTl6Z+abM/f0IVCyfPs9/UxCbVFOdc+UevtCRPE5K6nx4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268996; c=relaxed/simple;
	bh=3YjnxZWY8+A1CAXtu2lP+qXrvfKYEdhi2W8nLLgHgZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ova0SVh/KcrqwY2RY5x0sSm/fMIaEGyYtaww8FLZhU/dP/XdHiHjTbEToz6tfrbJfPY0xoX46GbTyO6N7Z0Mfc3Wgg6WXT2rJNjBYu74O7LRJdUrOKOSvQjQbsPzp9+zo4x52ik9G/eb9dW8VQ5uk5BKYWCcZVM85lV7cUD8GCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P6M8u9KX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38C2C4CEDD;
	Tue, 11 Feb 2025 10:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739268996;
	bh=3YjnxZWY8+A1CAXtu2lP+qXrvfKYEdhi2W8nLLgHgZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6M8u9KXVVMWw4Joy9IW9sw7b7H41IyeXvX9ig8NBMwntsb0v1HoZqAOqB7Ajr9Im
	 FLWrb+6/tITxpaXrkmVY2KxsOKNDOu4SLqALB/7JFiMPlDgJrWEb4dCQDUAnkxYuUW
	 F48xgYUTMkuLZo6tVrG8okceGjcMbD5PGKmwrE0M=
Date: Tue, 11 Feb 2025 11:16:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: stable@vger.kernel.org, Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Jacob Soo <jacob.soo@starlabs.sg>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH stable-6.6 1/3] io_uring: fix multishots with selected
 buffers
Message-ID: <2025021120-relearn-move-a4a0@gregkh>
References: <cover.1738772087.git.asml.silence@gmail.com>
 <7f1d8d30db7f5b304893917da8f9d22a38edb965.1738772087.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f1d8d30db7f5b304893917da8f9d22a38edb965.1738772087.git.asml.silence@gmail.com>

On Mon, Feb 10, 2025 at 03:21:36PM +0000, Pavel Begunkov wrote:
> [ upstream commit d63b0e8a628e62ca85a0f7915230186bb92f8bb4 ]
> 
> We do io_kbuf_recycle() when arming a poll but every iteration of a
> multishot can grab more buffers, which is why we need to flush the kbuf
> ring state before continuing with waiting.
> 
> Cc: stable@vger.kernel.org
> Fixes: b3fdea6ecb55c ("io_uring: multishot recv")
> Reported-by: Muhammad Ramdhan <ramdhan@starlabs.sg>
> Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
> Reported-by: Jacob Soo <jacob.soo@starlabs.sg>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Link: https://lore.kernel.org/r/1bfc9990fe435f1fc6152ca9efeba5eb3e68339c.1738025570.git.asml.silence@gmail.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  io_uring/poll.c | 2 ++
>  1 file changed, 2 insertions(+)

This is already in our 6.6.y queue, thanks!

greg k-h

