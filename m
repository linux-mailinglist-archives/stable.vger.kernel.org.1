Return-Path: <stable+bounces-38050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0FA8A08D9
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 08:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A089B1C21BA9
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 06:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B713D8AE;
	Thu, 11 Apr 2024 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+MPaGAa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E110A11
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818371; cv=none; b=a9VSG43UUQMhp2vqIvZ++frapzFHh2fKz1LEw+IJ3xcCcuqdJseMcXRvTFNdc04nPKlo4Y0Y3x8x5hu9AO4mu9x3sNt2hiaDk6hvWpR6LNtB29xcWBO2blRHQukEh4SUfyk+GtOwn3aY1EN054YU+H6RzjfD800iw8lxELKk/n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818371; c=relaxed/simple;
	bh=Z3HIEnpxTk06niN4TGE3ZM2QbfsdeSKGVrrcneU50kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UocYsPniWWLPOQiRC3yYSiWylo0RVdsoh0PGZjTNRU6iOG82Z2QbvNojweHb81zUeWUh+PB4r+2yY4zV0QreDzbm6K2sc7HmuBT20E6eTzj/zflkB3ySwDVv96HFonWIxZdnPPDSFK0La4yrSRKZkplYvGWwY8OR6NN8K13sOuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E+MPaGAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD8AC433F1;
	Thu, 11 Apr 2024 06:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712818371;
	bh=Z3HIEnpxTk06niN4TGE3ZM2QbfsdeSKGVrrcneU50kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+MPaGAakGYC9aIXqVPPlyKQsPLPXIkaqPp9Pipx0mGhyKy+An8uiNo4dwJ0hYd3r
	 hC5HHL6hW2kIv/kkxJwv2HhUcSU4N2liuBWqrxmBPB9kMXh7hlHo6u1Zv+ATgsbCMx
	 iXhQj1FrW665AkReGJ35pFBuVDOLQpYHLE+PY1Gk=
Date: Thu, 11 Apr 2024 08:52:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>, Kees Cook <keescook@chromium.org>
Subject: Re: v5.15+ backport request
Message-ID: <2024041139-unpleased-village-01c4@gregkh>
References: <CAMj1kXHi=hF=Qb1rQZ941TBA5v1H39+NRjqXU=o=aB=7AH=uGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHi=hF=Qb1rQZ941TBA5v1H39+NRjqXU=o=aB=7AH=uGA@mail.gmail.com>

On Thu, Apr 11, 2024 at 08:43:35AM +0200, Ard Biesheuvel wrote:
> please backport
> 
> e7d24c0aa8e678f41
> gcc-plugins/stackleak: Avoid .head.text section
> 
> to stable kernels v5.15 and newer. This addresses the regression reported here:
> 
> https://lkml.kernel.org/r/dc118105-b97c-4e51-9a42-a918fa875967%40hardfalcon.net
> 
> On v5.15, there is a dependency that needs to be backported first:
> 
> ae978009fc013e3166c9f523f8b17e41a3c0286e
> gcc-plugins/stackleak: Ignore .noinstr.text and .entry.text
> 
> The particular issue that this patch fixes does not exist [yet] in
> v6.1 and v5.15, but I am working on backports that would introduce it.
> But even without those backports, this change is important as it
> prevents input sections from being instrumented by stackleak that may
> not tolerate this for other reasons too.

All now queued up, thanks.

greg k-h

