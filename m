Return-Path: <stable+bounces-200799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62715CB609E
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 14:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 882FE30141DA
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 13:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC4D30F807;
	Thu, 11 Dec 2025 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y+pMqO07"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B0284672;
	Thu, 11 Dec 2025 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765460091; cv=none; b=V1tetUy6qhPo3K3UJRmlfC84aXFxreq4RyJQfTrEzRba+fLqbcqYqaAalXb5VGHOu5R7V8KD5cs/Z5N19GmVTjsXiwKgt4psxmEYOSm3M9Y/bQWAaTVsFvo2IJmNXyqBvgq8ugz8Utnx8MfrlrU+i/aCznhY4x4ZGZkL+34xBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765460091; c=relaxed/simple;
	bh=PX2xeICFOc8hwopXuENr+xB8Wmni5RPfx5e5kh/PRBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O84UqtAlJdvBTnkmpkJZF1jpBkLMXGLLt+yIhYCKr7omFdX9Tw2t+odgI+o43cX3yRR32mDtgi0xdCMzf+dMJEeZoO/NKXK64Q9uz7mQPbKLddkk5jYR/WPeO8pVwu7riTC98i7aIy8Z/S3Op9zTuu/1R80coixx2wplmByahcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y+pMqO07; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=87k6ZOPMZjikEVuPQMcOElrCO2sbaSMGE+CuXeuUymE=; b=Y+pMqO07thAfXDflKjPCaw9UDH
	cefJt4/vw4yCPrfXRYr0yVTO9QDamI9Q7/ELHXhBojx8USvqA/wAKy4Wj3LWuZsrQr1kg6fVHFia+
	Qx/kGfFBWcY26PbDF4mP6ek5z7u7h7/GSRT+h2gCgOAF5n5q+BItTusLN5f3G4ErqhV4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vTgoQ-00GeC8-MV; Thu, 11 Dec 2025 14:34:30 +0100
Date: Thu, 11 Dec 2025 14:34:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: phy: mediatek: fix nvmem cell reference leak in
 mt798x_phy_calibration
Message-ID: <57437939-6983-4db8-9178-dd19f1c7b971@lunn.ch>
References: <20251211081313.2368460-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211081313.2368460-1-linmq006@gmail.com>

On Thu, Dec 11, 2025 at 12:13:13PM +0400, Miaoqian Lin wrote:
> When nvmem_cell_read() fails in mt798x_phy_calibration(), the function
> returns without calling nvmem_cell_put(), leaking the cell reference.
> 
> Move nvmem_cell_put() right after nvmem_cell_read() to ensure the cell
> reference is always released regardless of the read result.
> 
> Found via static analysis and code review.
> 
> Fixes: 98c485eaf509 ("net: phy: add driver for MediaTek SoC built-in GE PHYs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

