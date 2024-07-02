Return-Path: <stable+bounces-56331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2722923923
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 11:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9DF1F21F00
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200741509B1;
	Tue,  2 Jul 2024 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gdfXBhDD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197D150997
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911298; cv=none; b=aPRMnSUPL8qBcrYT714aK7FQ+Mn0SSfrwBJqP8Qr65rzDy0eE3cjwPfaGMccLyQAbjL3y0JiWjP0zK7bY1FLWoZmfK220i7QGKmi16vlWE+DIPJw1YZAYatugbjgt/E+KAXcqJXwlaXV0ofwuC/XHSvtoJtZlAsWLgTHX01TGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911298; c=relaxed/simple;
	bh=NXI5B47v84D/CEDDZvcpRA+OI1HUD8OEuz79VrsNqqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciekC+32l5LJ5w/WIlS4jY0kiJsdcdMx+TeG/Xc8Hd3I5z5sVtyOWUel7g/KJsaO/f1PSatsEFw5zZI8OSvm1KSD1OQSSYZ4n4lghBVVFQCzzrOKZ91v3sjdwJiPEKs3gkn6fb+1OL5dRB3Ihxq8eS+ktaI6qc8zIZpdPdgtX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gdfXBhDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC808C116B1;
	Tue,  2 Jul 2024 09:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719911298;
	bh=NXI5B47v84D/CEDDZvcpRA+OI1HUD8OEuz79VrsNqqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdfXBhDDy9ZrV8yWs/Mvq8a7GeWfHJoGMgZ8vTIr0u/K69hBtaanSoi7m2QQ5wDjr
	 kKyVaCUbyWI7+pTgbFjpy/ajs7RSw1jzHmWOG6kHcMi3plLrrdVJwyvB92Jovf/OOX
	 AOF/llLMLd1ur7CJBMFVIHep7rkCnQUDlYZKu7D8=
Date: Tue, 2 Jul 2024 11:08:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: stable@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH 6.9.y and older] pwm: stm32: Refuse too small period
 requests
Message-ID: <2024070205-sleep-rectify-6099@gregkh>
References: <2024062455-green-reach-3f21@gregkh>
 <20240625075405.2196169-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625075405.2196169-2-u.kleine-koenig@baylibre.com>

On Tue, Jun 25, 2024 at 09:54:05AM +0200, Uwe Kleine-König wrote:
> If period_ns is small, prd might well become 0. Catch that case because
> otherwise with
> 
> 	regmap_write(priv->regmap, TIM_ARR, prd - 1);
> 
> a few lines down quite a big period is configured.
> 
> Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
> Cc: stable@vger.kernel.org
> Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> Link: https://lore.kernel.org/r/b86f62f099983646f97eeb6bfc0117bb2d0c340d.1718979150.git.u.kleine-koenig@baylibre.com
> Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
> (cherry picked from commit c45fcf46ca2368dafe7e5c513a711a6f0f974308)
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> this is a backport of c45fcf46ca2368dafe7e5c513a711a6f0f974308 to 6.9.y.
> It applies fine to 4.19.y, 5.4.y, 5.10.y, 5.15.y, 6.1.y and 6.6.y, too.
> Please apply accordingly.
> 

Now queued up, thanks

greg k-h

