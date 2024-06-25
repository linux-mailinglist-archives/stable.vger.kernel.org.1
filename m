Return-Path: <stable+bounces-55136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D2E915E33
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 07:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D85E7B20C88
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 05:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7608F145A18;
	Tue, 25 Jun 2024 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KyCujSuG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E32D600;
	Tue, 25 Jun 2024 05:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719293798; cv=none; b=tcWZCLDt39GN7ClcjECAuK91HDakpvRD4EtfXCxABrFdUTofPpJx4tA1GysK6Q+0qhN3U9g0TFYfbQ+ZuRYvtJAbrTyJWI5+y8cQ6YVeSl9rxJtt8gRQcG+tbYSReQwL6LDodi2fqTgR+jpN5yesQ2xw0sBlH1KSmcM5dDBbqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719293798; c=relaxed/simple;
	bh=6zfM41Tx41Up8MfdoUDh6VMajDFwGM/hgl+Q6iP0b9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbxvqwCQA2tqvnKcMbDRuoL5d4UwF8oge9SVqjwC7XFKGFK2LzElpReybRecPjd7pzD0Szi2wDnUvDsJZUp39DOk/bpXU4lsDRCyngJnJqWrjAvGeiRPJAJxDSV/mPiKzvOjbQN7OyTCHApIEC8fGSqvEnYLzKYVhSQSE1noU/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KyCujSuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54460C32782;
	Tue, 25 Jun 2024 05:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719293797;
	bh=6zfM41Tx41Up8MfdoUDh6VMajDFwGM/hgl+Q6iP0b9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KyCujSuGgHobRGbdEluUJRNR5SU51IfMsKRlSm8ovHUaLKZVmMjND3BHoDkf40bwi
	 g21lYvj1tuzmkoJ3nGEnpeA7nGSvxJVUR1nxh+R95W08OQ1s66Opb64umZpWWZp1Zu
	 PSz0HVe9aN7izc6XWNmPyuRZN5HjILxCGxr1MlhA=
Date: Tue, 25 Jun 2024 07:36:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Udit Kumar <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, tony@atomide.com, jirislaby@kernel.org,
	ronald.wahl@raritan.com, thomas.richard@bootlin.com,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: Implementation of Errata i2310 adding
 fifo level check
Message-ID: <2024062503-comrade-length-e166@gregkh>
References: <20240625051338.2761599-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625051338.2761599-1-u-kumar1@ti.com>

On Tue, Jun 25, 2024 at 10:43:38AM +0530, Udit Kumar wrote:
> As per Errata i2310[0], Erroneous timeout can be triggered,
> if this Erroneous interrupt is not cleared then it may leads
> to storm of interrupts.
> 
> This patch adding fifo empty check before applying errata.
> 
> [0] https://www.ti.com/lit/pdf/sprz536 page 23
> 
> Fixes: b67e830d38fa ("serial: 8250: 8250_omap: Fix possible interrupt storm on K3 SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> This is check is added on top of errata implementation v3 patch 
> https://lore.kernel.org/all/20240619105903.165434-1-u-kumar1@ti.com/

The subject, changelog text, reported-by, and fixes: tags all need to be
changed to be correct as what you have above is not right at all.

thanks,

greg k-h

