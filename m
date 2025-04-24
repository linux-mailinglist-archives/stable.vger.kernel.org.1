Return-Path: <stable+bounces-136595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0961AA9B044
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 16:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97C81B6760F
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16B9199FA4;
	Thu, 24 Apr 2025 14:11:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A212CDA5;
	Thu, 24 Apr 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503904; cv=none; b=CFy+FTueztc8EdbieOxrTdzlrf/hdyvVhKOhmuCGkcRHQKok4P7xwBToMRd1Lp2I/dhgBT2CAmwYFVpwFyaiqT6KxYbVtP/pxeff9eGgNhWk2gZzQKIyNJnIkYffzBjf2MYp7wRTpp/A6fQk7/p13i8hAbny6RxU1yBXO4BkVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503904; c=relaxed/simple;
	bh=j9MhJlmrBgxTw9usy7mwcj8IIcG2mA7HsiyHb4W6AN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtzX+LLbwjCuxJPgYdVag7GlD+FeZE1zgWdhylm8I4v8U6WUgA6cug/dtrsGjoPNcAQeYJv3IIdQXXJLtvX2CR5VITNFChgVIvLcN+Wz2QNFeUc44MXxiJNkQO4YjKyMlZdvmb9XbVA/yk+ZvnwOKAhu5mEgIODQJ9Jx6i10k7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83376C4CEE3;
	Thu, 24 Apr 2025 14:11:43 +0000 (UTC)
Date: Thu, 24 Apr 2025 16:11:41 +0200
From: Greg KH <greg@kroah.com>
To: Christian Heusel <christian@heusel.eu>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH] Revert "rndis_host: Flag RNDIS modems as WWAN devices"
Message-ID: <2025042434-timid-fencing-cfe0@gregkh>
References: <20250424-usb-tethering-fix-v1-1-b65cf97c740e@heusel.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-usb-tethering-fix-v1-1-b65cf97c740e@heusel.eu>

On Thu, Apr 24, 2025 at 04:00:28PM +0200, Christian Heusel wrote:
> This reverts commit 67d1a8956d2d62fe6b4c13ebabb57806098511d8. Since this
> commit has been proven to be problematic for the setup of USB-tethered
> ethernet connections and the related breakage is very noticeable for
> users it should be reverted until a fixed version of the change can be
> rolled out.
> 
> Closes: https://lore.kernel.org/all/e0df2d85-1296-4317-b717-bd757e3ab928@heusel.eu/
> Link: https://chaos.social/@gromit/114377862699921553
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220002
> Link: https://bugs.gentoo.org/953555
> Link: https://bbs.archlinux.org/viewtopic.php?id=304892
> Cc: stable@vger.kernel.org
> Acked-by: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Christian Heusel <christian@heusel.eu>
> ---
>  drivers/net/usb/rndis_host.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

