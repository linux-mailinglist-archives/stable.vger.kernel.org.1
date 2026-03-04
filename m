Return-Path: <stable+bounces-223124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKtOFHJ3qGnpugAAu9opvQ
	(envelope-from <stable+bounces-223124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 19:18:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9722A206270
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 19:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A07C30675A9
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 18:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02373D1CB1;
	Wed,  4 Mar 2026 18:01:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CF53D1CAE;
	Wed,  4 Mar 2026 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647294; cv=none; b=YF0U2ytnfXK0gMEHvib6Q07B1xDGsFbxrUOh7GuykBquJZdAmN+BCJCgZRPZlkgo8fnk0mR7s4iROTD0jyvM8QB9i7WOaz8e4YfKTNd+kfB2D7UKesQMBkRWU8bhl21IBDX8BC8h99zl/uG22QYNyfxBjUPbk99SbTVZuHBXwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647294; c=relaxed/simple;
	bh=SxnzQBt9Ot6eHMRYQurulLKTi0GMXW/OCWYbnRMqOu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk1/qcN5d7Ro9fWzIxVTwjpydGta/pcjjUhpSDBcR2JksxNNgAzFr5fl50cRHp2D5pjgcXjrStVPoq3CXvPdwAJRvribT8xl1PsANktuloe99pjRICwpcbpf0Z6+6s6Wb/eJ6EEj/SBpRGIyYA8lVV3Vlm4gJA7EwkPKGBfqkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 22AD820201B0;
	Wed, 04 Mar 2026 18:52:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 124422CFDA; Wed,  4 Mar 2026 18:52:19 +0100 (CET)
Date: Wed, 4 Mar 2026 18:52:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Rich Hanes <georgebastille@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Don't call pci_pm_power_up_and_verify_state()
 for devices already in D0
Message-ID: <aahxU99mfH2LZfrZ@wunner.de>
References: <20260304170324.67076-1-georgebastille@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304170324.67076-1-georgebastille@gmail.com>
X-Rspamd-Queue-Id: 9722A206270
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-223124-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_SPAM(0.00)[0.137];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 05:03:24PM +0000, Rich Hanes wrote:
> Reproduced on a Lenovo ThinkPad with Intel Wireless-AC 7265 (8086:095a)
> behind PCIe root port 8086:9d10.  The workaround pcie_aspm=off confirms
> that suppressing L1 PM substate configuration prevents the failure.

The same issue was observed on a Google Pixelbook Eve:
https://bugzilla.kernel.org/show_bug.cgi?id=220705

That laptop also uses an i7265 attached to a Sunrise Point-LP PCH.

The PCH suffers from a hardware erratum, it doesn't reinstate the
clock quick enough after CLREQ# assertion to stay below the
spec-prescribed 400 nsec.

Intel's specification update recommends disabling CLKREQ# support
at the Root Port to work around the issue.  This must be done by
the BIOS, an operating system patch isn't the right approach.

I've prepared a BIOS change for the coreboot BIOS used on the
Pixelbook, see the above-linked bugzilla.  It has not been
upstreamed yet as I'm waiting on the reporter to test it.

If your ThinkPad can be made to boot with coreboot, I can look into
porting the patch over to your machine.  Please specify the exact
Thinkpad model you're using.  Otherwise please check whether Lenovo
has released a BIOS update for your machine.

Thanks,

Lukas

