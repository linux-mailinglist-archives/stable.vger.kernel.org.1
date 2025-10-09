Return-Path: <stable+bounces-183672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F342BC80D9
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 10:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F03D3AEA99
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 08:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672972848BB;
	Thu,  9 Oct 2025 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtVUjQvJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173434A01;
	Thu,  9 Oct 2025 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998744; cv=none; b=COEuRLrKEcCrvIZHbSeSifF0uvk4fsqXYdyUBvfeWLgGdnCiA45nHpxgPDjxB6r3vIk5H/bl7KXIdxzFJ941cWyfdTgge1/fc57KfwkhJSJTjfvnOPlTBC4Xy3339+0n3DGbcxEesZo5HNM/oUwX3s3X17CQvQUnw1bym5fJFss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998744; c=relaxed/simple;
	bh=CpT047vseBAHkLMTuVR4Y4+NLn53QOvWFMPmqJrJSW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cr8Ook4kqOX/eanrExThZwEk1KFK6ICYJOGKcruf73SZYXXvjzwVw/Vwcf/4kW6ZKCIKcbxldxKg5TIa1FJc2x4sPjfiScUpLGMcwJqhiXJbZj+gVza6BL/af4hgAAZSi+aEXXZfRE8s4ivN491tHlPWpY+W0SQVk6Mn0LyOS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtVUjQvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACB3C4CEF7;
	Thu,  9 Oct 2025 08:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759998743;
	bh=CpT047vseBAHkLMTuVR4Y4+NLn53QOvWFMPmqJrJSW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UtVUjQvJ8VwBB4YjHG2j2Vhn4SwfSST9s7jMtACswUNDy6+QNYppj3Lk26sueiMmn
	 1bzAQRWADFCEGtf4V8IvoiT8Ly6xSXkAj7lc00CM9/cfO1b+7B9qpq4Ep3caaD/E4q
	 bX8uUItpgOE2Q0t5JqFugou4hlv1jR3WMWWzaE4o9rIXGMtWA3/0yTacq6YzL7NED6
	 mKpCI3/qsqHi3s/9KgSrj7LX8O1FQdz6Q4yBX5Kz/rbsF4VlLLnO5Hps3ATvzcx19a
	 HB108zq+cnuCTPRyT+ndX/+C0S4alfSSmCVSorC4t56hOnxxzW7vw2jJi6gaup9zAE
	 ArPus5VBXh2yw==
Date: Thu, 9 Oct 2025 09:32:17 +0100
From: Simon Horman <horms@kernel.org>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM write timeout
 error(-ETIMEDOUT) in lan78xx_write_raw_eeprom
Message-ID: <20251009083217.GT3060232@horms.kernel.org>
References: <20251009053009.5427-1-bhanuseshukumar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009053009.5427-1-bhanuseshukumar@gmail.com>

On Thu, Oct 09, 2025 at 11:00:09AM +0530, Bhanu Seshu Kumar Valluri wrote:
> The function lan78xx_write_raw_eeprom failed to properly propagate EEPROM
> write timeout errors (-ETIMEDOUT). In the timeout  fallthrough path, it first
> attempted to restore the pin configuration for LED outputs and then
> returned only the status of that restore operation, discarding the
> original timeout error saved in ret.
> 
> As a result, callers could mistakenly treat EEPROM write operation as
> successful even though the EEPROM write had actually timed out with no
> or partial data write.
> 
> To fix this, handle errors in restoring the LED pin configuration separately.
> If the restore succeeds, return any prior EEPROM write timeout error saved
> in ret to the caller.
> 
> Suggested-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Fixes: 8b1b2ca83b20 ("net: usb: lan78xx: Improve error handling in EEPROM and OTP operations")
> cc: stable@vger.kernel.org
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> ---
>  Note:
>  The patch is compiled and tested using EVB-LAN7800LC.
>  The patch was suggested by Oleksij Rempel while reviewing a fix to a bug
>  found by syzbot earlier.
>  The review mail chain where this fix was suggested is given below.
>  https://lore.kernel.org/all/aNzojoXK-m1Tn6Lc@pengutronix.de/
> 
>  ChangeLog:
>  v1->v2:
>   Added cc:stable tag as asked during v1 review.
>   V1 Link : https://lore.kernel.org/all/20251004040722.82882-1-bhanuseshukumar@gmail.com/

Thanks,

This patch seems consistent with the discussion at the link under Note.
I believe it addresses the review of v1.
And that the Fixes tag corresponds to the commit that introduced this problem.

Reviewed-by: Simon Horman <horms@kernel.org>

