Return-Path: <stable+bounces-6983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFE3816B4D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 11:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552292832C9
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FCF156CC;
	Mon, 18 Dec 2023 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UpN6t0pO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4B14F89
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 10:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C917BC433C8;
	Mon, 18 Dec 2023 10:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702896078;
	bh=RntGH3GjvbcIm6Ly2wvTM6Xt97Sl1gffShyx9JRX+60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpN6t0pOfa7H0SpRrkWvae0R5cHV7WkNxrcrrT6YrRHINjo8ukT5vEWDiDWk4tiW4
	 cbMqGNg45vGotacmzXZd1YavInVWkcPydwkq/JAYy0v2dJeRQnpI4IwGkodFUU2e/z
	 EHBpsnuRSAoEh+8wdjaIngk1QFFnyCxF8zLNpeRk=
Date: Mon, 18 Dec 2023 11:41:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Roy Luo <royluo@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y] USB: gadget: core: adjust uevent timing on gadget
 unbind
Message-ID: <2023121855-uncommon-morbidity-cb4c@gregkh>
References: <2023121132-these-deviation-5ab6@gregkh>
 <20231215021507.2414202-1-royluo@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215021507.2414202-1-royluo@google.com>

On Fri, Dec 15, 2023 at 02:15:07AM +0000, Roy Luo wrote:
> The KOBJ_CHANGE uevent is sent before gadget unbind is actually
> executed, resulting in inaccurate uevent emitted at incorrect timing
> (the uevent would have USB_UDC_DRIVER variable set while it would
> soon be removed).
> Move the KOBJ_CHANGE uevent to the end of the unbind function so that
> uevent is sent only after the change has been made.
> 
> Fixes: 2ccea03a8f7e ("usb: gadget: introduce UDC Class")
> Cc: stable@vger.kernel.org
> Signed-off-by: Roy Luo <royluo@google.com>
> Link: https://lore.kernel.org/r/20231128221756.2591158-1-royluo@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> (cherry picked from commit 73ea73affe8622bdf292de898da869d441da6a9d)
> ---
>  drivers/usb/gadget/udc/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Why just a 5.10.y backport?  What about 5.15.y as well?  You can't
upgrade kernels and have a regression :(

thanks,

greg k-h

