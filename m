Return-Path: <stable+bounces-233034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPdsCL96zmmMnwYAu9opvQ
	(envelope-from <stable+bounces-233034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:18:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7559438A5CA
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51930304421D
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28AC3EBF0C;
	Thu,  2 Apr 2026 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="aMX7FQc3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K7uoeNNP"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633B30FC39;
	Thu,  2 Apr 2026 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139405; cv=none; b=TIzXgNAevCtb+wl+a948v9BTFkzIpq4xjONLNrANkmzQ30qkNRVqNwy3rPoSVdpMXNHwgt2ApdkCNl/GVbDImlYnaD2CS+6HSkjtqeUlzjgNSYtwATlCha687WhGs4PNcGXRbPcp291UnHCZjEvGTbiOr7WxJkBgeYuz8xLZPqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139405; c=relaxed/simple;
	bh=jg8KPGh2GOb2pJBCznXp3tgimiIyxgrVajJWzzsgPEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/1hpoiR8LSpS01nJ7aWEPutYWryNm4s7blxuSuR6pr2OmYDEflH3Wm4DPuJSTrEqvi+il71P24sRw8kzbn4PQffuzoHkxNrgAv0jM93Ll8PrnY2Wx1B9+NqLgFsPVdYcquTz3U3qwEgPSzqheXhn7tkSWyuMExj2mzfAOtiyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=aMX7FQc3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K7uoeNNP; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FBA9140017A;
	Thu,  2 Apr 2026 10:16:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Apr 2026 10:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775139401;
	 x=1775225801; bh=CaEmS575vuG72PdWB4kbWXAIzRA4QIV3o8rz6fMz0nU=; b=
	aMX7FQc3QxatPLP5Tlrn/w3FsP6+BQ1g7EkaU+PhY8KlFofIiTpp3Zp4+LwhnkOQ
	gGIBoZEoqZzWWmbyiCrCdhG1DpFGUxloo1taGc+PVtdf/0pT1QvR9VcoIBzufJte
	CQsSWEL4J7acRpSelbM4oclV8iBzoC4UF7QY2YjWlQ/NijIlq5HwcNm9L5hQTx2a
	2rfSkrU2k0KwWQtNBo+neD5IMBcUvRd/bUGfrULFCfyqrDZAGyLHoAqvcJNgCX0K
	SVZ/w3BOtEz2i+NI3eLCwTjB5UlCEOGGzCYs7Yxq2sz4XwqTN8RnTV7k1KS+k/3e
	a0G/+c8+KooSgkeZdrIroQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775139401; x=
	1775225801; bh=CaEmS575vuG72PdWB4kbWXAIzRA4QIV3o8rz6fMz0nU=; b=K
	7uoeNNP6KEF0V8UL9rIhF/KljZZmsgS04lT8KKhTTFaJoJ5JWIUR7laq4HMRz23Z
	AyJu5I9jKT1Skt6Q1nGjQPbgjUi4+U2tTHAhNAuEf9+LlRKyVKma3zZW9EoW0AxP
	KMmsfQb0I9dTALlI1GZogwxaafMJLOgc8b/zpZXtyuTUAH80zHt//WOB2XlcmQrY
	HHk9IBElWqFHqO/oAJw/r/Q/74qOdi2mcdb+/eqxtb+/jPUDPiW5EL6pVa8vp2wc
	YNouKHerNxkyhNqFbqnfijagSXxEU9fwdpJFwSqL2UTRvekRkKciUcjRaLOJFrXN
	0bVS5iSYaSiHV5/eK9n/A==
X-ME-Sender: <xms:SXrOaYMDHezRkUCCxCSnct6oXzx-T7PnDppzqE2jt8w8paCT5Ve27A>
    <xme:SXrOaRgR-qLsu99RtS_uF_N6zHn-RdY4PTkCDyCrbPYIS9UbnN3fp0N6fua701Q-p
    -BHQUW73edjtZkAdy1t0YBFREUnKFIdfILDZ6-8CfOLVeFMJ2J27Q>
X-ME-Received: <xmr:SXrOaS6sEinAFWDTA3IxhkAvM2youM3zyIwfckX10jnJKxKlR6Rfp0i0mLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeivdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudegveeu
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    gvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhtshhmsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtoh
    hmpdhrtghpthhtohepnhhiphhunhdrghhuphhtrgesrghmugdrtghomhdprhgtphhtthho
    pehnihhkhhhilhdrrghgrghrfigrlhesrghmugdrtghomhdprhgtphhtthhopehpihgvth
    gvrhdrjhgrnhhsvghnqdhvrghnqdhvuhhurhgvnhesrghmugdrtghomhdprhgtphhtthho
    pehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigsehshhgriigsoh
    htrdhorhhg
X-ME-Proxy: <xmx:SXrOaQ1Zme_Bw04bOCX3MAk8oX0GNj-Zd4quFc4_-xsimaNVmLqGNQ>
    <xmx:SXrOaVvIyKnxC216Fl1A7IBBIaALOE-gCwRhf9HPbb7YnIho-3QZ-g>
    <xmx:SXrOae7GBF62TUlm1NPtSJ1OuRR0E62wYrIH3eYOJlDiRNRUOT1z9Q>
    <xmx:SXrOaZeDMePTCSJLWs4hSOzAhQQYixXge3ffIlNT5SamlXea14k8EQ>
    <xmx:SXrOaRDeiOaB6ir-bWK9XY-z3RKSwPXp3rE2Sx4_uMGSSFZGojnvq6Sz>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 10:16:40 -0400 (EDT)
Date: Thu, 2 Apr 2026 08:16:32 -0600
From: Alex Williamson <alex@shazbot.org>
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Cc: "Gupta, Nipun" <nipun.gupta@amd.com>, nikhil.agarwal@amd.com,
 pieter.jansen-van-vuuren@amd.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH 1/2] vfio/cdx: Fix NULL pointer dereference in interrupt
 trigger path
