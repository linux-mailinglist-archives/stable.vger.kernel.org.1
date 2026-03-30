Return-Path: <stable+bounces-231149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LO4FHtPymlr7gUAu9opvQ
	(envelope-from <stable+bounces-231149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:24:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B20359284
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82DBE3068EC6
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734243BE15F;
	Mon, 30 Mar 2026 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUFoVZC8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334173BAD84;
	Mon, 30 Mar 2026 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865940; cv=none; b=PjdF9FeL8Jaqo8vO6sqBh3w6DL520ZOX1Y6OZiaw0cFmhL3sgn2jnTkFDbSGiaSf9T/Ajux6b2AzpD0z8tbk2YWHXLXEZ1i5y7EXZTCgWwfGeHItGQk7w+KsQxkCNpPMd/Qz5guooqpR1/m4L1QBXhwJNWTHOkP0w3O+Vs9UvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865940; c=relaxed/simple;
	bh=zkPIFYlcvlNBwRpjkVxQHKinU444u5TIQ3o5lO3cjw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQLt/KVYnGZ0+Nf2HFZWinytp//pyZ3AdooOTqrTTsBD78IZWBV8BOvDCo619KK9h9AsOtAEbHHYEH2hrHFX99RbNKEZj7n1t+fmppZNfnr/v81bxg5kWc4h9jcnve1xJXp434jyqDsFypKUlku+0DVYO4ssTrgCOjuuGGLV4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUFoVZC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7C5C4CEF7;
	Mon, 30 Mar 2026 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774865940;
	bh=zkPIFYlcvlNBwRpjkVxQHKinU444u5TIQ3o5lO3cjw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mUFoVZC8BT1abPQSVnwCo6KS/5EN1PEfjba+c1Plp7X8QHOibbkg4xN9DTDdknSPj
	 TPpYZ+91NJut/Gv5uOiDwUSvKqC27NJdvQhVewydS3Y2FM9s8xlLFVd5UFAjJZdL+6
	 BYgrQpculCEb85wKPXecIjQvOieHuFBruJz8jyRbW+sUrlbMqwhAwXqKvn3RlXT62S
	 5l78j+fxjTqNRDLlFsa5GzNaCobxmacRLJ8HuScxl1OsVBE2G0cw7wYt3hBr8CMoA6
	 TYqUq8KJagKnoL/Q5W05nSgNtBj7ogoC1TJ6AdVvJ/HYdaUsLHUcYg+8jrNpsthpEz
	 /Gm+wjW1iKHCw==
Date: Mon, 30 Mar 2026 15:48:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, 
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH v2] PCI: imx6: Don't remove MSI capability For
 i.MX7D/i.MX8M
Message-ID: <5nom7wnhrr57jvb6komumg3fjkbavsq5ecz2pd43rc5tsmnqev@ag6ld453s2lu>
References: <20260319091823.446030-1-hongxing.zhu@nxp.com>
 <kqv3x4qocp7rkas5oedlpzd43h3ez7dg26hqnfgubbjdhhxlwe@rfnsicbv7qba>
 <AS8PR04MB8833AE3B8D106CE446EF89E58C52A@AS8PR04MB8833.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8833AE3B8D106CE446EF89E58C52A@AS8PR04MB8833.eurprd04.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231149-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,kernel.org,google.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: B2B20359284
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 09:02:57AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > Sent: 2026年3月30日 15:23
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > kwilczynski@kernel.org; robh@kernel.org; bhelgaas@google.com;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org; stable@vger.kernel.org;
> > Qiang Yu <qiang.yu@oss.qualcomm.com>
> > Subject: Re: [PATCH v2] PCI: imx6: Don't remove MSI capability For
> > i.MX7D/i.MX8M
> > 
> > + Qiang
> > 
> > On Thu, Mar 19, 2026 at 05:18:23PM +0800, Richard Zhu wrote:
> > > The MSI trigger mechanism for endpoint devices connected to i.MX7D,
> > > i.MX8MM, and i.MX8MQ PCIe root complex ports depends on the MSI
> > > capability register settings in the root complex. Removing the MSI
> > > capability breaks MSI functionality for these endpoints.
> > >
> > 
> > What is the relation between Root Port MSI and endpoint MSI? Endpoint MSIs
> > should be routed to the platform MSI controller (DWC i.MSI-RX or External like
> > GIC-ITS) independent of the Root Port MSI state.
> Hi Mani:
> Thank for your kindly concern.
> The MSI controller (DWC i.MSI-RX) on i.MX7D, i.MX8MM, and i.MX8MQ platforms
> requires the RC's MSI capability to remain enabled. Removing it breaks MSI
> routing from endpoints to the platform MSI controller.
> 

I understand that MSI is broken on your hardware, but I was trying to understand
'why' specifically. Because, Root Port MSI capability doesn't have anything to
do with the endpoint MSIs. And since you mentioned that this issue happens only
on one platform, could be that the hardware designers have mistakenly wired the
Root Port's 'MSI Enable' to iMSI-RX's enable signal or something similar?

If so, we can introduce a flag 'dw_pcie_rp::keep_rp_msi_en' or something
similar, set it for affected SoCs and skip the capability removal in
pcie-designware-host.c

- Mani

-- 
மணிவண்ணன் சதாசிவம்

