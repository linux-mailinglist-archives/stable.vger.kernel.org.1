Return-Path: <stable+bounces-137006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53970AA048A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 09:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA7A27A50FF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 07:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559327817E;
	Tue, 29 Apr 2025 07:30:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB2A278172
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911843; cv=none; b=FAq8DflNkPVeTfekDx+oVV5JgH3U1qR0uuWwqa3BiLAwzly37mRVlbUNSMwEhzS1Q2kmBsKg13drlaDQKUCSqqpBEK/VxuGiMnSKbnwp0vSnn2zZta1CRGv1os+QvL7E06sh+tqlXcSOmEHHlHeaf8iUnLAT+eJO4BuggObqYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911843; c=relaxed/simple;
	bh=WgGmPa0XrpYI1bFGQ7+5ZKzV0PfNsZhc7WfbzTPSqrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gzp+QrzHxnvG/hpcXwgrBhpWzG6b9t5jFikDNt26Irijgm6Trhl/pvZmvzhAbMlYy74rOFTNxm06qdII/QqI50kZxuN5ODmVwrlg/vU54ceaTdecF+UZ56Ioeyo5k1hTdJ9uX0PWrMrUB8CN9TRLk4VKj41BKo/oeL1e7bsoz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9fQC-00014S-HD; Tue, 29 Apr 2025 09:30:28 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9fQC-000DxD-0W;
	Tue, 29 Apr 2025 09:30:28 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9fQC-00AnkA-02;
	Tue, 29 Apr 2025 09:30:28 +0200
Date: Tue, 29 Apr 2025 09:30:27 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: phy: micrel: remove KSZ9477 EEE quirks
 now handled by phylink
Message-ID: <aBCAE46MW4PvBb2_@pengutronix.de>
References: <20250429072317.2982256-1-o.rempel@pengutronix.de>
 <20250429072317.2982256-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429072317.2982256-3-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On Tue, Apr 29, 2025 at 09:23:17AM +0200, Oleksij Rempel wrote:
> The KSZ9477 PHY driver contained workarounds for broken EEE capability
> advertisements by manually masking supported EEE modes and forcibly
> disabling EEE if MICREL_NO_EEE was set.
> 
> With proper MAC-side EEE handling implemented via phylink, these quirks
> are no longer necessary. Remove MICREL_NO_EEE handling and the use of
> ksz9477_get_features().
> 
> This simplifies the PHY driver and avoids duplicated EEE management logic.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Not all was included in the kernel build bot answer:
kernel test robot notices the stable kernel rule is not satisfied.

I'll resend with cc: stable@... included.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

