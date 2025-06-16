Return-Path: <stable+bounces-152720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31962ADB3A8
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 16:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EFD18929D7
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959FC21D585;
	Mon, 16 Jun 2025 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sLNFJMq3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E61FFC59;
	Mon, 16 Jun 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083496; cv=none; b=NDKm260JxfeWzyFTXSs9CumFU1qPAC6RMqARb96mpsLdvl0CT1h/NWZXuaQStDWtx0YuEF0kPN+dXomF1Kpx+QwlD97i289Xfzz6XsKAdGsg3DGIMknz4jhZrWoCiKz6sNoGBNP0cjPfoohK/VtSFxPV/BP7j/a9wJsuMBxmXWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083496; c=relaxed/simple;
	bh=5adsMQ0TDAhlIaGYvF670/1IDRxVrU+Q3eKWf6nrccg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS165uT1O6+TgrG85OIal22POk7HpPwfu/m4tjwNn+zdRwSmwI8GRVNftFVRCqj36iM87gEIWz6mtLqO3OTx4TKK6Slhv8Cbc8Czj0z8tqzNbvEuQV11elV/csvBJGmWVU7HYwzcdSAW0YUsQhcTTWffVT22856ASZcDoa63kUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sLNFJMq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74816C4CEED;
	Mon, 16 Jun 2025 14:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750083495;
	bh=5adsMQ0TDAhlIaGYvF670/1IDRxVrU+Q3eKWf6nrccg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLNFJMq3h3shBLwZpvAliCw36NIXJ9+FZhnZRWBEnv62iTXStnesZo9T4RHqxd3T2
	 vK06AaAlS4aFBmznsJWtMlfZyI/9FOpxXpGVFzDOX8L67FsSKfxi0K0saLprcF1AYL
	 4emc4YhJcZrQIkztzBAHq/oPneHG7IN8VnikzIGU=
Date: Mon, 16 Jun 2025 16:18:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: prashanth.k@oss.qualcomm.com, hulianqin@vivo.com,
	krzysztof.kozlowski@linaro.org, mwalle@kernel.org,
	jirislaby@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "usb: gadget: u_serial: Add null pointer
 check in gs_start_io"
Message-ID: <2025061642-likeness-heaving-dd75@gregkh>
References: <20250616132152.1544096-1-khtsai@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616132152.1544096-1-khtsai@google.com>

On Mon, Jun 16, 2025 at 09:21:46PM +0800, Kuen-Han Tsai wrote:
> This reverts commit ffd603f214237e250271162a5b325c6199a65382.
> 
> Commit ffd603f21423 ("usb: gadget: u_serial: Add null pointer check in
> gs_start_io") adds null pointer checks at the beginning of the
> gs_start_io() function to prevent a null pointer dereference. However,
> these checks are redundant because the function's comment already
> requires callers to hold the port_lock and ensure port.tty and port_usb
> are not null. All existing callers already follow these rules.
> 
> The true cause of the null pointer dereference is a race condition. When
> gs_start_io() calls either gs_start_rx() or gs_start_tx(), the port_lock
> is temporarily released for usb_ep_queue(). This allows port.tty and
> port_usb to be cleared.
> 
> Cc: stable@vger.kernel.org
> Fixes: ffd603f21423 ("usb: gadget: u_serial: Add null pointer check in gs_start_io")

As this is removing unneeded checks, why is it cc: stable?  What bug is
being resolved here?

confused,

greg k-h