Message-ID: <20260402081632.554fa467@shazbot.org>
In-Reply-To: <12005a02-a1cd-46ca-8782-c727a7d5e5c6@linux.microsoft.com>
References: <20260320101933.1554416-1-ptsm@linux.microsoft.com>
	<e9f01579-fd53-50b9-996b-cd1d3342f453@amd.com>
	<20260401122254.363d93c2@shazbot.org>
	<12005a02-a1cd-46ca-8782-c727a7d5e5c6@linux.microsoft.com>
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
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233034-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,shazbot.org:dkim,shazbot.org:mid,amd.com:email]
X-Rspamd-Queue-Id: 7559438A5CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 10:14:24 +0530
Prasanna Kumar T S M <ptsm@linux.microsoft.com> wrote:

> On 01-04-2026 23:52, Alex Williamson wrote:
> > On Wed, 1 Apr 2026 15:11:17 +0530
> > "Gupta, Nipun" <nipun.gupta@amd.com> wrote:
> >   
> >> On 20-03-2026 15:49, Prasanna Kumar T S M wrote:  
> >>> Add validation to ensure MSI is configured before accessing cdx_irqs
> >>> array in vfio_cdx_set_msi_trigger(). Without this check, userspace
> >>> can trigger a NULL pointer dereference by calling VFIO_DEVICE_SET_IRQS
> >>> with VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE flags before
> >>> ever setting up interrupts via VFIO_IRQ_SET_DATA_EVENTFD.
> >>>
> >>> The vfio_cdx_msi_enable() function allocates the cdx_irqs array and
> >>> sets config_msi to 1 only when called through the EVENTFD path. The
> >>> trigger loop (for DATA_BOOL/DATA_NONE) assumed this had already been
> >>> done, but there was no enforcement of this call ordering.
> >>>
> >>> This matches the protection used in the PCI VFIO driver where
> >>> vfio_pci_set_msi_trigger() checks irq_is() before the trigger loop.
> >>>
> >>> Fixes: 848e447e000c ("vfio/cdx: add interrupt support")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>  
> >>
> >> Acked-by: Nipun Gupta <nipun.gupta@amd.com>  
> > 
> > It's an improvement, but I think it also highlights that interrupt
> > setup for vfio-cdx devices is racy.  I think it should adopt a mutex on
> > the vfio_cdx_device that is acquired with a guard in
> > vfio_cdx_set_irqs_ioctl().  That would make config_msi stable for this
> > test.  Thanks,
> > 
> > Alex  
> 
> This patch is fixing a specific problem. User space can make VFIO_* 
> calls in a specific order to trigger NULL pointer access. This will not 
> get fixed with a mutex.

I'm not saying the fix is wrong, I'm saying it's incomplete.  This
fixes the specific case where config_msi is not set prior to the ioctl,
but it doesn't consider concurrency where config_msi may be set when
tested, but race with a call to vfio_cdx_msi_disable().  I think the fix
needs both the validation of config_msi and serialization via a mutex
such that the test remains valid through the whole ioctl path.  Thanks,

Alex

