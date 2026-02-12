Return-Path: <stable+bounces-215951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKgvEZPFjWnT6gAAu9opvQ
	(envelope-from <stable+bounces-215951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:20:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C5112D60C
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFF15300B46B
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 12:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B050835770A;
	Thu, 12 Feb 2026 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBcg4lQ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F601346779;
	Thu, 12 Feb 2026 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898827; cv=none; b=sMkPRyuoKYRvq6dOXyjysrwSFEhhSjbwE19/+WLk+P4dgffkvTNwkAxJBDW0KXNMD5WeGmE2tly4cik1bBAlYR1X3AXvpygc5bVAG5Hze3YiteYkIdbSFWaHhazUTbWxHmIzcgZYKN1/HiHLbqGCVT0zK9GHUEoGY1MdeAVjWGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898827; c=relaxed/simple;
	bh=yIbWErC8RoWVsumaMazbVPE1/7hFZ//8a27+WNh2ZJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJAIzGkopFYmPjx/RFxxCV5kLpRu5zJF6sFiticpVawWdQUzFkxhsc9rRXvVO05YSlIdsBRM62oqUOil1sJjifmc5ucoY7PxyQGoKbM6u8Ky63F75fevAuinA9aoktHGIN5EE7IHaZ6sox03PQN1no0Ihd7n98Nk/LZQhwJZYWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBcg4lQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E74C4CEF7;
	Thu, 12 Feb 2026 12:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770898827;
	bh=yIbWErC8RoWVsumaMazbVPE1/7hFZ//8a27+WNh2ZJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBcg4lQ9GBoQaNq/TDFVUofSs0znEjq9PUwj/bwijzcNnoTtA8xCZNY3BgczOnMJT
	 cRkgFKae2iL57FpxXHKBVjK/5qoKFYD9gfKRWM9g7UhBq2BY+TytcFhGVNRK0wQKRj
	 fGaQT7ZixF3H1EcAPIRXQC40Gwz8e9GAmlQqcuZS2c7TbL8MrYuGxXxpRghoyRe7QF
	 QXCg9c8agzlInhrUZLWlWG+SQh5gGTNjFUdmpZywDp+CUvNwPhArwLTQkcKdzB/V++
	 BXq5/6gv/PXOwQgMMlGeVB1qxrCEP3ibazV97DdMEZS3FUzfmWFzYj7yIlqozPLx9K
	 SyKhFsFV9oBGQ==
Date: Thu, 12 Feb 2026 13:20:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>, kishon@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
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
Message-ID: <aY3FhZUhb7RL80Fp@ryzen>
References: <20250922140822.519796-5-cassel@kernel.org>
 <20250922140822.519796-7-cassel@kernel.org>
 <2fedf28e-83ea-4e51-b1a1-e45f0e928509@nvidia.com>
 <aYonDJyd_dbV0GBK@ryzen>
 <94458c39-587b-4bb4-a410-e921e5d99f10@nvidia.com>
 <aYsDDOZA18BBeOsd@ryzen>
 <aYsKzBjmGEi1z0am@ryzen>
 <8d85409e-2f07-4e4b-831b-68c17a341a60@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d85409e-2f07-4e4b-831b-68c17a341a60@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215951-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,wdc.com,vger.kernel.org,google.com,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55C5112D60C
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 05:40:59PM +0530, Aksh Garg wrote:
> > since you have a @ti.com email, perhaps you can explain how pci-keystone.c
> > can pass all the pci-epf-test test cases, considering that this is the only
> > driver that has BARs (BAR0 and BAR1) marked as BAR_RESERVED but do not also
> > disable the BARs (using dw_pcie_ep_reset_bar()) in the init() callback.
> > 
> > Or, perhaps the simple answer is that pci-keystone.c does not pass all
> > pci-epf-test test cases?
> 
> Hi Niklas,
> 
> I just joined the organization and have no context on why the
> pci-keystone.c have BAR0 and BAR1 as reserved, without disabling the
> bars using dw_pcie_ep_reset_bar() in the .init() callback. Because the
> AM65 do not use any BARs for any purpose like Tegra194 does (ATU
> registers or eDMA registers exposed in BAR4 for example), there would
> be no issue if the BAR0 and BAR1 are overwritten.
> 
> This was introduced in the driver the time the EP support was added to
> the driver by Kishon in commit 23284ad677a9 ("PCI: keystone: Add support
> for PCIe EP in AM654x Platforms"), where no context is provided in the
> comments or commit message why the BAR0/1 are marked as reserved in the
> features. Perhaps Kishon can provide a better insight over this.

It is extra confusing, since the older driver from TI:
pci-dra7xx.c does have the dw_pcie_ep_reset_bar() calls in init()
(git blame shows added by Kishon), so it is a bit surprising that
the newer driver (pci-keystone.c) does not.

(And like I explained, currently all DWC drivers except keystone and
pcie-keembay.c do have the dw_pcie_ep_reset_bar() calls in init().)


Kind regards,
Niklas

