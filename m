Return-Path: <stable+bounces-121537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D10BBA578B8
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 06:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D7A174D79
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 05:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F7A188006;
	Sat,  8 Mar 2025 05:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pjkA/3w7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R+avuYy6"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FCB15E5B8;
	Sat,  8 Mar 2025 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741413584; cv=none; b=bcRS6koykewojQjpH53XRT1cjfSlWOuCstP73ufv+mbLUB3I1tE5Lsu+9Ihh3jV/AMgXfYsSxscJV22EnbHBTUuNbGxm8rSOXO2lX0uqUB3/CGYZQd6hg/A10MqX8Az/1zppftKhBhRbcUXAuDfLwT63BRq/poXTA21X/EsWCHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741413584; c=relaxed/simple;
	bh=5x6isPeriY4tooFN+kVCEAJ/nWOS7VHr5tjxCsHdOI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUkx+C9I4gZ/AkIkcJwi37EW3xM8fo3AfFR+DGub13MPYngkNYy0/bhlZlynhDhy1rkzY7WvoVDfQIb/8wl+BQycN8bjqPbCuarD/eFvCD3xUyMCuNsesqPNBzPArXJYVNidoQb6IdkSh2lLh4eD03u1G47DwgQSR29afKuAAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=pjkA/3w7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R+avuYy6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 88EC41140106;
	Sat,  8 Mar 2025 00:59:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 08 Mar 2025 00:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741413580;
	 x=1741499980; bh=FmgsMxhCqmgmceLCdDPE0XEb1ubyzeREmvx0bfeNqd0=; b=
	pjkA/3w7n9QqKt641i22MY3WjAAYLDE4yTPWlxzyMzWD8VPfKvMDvkrkush8rcfC
	aJ+8/sAktxDSoFRi4lW+y5cqOTgpQnyEqNutxrIDKUoDOiiJ6tyxmWXWFrMOFQjE
	ZBJaosjzylamllOtZGV1tYfSpIcONo/L9rs5VHmpACEL0skmtcME6rvnV8iiuX3a
	dwUISFtj6P0lvloHP/IS5blNN3YJDx4tAWLgKBXFsxNkGv3ZGEi5FaAF9lWL7k8N
	Fy3DbI6KFl2fOXtuTiE1vg07mEHOkRNbfEfM/V104xQUt/UQESkrZZ0s5It7wdCN
	orvWHULf+3OOFMP2MByxiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741413580; x=
	1741499980; bh=FmgsMxhCqmgmceLCdDPE0XEb1ubyzeREmvx0bfeNqd0=; b=R
	+avuYy6YfkL/clvWr4snjBiF0NKBKgAv7dyDI9ZxLAuFqIwOz5h7hhwTxd1g6Npc
	c+lc/FtT5vgccVCMXSSqhQjEl3Q0m2mOCercIKfTXqLapyC0Yrcd9NtV80D1RFC4
	CXOxdAmP8wQ7N9ZSTmG86HTBZmfTd3r/J3jVsg6PC+taTlwJGueWLKtMtSXbu7Kp
	u+9NgeODf60JiiGs0slc0UXqUxrVaVR40hlwfOF8IaNuH5GkL/V8L4GdHuv8QgI0
	C6yobKMGWrdGkfcrlhpbo+D4cjoVFQxJUwg9WpnhK3m1mSEb8jqW/3DQMRzQxzhR
	TiAefQBziJlrd8e1zwpHA==
X-ME-Sender: <xms:y9zLZ2RqOu8_V2zEorkwg2tPQ4yh3_glNc6WzWPrHaG4Zr0qQeZqSA>
    <xme:y9zLZ7xAm2sC3DF0OoJbG3g9fwGdOvfc6SFRvrPA75IQyvjvtX_tQkdPfruZ_GPdb
    6rC_118x-rQNw>
X-ME-Received: <xmr:y9zLZz3Q8_n7KHEHbjA8LUOm5-rRxi6BNkPCLzJD-r_fNL4zfHN-66_szidMSiax2I6Q1rwc-_8Spn14n-XFeFg63cWCdkaH1smejg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddvjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeelkeehjeejieehjedvteehjeevkedugeeuiefgfedufefgfffh
    feetueeikedufeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgt
    ohhmpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhgrrhhkuhhsrdgvlhhfrhhinhhgseifvggsrdguvgdprhgtphhtthhopehrvghvvghs
    thestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhgvrdhhrghnshgv
    nheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhphgrseiihihtohhrrd
    gtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:y9zLZyDkBZ0bWFAk15lirtWkDwf_Q3mUrnAo4yffekc9dsxqwmWCkw>
    <xmx:y9zLZ_ilOnALCQw5ZGZe2oXXP1icp7fcZjyQBtoPRnC3_-hEz-0mlw>
    <xmx:y9zLZ-oWnAt3_oetwgVGRZ53ZGfxH1T5mdzTrsSXCAHb9UjMXpw3Jg>
    <xmx:y9zLZyiPYaxTmGfL8iSL-izxN9u6MMR9lE7FNB_UgZRYLabsDju1rg>
    <xmx:zNzLZyinhU9Q2eFDu0hpxq-ZGB6DaA4y4WrF3jGfaZtofO4R8CpP3d6Y>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Mar 2025 00:59:39 -0500 (EST)
Date: Sat, 8 Mar 2025 06:59:37 +0100
From: Greg KH <greg@kroah.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Florent Revest <revest@chromium.org>, x86@kernel.org,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/microcode/AMD: Fix out-of-bounds on systems with
 CPU-less NUMA nodes
Message-ID: <2025030832-germproof-batting-6124@gregkh>
References: <20250307131243.2703699-1-revest@chromium.org>
 <85a61dad-46df-4920-bbff-7f500ef692da@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85a61dad-46df-4920-bbff-7f500ef692da@web.de>

On Fri, Mar 07, 2025 at 08:18:09PM +0100, Markus Elfring wrote:
> …
> > This patch checks that a NUMA node …
> 
> Please improve such a change description another bit.
> 
> See also:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14-rc5#n94
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

