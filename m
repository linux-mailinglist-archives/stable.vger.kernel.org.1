Return-Path: <stable+bounces-55024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BDF91510B
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701F4286A72
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A88019B5BC;
	Mon, 24 Jun 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Jvpdlst7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="emM7p91E"
X-Original-To: stable@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F25D19B3FD;
	Mon, 24 Jun 2024 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240657; cv=none; b=b9iuFx88Ex2z+4VmD5dObRwsp0DsDiGWfyirySuxWFACjjNFpTA7rtVGAN8hPZf3+6Ro310crTqQQTy3OpIJCSh0gEqrpQIi9C2PC/HkjCneLrV4NM3UlSi6DtigSGBverebDKgfDQ54Ni/0Gd7Ch/tE5UoCPGUs56qZmcvZ5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240657; c=relaxed/simple;
	bh=ItjoXlyP6RFrrvr6yVPdhlh2OEEgeVxZYRd4QbQxgLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkqvRv/S82uHkdIhBeOxXJWpEMQt2ZP3PqFaO6Nwh011C4kKaEJ/v1Ft8NdgYQA86UYpRMzdlaKv2xYTrMmoFM8LmlH3H44+ISkzsytpaqTletFn85KsgJceztIN4Ou6B07MX3Hbvyx/Af1Xef8rh0QyYHuBo5o7Kl2e3+SfFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Jvpdlst7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=emM7p91E; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id C3E261C000BB;
	Mon, 24 Jun 2024 10:50:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 24 Jun 2024 10:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1719240653; x=1719327053; bh=iflI4hURNK
	pkWeGGfdLQAuX9qesunlHDeYmddR+aXnA=; b=Jvpdlst7MW6Q8+9OetDxf6FoZo
	LiF+YRXMroeWzcL4pbyFnRWltPR9you0yZeBmvWLqtIe/b+LSjQMJoRKTLXNiv9h
	GhOinwmeU31inqgb5/bt4xYhCBLtYsHXCxA3PlUswjC1UBYuqHivBZVuswOCHNXI
	VwxYpA73JJ4j7ZfZrYrTE7pmIHvaFcU4d5OuHuKsplKDMXVENxdUCvXAuakpyiQe
	HnHzFYcZQoe8k0MWENFJZTayK0Kq3pOgdBz6K8Hre1nw4/XxlmupZI+zr4/icRCk
	ykbf4ZaY41sx4rRKvxn9n2DYa9L2GaqBqltnxXXO3C8+MzXEUNi/8wBBKM3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719240653; x=1719327053; bh=iflI4hURNKpkWeGGfdLQAuX9qesu
	nlHDeYmddR+aXnA=; b=emM7p91EQMaTWl57LSHsJbtayxf62N23bnfNdCW4MnQA
	gQdQV2vbj7rnMk241+1z65p3jH9Zci/CxF6HDXdm+8CWpPUjG4bJ8tU+IW0GkCCt
	tJIDIQalRBZlL//rb3yBbscofibI9fTV+Rwaf+L82OXDm29UNWdWNDEVLwOMeaMj
	jEK/M9H+mzv+67EbMtpaOfxaZToBfoFc1KkBchcOba4+bskhXE7OJdyO3SvP2qBS
	+P+T7ISrhoYA+oxW0YtT10JVRFUDnLD3Z1J46p7NP3HoLGtS2LDI0XGxLHuXM6l4
	rNIG1GlEovYixakT2Mg/uqRpiFF+jPp67SuV9kqlDw==
X-ME-Sender: <xms:zYd5ZpE8FLTS2dZFpx347L0SFMQhFDwbIkq-I4UJ11Y6o47KhRM7lg>
    <xme:zYd5ZuUrqrZPdKor6Z25F1S1tJPJgb42S2unOSzuG9-NbJk3iemEerh5T8iF3i5yw
    s250NaKNLQRww>
X-ME-Received: <xmr:zYd5ZrLGYK6wzuUWtsx9TdabkrIK1cOlSbtpTeLEu7FBrQOqfOjQX8FFBAs-u8nz3b9eRgkefXgyx5fnusJH8Qx5gjKDfEEUGVW4XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeguddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:zYd5ZvHxs_7L5mGIWYq_lhhFdXHk7jbK48wYgyhkFv2sF3r4NBmSbw>
    <xmx:zYd5ZvVNbGIk2UM_ncYigWbCqawNxdjX2AalSWwkaDIlzIwnQaBToA>
    <xmx:zYd5ZqPr6QqD5S4SmikvAvPIPcOGhY9xwvwydujdQxXVlLo1MhbjDA>
    <xmx:zYd5Zu1XL9bnTAu6xjDDQNBR6NWsSNPJgmwULje5lLbJlD9T8JkalA>
    <xmx:zYd5ZoNHhpk2tyFzGpgP3UOpnu-1B8CKgU4wbWqEGjURAMYbzY_zSaJv>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jun 2024 10:50:52 -0400 (EDT)
Date: Mon, 24 Jun 2024 16:50:50 +0200
From: Greg KH <greg@kroah.com>
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: Patch "ACPI: EC: Install address space handler at the namespace
 root" has been added to the 6.6-stable tree
Message-ID: <2024062437-spoof-snorkel-8b30@gregkh>
References: <20240621154703.4152297-1-sashal@kernel.org>
 <8f7fd03d-a231-4319-b83f-def67ef6f58f@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f7fd03d-a231-4319-b83f-def67ef6f58f@intel.com>

On Fri, Jun 21, 2024 at 08:49:06PM +0200, Wysocki, Rafael J wrote:
> On 6/21/2024 5:47 PM, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      ACPI: EC: Install address space handler at the namespace root
> 
> For this, you need
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=acpi&id=0e6b6dedf16800df0ff73ffe2bb5066514db29c2
> 
> too (here and for 6.9).

Now queued up, thnaks.

greg k-h

