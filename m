Return-Path: <stable+bounces-73936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935F3970A20
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 23:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AB81C20B67
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3C91741C8;
	Sun,  8 Sep 2024 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="W7DTnoir";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qygbMk/F"
X-Original-To: stable@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893CB191;
	Sun,  8 Sep 2024 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725830300; cv=none; b=jHQskt6DNqS4tXQlgm05XS/nXIizv6aFWV5g1ucF39e0wenz0tTRsBRfzCE7zdSuoNpc/dXv04SkawBsEcO8ktx1DnRyNQqnIndkN9zwTGu96so3b4r7x03Yk3BZh2ZOA9KsZAGqXTA9FmDurLRvrgA6NTCmzicFpt5YhPCbjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725830300; c=relaxed/simple;
	bh=6drDjKtcUf8auZfoPT6F3SAPmQSDih1pe3DIjaNPLdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLQu4hO2a7g4b/Y5XnaeyQMutaDMZ5rjdoCKA/+nnGDfmuwR6NIoJNckqbr9yXu8oOXS3iwZhgvKQBj6A+8HAEIXCpsI71+DOnbbOE88qo55/Ajg/CtvdvH2v4fcmD9NuHK8UL2Kw9H/ti7BXxKi3lH6L2S3/EDBfqqiCPjBiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=W7DTnoir; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qygbMk/F; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 906FA1380053;
	Sun,  8 Sep 2024 17:18:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 08 Sep 2024 17:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725830297;
	 x=1725916697; bh=J/m2qCsXtYaLAcpnBF5yeDYetdgbwY6EnTPusQDW6gA=; b=
	W7DTnoirTD9r89r4DYxcn689FJuHkwSABeKIIoH3TNGBosO6+3QMOX0H7p0j8Qdj
	jpReJxq6aS4X+D/809B5jEOl7APjIIITpftrsBhoowgd2uipjrXjjACiYZvqTG2S
	gYybTyL05lGLAv+xSKDZvHgqfSbK2kH8OycGuJ5RN/D52XfE9RLYfA4u09SnPRmF
	/9P5bkSyebaHqPt6MbBNVpUPA0FUsOevVn200ZyfiBdUCisabX6YME0tbYpFolmJ
	42H+kvjKrCHe7s4AZ/61NE2TOx6eaBRK3C5HLWbJIvh3yhfp5otmWtULsSwnmr14
	z53dPB086i9zmVmrhopHDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725830297; x=
	1725916697; bh=J/m2qCsXtYaLAcpnBF5yeDYetdgbwY6EnTPusQDW6gA=; b=q
	ygbMk/FaSgeC58fEdTTtYy8Dh9Wy1hErWp5tr3ABuOlMuY8MPKs1guWfMwmRxty8
	WN4D/+MqZFRRcVRdsGql43SagOOn1KdFS8AaataFs7PiwCU45IZAeWXH4zG4LAZ7
	4UKIWe9sy1avbf4IcrUDrxxsNIWFFKDp9E56mk9AR4QLTY94SV4Ji0D9CvNcQHXu
	0ZKWsrN2ux5h9x5IJ++eu/yI7HVqGIu2+LIk1lNRkW80vhz75WsO+U8jAK9d25Lu
	+cmm2Kgof8F8WgXi/6N4VV09CHamhlxv4i3OVyaPiDMl5ggG5FdViCfnL6bEBqqF
	TvRaaTNzc8gS5RNLz36Lw==
X-ME-Sender: <xms:mRTeZrqXzh9ql7vxDkUkZ8Lemdsb3qsbKPdy9Glme6cw6Tr2j71wvQ>
    <xme:mRTeZlrStZp9vcBgFP8DWMC0BxzaDZbc1DCJAeiAW7ZrCNQH8R7mNeQjKyRIb006I
    uc2skjP9U4lsw>
X-ME-Received: <xmr:mRTeZoPEvygly52UxQ2zoaZf-vNbyXMO2yDUe3KxtSdXUQwmCyLQzl9tfhxN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeihedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    udenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepueelueetueevjeehleeuvdfhheegieelfeevgeekudffffettefg
    udevgeehgeevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpmhhsghhiugdrlhhinh
    hknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhr
    vghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshhprghsshifohhlfhesfigvsgdruggvpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslh
    gvqdgtohhmmhhithhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhv
    rghloheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvth
X-ME-Proxy: <xmx:mRTeZu7J26s7HjND4akDjO-jtM-w84SqhK9P5ev0-TqpXTb6r4AaDQ>
    <xmx:mRTeZq6SrGtc4sDr0J6pKYQhRoUoH4W-7_tQPJwZ7oFmfGsNYlNkcw>
    <xmx:mRTeZmhkkYGhopBvFYjttbkYHVTeG3Zk0_Fu_cwl2C3zZIu28i_9-g>
    <xmx:mRTeZs7Bmv2QykrQ4JlfVXowT76EEZpC2p-C6sR6e3qacV9VxkqOEg>
    <xmx:mRTeZnwsNffbvbjoL6awxfpY_YXOd578fUa5JaoZLD6AnTVJZOiUaVJL>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Sep 2024 17:18:16 -0400 (EDT)
