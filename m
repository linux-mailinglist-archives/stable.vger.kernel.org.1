Return-Path: <stable+bounces-235882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bn/H79l3GmSQQkAu9opvQ
	(envelope-from <stable+bounces-235882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:40:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0EC3E7017
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4129300AC30
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 03:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D3D33F37A;
	Mon, 13 Apr 2026 03:40:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00A121D3E2;
	Mon, 13 Apr 2026 03:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776051644; cv=none; b=UNL8US1PF8oSSfoWPB9dln/zbg3xwUSY1FNNjnFYTD/4Q+HfTPdtB0l0eAWq7M9qWbIZrQ99jbY3XO9njgeBAX17Gt4dWYOxafi7ayDITgCPnHF0xwMt5sSGZPR+f6wKhjDq/jYKeaWi8Vs4wKIsSc/UB8w5zkxmi4QULkoWpJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776051644; c=relaxed/simple;
	bh=tuDwO3YZZfjHQw7URuUniNkMsqfh3GFLuy//dNLxIVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrysFho8VNLfCg4IXm8owDhP63D2o9aG1vUGlxT5P24US1ExXdpbPU/iCIrWeFMuU0Hz1xjVlfMRWmtLdYckWFgmLsU/+7hMnxsP5ttuvKvxtDH0IffrC51LF9jWqC07t+duiAZHRVe8Vm/OJzCr28HSsfZmUb+/EJe4GrNy8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id E3C1FC2B;
	Mon, 13 Apr 2026 05:40:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AD6076017610; Mon, 13 Apr 2026 05:40:31 +0200 (CEST)
Date: Mon, 13 Apr 2026 05:40:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Alexandre N." <an.tech@mailo.com>
Cc: Bernd Schumacher <bernd@bschu.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>,
	1131025@bugs.debian.org, Salvatore Bonaccorso <carnil@debian.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	regressions@lists.linux.dev, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: Bug#1131025: [6.12.y regression] Regression with 58130e7ce6cb
 ("PCI/ERR: Ensure error recoverability at all times"): echo vfio-pci
 >driver_override does not work for DVB Adapter
Message-ID: <adxlr9lWBTZIQMev@wunner.de>
References: <aclRwznwq6KpA2qA@wunner.de>
 <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
 <ac0Y85OShbK6mHEV@monoceros>
 <8275e5b86696dec133889713258c2e158a443496.camel@bschu.de>
 <ac19pxEZKvQuQwFV@wunner.de>
 <7173609c404c5444e634dd3ab26f55f2788d82e4.camel@bschu.de>
 <ac_VqcBbKRDkHp69@wunner.de>
 <79618160f928d7ed4ba0a84f3ab420427c5b8d10.camel@bschu.de>
 <dd3c3358-de0f-4a56-9c81-04aceaab4058@mailo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd3c3358-de0f-4a56-9c81-04aceaab4058@mailo.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235882-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:email,wunner.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB0EC3E7017
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 08:04:02PM +0200, Alexandre N. wrote:
> Independent confirmation on different hardware and a different
> stable branch, plus test results for the proposed fix on 6.19.11.
> 
>   Hardware:   PCI 1b4b:9215  Marvell 88SE9215 PCIe 2.0 x1 4-port
>               SATA 6 Gb/s controller, whole-device passthrough to a
>               Windows 10 guest via QEMU/libvirt on
>               an AMD Ryzen 7 7700 8-Core x86_64 host (Arch Linux).
>   Last good:  linux 6.18.9
>   First bad:  linux 6.18.13  (contains stable backport 71c50e60421b
>                               of upstream a2f1e22390ac, "PCI/ERR:
>                               Ensure error recoverability at all
>                               times", first backported in 6.18.10)
>   Also bad:   linux 6.19.11  (mainline carries a2f1e22390ac)
> 
> Confirmed by rolling linux back to 6.18.9 with everything else
> untouched: problem vanishes. Rolling forward to 6.18.13 or any
> later versions in 6.18/6.19 reproduces it everytime.

Hm, that's unexpected.  I cooked up the patch below on Saturday
but didn't immediately get around to sending it because of a
security bug report that came in later that day.

Could both of you, Alexandre and Bernd, give that patch a spin
to see if it fixes the issue?  I believe the patch should at least
fix things for Bernd.  If it doesn't fix things for you Alexandre,
I'll have to dig deeper.

Thanks!

Lukas

-- >8 --

Subject: [PATCH] PCI: Update saved_config_space upon resource assignment

Bernd reports passthrough failure of a Digital Devices Cine S2 V6 DVB
adapter plugged into an ASRock X570S PG Riptide board with BIOS version
P5.41 (09/07/2023):

  ddbridge 0000:07:00.0: detected Digital Devices Cine S2 V6 DVB adapter
  ddbridge 0000:07:00.0: cannot read registers
  ddbridge 0000:07:00.0: fail

The BIOS assigns an incorrect BAR to the DVB adapter which has the upper
32 bits set to "all ones".  This doesn't fit into the upstream bridge
window, which has those bits set to "all zeroes".  The kernel therefore
corrects the BAR assignment:

  pci 0000:07:00.0: BAR 0 [mem 0xfffffffffc500000-0xfffffffffc50ffff 64bit]: can't claim; no compatible bridge window
  pci 0000:07:00.0: BAR 0 [mem 0xfc500000-0xfc50ffff 64bit]: assigned

Correction of the BAR assignment happens in an x86-specific fs_initcall,
pcibios_assign_resources(), after PCI devices have been enumerated in a
subsys_initcall.  This order was introduced at the behest of Linus in
2004:

    https://git.kernel.org/tglx/history/c/a06a30144bbc

No other architecture performs such a late BAR correction.

Bernd bisected the issue to commit a2f1e22390ac ("PCI/ERR: Ensure error
recoverability at all times"), but it only occurs in the absence of commit
4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing").
This combination exists in stable kernel v6.12.70, but not in mainline,
hence mainline does not exhibit the issue.

Since commit a2f1e22390ac, config space is saved on enumeration (in a
subsys_initcall), i.e. prior to the BAR correction.  Upon passthrough,
the corrected BAR is overwritten with the incorrect saved value by:

  vfio_pci_core_register_device()
    vfio_pci_set_power_state()
      pci_restore_state()

But only if the device's current_state is PCI_UNKNOWN, as it was prior to
commit 4d4c10f763d7.  Since the commit it is PCI_D0, which changes the
behavior of vfio_pci_set_power_state() to no longer restore the state
without saving it first.

Although the issue could be fixed in v6.12-stable by backporting
4d4c10f763d7 or by changing vfio_pci_set_power_state(), a more robust fix
is to update saved_config_space upon resource assignment.

Reported-by: Bernd Schumacher <bernd@bschu.de>
Closes: https://lore.kernel.org/r/acfZrlP0Ua_5D3U4@eldamar.lan/
Fixes: a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.12+
---
 drivers/pci/setup-res.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index e5fcadfc58b0..1769ba960197 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -102,6 +102,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	}
 
 	pci_write_config_dword(dev, reg, new);
+	dev->saved_config_space[reg / 4] = new;
 	pci_read_config_dword(dev, reg, &check);
 
 	if ((new ^ check) & mask) {
@@ -112,6 +113,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	if (res->flags & IORESOURCE_MEM_64) {
 		new = region.start >> 16 >> 16;
 		pci_write_config_dword(dev, reg + 4, new);
+		dev->saved_config_space[(reg + 4) / 4] = new;
 		pci_read_config_dword(dev, reg + 4, &check);
 		if (check != new) {
 			pci_err(dev, "%s: error updating (high %#010x != %#010x)\n",
-- 
2.51.0


