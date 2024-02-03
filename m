Return-Path: <stable+bounces-17783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E768847E24
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 02:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE32B21CBC
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 01:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B227110B;
	Sat,  3 Feb 2024 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ioZm4ZAn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7061FAD
	for <stable@vger.kernel.org>; Sat,  3 Feb 2024 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706923522; cv=none; b=We+o1J5++KOzsMLdGzqFde946uK318L8Ep7Yf0rPbQ79ObQJRn7ywfnKaO/WTTlnERxVnm2DNhwsOe4Q1/5ud1RON4nYG9AwM9mazW4gqhjjJSbUFAVZET9SUlYUDnqoomRTGGfeS8YBxVqBzzbhEkY9Y6JViBcyTX73oE8nbKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706923522; c=relaxed/simple;
	bh=FCDObgQ2I2mcsuvXuxuMSRWhdW9VOFi0x/ABiwE8Sqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na8AAXjcaJVsUhNbfS9csRgJiAVK5FfQ1mb3HzuH0RFiYim1hI8GmnW0yQUKtiQacAj5VeomhHwG8SjeyY777Lj3HaNFgVDTmGjNhWwToyr36Ht87YxrECxHkIkcQazlChzs3B3JaMPgV76WJLnvidXb9TWy1ocykde4iMbEKOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ioZm4ZAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCDDC433F1;
	Sat,  3 Feb 2024 01:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706923521;
	bh=FCDObgQ2I2mcsuvXuxuMSRWhdW9VOFi0x/ABiwE8Sqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ioZm4ZAn0FwTLzfClEnAX8MvcKBCS6mCSk0k5+2e9/UQxftG16MSrAGDFR2EHrY+L
	 5myMUKYgV+LyvEj1HlpKZwFYoodhh2GZi+sjALtXQ+em0f+ji95JC85rTUKWmXnrYT
	 cHsxTni8LxemunNgLz6Jdf6cAeLbHZ8N3SpK4TBg=
Date: Fri, 2 Feb 2024 17:25:20 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Gray <jsg@jsg.id.au>
Cc: mario.limonciello@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] Revert "drm/amd/display: Disable PSR-SU on Parade
 0803 TCON again"
Message-ID: <2024020212-awhile-water-1261@gregkh>
References: <20240202020447.79371-1-jsg@jsg.id.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202020447.79371-1-jsg@jsg.id.au>

On Fri, Feb 02, 2024 at 01:04:47PM +1100, Jonathan Gray wrote:
> This reverts commit 85d16c03ddd3f9b10212674e16ee8662b185bd14.
> 
> duplicated a change made in 6.1.69
> 20907717918f0487258424631b704c7248a72da2
> 
> Cc: stable@vger.kernel.org # 6.1
> Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
> ---
>  drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 --
>  1 file changed, 2 deletions(-)

All now queued up, thanks.

greg k-h

