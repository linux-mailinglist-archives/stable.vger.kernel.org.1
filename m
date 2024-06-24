Return-Path: <stable+bounces-55028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D83A915125
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D111C24630
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8F719DF43;
	Mon, 24 Jun 2024 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="HYcbw/cn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SnPqGXi2"
X-Original-To: stable@vger.kernel.org
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414FC19AD6F;
	Mon, 24 Jun 2024 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240935; cv=none; b=cUEAC6aKwH3IWraw8cdth4FCz16dLy2TlxYHcIhOvz7O6CMs6wxsgdQUI1gm22HDjug9r1KKzpqJ3g9qXTdLThjA7tx95VjO/wQq0xLGdmN1AQ9YesUHv5fMF4dF6ic+8SQHU8TY5Kmhnvz6OVSTy8PsZUPFJh4MAtOi0uzqSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240935; c=relaxed/simple;
	bh=WBOBly65fU8NRUJxNVjP4blWq6ZHkhmfS2t8zXC9aAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hibkL154y+kdHPFKr51M0TOyOyv6MouqRlcjMqyI+3XzI76mYNtsht69YbG5eAjj1X8DrWFrrbCzc71vF7KCumMSzxWxOMy3FmlL4NpT/xHzfbTNwYLHaKibjxeU7T+Ut6fTzmh/p5pYUX7x8jj5cJWRrzvIJJOIP4wM72bZ4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=HYcbw/cn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SnPqGXi2; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9127118000B8;
	Mon, 24 Jun 2024 10:55:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 24 Jun 2024 10:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1719240931; x=1719327331; bh=wKnWwjzEX4
	rsvDW+y40PklVp0d4+hpuGPR1/66g/Fbc=; b=HYcbw/cnZ4U8/KmW6wMk6jAbeI
	O7Fydw9XkWiWpGuNsYmaSwLqxRFoM+6ZiOHQlXvQ0uQOv6eo/X2ZwHjW7d1yBJYB
	lb281SIO90je/6WguaZyPrMZ7A4byDqTutFgdMVIdGQh2LOAV9zOuiM+m/t6LHCI
	POkBFea3UK97tW/9dwFZeGGxCahZM+00yalEtSwg9u5jLdOoDxAGl9mXJO3CyQr1
	I/UHU87qjfYfisV/DpTTXHyE/di797lwCsdM1QJkGyj4uY0bd8nq4DHu3VAWCnNH
	v2Gs1mmSaaPsRyD6UaLlxWSElFn5eQETKbDeqtwxEPEIr4WfPr1nPY+EWxHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719240931; x=1719327331; bh=wKnWwjzEX4rsvDW+y40PklVp0d4+
	hpuGPR1/66g/Fbc=; b=SnPqGXi2YWg6aGXrqzu0uVMACKtntz1Ck0QDrAe2Rspd
	xEP7Pw5ZURG3fXNUScYnrRXyeywgW8YOZCsFjMCHzTRdPYRhcgPCbZVJNzqNMUQ1
	f1ayyRri5RKXxEuCeh7GroOq5i7Xd60swm4RJ6SKhwacvK0uH3SvKzWtF6B65D2J
	xE5+O2bIqwkBhz1/5wmhl9J8GvF4rDDP8UzdeVwyaDfMFK5wRhrbS77Ysl+Gk9YJ
	BTV56eclqmBWIMh0C5LxN7/z0YI9IA3d8sPOBkj0sNyUAIEGjfvQMdtoUhUIBMm+
	/5ByEUOLX96CqsD3i3kz3c7wunDbfIfxFJzNk+08JQ==
X-ME-Sender: <xms:4oh5Zsoc_Wd_ONaaOgSTnQmL8_6hICr4n-0kEnqE3yj4F317uE8LiA>
    <xme:4oh5Zira0KxFrvzlmMUifgdc9sZ5rjcej7hap-sDzXq5N3T49EeKp8OqNJ-XS3yLj
    jmJWl8Ynw7drw>
X-ME-Received: <xmr:4oh5ZhP4BrueBoOw3ge4CcsqKLscTsiDNiYxxcpKQByqehFi17ALmrkV50bhBMOHo1WKazYAHFC-J9uwvqTmhxrWQtDfQ9Nm1SPS1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeguddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:4oh5Zj4eQFVmkD6DiE41kkB_q6juoLQzATjFPR9GtOVGWoSQUyBarg>
    <xmx:4oh5Zr5Y5MiZbDUT9Gq_v6idgYkbzagQ0qVEKLew4qkvs5VZxDWNlg>
    <xmx:4oh5ZjgZA8U1E6y37ba0F9TERUBlblAEDsaeUCUkR9tb7fA1Q4l8ig>
    <xmx:4oh5Zl6eN-0zFtNRdMhwhbapnoNYWezWpc30e0Ohq_xTE6o_xqDpgw>
    <xmx:44h5ZomOeUfymLKm69dOV5JtF0NgtEcJSHwxspUv8LfjWcChNIabuKk6>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jun 2024 10:55:29 -0400 (EDT)
Date: Mon, 24 Jun 2024 16:55:26 +0200
From: Greg KH <greg@kroah.com>
To: Joel Granados <j.granados@samsung.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>
Subject: Re: Patch "netfilter: Remove the now superfluous sentinel elements
 from ctl_table array" has been added to the 6.6-stable tree
Message-ID: <2024062407-convene-imperfect-6c22@gregkh>
References: <CGME20240622234558eucas1p2a6211f0643e368f34541573847b7105e@eucas1p2.samsung.com>
 <20240622234538.197608-1-sashal@kernel.org>
 <20240624071005.tnijkj7b36bvztks@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624071005.tnijkj7b36bvztks@joelS2.panther.com>

On Mon, Jun 24, 2024 at 09:10:05AM +0200, Joel Granados wrote:
> On Sat, Jun 22, 2024 at 07:45:37PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     netfilter: Remove the now superfluous sentinel elements from ctl_table array
> > 
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      netfilter-remove-the-now-superfluous-sentinel-elemen.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> I don't understand why we are putting these in stable. IMO, they should
> not go there and this is why:
> 
> 1. This is not a fix.
>    The main motivation for doing these sentinel removals is to avoid
>    bloat in the boot and compiled image (read more in cover letters for
>    [1,2,3,4,5,6]) in future kernel versions. This makes no sense in
>    stable IMO.
> 
> 2. There are lots of moving parts and no "bang for the buck"
>    If you are going to bring one of them, you need to bring all of them.
>    This means brining in the preparation [7], the intermediate
>    [1,2,3,4,5,6] and the final patch [8]. This is not only prone to
>    error, but there is no real reason to do that in stable.
> 
> If I'm missing something, please let me know.

This was needed for the patch following this in the series.  I fixed
that one up by hand and dropped this one now, thanks.

greg k-h

