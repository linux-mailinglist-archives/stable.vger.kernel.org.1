Return-Path: <stable+bounces-54764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52A910F4A
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 19:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01511C23A3C
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535AD1B47C2;
	Thu, 20 Jun 2024 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ESXzq9Rq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191C1A4F1D;
	Thu, 20 Jun 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904939; cv=none; b=jZhJztT3IRTDlQG8LV9MzFhM5mcrc49R9/ZN5fqdTrDtweZk0HlXEUtIJ/mUbDAoeiO53Fno+pMAEvZ+0/fnmHyGABevOnp32QNbIGi8dRVhDDYb8/19mn/+hZ09qvwYs+oZmYqMzq1A67U5gblu2BY5tOrTEYF0GEtus4QdbiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904939; c=relaxed/simple;
	bh=Qysz9e+rYvmm4WsTMe7XJXmc8MH0fJVnEXb7URgZQ6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbPMeAVx6vwYnHX+I8I25ZbJJrfMNH0yHIxrMD1lznsxPhGDGbflE4LWfAJSCc3LxFc/jcdZ2ugevljJga0QHFPH13kNKeQ7h4ByutQuWR0TO+x5gcYPAkM39X+/TTCge86R+dW7HZFdzXr/5I6FbcD4CdhMqmHg9YFvJuyeEuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ESXzq9Rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13CAC2BD10;
	Thu, 20 Jun 2024 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718904938;
	bh=Qysz9e+rYvmm4WsTMe7XJXmc8MH0fJVnEXb7URgZQ6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESXzq9Rqi5cDaDMhC+DMXnSdLksJVN58ohfhsUokypfgmp7GKDSINXC3LQgiswvjV
	 /Qi0ad6cj8LvgWswFuDc9Sl0xEt2MJLjBDTw9dbem/rhUtUHUv2gYDR23KY7SfQXr9
	 qLCXEt6r+rqwSWTgR7ugcWAyGVeaC2JKV3BRn/YY=
Date: Thu, 20 Jun 2024 19:35:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ferry Toth <ftoth@exalondelft.nl>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Kees Cook <kees@kernel.org>, Linyu Yuan <quic_linyyuan@quicinc.com>,
	Justin Stitt <justinstitt@google.com>,
	Richard Acayan <mailingradian@gmail.com>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	s.hauer@pengutronix.de, jonathanh@nvidia.com, paul@crapouillou.net,
	quic_eserrao@quicinc.com, erosca@de.adit-jv.com,
	regressions@leemhuis.info, Ferry Toth <fntoth@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Revert "usb: gadget: u_ether: Re-attach netif
 device to mirror detachment"
Message-ID: <2024062009-unison-coauthor-46a0@gregkh>
References: <20240606210436.54100-1-ftoth@exalondelft.nl>
 <20240606210436.54100-2-ftoth@exalondelft.nl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606210436.54100-2-ftoth@exalondelft.nl>

On Thu, Jun 06, 2024 at 11:02:31PM +0200, Ferry Toth wrote:
> This reverts commit 76c945730cdffb572c7767073cc6515fd3f646b4.
> 
> Prerequisite revert for the reverting of the original commit f49449fbc21e.
> 
> Fixes: 76c945730cdf ("usb: gadget: u_ether: Re-attach netif device to mirror detachment")
> Fixes: f49449fbc21e ("usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach")
> Reported-by: Ferry Toth <fntoth@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/usb/gadget/function/u_ether.c | 2 --
>  1 file changed, 2 deletions(-)

You have to sign-off on your changes, otherwise the tools will reject
them (as will I).  Please fix up for both of these and resend.

thanks,

greg k-h

