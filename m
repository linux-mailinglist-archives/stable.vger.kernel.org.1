Return-Path: <stable+bounces-116808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0E3A3A3CB
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 18:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C5918979BB
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015AB26FA4B;
	Tue, 18 Feb 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="GkaNkd3X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IW6ov0HG"
X-Original-To: stable@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4B26FA4E;
	Tue, 18 Feb 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898562; cv=none; b=AcKvpcDFwgM+iKZQ5GnKR4UBD+d1jS/co8ezdtaAwuXr/j99ypkQjisvF28JfHd66XZS0GuX3IlyAxgxK4oozZ6lCDfOzqxCaYEASYFS2SsW7/BG0xpexcCzRn1OpqbYdGtQa/s1IC+Lbk5VslazJeRnxlLTIcJjun9sLr4qyS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898562; c=relaxed/simple;
	bh=ZNfv9Z+5CiRTXAvuSHErOgIgMqKuLPeoR36pG38TXzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BobSUshmYYnF6OEEdNkddXG49THSGiwNz3EBfQtuh7wu/iqi550Bul1yUhYpEra+Jgewk/hre/4dztsDSCzaqgAbMAqe8Ehwp1bCz0FhANGKQC6WgLQEMLhx30ciTz5RPzcIBgw5FelqBtjLI62iNlbZNy6dIWgME7Ai4Zus8jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=GkaNkd3X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IW6ov0HG; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id BE8B21140198;
	Tue, 18 Feb 2025 12:09:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 18 Feb 2025 12:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739898558; x=1739984958; bh=wwOTnScCCn
	TcC8h4BvkX90VCNONMi+Z1jo4JL/vQmpU=; b=GkaNkd3XQxon7cMEYibkrQrNmC
	DpJV56Y12wNOp6LR7j/jNajWmKhuDbz+2zsK3yvUgx4Jr/Z4GE1VG9ykyBfS6HAp
	zA1WEk5/CZnmmWMjXh1mCLL1p6uuT6wWbru4dPys7p3ViBIOQnY3Y4228X1VYhkj
	12VFfaZeGQIQKbSkIwGiwukoQgTRmIdw3lh/jdd5AXwoACYW93VOtFTbaWujRevW
	HrRQ1rpMi3nxW5vMS883izoJRHMDkfsTcfFuGRYZt29OY6vec2kT5zmA/Zg1oBUm
	maMuDYJv3GqqmkGzkt/3+pPcMNByjA3NlWsG8ePyZ968hMJyjwvVbn6FV5tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739898558; x=1739984958; bh=wwOTnScCCnTcC8h4BvkX90VCNONMi+Z1jo4
	JL/vQmpU=; b=IW6ov0HGoK4NnRWp7+3z+tx1OrUmj5v7C8es7J/xweLNYUo8292
	UNnI9/M7UCv4Kl7nclpFjqANDaBB0la14JcRro7Nvzs32dyg9n34FSEsb6x2CZrG
	pF0j1zzpPTQw398OFU17vsKMMdI3t7CrrDDg4TKAKWBnOeRnVWaj3sREdJvSJZFA
	VH1N6n8VLWRR5UjjseRRfbHSbunedEBlaDUGNfQASNhb1ELZhhjAF82/vijX/Md/
	8kqIv9rNbqRt9YrKwpmHPTh7xtcKUfmWezsDE7jimcmgNyd5GK5z78gZbEnsIdGv
	fiF96/WaLMxcHD0WqsE5grnv2Rp7vbjim7w==
X-ME-Sender: <xms:vr60Z47shKyxaX3VYHwgKfPD-ynmqTUJbHLnWSjkDNs8mn03Y6RKaQ>
    <xme:vr60Z55o_l96Lgg3fcz0RXGzKZ6N3bL0kZjJvs8yq-wQsEeSPiE3yRECMp6PJdE8C
    eAQMlTg1LSSaA>
