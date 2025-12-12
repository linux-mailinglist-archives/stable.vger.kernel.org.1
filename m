Return-Path: <stable+bounces-200927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75718CB95D6
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 17:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E81CC30C388B
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 16:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF4C1C8604;
	Fri, 12 Dec 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FCr93DE0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CD823E342
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765558292; cv=none; b=RNiBaLZ0uOGsGq5yZyCfgij/DtPCoRFMR60moFJ/NnMdsUVKjo/VtKSlXww2Mvqo4QzJcV6+pPxqN7m2HUAjU+fI4Rfg6XGvRGD2XtXFJFR8pQ3NL60Rll6qfJk8QPRN5Uu3hVJ1GuPBK7Jm0tQRfQCSnCl/+dFJelwTdpj2/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765558292; c=relaxed/simple;
	bh=wj4WZHcDJSlcuZ3Yrj0Tiws2WsFAr/1k7Mv6n1tz1Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQbOytk2+H/aBiNJ7JVmXkP01Zv1I+O1xryw5WLhoWZfg2tfMZLeauzvqU3sFBzlztBDHVG2/kAcOQJyNXRXoClT81jK9WJPcrItvFMH7dEi55EQhcKFZFNEjdJvqEGg7Uxdrta2tOH5yUtoNxvuPSECrYzM3BcQ9WxbH4nUvUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FCr93DE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F33C4CEF1;
	Fri, 12 Dec 2025 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765558291;
	bh=wj4WZHcDJSlcuZ3Yrj0Tiws2WsFAr/1k7Mv6n1tz1Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCr93DE0l5R+gmu1+XpQswYsa6rJIw/jCe6nK9YEXYdUQosLx4FGZfhPugx4M66K2
	 W87d9aADe0A/AzJ22tHqmHtokHxUc+j5GTO3kRzHsqIrjd6Epxo4CNIPJVlv8yeevk
	 4XTVtyWIp8cIoGNsheZpXOG590ZCPI4IoMoiywYw=
Date: Fri, 12 Dec 2025 17:51:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Yu <xnguchen@sina.cn>
Cc: s.shtylyov@omp.ru, ulf.hansson@linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] mmc: core: use sysfs_emit() instead of sprintf()
Message-ID: <2025121205-wool-undesired-0609@gregkh>
References: <20251212081959.5633-1-xnguchen@sina.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212081959.5633-1-xnguchen@sina.cn>

On Fri, Dec 12, 2025 at 04:19:59PM +0800, Chen Yu wrote:
> From: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [ Upstream commit f5d8a5fe77ce933f53eb8f2e22bb7a1a2019ea11 ]
> 
> sprintf() (still used in the MMC core for the sysfs output) is vulnerable
> to the buffer overflow.  Use the new-fangled sysfs_emit() instead.
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/717729b2-d65b-c72e-9fac-471d28d00b5a@omp.ru
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Chen Yu <xnguchen@sina.cn>
> ---
>  drivers/mmc/core/bus.c      |  9 +++++----
>  drivers/mmc/core/bus.h      |  3 ++-
>  drivers/mmc/core/mmc.c      | 16 ++++++++--------
>  drivers/mmc/core/sd.c       | 25 ++++++++++++-------------
>  drivers/mmc/core/sdio.c     |  5 +++--
>  drivers/mmc/core/sdio_bus.c |  7 ++++---
>  6 files changed, 34 insertions(+), 31 deletions(-)

Why is this needed for stable kernels?  I see no real bugfix here, do
you?

