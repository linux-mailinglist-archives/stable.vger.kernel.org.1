Return-Path: <stable+bounces-137119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A15AA1169
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239E03BD5EF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98EF245019;
	Tue, 29 Apr 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHbxnauX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE18244686;
	Tue, 29 Apr 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745943276; cv=none; b=KR4V3Kagv/MWOhKb4KsMXWnkzO5yEV/gBWOQzYi4tvd+gPjf3AZoa33oMxW9fGJrJZxXzt8E/Thq2kjw1HqwC4vBy1g7xnqF14Y13KZwvbWPwtAFbXslZEHgy0qzlnOzOfs+FjyrRN8pIFvZGfzVf+fxcq/XcyjvBD7i4cLrquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745943276; c=relaxed/simple;
	bh=Za8BZ1UuGG2x9A7r1s1ssfvw4dTTAtf2acqIsO/vEKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQzLjM4SZU0CLvB9bR9TOLt83TAx9y/Rn/3t00va8GnZA8QEYXtYFvwB1HgDkMAtXOHWFUwI3mywaO846s2vTXMCPb9oxX/aJZuy61XI4chAkLTqcYldziOXfNFwidEgcU2RKHgGtdlQEsLuUZR6aTj16GmIPeV/aVfAfmSXONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHbxnauX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47365C4CEE9;
	Tue, 29 Apr 2025 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745943275;
	bh=Za8BZ1UuGG2x9A7r1s1ssfvw4dTTAtf2acqIsO/vEKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SHbxnauXLSp+l6ucqxC0MVJsfT2tWA3tsa4WUZuygkJ7bIefavMEcVylGGbx3u1WR
	 Vwh9cMNNo0n1kzTkZMIDfXbjDpmUvMub52/2Q0782AX9UmTU9H1Jj1I4y1bCjIoHxH
	 aM4rB0brwO6RBieMNPa5ayn3nY/KJ14mdFvdr6FzLbH7D43veYo/mfqip7p1Jqq1x+
	 4O2I/ZjC4ZNUOP28X7o7p9qUkINwSdygqnwH4ObTS2Wkbp/I8guLZ8ml7P1HBHSnvH
	 hyFCfA5ZFVrt0xbxR3TrQwa3Y91eFnSbVs+Gt6K/IJF3npnF3e8ZNm6g0fOauCE8sD
	 Fozt+c+Ndc+ww==
Date: Tue, 29 Apr 2025 09:14:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
 <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, "Russell King
 (Oracle)" <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 stable@vger.kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v3 1/2] net: dsa: microchip: let phylink manage PHY
 EEE configuration on KSZ switches
Message-ID: <20250429091433.7a4e8aaa@kernel.org>
In-Reply-To: <20250429073644.2987282-2-o.rempel@pengutronix.de>
References: <20250429073644.2987282-1-o.rempel@pengutronix.de>
	<20250429073644.2987282-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 09:36:43 +0200 Oleksij Rempel wrote:
>  	switch (dev->chip_id) {
>  	case KSZ8563_CHIP_ID:
> +	case KSZ9563_CHIP_ID:
> +	case KSZ9893_CHIP_ID:
> +		return true;
>  	case KSZ8567_CHIP_ID:
> +		/* KSZ8567R Errata DS80000752C Module 4 */
> +	case KSZ8765_CHIP_ID:
> +	case KSZ8794_CHIP_ID:
> +	case KSZ8795_CHIP_ID:
> +		/* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */
>  	case KSZ9477_CHIP_ID:
> -	case KSZ9563_CHIP_ID:
> +		/* KSZ9477S Errata DS80000754A Module 4 */
>  	case KSZ9567_CHIP_ID:
> -	case KSZ9893_CHIP_ID:
> +		/* KSZ9567S Errata DS80000756A Module 4 */
>  	case KSZ9896_CHIP_ID:
> +		/* KSZ9896C Errata DS80000757A Module 3 */
>  	case KSZ9897_CHIP_ID:
>  	case LAN9646_CHIP_ID:
> -		return true;
> +		/* KSZ9897R Errata DS80000758C Module 4 */
> +		/* Energy Efficient Ethernet (EEE) feature select must be
> +		 * manually disabled
> +		 *   The EEE feature is enabled by default, but it is not fully
> +		 *   operational. It must be manually disabled through register
> +		 *   controls. If not disabled, the PHY ports can auto-negotiate
> +		 *   to enable EEE, and this feature can cause link drops when
> +		 *   linked to another device supporting EEE.
> +		 *
> +		 * The same item appears in the errata for all switches above.
> +		 */
>  	}

compilers are not on board with having labels right before the closing
bracket. Please add a 'break;' here?

drivers/net/dsa/microchip/ksz_common.c:3565:9: warning: statement expected after case label

reminder: we have a 24h cool down period between reposts
-- 
pv-bot: 24h
pw-bot: cr

