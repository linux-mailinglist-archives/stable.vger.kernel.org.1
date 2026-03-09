Return-Path: <stable+bounces-223656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKo2J4jOrmnEIwIAu9opvQ
	(envelope-from <stable+bounces-223656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:43:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F416F239E9D
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99794307F29B
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D8B38553A;
	Mon,  9 Mar 2026 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tbxmrtHr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67359375F86
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063732; cv=none; b=p14ajIYIhkwKxTZ26Cn528C1cdCwH5sTCmfdmu8d1f/oF7YBUzo8QDG7NP5KUgqT3bUzA1W+5Y8WDajsF63OPNa4l4F36gHqVvoIH/pKonc77Yv8qAolfOrwCjXe6Z2nu19y9G1GkbQ3o02GdJt8rQi6P2vRu1nl9yXAtYydrpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063732; c=relaxed/simple;
	bh=Cnbixcb5t35c9TUNkScnwzzSFZPpCMcGKmEs6KY/Ao0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ41e99NL82vTwEyoFUVe47ztdrF5BEtihq0wbcjx+Kmxsq82aRnvSpC0PqjMnjOQq4Is3o2BRCX+bMMPVLMAAakSy3DNLlguUJPer0PZu8/nF/7fU0pL/pI7gngv8grZelXBq5EL76tKWt6kkNUJkjENt3Fp18TneyoqF8Cl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tbxmrtHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE343C4CEF7;
	Mon,  9 Mar 2026 13:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773063732;
	bh=Cnbixcb5t35c9TUNkScnwzzSFZPpCMcGKmEs6KY/Ao0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tbxmrtHrXVNMFj2aGfzYA+fCdNJludid1CbJhpji8YIyN3WKhFxI3wJ/dxEVKpvS4
	 Cxnu0t5Do2AFMLQ5rUF5/GP5pX/Lc0D/uJJ7YNW+t59oUy2iNi7unTJ1f+mkC6h4Y/
	 Q/TyEzSaVvl8v30N3i+MGS9HPNbSW7UrMxBf6ddA=
Date: Mon, 9 Mar 2026 14:42:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.18.y 0/1] net: stmmmac: Fix lpi_intr_o interrupt storms
Message-ID: <2026030900-twitch-maternity-1792@gregkh>
References: <20260306150502.23713-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306150502.23713-1-ovidiu.panait.rb@renesas.com>
X-Rspamd-Queue-Id: F416F239E9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-223656-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.010];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 03:05:01PM +0000, Ovidiu Panait wrote:
> Backport upstream commit 14eb64db8ff0 ("net: stmmac: remove support
> for lpi_intr_o"), to fix Ethernet interrupt storms on the Renesas RZ/V2H
> and RZ/V2N platforms.
> 
> The stmmac lpi_intr_o sideband signal is synchronous to the PHY RX clock,
> which can be stopped by the link partner while the interrupt is still
> asserted, causing an interrupt storm. Since the lpi_intr_o interrupt
> serves no useful purpose and it causes issues, it was removed in mainline.
> 
> Russell King (Oracle) (1):
>   net: stmmac: remove support for lpi_intr_o

>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 -
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  |  7 ----
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 --
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 36 -------------------
>  .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 -----
>  include/linux/stmmac.h                        |  1 -
>  7 files changed, 59 deletions(-)
> 
> -- 
> 2.34.1
> 
> 


What about 6.19.y?

