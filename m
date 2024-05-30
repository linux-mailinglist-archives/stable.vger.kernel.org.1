Return-Path: <stable+bounces-47700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0E88D49CD
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 12:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724311F24103
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 10:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F0217C7A4;
	Thu, 30 May 2024 10:40:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8271761B1;
	Thu, 30 May 2024 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065607; cv=none; b=NeBm9i8lEbL9d8vsyQHnSxVA1UWcsQbdM5Az2P4QhAuBLviM55/tdClgV8UJi7Wu0vk6bWG+B1DmlJEGpSqM9hdKJ/VLXYINpc46o7p8hkNkkEW2Vr68W+xxXRq1fUid6ml1/kzQ67WX267AvgKFGka9O8PHFuqWveecT1Xu0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065607; c=relaxed/simple;
	bh=lLSoRHmW98Gmm9Y7MYMrtEICFrZqirjSTF5GZ+7r/z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8gPAYk4PKxUgbiW0siiFFYKfLcDG+WSY9LlyKeeIHWjo7tGiLfw5DZg1++ZDOW416O5bmLvAlIs3ZF6vQEojtPCbtNRZ4oF74FhbbxUBLtbpwE1krGe9yrol6qxoslIKO+Zl/fyH0XrQNyI4sZRQgIZVaJ4tpQ4OL/NbHt8MaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sCdCS-000000006jR-2UOa;
	Thu, 30 May 2024 10:40:00 +0000
Date: Thu, 30 May 2024 11:39:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: stable@vger.kernel.org
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: sfp-bus: fix SFP mode detect from bitrate
Message-ID: <ZlhXe81dILU5XytA@makrotopia.org>
References: <E1rPMJW-001Ahf-L0@rmk-PC.armlinux.org.uk>
 <20240115165848.110ad8f9@device-28.home>
 <ZaVYKgCPZaidGimU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaVYKgCPZaidGimU@shell.armlinux.org.uk>

Hi stable team,

> > On Mon, 15 Jan 2024 12:43:38 +0000
> > "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> > 
> > > The referenced commit moved the setting of the Autoneg and pause bits
> > > early in sfp_parse_support(). However, we check whether the modes are
> > > empty before using the bitrate to set some modes. Setting these bits
> > > so early causes that test to always be false, preventing this working,
> > > and thus some modules that used to work no longer do.
> > > 
> > > Move them just before the call to the quirk.
> > > 
> > > Fixes: 8110633db49d ("net: sfp-bus: allow SFP quirks to override Autoneg and pause bits")
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

please apply this patch also to Linux stable down to v6.4 which are
affected by problems introduced by commit 8110633db49d ("net: sfp-bus:
allow SFP quirks to override Autoneg and pause bits").

The fix has been applied to net tree as commit 97eb5d51b4a5 ("net:
sfp-bus: fix SFP mode detect from bitrate") but never picked for older
kernel versions affected as well.


Thank you!


Daniel