Date: Sun, 8 Sep 2024 23:18:15 +0200
From: Greg KH <greg@kroah.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: Patch "wifi: mt76: mt7921: fix NULL pointer access in
 mt7921_ipv6_addr_change" has been added to the 6.6-stable tree
Message-ID: <2024090842-patient-dispatch-c528@gregkh>
References: <20240908133703.1652036-1-sashal@kernel.org>
 <38a42fddfd5b6cde1115b600a40ad4b158b430ea.camel@web.de>
 <2024090859-wooing-crock-6827@gregkh>
 <2390be3e4792fa95df68d1f28818a5ed60c3cfdf.camel@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2390be3e4792fa95df68d1f28818a5ed60c3cfdf.camel@web.de>

On Sun, Sep 08, 2024 at 07:21:23PM +0200, Bert Karwatzki wrote:
> Am Sonntag, dem 08.09.2024 um 16:40 +0200 schrieb Greg KH:
> > On Sun, Sep 08, 2024 at 04:27:49PM +0200, Bert Karwatzki wrote:
> > > Am Sonntag, dem 08.09.2024 um 09:37 -0400 schrieb Sasha Levin:
> > > > This is a note to let you know that I've just added the patch titled
> > > >
> > > >     wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change
> > > >
> > > > to the 6.6-stable tree which can be found at:
> > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > >
> > > > The filename of the patch is:
> > > >      wifi-mt76-mt7921-fix-null-pointer-access-in-mt7921_i.patch
> > > > and it can be found in the queue-6.6 subdirectory.
> > > >
> > > > If you, or anyone else, feels it should not be added to the stable tree,
> > > > please let <stable@vger.kernel.org> know about it.
> > > >
> > > >
> > > >
> > > > commit 857d7854c40324bfc70a6d32c9eb0792bc7c0b56
> > > > Author: Bert Karwatzki <spasswolf@web.de>
> > > > Date:   Mon Aug 12 12:45:41 2024 +0200
> > > >
> > > >     wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change
> > > >
> > > >     [ Upstream commit 479ffee68d59c599f8aed8fa2dcc8e13e7bd13c3 ]
> > > >
> > > >     When disabling wifi mt7921_ipv6_addr_change() is called as a notifier.
> > > >     At this point mvif->phy is already NULL so we cannot use it here.
> > > >
> > > >     Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > > >     Signed-off-by: Felix Fietkau <nbd@nbd.name>
> > > >     Signed-off-by: Kalle Valo <kvalo@kernel.org>
> > > >     Link: https://patch.msgid.link/20240812104542.80760-1-spasswolf@web.de
> > > >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > >
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > > index 6a5c2cae087d..6dec54431312 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > > @@ -1095,7 +1095,7 @@ static void mt7921_ipv6_addr_change(struct ieee80211_hw *hw,
> > > >  				    struct inet6_dev *idev)
> > > >  {
> > > >  	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
> > > > -	struct mt792x_dev *dev = mvif->phy->dev;
> > > > +	struct mt792x_dev *dev = mt792x_hw_dev(hw);
> > > >  	struct inet6_ifaddr *ifa;
> > > >  	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
> > > >  	struct sk_buff *skb;
> > >
> > > The patch is only fixes a NULL pointer if the tree also contains this commit: 
> > >
> > > commit 574e609c4e6a0843a9ed53de79e00da8fb3e7437
> > > Author: Felix Fietkau <nbd@nbd.name>
> > > Date:   Thu Jul 4 15:09:47 2024 +0200
> > >
> > >     wifi: mac80211: clear vif drv_priv after remove_interface when stopping
> > >
> > >     Avoid reusing stale driver data when an interface is brought down and up
> > >     again. In order to avoid having to duplicate the memset in every single
> > >     driver, do it here.
> > >
> > >     Signed-off-by: Felix Fietkau <nbd@nbd.name>
> > >     Link: https://patch.msgid.link/20240704130947.48609-1-nbd@nbd.name
> > >     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > >
> > >
> > > In trees which do not contain this the patch is not necessary.
> >
> > Ah, perhaps a Fixes: tag should have been used here then?
> >
> > Anyway, I'll go drop this commit from the 2 trees now, thanks.
> >
> > greg k-h
> 
> So
> "Fixes: 09c4e6a (" wifi: mac80211: clear vif drv_priv after remove_interface
> when stopping")"
> would be the correct tag?

Close, it would be:

Fixes: 574e609c4e6a ("wifi: mac80211: clear vif drv_priv after remove_interface when stopping")

Right?

thanks,

greg k-h

