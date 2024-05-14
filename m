Return-Path: <stable+bounces-43762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BABA8C4F2D
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3ABB2096E
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0741213CA99;
	Tue, 14 May 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyZ6gHPt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B569B58ACC;
	Tue, 14 May 2024 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680985; cv=none; b=XfDWfEalwct0veq6Vng3THfU/fQucyr0eOzxa/iCrnKNHdvzBXmon0QDivw+jLFP5/CuNAIlt6rOVtyLZ21i4M3SbC6hlaX9XSlfRrBl+F9smj/2agKEhpmkXCuncmjyX9IgzCB/2xlO82ZlcjS0DByHXQYZoInZtjc0iYWY1pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680985; c=relaxed/simple;
	bh=56LqVfznygd3cTbpewjX5Ek365TWbWYMxYpG+tsrTOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcwVQ3WhejKBJzCMKZkESc/wB9PoR2ka97vxw72qi3NXyfVWB7nT57B6O97vrDK7KaPlqk+nwU+WPVkrwcqcn1i2MTCbcyAVrb2CbdgWeC6hx8Us1yTfi7BHbS+hxqAvuaY8hOZVtSrkmNzZCeSpBSOivuiyKshWKRcrUfiEHCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyZ6gHPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF3BC32781;
	Tue, 14 May 2024 10:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715680985;
	bh=56LqVfznygd3cTbpewjX5Ek365TWbWYMxYpG+tsrTOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TyZ6gHPtwi8y0QQd6zf2dDt9XnDQriEmPwYhVa9+VSZ3jLGat3WbBr7taJgntiUY1
	 XYsFZLO4foBpQLO/SteMTqwx7fOcRhkRqG3nQfW24E2cVZATmwZShIbjIPrA00xufD
	 vnXRza4vCOum3VDj1uyT28tUeHWl11rrFJez01hW6MVMU2S6AexuLROyy1SaWI/xLs
	 YhKUDJOPnv4wPNyXAdbIUTTWB6hZJI3naRoME/SpGRLs6iHIa0aJ4YwGoyH67a5mdq
	 npDV4nWylvrIWxDj4ln8vNiEEk25vf4Jxaog4Kz2xDcRBGqaANIdo9U1v3TpOiAEBH
	 SIPIUUAD35+3g==
Date: Tue, 14 May 2024 11:02:13 +0100
From: Simon Horman <horms@kernel.org>
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: ks8851: Fix another TX stall caused by wrong ISR
 flag handling
Message-ID: <20240514100213.GA2787@kernel.org>
References: <20240513143922.1330122-1-rwahl@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513143922.1330122-1-rwahl@gmx.de>

On Mon, May 13, 2024 at 04:39:22PM +0200, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> Under some circumstances it may happen that the ks8851 Ethernet driver
> stops sending data.
> 
> Currently the interrupt handler resets the interrupt status flags in the
> hardware after handling TX. With this approach we may lose interrupts in
> the time window between handling the TX interrupt and resetting the TX
> interrupt status bit.
> 
> When all of the three following conditions are true then transmitting
> data stops:
> 
>   - TX queue is stopped to wait for room in the hardware TX buffer
>   - no queued SKBs in the driver (txq) that wait for being written to hw
>   - hardware TX buffer is empty and the last TX interrupt was lost
> 
> This is because reenabling the TX queue happens when handling the TX
> interrupt status but if the TX status bit has already been cleared then
> this interrupt will never come.
> 
> With this commit the interrupt status flags will be cleared before they
> are handled. That way we stop losing interrupts.
> 
> The wrong handling of the ISR flags was there from the beginning but
> with commit 3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX
> buffer overrun") the issue becomes apparent.
> 
> Fixes: 3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overrun")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>

Reviewed-by: Simon Horman <horms@kernel.org>


