Return-Path: <stable+bounces-232840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHQYC3hjzWkHdAYAu9opvQ
	(envelope-from <stable+bounces-232840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 20:27:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739637F413
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 20:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F24300D46A
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76272E62C6;
	Wed,  1 Apr 2026 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="q9+CC2dQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sn+QMQNo"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6505E2E0413;
	Wed,  1 Apr 2026 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067781; cv=none; b=ZYvtpfiqOa/BFLgofnfCvRX/fMh/3w3yDNw7iDJKEEL00EolrMJg/IfTP0CcRTwAUKzWExFPCX3La3oeZat3WlEvUcLhyegioZh4QFpCcntRuZjIcZQiVzaI+kFQT58Nr8LfvmoUQK+KtG82/iczT2pvnjGP2Gz0T6F4fVl7UBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067781; c=relaxed/simple;
	bh=buub52QuZ/KRmj2Zk3J20YYXzwuDYvuW0XMH6C7vJJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COQVrbU+DBhEQJF8OKsZxHaAOE9NQEMsr/aCWzXDQoiLZFHsNZFMyiI/yRCr5aM8H8bU3Iz0hTMvZJdLEK0wtV7fMq7pcNwX/SH8/pJv5kJO1O8/qDIZLVHFlbyujD6dgumiOjR8So/9pSIcSQfMqB36GBsaGUiAQpI5PrVH29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=q9+CC2dQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sn+QMQNo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E619EC020A;
	Wed,  1 Apr 2026 14:22:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 01 Apr 2026 14:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775067777;
	 x=1775154177; bh=aYCGW8OPkNjWJv40wrVz7L1vtYyQsORLFbpGmGVrG2A=; b=
	q9+CC2dQ2TjF6B6YXwqbqzf5YOdg1Ib4O0TaXOOnRHrs/8VCs8G7V+4isudPI7UU
	Aij4vjmm7elr1Y4KmrivlOsLbJlh2u0FzaKXT+IgLLwGrAaqB1ZgaYns3RDoqnhE
	3OJUH6OTqnN6O53ztVOQ8fpzKUJ7EEAuneAB3xGR9Hu7k1hjCt6Z6gZ3w7zmc0Ht
	Nk2Y2ue1VFwz6SBIe4+q74a9Qp8DDE98gADnTUb41vTSFPMpgzcqi0Ot6az2k5O2
	8Ytie19sIVEtxpp3cOKOsVQD0tEJLEQAJosNUfj7rzsfKumS29RwXa2lLcMcQ1ku
	A+cxX5RHdn4GoT3Kex2V4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775067777; x=
	1775154177; bh=aYCGW8OPkNjWJv40wrVz7L1vtYyQsORLFbpGmGVrG2A=; b=s
	n+QMQNoVGNItSAdI0KW7AZLWVQrPpOuUVf5kCevPjt4w9KHe14z8TXsxVKKmHNxw
	RFGFMjZulMS7AKW99nVeQvH7Ao++L8zqbtru1V9rM9UNxdIaLQ+FwSTH100cgstT
	T9Ii4t+xXgyu8PvauLKpYY6XO8QHkrx15tqf/pFQTb7sikm10ObW6F+hpNNMFiGj
	7+ro9ERiIUs2RZXzw8kt5cynu7BlRiRF4mpIzHZCC/mUYdWRQY4lUcU2+XTREnyn
	neep92ZlYmYYihpDYyeTpg/v5+YgpQNaG43YNN+e7TNEBxsYVLfxKSEuz8/WVz5Q
	47t1J2SH0v/WNCX0WpdFA==
X-ME-Sender: <xms:gWLNabHwS9RmTInZ1en-2X4RQ-sg6pjf7c66YVludETjI8K5FZ8yug>
    <xme:gWLNaa5hdDJ6ClDR4ahe-yiQneg_24snT1h2hPYlZnpoTIKuav7hA5WD5JUyhSj3p
    xiaky4073Uf8H1PD2UqDt2BymTxLbBj0RiYYPd2TNNbowPMZR5cSA>
X-ME-Received: <xmr:gWLNaQzA1YJ8HLSSq8quggb-635skYULbBfyvv5nmjXpcok6_8vjORGlkn4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudegveeu
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    gvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepnhhiphhunhdrghhuphhtrgesrghmugdrtghomhdprhgtph
    htthhopehpthhsmheslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthho
    pehnihhkhhhilhdrrghgrghrfigrlhesrghmugdrtghomhdprhgtphhtthhopehpihgvth
    gvrhdrjhgrnhhsvghnqdhvrghnqdhvuhhurhgvnhesrghmugdrtghomhdprhgtphhtthho
    pehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigsehshhgriigsoh
    htrdhorhhg
X-ME-Proxy: <xmx:gWLNaZNCKkBqqcelgjWjDs2eKUUZaMjdmHAxHSQYN3dVXbHRP0CBbg>
    <xmx:gWLNaWma0qT4sj5zK0XjPIuR775mIL4UgcJRNSps3Dmbynl9wJnwJw>
    <xmx:gWLNaeTK09xeJslcDzXz0rcvgcHcvB0pTnEfrSBnT_htVd6g8e9J6g>
    <xmx:gWLNaVU3rdm-30PzqBkRrnQR5kcmIAHKVsBATWQiDAEB2ExkPKF2tw>
    <xmx:gWLNaXaKosc3HFzd205MRtp5fg29iXLlU78wCgAtK1mLoOiG_EjK-b4E>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 14:22:56 -0400 (EDT)
Date: Wed, 1 Apr 2026 12:22:54 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Gupta, Nipun" <nipun.gupta@amd.com>
Cc: Prasanna Kumar T S M <ptsm@linux.microsoft.com>, nikhil.agarwal@amd.com,
 pieter.jansen-van-vuuren@amd.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH 1/2] vfio/cdx: Fix NULL pointer dereference in interrupt
 trigger path
