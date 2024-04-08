Return-Path: <stable+bounces-36403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC989BE89
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1084B226C8
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597526A037;
	Mon,  8 Apr 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cfB07VEO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A8C6A323
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577590; cv=none; b=Idwj6klnYmC0291uR90arQI1iQ/6XqzcKK8RSdm86Ifq75NniQUfCdn76vtGDUUBhlZZyljn9msJJbMf/ENL5C9xMaAjAafXdOEExwU61Gu+jCNusyxYcEKo7IHBDLkAOiJlqFJm0xRCJckZDWK86T3B/o6yK18Jl6JeyerDZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577590; c=relaxed/simple;
	bh=r1EYDebxHShgLyRhepDhxYOGFd6LAFgywT/wfezu1uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoLCTJjAWapOH0mLRoMCMQ1PdEFn0xV773WH73hZ1wrT6dEMLhdpQtr7v5DKI8C8vqOEW6R5V/5DVBW2irE3KdkfVdQIW/IQN7S4A8Cf3zXAyvYX1TjS1RIKoqskzVZxEhn/Wil2pBmeXUSeBsnwAOgZccHW2TmlACOhI6udkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cfB07VEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5C6C433C7;
	Mon,  8 Apr 2024 11:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712577589;
	bh=r1EYDebxHShgLyRhepDhxYOGFd6LAFgywT/wfezu1uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfB07VEOab0UWFWKzM/KyM1swGCWSnBnqEzkY8w2zr9PDiYzyaawp12/9HL0p54nS
	 6JPrcZ7LznUnQ6pXd/loXQdPw+o+24cNewtgXaWqCNKWkelHfrZ5lvIKG6EW1ttEdw
	 EqSLNNuQjGBGHakt3ZJVimvMmoHDFjh5qCw8oMgU=
Date: Mon, 8 Apr 2024 13:59:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH -for-stable-v6.6+ 0/6] EFI/x86 updates for secure boot
Message-ID: <2024040834-reborn-devoutly-c2ae@gregkh>
References: <20240408064917.3391405-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408064917.3391405-8-ardb+git@google.com>

On Mon, Apr 08, 2024 at 08:49:18AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Please merge the attached series into stable branches v6.6 and v6.8.
> They backport changes that are part of the work to harden the EFI stub
> and make it compatible with MS requirements on EFI memory protections on
> secure boot enabled systems.
> 
> Note that the first patch by Hou Wenlong is already in v6.8. The
> remaining ones should apply equally to v6.6 and v6.8. Only patch #5 was
> tweaked for context changes due to backports that overtook this one.

All now queued up, thanks.

greg k-h

