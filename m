Return-Path: <stable+bounces-215646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP+1DPwQi2l/PQAAu9opvQ
	(envelope-from <stable+bounces-215646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 12:05:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F3A119FB2
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 12:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 649323073F53
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A633612E8;
	Tue, 10 Feb 2026 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wft85wPu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D7C34CFBB;
	Tue, 10 Feb 2026 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721473; cv=none; b=pC8N3tWv+N5+DHPGC6XxReCfkZqGoZThaWCtIJMufEYGDLNKODgmvLLRaG0QRSiTWkBOVAp31b+nFoDlDwrjSG899dkWjnK7AKU6KcBI4I6xRuzYn6EToAa6sfZwv6zWFrHLC4wPFQ6hkVU6EJAoNC7ITDxkHNRR65o0Ce5kNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721473; c=relaxed/simple;
	bh=7yZxFkNNQCJkdJ9pJ8Eclg+/98lS5/890gc/MqlDytE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpM8/6Pg6r+Sv0YPGiaV34enGTmpiBHXkoDZoVOrn3qSAZAsGZhRjIivcInMyNTVJkJxQsbMW6TKTNqF9yRgeQgnulAMLVxKAACixVxq46+PSMywfxSgXL8hYmeD9LfZxraI86jIIuY9LWOun4+JHVCsAbRnFn2OapQuvAnwNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wft85wPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8200BC19423;
	Tue, 10 Feb 2026 11:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770721473;
	bh=7yZxFkNNQCJkdJ9pJ8Eclg+/98lS5/890gc/MqlDytE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wft85wPujxS+9BjK2WLUDPsGY6vtTTreoK9vPzH9LeH9UgyXeKZFuQ63xNu4VKecU
	 JPHBfH4t0OuagB0TGt6HZgqJnXcX0/97je7QQK1PtjNdtE4D21Kped2mkXpva0KPYX
	 SL/6UB/pTKm3unBM71PslUCqZt4qddum7pbDFPnGKxiE20d3zUNBSqcY7jGhc4WQwG
	 7bgOesbGPXv7RS0/TsDtiAgbTlwaAXnrUmrCeD3X9nxaqwinK/d3A5L1ml4leDi7Uq
	 7DpeZR1XYO80lqYHfnHwTVfyCxgkcBLvS9lOrsK5ysDNM2FYHE33/cZku1NWXMi7Mf
	 Ui2wBaYWwSIyQ==
Date: Tue, 10 Feb 2026 12:04:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: tegra194: Reset BARs when running in PCIe
 endpoint mode
Message-ID: <aYsQu9lQi4IzfBiP@ryzen>
References: <20250922140822.519796-5-cassel@kernel.org>
 <20250922140822.519796-7-cassel@kernel.org>
 <2fedf28e-83ea-4e51-b1a1-e45f0e928509@nvidia.com>
 <aYonDJyd_dbV0GBK@ryzen>
 <94458c39-587b-4bb4-a410-e921e5d99f10@nvidia.com>
 <aYsDDOZA18BBeOsd@ryzen>
 <c8e42e96-212f-451d-802b-7166611f6fcd@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8e42e96-212f-451d-802b-7166611f6fcd@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215646-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,wdc.com,vger.kernel.org,google.com,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9F3A119FB2
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 04:09:05PM +0530, Manikanta Maddireddy wrote:
> > For pci-keystone.c, this is the only driver that is a bit weird, it marks
> > BAR0 and BAR1 as reserved, but does not disable them in the init() callback.
> > It seems force set BAR0 as a 32-bit BAR in the init() callback.
> > 
> > Thus, for all drivers except for pci-keystone.c, BAR_RESERVED does mean
> > BAR_DISABLED. Feel free to send a patch that renames BAR_RESERVED to
> > BAR_DISABLED.
> > 
> > If you send such a patch, perhaps you also want to modify the PCI endpoint
> > core to call reset_bar() for all BARs marked as BAR_RESERVED/BAR_DISABLED,
> > instead of each EPC driver doing so in the init() callback. I think the main
> > reason why this is not done already is that thare is no reset_bar() op in
> > struct pci_epc_ops epc_ops, there is only clear_bar() which clears an BAR
> > enabled by an EPF driver. (So you would most likely also need to add a
> > .disable_bar() op in struct pci_epc_ops epc_ops.)
> > 
> pci-epc.h defined
> 
>  * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
> 
> I believe you are interpreting this as unused BAR?
> 
> In Tegra PCIe, BAR2 and BAR4 are backed by PCIe HW memory which
> 
> shouldn't be touched by EPF, but should be kept enabled.
> 
> This support is not available. I suggested to add BAR_DISABLED
> 
> for unused and use BAR_RESERVED for bars like above.

I understand what you want. You want to have a BAR_RESERVED and a
BAR_DISABLED.

Sounds like a nice feature. Feel free to add that.


But like I mentioned in my reply, for all existing drivers, except for
pci-keystone.c, in practice BAR_RESERVED actually means BAR_DISABLED.
(Since all drivers except for pci-keystone.c call reset_bar() in init(),
and pci-epf-test will not enable BARs marked as BAR_RESERVED).

So if you add a BAR_DISABLED, make sure that you convert all existing
uses of BAR_RESERVED (except for pci-keystone.c) to BAR_DISABLED.

pci-keystone.c and pcie-tegra194.c can then be the only drivers that
have BARs marked as BAR_RESERVED (all other drivers would use BAR_DISABLED).

Please just make sure that you don't regress the amount of currently passing
pci_endpoint_test test cases that are passing for pcie-tegra194.c.
(Which would be the case if you revert the patch in $subject without first
adding your proposed new BAR_DISABLED, such that we can have a distinction
between BAR_DISABLED and BAR_RESERVED.)


Kind regards,
Niklas

