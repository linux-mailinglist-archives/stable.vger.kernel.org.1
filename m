Return-Path: <stable+bounces-214328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDsgLUNwg2lgmwMAu9opvQ
	(envelope-from <stable+bounces-214328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:13:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F071EA057
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4EC230055B9
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CB8423A64;
	Wed,  4 Feb 2026 16:13:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A77B238171;
	Wed,  4 Feb 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221633; cv=none; b=nk5bebffjZPNhOoNcEYTO89Zbgismq4HiCWGGpiiEhmRgCP8BEDHK864t3qFadnSRQp9y6lVsvdJAFolvBweUESqASluDBotf54RCs3vKGHwJbfs8GW3PYOcmjPaf8LPjFdh2hwHEkP+EBTF/aaM0XwedPPkNjznatuDSn0QamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221633; c=relaxed/simple;
	bh=3510jWJU6BaX1/NwPtwvhKUWAy8G/HuxQvk3XEutA2g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XZFNQtJCAeA+/BInyRhQAIs/X6MIiLhTSDXoQ+IeGBQDSBPZdSQMqneDAVYBbe4EsPzJKE2hRAGeBY+CTlqJBQbDJ89xkZIPvywQwPirOlu7VgzQQ6Pic1d84eHvmE+2itqMeiR9xqGCkIaNJyukBNJXnNMRDhpGxrEPn7TkVGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id EF97992009D; Wed,  4 Feb 2026 17:04:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id EC6CE92009C;
	Wed,  4 Feb 2026 16:04:26 +0000 (GMT)
Date: Wed, 4 Feb 2026 16:04:26 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Niklas Cassel <cassel@kernel.org>
cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Frank Li <Frank.Li@nxp.com>, Randolph Lin <randolph@andestech.com>, 
    Samuel Holland <samuel.holland@sifive.com>, 
    Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com, 
    Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    dlemoal@kernel.org, stable@vger.kernel.org, 
    Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PCI: dwc: Fix msg_atu_index assignment
In-Reply-To: <20260127151038.1484881-6-cassel@kernel.org>
Message-ID: <alpine.DEB.2.21.2602041601380.12532@angie.orcam.me.uk>
References: <20260127151038.1484881-5-cassel@kernel.org> <20260127151038.1484881-6-cassel@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214328-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,nxp.com,andestech.com,sifive.com,redhat.com,oss.qualcomm.com,vger.kernel.org,rock-chips.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.964];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,angie.orcam.me.uk:mid]
X-Rspamd-Queue-Id: 5F071EA057
X-Rspamd-Action: no action

On Tue, 27 Jan 2026, Niklas Cassel wrote:

> When dw_pcie_iatu_setup() configures outbound address translation for both
> type PCIE_ATU_TYPE_MEM and PCIE_ATU_TYPE_IO, the iATU index to use is
> incremented before calling dw_pcie_prog_outbound_atu().

Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>

-- with SiFive FU740 RISC-V SoC onboard a HiFive Unmatched system.

  Maciej

