Return-Path: <stable+bounces-127476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE7DA79ABC
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 06:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494AE18936DB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 04:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949FD194AD5;
	Thu,  3 Apr 2025 04:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7F5jFv3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499052CA6;
	Thu,  3 Apr 2025 04:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743653335; cv=none; b=Rr7RHktLBbMjE4ImqcmE82tX43bYfv4jhxtKaLVZWD7YQW/Ng10cn+Er+fd0/zLrhVs1GcrrB9QarNbgukvROEJpHqNTyFNIwOfR5jkOHYa63KB5BSC+zZ460Z9/vPqArY3s02KJzYq1uRQZx3ltb3VI4YoiuIW+mSZHf7o3l4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743653335; c=relaxed/simple;
	bh=2JFZ7vu17THCyGPX0W0tfxAKNb3UxGPFhesBRijRBCM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bXAfxkuLy56ER3xuQcRm9R/t9BqaBQRNfSyJIpXu50uNVBRL2IVYuC8KhS3R/UGBNdQKK9GCwuqRPx/zNK58dzQ2bjLOCahQzhtkkRp2MyACKSRksllJwr+4yNnLVaHWEyMeJyjfkaH8/XfN7w5Olc/Wtlbe2IlOoK70uPpoLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7F5jFv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CB3C4CEE3;
	Thu,  3 Apr 2025 04:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743653334;
	bh=2JFZ7vu17THCyGPX0W0tfxAKNb3UxGPFhesBRijRBCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i7F5jFv3N7OsJ62htzJmLS/eTBdBF8pu+Q10OxVhfaj+OggMtrwuVq0R34zYknpuW
	 G7cYb50ud+Ofg8cYN15VudKU4DJEyEeVlf2A25Gl+mcAevOdVmI581f3kTqhtjxFV5
	 9eB7CPu2ZGTtw5lSPeX8J65j9tfFCVx71C36mDkJT3Mh5yT91N8QhDHMNf5r0NgmVR
	 rFo5FbvemtSxCWrwGkyUlHiRESJZkKi/Z2HgLLCfkMq693CTOnvn8iCswfFzNvPhcD
	 ijVnCPF4tqPTF5nBb1muO8AY1MH27TSRDanxiXzT2NgfIpJboj0LXA1Q+cDpZeYEcs
	 KymgDrSNjweIw==
Date: Thu, 3 Apr 2025 13:08:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] Revert
 "drivers: core: synchronize really_probe() and dev_uevent()"
Message-Id: <20250403130851.089bbaae4fe0d42b14a3266b@kernel.org>
In-Reply-To: <20250311052417.1846985-1-dmitry.torokhov@gmail.com>
References: <20250311052417.1846985-1-dmitry.torokhov@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 22:24:14 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> This reverts commit c0a40097f0bc81deafc15f9195d1fb54595cd6d0.
> 
> Probing a device can take arbitrary long time. In the field we observed
> that, for example, probing a bad micro-SD cards in an external USB card
> reader (or maybe cards were good but cables were flaky) sometimes takes
> longer than 2 minutes due to multiple retries at various levels of the
> stack. We can not block uevent_show() method for that long because udev
> is reading that attribute very often and that blocks udev and interferes
> with booting of the system.
> 
> The change that introduced locking was concerned with dev_uevent()
> racing with unbinding the driver. However we can handle it without
> locking (which will be done in subsequent patch).
> 
> There was also claim that synchronization with probe() is needed to
> properly load USB drivers, however this is a red herring: the change
> adding the lock was introduced in May of last year and USB loading and
> probing worked properly for many years before that.
> 
> Revert the harmful locking.
> 

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/base/core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> v3: no changes.
> 
> v2: added Cc: stable, no code changes.
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d2f9d3a59d6b..f9c1c623bca5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2726,11 +2726,8 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
>  	if (!env)
>  		return -ENOMEM;
>  
> -	/* Synchronize with really_probe() */
> -	device_lock(dev);
>  	/* let the kset specific function add its keys */
>  	retval = kset->uevent_ops->uevent(&dev->kobj, env);
> -	device_unlock(dev);
>  	if (retval)
>  		goto out;
>  
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

