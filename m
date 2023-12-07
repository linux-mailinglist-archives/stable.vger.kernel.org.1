Return-Path: <stable+bounces-4907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3984780812A
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 07:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB401C209EF
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 06:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323013AED;
	Thu,  7 Dec 2023 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CcR4zYOr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765910A00;
	Thu,  7 Dec 2023 06:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C665C433CC;
	Thu,  7 Dec 2023 06:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701931857;
	bh=5rq84evr5Sp4/RH4eXvLAxgnsQiE23jaVtXpmghA1G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CcR4zYOrTjlo6Y9j0vouEKHP+t3UfzxX0klqYQd02P6/nycMBXSx4jDA1ys1O7l//
	 jEn30fvBRo2lOihnjQ5AG2LzYlSBB48wiMoO3w1eNt16E9Rc2GwEnS7F6VniJeUYu+
	 pA5Nr5e/CozwpXpbYkitpAYnB67qETBIb7FhElCM=
Date: Thu, 7 Dec 2023 10:45:48 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in
 sc16is7xx_regmap_name()
Message-ID: <2023120748-macaroni-gaining-335f@gregkh>
References: <20231130191050.3165862-1-hugo@hugovil.com>
 <20231130191050.3165862-2-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130191050.3165862-2-hugo@hugovil.com>

On Thu, Nov 30, 2023 at 02:10:43PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Change snprint format specifier from %d to %u since port_id is unsigned.
> 
> Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
> Cc: stable@vger.kernel.org # 6.1.x: 3837a03 serial: sc16is7xx: improve regmap debugfs by using one regmap per port
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> I did not originally add a "Cc: stable" tag for commit 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
> as it was intended only to improve debugging using debugfs. But
> since then, I have been able to confirm that it also fixes a long standing
> bug in our system where the Tx interrupt are no longer enabled at some
> point when transmitting large RS-485 paquets (> 64 bytes, which is the size
> of the FIFO). I have been investigating why, but so far I haven't found the
> exact cause, altough I suspect it has something to do with regmap caching.
> Therefore, I have added it as a prerequisite for this patch so that it is
> automatically added to the stable kernels.

As you are splitting fixes from non-fixes in this series, please resend
this as 2 different series, one that I can apply now to my tty-linus
branch to get merged for 6.7-final, and one that can go into tty-next
for 6.8-rc1.  Mixing them up here just ensures that they all would get
applied to tty-next.

thanks,

greg k-h

