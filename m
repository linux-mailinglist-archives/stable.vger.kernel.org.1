Return-Path: <stable+bounces-200791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF34CB58E7
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 11:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C35E301DBB8
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6504F305048;
	Thu, 11 Dec 2025 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="gteaPq/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f5KV3Nef"
X-Original-To: stable@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F7226980F;
	Thu, 11 Dec 2025 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765450164; cv=none; b=D0bnut07EdI4/yCyS+Geb8w2SpyVeW1RlAYHQOQxbqrq6TsPfuzCsizFAH/lUykGvB+H+v9TdBsfpwUjiSb6Un7wVeW+bCv6CyhZaZVLZ+O6lgwPFOh7/1XcKKSNGA6MZkG9qXRETLEg+oLWYChIjNw4kaihArGnRFevkWOrV3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765450164; c=relaxed/simple;
	bh=ZMtEOQfHto48TI2NKNfhRYnk7HR3pQP1Ggw3Ig0X68s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sS15yOy/klYSLQZjad+dhCAK4ixQq7/wWAsRuhl8jiL+dfN+Wh/E1m8D63Qqr5Mb82RdOByDpYivpBqmwL3qEiaxrQw98uEp8xlUZ8iZfVNiwzgwwitaTCUOr3GkTqMK+feY+E0FLJHxIy7J555ZgMlCThzoldo43SwlQnzR1oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=gteaPq/H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f5KV3Nef; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 0CE081380392;
	Thu, 11 Dec 2025 05:49:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Dec 2025 05:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765450161; x=1765457361; bh=mdcxiNd9OE
	2zw6LOwpXaWFY/tSWlCV1tDp8LemnEQqI=; b=gteaPq/Hc6kbkAqiwI8Q3Q5Ynq
	f35ZS2ymrGRVHT0q428o74Fvgdm/5fbwp1/K2I9bICfoXMc7uyaAYd7WZpfxOmVq
	9iEMzjtJthUIFnR9unp2NY7OFw8FaiYRtlu0IV8Nv8ASJCg+M4p7P/HTAU/LrawE
	277nzJeu2cGDPxTYph6Mq6vpbEZcbL2W5BAR54aYX4pDVCQah5lCsLWcyMDpenhW
	O1aCKIkmYuGs6JAYS9SFJTTUoVz1xvW+6xEjJfy4cTJUrvsa3RHSA6bMnJMk+hSy
	cUiHlpM/sIYP6o2CgnTBBWtlWBX2kPPZc6qjtJOFZaxERGuz7Zni7xJGrjfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765450161; x=1765457361; bh=mdcxiNd9OE2zw6LOwpXaWFY/tSWlCV1tDp8
	LemnEQqI=; b=f5KV3NefGz0q79ugNgB5i6zV8RgCFv13lgyASFSFeB41TauIag/
	6Sr4nX/2cB6s5NsWs6PxCjvCciY92j6HmFnQ5E//06ZldwqcWf6ZZvhCu/agtriO
	QbEfIjKSxTCSFjwzpvLz0XBISI5iLqcwaf4VJW5mX+aIesih5JevP1KfvAhz3Udz
	ZllEAAm0eKfUbLfAqT54hvmZbeGYyQon5tQVyqVzcM0IboV9hZhPEJZ//eVM3KJi
	FjPFi5ZHbk8yd5wbM5RgxleigJZunDJn2ZLYeiL5b/lldVJ+c+hraY7gI55YKT1I
	pFEPzEbRH9XrSMThdhX/M3xv4em/XwCq9SA==
X-ME-Sender: <xms:r6E6aadZfVuEtDJTYQVhcsrCDZwjAkjKHhzH4QdvzhwzECKieleChg>
    <xme:r6E6aRp8uV1c7f-btkOi5HywpyngKvARNsdZKGBwpib6lnIvnz7gzte3jdyYIaK2r
    hTZ2dIFXq8eyjVFTYNts8TaaBle7ACmcqYPDROm2UWCsFV1>
X-ME-Received: <xmr:r6E6abfuwZ_xQKp6RrN2T5GLz8NfLRXuaiCPYWu0jqS7iJoHgRhuTIbNUb_Goql0gD8S8VdRhY2jGh97xAxF2d0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhefgtd
    eluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedvgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhkuhhsrdgvlhhfrhhinhhgse
    ifvggsrdguvgdprhgtphhtthhopehlihhhrghogihirghnghesihhsrhgtrdhishgtrghs
    rdgrtgdrtghnpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphht
    thhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrg
    iivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hhohhrmhhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:r6E6aZmmA2-g-hxBdZGuCKrOAiV1klMTLH_JEBtR8ZPM7zdJdLoptA>
    <xmx:r6E6aWu9C_plcyRcoa7-oqUUW9EbQki0-Ko_MjHmFzc7Ek79hA-hhw>
    <xmx:r6E6aUz6L11_DvC7VLukBL126Z8Ct6QXLF0ZfyKff2VVtS4oMg-XSg>
    <xmx:r6E6aZxDL7ipAWngghJX0YtNVuYzNSzcno9r2ktLP3TkIgJJrABZ3w>
    <xmx:saE6ac2watM5pAhCs6mFU1ZFJh7FHwwvcd6yj3GU6EHfoNTbFSrwSw2g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 05:49:19 -0500 (EST)
Date: Thu, 11 Dec 2025 19:49:16 +0900
From: Greg KH <greg@kroah.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fjes: Add missing iounmap in fjes_hw_init()
Message-ID: <2025121108-armless-earthling-7a6f@gregkh>
References: <20251211073756.101824-1-lihaoxiang@isrc.iscas.ac.cn>
 <b3c0256b-b54b-49c7-91e3-8ac189613abe@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3c0256b-b54b-49c7-91e3-8ac189613abe@web.de>

On Thu, Dec 11, 2025 at 10:10:37AM +0100, Markus Elfring wrote:
> > In error paths, add fjes_hw_iounmap() to release the
> > resource acquired by fjes_hw_iomap(). Add a goto label
> > to do so.
> 
> Under which circumstances would you get into the mood to take more desirable
> word wrap preferences better into account?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18#n658


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

