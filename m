Return-Path: <stable+bounces-181824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13577BA625C
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 20:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475EA189A758
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 18:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9912B22D4DE;
	Sat, 27 Sep 2025 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="fRwqZq3J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kkcfw90Z"
X-Original-To: stable@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD922B8C5;
	Sat, 27 Sep 2025 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758996553; cv=none; b=KW/PVj76cEgXq4qkwpNRzIf42FhljiTrMT+bo7ZIcx/hJf0KfOlf3RGiFI10wHpGtvz7K2lGqrmhvXd7k7Ey3BskLMkyMBm8bQb1CkN6rFbd//5neZPGMU79Yf26xkag/tEev5iKKWZ62l3Z46JktVbHCcNX8RTx6bIv4mpW0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758996553; c=relaxed/simple;
	bh=21/OaUZTQOqMWP0UUGYmj37rN7bY/3NrEREd9tA33h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPjLPho5s/DJjWyXcJjhzXvMCCBmzADGgDDLQDPNCBjBnM3lCm+hw5/WiZpZe0wuvcdZUeD9x3GBTHYjfMaYAe4Bc1umhFVt5EPhkNK68m7VKVEZq6CTmnRXE8p3JjKiqB9oek5Wl5NdtHD9gfeFWuy/V0qHXMTAlLAHMsRy3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=fRwqZq3J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kkcfw90Z; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id E4EAC1D00075;
	Sat, 27 Sep 2025 14:09:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 27 Sep 2025 14:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1758996548; x=1759082948; bh=zVmWk//tS0
	x4EgJXBIHJsb8UJmMAL/AYdKjLj2iNX3Y=; b=fRwqZq3JMaJaKVGmbJpZpk2s4s
	rBQcnZxRPOUfzP7x3gZdq4DfjDCRXPY0qKv0EfbJmD/HkwfZc0FSNNlKpNqocgqp
	QRDTJ4Kx33lHJa9nSETWW7QcvQwbk+Ah4UdEp3yIOAOm382TlU/CKw3Pa6lWOTYZ
	SFRXuJBAsxBNdvY7t7cnEZAlPVN1AKHdwuyyhWNOqUdTQhLKrxJtbCHHwW5CsK/s
	YynsKmVELO94F8UeeGsdd33DicKVFAP8dN5Ca3YFRKZoR6MuC0Fe7lONWdeDo7X+
	JBvWoCeV31+BtxsvAwlpsQ0NqFD/3AUsjXpcsNTVmpuNASy84q/WZPbBVePw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758996548; x=1759082948; bh=zVmWk//tS0x4EgJXBIHJsb8UJmMAL/AYdKj
	Lj2iNX3Y=; b=Kkcfw90ZtI7lzH8Vdsm0sKYNtDzG/0yvJ789mQW+H3CmspNSONV
	Kpspa7OY9GGZqDQxX7+XNNFCLECbQUkOiUQGRg7YF+1lcWITZyqToQiG2onpBzZu
	BiZqOeqqwwbYP993DFfR2pG0cb6hDIbFmH47mE6mgwGY+bs71p64Js+oyti1kSLX
	sSDJ0dV4ajfnjayyTwDvBgSQBa98ZQla8f/IrEHtn4sb7fv4pKzreDzDhpkVTI/f
	rhYLPT84LAAC8SkdjqDgQLpM9pzgFnCsrSJ+yCuR39yI9bkIWyE//+7YCS2APAPh
	eaaeRqGp+RvRYvXfnZn03/5axDTO9fMYpCA==
X-ME-Sender: <xms:QyjYaAlrfQXdagDoRqmbxAzmzqU4P3riJEV1RDmb7cpPZ3k94YD57A>
    <xme:QyjYaPsnv5_3qKUMLnl-JRnsFQrShKa8AczlTuJi5tEoTafMgZMmdu2jjIkrDQ-0n
    8I0dnwhqa6MfU8RJc8VPsFRIh_EiSeJ6RCQ1AHbGqil8IFy_Q>
X-ME-Received: <xmr:QyjYaL-Oi57zYKtC79Y8zD6laaT8hyFhNeeX0h671P8xW-tK4fp4v4kmIk5jjf4kcV3znh5Znvc3R_iPaburSjjvW42puvqMWv72Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeefveeiffegue
    ffieekjedvgeethfduvdejlefgveettdfggeeigeelfeduleejkeenucffohhmrghinhep
    sghoohhtlhhinhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepvdeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrkhhushdrvghlfhhrihhngh
    esfigvsgdruggvpdhrtghpthhtohepmhgrkhgvvdegsehishgtrghsrdgrtgdrtghnpdhr
    tghpthhtoheplhhinhhugidqthgvghhrrgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdho
    rhhgpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhope
    hjohhnrghthhgrnhhhsehnvhhiughirgdrtghomhdprhgtphhtthhopehmphgvrhhtthhu
    nhgvnhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrd
    gthhdprhgtphhtthhopehthhhivghrrhihrdhrvgguihhnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QyjYaIwYcAUgWXxw0QXtK-RbYwg-6YGeZI9qxodf05YooZ3V_aCkEw>
    <xmx:QyjYaL8QYEbKm-RK3sagUTpjecWo8FvFKF3aFMF4y5YaHggo_VuUiQ>
    <xmx:QyjYaFIB4aoj4SDHvMT7ZKv9R0wF0Nljkih8Wjuq5CXYG5m7JtafxA>
    <xmx:QyjYaI_35Vpyyuvpkn_5YhpNS10loeNFQzZruQv_IlDIXfXPIx8DCA>
    <xmx:RCjYaOETspx8324KALNbKAAnzQjoEh_CudC3xH99yqPuXpOqP6WhSppe>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 14:09:07 -0400 (EDT)
Date: Sat, 27 Sep 2025 20:09:05 +0200
From: Greg KH <greg@kroah.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: make24@iscas.ac.cn, linux-tegra@vger.kernel.org,
	dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thierry Reding <thierry.reding@gmail.com>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] drm/tegra: dc: fix reference leak in tegra_dc_couple()
Message-ID: <2025092700-timing-devourer-238c@gregkh>
References: <20250927094741.9257-1-make24@iscas.ac.cn>
 <f0b0a007-599b-428b-bea6-5eafc567d757@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0b0a007-599b-428b-bea6-5eafc567d757@web.de>

On Sat, Sep 27, 2025 at 02:43:17PM +0200, Markus Elfring wrote:
> > driver_find_device() calls get_device() to increment the reference
> > count once a matching device is found, but there is no put_device() to
> > balance the reference count. To avoid reference count leakage, add
> > put_device() to decrease the reference count.
> 
> How do you think about to increase the application of scope-based resource management?
> https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/device.h#L1180


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

