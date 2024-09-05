Return-Path: <stable+bounces-73144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B59E196D09E
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C07B20ED3
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D520D192D73;
	Thu,  5 Sep 2024 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="toQwOw1q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W51oSfxa"
X-Original-To: stable@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15318A94F
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522095; cv=none; b=r1CZZl8Iu6jwVLniZpDTl0qiEgaxDjXM6ckyPryo0jjJXfGwDImxxr8v/ArBGmYt32E0+4QcQ2Hyq+iKOSn0hH0dzfxzS7M1xHpDnZXqNxethTnpH0ehbskhnw9eqK4DYGe0VwOzgWvz6acgIiiyg0W2wYR2VxznzYZTbE89NmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522095; c=relaxed/simple;
	bh=DSihOleXWHhCj+U3QfiiFy16MSjZ7Swmvfn3I9RC/u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrPpKtMzkgyxa1B9GH7eCqBtlj6Zij1IzJJ0PmHetu2+taWIUrPExejoN2oeY/nlZcCaO/lPpyiBcS6EFLrABpcIUx3tsTh5adtzk44NqXO9FAn45mttITVFOziCpVxL8YftitugP+3gyFScllrEWq1NYD7ZD7EA6j2ECONeLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=toQwOw1q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W51oSfxa; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 607431140239;
	Thu,  5 Sep 2024 03:41:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 05 Sep 2024 03:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725522092; x=1725608492; bh=l4edhrmGlS
	zCCJQDhi+VeDY9fCDzM3pWX6emmC4KFfI=; b=toQwOw1qt3pFaE2oJRtXRiJRvS
	gB5NDW9Cw8zTpKpLuWZCPGVCmWgahgzWlrvo7IYIK8aAhr86SAHhfReP+XFg6Ca5
	YgXTz1JgjbkUfLZUouBPz6e7C3kRBiJ1OKmPpdUIg+Vkl+erIH6dyBW2B5YotKBK
	KCgAX+nMcYE3rQDgHvr2vXWALlha0d+ruWb999LXHwjThHZpmugK+CheOwsOGYhW
	1x6wkke2tNRheVV2+PnsIMMWS0SCNAQxeMIbSlLLuZ6RNUV2kq1VeWFa+SSiGhRt
	tn32ldO2eealobP4EQSE3KHm5MBuX/zJTByyyNTqHbVNW3Z0Suje/9DLhkBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725522092; x=1725608492; bh=l4edhrmGlSzCCJQDhi+VeDY9fCDz
	M3pWX6emmC4KFfI=; b=W51oSfxaVhIbiSvZDqp7AE8ze0+QaaUqH/tmMVUPNbs9
	D3W3pp4npLuhanxS8GiD+D8wCYqD6aCaAoea9e31ifEicrL/Pdqp9Ti6MPJ3xU4h
	JdUAo8BLuP9q7MCWNg1JkqroYNBcQv1uwWrxuPXygeA6R2ki3k7xco227nQgTEwn
	4rXmSsh83W7VtmmTA+AAPWpXzLPzrGbiCvPi6h8XoddEi6auoYOj7bnnQilbCsq2
	Ca1IvIQQQaV014jGn51sJcU9df3mpJUgZ6WvphfzIixHMePxT4pJ8HDEfCkg14tw
	HpWfhTp3zUZPMDH+XXHYQbnZWKjuLNLV4AztWpJg9w==
X-ME-Sender: <xms:rGDZZgtyRjk4jrofti574OgHCZB9oBfaJTYu0mr-GY1JUM_EWxlnZw>
    <xme:rGDZZteMjqEzWSU3yWNSHzR_vjC3Avm0Pmxv_eKoiFPn_UfttrQ7WUdvqQjpDEVaE
    Otcb2lOp8mQYQ>
X-ME-Received: <xmr:rGDZZrx5zxvAvgY9fyIsuueSkWtLYGXzOuG5BB8yYNQdA4wcM74xegPD52-NLb6GYE9JHBn_74qHfAXwFN4JNdDWBwBtejKDfkPygQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehkedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeehffejiedutddvhfetlefghfetudeuudffgfelffdvffefhfehudej
    hedvteegffenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomh
    dpkhgvrhhnvghlrdhorhhgpdhmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnh
    gspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrght
    hhhivghurdhtohhrthhuhigruhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtrg
    gslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhtohhrthhuhigr
    uhigsehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepfihilhhlvghmsgesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rGDZZjMp6cTWF3IrSIyR9dPM-S7D6vAeMlZrYk_V3jAb7fyzhQYG1A>
    <xmx:rGDZZg8hksNXXo3dMJ0px3tm6bnRdvvkt52mcPquc2JGAjydqKonpg>
    <xmx:rGDZZrUppouKNF2v9reXDp1ijRh2nAJLPGDfT3KLsFIWd-cVucQA3A>
    <xmx:rGDZZpfxsZqroyrdaDmFVeanoI2iKKq-erYwAn-IXgeT2oWvJgB_SQ>
    <xmx:rGDZZh0Vj_fremnaux92nlpNNycLE5IFjHo8GIhZAgkF6eNNc3xzYgm9>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 03:41:31 -0400 (EDT)
