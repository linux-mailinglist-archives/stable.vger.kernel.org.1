Return-Path: <stable+bounces-160514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE61AFCF2C
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC437A545F
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091A32DF3F8;
	Tue,  8 Jul 2025 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N0t4WwmZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1F2DECB4
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988475; cv=none; b=QUCOSpJE4KhNDED+S2s4YlfYAolhHNxaJBS+Q5tmkfgKUbCEyzjjiv224lxNeayKsK1eqs4ZdBNjXRRRRB7TOpMgGND0ifIBhkEbBP6B2to0Ms4gg79aJEGiw6+AgYLN+z59cj6eoa6b2Z5vUr2zNFLT975yWbJfxse2MZlt/eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988475; c=relaxed/simple;
	bh=6ul/XTQ37wsLWEqQJPqo35oU1RJ8W0jy7vbemVbizCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeAXl04XGVKcGDvNnT80/4tiMp1LmFgsYXxv/tNOmXkfemuQ0CKokK71HKqC0YhNyfAZyATELA5s9eZUwYAMmabibtjYI130XFI2dmy+efRZ29PXQshQvdmJGy5P9/xSJdop9aPb1hWMOE0hiktjV3LS4s3ldN99d4GePUg0Ew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N0t4WwmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3915DC4CEED;
	Tue,  8 Jul 2025 15:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751988474;
	bh=6ul/XTQ37wsLWEqQJPqo35oU1RJ8W0jy7vbemVbizCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0t4WwmZM5bTkuwGTnaNE7F011GFz3P6ATuVZMCRpF+HrnFJbhZmA46rnF2XqKGRC
	 FgORDo6eNcHuaDKKTPJIDqo6j50BV/wxPd5xHmxJO16ZOjeslSzLWHtD1Ev6uYFTjf
	 QvVzbWyS5QOum4Q1EEw+p2TmQq/Kw1rtttkJTbAk=
Date: Tue, 8 Jul 2025 17:27:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org
Subject: Re: Please apply commit 93bd4a80efeb to v6.6.y and v6.12.y
Message-ID: <2025070845-spur-grumpily-fb4e@gregkh>
References: <3fb5d5b7-8c1d-414d-953f-b883a6e188d5@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fb5d5b7-8c1d-414d-953f-b883a6e188d5@roeck-us.net>

On Mon, Jul 07, 2025 at 03:43:36PM -0700, Guenter Roeck wrote:
> Hi Greg,
> 
> v6.6.y and v6.12.y fail to build corenet64_smp_defconfig.
> 
> powerpc64-linux-ld: arch/powerpc/kernel/irq_64.o: in function `__replay_soft_interrupts':
> /opt/buildbot/slave/qemu-ppc64/build/arch/powerpc/kernel/irq_64.c:119:(.text+0x50): undefined reference to `ppc_save_regs'
> 
> This is caused by the backport of upstream commit 497b7794aef0 ("powerpc:
> do not build ppc_save_regs.o always"). That commit made some wrong
> assumptions and causes the build failure.
> 
> Please apply commit 93bd4a80efeb ("powerpc/kernel: Fix ppc_save_regs
> inclusion in build") to both branches to fix the problem.

Now applied, thanks.

greg k-h

