Return-Path: <stable+bounces-215643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBN2O9UKi2lQPQAAu9opvQ
	(envelope-from <stable+bounces-215643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:39:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B95119B48
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D6023018432
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C44431690A;
	Tue, 10 Feb 2026 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbeGcdok"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8793168E1;
	Tue, 10 Feb 2026 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719955; cv=none; b=m1fUzQFhByNkuO6NvTakUv8WXrhzwuAq42nYaeLpAmJDXW5LbnNj/SgIqmc4UDYAZ35UcSfWK8dxigrGeFN85asSwDpS8TH2kAyG9TG4FnkbLuQfj1vbxE9lEjXtPvu7GyO8vmBDue/ONjwVCjdZSdRNdbRFnpm8zyuaz0oqVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719955; c=relaxed/simple;
	bh=EXWvU3l3SxXvylYPwC9SWvwtV6vz8L7IbmmOR0Dymk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCdVYXKHMqy5mf0IvGcKPlmanBERNlhBR3BZIDxXpNymqdZ5UPhfOJbzFe7nRXTSgceRiqCF/NIaJBh2AK3IDdGwBzq0AewLnoKAXfpT+FWmFaldHUessFYcqXHNwSGkg0gaziM3IasFehpEzBz0PArSwh9zGne4+GCxGM8bxa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbeGcdok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CEAC116C6;
	Tue, 10 Feb 2026 10:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770719954;
	bh=EXWvU3l3SxXvylYPwC9SWvwtV6vz8L7IbmmOR0Dymk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kbeGcdokdoZtL526Ut5lHEGDQMLybi9mbob1t+oHUu1v3rGDonbM4TG2GVgTgvG5+
	 TXeE70YdEISkjLc+TrrIhwXsROXyntdKC0HFYGiJ/cHXvNfoo94UpPtjznEqovP8/U
	 uC27PVwY93HRVWsW+AQZgdZrLVpgb5dH5uEoZcxtX59SxF5Dy66zoYzXaASec7WgIf
	 5MoHvbSXiv30StxC8iwTQk7nwpwlXfb5RSFdDiApeb2WQpd+kmdi2vkfCwpid1Wrzo
	 ddNAChSAwUPnSLsVI35n1ebUxLkgUij41k9i4BR8RjN4aAkc9nltBGOgLI62RhXZZf
	 zDVJ1GEyx7b7g==
Date: Tue, 10 Feb 2026 11:39:08 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Aksh Garg <a-garg7@ti.com>
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
Message-ID: <aYsKzBjmGEi1z0am@ryzen>
References: <20250922140822.519796-5-cassel@kernel.org>
 <20250922140822.519796-7-cassel@kernel.org>
 <2fedf28e-83ea-4e51-b1a1-e45f0e928509@nvidia.com>
 <aYonDJyd_dbV0GBK@ryzen>
 <94458c39-587b-4bb4-a410-e921e5d99f10@nvidia.com>
 <aYsDDOZA18BBeOsd@ryzen>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYsDDOZA18BBeOsd@ryzen>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215643-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,wdc.com,vger.kernel.org,google.com,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84B95119B48
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:06:04AM +0100, Niklas Cassel wrote:
> BAR_RESERVED already means disabled, it just assumes that an EPC driver
> disables all BARs by default, which is the case for:
> pci-dra7xx.c, pci-imx6.c, pci-layerscape-ep.c, pcie-artpec6.c,
> pcie-designware-plat.c, pcie-dw-rockchip.c, pcie-qcom-ep.c, pcie-rcar-gen4.c,
> pcie-stm32-ep.c, pcie-uniphier-ep.c.
> (All drivers which disables all BARs by default in the init() callback using
> dw_pcie_ep_reset_bar(). pci-epf-test will later enable all BARs that are not
> marked as BAR_RESERVED.)
> 
> That leaves: pcie-keembay.c, pci-keystone.c, pcie-tegra194.c (before my patch).
> 
> For pcie-keembay.c, this is not a problem, because BAR0, BAR2, BAR4 are marked
> as only_64bit, so pci-epf-test configure these BARs as 64-bit BARs, and thus
> BAR1, BAR3, and BAR5 will get disabled implicitly.
> 
> For pci-keystone.c, this is the only driver that is a bit weird, it marks
> BAR0 and BAR1 as reserved, but does not disable them in the init() callback.
> It seems force set BAR0 as a 32-bit BAR in the init() callback.
> 
> Thus, for all drivers except for pci-keystone.c, BAR_RESERVED does mean
> BAR_DISABLED. Feel free to send a patch that renames BAR_RESERVED to
> BAR_DISABLED.
> 
> If you send such a patch, perhaps you also want to modify the PCI endpoint
> core to call reset_bar() for all BARs marked as BAR_RESERVED/BAR_DISABLED,
> instead of each EPC driver doing so in the init() callback. I think the main
> reason why this is not done already is that thare is no reset_bar() op in
> struct pci_epc_ops epc_ops, there is only clear_bar() which clears an BAR
> enabled by an EPF driver. (So you would most likely also need to add a
> .disable_bar() op in struct pci_epc_ops epc_ops.)

Aksh (on To:),

since you have a @ti.com email, perhaps you can explain how pci-keystone.c
can pass all the pci-epf-test test cases, considering that this is the only
driver that has BARs (BAR0 and BAR1) marked as BAR_RESERVED but do not also
disable the BARs (using dw_pcie_ep_reset_bar()) in the init() callback.

Or, perhaps the simple answer is that pci-keystone.c does not pass all
pci-epf-test test cases?


Kind regards,
Niklas

