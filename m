Return-Path: <stable+bounces-229260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEpHMr1cwWlZSgQAu9opvQ
	(envelope-from <stable+bounces-229260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:31:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F06922F6662
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C7A330BAB62
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F34F3B3897;
	Mon, 23 Mar 2026 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Whk9qdvc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E669E388377;
	Mon, 23 Mar 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278560; cv=none; b=cqPvOwUnHAcwwdyUafW+/n+rNqhtkEJaVHj/oijr8IHhfvVksQ35vv8yFpX/LGrzTFkIICvxIgCsmKUtICAHYqTBECqYJ76mTl8Iffx5ccFpE12pz1QPUemD7jbivpdiZwUab+hfN7LaxtMchOpkIxFcZZOgrSiCDy+2B0FyOlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278560; c=relaxed/simple;
	bh=4d1Fg2Qhn+AdqX2uETcrCYn+LafDsX6G1tmYhwMTNv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghDSBhXtZ9gGC+DfzGdqizfw3Bxl1qvZpOtqUNIH2le37DDFz2OoTgM10a1bgYi8z8N2Pin+kIMHHvskkoQ7QA4CeWwFiCGa2UJ9HcF+3BbUjGxsSUbK6ldOxOMD9d9WDHMlwHSIU0apmbCZwXTLYIwIYtds8Qj2X3wCrhT0nr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Whk9qdvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF86BC4CEF7;
	Mon, 23 Mar 2026 15:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774278559;
	bh=4d1Fg2Qhn+AdqX2uETcrCYn+LafDsX6G1tmYhwMTNv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Whk9qdvcoCA2BVjGSsMqq1yQGyZZFpTGC4dwLpmnkmgnJrUBXmeHzUyf257DgEYR8
	 iajZQZ2x+tNxaaV/jMCidFE37m0POo1pKBGtJNtd8OyyRh7tk0iYpYAX9CtFA2D3P/
	 JwsI2TGr5Yr25V2e2OduioF4FkBWtT6wWYD1CAhDv5MNrVDfQMZvMl6eHOwwmmZj8u
	 x9viZ63woGvPJAaOfXAMXo/6jWAzcAhxSwZ+LNPycst7JA3aM17hQPVVlGm+muZoDg
	 Sr4kbk17lUHRfk2Zfpe37aeHr8E6ylr0STmAgkEdq6vhSWYdxlx4BSRYft+HY9rotV
	 zxcx23gZE+TfQ==
Date: Mon, 23 Mar 2026 20:39:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: John Hancock <john@kernel.doghat.io>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: stable@vger.kernel.org, bhelgaas@google.com, 
	manivannan.sadhasivam@oss.qualcomm.com, joro@8bytes.org, linux-pci@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: Re: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU for
 OF platforms"
Message-ID: <x3svxxoldy4dkhtta6dvdg5czwg2pvqduog4dyhysakjcctmq5@dpakwaqcgody>
References: <20260320172335.29778-1-john@kernel.doghat.io>
 <o7nnlvtkmatzafs44um6h5wnqo755msiukfn6kbu2zxdhe45ws@mde5lt2ufusz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o7nnlvtkmatzafs44um6h5wnqo755msiukfn6kbu2zxdhe45ws@mde5lt2ufusz>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229260-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F06922F6662
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+ Jason

On Mon, Mar 23, 2026 at 07:24:30PM +0530, Manivannan Sadhasivam wrote:
> + Robin
> 
> On Fri, Mar 20, 2026 at 01:23:35PM -0400, John Hancock wrote:
> > Commit 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF
> > platforms") introduced a regression affecting AMD IOMMU group isolation
> > on x86 systems, making PCIe passthrough non-functional.
> > 
> > While the commit addresses a legitimate ordering issue on OF/Device Tree
> > platforms, the fix modifies pci_dma_configure(), which executes on all
> > platforms regardless of firmware interface. On AMD systems with IOMMU,
> > moving pci_enable_acs() from pci_acs_init() to pci_dma_configure() alters
> > the point at which ACS is evaluated relative to IOMMU group assignment.
> > The result is that devices which previously occupied individual, exclusive
> > IOMMU groups are merged into a single group containing both passthrough
> > and non-passthrough members, violating IOMMU isolation requirements.
> > 
> 
> Ouch! Sorry for the breakage.
> 
> > The commit author notes that pci_enable_acs() is now called twice per
> > device and that this is "presumably not an issue." On AMD IOMMU hardware
> > this assumption does not hold -- the change in call ordering has
> > observable and breaking consequences for group topology.
> > 
> > It is worth noting that this is a stable/LTS series (6.12.y), where
> > changes to fundamental PCI initialization ordering carry significant
> > risk for production and specialized workloads that depend on stable
> > IOMMU behavior across kernel updates. A regression of this nature --
> > silently breaking PCIe passthrough without any configuration change on
> > the part of the user -- is particularly disruptive in a series that
> > users reasonably expect to be conservative.
> > 
> 
> I still haven't investigated this failure deeply, but it is also worth noting
> that this regression only happens with v6.12 and earlier stable kernels as
> mentioned in [1].
> 
> > This revert restores pci_enable_acs() to pci_acs_init() and marks it
> > static again, fully restoring correct IOMMU group topology on affected
> > hardware.
> > 
> > Regression introduced in: 6.12.75
> > Tested on: 6.12.77 with this revert applied
> > 
> > Hardware:
> >   CPU:   AMD Ryzen Threadripper 2990WX (family 23h, Zen+)
> >   IOMMU: AMD-Vi
> > 
> > Bisect:
> >   6.12.74: GOOD -- IOMMU groups correct, passthrough functional
> >   6.12.75: BAD  -- IOMMU groups collapsed, passthrough broken
> >   6.12.76: BAD  -- still broken
> >   6.12.77: BAD  -- still broken
> > 
> > Fixes: 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF platforms")
> > Signed-off-by: John Hancock <john@kernel.doghat.io>
> 
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> - Mani
> 
> [1] https://lore.kernel.org/all/2c30f181-ffc6-4d63-a64e-763cf4528f48@leemhuis.info/
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

