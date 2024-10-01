Return-Path: <stable+bounces-78339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C098B6A4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5992832BF
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 08:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C16199EA6;
	Tue,  1 Oct 2024 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="loYKF/m8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWbdwVfx"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95161155738;
	Tue,  1 Oct 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770790; cv=none; b=Cj4wlLMep2++GOqiKga3rwS/2k+iOi28DN1bGO+mlhTlx638Xw4H3KjT996fu8uVOZizJsvjZPWnODj5R+3CTN+KFgYve8FELHDvgfUErOhFYP2beUNWRIjueJL9LQbATHS2xjvEClYwja0boc34HAZQb4VORd+3mfUBeAGaxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770790; c=relaxed/simple;
	bh=bnFYM0nJvriU0K/TxS2+Tu9Yq2ItRjtwqzwVGU5mFm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caXg5VGegj061DtOMsx51y7rgy2I0bKHWsiJ+Xeq7KnZ6ocgaPvFQr0a0Sjuv+22YhaPywdH+P+HDdmgUg6jabI6tEyqVIUaass9HY8xooF4PDB70jInG75V9XVFsMtPPhlfxn+U/RpnBdFEUKXIaDrY9gXyvLEyS+VbSY1/7YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=loYKF/m8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWbdwVfx; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84C631141C12;
	Tue,  1 Oct 2024 04:19:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 01 Oct 2024 04:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727770787;
	 x=1727857187; bh=lXflFodTw5rai+i3zuAESQh/SuOzecEO7W+50WGtXKE=; b=
	loYKF/m8CWaksHdjJh/PaEm9oWd6dkORz5QjO5VEe3ArTTDob9AqMi8KkUanv+bC
	wBuVYkW5oUaqlu9qUqJlHKWhRPbk0wA6oGPdaDE9R1aRzUIPcBzKKDKbXguFiroI
	DeSpLmsETb74EtB27Cu9MAlKjP/d4EBL1HSujlU3DOEtoWHb6Uvv4kv38/pN/1n2
	s3uOX2x+9WXj5Mm1mzT6xzR4NO7MwGM5WB0U75NR5YzDmolsgEQwHd4f+MGhjpYa
	NyCj/aRzidp4XKIkKD0jLB3731Ql9avF0JEVv4HYr2XZq/mJNR82PMbgvLawJVOQ
	RTAdVcxj+ubZbgjtXV9JrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727770787; x=
	1727857187; bh=lXflFodTw5rai+i3zuAESQh/SuOzecEO7W+50WGtXKE=; b=B
	WbdwVfxHWfwY4yw3JNa/z/y9RkmUSIt8QxBSkdgyiUico+/HqLO3pRSIJpzMaxKW
	fR+yCBi09TUrStRBeRNrDMvmY1WPuYUrXss9mrAytm5Ki9z5y8wqQtmPrBzbLL+W
	NI32WwfAmoDRi80vOmOu0SS6O4EZWa9yzfJpEiSvJm+rlP1oO4Cz1rW5f02uEvWx
	DQJp3PFBoJdytgrmJxfpk5b/6y/KISkMMbSs7bPtwVncEPav4q5skJx+1/Nyqi2Z
	4EeTXRTF+PyEGI8eb0FhNLEiqP6Y9y+f8rYZt5CoNkgAmstSSnm2ivsAr0nEDgBB
	ZYG9kvdsdlWdf8O6UwpCg==
X-ME-Sender: <xms:orD7ZkiqSjVYDIggBtwmE-Aa45f36gcTiE4ko2mhJsfV7iUDaygIXw>
    <xme:orD7ZtBMHXgbwU7XntIKtveQAMKFEamAcpG7dw5XYLSC7RIUlXe81jWeLsMT_0BMu
    8g0v6QB4R77Mg>
X-ME-Received: <xmr:orD7ZsHsnJ5JilWK3unx8JRnXAUfIJLtdXb27yXcYG2nrhfrIaqaSe37xRmj19gOj1m0qujMZYQipMi5QyPwIpKeBSt61LfhE8837w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddu
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeegveevtefgveejffffveeluefhjeefgeeuveeftedujedufeduteej
    tddtheeuffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    pdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    hgrhhoshhssehsuhhsvgdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgdqtghomhhmihhtshesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhrihhsrdhoshhtrhhovhhskhih
    sehorhgrtghlvgdrtghomhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrd
    guvgdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegs
    phesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuh
    igrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:orD7ZlSgVWrZEJdO4GyzWxp3soxiewfPHv0FiPV4yMfeEnX4nASlTw>
    <xmx:orD7ZhyANBaPMlVD_bDOb3OIQ2PwfN4Nqo5tfInr-xQVNvcj9KvpmQ>
    <xmx:orD7Zj5QKoK0PqsOUCiUIIeV_4F31dauO11folHReMk11vkS0CjSEA>
    <xmx:orD7Zuxv4Z_8rmDCUXA6EOpDYUCXvgwZqDHKfuk6JwtGnG6OZihUTw>
    <xmx:o7D7Zmw1l-joXkjtv-WzqX1mJRAS1uqiHeVk-7ObGIs7L-w70U2h1OcN>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 04:19:45 -0400 (EDT)
Date: Tue, 1 Oct 2024 10:19:42 +0200
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Patch "xen: tolerate ACPI NVS memory overlapping with Xen
 allocated memory" has been added to the 6.11-stable tree
Message-ID: <2024100121-corroding-army-d9b1@gregkh>
References: <20240930231559.2561833-1-sashal@kernel.org>
 <25156641-8cca-4ccd-a1db-3916871929bc@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25156641-8cca-4ccd-a1db-3916871929bc@suse.com>

On Tue, Oct 01, 2024 at 07:53:23AM +0200, Jürgen Groß wrote:
> On 01.10.24 01:15, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      xen: tolerate ACPI NVS memory overlapping with Xen allocated memory
> > 
> > to the 6.11-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       xen-tolerate-acpi-nvs-memory-overlapping-with-xen-al.patch
> > and it can be found in the queue-6.11 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit 8302ac200e3fb2e8b669b96d7c36cdc266e47138
> > Author: Juergen Gross <jgross@suse.com>
> > Date:   Fri Aug 2 20:14:22 2024 +0200
> > 
> >      xen: tolerate ACPI NVS memory overlapping with Xen allocated memory
> >      [ Upstream commit be35d91c8880650404f3bf813573222dfb106935 ]
> 
> For this patch to have the desired effect there are the following
> prerequisite patches missing:
> 
> c4498ae316da ("xen: move checks for e820 conflicts further up")
> 9221222c717d ("xen: allow mapping ACPI data using a different physical address")
> 
> Please add those to the stable trees, too.

As those didn't apply to anything older than 6.1.y I've dropped this one
from the older kernel branches as well.

thanks,

greg k-h

