Return-Path: <stable+bounces-112249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B482CA27DB5
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 22:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9746B18877E0
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E5821B182;
	Tue,  4 Feb 2025 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJS7xBab"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7021ADC6;
	Tue,  4 Feb 2025 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738705414; cv=none; b=X8BFLevQcMfH2ACKhg+LVxyWXNy6QS34ZxXSkS9AAb2E30rW1CP4cHD2DoIVGof4bOXjQ2MCt6HqUq286h+zJ1koqjGmIN2zUJC9PgHQGalltBlCI8pRwctQ4YXmB2Wz7N5LC8am1R4PhS7V2EyZi7goLU4n0blRbyFNCNZpmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738705414; c=relaxed/simple;
	bh=m8GYnkgYI7fcL9yp4e1ubi28RL805QQPehrMMx73558=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsQNSYEglL94QHaxomTri7lng7uPCM5sr3uxhTxL193NwAlBTidWp6JeIi9aEkpXL6VbYr7WziwaX76d0+/su6XlLKvmHrJ8XN+wK/UnI8c7ONUMke3yPiAVhjj8fIlTQsU4dV4r3N1NnKLt3lixfxOsdWr9Z5rEAaFgkDQo1b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJS7xBab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43FFC4CEDF;
	Tue,  4 Feb 2025 21:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738705413;
	bh=m8GYnkgYI7fcL9yp4e1ubi28RL805QQPehrMMx73558=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YJS7xBabGSYqT+e5Tz5JlbNObumGlum7hSL+mLqLgR3qw5HYW5Z3XkttuhJwfBh6J
	 IhhRu5bZVyYXzD7T0xBTE84VDeRdDqI1Oz7a0BQ1wTuH59+UU4Xii9DtcGjyaj+5v4
	 NybfB+xPcru05fSXKpX37BRu4mEQXdw8L8Ke/7HH7we34VNp6XsRj7Cz9cxJyqXSon
	 Ao+O5DAHTk5fWHbhLz4yL4GGHxkhhWBH3kvNoIpgNt6vPEyAsAvvATl57jCmU4haZU
	 YKTrTJUsxlbYWntqjW+fkcFsffjRdSIVFrh4iyVB/2CCV7dfU3slZr5/f2dHPcyfIw
	 1GL89ahroikqg==
Date: Tue, 4 Feb 2025 13:43:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiko Stuebner <heiko@sntech.de>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Steven Price
 <steven.price@arm.com>, Chen-Yu Tsai <wens@csie.org>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH netdev] net: stmmac: dwmac-rk: Provide FIFO sizes for
 DWMAC 1000
Message-ID: <20250204134331.270d5c4e@kernel.org>
In-Reply-To: <20250204161359.3335241-1-wens@kernel.org>
References: <20250204161359.3335241-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Feb 2025 00:13:59 +0800 Chen-Yu Tsai wrote:
> Since a fix for stmmac in general has already been sent [1] and a revert
> was also proposed [2], I'll refrain from sending mine.

No, no, please do. You need to _submit_ the revert like a normal patch.
With all the usual details in the commit message.

