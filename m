Return-Path: <stable+bounces-192488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE8EC35018
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 11:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD077560CE3
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990DC304BC2;
	Wed,  5 Nov 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBCMeyAT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFDE2FB09B;
	Wed,  5 Nov 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336735; cv=none; b=aMMqAMdPFiyL1nfEhaU8rmh2LtiuODU/8CejMYVMLxSUZD7yOdqsw1VNCIYzqboowaspbsv9CupVEGPhiciAeMgWWx4SL7VW17pyLDxAW2SXobaar6QgR7Vw3+e6gOekFlftH4FhQYpEUh7P+OWZRh0uu2k0zoyyCs8hw0TtBEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336735; c=relaxed/simple;
	bh=e4YUe6uFCdEjtXnfOYkxvoxqraQGxaOlP2Ux54Vd/zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKEo3aSrbvpKD0Jxu2wlfw+XSVz1MeHe9IWVQoiljrkLklAkBD5YYBzAGiiAcW0RSVjN3YJzUsIitIn+Unib77kO1bghM4UvWUiTzHnd+mCyNeftR/epSSilvyqS4pHXKQ0QQYgB2/q1bNKyn5tTOYqjMfpHx2vWoRxRS82x9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBCMeyAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A515C4CEF8;
	Wed,  5 Nov 2025 09:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762336734;
	bh=e4YUe6uFCdEjtXnfOYkxvoxqraQGxaOlP2Ux54Vd/zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBCMeyATv3O379YeQGuOE+iKkrUH/VLDzKOHjX3O5B8CkRSQy1UgoCdxwsWpSu6OC
	 fDHWrK6jsOk4sVMSAbvG6fI+LwCv1QJbr3e+V6N5RUmDzNt9C5Muyfu9zqh6nc5Sgn
	 CnSpwkSlO8WTGvakKwYQoJSV81xpsC9xX4cBLgr6XZ3GaGFqxR0fBIz9UhJJ2wIxmx
	 cf5zWKL3gV/zLcYZWo8Iey9roc7AYvubSBPH8/+3WV/EivZ1J0KmNUaGF7GFsLKbsA
	 UELqwrzed9o3wkjCCK/ZUILfZij7CRAiIDAEmsuJyaweQWNigwFWv5ucaNOyZyukIg
	 vICVmLSLh62Cw==
Date: Wed, 5 Nov 2025 09:58:50 +0000
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: libwx: fix device bus LAN ID
Message-ID: <aQsf2tTu3_FAeRic@horms.kernel.org>
References: <B60A670C1F52CB8E+20251104062321.40059-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B60A670C1F52CB8E+20251104062321.40059-1-jiawenwu@trustnetic.com>

On Tue, Nov 04, 2025 at 02:23:21PM +0800, Jiawen Wu wrote:
> The device bus LAN ID was obtained from PCI_FUNC(), but when a PF
> port is passthrough to a virtual machine, the function number may not
> match the actual port index on the device. This could cause the driver
> to perform operations such as LAN reset on the wrong port.
> 
> Fix this by reading the LAN ID from port status register.
> 
> Fixes: a34b3e6ed8fb ("net: txgbe: Store PCI info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Hi Jiawen Wu,

I am wondering if these devises also support port swapping (maybe LAN
Function Select bit of FACTPS). And if so, does it need to be taken into
account here?

...

