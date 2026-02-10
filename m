Return-Path: <stable+bounces-215636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMq6AlsEi2kMPQAAu9opvQ
	(envelope-from <stable+bounces-215636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:11:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A361197A2
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ED953066414
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9F4346E46;
	Tue, 10 Feb 2026 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HueU6L61"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45C3446B7;
	Tue, 10 Feb 2026 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770717970; cv=none; b=AgOYGKpRUgJFmY5ZqyVtbL8tw+GsLpGx4I+iQEzOTNyr8o0WSyhlsBsEfDR1wjXaFfT9dDcljZQe0m9bXcfRlM+GwJVx/+ZAd4B4D1Z02AJOr3Yx9mRqAFwotPRaidxKP2myenxjzuwhyeO8ObiSo5f34Ft52BZsDjA7kvZUK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770717970; c=relaxed/simple;
	bh=E07rW57XvUp9dRCWusGbgPrZsQXq2+KThzrSXX8KsSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiPRYTBfNwnGpdkprAfNGZbobF9GfuAGvHyTqZUi5SwkJdrCqkXbWEIFIDWdjzLUTdI2UI/mmCZnRGC1IzfMSqZtO+KfxI+qOcxXAUkDPAtCxZJm9bj8omyLy8Np8Xi9Fn5Flq2cIeAZ07DBKa8JMndOAzTjHKkX6VJkoo4LAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HueU6L61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C56C116C6;
	Tue, 10 Feb 2026 10:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770717970;
	bh=E07rW57XvUp9dRCWusGbgPrZsQXq2+KThzrSXX8KsSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HueU6L61WhjpwVG61pkiebO4T1YOTik3YStQ1CA89k8JtPhYXv6Isn7xjvDkuG9ZW
	 u/3MALLxPQkBT9k0CSUQZmRDkY5xb3EZEFSx9sNChsJ5AW4sva/e9JZEcjgBaWp7a0
	 Y+IT3a2aVRLZIwyxa2VbLZtwosOIdBvXLgVCARQ1DxA1brre55YVAIskV1oQGO50mw
	 0BBPVmU0venNiNgMjdghnzGdgwT4my9vPe6B+onEzZ5h28/ACsddgcL3p1d4tyUZAX
	 GlhpxF01XgYakiNI54pHw80wKEdiHMALJbcJFSCjdedWUFhFJpYMEUzvKqmjwvavOj
	 4J7xyAJ3wBDZA==
Date: Tue, 10 Feb 2026 11:06:04 +0100
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
Message-ID: <aYsDDOZA18BBeOsd@ryzen>
References: <20250922140822.519796-5-cassel@kernel.org>
 <20250922140822.519796-7-cassel@kernel.org>
 <2fedf28e-83ea-4e51-b1a1-e45f0e928509@nvidia.com>
 <aYonDJyd_dbV0GBK@ryzen>
 <94458c39-587b-4bb4-a410-e921e5d99f10@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94458c39-587b-4bb4-a410-e921e5d99f10@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-215636-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: A8A361197A2
X-Rspamd-Action: no action

Hello Manikanta,

On Tue, Feb 10, 2026 at 09:40:44AM +0530, Manikanta Maddireddy wrote:
> > On Sun, Feb 08, 2026 at 11:41:42PM +0530, Manikanta Maddireddy wrote:
> > > Hi Niklas,
> > > 
> > > Tegra PCIe exposes only DMA register over BAR4, not iATU.

Here you claim that DMA registers are exposed in BAR4.


> Hi Niklas,
> 
> In Tegra234 PCIe, BAR1 is MSI-X table and BAR2 is DMA registers backed
> by PCIe HW RAM and registers.

Here you claim that DMA registers are exposed in BAR2.
Which one is it?


> EPF driver shouldn't allocate memory for
> these two BARs. This is the reason for marking them as reserved in
> Tegra PCIe driver. DMA registers are exposed over BAR2 to allow
> PCI client driver in host to transfer data from host to endpoint
> using endpoint remote DMA read functionality. BAR test fails on this
> because not all register bits are writable. Consider NVMe example
> which has RO capability bits at the start of the BAR, it is not correct
> to add BAR test on these bits.

Have you tried running
tools/testing/selftests/pci_endpoint/pci_endpoint_test
?

pci_endpoint_test will run BAR tests against all BARs that are enabled by
default, regardless of the BAR being marked as RESERVED or not, see:
https://github.com/torvalds/linux/blob/v6.19/drivers/misc/pci_endpoint_test.c#L1052-L1061

In the case of nvidia,tegra234-pcie-ep, before my commit 42f9c66a6d0c
("PCI: tegra194: Reset BARs when running in PCIe endpoint mode"):
pcie-tegra194.c marked all BARs except BAR0 as reserved.
pci_endpoint_test would run tests against BAR0, BAR2, BAR3, BAR4, BAR5
(it would not run against BAR1, because BAR0 is marked as "only_64bit").

After my commit 42f9c66a6d0c ("PCI: tegra194: Reset BARs when running in
PCIe endpoint mode"):
pcie-tegra194.c still marks all BARs except BAR0 as reserved (I did not
change this).
pci_endpoint_test would run tests only against BAR0.
I.e. the only BAR that is not marked as reserved.


> 
> I think following fixes are required to address this issue,

Could you please define "this issue", because right now I honestly don't
see the issue.

To me it seems like you want pci_endpoint_test to run against BARs that are
marked as reserved (I assume that Vidya marked them as reserved for a good
reason, most likely because all of them map to MMIO registers) and thus you
want multiple test cases in pci_endpoint_test to fail instead of being skipped?


> 1. BAR test in pci_endpoint_test should skip MSI-X table.
> 2. BAR test in pci_endpoint_test should provide option to
> skip this test on known reserved BARs, maybe we can use
> pci_endpoint_test_data for this.

pci_endpoint_test already skips disabled BARs by default.

They way it works is that you disable all BARs in you EPC driver's init()
callback (i.e. what my patch does), pci-epf-test will then allocate backing
memory + enable all BARs that are not marked as RESERVED.


> 3. EPC driver should provide BAR_DISABLED enum to disable
> unused BARs.

BAR_RESERVED already means disabled, it just assumes that an EPC driver
disables all BARs by default, which is the case for:
pci-dra7xx.c, pci-imx6.c, pci-layerscape-ep.c, pcie-artpec6.c,
pcie-designware-plat.c, pcie-dw-rockchip.c, pcie-qcom-ep.c, pcie-rcar-gen4.c,
pcie-stm32-ep.c, pcie-uniphier-ep.c.
(All drivers which disables all BARs by default in the init() callback using
dw_pcie_ep_reset_bar(). pci-epf-test will later enable all BARs that are not
marked as BAR_RESERVED.)

That leaves: pcie-keembay.c, pci-keystone.c, pcie-tegra194.c (before my patch).

For pcie-keembay.c, this is not a problem, because BAR0, BAR2, BAR4 are marked
as only_64bit, so pci-epf-test configure these BARs as 64-bit BARs, and thus
BAR1, BAR3, and BAR5 will get disabled implicitly.

For pci-keystone.c, this is the only driver that is a bit weird, it marks
BAR0 and BAR1 as reserved, but does not disable them in the init() callback.
It seems force set BAR0 as a 32-bit BAR in the init() callback.

Thus, for all drivers except for pci-keystone.c, BAR_RESERVED does mean
BAR_DISABLED. Feel free to send a patch that renames BAR_RESERVED to
BAR_DISABLED.

If you send such a patch, perhaps you also want to modify the PCI endpoint
core to call reset_bar() for all BARs marked as BAR_RESERVED/BAR_DISABLED,
instead of each EPC driver doing so in the init() callback. I think the main
reason why this is not done already is that thare is no reset_bar() op in
struct pci_epc_ops epc_ops, there is only clear_bar() which clears an BAR
enabled by an EPF driver. (So you would most likely also need to add a
.disable_bar() op in struct pci_epc_ops epc_ops.)


> 4. Tegra PCIe driver should disable only BAR_DISABLED bars and
> leave BAR_RESERVED untouched.
> 5. Return NO_BAR for both BAR_DISABLED and BAR_RESERVED in
> pci_epc_get_next_free_bar()

A BAR marked as BAR_RESERVED will never be returned by
pci_epc_get_next_free_bar(), so this is the case already.


Kind regards,
Niklas


