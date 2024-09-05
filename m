Return-Path: <stable+bounces-73154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B490096D182
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 10:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE622848AE
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A64D197A83;
	Thu,  5 Sep 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q+0tzwoO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF356195383
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523713; cv=none; b=nGyB7/HdZIFbwAlo1uRi7D91XL7Y4SJVyvXJEdatQw1qOl2HrJhEgk4pjCSY46AeBS9lQi7QLqVX9Rhga3w2hPtBYaXQIWtqnHlh/BdtHvT4OcFyKkfLc1exll8f+NMiqWH70ACl21jGA0dVTxx4DCFPBA2/OBYViQu//owYOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523713; c=relaxed/simple;
	bh=To/aDxeYztB39vkMxp8jPtU18jsGRR1D1kv/dHNzZCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgqQEYeN+d8gbGbEFoNegNtuU6IIYswTxGKkeQYWpa9DWEj7SJHbl3Pp3Onyb9K09T7ikU7DkDy+jXIJ48e4FaYWiZW54HSXekt00BhObu9vCkTpZmP/eRp3EAXwPPfZsPPrBrH3CLxTI2uAZCjYujax7dODtvXZI6yIACxC7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q+0tzwoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF166C4CEC4;
	Thu,  5 Sep 2024 08:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725523713;
	bh=To/aDxeYztB39vkMxp8jPtU18jsGRR1D1kv/dHNzZCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+0tzwoONOHf8lGd4nA8PwwBjvDcFxba3eGu32cQVUasH+fKeZoxNH0cI+U8BhsHd
	 IMVBdHulygYiD2V9n8KcTmInHhYuiVRxbRL88uUDgmDHG19dn+1x2SWANToqVinfvK
	 kewJ7j7vmGJsMbABSzqUyT7QPBJllCkqwVBNLLFo=
Date: Thu, 5 Sep 2024 10:08:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: mathieu.tortuyaux@gmail.com
Cc: stable@vger.kernel.org, Mathieu Tortuyaux <mtortuyaux@microsoft.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] net: drop bad gso csum_start and offset in virtio_net_hdr
Message-ID: <2024090532-earthworm-sincere-005e@gregkh>
References: <20240903084307.20562-2-mathieu.tortuyaux@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
> 
> Thanks,
> 
> Mathieu - @tormath1

How did you test this, it breaks the build for me:

net/ipv4/tcp_offload.c: In function ‘tcp_gso_segment’:
net/ipv4/tcp_offload.c:74:5: error: this ‘if’ clause does not guard... [-Werror=misleading-indentation]
   74 |     if (unlikely(skb_checksum_start(skb) != skb_transport_header(skb)))
      |     ^~
net/ipv4/tcp_offload.c:77:9: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the ‘if’
   77 |         if (!pskb_may_pull(skb, thlen))
      |         ^~
net/ipv4/udp_offload.c: In function ‘__udp_gso_segment’:
net/ipv4/udp_offload.c:282:5: error: this ‘if’ clause does not guard... [-Werror=misleading-indentation]
  282 |     if (unlikely(skb_checksum_start(gso_skb) !=
      |     ^~
net/ipv4/udp_offload.c:286:9: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the ‘if’
  286 |         skb_pull(gso_skb, sizeof(*uh));
      |         ^~~~~~~~
cc1: all warnings being treated as errors

Now dropped, please test your patches before sending them as it throws a big
wrench in our process when things break...

thanks,

greg k-h

