Return-Path: <stable+bounces-73869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997D970711
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CD31F21BD4
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 11:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81D815886B;
	Sun,  8 Sep 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NntdXFxN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD74503C;
	Sun,  8 Sep 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725796054; cv=none; b=F6uTdUtCwZqHkS0F0qDpjZ/YHgsc7mYyfUxervrudLVioRMgYUDFkSZPztXE9Ksk3hG+5g7ZWNqTTbCXpS0FIXhhHoevwQ9sPh/42FSqKP5RN6i+VRvlz/wftuaR0eGKqSdlzHYLur0Zne1yYMtWyE2mH6DI7LkO738jGeAVxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725796054; c=relaxed/simple;
	bh=TOLe3eD0M33y8treKPXWeCy9wvyflht//GLoHw8oPvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDLJFJdOq7V42/XEOnJbZ4gGC08kjCFqCBIg3lvYpJu0SWc8Eosi6QDE94f3fMjwtY6yj/iLmeLRvnQQKUvVP8Iw+xdmjcbvRSxojoZnCgChoveZKi7XPdN49ctu9KNB+G+dLnopSnJeY4u0bs1zk6Me63Q/9zNzN2YYfHrYV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NntdXFxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEFCC4CEC3;
	Sun,  8 Sep 2024 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725796054;
	bh=TOLe3eD0M33y8treKPXWeCy9wvyflht//GLoHw8oPvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NntdXFxNUTR/kzQtS0Ohd9d4amS+FxyFVJ7FpEvtW2LjUM65Ij5wO67/vdV5CW7qN
	 qjq8ShR55RIsIT+xQSmyzCTo+EP9cf3zg360IfmKv6+G24F04+GUL3KxD7mdvXoQxA
	 nKraq6/juJux4mMRNcKno2EtBeihyXPnsKcWHfno=
Date: Sun, 8 Sep 2024 13:47:31 +0200
From: GregKH <gregkh@linuxfoundation.org>
To: Yongqin Liu <yongqin.liu@linaro.org>
Cc: stable@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>,
	John Stultz <jstultz@google.com>,
	Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
	Allison Randal <allison@lohutok.net>, linux-clk@vger.kernel.org
Subject: Re: [Backport request for 5.4.y] clk: hi6220: use
 CLK_OF_DECLARE_DRIVER
Message-ID: <2024090824-cohesive-issuing-e007@gregkh>
References: <CAMSo37Udb-DwXYdGp+RdvKS87-0nTXjR1Dj0W46CALspeW2O2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMSo37Udb-DwXYdGp+RdvKS87-0nTXjR1Dj0W46CALspeW2O2A@mail.gmail.com>

On Fri, Sep 06, 2024 at 08:57:57PM +0800, Yongqin Liu wrote:
> Hi, Greg
> 
> Could you please help to cherry-pick the following commit to the 5.4.y branch?
> 
>      f1edb498bd9f ("clk: hi6220: use CLK_OF_DECLARE_DRIVER")
> 
> It's been there since the 5.10 kernel, and  this along with the reset
> controller patch
> are needed for Hikey devices to work with 5.4.y kernels, otherwise it
> will get stuck
> during the boot.

Both now queued up, thanks.

greg k-h

