Return-Path: <stable+bounces-249583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLu0OvtdDGq5gQUAu9opvQ
	(envelope-from <stable+bounces-249583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:56:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F66057F21F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50A393021EA2
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78D14BCAD7;
	Tue, 19 May 2026 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="xH8uJz5C"
X-Original-To: stable@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C494C9567;
	Tue, 19 May 2026 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194984; cv=none; b=D1hLZRu/wSe8ZU3lbKuOylaP66TXxVghYnKgxTssKQhCf4T6HQ9sX0prgUnkyadZ5HO/u1SXqedJJtmUv+FPLYcqVmdlihUCwViW2r8g63Kpif/KZ8SdNlmc0hcXqUdi9iEUOhy2Do3LodGO0BJgva9bdt84RBRSZ5McUU1sfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194984; c=relaxed/simple;
	bh=PmRdx8FRHXEbQy7+lAOa4RyFLZUwwH/S0Yo3h+evwYY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=i2on5J8cddnn1QRx60GfAvqKpZ62asyZzSjA1fG8rP5h5TQORrV/zaLMHMPLvCxmeAZf+iUGrZ3L4AxAxM5hS4ije41JCEos1CX1kXe21issJ7BBI506FNN+qJiNNfjFQ2mCor1wPvGPitWOsJMFRTJforxtTYMO9IlHQLi+zUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=xH8uJz5C; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 337BDA4FA2;
	Tue, 19 May 2026 14:49:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779194971; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KYHK9v8QDbL8YKvFNpIhVX5SjY8D12WYNhJK8Mla/t0=;
	b=xH8uJz5CyS1nIr22DGdlIQrbdTZcXek14ghLIo7lNXiUst5FiCopGRidLa8kI+dEN4UmXX
	Z2H6vX2S+yl6Bn3TIFvV5KeKLxdkan7l/GIBWZX9vDjucLS6c+uwwYxpMqFpEqvJvD221G
	Co768t1utmjTK9Dox7xKBZNc9ObVWqVgHTpNEi2JBGh+LTYPH4RVjJ2maYz2PksPmxFUTX
	yNH9UUD/dNoLgMNy2mfERcbPlgzvg/9J/Lncq8nSV1swVxQ2mRqFBBFGjEhFqJYA4WfykM
	Vgt9S6A+KpZ2KihPEK32Q/BMuBh7YSUpjQzxk9s+dUmU/dgTmCxyzKqhbPVw3g==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 May 2026 14:49:23 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Nerijus_Bend=C5=BEi=C5=ABnas?= <nerijus.bendziunas@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: skip EEE advertisement write when
 autoneg is disabled
In-Reply-To: <20260516150251.879680-1-nerijus.bendziunas@gmail.com>
References: <20260516150251.879680-1-nerijus.bendziunas@gmail.com>
Message-ID: <f8cb33492160a3d75669c573913a363f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249583-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev];
	TAGGED_RCPT(0.00)[stable,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8F66057F21F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Nerijus

On 16.5.2026 17:02, Nerijus Bendžiūnas wrote:
> genphy_c45_an_config_eee_aneg() writes the EEE advertisement to the
> auto-negotiation device's MMD register space (MDIO_MMD_AN, register
> MDIO_AN_EEE_ADV).  These registers are read by the link partner only
> during auto-negotiation, so writing them while autoneg is disabled
> cannot influence the link.  On some PHYs (e.g. Broadcom BCM54213PE)
> the write nevertheless reaches the chip and disturbs the receive
> datapath.
> 
> Concretely, running
> 
>     ethtool -s eth0 speed 100 duplex full autoneg off
>     ethtool --set-eee eth0 eee off
> 
> leaves eth0 with TX working and RX completely silent on a
> Raspberry Pi 4 / CM4 board (bcmgenet + BCM54213PE in rgmii-rxid).
> Switching back to autoneg recovers the link.
> 

Can confirm this. A quick look at the BCM54213PE datasheet shows that 
EEE is
only applied if autoneg is enabled (as expected). With autoneg disabled 
it
is undefined behavior, but clearly breaks communication.

> [...]

> 
> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index d48aa7231b37..126951741428 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -940,6 +940,14 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_eee_abilities);
>   */
>  int genphy_c45_an_config_eee_aneg(struct phy_device *phydev)
>  {
> +	/* Writing MMD AN advertisements while autoneg is disabled has no
> +	 * effect on link-partner negotiation, but on some PHYs (e.g. the
> +	 * Broadcom BCM54213PE) the write itself disturbs the receive
> +	 * datapath. Skip it.
> +	 */
> +	if (phydev->autoneg == AUTONEG_DISABLE)
> +		return 0;
> +
>  	if (!phydev->eee_cfg.eee_enabled) {
>  		__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai

