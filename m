Return-Path: <stable+bounces-152600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBBDAD8204
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 05:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106643B7CF2
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 03:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6117025291C;
	Fri, 13 Jun 2025 03:55:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D920B804;
	Fri, 13 Jun 2025 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749786933; cv=none; b=lWNXdkZNuIvn4mlidYuHAJwPLRSeD3hVK22vpzsiHPiNZAoM8syy3DPwPLefxA6zS7+u2F/b2kLX76CmUvfE3ZDSGr/CK+lT8FzjN3Tj59viAQkQ/AXHF2BLOiIDfLyUzLU2XJtsXS7UT28qPd9gS7hgFUHw+oJYBDDkQW9hAAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749786933; c=relaxed/simple;
	bh=KB5nwV0rrCyqMKw0DZjgDmOOJVHOB+5s/KK30BOM6d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikxWx6SCLEwhSZpIolqXGOcosm1lMTPC439wx5ibBQoMrsH4UyhirNl62OoKIdqgK1nOM3m393EvhRvN2Cvm/1TSKmOokzssibbxBLmR3YdeVHTy97hXYp8RcmwGzoHT+xPimIzC8UvJsEDvrSjF2nEb3PLxVJ757NwU30ztbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id A3C342C06659;
	Fri, 13 Jun 2025 05:55:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8BD7EEEAA0; Fri, 13 Jun 2025 05:55:19 +0200 (CEST)
Date: Fri, 13 Jun 2025 05:55:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>
Subject: Re: Patch "PCI: pciehp: Ignore Link Down/Up caused by Secondary Bus
 Reset" has been added to the 6.15-stable tree
Message-ID: <aEuhJ_ldVUwI6u-V@wunner.de>
References: <20250610121606.1556304-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610121606.1556304-1-sashal@kernel.org>

[cc += Joel Mathew Thomas]

On Tue, Jun 10, 2025 at 08:16:05AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     PCI: pciehp: Ignore Link Down/Up caused by Secondary Bus Reset
> 
> to the 6.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      pci-pciehp-ignore-link-down-up-caused-by-secondary-b.patch
> and it can be found in the queue-6.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hi Sasha, thanks for selecting the above (which is 2af781a9edc4 upstream)
as a 6.15 backport.

A small feature request, could you amend the stable tooling to cc
people tagged as Reported-by and Tested-by?  I think they're the
ones most interested in seeing something backported.

Thanks!

Lukas

