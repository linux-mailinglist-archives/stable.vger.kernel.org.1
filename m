Return-Path: <stable+bounces-196614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F27DCC7DC16
	for <lists+stable@lfdr.de>; Sun, 23 Nov 2025 07:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99837349FDC
	for <lists+stable@lfdr.de>; Sun, 23 Nov 2025 06:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C81B214204;
	Sun, 23 Nov 2025 06:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KCKXSbqt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eXWq3xTW"
X-Original-To: stable@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF684154BF5;
	Sun, 23 Nov 2025 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763878969; cv=none; b=d9OhG2VjDHKpl/HuIDNZS+RzUuwaSm8lqk9Jzlj9Lq/u+CAxF3Qr3SEIgwjuftUOH8X2NQg9JRWRlYIIQH9hlX1zkk6L+cki+ZGD5C6NlIw2R8t1/9V5+TiSdnJMn1ndBvQrsfEpVCXPLZUa/uDKjWkxtJl58KVf5n4/ZzyR9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763878969; c=relaxed/simple;
	bh=NpJ2TrZ2fxiFa64xgKbdpladtq8k2tsnrOySZln8RFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1q4Ttt6CnWNubXmvQH0ICG+tW1YotKCDTVlLP+4e8PGQeTxypekC57QgnzztlUnLwhFGPJ0oa6zgiI7T9/G0tQi2C1G/kQH7XgtuZ0ab+B12A+oeGsrz7jS1cg2auEmYqEPJWWaf4XjZiQyE61kle/mdSmyPtZ8akrs7TGbAHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=KCKXSbqt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eXWq3xTW; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id E25D5130010A;
	Sun, 23 Nov 2025 01:22:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 23 Nov 2025 01:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763878964;
	 x=1763886164; bh=F68B6sDYvZaZruZD9EYtEFdkvU0b/sWEl4wjKc2fc/o=; b=
	KCKXSbqtghoGkk33nPGn/n09Q8/A6aKpIU5wFLUrI3uxJxLDRYsdb8o73C8iJ2/O
	fDLD9xq+NDaofsQd/pGbw4Ghy+UFbuYNN++rEAfinc/DfXZ/Tgzr5P2NFzTj3HiJ
	La/eSPJWOorUjKaJNCwgw8G78lfetMmpgS7Om2LA1jo415S+OYkKTaUXD8HBUOS3
	eU0B+VhAV1HmIB16zZncL9s2OhskgFNznx84s4Mq4V8ptHejFbMcMI19zAC+TpZn
	YwGkwb6U00u6+S5a0g9T1b3LObRzoHPB0JA9BvCQQhyFJHvVRRid0+qcaPO9YSYT
	jVFWuVnHdE8TBr2HFaMRuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763878964; x=
	1763886164; bh=F68B6sDYvZaZruZD9EYtEFdkvU0b/sWEl4wjKc2fc/o=; b=e
	XWq3xTWlVRdH2/ipSSmxESRyasrjxZp73yYYe3HlaYTBvTMMNR+jq+U2PBfCJdZG
	Z3N2wxW39vxeJ7hsgX1RdRUWVgMG5WuTYMB4jpmo2+bszpFMcO4a+z4VGJCgmCAd
	YYNdb2ZxKfOkF6DNxwZQNuUpk9XnJkGUR/doVS3Vq13Xp3uBvfwgLbxS2n+keIPL
	gYIOh124uBa0WOVbxq4ixndx/cxLetqFrYl1f7vrnVtZuUiX8FuWzdJAnhmGDEiQ
	e88bup/L4UKJYurS9Jud+8CdaGb9Z+6dgbsOCN++sqHjVE43Bhl/1Yreg96nOeuK
	D+Ke9dtjFFhKY1Kr7Ap+Q==
X-ME-Sender: <xms:M6giadG0Qy-QdoK0jRTKd75cbm81fXgHdAPr4151JKs9A8q01GtPSA>
    <xme:M6giaf1ywxLc-mz3saW_u6BgoSQI8-jnHCdt9oXvGa3Idvlu8Clje0P-hq9lFkujX
    LPDTDLfNtToYuct0RvMr9j4x8hqwiymVvvWvXg0x5gHvi6U9g>
X-ME-Received: <xmr:M6giabNZOAhebDnUND16QjY2RiycPmwOk4MlmyTYmzhq3DFykpQNif_9jD7HKr_029YWsHowlzRMy_x_ZDOJbrqFI5Tmq4xt28Pm4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeehje
    ejieehjedvteehjeevkedugeeuiefgfedufefgfffhfeetueeikedufeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeef
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhkuhhsrdgvlhhfrhhinh
    hgseifvggsrdguvgdprhgtphhtthhopehmrghkvgdvgeesihhstggrshdrrggtrdgtnhdp
    rhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehflhhorhhirghnrdhfrghinhgvlhhlihessghrohgruggtohhmrdgt
    ohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprg
    gsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:M6giaQXrCarEAx3Tft4MK1_raIE62Wto0L6V77QUosoohrUUQPiyRA>
    <xmx:M6giaV0Q1enbMwLX35RLAHPBv6duEAHw9QBdyHi_HXk8WWEokEDwiA>
    <xmx:M6giaZtAxwWXtHfsQpGbvuT4RTLhy6OHPynyL0jilegwJFz62u8g0Q>
    <xmx:M6giadRV_kG_ZyU1fp1AJ3PJGj6WnzDn2oUt3mvmXWFf_YFlVZmFjQ>
    <xmx:NKgiaYCcCVU9XLu5-BRER-TRZB6lxLL8drVxOup9_Ax-qL1g4MdwYkgg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 01:22:42 -0500 (EST)
Date: Sun, 23 Nov 2025 07:22:38 +0100
From: Greg KH <greg@kroah.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: make24@iscas.ac.cn, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>, Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Vladimir Oltean <olteanv@gmail.com>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] net: dsa: Fix error handling in dsa_port_parse_of
Message-ID: <2025112332-moonscape-varmint-86b1@gregkh>
References: <20251121035130.16020-1-make24@iscas.ac.cn>
 <ca517274-9238-4f76-98c5-2fd31276d64f@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca517274-9238-4f76-98c5-2fd31276d64f@web.de>

On Sat, Nov 22, 2025 at 08:58:12PM +0100, Markus Elfring wrote:
> …
> > returned structure, which should be balanced with a corresponding
> > put_device() when the reference is no longer needed.
> …
> 
> * Would a corresponding imperative wording become helpful for an improved change description?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18-rc6#n94
> 
> * How do you think about to omit an extra check for the variable “err”
>   in the affected if branch because it can always be returned here?
> 
> * Would it be helpful to append parentheses to the function name in the summary phrase?
> 
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

