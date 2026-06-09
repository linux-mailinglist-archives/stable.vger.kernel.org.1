Return-Path: <stable+bounces-262242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vkuLF2/iJ2oO4AIAu9opvQ
	(envelope-from <stable+bounces-262242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 11:52:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2685065E905
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 11:52:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=kmxxbabX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262242-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-262242-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24D2030851B1
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 09:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF233F4105;
	Tue,  9 Jun 2026 09:47:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD33F4115;
	Tue,  9 Jun 2026 09:47:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998440; cv=none; b=WW/UFFtfXD9esLfaIMuE2OiANlo+QPfI3sKg27+Hbep0UaBVz95QCW+ummdLZhuv43BbMyczVMdLR2/Xw8Enqx7qRUMtdToCyI38Gc9rtKYVB2PpEIo9cYdqqH1MwnEvEAwx74xGO7YoyI3LjcyhwvE+MmFnOA3k23Bdnc6jHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998440; c=relaxed/simple;
	bh=LuS36RU+WTuUwwvmG/HT9IVsmodfFZAdD+e4eG1mM50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrlFn5TBTdEA/g4SbCbffoKzVvhvnqdj+gPH8mgd2vLv9e5to1FbTaUabQ/aPlUKeaUAQM221PFLA19XPO/HiPE+DTt/hM4vIYSHcLvuGN5HO6woVFgIrlitB1HsJ48qCD+aZMR49GR2tKDc0Kpgm0OGBctaaVTDr/uwRxcGSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kmxxbabX; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1wE2Dps9NRUxIbcRxIJ0e8icPNgC1+yiq+5OV8gGLi4=; b=kmxxbabX74Inj11UcnqdrSIi8L
	uaG/r/JAoLcyCVqri1rUeVpMyeW0FdaBD9PBTilk1hK5liflQGHQYp+4wOioYpz2lNddvoGUAXECR
	0qdU5O2QVrmDK+AE/QaT5sSV6CAhkAFYyAjYCVULFovxNeGOv8+Be2Lk62wMvlSO8faQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWt33-006m7g-J3; Tue, 09 Jun 2026 11:47:05 +0200
Date: Tue, 9 Jun 2026 11:47:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mdio-airoha: fix refcount leak in airoha_mdio_probe()
Message-ID: <a3757265-9487-4f75-9bdf-dcb38dff4022@lunn.ch>
References: <20260609090729.219120-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609090729.219120-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262242-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2685065E905

On Tue, Jun 09, 2026 at 09:07:29AM +0000, Wentao Liang wrote:
> In airoha_mdio_probe(), after calling reset_control_deassert(),
> if clk_set_rate() fails, the function returns immediately without
> calling reset_control_assert().  This leaves the reset line
> deasserted and causes a reference count leak on shared reset
> controllers.  The devm cleanup does not assert the reset line, so
> the unbalanced deassert persists.
> 
> Fix this by adding a reset_control_assert() call on the
> clk_set_rate() error path, matching the existing error handling
> for devm_of_mdiobus_register().
> 
> Cc: stable@vger.kernel.org
> Fixes: 67e3ba978361 ("net: mdio: Add MDIO bus controller for Airoha AN7583")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/mdio/mdio-airoha.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mdio/mdio-airoha.c b/drivers/net/mdio/mdio-airoha.c
> index 52e7475121ea..030482b8318f 100644
> --- a/drivers/net/mdio/mdio-airoha.c
> +++ b/drivers/net/mdio/mdio-airoha.c
> @@ -245,8 +245,10 @@ static int airoha_mdio_probe(struct platform_device *pdev)
>  		freq = 2500000;
>  
>  	ret = clk_set_rate(priv->clk, freq);
> -	if (ret)
> +	if (ret) {
> +		reset_control_assert(priv->reset);
>  		return ret;
> +	}
>  
>  	ret = devm_of_mdiobus_register(dev, bus, dev->of_node);
>  	if (ret) {

devm_of_mdiobus_register() also calls reset_control_assert() on
error. So please put all the error cleanup handling at the end and use
goto.

    Andrew

---
pw-bot: cr

