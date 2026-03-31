Return-Path: <stable+bounces-232602-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBwcCHBSzGmvSQYAu9opvQ
	(envelope-from <stable+bounces-232602-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 01:02:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED2B372908
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 01:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A65EF3024B67
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8237C4611CE;
	Tue, 31 Mar 2026 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="pep+ZU7Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gmQnSYAh"
X-Original-To: stable@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D4D46AEE8;
	Tue, 31 Mar 2026 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998117; cv=none; b=HyII1jTCHDiZcj17ni54igSXZlJCdp3WfddeFDY4ero4xJkbInSu0cISwFbFPd2TST4sIK7xtBawQRBlwq6I3mket0eRWEASHrsAUS/5ZFnWo1MggJgrbd9JEmkiwd1u5kSwRPMddj5SipugxOOT5g7tKEYsfK0MGe94v1HC7SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998117; c=relaxed/simple;
	bh=uhwpHP2Ttf1/01lqwrO31sK/lvNvQg/Kd/276OzWF2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqxKAJPwAMKPyngGy4xbLy0frI9luH7auzuCollsmJcZ4SzRNXvxQQzsCQL359JWwGAHW6JaqH6D9BrY512Kgd5IHdLDvu+fabm9YPfLe9ydKoRq0rfZNjbneCiNIsQbMGBUCf0Sjy1wWkkl6SjB0jkwTixmcoe6rcK+x0E2qiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=pep+ZU7Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gmQnSYAh; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 13EE01D000CA;
	Tue, 31 Mar 2026 19:01:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 19:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774998113;
	 x=1775084513; bh=lBuwiN4qeR4cp/7SH69mL0nqRv1FXISJ3o63/YTRGfg=; b=
	pep+ZU7ZC3w9Knw2+EVJlg2x63zg4wT3UdZrVqlDEE7Vq2NuVK6V58imjucxc+9d
	SCoehZTAGBC/3mQZpy5MNXpLhTQGLlfC8bFvgCfOtAKAHv/Z5aN2sexAssHYLS1r
	Y2pTMWBejAZ1AbridVRr2HEfGqjKnQ9bDjSsvaFNa45dpWao08Ax/IsDbWQgj5CL
	yo6NraMeq96MzEb6iLYsKls9IXreZ2QyHUrAoxvAymLGhpW82iO90zdk998JSM0Q
	4jtgjj4CVGOZBQmtFKq0dscJtHvylQattMcrqMpzGOvESf+pORryb+hlTXVBTRXE
	cMhc+Jw92552e7z+lJFfKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774998113; x=
	1775084513; bh=lBuwiN4qeR4cp/7SH69mL0nqRv1FXISJ3o63/YTRGfg=; b=g
	mQnSYAhgsyOrSnAkj/YHViJUvj8OiAmpYwFkw24F6NVsIu5WMlskx6uvqqHzY6fL
	8PppWhL8dPTtie07AOWs0oaVCALp464pZ6hwDPm1qoqI0DQ11mv7sZ8ERBDZNAmr
	OASopWF885SkfcilJZXeykIfuanC3/Vi/Y001T4qAirq5crfQDhX7GFQfnrV7Pfj
	/RO4y0l2E3IQ4Msn9lg4d4K0hib9eCKDBJlTbrNRG8aWnANpOrW+gN+HOllg52+u
	HfbtPBUckTY6IpeevPhdzT019cpRtbyA5c0TuiPPwLORKOccCIgMw+DbAAJTiGpS
	oarPL1G4UhzL4ake8RacQ==
X-ME-Sender: <xms:YFLMafuMcmhNatmHxRMsquzXHyKQKw2ECQdrtt13zTzMS1N8aUWuow>
    <xme:YFLMaW8oQWr8ne2aCzOqpWvRmZV4d4WDBaBUG7oGTLMXbB8_M8kOSumWfaZm0h0-5
    Z9YyrfRUh8cr3SOwe8VaAAc2hTd6E8VXOkQ2nmKAUhBXnhkWa7gJw>
X-ME-Received: <xmr:YFLMaQz8T-kL2pA0LQ_0l2_tjttOJXaA5tpN0JudmmFcR_TUfkb238RXQgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudegveeu
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    gvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtoh
    epsggvrhhnugessghstghhuhdruggvpdhrtghpthhtoheptggrrhhnihhlseguvggsihgr
    nhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrihho
    rdhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtohepuddufedutddvhe
    essghughhsrdguvggsihgrnhdrohhrghdprhgtphhtthhopehrvghgrhgvshhsihhonhhs
    sehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepshhtrggslhgvsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YFLMaQ9lOwQmNviNE1kutxf7BjGVpEcv3AogzAj7vfCI0HcJbQQEcA>
    <xmx:YFLMaWNk1895DW6-12Ka3SygpAUYWDMiCRhPaVqOjcqerxjQ_Amfew>
    <xmx:YFLMaYqj8AVcWzH0mBY0BWYbtC0h2V9uRSX1Z62wI_qcTXYWj1oDvw>
    <xmx:YFLMaV7rEvHQcto4kCNk1YJA3mkl3uzF5D2Xx0-57L1Ph5bYIO8Dvw>
    <xmx:YVLMaeXAx9OBrpu6BP6didbMwx09-SVpWIumjKVjGkzbke2Utn_ih5-2>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 19:01:52 -0400 (EDT)
Date: Tue, 31 Mar 2026 17:01:49 -0600
From: Alex Williamson <alex@shazbot.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bernd Schumacher <bernd@bschu.de>, Salvatore Bonaccorso
 <carnil@debian.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>, 1131025@bugs.debian.org,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [6.12.y regression] Regression with 58130e7ce6cb ("PCI/ERR:
 Ensure error recoverability at all times"): echo vfio-pci >driver_override
 does not work for DVB Adapter
Message-ID: <20260331170149.3ee222aa@shazbot.org>
In-Reply-To: <acvHjo8PKdyHshSE@wunner.de>
References: <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
	<acfZrlP0Ua_5D3U4@eldamar.lan>
	<acfhf-odtr0yw_py@wunner.de>
	<74bcd84500e5efcca035624f325e400dd8a21f44.camel@bschu.de>
	<acgohjvBpVcR7HcK@wunner.de>
	<5f9386146f426e2847550681cb7188471205607f.camel@bschu.de>
	<aclRwznwq6KpA2qA@wunner.de>
	<ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
	<acvHjo8PKdyHshSE@wunner.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-232602-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,shazbot.org:dkim,shazbot.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4ED2B372908
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 15:09:34 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Mon, Mar 30, 2026 at 08:14:53AM +0200, Bernd Schumacher wrote:
> > [    0.318903] pci 0000:07:00.0: [dd01:0003] type 00 class 0x048000 PCIe Endpoint
> > [    0.318939] pci 0000:07:00.0: BAR 0 [mem 0xfffffffffc500000-0xfffffffffc50ffff 64bit]  
> 
> BIOS initially sets the BAR address to an incorrect value (the top 32 bits
> should be all zeroes instead of all ones)...
> 
> > [    0.339685] pci 0000:07:00.0: BAR 0 [mem 0xfffffffffc500000-0xfffffffffc50ffff 64bit]: can't claim; no compatible bridge window  
> [...]
> > [    0.311065] pci 0000:02:03.0: [1022:57a3] type 01 class 0x060400 PCIe Switch Downstream Port
> > [    0.311107] pci 0000:02:03.0: PCI bridge to [bus 07]
> > [    0.311118] pci 0000:02:03.0:   bridge window [mem 0xfc500000-0xfc5fffff]  
> 
> ... this doesn't fit into the window of the bridge above the DVB card,
> which has the top 32 bits set to all zeroes...
> 
> > [    0.357346] pci 0000:07:00.0: BAR 0 [mem 0xfc500000-0xfc50ffff 64bit]: assigned  
> 
> ... the kernel fixes the incorrect BAR, but it seems there's an ordering
> issue such that pci_save_state() is called beforehand.  It's weird that
> this doen't occur with newer kernels and it would be good to understand why.
> I'm not seeing the ordering issue despite staring at the code for a while.

Do we know this isn't occurring on newer kernels?  If we have a bogus
BAR address that later gets fixed, this seems like a fairly unique
setup.  AIUI, we're saving the state via the call chain invoked by
subsys_initcall(pcibios_init), but I think we're doing the resource
fixes in fs_initcall(pcibios_assign_resources).  That suggests that the
saved state would have the bogus BAR values.

If we toss PM runtime into that mix, pci_pm_default_resume_early() will
call pci_restore_state() however pci_save_state() in that file is
mostly wrapped around pci_dev->state_saved guards.  This suggests we
likely won't save the reallocated state, but we will restore the
pre-reallocated state.

Maybe this can be quickly validated by loading vfio-pci with the
disable_idle_d3=1 option to avoid the PM transition.  Thanks,

Alex

