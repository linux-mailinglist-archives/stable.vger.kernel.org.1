Return-Path: <stable+bounces-231422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNN1E7XHy2mnLgYAu9opvQ
	(envelope-from <stable+bounces-231422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:10:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B849C369FA5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73F0A3021EBC
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750E3E51FE;
	Tue, 31 Mar 2026 13:09:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984CD3D9DC0;
	Tue, 31 Mar 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962586; cv=none; b=cF3MSx0n/YQ+0w757W9LWLYbmAjEotXGmI+FQCaEcfj9lX7uK6iKia3ubsBC89xW7Uhk34r5B4+bS6QguyaE9VkkKLocw/xy0eMJ0uu4qzjVjwqYlRMqw1FgbDg0j8fvJju4WJsLKKx440BPOidvUYooACNhNQepzVqna+ngykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962586; c=relaxed/simple;
	bh=ZnWASK7jBKHNzr0d5EkfnKa0BgHG0PxTkNlJLlhjIrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+RjIIdgA9Xedpg85VU3573fPFdsnK81mgvY399XYhxqxIfXV2vbArvkf6jjvGaO4BAKsthaHxXzFsbGCELhmrlZjzymDEXZHtjCUIugbfecZItWBpQwd0SfvMuYnKwiCqHy/5IP/W9eiqMf9UztlD5EPdi4M38G9gRHlRdQYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 0D6E810610;
	Tue, 31 Mar 2026 15:09:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E68456015F77; Tue, 31 Mar 2026 15:09:34 +0200 (CEST)
Date: Tue, 31 Mar 2026 15:09:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bernd Schumacher <bernd@bschu.de>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	1131025@bugs.debian.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [6.12.y regression] Regression with 58130e7ce6cb ("PCI/ERR:
 Ensure error recoverability at all times"): echo vfio-pci >driver_override
 does not work for DVB Adapter
Message-ID: <acvHjo8PKdyHshSE@wunner.de>
References: <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <acfZrlP0Ua_5D3U4@eldamar.lan>
 <acfhf-odtr0yw_py@wunner.de>
 <74bcd84500e5efcca035624f325e400dd8a21f44.camel@bschu.de>
 <acgohjvBpVcR7HcK@wunner.de>
 <5f9386146f426e2847550681cb7188471205607f.camel@bschu.de>
 <aclRwznwq6KpA2qA@wunner.de>
 <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231422-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wunner.de:mid]
X-Rspamd-Queue-Id: B849C369FA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 08:14:53AM +0200, Bernd Schumacher wrote:
> [    0.318903] pci 0000:07:00.0: [dd01:0003] type 00 class 0x048000 PCIe Endpoint
> [    0.318939] pci 0000:07:00.0: BAR 0 [mem 0xfffffffffc500000-0xfffffffffc50ffff 64bit]

BIOS initially sets the BAR address to an incorrect value (the top 32 bits
should be all zeroes instead of all ones)...

> [    0.339685] pci 0000:07:00.0: BAR 0 [mem 0xfffffffffc500000-0xfffffffffc50ffff 64bit]: can't claim; no compatible bridge window
[...]
> [    0.311065] pci 0000:02:03.0: [1022:57a3] type 01 class 0x060400 PCIe Switch Downstream Port
> [    0.311107] pci 0000:02:03.0: PCI bridge to [bus 07]
> [    0.311118] pci 0000:02:03.0:   bridge window [mem 0xfc500000-0xfc5fffff]

... this doesn't fit into the window of the bridge above the DVB card,
which has the top 32 bits set to all zeroes...

> [    0.357346] pci 0000:07:00.0: BAR 0 [mem 0xfc500000-0xfc50ffff 64bit]: assigned

... the kernel fixes the incorrect BAR, but it seems there's an ordering
issue such that pci_save_state() is called beforehand.  It's weird that
this doen't occur with newer kernels and it would be good to understand why.
I'm not seeing the ordering issue despite staring at the code for a while.

Below is a small debug patch.  Could you apply that on top of v6.12.73
(or newer) and provide me with the resulting full dmesg output?

The patch emits a stacktrace when correcting the BAR value as well as
when saving and restoring config space of the DVB card.  This should
give a clue where the ordering issue originates from.

Please note that the log_buf_len=16M parameter needs to be put outside
the double quotes of the dyndbg parameter, i.e.:

GRUB_CMDLINE_LINUX='log_buf_len=16M dyndbg="file drivers/pci/* +p"'

The dmesg output provided most recently no longer contained the dyndbg
output, probably because log_buf_len was intermixed with the double quoted
string.

Thanks for your continued patience in helping root-cause this issue!

Lukas

