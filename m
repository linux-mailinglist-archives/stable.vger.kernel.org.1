Return-Path: <stable+bounces-197533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE5AC8FF98
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 20:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E933A7F18
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 19:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1F2303C9F;
	Thu, 27 Nov 2025 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fLwJpA1+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86230302CDE
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270133; cv=none; b=ZQfXXGSAI4nnn321Wz4aTIIq6pMQx/CTXcJLH8DPLg18W2ZeJVsRoMXb0mG02MYIpC9pdn5hK9/aXBwAGrGbZySBJFDqaoI18gHPNB+MlJJdlFub9rSmEIiGsh5N7yvG1RevLSpGtVoeJcoLXeYQtWaMFzH8XNo/p9miuKGFyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270133; c=relaxed/simple;
	bh=3jDWUg/141k/bQ5wyCE7Ut9np3xh0kFNT8A8duoDSJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijxxZCYrnyC4nq67epmskL+q7h40fgRnVE1IT1FNy2+JOnC7SJ2VWoRV+3/91RiUzYW2bWFJ1/I4QhAnh89md8HvtyMZJ+etTZyu+gyUeZVA7h20Q2Yh/Bzss5BYwoEou8/TXZf4vHvek+snsDcDOylManDUFrlobvY/eHPei9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fLwJpA1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6776C113D0;
	Thu, 27 Nov 2025 19:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764270133;
	bh=3jDWUg/141k/bQ5wyCE7Ut9np3xh0kFNT8A8duoDSJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLwJpA1+02BSTS7xwaSmp3wOTOTD13XNxPTFs972X4r1FsRYbfo5QAbLmC338StiT
	 8iuPkmV3g8QOYEYi+j66JNKB4XRDTUmkX2zjDC0IrFKZnkKBr5VYJBe5o5ynYP1KR8
	 tWGsx3M7J/fs6m/T4YhjIlujfoyo9SKpSU4VsuiE=
Date: Thu, 27 Nov 2025 20:02:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: Re: [PATCH v6.12] staging: rtl8712: Remove driver using deprecated
 API wext
Message-ID: <2025112755-wince-upstage-372f@gregkh>
References: <20251127182037.2174177-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127182037.2174177-1-linux@roeck-us.net>

On Thu, Nov 27, 2025 at 10:20:37AM -0800, Guenter Roeck wrote:
> From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> 
> commit e8785404de06a69d89dcdd1e9a0b6ea42dc6d327 upstream.
> 
> This driver is in the staging area since 2010.
> 
> The following reasons lead to the removal:
> - This driver generates maintenance workload for itself and for API wext
> - A MAC80211 driver was available in 2016 time frame; This driver does
>   not compile anymore but would be a better starting point than the
>   current driver. Here the note from the TODO file:
>   A replacement for this driver with MAC80211 support is available
>   at https://github.com/chunkeey/rtl8192su
> - no progress changing to mac80211
> - Using this hardware is security wise not state of the art as WPA3 is
>   not supported.
> 
> The longterm kernels will still support this hardware for years.

That's not going to be true :)

> Like this ?

I like it, removing code is always good.  If we find people that are
relying on this, we can revisit it.  I'll queue this up for the next
round of stable releases after these.

thanks!

greg k-h

