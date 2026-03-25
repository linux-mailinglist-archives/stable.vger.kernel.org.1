Return-Path: <stable+bounces-230362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAolAv0OxGk+vgQAu9opvQ
	(envelope-from <stable+bounces-230362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:36:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3AF3291FD
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7338302D97A
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B223F0A84;
	Wed, 25 Mar 2026 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="aVyuVZEm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TMEF5ntT"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA33E0C66;
	Wed, 25 Mar 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455912; cv=none; b=WgyqQ9Yo6DeMZj7m9LDOk32fM0F1jqjmazAYj59SOJjGbQPp0aFhbkjnPrRN89f3HFbOGS4QCCPVys29Ig+fKUYpZUGbS2yxjeFtly/jX+FyM9MJc3dTVAgxIPsSH35+VGQQeGz4jwl77uj/kpHL0Iu+VgsZjVPBrhTaxTpVRNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455912; c=relaxed/simple;
	bh=KlDOHSwrDtEzlgKW2xnvFrCVTld4Tl/z7+kVOjPvQs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvCCiKtm8tQc4BFoImh0GIvx6FvvlufmD2csXALaZ7YcoCizlWNleWYENbZODUBU2JF+IWX6+RR5B6mLG1fEwlWUcm+URIXVHtRmyCNeKTSzT89Rlp1yT3mdr7CFfWUejuv72mKXY9ufaAQ3fD4peghki+tXavRUw6EKbCKegjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=aVyuVZEm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TMEF5ntT; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 1EB201D002CC;
	Wed, 25 Mar 2026 12:25:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 25 Mar 2026 12:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774455907;
	 x=1774542307; bh=faYC/qqrNSOHMMTzCdqtq53TcwibI4VXxFSMspPZRkA=; b=
	aVyuVZEmARWu2cqMHmSp6ae3NtLkebOkKe/7rFL0Yn30P2w3FHZnWGamlDyp+oes
	/ZcjaqDBzKE9sqEznIubP79Wpnq5tsCLAHz3rZXWfSTVQdAgNAx928Zvdc+g85Km
	33Fko8t8tJLq0Gn+KBqA43dBH8Y7daKqdi7P7rajPVO/ZCNHjcF3DT6OnzkZs1tD
	W/lW0lXeOqoUQ3wzvwBGwHWmRDJBsumLI1SUQVQcHvEp/a5S2XtbKoZLPSPj9QDm
	wIh4CqMAe2Dg3eqTyj7BS4oXDPmqfHldlB3Wbr73cQw3QdQECTriH4yvm2EgDvpJ
	gKzc4lPKR++rA9EJYbUM2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774455907; x=
	1774542307; bh=faYC/qqrNSOHMMTzCdqtq53TcwibI4VXxFSMspPZRkA=; b=T
	MEF5ntThZQqDlSrXnScuOnKo75B/qNU+QWWO5N49imxOqUvCZ8nsb+Ju+4szYYZv
	WewwbobaHtz5CusxGINSOwNMVtZVU1MF2/10mz+nja8XXOvwESZTShYV7PwUJGLe
	uTHZZvw+0kqf4MtYu1eJ0HsfgvptmDAmPDww9cAQ6+rYcgR9i52r34CaHxXPvSiW
	GiUK7AqhPE/8WBKOTrmGQDfGfN+trjUjj+ilOXdZnuhcWYX1/7sT8SveOcQABq1m
	+liCFDlc6fxz8WtYlJ0/5atR3QeRvO/TVa2k0UNw8/ttnSFRZKWoNvTKVDLBhiUk
	XDEaSQQ/tjbLqyilQqlFw==
X-ME-Sender: <xms:YgzEaUa8X-rUGGkFepkQqmSt9s1HA0BA5mRdbwPFEub5Agl_WFmq5g>
    <xme:YgzEaZwip5mg_lOWDsoUepJzCQCtxIXgNuenXRFTP83QhNDxu6dRLmGA-MiSSGK_x
    H0XUFWscVg-gCI1AZ6Ih0cdodyJmedAdSP8Ot28D-S7VG3ZoK2c>
X-ME-Received: <xmr:YgzEaVGE2HEo3RYbLMXVr8Virt1bj6EJWk9pLJrycUrAjgcpri7MxIj1MJ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeeftdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegkeejhedvtdelledvvdekuefgieelgeeuleevhffghffggffhjefhfeeh
    ueffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhhifhhmsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqshefledtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrg
    hsseifuhhnnhgvrhdruggvpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtlhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgrsg
    hlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YgzEaZxAJFR9xBB8HvZxlyv7ArVPyF1LGf2zfKB4BD5dyVfRWv-ooA>
    <xmx:YwzEaYOvdtH4c8rM7SQ9Tmc1B26jFS9fUErfKH59IQKBs8vf79C61g>
    <xmx:YwzEafbfpmuISnWXOBdk9mVBbOkznOd2S16p3ASyStaqLwL5v86Szg>
    <xmx:YwzEafDP7-61bKtZP6Vb2Z2lVWuGGHDxqNehRwJaHrfPhYWeaQNglQ>
    <xmx:YwzEaau3R0LqE_E_gyOh84D6lymyc7USGnQUWUWltpxLlSTGC5wyGlDU>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 12:25:05 -0400 (EDT)
Date: Wed, 25 Mar 2026 10:25:04 -0600
From: Alex Williamson <alex@shazbot.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de,
 kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, Benjamin Block
 <bblock@linux.ibm.com>, alex@shazbot.org
Subject: Re: [PATCH v11 4/9] PCI: Add additional checks for flr reset
Message-ID: <20260325102504.56140878@shazbot.org>
In-Reply-To: <20260324224936.GA1157694@bhelgaas>
References: <20260316191544.2279-5-alifm@linux.ibm.com>
	<20260324224936.GA1157694@bhelgaas>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-230362-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,shazbot.org:dkim,shazbot.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D3AF3291FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 17:49:36 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Mar 16, 2026 at 12:15:39PM -0700, Farhan Ali wrote:
> > If a device is in an error state, then any reads of device registers can
> > return error value. Add additional checks to validate if a device is in an
> > error state before doing an flr reset.  
> 
> s/flr/FLR/ (also in subject)
> 
> Also please extend the subject to say something specific about the
> "additional checks".  E.g.,
> 
>   PCI: Fail FLR when config space inaccessible
> 
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> > Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> > ---
> >  drivers/pci/pci.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 373421f4b9d8..8e4d924f4e88 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4371,12 +4371,19 @@ EXPORT_SYMBOL_GPL(pcie_flr);
> >   */
> >  int pcie_reset_flr(struct pci_dev *dev, bool probe)
> >  {
> > +	u32 reg;
> > +
> >  	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> >  		return -ENOTTY;
> >  
> >  	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
> >  		return -ENOTTY;
> >  
> > +	if (pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &reg)) {
> > +		pci_warn(dev, "Device unable to do an FLR\n");
> > +		return -ENOTTY;
> > +	}  
> 
> I guess the point of this is to detect devices that are inaccessible?
> The same sort of thing as in pci_dev_save_and_disable() from patch
> 3/9?  But we use "dev->error_state == pci_channel_io_perm_failure"
> instead?
> 
> No matter what we do, this has the same race as in patch 3/9.  And I
> think using dev->error_state also depends on AER being enabled, which
> cuts out many PCIe devices.
> 
> I think using the same exact code as in pci_dev_save_and_disable()
> would be more straightforward.  And also the same sort of wording in
> the message, e.g., "Device config space inaccessible; unable to FLR"
> or similar.  I foresee many of these messages in my future, and it
> will be helpful to have a specific clue about why FLR failed :)

I think pci_af_flr() and pci_pm_reset() are all subject to this as
well, some of the device specific resets too.  Maybe we need a common
helper with a string provided so we can differentiate the callers, even
if we don't make all the conversions in this series.  Thanks,

Alex

