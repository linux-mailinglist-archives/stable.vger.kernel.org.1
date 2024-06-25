Return-Path: <stable+bounces-55133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F84915DBD
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 06:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FAB1C21756
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 04:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5A313C90B;
	Tue, 25 Jun 2024 04:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kwJkbyO2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9613C9A2;
	Tue, 25 Jun 2024 04:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719290462; cv=none; b=gCEz+o2BnZwQS5ErYxqYTvx4FXpSzdkdD3wpRH9gafxX0IsS1B/TQQomRxcOWj2dV/iEtbZXZZQ3Ms47MXBxwl6rqDDboB9BfEJxuFyYUCZ9D7n2SlDqlS3Oo1jsXkZRX/5MTdPZMKdN6gAr/+RxxPS+u4vFcM69VuEw+niXH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719290462; c=relaxed/simple;
	bh=D7IIeOXloXwbPh6kcp6AarwDbWuitjPwrJSr2qfNFLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRYjlXIRSx9PL6fISTMDNzVA9+Dyhiz7MqBbp2ZiyAbS9GjjUT+qCoMr1bL2lSFIfBG/gFzrM1/qdFKZggEzyIPkhwRcQDHZC3xWIsrRNfv7zE7DkM2uim0OFaPPUeZfD+oQMkEl6hAEiYz7Bbs107xb+DIkQ3u3P02ZUrEs++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kwJkbyO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811F4C32782;
	Tue, 25 Jun 2024 04:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719290462;
	bh=D7IIeOXloXwbPh6kcp6AarwDbWuitjPwrJSr2qfNFLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwJkbyO2t5aAPDDtUFSL5ygieGeKli086ona1nncN0naWo6Rx5Dw4bCZHxLRvGZ0m
	 15NjjrXadD2AeKVUGe3qk8t2YXwDwIw5r4ozwYbZGC48z4jrSEAs4s+q45BfMzTIAh
	 uggp5EbN0VOHY4mUQ3zLqWIiSNO/PpOJcfeE6vko=
Date: Tue, 25 Jun 2024 06:40:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Udit Kumar <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, tony@atomide.com, jirislaby@kernel.org,
	ronald.wahl@raritan.com, thomas.richard@bootlin.com,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] serial: 8250_omap: Implementation of Errata i2310
Message-ID: <2024062525-venue-twine-aa79@gregkh>
References: <20240624165656.2634658-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624165656.2634658-1-u-kumar1@ti.com>

On Mon, Jun 24, 2024 at 10:26:56PM +0530, Udit Kumar wrote:
> As per Errata i2310[0], Erroneous timeout can be triggered,
> if this Erroneous interrupt is not cleared then it may leads
> to storm of interrupts, therefore apply Errata i2310 solution.
> 
> [0] https://www.ti.com/lit/pdf/sprz536 page 23
> 
> Fixes: b67e830d38fa ("serial: 8250: 8250_omap: Fix possible interrupt storm on K3 SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

As I have already taken the v3 patch to my tree, please send a "fix"
patch on top of it, as I can not rebase a public tree.

thanks,

greg k-h

