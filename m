Return-Path: <stable+bounces-178934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6BDB49437
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 17:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655C2188B49D
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63238235BE8;
	Mon,  8 Sep 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="ms7COJtI"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FC9199931;
	Mon,  8 Sep 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346608; cv=none; b=brP0TCxd/rrZzbqqiDOUSKunrODZJjzHn/xRxoJgX6uQsfgUicyAdX+38gAN6i8X7MTUlVioCRyikMe2HZMp5OpYjVHFTqfYtsjIWkTPFaqDx1fa4tpoSueS+mLtB3p8WbMExJDyieeEuBAsmeRiD8eKCKs+io6VLCGMBBptZ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346608; c=relaxed/simple;
	bh=/Xd88lOPU68GuGK90CcjcRD+mst7vylArozokYYlrI0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5oYAuPFJePR8l6P/DD8rfJwsDZTeRnmmuvk98GuSXYFJ1CsajKphXC4EDnywtR2SBGreFru90pcfHacSNy0bYROHcpz5HoVb26/XQriYi3MSssaaOkJKykZ7beRR6G9j9j8FQ6EkIb31LPSxKuuZkfN/eavIrjNJqtEoKj9Rjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=ms7COJtI; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Mon, 8 Sep 2025 17:50:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1757346599;
	bh=/Xd88lOPU68GuGK90CcjcRD+mst7vylArozokYYlrI0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=ms7COJtIpqIrbWXvHz/HYeEg3rpo/r5MGOdGu/tJ1cwPlUTwmPL7Ibjhya5XkoXE2
	 xit78FbEGm1S1D770G13eANXZovw57e9PvRvaJqSCDF/0IZNX8poaORecmbGYHqmOB
	 ksGVvVl4AO3O3sxwciHjdknuykUR9PTml+oofxJtJas6qVU2ld38cfO6JPWkwaxdEB
	 zsT8gDv6lzpqEptS1DIR8MgHZ0mZhSyz+oJ0Fc6+3s0hb82qe1uTsLUskN5TL8OMMP
	 UUEiAM93h0pxay6a0lefGW/dVdF7XuFgQmpUOlRD+dp1E+5zKjI7q0MyCNQ9AU0OiU
	 8JOLFBJlwxz3A==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
Message-ID: <20250908155000.GH2771@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250907195615.802693401@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.

Hi Greg

6.16.6-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current).
No regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

