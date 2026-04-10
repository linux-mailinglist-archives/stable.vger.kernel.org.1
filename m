Return-Path: <stable+bounces-235677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JCJEIB/2WmjqAgAu9opvQ
	(envelope-from <stable+bounces-235677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:53:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 350F53DD574
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 364CD3016D0F
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3740636CDE2;
	Fri, 10 Apr 2026 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlDXbIlb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ECE34107A;
	Fri, 10 Apr 2026 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861623; cv=none; b=J/ny/TCrRT7geIPwAvkq4+HhlUFnm+aRaiZb0fXiXIvWYLuP4oHf5tCTxS5D1+XVl86F+vMfPVe1Kkpuj17iGSn15KEJ911Xi2meFZqlp5wpBVRjcL4N9erc7koFMESaf9hZx0s4rSJWuyASmckwivsHBh1c5XLz2oUGVs8aLJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861623; c=relaxed/simple;
	bh=9VBjNQAzbB9vwgFa9GsT6+N9W2jFYIIY2jEQ/4Yjw7E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cBVaQNhJW+bR1SPOWc8tir03p0lw0ageLFS/VRcFcFBVGFw3HayOQxT0aoU9IFaHuEdFl6qYC5/An0zUQXngHJprZuU0OmlFx4Yn6P2C+BLmT5rgwMABiZgsVv3uRMKVEpn/qJx9vEDnrV4PpNEgdrtFEHBquvDqrfdDXtgJFVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlDXbIlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1193CC19421;
	Fri, 10 Apr 2026 22:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775861623;
	bh=9VBjNQAzbB9vwgFa9GsT6+N9W2jFYIIY2jEQ/4Yjw7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JlDXbIlbK5X40pJZvtF0DRYkDEl98GwzuiRxiheKDsqyaB3Tmemx7eemj1/VWTZtd
	 O50M1m/s7YWxzlT4PVxQB+OXsHFxvsOFWVEKuEASn1qzDyIiNdBmSQpyoptDTtItn/
	 fziGS/McdLELE72g+lmuXFc3SPDW7ulyP5gVM+jju34DQ9L6IbPiYYrDzWfCRAX6ds
	 zvU4ZpefRlXXQEeuD4G+xDVGr+Bcw/M80+N+ORk40JJsMkX4n6WgRuKcRj6ocNQbDy
	 6kKvOkowpl4YDki/Z22Hd5lVxjf8tyIpR2JBKaWfMYI3oDFVhgCDHb2TNMnhPJIEJa
	 PbAosXJR4dLpA==
Date: Fri, 10 Apr 2026 17:53:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "mani@kernel.org" <mani@kernel.org>, Frank Li <frank.li@nxp.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
 suspend skip
Message-ID: <20260410225341.GA598942@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB883374CBFD3C97CE54DFB4C48C5BA@AS8PR04MB8833.eurprd04.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235677-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,pengutronix.de,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,i.mx:url]
X-Rspamd-Queue-Id: 350F53DD574
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 02:38:35AM +0000, Hongxing Zhu wrote:
> ...

> One additional note regarding NVMe: ASPM (Active State Power Management) is
> disabled locally on i.MX platforms for NVMe devices. This decision was made
> after encountering a system hang issue similar to the one reported by Hans a
> few months ago in his patch listed below.
> https://lore.kernel.org/linux-nvme/20250502032051.920990-1-hans.zhang@cixtech.com/

Where is ASPM disabled for i.MX?  I don't see anything in pci-imx6.c.

It doesn't sound architecturally clean to me to disable ASPM based on
whether an NVMe device is involved.

