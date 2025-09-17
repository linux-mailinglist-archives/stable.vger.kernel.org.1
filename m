Return-Path: <stable+bounces-179828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCACFB7C6DD
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8149016C6A1
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 11:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8F93705B5;
	Wed, 17 Sep 2025 11:52:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA02D5427
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109974; cv=none; b=hbKDxpggy9ij3r7RU08qG9l1vsTtb0hT2NwqB475wf/QvE9OTOXDVB5ERddTgC8hac21QKLw5mPLs3ovfh8rU24YhOSiXs+0vmHwFQGBmSt2anSeBZcle3ZRGsOxl0IGpLoTABBPXXprZp6+jOpn1wgkMILppIFz+SIJmgnpOmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109974; c=relaxed/simple;
	bh=uqaJ1Aj4tgRkY2VxqYrivb+JAi9VHqoNbdDpXMjZ9oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mam2L2siZTBCAMxT4A4BcXwBe1nLPzg+y3L8eCP6wGwwI0aYo3dWLVXm/4hV9G6ugZqJcoVMQyuS8reodqCXzHyZQ40cM7f6qYW04SmpKQcEVU4eC2wCObZ+xHy/LTGP+yjKu/ZHgS6XUFGX2J862AojQUr7OREEGKlKm6qweGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uyqiG-0007bg-Rh; Wed, 17 Sep 2025 13:52:40 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyqiE-001kqb-0v;
	Wed, 17 Sep 2025 13:52:38 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyqiE-00Dh2D-0U;
	Wed, 17 Sep 2025 13:52:38 +0200
Date: Wed, 17 Sep 2025 13:52:38 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Oliver Neukum <oneukum@suse.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Russell King <linux@armlinux.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
Message-ID: <aMqhBsH-zaDdO3q8@pengutronix.de>
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
 <0f2fe17b-89bb-4464-890d-0b73ed1cf117@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f2fe17b-89bb-4464-890d-0b73ed1cf117@suse.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Hi Oliver,

On Wed, Sep 17, 2025 at 12:10:48PM +0200, Oliver Neukum wrote:
> Hi,
> 
> On 17.09.25 11:54, Oleksij Rempel wrote:
> 
> > With autosuspend active, resume paths may require calling phylink/phylib
> > (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM
> > resume can deadlock (RTNL may already be held), and MDIO can attempt a
> > runtime-wake while the USB PM lock is held. Given the lack of benefit
> > and poor test coverage (autosuspend is usually disabled by default in
> > distros), forbid runtime PM here to avoid these hazards.
> 
> This reasoning depends on netif_running() returning false during system resume.
> Is that guaranteed?

You’re right - there is no guarantee that netif_running() is false
during system resume. This change does not rely on that. If my wording
suggested otherwise, I’ll reword the commit message to make it explicit.

1) Runtime PM (autosuspend/autoresume)

Typical chain when user does ip link set dev <if> up while autosuspended:
rtnl_newlink (RTNL held)
  -> __dev_open -> usbnet_open
     -> usb_autopm_get_interface -> __pm_runtime_resume
        -> usb_resume_interface -> asix_resume

Here resume happens synchronously under RTNL (and with USB PM locking). If the
driver then calls phylink/phylib from resume (caller must hold RTNL; MDIO I/O),
we can deadlock or hit PM-lock vs MDIO wake issues.

Patch effect:
I forbid runtime PM per-interface in ax88772_bind(). This removes the
synchronous autoresume path.

2) System suspend/resume

Typical chain:
... dpm_run_callback (workqueue)
 -> usb_resume_interface -> asix_resume

This is not under RTNL, and no pm_runtime locking is involved. The patch does
not change this path and makes no assumption about netif_running() here.

If helpful, I can rework the commit message.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

