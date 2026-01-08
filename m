Return-Path: <stable+bounces-206284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2122D0414A
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFBF530802AF
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59ED4352F6;
	Thu,  8 Jan 2026 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FnPF9izf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E45C356A21
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864245; cv=none; b=T7R2WNFcNZT1j8SHJBgByUkUQ/IC6j4/ALaReAAqJeexSDNI9oerDTPlBjyEETgfuCAsi1C6P+n4Mz8wmMnQ30vqOq4W/NzlxpvgcQj6tHvBwUcIyomQU2qLHxgnPMRag+igkoFfLc3KTHqw/ZVPIhILjxE6W4Ty/k9sT1ld2MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864245; c=relaxed/simple;
	bh=u5tHIGlj/QfO6SyGVoFuIMcv530KGqYHpCtBr6HxkzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lbj6yq61hUpUc2/vpiYRjK51AonKp+OJCqawuwB112pXbafyaOueR0myCWeY+qhrXZzqZy9swq1a5aoBxUdyxFrCMAEXee3BHy2abbExDWsUC/jck0WXPpXx6mFpD0lWQlTmBCYZ8sEdHZsh/WlQg+VRrMYtH/ABSvJD2Mv8t6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FnPF9izf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1B7C116C6;
	Thu,  8 Jan 2026 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767864244;
	bh=u5tHIGlj/QfO6SyGVoFuIMcv530KGqYHpCtBr6HxkzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnPF9izf7F3Hl20XaosWqgj12YOsicnQZ3X9EQCkfrRUZ2AuId/XKcgVLebAmMCDP
	 1TA1YgULZtIpvEaafbGm1oy+JTo1UgHP5vwdgZHZvFAbf9mGxHkDwuGIfOhrXGGY17
	 9G/vAoL0SBi2rKQCZXjNmQRNtbRwDLsPMvi0H7xY=
Date: Thu, 8 Jan 2026 10:24:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Cc: stable@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH 6.12.y] xhci: dbgtty: fix device unregister: fixup
Message-ID: <2026010844-dispense-headless-de8c@gregkh>
References: <2025122917-unsheathe-breeder-0ac2@gregkh>
 <20260106235820.2995848-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260106235820.2995848-1-ukaszb@chromium.org>

On Tue, Jan 06, 2026 at 11:58:20PM +0000, Łukasz Bartosik wrote:
> This fixup replaces tty_vhangup() call with call to
> tty_port_tty_vhangup(). Both calls hangup tty device
> synchronously however tty_port_tty_vhangup() increases
> reference count during the hangup operation using
> scoped_guard(tty_port_tty).
> 
> Cc: stable <stable@kernel.org>
> Fixes: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
> Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
> Link: https://patch.msgid.link/20251127111644.3161386-1-ukaszb@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/host/xhci-dbgtty.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

What is the git commit id of this in Linus's tree?

Please resend it with that information.

thanks,

greg k-h

