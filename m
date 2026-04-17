Return-Path: <stable+bounces-238402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMHTJwO/4WnixgAAu9opvQ
	(envelope-from <stable+bounces-238402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:02:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B442416F3F
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 965BF30A8A35
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FCF2D12EE;
	Fri, 17 Apr 2026 05:02:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF68C1643B;
	Fri, 17 Apr 2026 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776402171; cv=none; b=s1p7a65bAc0BHPzbKeXDF3XDGPIdN0Fy6GbE/VGXLQkHXzKLyvPzYeySsY4Lq+f4tmzeAJGG5/3ScD47NZIYQQFvDIdld52TKptQr62aRrDI9cWKBc25vUmrtHA+Bo8EskIGxw6pYoJa/LlxvKBb9Axye/oLlUm8sNLPZ4SgDLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776402171; c=relaxed/simple;
	bh=Z1CdR5FcjEmeJjNx2pjoaO8JYhaJSY/2d3TR/ySKYjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjctOI59uBDh5Xr6KLQeJJp/JlkF1joiGCLOkD1GelkSBt7oMiM9HERP/+ptx5bsW0pmpKaDC/DtfzbA+Jb4QDkF4PCyVWNkTJiEIHOoCR3EYPwjx4NSYtCbWzkafbkxDcoYZ9tUdBC9DClx0VAfJOMYKQJ264DaRiGdzqZuehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 3FBD41062E;
	Fri, 17 Apr 2026 06:57:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 20116601495C; Fri, 17 Apr 2026 06:57:21 +0200 (CEST)
Date: Fri, 17 Apr 2026 06:57:21 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marco Nenciarini <mnencia@kcore.it>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Eric Chanudet <echanude@redhat.com>,
	Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/IOV: Fix out-of-bounds access in
 sriov_restore_vf_rebar_state()
Message-ID: <aeG9sQNwQPSlBCY-@wunner.de>
References: <20260408163922.1740497-1-mnencia@kcore.it>
 <20260416225745.GA41850@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416225745.GA41850@bhelgaas>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238402-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: 3B442416F3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 05:57:45PM -0500, Bjorn Helgaas wrote:
> And we have this weird retry loop in pci_restore_config_dword():
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci.c?id=v7.0#n1766,
> which was originally added by
> https://git.kernel.org/linus/26f41062f28d ("PCI: check for pci bar
> restore completion and retry") to fix an actual problem:
> 
>   On some OEM systems, pci_restore_state() is called while FLR has not
>   yet completed.  As a result, PCI BAR register restore is not
>   successful.  This fix reads back the restored value and compares it
>   with saved value and re-tries 10 times before giving up.
> 
> This just gives me the heebie-jeebies.  If we still need this retry
> loop, it means all the previous state restoration (PCIe, LTR, ASPM,
> IOV, PRI, ATS, DPC, etc.) probably failed, and we end up with a device
> where the BARs got restored but none of the previous stuff.  That
> sounds like a mess.

Nowadays we wait for devices to re-appear after reset by polling the
Vendor ID register, see the call to pci_dev_wait() in pcie_flr().

It seems we didn't do that back in the day when 26f41062f28d introduced
the loop.  The commit went into v3.4 and back then, pcie_flr() only
waited for 100 msec:

https://elixir.bootlin.com/linux/v3.4/source/drivers/pci/pci.c#L3052

And indeed pci_reset_function() immediately restored config space
afterwards:

https://elixir.bootlin.com/linux/v3.4/source/drivers/pci/pci.c#L3285

So I strongly suspect that the loop no longer has a valid raison d'être.
Maybe remove it early in the next cycle to get linux-next coverage for
8 weeks and see if anything breaks (which I doubt)?

As to validity of cached config space state in general, see this
discussion with Ilpo yesterday, in response to a regression fix
I submitted:

https://lore.kernel.org/all/aeDXktnNLEtmYsbh@wunner.de/

Thanks,

Lukas