X-ME-Received: <xmr:vr60Z3fXWN7m7Dx-DD4z54aVlF1MP2-1BsTctSxengYumb1XIzMRbX81vWerpCg-8MW_oeiRaaV4P84ZibEDj2o7lln4moNP-QIwNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpefgueffveeugfefuddtvddtfeeivefgveduteetfeegieehtddvteev
    feetfedtkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddugedqrhgtuddrshhone
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghg
    sehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepfihinhhtvghrrgeslhhinhhugidrihgsmhdrtghomhdprhgtphht
    thhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsth
    grsghlvgdqtghomhhmihhtshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehtfihinhhklhgvrheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehhtggrse
    hlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepghhorheslhhinhhugidrihgsmhdr
    tghomhdprhgtphhtthhopegrghhorhguvggvvheslhhinhhugidrihgsmhdrtghomhdprh
    gtphhtthhopegsohhrnhhtrhgrvghgvghrsehlihhnuhigrdhisghmrdgtohhmpdhrtghp
    thhtohepshhvvghnsheslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:vr60Z9ITAJY_GvRUevxjAG7sm5SQC6AGhb2sgjJ5SY4-Nr66yKyieg>
    <xmx:vr60Z8Lgso2XqDL3QBXuKvleb_tizxSeAsKuMxfTJqh5rGD2a5sl2A>
    <xmx:vr60Z-ya1voLIQ9tLccKTpvZQSMAC7NolwfbMUPT-thzQZk-6wJiXA>
    <xmx:vr60ZwKQvYiXbhmbgKi8lF7ldW_FdVzCnfmpH2Nn1aSRBp4cplM-zQ>
    <xmx:vr60ZxB7B56Y8tkEKoP2FT2VN9w1H9riciv98pHennnQ9yRK2T8g5M4w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 12:09:17 -0500 (EST)
Date: Tue, 18 Feb 2025 18:09:09 +0100
From: Greg KH <greg@kroah.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: Patch "s390/qeth: move netif_napi_add_tx() and napi_enable()
 from under BH" has been added to the 6.13-stable tree
Message-ID: <2025021847-enchilada-quilt-d3da@gregkh>
References: <20250218123639.3271098-1-sashal@kernel.org>
 <b01c840b-55fb-455d-88fa-69848d2dcebf@linux.ibm.com>
 <2025021828-pond-matador-38d9@gregkh>
 <febb6754-f2a3-411c-a201-c403960856d0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <febb6754-f2a3-411c-a201-c403960856d0@linux.ibm.com>

On Tue, Feb 18, 2025 at 04:32:27PM +0100, Alexandra Winter wrote:
> 
> 
> On 18.02.25 16:19, Greg KH wrote:
> > On Tue, Feb 18, 2025 at 04:08:25PM +0100, Alexandra Winter wrote:
> >>
> >>
> >> On 18.02.25 13:36, Sasha Levin wrote:
> >>> This is a note to let you know that I've just added the patch titled
> >>>
> >>>     s390/qeth: move netif_napi_add_tx() and napi_enable() from under BH
> >>>
> >>> to the 6.13-stable tree which can be found at:
> >>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >>>
> >>> The filename of the patch is:
> >>>      s390-qeth-move-netif_napi_add_tx-and-napi_enable-fro.patch
> >>> and it can be found in the queue-6.13 subdirectory.
> >>>
> >>> If you, or anyone else, feels it should not be added to the stable tree,
> >>> please let <stable@vger.kernel.org> know about it.
> >>>
> >>
> >> Hello Sasha,
> >> this is a fix for a regression that was introduced with v6.14-rc1.
> >> So I do not think it needs to go into 6.13 stable tree.
> >> But it does not hurt either.
> > 
> > It fixes a commit that is already in the 6.13 stable queue:
> > 
> >>>     Fixes: 1b23cdbd2bbc ("net: protect netdev->napi_list with netdev_lock()")
> > 
> > So for that reason, this commit should be applied, right?
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> In that case: Yes, of course.
> 
> Sorry. I didn't expect Jakub's netdev->lock series to have gone into stable.

It was marked as fixing a problem, so Sasha picked it up.

> I should have checked.

Not a problem, happens all the time :)

thanks for the review!

greg k-h

