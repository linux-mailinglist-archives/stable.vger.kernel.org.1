Return-Path: <stable+bounces-73923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE04970831
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 16:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4E4B21190
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72C170A39;
	Sun,  8 Sep 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="gWFktRQ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qxcW5IGO"
X-Original-To: stable@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D60EACD;
	Sun,  8 Sep 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725806426; cv=none; b=kpcBIcv0hTc2a6+bEOh5r0MBZaHmKoYLS6qe+9+aOUkt2dnnTiV5vYT1RVLpLq+wV2tLHlUOtcj1ngaTkirONcan23fe1RFx2Kqz6vc1wsSfQpNWzSBSqX7LR4H2BYZOCuCwuxFJNVSZEUsrraQp4S9nvbqDMnqLT4KoGG6loG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725806426; c=relaxed/simple;
	bh=+2gLntmAvGbRQUtBkZxq3O3ALhrtJAusPBITo6LWyNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA3cMe0o7pYfVuPnO/UQIdgJUxl6ZoKMycfoMQezwHEhya9GcCTrLIAtSN3DZqWmTTuAg118N5/KdCNoSJvjJ9YvdEpBPgmRoJBgnyuHjhA4BT6vbN7YZ2h+KsH3xL2agkdhWagMj0Jr0ZvRAXTcxFjWsqwhkpXoFNRVWhjNbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=gWFktRQ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qxcW5IGO; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F05711400B7;
	Sun,  8 Sep 2024 10:40:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 08 Sep 2024 10:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725806423;
	 x=1725892823; bh=WZED2l7BcUUjeyjMCdr468O2Tgq6NDEaXYJLGb28iW0=; b=
	gWFktRQ3sW92YJ6XdgaDWc3WKE5pwk7fOZ9Zfldn/cZQ2ckSRahzxwAVgt6krGq2
	adHYgDNgkHoc1zlRV/UBG7giNluABAlhDC/XOhe0UNZnzoqBU5O2YVFd/cgNc/0C
	iMrEtwuJ04LTN1QqDafqLi8ec4Ib++m+sXeUB2kxmIl05LnO8VjGg/ouyp06VkFM
	XcjeJLCN+ApgDWJuBYIWfNBd1eDMXA0BdxUZoKqLGW+zO7NTm81swWVyP2fFY6N+
	zp+OR5Z9d4xs+iwoT6AhZ8EKF/txIYaJeQQQTPsiD8g8ClBGQrwXBedjcSOqoNkC
	Txc5ipXJPFc0xc1XHs1mGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725806423; x=
	1725892823; bh=WZED2l7BcUUjeyjMCdr468O2Tgq6NDEaXYJLGb28iW0=; b=q
	xcW5IGOZZttpNoBtcFNw+iSvOi8TEv404xAWnHaM60wGMBdYDqRV5PAwvbR0Kk15
	EpVvNsu1RkMNNSF/K8UPjvLr8XCv6ArQcrCR5iydQzpSZSkCqBDwgb8c5TEwm9sQ
	3SJri/d3n0HrjrODWSt6Uvps/7ZpTvM1xzJPgbqIaMNpccqAbNS3LwCN0qN0U+t3
	Z8lpBa4PitpSduDi7jGhfBCD7CCvc7L86gqPbOHWNi4OwlcwXwOfm7GM47imvOvg
	fw5Hr7qIWQQWcoFDch/ROCVxT2MtVtWNHoA/WEPpYhuMxPE7aChQLwBoJlipqTw2
	V0YgLSR/+N0VPyiztwXfg==
X-ME-Sender: <xms:V7fdZr4EODEqhsoEysORDI2DoybjTQoAETFLHWQok8UU7wuskdgt6w>
    <xme:V7fdZg7VOrTtXcINOS6as1cTqRF-7Wlr9H0Lrn-duz1kXBhZNh_MND5-vyPFra9lf
    tucA920cBG97w>
X-ME-Received: <xmr:V7fdZiejvxxS2H7fQWwSXowT3h98HCi4lbsFEZBtKYBZfUBMDKAr8uQXVXs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeihedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddu
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeeuleeuteeuveejheeluedvhfehgeeileefveegkeduffffteetgfdu
    veegheegveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhmshhgihgurdhlihhnkh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgv
    gheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehsphgrshhsfiholhhfseifvggsrdguvgdprhgtphhtthhopehs
    thgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvg
    dqtghomhhmihhtshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvhgr
    lhhosegtohguvggruhhrohhrrgdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvg
    hmlhhofhhtrdhnvght
