Return-Path: <stable+bounces-106131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 845CE9FCA4D
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 11:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073701882B56
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896C3171E49;
	Thu, 26 Dec 2024 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="zcqRxl5E"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196185626;
	Thu, 26 Dec 2024 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735209469; cv=none; b=FBJD6QqMGF7xTabiBxfWaCT1fgJY5XepgevSdlBEKs7H2D085Wbe6OIXpNSis+eRHCNG1K6g5y/wPJDRaF/P7b3Up/sw+upw+sVawB4V9WVmvuyfb9vW+zRvXvntML+8RaVuaZAVi2Q94ahy3wXoE7CTYkxSpcfVfo+d8/Pvc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735209469; c=relaxed/simple;
	bh=K0rwpEQ8Gb7A8CmI5mfchHXDdRg8gSJ/yUUNA/Pr05E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVHK8LCUuKrbed5QkTB5lLXOxAdZCfRzDZTrUq5czprnmFX8A9yCevZ2c/NQzC7F33ze/1cKiBEfOlGutq1NgOcYFE6QVUzPH/o4iI+0/IxMRte4lLa+FxDezBFzBJC6ecMrHRlGQSVhQLvu2r2w3EUatNTSJLO/TK2QZc9Tfqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=zcqRxl5E; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Thu, 26 Dec 2024 11:32:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1735209137;
	bh=K0rwpEQ8Gb7A8CmI5mfchHXDdRg8gSJ/yUUNA/Pr05E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=zcqRxl5EjdNfJedTdphXpUYtNDgy2vfk3MFy0pVm1gH4C5E17jTVQJcVaTb12K5Lv
	 m7NdtQy/06/r3sqnOEjvwnnlcYY0DOu0mHsloF5YL8p9ZNuZNMbNpdJzeGx4SIvgEo
	 c43ZGmsVkUeM12feluNVsR2Nkff8OQ2q0L+nI1bfxBPVfZwrmWlU6EKC2b3atO/xUs
	 VsZdEwewqQIa27DYqNayu4xMLNHhbnKmMpN3+iJNDrtvcDCLOrJir0Z0JRS3CYKRLH
	 GhQn4nShjgZq49fMh9EZ4u6FMQJvnlj8jUisRgYOBE40QV/ZjkTD+t44x+h44gGI5/
	 t4h0+XGpehMzQ==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: volkerdi@slackware.com
Subject: Re: [PATCH 6.12 000/160] 6.12.7-rc1 review
Message-ID: <20241226103216.GA29340@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	volkerdi@slackware.com
References: <20241223155408.598780301@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.7 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.7-rc1 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Nitpicking: On Slackware64-current (Tue Dec 24 19:32:08 UTC 2024)
I notice the following info in dmesg on an AMD Ryzen 5 7520U lappy
with kernel-firmware-20240904_87cae27 popping up within some minutes
after booting, no negative system impact noticed; tho, once the event
is logged, it seems to show up more frequent even in idle usage.

Dec 26 11:09:22 karrde kernel: rtw_8821ce 0000:02:00.0: unhandled firmware c2h interrupt
Dec 26 11:10:11 karrde last message buffered 3 times
Dec 26 11:12:14 karrde last message buffered 12 times
Dec 26 11:21:19 karrde last message buffered 41 times

Bluetooth is enabled. This happens on both 6.12.7-rc1 and 6.12.6 (probably affects earlier 6.12.X kernels too), I can't bisect.

Pat, what about a more recent kernel-firmware package to test? :)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