> commit 161a7237de69f65ccfe68da318343f3719149480
> Author: Lukas Wunner <lukas@wunner.de>
> Date:   Thu Apr 10 17:27:12 2025 +0200
> 
>     PCI: pciehp: Ignore Link Down/Up caused by Secondary Bus Reset
>     
>     [ Upstream commit 2af781a9edc4ef5f6684c0710cc3542d9be48b31 ]
>     
>     When a Secondary Bus Reset is issued at a hotplug port, it causes a Data
>     Link Layer State Changed event as a side effect.  On hotplug ports using
>     in-band presence detect, it additionally causes a Presence Detect Changed
>     event.
>     
>     These spurious events should not result in teardown and re-enumeration of
>     the device in the slot.  Hence commit 2e35afaefe64 ("PCI: pciehp: Add
>     reset_slot() method") masked the Presence Detect Changed Enable bit in the
>     Slot Control register during a Secondary Bus Reset.  Commit 06a8d89af551
>     ("PCI: pciehp: Disable link notification across slot reset") additionally
>     masked the Data Link Layer State Changed Enable bit.
>     
>     However masking those bits only disables interrupt generation (PCIe r6.2
>     sec 6.7.3.1).  The events are still visible in the Slot Status register
>     and picked up by the IRQ handler if it runs during a Secondary Bus Reset.
>     This can happen if the interrupt is shared or if an unmasked hotplug event
>     occurs, e.g. Attention Button Pressed or Power Fault Detected.
>     
>     The likelihood of this happening used to be small, so it wasn't much of a
>     problem in practice.  That has changed with the recent introduction of
>     bandwidth control in v6.13-rc1 with commit 665745f27487 ("PCI/bwctrl:
>     Re-add BW notification portdrv as PCIe BW controller"):
>     
>     Bandwidth control shares the interrupt with PCIe hotplug.  A Secondary Bus
>     Reset causes a Link Bandwidth Notification, so the hotplug IRQ handler
>     runs, picks up the masked events and tears down the device in the slot.
>     
>     As a result, Joel reports VFIO passthrough failure of a GPU, which Ilpo
>     root-caused to the incorrect handling of masked hotplug events.
>     
>     Clearly, a more reliable way is needed to ignore spurious hotplug events.
>     
>     For Downstream Port Containment, a new ignore mechanism was introduced by
>     commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC").
>     It has been working reliably for the past four years.
>     
>     Adapt it for Secondary Bus Resets.
>     
>     Introduce two helpers to annotate code sections which cause spurious link
>     changes:  pci_hp_ignore_link_change() and pci_hp_unignore_link_change()
>     Use those helpers in lieu of masking interrupts in the Slot Control
>     register.
>     
>     Introduce a helper to check whether such a code section is executing
>     concurrently and if so, await it:  pci_hp_spurious_link_change()
>     Invoke the helper in the hotplug IRQ thread pciehp_ist().  Re-use the
>     IRQ thread's existing code which ignores DPC-induced link changes unless
>     the link is unexpectedly down after reset recovery or the device was
>     replaced during the bus reset.
>     
>     That code block in pciehp_ist() was previously only executed if a Data
>     Link Layer State Changed event has occurred.  Additionally execute it for
>     Presence Detect Changed events.  That's necessary for compatibility with
>     PCIe r1.0 hotplug ports because Data Link Layer State Changed didn't exist
>     before PCIe r1.1.  DPC was added with PCIe r3.1 and thus DPC-capable
>     hotplug ports always support Data Link Layer State Changed events.
>     But the same cannot be assumed for Secondary Bus Reset, which already
>     existed in PCIe r1.0.
>     
>     Secondary Bus Reset is only one of many causes of spurious link changes.
>     Others include runtime suspend to D3cold, firmware updates or FPGA
>     reconfiguration.  The new pci_hp_{,un}ignore_link_change() helpers may be
>     used by all kinds of drivers to annotate such code sections, hence their
>     declarations are publicly visible in <linux/pci.h>.  A case in point is
>     the Mellanox Ethernet driver which disables a firmware reset feature if
>     the Ethernet card is attached to a hotplug port, see commit 3d7a3f2612d7
>     ("net/mlx5: Nack sync reset request when HotPlug is enabled").  Going
>     forward, PCIe hotplug will be able to cope gracefully with all such use
>     cases once the code sections are properly annotated.
>     
>     The new helpers internally use two bits in struct pci_dev's priv_flags as
>     well as a wait_queue.  This mirrors what was done for DPC by commit
>     a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC").  That may
>     be insufficient if spurious link changes are caused by multiple sources
>     simultaneously.  An example might be a Secondary Bus Reset issued by AER
>     during FPGA reconfiguration.  If this turns out to happen in real life,
>     support for it can easily be added by replacing the PCI_LINK_CHANGING flag
>     with an atomic_t counter incremented by pci_hp_ignore_link_change() and
>     decremented by pci_hp_unignore_link_change().  Instead of awaiting a zero
>     PCI_LINK_CHANGING flag, the pci_hp_spurious_link_change() helper would
>     then simply await a zero counter.
>     
>     Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
>     Reported-by: Joel Mathew Thomas <proxy0@tutamail.com>
>     Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219765
>     Signed-off-by: Lukas Wunner <lukas@wunner.de>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Tested-by: Joel Mathew Thomas <proxy0@tutamail.com>
>     Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>     Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>     Link: https://patch.msgid.link/d04deaf49d634a2edf42bf3c06ed81b4ca54d17b.1744298239.git.lukas@wunner.de
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

