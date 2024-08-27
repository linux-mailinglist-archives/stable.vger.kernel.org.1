Return-Path: <stable+bounces-70360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3A960B9C
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B9C1F2237D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8381BAED5;
	Tue, 27 Aug 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hfo0hLUJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787F919CCE6;
	Tue, 27 Aug 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764619; cv=none; b=CJIMIZYYFzLlAvqDONfk9R3Aqg0O1CpaTSdX8VFfqd1I9ueM7mSu/zHFCRiLEhUmPaYUlf0XJBDKbu38q35swlOjJke5/tkPjrije+qyHBwpHtqk+HhIvM1EwZyoi+cyhXHIaT9f8d43TPgQn9ngZzX298SvJafkEbgfrTDVY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764619; c=relaxed/simple;
	bh=aY1aAhJeV+p1s0ZXDxOzamYB2/VzqxrNQdK/2AxCnA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUOejLlHXibgr/XI6CxIY+DXBoOQsBHqRmSYRYYYJEUQnl8TJkwKwEqSGsl+rXYVkBFo14qh2uhR1hXSX9Uhv1Ez0XkvJNdOe5zeBWUlR42mgjFqOUTMm4QEBGCunAgaiCZoXy+9gzVyXyt0tdSLHPbUHau9oPbZX4U+TnPitAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hfo0hLUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DE7C61042;
	Tue, 27 Aug 2024 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724764619;
	bh=aY1aAhJeV+p1s0ZXDxOzamYB2/VzqxrNQdK/2AxCnA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hfo0hLUJm2TVm8Wk1IVsJXYXYhbdDIPa3D5IUb8YRE+4yRY6nWHvBsQdx1FNqxBhd
	 yTwHBD+B02gEbU5ItUdPJyXWvA/9hhlNNwqSOC/+rCt/D0Jbzmd1HwkAOn/PMdqqQD
	 c5SNnz7du7gjz8iFT4bwaXjIVK8f8VRyodLHSvuQ=
Date: Tue, 27 Aug 2024 15:16:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Vitaly Chikunov <vt@altlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	Adrian Vladu <avladu@cloudbasesolutions.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
	"arefev@swemel.ru" <arefev@swemel.ru>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"willemb@google.com" <willemb@google.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	David =?iso-8859-1?Q?Pr=E9vot?= <taffit@debian.org>
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <2024082741-crease-mug-f658@gregkh>
References: <0d897b58-f4b8-4814-b3f9-5dce0540c81d@heusel.eu>
 <20240814055408-mutt-send-email-mst@kernel.org>
 <c746a1d2-ba0d-40fe-8983-0bf1f7ce64a7@heusel.eu>
 <PR3PR09MB5411FC965DBCCC26AF850EA5B0872@PR3PR09MB5411.eurprd09.prod.outlook.com>
 <ad4d96b7-d033-4292-86df-91b8d7b427c4@heusel.eu>
 <66bcb6f68172f_adbf529471@willemb.c.googlers.com.notmuch>
 <zkpazbrdirbgp6xgrd54urzjv2b5o3gjfubj6hi673uf35aep3@hrqxcdd7vj5c>
 <66c5f41884850_da1e7294d2@willemb.c.googlers.com.notmuch>
 <ZsyMzW-4ee_U8NoX@eldamar.lan>
 <ZszgliPW3QEodr5G@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZszgliPW3QEodr5G@eldamar.lan>

On Mon, Aug 26, 2024 at 10:07:50PM +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Mon, Aug 26, 2024 at 04:10:21PM +0200, Salvatore Bonaccorso wrote:
> > Hi,
> > 
> > On Wed, Aug 21, 2024 at 10:05:12AM -0400, Willem de Bruijn wrote:
> > > Vitaly Chikunov wrote:
> > > > Willem,
> > > > 
> > > > On Wed, Aug 14, 2024 at 09:53:58AM GMT, Willem de Bruijn wrote:
> > > > > Christian Heusel wrote:
> > > > > > On 24/08/14 10:10AM, Adrian Vladu wrote:
> > > > > > > Hello,
> > > > > > > 
> > > > > > > The 6.6.y branch has the patch already in the stable queue -> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=3e713b73c01fac163a5c8cb0953d1e300407a773, and it should be available in the 6.6.46 upcoming minor.
> > > > > > > 
> > > > > > > Thanks, Adrian.
> > > > > > 
> > > > > > Yeah it's also queued up for 6.10, which I both missed (sorry for that!).
> > > > > > If I'm able to properly backport the patch for 6.1 I'll send that one,
> > > > > > but my hopes are not too high that this will work ..
> > > > > 
> > > > > There are two conflicts.
> > > > > 
> > > > > The one in include/linux/virtio_net.h is resolved by first backporting
> > > > > commit fc8b2a6194693 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4
> > > > > validation")
> > > > > 
> > > > > We did not backport that to stable because there was some slight risk
> > > > > that applications might be affected. This has not surfaced.
> > > > > 
> > > > > The conflict in net/ipv4/udp_offload.c is not so easy to address.
> > > > > There were lots of patches between v6.1 and linus/master, with far
> > > > > fewer of these betwee v6.1 and linux-stable/linux-6.1.y.
> > > > 
> > > > BTW, we successfully cherry-picked 3 suggested[1] commits over v6.1.105 in
> > > > ALT, and there is no reported problems as of yet.
> > > > 
> > > >   89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
> > > >   fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> > > >   9840036786d9 ("gso: fix dodgy bit handling for GSO_UDP_L4")
> > > > 
> > > > [1] https://lore.kernel.org/all/2024081147-altitude-luminous-19d1@gregkh/
> > > 
> > > That's good to hear.
> > > 
> > > These are all fine to go to 6.1 stable.
> > 
> > FWIW, as we are hit by this issue for Debian bookworm, we have testing
> > as well from David Prévot <taffit@debian.org>, cf. the report in
> > https://bugs.debian.org/1079684 .
> > 
> > He mentions that the 9840036786d9 ("gso: fix dodgy bit handling for
> > GSO_UDP_L4") patch does not apply cleanly, looks to be because of
> > 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packets.")
> > from 6.2-rc1, which are reverted in the commit.
> 
> Just to give an additional confirmation: Applying
> 
> 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packets.")
> 9840036786d9 ("gso: fix dodgy bit handling for GSO_UDP_L4")
> fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> 89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")

Ah, that works, thanks!

greg k-h

