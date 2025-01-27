Return-Path: <stable+bounces-110914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D488A2003B
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 23:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60E61886F4F
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 22:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C081D9A79;
	Mon, 27 Jan 2025 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXH5kMER"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229AE194A6B;
	Mon, 27 Jan 2025 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738015569; cv=none; b=io2nDv01RfCCKT1l58A0D5Tp9UVYePMr2/kq8IQMG4jII/8Wl10mynp0aDbBhh94FHx6CnqKi9Qc5WA3VMagyhLfuUzfIRePzb0QMt0R3DBrO2KfF4Ky2XWcUKVXYT7ns5Ed8/S5OwSvxVT7tdPy5umkJwBW5PMCgeXnLtBbjtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738015569; c=relaxed/simple;
	bh=EohFWVUKO5Dc2lTWarTHfeVWR7kzQ2rpOyw/XUErVuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYnJ6UUNHklK5AaTbTDb7pYlZuotX76HM37/Tu8TiPxhqmLGkEldpseDrDWkrDF0gNol0vITIUpT9pfgp0Fip7UHuSpzGb58QWosVxrC47oodKF5X23aDc8ROjtdo6IUwifIFgdj6bIvMy4sXRwrs8yQyrxl7N+5zOJbLieVxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXH5kMER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B44C4CED2;
	Mon, 27 Jan 2025 22:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738015568;
	bh=EohFWVUKO5Dc2lTWarTHfeVWR7kzQ2rpOyw/XUErVuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eXH5kMERklQq+IeHDTQUx00FKdPKQ+RC9uzLl77ZzTEeHTuDWBgplCTJeIzPeHbCY
	 xRQ8PoIpaRPATjvYqyw4BHCGnoW66wNbUfovQpPnWy+zC+J7h+hFxUTazPcfxR1z2b
	 y8ZrPFXx0Vw74JU8nTD11wehWBwWU5S9+Lb0zuJ/iEINiqjlzuNNXajwuUayV1YHWb
	 zS6C4KB90lHXZ7rpBs3b1Az3/MlhLtNnEOW475mqtIiTm/8M1YREdkVBajM9TnNg/9
	 lsAwb4E2sQoGWsQwAiREI/tXKkJEPycCqcQhG1Zf2cRQNQzyFFVao7QiP416v4oTQX
	 hhT7vghPBGhWw==
Date: Mon, 27 Jan 2025 14:06:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Chong Qiao
 <qiaochong@loongson.cn>
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Set correct
 {tx,rx}_fifo_size
Message-ID: <20250127140607.6b3617df@kernel.org>
In-Reply-To: <20250121093703.2660482-1-chenhuacai@loongson.cn>
References: <20250121093703.2660482-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 17:37:03 +0800 Huacai Chen wrote:
> Now for dwmac-loongson {tx,rx}_fifo_size are uninitialised, which means
> zero. This means dwmac-loongson doesn't support changing MTU, 

Please provide more details here than "doesn't support changing".
Does it return an error every time, but the device is operating
correctly?

Do the flow control thresholds also get programmed incorrectly?

> so set the
> correct tx_fifo_size and rx_fifo_size for it (16KB multiplied by channel
> counts).
> 
> Note: the Fixes tag is not exactly right, but it is a key commit of the
> dwmac-loongson series.

Please pick a better one, then. Oldest commit where issue can be
observed by the user is usually a safe choice.

Please use 12 chars of the hash in the tag.

> +	plat->tx_fifo_size = SZ_16K * plat->tx_queues_to_use;
> +	plat->rx_fifo_size = SZ_16K * plat->rx_queues_to_use;

Is this really right? 16k times the number of queues seems like you're
just trying to get the main driver to calculate 16k. 
What if user decreases the queue count? Maybe you should add a way to
communicate the fifo size regardless of the queue count to the main
driver?
-- 
pw-bot: cr

