Return-Path: <stable+bounces-210757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBZ6DcXYcGkOaAAAu9opvQ
	(envelope-from <stable+bounces-210757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:46:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F9757C73
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ADD6F4EBE30
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8341A481FA3;
	Wed, 21 Jan 2026 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LJWr3+y2"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF073BC4CE;
	Wed, 21 Jan 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001730; cv=none; b=e+QftvsWo2s03pmi6gb6ow5J2uF+P0LwtmxulH4bOIcZ6xKuRsDtf4yr2hYqSu+ruSKWwBZGhMPOk7mM7P0/mzMhgLak1d+4XJlFFafXxQl0a7CDN7zqa8QUT+rdB+L8b5PEaDMfJ3t7bfBLAgVPmUBw3cJfJnC1RJLVI4cfRTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001730; c=relaxed/simple;
	bh=MQSzl+4nqOijdGa5k2w8X7c/UD0ynPlSkFE9VBKNSkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJH/39LkOMqCpQFx+w7ciY/nux8Bhg01/jCFQxIpJ8Xjn54W6Oqq6YQCdIrdtdb2Q8aWEz9APq3bzxC/+Q3GZwjjY0qaocYUia/5uMpmxbHeg9zkAC//1wlam7/yLWH7qCObYhQCtFrHT/Bjss8Ppjc39J9WrIEKmmiPXMPo5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LJWr3+y2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h8u/ykkVY6Qh746PzwCjfRYHw91IzldDAx4C04yrZ78=; b=LJWr3+y2k3VQPMYowZWyW+OLQ5
	d6isFOBsOLwtJETmABPUnAbF0lxzfrWfHiQsP3dHC7bSzDqyP5F4DiYyJwSRRllhlhBB4yXMV04sz
	t2xR672cZXCz+7MsrceKGgc2fRjrCja7/GOT7+NkuTc0XimqEgtnNqn41oHb+07dIEEc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viY9s-003oz2-E5; Wed, 21 Jan 2026 14:22:04 +0100
Date: Wed, 21 Jan 2026 14:22:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bb@ti.com, afd@ti.com,
	p-bhagat@ti.com, gehariprasath@ti.com, stable@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62d2-evm: Fix missing RX delay
 for DP83867 PHY
Message-ID: <32265181-6a16-4cb3-9cc8-52d4265c6646@lunn.ch>
References: <20260121054552.1650926-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121054552.1650926-1-s-vadapalli@ti.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210757-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[lunn.ch,none];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[stable,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: C5F9757C73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 11:15:50AM +0530, Siddharth Vadapalli wrote:
> MAC Ports 1 and 2 of the CPSW3G Ethernet Switch in the AM62D2 SoC are both
> connected to different instances of the DP83867 Ethernet PHY on the AM62D2
> EVM, with the 'phy-mode' set to 'rgmii-id'. The DP83867 Ethernet PHY has to
> add a 2 nanosecond delay on receive (from wire) based on the EVM design.
> 
> Since the device driver for the DP83867 Ethernet PHY coincidentally assumes
> that a 2 nanosecond receive delay has to be added in the absence of the
> 'ti,rx-internal-delay' property, Ethernet is functional.
> 
> However, since the device-tree is intended to describe the Hardware, and,
> the device driver for the DP83867 Ethernet PHY may change in the future,
> add the 'ti,rx-internal-delay' property and assign it the value
> 'DP83867_RGMIIDCTL_2_00_NS' which corresponds to a 2 nanosecond
> delay.

The driver will not change. Doing so will break boards, causing
regressions. Also, passing PHY_INTERFACE_MODE_RGMII_ID to the PHY
means the PHY should add 2ns, or the closet it can achieve. The PHY
driver does not coincidentally assumes that a 2 nanosecond receive
delay is required, it is required a 2ns delay is added.

So this patch is pointless.

Please drop it.

       Andrew

