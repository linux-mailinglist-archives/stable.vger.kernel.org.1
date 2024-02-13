Return-Path: <stable+bounces-19770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6786F8535D4
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08741B23C05
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBAA5F846;
	Tue, 13 Feb 2024 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PtXowNPR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4655F540
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841143; cv=none; b=YgZZcbihrfIDhlSnGDdYZ0nzZkznbbZLsUlOeGHy0DNDSjBPnSkys8VnxMJiBJ5EOm76RFXNX4tUx55ENDeSRh2vSIlH7YK+RmweZTF0PGYDkDmQHH84jB79fKWOKdEHiHG53ZWixJRmBotg1AmNCQi6nF0rHIG63ucklj549LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841143; c=relaxed/simple;
	bh=zako/G/HB9gTzQ6JN0eka0+jdG1aihgr3k6eoWFjUbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQs1vvgUcVd/z5iz7z3D6AqQ+tMPstitktA0CHw0CdMFg6aUQSJ9NcRz61WxS3DZAAcNb9gFuXycAIoRp5ThHPBFJ+xkNrTnfbksKsqWG6oMVAT5d7yy9S9clnTA8ySBnsHtQZ6wBJCnc44nbyWIwwmomelZQlPP9ECMQiqwCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PtXowNPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AC1C433F1;
	Tue, 13 Feb 2024 16:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707841142;
	bh=zako/G/HB9gTzQ6JN0eka0+jdG1aihgr3k6eoWFjUbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtXowNPRsFn0UGhQnqeWUdI6bVouaYs4W9ihROpvzLOZgFkKQ7+bH2yd83+dBm2O1
	 KYL1ButHrYe/wwn4XwsQEKbqF80XrABKaSgcUPro3Zd/SW70eSdoL1yh9V0P8C0jcI
	 2s59px8zrJ0tdKVpNfGdvNG0DOt7x9ggJa9DoMGc=
Date: Tue, 13 Feb 2024 17:18:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: frederic@kernel.org, paulmck@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19] hrtimer: Report offline hrtimer enqueue
Message-ID: <2024021344-reveal-flying-3752@gregkh>
References: <2024021300-sagging-enhance-9113@gregkh>
 <87h6icgz7o.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6icgz7o.ffs@tglx>

On Tue, Feb 13, 2024 at 04:28:59PM +0100, Thomas Gleixner wrote:
> 
> From:  Frederic Weisbecker <frederic@kernel.org>
> 
> commit dad6a09f3148257ac1773cd90934d721d68ab595 upstream.
> 
> The hrtimers migration on CPU-down hotplug process has been moved
> earlier, before the CPU actually goes to die. This leaves a small window
> of opportunity to queue an hrtimer in a blind spot, leaving it ignored.
> 
> For example a practical case has been reported with RCU waking up a
> SCHED_FIFO task right before the CPUHP_AP_IDLE_DEAD stage, queuing that
> way a sched/rt timer to the local offline CPU.
> 
> Make sure such situations never go unnoticed and warn when that happens.
> 
> Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20240129235646.3171983-4-boqun.feng@gmail.com
> ---
> 
> Backport to 4.19 as tglx has too much spare time...

Now queued up, thanks.

greg k-h