X-ME-Proxy: <xmx:V7fdZsLtBOkkJp7P9xzApSyG0-usnbcFTN7sNGSfq0jbJ93tlUQlcg>
    <xmx:V7fdZvJL0UuD-_hrRluI8Vi1WthUmhSr8AbUVyVPYsypXISsFF2aog>
    <xmx:V7fdZlxeV7J_cCfuS9dkTlorP8ls8n1i_AD0YNWjEmT1lF72w9OD_w>
    <xmx:V7fdZrJmZ6X_QWZmNXKWs4BNuTfsn1LcMoG28OI5RpjRnlKzz7gdmg>
    <xmx:V7fdZsC-ypzZQprqlEgVPOgEW_L6VF0g2uW6goKjNadQeGjVPSZ9v3UM>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Sep 2024 10:40:22 -0400 (EDT)
Date: Sun, 8 Sep 2024 16:40:21 +0200
From: Greg KH <greg@kroah.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Kalle Valo <kvalo@codeaurora.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: Patch "wifi: mt76: mt7921: fix NULL pointer access in
 mt7921_ipv6_addr_change" has been added to the 6.6-stable tree
Message-ID: <2024090859-wooing-crock-6827@gregkh>
References: <20240908133703.1652036-1-sashal@kernel.org>
 <38a42fddfd5b6cde1115b600a40ad4b158b430ea.camel@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38a42fddfd5b6cde1115b600a40ad4b158b430ea.camel@web.de>

On Sun, Sep 08, 2024 at 04:27:49PM +0200, Bert Karwatzki wrote:
> Am Sonntag, dem 08.09.2024 um 09:37 -0400 schrieb Sasha Levin:
> > This is a note to let you know that I've just added the patch titled
> >
> >     wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change
> >
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      wifi-mt76-mt7921-fix-null-pointer-access-in-mt7921_i.patch
> > and it can be found in the queue-6.6 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> >
> >
> >
> > commit 857d7854c40324bfc70a6d32c9eb0792bc7c0b56
> > Author: Bert Karwatzki <spasswolf@web.de>
> > Date:   Mon Aug 12 12:45:41 2024 +0200
> >
> >     wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change
> >
> >     [ Upstream commit 479ffee68d59c599f8aed8fa2dcc8e13e7bd13c3 ]
> >
> >     When disabling wifi mt7921_ipv6_addr_change() is called as a notifier.
> >     At this point mvif->phy is already NULL so we cannot use it here.
> >
> >     Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> >     Signed-off-by: Felix Fietkau <nbd@nbd.name>
> >     Signed-off-by: Kalle Valo <kvalo@kernel.org>
> >     Link: https://patch.msgid.link/20240812104542.80760-1-spasswolf@web.de
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > index 6a5c2cae087d..6dec54431312 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > @@ -1095,7 +1095,7 @@ static void mt7921_ipv6_addr_change(struct ieee80211_hw *hw,
> >  				    struct inet6_dev *idev)
> >  {
> >  	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
> > -	struct mt792x_dev *dev = mvif->phy->dev;
> > +	struct mt792x_dev *dev = mt792x_hw_dev(hw);
> >  	struct inet6_ifaddr *ifa;
> >  	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
> >  	struct sk_buff *skb;
> 
> The patch is only fixes a NULL pointer if the tree also contains this commit: 
> 
> commit 574e609c4e6a0843a9ed53de79e00da8fb3e7437
> Author: Felix Fietkau <nbd@nbd.name>
> Date:   Thu Jul 4 15:09:47 2024 +0200
> 
>     wifi: mac80211: clear vif drv_priv after remove_interface when stopping
> 
>     Avoid reusing stale driver data when an interface is brought down and up
>     again. In order to avoid having to duplicate the memset in every single
>     driver, do it here.
> 
>     Signed-off-by: Felix Fietkau <nbd@nbd.name>
>     Link: https://patch.msgid.link/20240704130947.48609-1-nbd@nbd.name
>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> 
> In trees which do not contain this the patch is not necessary.

Ah, perhaps a Fixes: tag should have been used here then?

Anyway, I'll go drop this commit from the 2 trees now, thanks.

greg k-h

