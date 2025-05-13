Return-Path: <stable+bounces-144277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDD7AB5FEC
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 01:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1567A8608B7
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 23:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A4720D4FF;
	Tue, 13 May 2025 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8NEbqXy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303C3FBA7;
	Tue, 13 May 2025 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747179468; cv=none; b=f3P/hTeBZwxcAm9bMvHhgwr7pAfPJvCRAULw2C5tM7Ms2TV5WhXa92E7OyZgKkbfuUVtLir+jWHg87S/v9HsdPBpH0Nkgft6X1v6U84tVfI/ymz8D2fj/B3Am1ThTQwBv0mNfRyXRX18ExyagrXuxFQngMmtvP03XgMlxhgf5VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747179468; c=relaxed/simple;
	bh=d7e15YBeDTYxkNwm52QjN3kE/RCjGpq8kBOBS3qCUZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRIWS+7428HdmLEEPTOs2zAl8gpjHlWWpeGtBfbT4nJsig8md6r6hkZQNyM/Q1p0szvexnEwQQNKebZmH78zfjC6glaDBMvBPYUyRCaozERWkwXfQBLnpiyjRdrN0B6xsUVARnQ5THZYsQzCeZtmCvwg23fnU3OzaGN4Gk0GgR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8NEbqXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C54C4CEE4;
	Tue, 13 May 2025 23:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747179466;
	bh=d7e15YBeDTYxkNwm52QjN3kE/RCjGpq8kBOBS3qCUZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b8NEbqXy+C+8yutkV6fDKPrYhNMTOS2z/vEyRNe8dj94zQ6T88SNYMIU3JtcXp+aR
	 /9DB32Hoo39leQjuT19O27r4y4xI+5Gkf1ymwVIrGoC0504QpclF5P+2Qo+QQsbjv2
	 x51/RoZXe0ofgFPap2bPBUaOzaZrttfHB475/Bc+XksbVYVW3wxKJKVZfPit24joYC
	 YTXMLt39iSLKqi1zoq9ENUdt+tTx9kJ/qY0km5tk9oBvXonmDfMc/IRrecQmfdlzOr
	 VRaToepivA8WQ1sc9skAsKPwGXX+oaUdLyCpwueXQeXXScOwTZEEokoxD/uTEORJBl
	 RqQ3bQ0nnNb/g==
Date: Tue, 13 May 2025 16:37:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Marek Vasut
 <marex@denx.de>, Tristram Ha <Tristram.Ha@microchip.com>, Florian Fainelli
 <f.fainelli@gmail.com>, jakob.unterwurzacher@cherry.de,
 stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: microchip: linearize skb for
 tail-tagging switches
Message-ID: <20250513163744.20299747@kernel.org>
In-Reply-To: <20250512144416.3697054-1-jakob.unterwurzacher@cherry.de>
References: <20250512144416.3697054-1-jakob.unterwurzacher@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 16:44:18 +0200 Jakob Unterwurzacher wrote:
>  static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev)
>  {
> +	u8 *tag;
> +
> +	if (skb_linearize(skb))
> +		return NULL;
> +
>  	/* Tag decoding */
> -	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
> +	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
>  	unsigned int port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
>  	unsigned int len = KSZ_EGRESS_TAG_LEN;

Please don't add code before variable declarations.
-- 
pw-bot: cr

