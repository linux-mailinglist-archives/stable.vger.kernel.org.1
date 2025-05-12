Return-Path: <stable+bounces-143273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3161EAB39BF
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 15:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A52916F8B6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDA51DDA1B;
	Mon, 12 May 2025 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qS/ecjEZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563CE1DB125
	for <stable@vger.kernel.org>; Mon, 12 May 2025 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058099; cv=none; b=uOjkSt1cbZfVAqDkUFM04DGD4G0caeZamw3blHDhL0eoYmI92gQE04ikYZd9a0c6Oyy0NtDAuI4mgaPOZJIxOxbFkFCq7GKZ+LpvGG+Z9oq6kwxonajTGvdSkeYbbSO7MU72t/ZTSNeAf0gI1BEY0/KxPXSsaVsuEoOcbfFCZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058099; c=relaxed/simple;
	bh=cd2xWihiuNuwIeH1dcW/0cwJhk+eg6cocXHvr4xmodc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYhK7bWqrgJ+KqUZzNG/NH29FLuCbQr1689vskSTp7XxULmzTYOjg608fIk0YIykYqL9JP/i5Ba+bEka9lzNoLhIve7ZZQR3JLG9qNUiaklPdJoEizO1uEEedckFX+ThhTuDlXvzciKtzQ1hfJNis4oEWN7WHWqv+dTmja47ZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qS/ecjEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664A8C4CEE7;
	Mon, 12 May 2025 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747058098;
	bh=cd2xWihiuNuwIeH1dcW/0cwJhk+eg6cocXHvr4xmodc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qS/ecjEZSkDooiSZHmvsPOt12WNRDbB+I0szNrlYE0lLa81uKITTl8lDWIQjX4UlE
	 Lwf6lViHhtyoj6T5XrDMvGzvtsLaso2Fof361UpUhe1paMovIl4ybJid68+Ddw5eIH
	 awGLKGe5aPZHTeJvhaGYHdiLjXNIDTip2O3evHfc=
Date: Mon, 12 May 2025 15:54:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: christian.mazakas@gmail.com, norman_maurer@apple.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: ensure deferred completions are
 flushed for" failed to apply to 6.1-stable tree
Message-ID: <2025051246-cannabis-strongly-7d96@gregkh>
References: <2025051212-antirust-outshoot-07f7@gregkh>
 <a7dc23a8-8696-47b7-bcb2-3d45993b6c5b@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7dc23a8-8696-47b7-bcb2-3d45993b6c5b@kernel.dk>

On Mon, May 12, 2025 at 07:07:18AM -0600, Jens Axboe wrote:
> On 5/12/25 4:01 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's a tested 6.1-stable backport.

Thanks for them all, now queued up.

greg k-h

