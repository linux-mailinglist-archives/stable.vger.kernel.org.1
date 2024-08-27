Return-Path: <stable+bounces-71335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D3E96162F
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 19:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EDE1C23797
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187021D1F70;
	Tue, 27 Aug 2024 17:59:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67461D1756;
	Tue, 27 Aug 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781558; cv=none; b=eUJR8iGMoKk2zj6JMUKpd7VRUM6Vye+xN22inCMutQleNNnZ+t6x77tdnJw4AmFp01bjm5/xKY0YhrLH7LyuFP+2GMDP/WkEpNbqV6wy8SY8cVtvJCiG6DFMKe2IFeggcPsHQsN0lFIRKIbem8Fh7hshbZcU4Kf1SgXcp6ZQfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781558; c=relaxed/simple;
	bh=48Q33iSBe30feBJajsdUjyXtMAg7Ws8PgEKICrBPRVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIKmHQausmxAxtN1ZhN9Op7862K4XAbeS2mFpfLaLjgIbCFrC3p126JMNFJhUV7Lh8POvDAsdXiulUyGCu+sAnQECE63b3VIqahxeJRQwN7xSibtMumY0qrT2vqHkHTvAZ0wtCXXKBo+WbZapDfqlCvwN9+m5RBtnxs54kaqMhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id BD9A472C8CC;
	Tue, 27 Aug 2024 20:59:07 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id A6D3E36D0184;
	Tue, 27 Aug 2024 20:59:07 +0300 (MSK)
Date: Tue, 27 Aug 2024 20:59:07 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
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
	David =?utf-8?Q?Pr=C3=A9vot?= <taffit@debian.org>
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <20240827175907.ih2jjmmm6iyf5gsm@altlinux.org>
References: <20240814055408-mutt-send-email-mst@kernel.org>
 <c746a1d2-ba0d-40fe-8983-0bf1f7ce64a7@heusel.eu>
 <PR3PR09MB5411FC965DBCCC26AF850EA5B0872@PR3PR09MB5411.eurprd09.prod.outlook.com>
 <ad4d96b7-d033-4292-86df-91b8d7b427c4@heusel.eu>
 <66bcb6f68172f_adbf529471@willemb.c.googlers.com.notmuch>
 <zkpazbrdirbgp6xgrd54urzjv2b5o3gjfubj6hi673uf35aep3@hrqxcdd7vj5c>
 <66c5f41884850_da1e7294d2@willemb.c.googlers.com.notmuch>
 <ZsyMzW-4ee_U8NoX@eldamar.lan>
 <ZszgliPW3QEodr5G@eldamar.lan>
 <2024082741-crease-mug-f658@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024082741-crease-mug-f658@gregkh>

On Tue, Aug 27, 2024 at 03:16:50PM +0200, Greg KH wrote:
> On Mon, Aug 26, 2024 at 10:07:50PM +0200, Salvatore Bonaccorso wrote:
> > Hi,
> > 
> > On Mon, Aug 26, 2024 at 04:10:21PM +0200, Salvatore Bonaccorso wrote:
> > > Hi,
> > > 
> > > On Wed, Aug 21, 2024 at 10:05:12AM -0400, Willem de Bruijn wrote:
> > > > Vitaly Chikunov wrote:
> > > > > Willem,
> > > > > 
> > > > > On Wed, Aug 14, 2024 at 09:53:58AM GMT, Willem de Bruijn wrote:
> > > > > > Christian Heusel wrote:
> > > > > > > On 24/08/14 10:10AM, Adrian Vladu wrote:
> > > > > > > > Hello,
> > > > > > > > 
> > > > > > > > The 6.6.y branch has the patch already in the stable queue -> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=3e713b73c01fac163a5c8cb0953d1e300407a773, and it should be available in the 6.6.46 upcoming minor.
> > > > > > > > 
> > > > > > > > Thanks, Adrian.
> > > > > > > 
> > > > > > > Yeah it's also queued up for 6.10, which I both missed (sorry for that!).
> > > > > > > If I'm able to properly backport the patch for 6.1 I'll send that one,
> > > > > > > but my hopes are not too high that this will work ..
> > > > > > 
> > > > > > There are two conflicts.
> > > > > > 
> > > > > > The one in include/linux/virtio_net.h is resolved by first backporting
> > > > > > commit fc8b2a6194693 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4
> > > > > > validation")
> > > > > > 
> > > > > > We did not backport that to stable because there was some slight risk
> > > > > > that applications might be affected. This has not surfaced.
> > > > > > 
> > > > > > The conflict in net/ipv4/udp_offload.c is not so easy to address.
> > > > > > There were lots of patches between v6.1 and linus/master, with far
> > > > > > fewer of these betwee v6.1 and linux-stable/linux-6.1.y.
> > > > > 
> > > > > BTW, we successfully cherry-picked 3 suggested[1] commits over v6.1.105 in
> > > > > ALT, and there is no reported problems as of yet.
> > > > > 
> > > > >   89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
> > > > >   fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> > > > >   9840036786d9 ("gso: fix dodgy bit handling for GSO_UDP_L4")
> > > > > 
> > > > > [1] https://lore.kernel.org/all/2024081147-altitude-luminous-19d1@gregkh/
> > > > 
> > > > That's good to hear.
> > > > 
> > > > These are all fine to go to 6.1 stable.
> > > 
> > > FWIW, as we are hit by this issue for Debian bookworm, we have testing
> > > as well from David Prévot <taffit@debian.org>, cf. the report in
> > > https://bugs.debian.org/1079684 .
> > > 
> > > He mentions that the 9840036786d9 ("gso: fix dodgy bit handling for
> > > GSO_UDP_L4") patch does not apply cleanly, looks to be because of
> > > 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packets.")
> > > from 6.2-rc1, which are reverted in the commit.
> > 
> > Just to give an additional confirmation: Applying
> > 
> > 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packets.")

Interestingly, I don't need this commit cherry-picked when applying
above patchset over v6.1.106 (with my git 2.42.2). It applies cleanly
with two "Auto-merging" messages, then 2nd and 3rd hunks are not
applied. It seems that 1fd54773c267 only adds the changes that
following 9840036786d9 removes (in the 2nd and 3rd hunks). And the git
is smart enough to figure that out and just don't apply them when
cherry-picking. That explains why some commits that I say is apply
cleanly some other people cannot apply.

Thanks,

> > 9840036786d9 ("gso: fix dodgy bit handling for GSO_UDP_L4")
> > fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> > 89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
> 
> Ah, that works, thanks!
> 
> greg k-h

