Return-Path: <stable+bounces-195462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A58C77665
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 06:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E1C34E77C6
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 05:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737422F49E9;
	Fri, 21 Nov 2025 05:41:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A829D29C
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 05:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703708; cv=none; b=H+znsZKQ/R4YwePMg+XstK2yVzANeuhmlRF/QqrhxRGvRb2BYsPI+7aLO6Xtes3gAAIeh/zE5wKUKLxBgX7b/Kc3RgzcEdr8B2H0f7u0S1xRPlWNWXTn69C2zW0jj9jYxwkfFDgPsERTs0xTawNYwEkRWCOgXOMIPyCNh76HkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703708; c=relaxed/simple;
	bh=Kn3J28aVMmGq6lo21uh5ZYTWPzceqvcAiZtS9zxPeYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keFVnKJRz+POoQclmuAVM4n7GkV5fr2MfC3zFcFKpu6p8tFjDEiD3Uu0nF1nR2V6C2ho3pWpS7FCobFWb0R2KMoAAtkQxnOPjqJ4bVxc1P+r5dsj1M7ipT6w6+BDZVEdSthI1mMYfmJ5Qlz5R97vk3yEEcw2Qm4RREA4uTbyqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vMJtW-0000dd-I7; Fri, 21 Nov 2025 06:41:18 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vMJtV-001XGc-0k;
	Fri, 21 Nov 2025 06:41:17 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vMJtV-00FpBF-0D;
	Fri, 21 Nov 2025 06:41:17 +0100
Date: Fri, 21 Nov 2025 06:41:17 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ma Ke <make24@iscas.ac.cn>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: microchip: fix mdio parent bus reference leak
Message-ID: <aR_7fXEMhNeIhRwZ@pengutronix.de>
References: <20251121042000.20119-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121042000.20119-1-make24@iscas.ac.cn>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Hi,

On Fri, Nov 21, 2025 at 12:20:00PM +0800, Ma Ke wrote:
> In ksz_mdio_register(), when of_mdio_find_bus() is called to get the
> parent MDIO bus, it increments the reference count of the underlying
> device. However, the reference are not released in error paths or
> during switch teardown, causing a reference leak.
> 
> Add put_device() in the error path of ksz_mdio_register() and
> ksz_teardown() to release the parent bus.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9afaf0eec2ab ("net: dsa: microchip: Refactor MDIO handling for side MDIO access")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

