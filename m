Return-Path: <stable+bounces-215543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMdiEGQnimlKHwAAu9opvQ
	(envelope-from <stable+bounces-215543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 19:28:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AD41138CE
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 19:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A23B43037D7E
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D0E38A728;
	Mon,  9 Feb 2026 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqEBFhAa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D43859F7;
	Mon,  9 Feb 2026 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661650; cv=none; b=KgyJ1qVyaRIwqVM4+RcLQ22QQUV2BEm4Hp7YwgLQj8vgkibS9teju8dHgr9+SEtlCWWCTGeXvKHgBAHloLIVaYgkAzWUIhaj9f4O+Zygscrq2VDvOFXOWcPoxa4yaPwsnccFzisccDnj2+MzOo9jcWtYFukVwyO2p1j0PCmXKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661650; c=relaxed/simple;
	bh=0k04Mef8l+RsgOlvF/WA1v0iJyspoPB8kq1/j3gnyNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7BxMf6z/pX2GaIeW5fPGg5mYQkUdZKp2N6ezqyAu2KfPU790Hd5WFowmBPxBNUUrtawVB+Lu4ZKnYBTRCGxx6CBUaAjrkROctuXn4e79I9MYu1bX32uCaH2+5a4ple0xCfcY6fUTIeKO8Ap3eUQCpKASpE30Hn0NNHXr8aQuq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqEBFhAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29601C116C6;
	Mon,  9 Feb 2026 18:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770661650;
	bh=0k04Mef8l+RsgOlvF/WA1v0iJyspoPB8kq1/j3gnyNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqEBFhAaXZLv/0bfMhP1K0XjK4+vMYIHgqhqeIh5q3RGkCNbb8I5JS3yXJi3WMHUq
	 FZj2cHDnuXtlUrIchR2bzXhU6Mumc9HGcLlSJhX8YHshBJfQjnblrtMIsd60u8epdR
	 H3MsQDWq2BXOG5ST4Y/Qak8tdVNIsD8jXkAH9aJhtwIm+ez94GIfjCWiQ1vC6L79z5
	 Amkuy/0XlSUhg8fvpc38ycXqRwjyqOG0dLoX/5Zq/puSW6no7mCtROf1SOBI5o7reO
	 /6Cv6OhH4/9fB/g24kwsLSDcep4618XnfB9kzXCmYx1xjjRSAHETLfirJTUF8j5mgL
	 GZM7B7YI65/Bw==
Date: Mon, 9 Feb 2026 19:27:24 +0100
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
Message-ID: <aYonDJyd_dbV0GBK@ryzen>
References: <20250922140822.519796-5-cassel@kernel.org>
 <20250922140822.519796-7-cassel@kernel.org>
 <2fedf28e-83ea-4e51-b1a1-e45f0e928509@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fedf28e-83ea-4e51-b1a1-e45f0e928509@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-215543-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: D5AD41138CE
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 11:41:42PM +0530, Manikanta Maddireddy wrote:
> Hi Niklas,
> 
> Tegra PCIe exposes only DMA register over BAR4, not iATU.
> So, the issue described in this commit message is not applicable.
> This patch is disabling BAR2 and BAR4, after enumeration I see
> only BAR0. I think we should revert this patch.
> Please share your inputs on this.

If you look at this commit, it only disables all BARs by default,
which brings the tegra driver in-line with all other DWC based
endpoint drivers: dra7xx, imx6, layerscape-ep, artpec6, dw-rockchip,
qcom-ep, rcar-gen4, and uniphier-ep.

A PCI endpoint function (EPF) driver will still be able to enable a
BAR that was disabled in .init().
However, an EPF driver will not be able to use/enable a reserved BAR.

Look at e.g. the code in pci-epf-test. It will not allocate backing
memory for a BAR that is reserved, so having a BAR enabled that we
have not allocated backing memory for is wrong.

Commit c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint
mode in Tegra194") is the commit that marked all BARs other than
BAR0 as reserved, so if you want to test BARs other than BAR0,
talk to the author of that commit.

If you revert this patch, tools/testing/selftests/pci_endpoint/pci_endpoint_test
will once again fail the consecutive BAR test, so I think it would
be wrong to revert this patch.

If it is ATU registers or eDMA registers exposed in BAR4 does not
really matter. The end result is that you overwrite eDMA registers
that you should not be overwriting when you run the BAR tests.
(So BAR4 should absolutely be marked as reserved).

I don't recall, but if you overwrite the eDMA registers, then in
addition to the consecutive BAR test failing, most likely the DMA
test cases will also fail.

Have you tried running
tools/testing/selftests/pci_endpoint/pci_endpoint_test
?


Kind regards,
Niklas