Message-ID: <20260401122254.363d93c2@shazbot.org>
In-Reply-To: <e9f01579-fd53-50b9-996b-cd1d3342f453@amd.com>
References: <20260320101933.1554416-1-ptsm@linux.microsoft.com>
	<e9f01579-fd53-50b9-996b-cd1d3342f453@amd.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232840-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,shazbot.org:dkim,shazbot.org:mid]
X-Rspamd-Queue-Id: 8739637F413
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 1 Apr 2026 15:11:17 +0530
"Gupta, Nipun" <nipun.gupta@amd.com> wrote:

> On 20-03-2026 15:49, Prasanna Kumar T S M wrote:
> > Add validation to ensure MSI is configured before accessing cdx_irqs
> > array in vfio_cdx_set_msi_trigger(). Without this check, userspace
> > can trigger a NULL pointer dereference by calling VFIO_DEVICE_SET_IRQS
> > with VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE flags before
> > ever setting up interrupts via VFIO_IRQ_SET_DATA_EVENTFD.
> > 
> > The vfio_cdx_msi_enable() function allocates the cdx_irqs array and
> > sets config_msi to 1 only when called through the EVENTFD path. The
> > trigger loop (for DATA_BOOL/DATA_NONE) assumed this had already been
> > done, but there was no enforcement of this call ordering.
> > 
> > This matches the protection used in the PCI VFIO driver where
> > vfio_pci_set_msi_trigger() checks irq_is() before the trigger loop.
> > 
> > Fixes: 848e447e000c ("vfio/cdx: add interrupt support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>  
> 
> Acked-by: Nipun Gupta <nipun.gupta@amd.com>

It's an improvement, but I think it also highlights that interrupt
setup for vfio-cdx devices is racy.  I think it should adopt a mutex on
the vfio_cdx_device that is acquired with a guard in
vfio_cdx_set_irqs_ioctl().  That would make config_msi stable for this
test.  Thanks,

Alex


