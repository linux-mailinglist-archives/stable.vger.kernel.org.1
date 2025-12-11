Return-Path: <stable+bounces-200793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25947CB599B
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 12:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B701B30115F3
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E9306B1B;
	Thu, 11 Dec 2025 11:05:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56C1EDA3C;
	Thu, 11 Dec 2025 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765451158; cv=none; b=J7DXA7yZuoplyavsDKXbtmty+31HdSgUdJSla6t+FMn4CMy15IS0/ioKbxMQ5Hg76E0eCRB+n99/tQNBx+AMFMJfCiPkIu1yqFxaGhctMphNCsygCTQt2EkDxrGTpWWMx7ox7MeHk8m3yo1Bl+shScDuxiEEGs6Y16XBCF9zzrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765451158; c=relaxed/simple;
	bh=hCtjyhgvHlcSoyDczJ6WX3lm1CPRYixLxhhCbIr57Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei+CCgrELkIx1KqT2QSJmVYMyr/9tIYXKljRK9wepRujjXSxlkEmV3NJLeDSr6RkyT++6JS3VMX0mr7Xrj6zI3HrkuOcCF/SHwb4/oNtFt8o5jr+E4qUDDSTCsLo0KD/TAtlIqLUcJTdrCGuagoqlO2PmjWj3rVnvguwoy3tTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vTeUQ-0000000019P-14kL;
	Thu, 11 Dec 2025 11:05:42 +0000
Date: Thu, 11 Dec 2025 11:05:35 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <aTqlf6pUC6uMp3bk@makrotopia.org>
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

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