Date: Thu, 5 Sep 2024 09:41:29 +0200
From: Greg KH <greg@kroah.com>
To: mathieu.tortuyaux@gmail.com
Cc: stable@vger.kernel.org, Mathieu Tortuyaux <mtortuyaux@microsoft.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] net: drop bad gso csum_start and offset in virtio_net_hdr
Message-ID: <2024090519-battalion-quadrant-fd0a@gregkh>
References: <20240903084307.20562-2-mathieu.tortuyaux@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903084307.20562-2-mathieu.tortuyaux@gmail.com>

On Tue, Sep 03, 2024 at 10:42:26AM +0200, mathieu.tortuyaux@gmail.com wrote:
> From: Mathieu Tortuyaux <mtortuyaux@microsoft.com>
> 
> [ Upstream commit 89add40066f9ed9abe5f7f886fe5789ff7e0c50e ]
> 
> Tighten csum_start and csum_offset checks in virtio_net_hdr_to_skb
> for GSO packets.
> 
> The function already checks that a checksum requested with
> VIRTIO_NET_HDR_F_NEEDS_CSUM is in skb linear. But for GSO packets
> this might not hold for segs after segmentation.
> 
> Syzkaller demonstrated to reach this warning in skb_checksum_help
> 
> 	offset = skb_checksum_start_offset(skb);
> 	ret = -EINVAL;
> 	if (WARN_ON_ONCE(offset >= skb_headlen(skb)))
> 
> By injecting a TSO packet:
> 
> WARNING: CPU: 1 PID: 3539 at net/core/dev.c:3284 skb_checksum_help+0x3d0/0x5b0
>  ip_do_fragment+0x209/0x1b20 net/ipv4/ip_output.c:774
>  ip_finish_output_gso net/ipv4/ip_output.c:279 [inline]
>  __ip_finish_output+0x2bd/0x4b0 net/ipv4/ip_output.c:301
>  iptunnel_xmit+0x50c/0x930 net/ipv4/ip_tunnel_core.c:82
>  ip_tunnel_xmit+0x2296/0x2c70 net/ipv4/ip_tunnel.c:813
>  __gre_xmit net/ipv4/ip_gre.c:469 [inline]
>  ipgre_xmit+0x759/0xa60 net/ipv4/ip_gre.c:661
>  __netdev_start_xmit include/linux/netdevice.h:4850 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4864 [inline]
>  xmit_one net/core/dev.c:3595 [inline]
>  dev_hard_start_xmit+0x261/0x8c0 net/core/dev.c:3611
>  __dev_queue_xmit+0x1b97/0x3c90 net/core/dev.c:4261
>  packet_snd net/packet/af_packet.c:3073 [inline]
> 
> The geometry of the bad input packet at tcp_gso_segment:
> 
> [   52.003050][ T8403] skb len=12202 headroom=244 headlen=12093 tailroom=0
> [   52.003050][ T8403] mac=(168,24) mac_len=24 net=(192,52) trans=244
> [   52.003050][ T8403] shinfo(txflags=0 nr_frags=1 gso(size=1552 type=3 segs=0))
> [   52.003050][ T8403] csum(0x60000c7 start=199 offset=1536
> ip_summed=3 complete_sw=0 valid=0 level=0)
> 
> Mitigate with stricter input validation.
> 
> csum_offset: for GSO packets, deduce the correct value from gso_type.
> This is already done for USO. Extend it to TSO. Let UFO be:
> udp[46]_ufo_fragment ignores these fields and always computes the
> checksum in software.
> 
> csum_start: finding the real offset requires parsing to the transport
> header. Do not add a parser, use existing segmentation parsing. Thanks
> to SKB_GSO_DODGY, that also catches bad packets that are hw offloaded.
> Again test both TSO and USO. Do not test UFO for the above reason, and
> do not test UDP tunnel offload.
> 
> GSO packet are almost always CHECKSUM_PARTIAL. USO packets may be
> CHECKSUM_NONE since commit 10154db ("udp: Allow GSO transmit
> from devices with no checksum offload"), but then still these fields
> are initialized correctly in udp4_hwcsum/udp6_hwcsum_outgoing. So no
> need to test for ip_summed == CHECKSUM_PARTIAL first.
> 
> This revises an existing fix mentioned in the Fixes tag, which broke
> small packets with GSO offload, as detected by kselftests.
> 
> Link: https://syzkaller.appspot.com/bug?extid=e1db31216c789f552871
> Link: https://lore.kernel.org/netdev/20240723223109.2196886-1-kuba@kernel.org
> Fixes: e269d79 ("net: missing check virtio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Link: https://patch.msgid.link/20240729201108.1615114-1-willemdebruijn.kernel@gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mathieu Tortuyaux <mtortuyaux@microsoft.com>
> ---
> Hi,
> 
> This patch fixes network failures on OpenStack VMs running with Kernel
> 5.15.165.
> 
> In 5.15.165, the commit "net: missing check virtio" is breaking networks
> on VMs that uses virtio in some conditions.
> 
> I slightly adapted the patch to have it fitting this branch (5.15.y).
> 
> Once patched and compiled it has been successfully tested on Flatcar CI
> with Kernel 5.15.165.
> 
> NOTE: This patch has already been backported on other stable branches
> (like 6.6.y) 

Now queued up, thanks.

gre gk-h

