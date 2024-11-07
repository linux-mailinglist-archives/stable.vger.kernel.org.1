Return-Path: <stable+bounces-91852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624A99C0BA0
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 17:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9141C22421
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 16:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A462161FF;
	Thu,  7 Nov 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbvSHeD1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7BF212D3A;
	Thu,  7 Nov 2024 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996766; cv=none; b=t2apCdtZ6sig36MWgLikZKh0KFr+8ShqVFqMxNRiBlaJfX9GdKdFf7oA2XBm3PRm5XJO05mUUzzSGNPxj/RSQ/SE/jjxAjvLxYrZiYaSsAX+SNhxlYcWHALq2UkJZBo3bDeJzLr+BVrJ8f/VaTmIZM3zcaSy+R4nQGuwqc4KDLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996766; c=relaxed/simple;
	bh=ZGNeGv59giDSq2n3Qf1rhDUEiKsr68Gb0LrKfWT12ro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrgMAK075tUOtIee/PaAbTzSCTtbczgJKXze4lzR3bUapOcaKPEmrVUtQHNoSWB3junans+LUxqSRK+ZZ40RJKX+8/TN7u8dmQGEtUH5CUCY7pDLdZZKmCcvh9njp3dk6/GkHY8JQI40e6bGTqStcBxlZNSswFJvsZrjFGksY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbvSHeD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB564C4CECC;
	Thu,  7 Nov 2024 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730996766;
	bh=ZGNeGv59giDSq2n3Qf1rhDUEiKsr68Gb0LrKfWT12ro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dbvSHeD1gD7wOtH851djZvFSDmArgs+/zApmZXN5YfF53TGAntdkEY91+Lbk7N2F3
	 ye6y5WRBykqRpBg3m8IJ6vWNf5LowZ4lyQjksZ3r6jZ7R5YdNtD6ywxok9P4pMXph4
	 qCE5J/M8ZpxIABSU2vwtr2CZ1OBMptAfOaKWRU56KsPyx6MRMJQvCfhcwbtDzTJJDN
	 IvMniAtNec9+TuCbb8NznZb08zto6EK3BKO+2hQdZaPtGs83mnhm6VlZuy3rtHd1ho
	 YzUd2AEBuHgTaZQlel2NE2jrSZg9xtByyt64fu9dGPjnDxo18LAdy28bjaIYS4d9if
	 24Kxrsp7XWKqQ==
Date: Thu, 7 Nov 2024 08:26:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Romain Gantois <romain.gantois@bootlin.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Dan Murphy <dmurphy@ti.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: dp83869: fix status reporting for
 1000base-x autonegotiation
Message-ID: <20241107082604.3cf95e9d@kernel.org>
In-Reply-To: <20241104-dp83869-1000base-x-v2-1-f97e39a778bf@bootlin.com>
References: <20241104-dp83869-1000base-x-v2-1-f97e39a778bf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 Nov 2024 09:52:32 +0100 Romain Gantois wrote:
> The DP83869 PHY transceiver supports converting from RGMII to 1000base-x.
> In this operation mode, autonegotiation can be performed, as described in
> IEEE802.3.
> 
> The DP83869 has a set of fiber-specific registers located at offset 0xc00.
> When the transceiver is configured in RGMII-to-1000base-x mode, these
> registers are mapped onto offset 0, which should, in theory, make reading
> the autonegotiation status transparent.
> 
> However, the fiber registers at offset 0xc04 and 0xc05 do not follow the
> bit layout of their standard counterparts. Thus, genphy_read_status()
> doesn't properly read the capabilities advertised by the link partner,
> resulting in incorrect link parameters.
> 
> Similarly, genphy_config_aneg() doesn't properly write advertised
> capabilities.
> 
> Fix the 1000base-x autonegotiation procedure by replacing
> genphy_read_status() and genphy_config_aneg() with driver-specific
> functions which take into account the nonstandard bit layout of the DP83869
> registers in 1000base-x mode.

Could we get an ack from PHY maintainers?

