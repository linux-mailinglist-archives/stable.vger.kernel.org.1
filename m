Return-Path: <stable+bounces-180540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC7BB85363
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865EC1895794
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63AC316181;
	Thu, 18 Sep 2025 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omiy0wMo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53860315D43;
	Thu, 18 Sep 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204918; cv=none; b=R9NL7j8k9GPzWd9SGrUO5wvCK+we5gZKNcOChL1i6YuNAg4xu0i2a+diNwpuiPUkadktzVs7SnKBSj7nh8WosdD5EZDz4YUcXk3Q7/qPwoG0LaKZnBmgG/iBKZr6DFDEgJGXlHi0xgL13DAA3PTIjjAWEKQjTcY36fecIXFB2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204918; c=relaxed/simple;
	bh=gWiH50s9H+3QCpy8Kdrf0c6cYqdlCgBeb7X+5UHAGoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+xu3Clm4rj4+aUhNRPS7sdd+XXS+uzHQuBQo7VGxcaKywk9bJU6JBa+P0xrm5k9eHc6DEuFF3oqTt9IVmLRcR3+uK3sHLpfDZ3dB2PD1pu0qVg1pM9wdeZxWEgop0WT99l7UMDavgYt/pq79YnR9/Fxi/diNz/hURap2lsffiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omiy0wMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D56AC4CEE7;
	Thu, 18 Sep 2025 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758204917;
	bh=gWiH50s9H+3QCpy8Kdrf0c6cYqdlCgBeb7X+5UHAGoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=omiy0wMoSXyYLTe/4zOJcqwtzcAPeEWcnCWNoU5Qrqd2AMoDon4wjy9pbcDRI0dMl
	 YSkOUNEC1lO7PzfI7wL64JLySfrwI4dSX6fz6tz3jqByfNv90r1kVPTLbtDvW+Vg2p
	 XZpFSXFQwvWui6rYBDaBTqlogMt1fiTiGxADYwTotvYkf2LF7oBOcRbtRBIJN6opax
	 Xd5Q4amuPx/iYGm9XTkvGxaa9okcaH86Ku0TPyrOE1LYZlCuILzWMYfbOeJd2iCQWw
	 zeXnp3I49s1TgB2O+7go/BPo3HC1dzkTe29JIRD+Ll1anf4GgW7LMTK6l2hUcuGUDh
	 w70C7uZ9NvYjQ==
Date: Thu, 18 Sep 2025 07:15:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, Jeff Garzik <jeff@garzik.org>, "Maciej W.
 Rozycki" <macro@orcam.me.uk>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: broadcom: sb1250-mac: Add checks for
 kcalloc() in sbdma_initctx()
Message-ID: <20250918071516.4ca7f752@kernel.org>
In-Reply-To: <20250918121051.3504490-1-lgs201920130244@gmail.com>
References: <20250918121051.3504490-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 20:10:51 +0800 Guangshuo Li wrote:
> Fixes: 73d739698017 ("sb1250-mac.c: De-typedef, de-volatile, de-etc...")
> Fixes: c477f3348abb ("drivers/net/sb1250-mac.c: kmalloc + memset conversion to kcalloc")

neither of these tags is correct, the bug existed before them
The Fixes tag should point to the commit that added the bug,
not the last commit that touched the line

> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/sb1250-mac.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
> index 30865fe03eeb..e16a49e22488 100644
> --- a/drivers/net/ethernet/broadcom/sb1250-mac.c
> +++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
> @@ -625,6 +625,8 @@ static void sbdma_initctx(struct sbmacdma *d, struct sbmac_softc *s, int chan,
>  	d->sbdma_dscrtable_unaligned = kcalloc(d->sbdma_maxdescr + 1,
>  					       sizeof(*d->sbdma_dscrtable),
>  					       GFP_KERNEL);
> +	if (!d->sbdma_dscrtable_unaligned)
> +		return;		/* avoid NULL deref in ALIGN/phys conversion */

This comment is completely unnecessary

Please make sure to read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
before proceeding
-- 
pw-bot: cr

