Return-Path: <stable+bounces-69800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA26D959CC1
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 15:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DBA286C90
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 13:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D26196D9E;
	Wed, 21 Aug 2024 13:03:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED1B18B49E;
	Wed, 21 Aug 2024 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245437; cv=none; b=bXXe9yt6yAFxD9W6xOj646rbPahzWbtbJ0TGww1anGSzm9qhx1ar+CQLhl7bzQXbekpjxz7jxlXHummDD+tBD3MbPYKhE3TLboN4epUVl9BH0qSXHdh8df5Qe/LV9q08yKsPHlgBZ1VQO8ZMzSNhjFYyofn34nMhE/uK533tI/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245437; c=relaxed/simple;
	bh=EsZd7zphgRfp+Pj+5bpQt0D8iW92EupN1ZQaK+j/SKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxTzBB4ih7Zq2vbQs9qg7O6XdDaYJFagwGJccbiK5cTU580Vh9Yzl6c79apRHcCYzdUaP23udEwr6KO7yiPrYXuLaUJhz9qg1r0OdVpghTFHrukwfOAXzjdOT5/m4Nisu1wKVaIt4kcs2+pdjidzsaRr8iEE+1VaqyzmP0p8RW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id BF7B572C8CC;
	Wed, 21 Aug 2024 15:57:58 +0300 (MSK)
Received: from pony.office.basealt.ru (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id B626636D0178;
	Wed, 21 Aug 2024 15:57:58 +0300 (MSK)
Received: by pony.office.basealt.ru (Postfix, from userid 500)
	id 95406360C1DE; Wed, 21 Aug 2024 15:57:58 +0300 (MSK)
Date: Wed, 21 Aug 2024 15:57:58 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Christian Heusel <christian@heusel.eu>, 
	Adrian Vladu <avladu@cloudbasesolutions.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, 
	"arefev@swemel.ru" <arefev@swemel.ru>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"willemb@google.com" <willemb@google.com>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <zkpazbrdirbgp6xgrd54urzjv2b5o3gjfubj6hi673uf35aep3@hrqxcdd7vj5c>
References: <2024080703-unafraid-chastise-acf0@gregkh>
 <146d2c9f-f2c3-4891-ac48-a3e50c863530@heusel.eu>
 <2024080857-contusion-womb-aae1@gregkh>
 <60bc20c5-7512-44f7-88cb-abc540437ae1@heusel.eu>
 <0d897b58-f4b8-4814-b3f9-5dce0540c81d@heusel.eu>
 <20240814055408-mutt-send-email-mst@kernel.org>
 <c746a1d2-ba0d-40fe-8983-0bf1f7ce64a7@heusel.eu>
 <PR3PR09MB5411FC965DBCCC26AF850EA5B0872@PR3PR09MB5411.eurprd09.prod.outlook.com>
 <ad4d96b7-d033-4292-86df-91b8d7b427c4@heusel.eu>
 <66bcb6f68172f_adbf529471@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66bcb6f68172f_adbf529471@willemb.c.googlers.com.notmuch>

Willem,

On Wed, Aug 14, 2024 at 09:53:58AM GMT, Willem de Bruijn wrote:
> Christian Heusel wrote:
> > On 24/08/14 10:10AM, Adrian Vladu wrote:
> > > Hello,
> > > 
> > > The 6.6.y branch has the patch already in the stable queue -> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=3e713b73c01fac163a5c8cb0953d1e300407a773, and it should be available in the 6.6.46 upcoming minor.
> > > 
> > > Thanks, Adrian.
> > 
> > Yeah it's also queued up for 6.10, which I both missed (sorry for that!).
> > If I'm able to properly backport the patch for 6.1 I'll send that one,
> > but my hopes are not too high that this will work ..
> 
> There are two conflicts.
> 
> The one in include/linux/virtio_net.h is resolved by first backporting
> commit fc8b2a6194693 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4
> validation")
> 
> We did not backport that to stable because there was some slight risk
> that applications might be affected. This has not surfaced.
> 
> The conflict in net/ipv4/udp_offload.c is not so easy to address.
> There were lots of patches between v6.1 and linus/master, with far
> fewer of these betwee v6.1 and linux-stable/linux-6.1.y.

BTW, we successfully cherry-picked 3 suggested[1] commits over v6.1.105 in
ALT, and there is no reported problems as of yet.

  89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
  fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
  9840036786d9 ("gso: fix dodgy bit handling for GSO_UDP_L4")

[1] https://lore.kernel.org/all/2024081147-altitude-luminous-19d1@gregkh/

Thanks,

> 
> We can also avoid the backport of fc8b2a6194693 and construct a custom
> version for this older kernel. All this is needed in virtio_net.h is
> 
> +               case SKB_GSO_UDP_L4:
> +               case SKB_GSO_TCPV4:
> +               case SKB_GSO_TCPV6:
> +                       if (skb->csum_offset != offsetof(struct tcphdr, check))
> 
> and in __udp_gso_segment
> 
> +       if (unlikely(skb_checksum_start(gso_skb) !=
> +                    skb_transport_header(gso_skb)))
> +               return ERR_PTR(-EINVAL);
> +
> 
> The Fixes tag points to a commit introduced in 6.1. 6.6 is queued up,
> so this is the only release for which we have to create a custom
> patch, right?
> 
> Let me know if you will send this, or I should?
> 

