Return-Path: <stable+bounces-158863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AB3AED39F
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 06:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498F61892C11
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 04:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E4F1A9B53;
	Mon, 30 Jun 2025 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fue8I5h0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6222D4A11;
	Mon, 30 Jun 2025 04:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751259373; cv=none; b=IY9gFDONlyu7GJCP4ZngVx1Xe6hny/0eItsamrVMa/MGWUz9D/3c5NGhPGO68btr3PzFrPFNDiMls2HlJJi64PrFTfAwvLF4AnBerEmgt/lzvcqMF/3tv3ONMeFgi9B6kB1vzZHFdHQ13MVm/oi/nLIZGVN7Tg67SpDk7Ah3Rwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751259373; c=relaxed/simple;
	bh=wi6F43pcceDDPdVweAPMy1WeWjcYnUFiN1QJWIMhT2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGOxOYtyRXlGrtpf9M9/PrdOu4Jvi3o5dqzoxC5VvhzyMaAckZOWzFeTximYsygZhtNwaq0kjxzkvg/9Xp9ugtcIZrfJrcM6qV5fIrjE57HPW0cGs4OBcgTGhkQzg+W1mFHMs8w6fRXwNOf0tCY6FFdnIPYiG+I/31cBJbX7vWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fue8I5h0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DC1C4CEE3;
	Mon, 30 Jun 2025 04:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751259372;
	bh=wi6F43pcceDDPdVweAPMy1WeWjcYnUFiN1QJWIMhT2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fue8I5h0lsMALOQFl6B6mw9NhGqJunT8/9AQwRoh6sEZ3HSa2QXFTZsvCRlCKCaCa
	 b0HRdQQM45ywBt+hgwQ9ETwsnLBtCuaP5KJr0LY9OarHY1afjU++cssR0hR05JATDp
	 MufwaPrjDza4oK+g1/bvCsN9hgcq5+M+HkjVjsvo=
Date: Mon, 30 Jun 2025 06:56:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Seungjin Bae <eeodqql09@gmail.com>
Cc: Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: gadget: max3420_udc: Fix out-of-bounds
 endpoint index access
Message-ID: <2025063044-uninvited-simplify-0420@gregkh>
References: <20250629201324.30726-4-eeodqql09@gmail.com>
 <20250629214943.27893-4-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629214943.27893-4-eeodqql09@gmail.com>

On Sun, Jun 29, 2025 at 05:49:45PM -0400, Seungjin Bae wrote:
> In the max3420_set_clear_feature() function, the endpoint index `id` can have a value from 0 to 15.
> However, the udc->ep array is initialized with a maximum of 4 endpoints in max3420_eps_init().
> If host sends a request with a wIndex greater than 3, the access to `udc->ep[id]` will go out-of-bounds,
> leading to memory corruption or a potential kernel crash.
> This bug was found by code inspection and has not been tested on hardware.

Please wrap your lines at 72 columns.

Also, you sent 2 patches, with identical subject lines, but they did
different things.  That's not ok as you know.

And I think you really need to test this on hardware.  How could that
request ever have a windex set to greater than 3?  Is that a hardware
value or a user-controlled value?

thanks,

greg k-h

