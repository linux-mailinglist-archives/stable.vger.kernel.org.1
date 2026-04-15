Return-Path: <stable+bounces-238151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMOSFnS332lVYQAAu9opvQ
	(envelope-from <stable+bounces-238151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:06:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FCC40638B
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 748B530427E7
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DCF3E3C75;
	Wed, 15 Apr 2026 16:05:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA73AD53E;
	Wed, 15 Apr 2026 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776269119; cv=none; b=CWXMZ2YlNSYpclQOwTv9j+Z2NIhUqRDvvv+r+8QW78hfI0XadMQ0WeAH3EFk0dKfbsG1z3cq6+d1e1raEoxp9JnAqehZfZ+nFpmY/sN04TqtSltLx1ZwfwdQOGxgVWOQSyt4RmGAHQpPjtID1pRPYc6nvjLQr+Wzc9q/80aKAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776269119; c=relaxed/simple;
	bh=RIfpfBcjI92ETmr6jgG9YCZQwVzBVISBWfOAjrmpoU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWPhGgoVnD4bIFjjwVa1dcYR12M0EXP6zxZWEbtavFjcJXaYWmmgywKX4JKlMHSWObKhB3bB7G2njOS9H/JGtrpzB1qWaacLLWX2QLl4Qcq8YG+tyF1GxMYEj3ELOJXbkSbQ94hmuhNshPT0HScye/EsSCgnlhYC9b06mVrFY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id E7F85C13;
	Wed, 15 Apr 2026 18:05:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CF9506014951; Wed, 15 Apr 2026 18:05:14 +0200 (CEST)
Date: Wed, 15 Apr 2026 18:05:14 +0200
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
Message-ID: <ad-3OtA_i43_MmdU@wunner.de>
References: <8275e5b86696dec133889713258c2e158a443496.camel@bschu.de>
 <ac19pxEZKvQuQwFV@wunner.de>
 <7173609c404c5444e634dd3ab26f55f2788d82e4.camel@bschu.de>
 <ac_VqcBbKRDkHp69@wunner.de>
 <79618160f928d7ed4ba0a84f3ab420427c5b8d10.camel@bschu.de>
 <dd3c3358-de0f-4a56-9c81-04aceaab4058@mailo.com>
 <adxlr9lWBTZIQMev@wunner.de>
 <f55cb406-4a49-462d-b933-48303b32c014@mailo.com>
 <ad3Ug9NK3bgStlE4@wunner.de>
 <6073a429-1932-456b-8cdf-29ba28f46a81@mailo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6073a429-1932-456b-8cdf-29ba28f46a81@mailo.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238151-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,wunner.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9FCC40638B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 02:29:08AM +0200, Alexandre N. wrote:
> Please find attached the full dmesg with the debug patch
> and options you mentioned, using a clean 6.19.11 as a base.
> 
> This dmesg log shows a run with my host and guest issues (no
> disks from controller in VM, page fault error, virt-manager
> unresponsive etc).
> 0000:05:00.0 is the PCI SATA Controller device having issues.
> 
> Timings:
> - 36.447944: host ready after startup
> - 158.292119: VM starting
> - 166.564760: VM startup sequence ended
> - 286.631128: VM shutting down
> - 293.950976: VM shutdown sequence ended

Thank you!  In your case, the host kernel binds a driver to the
device which is unbound prior to passthrough.  Unbinding sets
current_state to PCI_UNKNOWN and that makes the problem re-appear
despite 4d4c10f763d7:

https://elixir.bootlin.com/linux/v6.19.11/source/drivers/pci/pci-driver.c#L484

On Bernd's system, the host kernel doesn't bind a driver to the
DVB adapter, hence 4d4c10f763d7 is sufficient to make the issue
disappear in his case.  I guess if he'd unbind vfio-pci and rebind
it, he'd see the problem again.

In any case, the patch is now submitted:

https://lore.kernel.org/r/febc3f354e0c1f5a9f5b3ee9ffddaa44caccf651.1776268054.git.lukas@wunner.de/

Thank you both for your efforts in reporting the bug and patiently
providing log output for debugging!

Lukas

