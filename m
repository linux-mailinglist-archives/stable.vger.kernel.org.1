Return-Path: <stable+bounces-86837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA9F9A411F
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 16:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F40E282006
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CD31DED5B;
	Fri, 18 Oct 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iQ9aidAd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEEF1EE007
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261614; cv=none; b=SG4WF+IdUTgQJf4olH4cjx2mJL2NXdLccwDZI/DLjI0SWYITDFhuZcYn1aPAcPJ1Nl6h1HcbA+CZvQkHW6v9Y6zRL2zF3TI6wN8n0uqOQTsTWl/ZFNHHHAYe96OmmifN0GLfXuHeLdfYgswGNX7vqqbSGmLmU+UKIlCVqkGH53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261614; c=relaxed/simple;
	bh=jsihBh2rkPfJQFevUVF0No5aUekJE6mW8IURRx+zw80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMcCECTn/TvVkGFooLF6iwIjm98OCcA7FrH46Wws9fHO1atp3QmLwgEfN6hx2bUjC/+ewZ7jjMhoeqa7hlcKIeQoL7PYZT4FWqTADu5Sxn4m9eWYhEmlYTAlUV35N7z5fGdxJ8n4xhh75YpOcAn7ZDy/lwo9UsW/HTD0YDDAVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iQ9aidAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB86C4CEC3;
	Fri, 18 Oct 2024 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729261613;
	bh=jsihBh2rkPfJQFevUVF0No5aUekJE6mW8IURRx+zw80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQ9aidAd7rp/EuBfVw+A+cx5mR3HPE/mOpnF9UM1hQ4xCdil138qqLytVplmdAdgV
	 DeKfNsUsbOeB+IUtTz23cvdWgOvq4GZcF8j63H1yNFs0zsRWaLZnI210ri4YKBR2VB
	 u73hC5rUOGF3AUxLsKly9qQ8lsQrm5kRQTN8enbQ=
Date: Fri, 18 Oct 2024 16:26:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Zhe <zhe.he@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10] watchdog: cpu5wdt.c: Fix use-after-free bug caused
 by cpu5wdt_trigger
Message-ID: <2024101821-pruning-estrogen-c92d@gregkh>
References: <20241018135428.1422904-1-zhe.he@windriver.com>
 <20241018135428.1422904-5-zhe.he@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018135428.1422904-5-zhe.he@windriver.com>

On Fri, Oct 18, 2024 at 09:54:28PM +0800, He Zhe wrote:
> From: Duoming Zhou <duoming@zju.edu.cn>
> 
> commit 573601521277119f2e2ba5f28ae6e87fc594f4d4 upstream.
> 
> When the cpu5wdt module is removing, the origin code uses del_timer() to
> de-activate the timer. If the timer handler is running, del_timer() could
> not stop it and will return directly. If the port region is released by
> release_region() and then the timer handler cpu5wdt_trigger() calls outb()
> to write into the region that is released, the use-after-free bug will
> happen.
> 
> Change del_timer() to timer_shutdown_sync() in order that the timer handler
> could be finished before the port region is released.
> 
> Fixes: e09d9c3e9f85 ("watchdog: cpu5wdt.c: add missing del_timer call")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/r/20240324140444.119584-1-duoming@zju.edu.cn
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
> 
> CVE: CVE-2024-38630
> 
> [Zhe: The function timer_shutdown_sync in the original fix is not
> introduced to 5.10 yet. As stated in f571faf6e443b6011ccb585d57866177af1f643c

Please refer to commits in the correct way, this would be f571faf6e443
("timers: Provide timer_shutdown[_sync]()"), right?

thanks,

greg k-h

