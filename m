Return-Path: <stable+bounces-115094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00AEA33696
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 05:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B55A169175
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 04:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323CC205E17;
	Thu, 13 Feb 2025 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqOaTuaR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7F205512;
	Thu, 13 Feb 2025 04:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419568; cv=none; b=CNm4QUoZjoCXrqUHwWQ+rzdfOfsHZgwkljc1KiLtwu/k1KibHSAM4PTAPJLi1PdD40tVWXwaloiXr0R6MwsQrQrj03/2554yD4J0YmGgStI3RV/oJ7gApF72SA2xg6gZmkBHBk/BZYgalN+nweKG4Vk8vodAvo2QE+POYAj02yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419568; c=relaxed/simple;
	bh=2qAEKldKxjDMlgop/J9s2nwKY2jZLURRUinqIzr3DpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXAUO5+My53dt09KptUKDNgT0DiFXtbghSIjLzEeq2iBYNhi9RkTjKp9EpuuN5TS6q2cFY5LLCHmsPDOBxGcVpWdDRmKTsNhh76SP/4TyHF9+oJ1CvUM3/3ruLFbfspoo8vM6r2fLCTPOmK2DWATeJ5WnGChm8Q2PLJ7y5lj+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqOaTuaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927F3C4CEE4;
	Thu, 13 Feb 2025 04:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739419568;
	bh=2qAEKldKxjDMlgop/J9s2nwKY2jZLURRUinqIzr3DpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DqOaTuaRoaAli5GYGECbqmxAX+mm7CyoQpfW32UF7De6zOenUyp4j+WTkTCGxlHWe
	 AqM3jWhIlANjHxS52UhWIAbp9X4na338CbOwMETnYZKB06APU5meC5u2F7hiFEtzV5
	 iRAu4y36nwyAL26/pfeJKVMGxADMaNdkIVJrsFUL5yDhZloKHbOg3bAy685AFmW7f7
	 YI0LGxT8q/HX3x1T4qFTDi8GQGXWpd/LUlXZIrkoijig9HlgxqBhXzD9Lu/takwR59
	 Io8nUjvpwUqAaAbMvZbiZzXdgcbE2t5++kDBeyMHH2Rv+Qp1dkUHJeSOnuyIs38noO
	 0Y6GZ8injrrjw==
Date: Wed, 12 Feb 2025 20:06:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Yanteng Si
 <si.yanteng@linux.dev>, Feiyang Chen <chris.chenfeiyang@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Serge Semin <fancer.lancer@gmail.com>,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Chong Qiao <qiaochong@loongson.cn>
Subject: Re: [PATCH net V2] net: stmmac: dwmac-loongson: Set correct
 {tx,rx}_fifo_size
Message-ID: <20250212200606.0638ed60@kernel.org>
In-Reply-To: <20250210134328.2755328-1-chenhuacai@loongson.cn>
References: <20250210134328.2755328-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 21:43:28 +0800 Huacai Chen wrote:
> Now for dwmac-loongson {tx,rx}_fifo_size are uninitialised, which means
> zero. This means dwmac-loongson doesn't support changing MTU because in
> stmmac_change_mtu() it requires the fifo size be no less than MTU. Thus,
> set the correct tx_fifo_size and rx_fifo_size for it (16KB multiplied by
> queue counts).

Not all drivers support changing MTU. Supporting jumbo frames 
is a feature, so this commit enables the use of a feature. 
As such it is not a fix. I'm applying this to net-next.

