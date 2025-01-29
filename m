Return-Path: <stable+bounces-111131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C3FA21DEF
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61FC163858
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB85F26289;
	Wed, 29 Jan 2025 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DYkoqYs0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3C1FDD;
	Wed, 29 Jan 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738157827; cv=none; b=LCmVdeUH+pqTj0ZXDD5PhpY4kAJPm6ex0AhijI4Ux+iYjfj7XWkuqfYv/ArdM30bbIYdSI8iT3ajayNhJk4i34k0am74z3CCB+zCfbh4yL/SuuYsYm3ushKvJ50vpwrYCyVV9oMrI2uqXQ1GKIqHkiSHrEEUevP858sliBP0ubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738157827; c=relaxed/simple;
	bh=u6M3Ft/QSXJZVKqG9Y87RFNcgGFOdiX+iAQqcAeFpyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9a3Crxp26AnQZRo//78KKVa4Ho8zDQd7TQnaRIvcFiWTj79XMK22Tmdk5lKfjbhUxsEAwSH3fzMl4OPDRxF4r8H7+ysCMpeGWClBnCcEoiIEBEHee6xDfi2EhANU8JCMEPtup8Dg2ajeVsY4nGws3vlJ6vHq6OiOqhQde6xHcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DYkoqYs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6504EC4CED3;
	Wed, 29 Jan 2025 13:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738157826;
	bh=u6M3Ft/QSXJZVKqG9Y87RFNcgGFOdiX+iAQqcAeFpyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYkoqYs0FY1o7F/u3llruer+SgXWqV63IabAK789tl6vAzybGkBjWGSXNCbaXt+W7
	 7Flzcu7Rrh1RlfTldrAscdMwO6OMfFg9gnQ3zxnMT+nQWinfQKKiTohlzWQ/EotcTz
	 BtcI+Wz4m8UGGF+02z31CZ3fMPOhvVZ4HWA/TRAQ=
Date: Wed, 29 Jan 2025 14:36:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan =?utf-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>
Cc: stable@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>,
	Michael Zimmermann <sigmaepsilon92@gmail.com>,
	Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>, regressions@lists.linux.dev
Subject: Re: [REGRESSION] USB 3 and PCIe broken on rk356x due to missing phy
 reset
Message-ID: <2025012925-stammer-certify-68db@gregkh>
References: <20241230154211.711515682@linuxfoundation.org>
 <20241230154212.527901746@linuxfoundation.org>
 <91993fed-6398-4362-8c62-87beb9ade32b@sairon.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91993fed-6398-4362-8c62-87beb9ade32b@sairon.cz>

On Wed, Jan 29, 2025 at 02:27:05PM +0100, Jan Čermák wrote:
> Hi Greg, everyone,
> 
> unfortunately, this patch introduced a regression on rk356x boards, as the
> current DTS is missing the reset names. This was pointed out in 6.12 series
> by Chukun Pan [1], it applies here as well. Real world examples of breakages
> are M.2 NVMe on ODROID-M1S [2] and USB 3 ports on ODROID-M1 [3]. This patch
> shouldn't have been applied without the device tree change or extra fallback
> code, as suggested in the discussion for Chukun's original commits [4].
> Version 6.6.74 is still affected by the bug.
> 
> Regards,
> Jan
> 
> [1]
> https://lore.kernel.org/stable/20241231021010.17792-1-amadeus@jmu.edu.cn/
> [2] https://github.com/home-assistant/operating-system/issues/3837
> [3] https://github.com/home-assistant/operating-system/issues/3841
> [4] https://lore.kernel.org/all/20250103033016.79544-1-amadeus@jmu.edu.cn/
> 
> #regzbot introduced: v6.6.68..v6.6.69

So where should it be reverted from, 6.6.y and 6.12.y?  Or should a
different specific commit be backported instead?

And this isn't an issue on 6.13, right?

thanks,

greg k-h

