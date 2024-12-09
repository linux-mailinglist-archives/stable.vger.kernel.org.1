Return-Path: <stable+bounces-100262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4E9EA125
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 22:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3598F18871D1
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB20199E84;
	Mon,  9 Dec 2024 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUb/NKbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1488170815;
	Mon,  9 Dec 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733779159; cv=none; b=jCf27orxHFmQ9NoXQVSafs5M4Fnnx0YQv7zBvHbLPRQUruilsijO9prPrpFfkwilk7W7XSALpKkwho+ArZInl0gdWs7vk8Q3x1qPdRrWEEqAs6KGLsmVz19uQRxbv2CvyDlz03CaCUC0rCkOaBN7gd4Mo7qs7+0RBHH0ge/XWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733779159; c=relaxed/simple;
	bh=fQf9zpQ+5s9sRVYLqUiIDpZiLT4jPnTuTXJA3SHtA4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7KVSIwZgmMPskCuTIOpowwPit2tSTxZZCHfCICAt9zCu6OdjEXaHT1eg4hqY1YCUo3jqilBIuNQwzo7r+Wv73oQsCfXYLkuqdKLSjHKzG1YdKZrnGrQzQzU5SDis/fuhv1dfCvJ5turfp8/w9WOnt86q0evaMWH90gYaZlDZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUb/NKbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685ACC4CED1;
	Mon,  9 Dec 2024 21:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733779158;
	bh=fQf9zpQ+5s9sRVYLqUiIDpZiLT4jPnTuTXJA3SHtA4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUb/NKbNQlXWONUnLeHLd9UQEEefBjSvVgaefA85vq+pKHT26jN7ZnrD1eW4bRoYX
	 TjAuoJh/0PDLCwD7QnBoTxluv1l1sdU0Rhs52afBwuqTyzZlOEGnOco6Je+w4FThlW
	 h5IfIBHyOYKa3nqfVKbsswfueA0CzgqOVF6eCImjfOVieajMKvc1ty9AxKR5e0r+qw
	 UMkywIVqD2Bnb1pf8o5rus+AhYLpTjAXNQfHkZH6B9gHkpyMAa8cjqcjOwgs6a42Ts
	 pgX7oK+qTI9CzLwhT9uwScJ1snm1tWep4vhWR0Heg+wV5zNCVZoT+4NA7Sz4n9+5lQ
	 zb6ftHv9Ke2Sg==
Date: Mon, 9 Dec 2024 15:19:16 -0600
From: Rob Herring <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Stefan Wiehler <stefan.wiehler@nokia.com>,
	Grant Likely <grant.likely@linaro.org>,
	Tony Lindgren <tony@atomide.com>, Kumar Gala <galak@codeaurora.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jamie Iles <jamie@jamieiles.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 4/8] of/irq: Fix using uninitialized variable @addr_len
 in API of_irq_parse_one()
Message-ID: <20241209211916.GD938291-robh@kernel.org>
References: <20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com>
 <20241209-of_irq_fix-v1-4-782f1419c8a1@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-of_irq_fix-v1-4-782f1419c8a1@quicinc.com>

On Mon, Dec 09, 2024 at 09:25:02PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> of_irq_parse_one() may use uninitialized variable @addr_len as shown below:
> 
> // @addr_len is uninitialized
> int addr_len;
> 
> // This operation does not touch @addr_len if it fails.
> addr = of_get_property(device, "reg", &addr_len);
> 
> // Use uninitialized @addr_len if the operation fails.
> if (addr_len > sizeof(addr_buf))
> 	addr_len = sizeof(addr_buf);
> 
> // Check the operation result here.
> if (addr)
> 	memcpy(addr_buf, addr, addr_len);
> 
> Fix by initializing @addr_len before the operation.
> 
> Fixes: b739dffa5d57 ("of/irq: Prevent device address out-of-bounds read in interrupt map walk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/irq.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Rob

