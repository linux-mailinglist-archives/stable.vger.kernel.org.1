Return-Path: <stable+bounces-232853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICgEMbZ9zWnqeAYAu9opvQ
	(envelope-from <stable+bounces-232853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 22:19:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 985B63800FD
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 22:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E130D3054B24
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 20:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93C936309D;
	Wed,  1 Apr 2026 20:18:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA3362156;
	Wed,  1 Apr 2026 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074738; cv=none; b=Tcgdc4igtw9iRJiBWhItDoz/l9Fu+qanyKd3Hcbj9vzotRF1KWi70AX0PMwGeZft6zPCBEdQwYDpS19qLYpwo77F5nGSEBt9BIgxQZPalHoOvEnbx0nh5JAdgpxnVVbRyu/j7QY5lTbHqS6CER1Nd1r9allZvxEMvj0mrmVvSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074738; c=relaxed/simple;
	bh=/0FIf537nm1xY06ayGZ16GQTeFwrvd12lIXJeKG4FYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcHSv2VSutJ6QzzJJkJ7T6vQrMXok0ttvU85KFpOBgok4LQsNXfd/HTGi8ZEmP5f8fzfEwLgU7nxP9NmThCdbXwOPczAmGHaQEmDn2ZpC26ZldZ80je1bPfPmAg9h0TR27x90NRXkB+ckabUsDY3V8g5b/DTBUnWggSh2Y4zE7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id EA357383;
	Wed, 01 Apr 2026 22:18:47 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D6CFC6029F6C; Wed,  1 Apr 2026 22:18:47 +0200 (CEST)
Date: Wed, 1 Apr 2026 22:18:47 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bernd Schumacher <bernd@bschu.de>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>,
	1131025@bugs.debian.org, Salvatore Bonaccorso <carnil@debian.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	regressions@lists.linux.dev, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bug#1131025: [6.12.y regression] Regression with 58130e7ce6cb
 ("PCI/ERR: Ensure error recoverability at all times"): echo vfio-pci
 >driver_override does not work for DVB Adapter
Message-ID: <ac19pxEZKvQuQwFV@wunner.de>
References: <acfZrlP0Ua_5D3U4@eldamar.lan>
 <acfhf-odtr0yw_py@wunner.de>
 <74bcd84500e5efcca035624f325e400dd8a21f44.camel@bschu.de>
 <acgohjvBpVcR7HcK@wunner.de>
 <5f9386146f426e2847550681cb7188471205607f.camel@bschu.de>
 <aclRwznwq6KpA2qA@wunner.de>
 <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
 <ac0Y85OShbK6mHEV@monoceros>
 <8275e5b86696dec133889713258c2e158a443496.camel@bschu.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8275e5b86696dec133889713258c2e158a443496.camel@bschu.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232853-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.782];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wunner.de:mid]
X-Rspamd-Queue-Id: 985B63800FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 06:16:37PM +0200, Bernd Schumacher wrote:
> Now the CMDLINE should be correct:
> cat /proc/cmdline 
> BOOT_IMAGE=/boot/vmlinuz-6.12.73 root=/dev/mapper/vg00-lvroot2 ro
> "dyndbg=file drivers/pci/* +p" log_buf_len=16M quiet
> 
> The problem still exists.
> The attached dmesg output is now larger.

Unfortunately this dmesg output was not generated with the debug patch
I provided here:

https://lore.kernel.org/all/acvIfI3naoGsOpFE@wunner.de/

It's missing the stack traces that the debug patch would have caused.

Could you please repeat with the patch applied?

Thanks,

Lukas

