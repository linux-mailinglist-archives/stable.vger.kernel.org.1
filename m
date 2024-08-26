Return-Path: <stable+bounces-70280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCCA95FA64
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 22:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CDCB22999
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 20:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487E199E9E;
	Mon, 26 Aug 2024 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="i2NTX8rS"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4F5824BB;
	Mon, 26 Aug 2024 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702896; cv=none; b=j2YXxmg3GnLBv1zfsWBPAYh9SCmKqi9mHYO+tr4vtEO6Tj8bNie5VNIX4KRFRBTQm/aRc7NZAR6JlltDx5m27f2lbrlUnKlPw8xLN1IBX0sH4zvXJUC3Wj3BT0ye501hoMAfNHYZh3fIrL42dEOVWLe4KLCQxaRl3qXSEyVBtA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702896; c=relaxed/simple;
	bh=fUos6GFFOCBysbGE7iuG8e2MDbRQwYqBMZokGY4eDcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffGSQbkcNQ2HRjHMpLUfsq3JkJRx4KI9AYj0QoawH33r3bZnylBgikp/M/L1TuWYI7UQ0K5l7OgfppVvnoUxSpcgDoHkfZ/117fl96BBcCCF8k9BinK/soHnaeyw56Qz7ADMrBccpKWUBTxIpNCfFKkX3jbiV1CkA5QB254hYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=i2NTX8rS; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=yQZq+wWJI34kvGZwqwBDuoRZgkh9whbk7qwYwReZVYg=; b=i2NTX8rS24h5zJqmdFwWhpt9J9
	eDoR1HNp9qZGT60SPFbmRQhjoM7jb1ONYdIrypUbz/BRp2c66MkR8Jq8sqLnSbSy7VpZ6zv7cKu/2
	UkxyT1wtLFNJoGUewIeZSApd5m6b9ANYDPWKGnon7vZ9XPCbonkte2MrXFGKqXcfANjn/bZoFINoS
	1rDAHSF66kHYz/BBFUOi67nxWInSzvSRJzXcVWgvcU/WyuyhNW9vaFrPoTshfCpRP9sS0X/HfXrSi
	IxSfnbj7xNGQlCqhrwRFbPZOB52IWeq6b+903O0XJJ6XO4V/QO2p6u4B9JG7O5MeSze2rOFCQjLKd
	5L/CHyiQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1sig0H-00BKGx-Qr; Mon, 26 Aug 2024 20:07:53 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id AFA47BE2EE7; Mon, 26 Aug 2024 22:07:50 +0200 (CEST)
Date: Mon, 26 Aug 2024 22:07:50 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Vitaly Chikunov <vt@altlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	Adrian Vladu <avladu@cloudbasesolutions.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <ZszgliPW3QEodr5G@eldamar.lan>
References: <60bc20c5-7512-44f7-88cb-abc540437ae1@heusel.eu>
 <0d897b58-f4b8-4814-b3f9-5dce0540c81d@heusel.eu>
 <20240814055408-mutt-send-email-mst@kernel.org>
 <c746a1d2-ba0d-40fe-8983-0bf1f7ce64a7@heusel.eu>
 <PR3PR09MB5411FC965DBCCC26AF850EA5B0872@PR3PR09MB5411.eurprd09.prod.outlook.com>
 <ad4d96b7-d033-4292-86df-91b8d7b427c4@heusel.eu>
 <66bcb6f68172f_adbf529471@willemb.c.googlers.com.notmuch>
 <zkpazbrdirbgp6xgrd54urzjv2b5o3gjfubj6hi673uf35aep3@hrqxcdd7vj5c>
 <66c5f41884850_da1e7294d2@willemb.c.googlers.com.notmuch>
 <ZsyMzW-4ee_U8NoX@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsyMzW-4ee_U8NoX@eldamar.lan>
X-Debian-User: carnil

Hi,

On Mon, Aug 26, 2024 at 04:10:21PM +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Wed, Aug 21, 2024 at 10:05:12AM -0400, Willem de Bruijn wrote:
> > Vitaly Chikunov wrote:
> > > Willem,
> > > 
> > > On Wed, Aug 14, 2024 at 09:53:58AM GMT, Willem de Bruijn wrote:
> > > > Christian Heusel wrote:
> > > > > On 24/08/14 10:10AM, Adrian Vladu wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > The 6.6.y branch has the patch already in the stable queue -> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=3e713b73c01fac163a5c8cb0953d1e300407a773, and it should be available in the 6.6.46 upcoming minor.
> > > > > > 
> > > > > > Thanks, Adrian.
> > > > > 
> > > > > Yeah it's also queued up for 6.10, which I both missed (sorry for that!).
> > > > > If I'm able to properly backport the patch for 6.1 I'll send that one,
> > > > > but my hopes are not too high that this will work ..
> > > > 
> > > > There are two conflicts.
> > > > 
> > > > The one in include/linux/virtio_net.h is resolved by first backporting
> > > > commit fc8b2a6194693 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4
> > > > validation")
> > > > 
> > > > We did not backport that to stable because there was some slight risk
> > > > that applications might be affected. This has not surfaced.
> > > > 
> > > > The conflict in net/ipv4/udp_offload.c is not so easy to address.
> > > > There were lots of patches between v6.1 and linus/master, with far
> > > > fewer of these betwee v6.1 and linux-stable/linux-6.1.y.
> > > 
> > > BTW, we successfully cherry-picked 3 suggested[1] commits over v6.1.105 in
> > > ALT, and there is no reported problems as of yet.
> > > 
> > >   89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
> > >   fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> > >   9840036786d9 ("gso: fix dodgy bit handling for GSO_UDP_L4")
> > > 
> > > [1] https://lore.kernel.org/all/2024081147-altitude-luminous-19d1@gregkh/
> > 
> > That's good to hear.
> > 
> > These are all fine to go to 6.1 stable.
> 
> FWIW, as we are hit by this issue for Debian bookworm, we have testing
> as well from David Prévot <taffit@debian.org>, cf. the report in
> https://bugs.debian.org/1079684 .
> 
> He mentions that the 9840036786d9 ("gso: fix dodgy bit handling for
> GSO_UDP_L4") patch does not apply cleanly, looks to be because of
> 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packets.")
> from 6.2-rc1, which are reverted in the commit.

Just to give an additional confirmation: Applying

1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packets.")
9840036786d9 ("gso: fix dodgy bit handling for GSO_UDP_L4")
fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")

addresses the issue from

https://bugs.debian.org/1079684

matching

https://bugzilla.kernel.org/show_bug.cgi?id=219129

I tested it with the iperf3 based reproducers.

Tested-by: Salvatore Bonaccorso <carnil@debian.org>

Regards,
Salvatore

