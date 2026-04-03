Return-Path: <stable+bounces-233191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPNwNinWz2kQ1AYAu9opvQ
	(envelope-from <stable+bounces-233191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:00:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FB339576E
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17306302DE16
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8869392815;
	Fri,  3 Apr 2026 14:59:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9283C457D;
	Fri,  3 Apr 2026 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228340; cv=none; b=SXJFjl9rhnMYrt7TrlxIc4zFcl3c+UpuSM3u39W4PxfdQOnN4pt31oy1KLKKHw4HKg3ZHccH5XaQ1aCXk3uDumTPKxgjNZBXemICd515kpHtM0Mie6rApraUvaGep1b5eghUztx7Nk17/ZZDafHEfg4z02QSbSy5jh1hKSGRqoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228340; c=relaxed/simple;
	bh=3Rkb0g97Ceob67GFEhQG4wUs08kRFoCi/DEvg7lzIjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bo4jWr83cHsazM4GdzfLkufEFBt5jMPVmX2jFqtafLgfLXPiNalQTfEgUfwgKrdYKPWJ3dPSFVz6Zl68MY3fn3FVamYvIi0kHGaY1/ZH1aoPqz7EqqOr8xWCgg+UXSZWBFwCRbfgF5c863y7atBLOr2EkMZ0/OTKRcW+oOqNdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id A343810DC6;
	Fri, 03 Apr 2026 16:58:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 845C16000EC2; Fri,  3 Apr 2026 16:58:49 +0200 (CEST)
Date: Fri, 3 Apr 2026 16:58:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bernd Schumacher <bernd@bschu.de>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>,
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
Message-ID: <ac_VqcBbKRDkHp69@wunner.de>
References: <74bcd84500e5efcca035624f325e400dd8a21f44.camel@bschu.de>
 <acgohjvBpVcR7HcK@wunner.de>
 <5f9386146f426e2847550681cb7188471205607f.camel@bschu.de>
 <aclRwznwq6KpA2qA@wunner.de>
 <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
 <ac0Y85OShbK6mHEV@monoceros>
 <8275e5b86696dec133889713258c2e158a443496.camel@bschu.de>
 <ac19pxEZKvQuQwFV@wunner.de>
 <7173609c404c5444e634dd3ab26f55f2788d82e4.camel@bschu.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7173609c404c5444e634dd3ab26f55f2788d82e4.camel@bschu.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233191-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.349];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57FB339576E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[cc += Alex, Ilpo]

On Thu, Apr 02, 2026 at 07:53:09AM +0200, Bernd Schumacher wrote:
> dmesg with patch is now attached

Thank you Bernd!

If you cherry-pick these two upstream commits onto v6.12.73,
does the issue go away?

  4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
  907a7a2e5bf4 ("PCI/PM: Set up runtime PM even for devices without PCI PM")

The second one is a fix for the first one.

I suspect that the first one is the reason why you are seeing
the issue on v6.12.73 but not on current mainline.  The commit
went into v6.16 but was not backported to LTS kernels.

@Alex:
The commit sets pci_dev->current_state to PCI_D0 on device enumeration,
whereas previously it was PCI_UNKNOWN.  This changes code paths in
a number of places.  In particular:

  vfio_pci_core_register_device()
    vfio_pci_set_power_state()

... calls pci_restore_state() without a prior pci_save_state() if
current_state is PCI_UNKNOWN.  The function doesn't do that for PCI_D0.

Also, there is a code comment in vfio_pci_core_register_device()
claiming that "pci-core sets the device power state to an unknown value
at bootup" which is no longer true since commit 4d4c10f763d7.

I recently had to deal with a regression in ASPM code which was
likewise caused by the subtle change of current_state from PCI_UNKNOWN
to PCI_D0, so my non-artificial neural network was trained to recognize
this pattern and seeing the current_state checks in vfio code thus
immediately looked suspicious to me:

https://bugzilla.kernel.org/show_bug.cgi?id=220705

Thanks,

Lukas

