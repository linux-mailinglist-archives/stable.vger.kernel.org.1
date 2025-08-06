Return-Path: <stable+bounces-166740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B18B1CCA4
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 21:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF4566962
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C132BCF4A;
	Wed,  6 Aug 2025 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMMUAJZA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4421ABDD;
	Wed,  6 Aug 2025 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510073; cv=none; b=WjZI1MmxFbjutPeMVVk+G1gQJEJ8jqnU3wy5m9shVvmn0bWZQJd5R0UzN/Q/pF4b29SG0hol0/ep8h28ZNZwYMSs4O6C5RcHQoocwscB7224Xi5o3wSeDKRvd7LK4t4mTGiRDg1lWO0AJPHgYlGn88M3CTos8vBodPLIPBaYHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510073; c=relaxed/simple;
	bh=/cOp30dms8uItY/3xX0vKGu+W81HNkXMglBIQQK17j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCZrPF32SRJn4/ydLtd6gTPTAT8ZMptqJTvfIN2RweHx+fsIxkl/DSNpCYZFNIzKthb8PouhvJUIBX/ER5E0SO3jI/QhSKyJLKNm9TT8I2njL9AsZlR27sh8VQTdEgYrEPUhBEC7sNCGeEWJax6R3hP5mlYzlhNNEMs+nFSMo3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMMUAJZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8DEC4CEE7;
	Wed,  6 Aug 2025 19:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754510072;
	bh=/cOp30dms8uItY/3xX0vKGu+W81HNkXMglBIQQK17j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMMUAJZADmwrEA56beYBmoyUXMpDChhSxqhSlFM6twGj4izMgh0FzfADAXb/EejWj
	 ucE7JXNZHAEeguZYuQuYXc14NuDUZGVJv0Wq/jWsjdkmOPLuWhxIN5shWv4nV1gpEX
	 g5pQdZUM5ir+geRLPdGXUOhye02ZuWwvzopO2onaT7EmGegHe6mLZ1TfYy3nj/zL1h
	 mn5G6oE84t9YjHh92Fao+E/lvpaSaXqZmxXqvn9m9PLCvAw1Y4YQxv14syfwhT1bMu
	 BaCemHORXhwMK54PQh42yZt3hjhRGfSOVFLwahvUg0YryJEpprCsh7YerrEwelZ84q
	 g1/O48Nyqh/7Q==
Date: Wed, 6 Aug 2025 20:54:27 +0100
From: Simon Horman <horms@kernel.org>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Ernberg <john.ernberg@actia.se>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Netdev Mailing List <netdev@vger.kernel.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: usbnet: Fix the wrong netif_carrier_on() call
Message-ID: <20250806195427.GH61519@horms.kernel.org>
References: <20250806003105.15172-1-ammarfaizi2@gnuweeb.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806003105.15172-1-ammarfaizi2@gnuweeb.org>

On Wed, Aug 06, 2025 at 07:31:05AM +0700, Ammar Faizi wrote:
> The commit referenced in the Fixes tag causes usbnet to malfunction
> (identified via git bisect). Post-commit, my external RJ45 LAN cable
> fails to connect. Linus also reported the same issue after pulling that
> commit.
> 
> The code has a logic error: netif_carrier_on() is only called when the
> link is already on. Fix this by moving the netif_carrier_on() call
> outside the if-statement entirely. This ensures it is always called
> when EVENT_LINK_CARRIER_ON is set and properly clears it regardless
> of the link state.
> 
> Cc: stable@vger.kernel.org
> Cc: Armando Budianto <sprite@gnuweeb.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/all/CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com
> Closes: https://lore.kernel.org/netdev/CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com
> Closes: https://lore.kernel.org/netdev/0752dee6-43d6-4e1f-81d2-4248142cccd2@gnuweeb.org
> Fixes: 0d9cfc9b8cb1 ("net: usbnet: Avoid potential RCU stall on LINK_CHANGE event")
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

FTR, this patch was applied directly by Linus:

- net: usbnet: Fix the wrong netif_carrier_on() call
  https://git.kernel.org/torvalds/c/8466d393700f


