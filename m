Return-Path: <stable+bounces-139278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F86AA5B2A
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 08:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A321B685A6
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 06:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912712690F0;
	Thu,  1 May 2025 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PnpsRRqf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFB1269D1F
	for <stable@vger.kernel.org>; Thu,  1 May 2025 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746081883; cv=none; b=F74/rb9a/WOCyowTu72MkPb49kZq5xsKMD2ZK/wB6gNQAgJhGb5ed55+vAwSOT/7ARUquO+LGOydrHfc2FfjeHeXmmVoRDF4DGUjLmv+y0cEROuGO1qYoI/5F09nkiZVjHlGR0oQGxgZdEIgzO4KBgn4onbLwS/vEL08qQQROMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746081883; c=relaxed/simple;
	bh=fekD/J/7e5SGGy5tXy012Gcf1md62EYiz8AWOrflMt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evQGPNuDPpY8OaUOIXPhidptzUoPN4cRgcdltmsgdRX66VnXhveTTE2sneBZyOnLmFPizBnfM8NsCmB1DmSxpddDtdEeaDxbHiJsisWWalooSWGBA9PxI8umpzFo+PuhZ2VkuQlvButw0eHmjPgjwYc3XBp2irT4D96Caf/O49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PnpsRRqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3731EC4CEE3;
	Thu,  1 May 2025 06:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746081882;
	bh=fekD/J/7e5SGGy5tXy012Gcf1md62EYiz8AWOrflMt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PnpsRRqfq9T4ehkoK3pUbx8xxwKiIaEXORWf/JdiBM3csYDA8+/st5CNAag5qlY8s
	 rTJmWkxK4z6bUrGRfzHB1yLBcMWHeNx/JuT7aoguXEmPv+p/Dq7dNYX6bc6za64jiP
	 PrYmXajfIzN6S0W6iO8/9/VJZ8szDa8F1Omgnevc=
Date: Thu, 1 May 2025 08:44:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Older kernels like 6.6 and lower may not compile with GCC15 due
 to -std=gnu23
Message-ID: <2025050154-finalize-violet-58d0@gregkh>
References: <e7198e45-f7bf-4864-aed7-dd4ecfd13112@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7198e45-f7bf-4864-aed7-dd4ecfd13112@manjaro.org>

On Thu, May 01, 2025 at 08:34:36AM +0200, Philip Müller wrote:
> Hi all,
> 
> GCC 15 changed the default C standard dialect from gnu17 to gnu23,
> which should not have impacted the kernel because it explicitly requests
> the gnu11 standard in the main Makefile. However I see these errors in older
> kernels series and some realtime kernels:
> 
> 5.4, 5.10, 5.15, 6.1, 6.1-rt, 6.6, 6.13-rt

That's to be expected, no one has backported the fixes for this yet.

Someone on the list started to, but then said they would wait for
someone else to do it, see this thread:
	https://lore.kernel.org/r/fb4cce81-1e36-4887-a1e0-0cfd1a26693e@googlemail.com

So, until that happens, or one of my build-boxes accidentally gets
upgraded to gcc-15 and I'm forced to do it myself, this is going to stay
as-is.

thanks,

greg k-h

