Return-Path: <stable+bounces-231369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP2MGKyRy2nMJAYAu9opvQ
	(envelope-from <stable+bounces-231369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:19:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 040AB366E91
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6695030213B3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402543ED109;
	Tue, 31 Mar 2026 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lagz2h6e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0120930BBBF;
	Tue, 31 Mar 2026 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948777; cv=none; b=m1CtGM0j4gt1A6evbCBXcjOrUbkUIt3Qu7TumE3tph67hTRaxaH/n8QFfFml795I4seNYCTDzhiXwKC2YErr2ITk8DtctweT+YtuYb4L2N7LIGao6c+nJKg6YzjM38g5j0Gf+qNZ78jdY/X2cjBNXraDAYx90JX/gPUXUZGugJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948777; c=relaxed/simple;
	bh=1qhYBKOIdwEKAqXBxUeevZeCOU9ZFE8gnSQsrf9ZPcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JStjN27Ba+CB8snvHkne/wBY+emWAkxFeI7qQm7vqF0kuhaaH3IZTtf8yVZ2dmdRv/z1fAiO8AktShLWwHsnyNnVmlf6YZIeWk2g3WJCtbZ19gaq+5lDebCpHeQZ/4bUobF48NHnaRb7mRUp1CMdzpEX8azpxg6XriI+q4Py5YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lagz2h6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86A4C19423;
	Tue, 31 Mar 2026 09:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774948776;
	bh=1qhYBKOIdwEKAqXBxUeevZeCOU9ZFE8gnSQsrf9ZPcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lagz2h6eGYeissg4UXp4UyVObbavf90h6D8GzyDDXdlcS+D6yfVK+mOWvoViWPdP2
	 o/5U7kHvteqXm5zTIxs5o99wP5t0k5gT1MbbziaCkkHSdObTI8nWRX0Ztv7ue+hFt4
	 VeUTMwbYqpEVWAbANSw4sQERI1txFEmucvyutfXEUZbKrlJCJ1wyBBHV9xlipu6sE3
	 FmteD4E6QaGFLK5leo36eCz0mqkEcYLjVMGzPfEj1V1arQ9cllDDl8n01tMp8uaqt1
	 A4iOY+ZdXZouIYjmr2BbR1zC3VnzDgsGoy4pwUOoW8AvrPOZUw5tZZjol9Zuh31yW2
	 nHvjpaiBtTSJQ==
Date: Tue, 31 Mar 2026 14:49:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	John Hancock <john@kernel.doghat.io>, stable@vger.kernel.org, bhelgaas@google.com, 
	manivannan.sadhasivam@oss.qualcomm.com, joro@8bytes.org, linux-pci@vger.kernel.org, 
	iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU for
 OF platforms"
Message-ID: <5hng5r6q525scbclramuv2h2hphljbcsscwohvrs7teuedgfvl@ncr7tqhr4l4z>
References: <20260320172335.29778-1-john@kernel.doghat.io>
 <o7nnlvtkmatzafs44um6h5wnqo755msiukfn6kbu2zxdhe45ws@mde5lt2ufusz>
 <fad11c37-5bfb-44fd-b0bf-2a2d15b3382c@arm.com>
 <ovfco6pqzw734flu7navat36avt6yfosruouduhmbti7umunus@ijmu6nhz56l5>
 <99426bd8-32e5-4246-9d3b-772e136bc078@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99426bd8-32e5-4246-9d3b-772e136bc078@leemhuis.info>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231369-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 040AB366E91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 10:23:25AM +0200, Thorsten Leemhuis wrote:
> On 3/23/26 16:13, Manivannan Sadhasivam wrote:
> > On Mon, Mar 23, 2026 at 03:06:16PM +0000, Robin Murphy wrote:
> >> On 23/03/2026 1:54 pm, Manivannan Sadhasivam wrote:
> >>> On Fri, Mar 20, 2026 at 01:23:35PM -0400, John Hancock wrote:
> >>>> Commit 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF
> >>>> platforms") introduced a regression affecting AMD IOMMU group isolation
> >>>> on x86 systems, making PCIe passthrough non-functional.
> >>> [...]
> >>> Ouch! Sorry for the breakage.
> >>> [...]
> >>> I still haven't investigated this failure deeply, but it is also worth noting
> >>> that this regression only happens with v6.12 and earlier stable kernels as
> >>> mentioned in [1].
> >> Oops, indeed, relying on pci_dma_configure() to be called prior to group
> >> assignment in iommu_init_device() only works since bcb81ac6ae3c ("iommu: Get
> >> DT/ACPI parsing into the proper probe path") added that call path in 6.15 -
> >> thus the backport probably doesn't actually work for OF platforms either.
> > 
> > Ah, that makes sense. Thanks for finding the root cause. It might be very
> > obvious to you, but still... ;)
> > 
> >> Dropping this from 6.12.y and earlier stable branches seems like the correct
> >> action to me (but not a mainline revert, obviously). ACS had essentially
> >> *never* worked properly on OF platforms prior to 6.15, but that was more
> >> down to fundamental design flaws in the OF-based IOMMU probe path (dating
> >> back to 4.12) rather than any easily-fixable bug as such, so realistically I
> >> think we just leave it that way.
> > 
> > That's my opinion as well. I guess I need to send reverts for rest of the older
> > stable kernels as well.
> 
> Mani, did you send those reverts? I could not find any on lore. And the
> one at the start of the thread likely won't work, as it doesn't state
> that c41e2fb67e26b0 ("PCI: Enable ACS after configuring IOMMU for OF
> platforms") needs to be reverted for 6.12.y and all earlier series. So
> to speed things up:
> 
> Greg, Sasha, could you maybe simply revert that backported commit
> directly in 6.12.y and all earlier series?
> 

Sorry for the delay. I just sent the reverts for v5.10, v5.15, v6.1 and v6.6.
This patch is for v6.12, so we've covered all affected stable kernels prior to
v6.15.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

