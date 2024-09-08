Return-Path: <stable+bounces-73927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3A29708E4
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 19:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628361F2170F
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 17:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73264175D35;
	Sun,  8 Sep 2024 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="AmEfoBQH"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C0C3FF1;
	Sun,  8 Sep 2024 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725816102; cv=none; b=f+bYTVmHvgbvCJzhj3VzM/N5O80PfrGKS+VCGJN05h68jwDvKmdZ0cJlUhh0aOCRZcor5YNSyN/68YNtayKnvoQCeBmAX+DwOpxQ5iHJXj13/GIFhdgHoeOQoj8GhMPOzjkWGI0xZ7ejCZ6Z4KHdtCp+tZl67/4VDz6ARKB7c9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725816102; c=relaxed/simple;
	bh=s5AdX7opWebqYUMAyvGZvUBOnUh72v+qOX9yOf96rrM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j9GnY2QB+oT3P/Z/ysl38EScG58dSu/lbQtaxwDE9jj0G2j5Sj3+7I4Y1DIsveZvc+wk+8Bkk0zTMmDjr4JDdjQfhM/UEAmAxGyTcRYPe/m1aJeqFCo4ulAHPe0Q1hMq54yqVNIC+TXBbC8J4aScAPhSDzfxCm0fbRQJk7wo5s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=AmEfoBQH; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725816084; x=1726420884; i=spasswolf@web.de;
	bh=NBodCydRz1h5gjv4zRZqlA2bXbKHYH/Dy7GpYakwN5A=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AmEfoBQHAZqUBN6vJqMrL4Ho9/UUzDyjcZJHXV1YUsDHb2bEDxI84R8T7CqE/D30
	 QxdC1e6Heg0uM/ZpiK1KwNN5bs+v57uqriI/ugYqD7+zv2iWcdcis7eJfKVLfF5/Q
	 tJP+a1vjhM5DzGBsdgPg8b4W3iYB+0mHsV0pYMLAqV5fczoO3UxpGroJxntUuCTlY
	 8F5gaXY5v9KqI6fP51M7wAVcEeR2oRjYp5m9N1X7M+BX9d2Zb5ye8zHaPiXEYaBTz
	 nYybR32KStE2M1HK0Yt7EMVnIA8ilRyAC1rnI5iqbEQ9c0VL9SK2Kw+n9kZxdAw5P
	 52U7DbPzoXF+TKmUVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdfCN-1sDjjZ2mqv-00b9dl; Sun, 08
 Sep 2024 19:21:24 +0200
Message-ID: <2390be3e4792fa95df68d1f28818a5ed60c3cfdf.camel@web.de>
Subject: Re: Patch "wifi: mt76: mt7921: fix NULL pointer access in
 mt7921_ipv6_addr_change" has been added to the 6.6-stable tree
From: Bert Karwatzki <spasswolf@web.de>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, Kalle Valo	
 <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 spasswolf@web.de
Date: Sun, 08 Sep 2024 19:21:23 +0200
In-Reply-To: <2024090859-wooing-crock-6827@gregkh>
References: <20240908133703.1652036-1-sashal@kernel.org>
	 <38a42fddfd5b6cde1115b600a40ad4b158b430ea.camel@web.de>
	 <2024090859-wooing-crock-6827@gregkh>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uurudrL4R3buzzkca0cpSJPeV4jUhYMYFuvgiD3xhMYFSw/B1Fw
 i38vpmY1LqhuMseL+aVeLQF9xllDBVuWycSgJSSNFE37EZsAbHbwJOMhpxL+jAPXMJEqTHN
 YZoqTLZnWiB9zHSf4ho285LOaeDzlDWtSfi2DNFZtGRgjCncvIfh0Hg9IvEgZYeHbz0MHIv
 tvJRXd2Pm14CPVYQMQYyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XWUuUQrklDE=;tueAQfh8SB0reV/T1xjwAp4jSVG
 SGVtd5oT4Z6HP65en3J9XUwMvi9V/M8JHgYy/lWGZQav9C5Mc4Yzn7tn0dgjv/1+rocnVzknf
 SShzOzQZOtAAevGK75QUJj/qr6eeNnlhlRVAB17qw5AEbX5Gl4hi3uYNxPTnsTsP8eWHKcexw
 gxnJVYmYO00EYc8/STMLXdgkY2IBlsAkaComZx08tJulOaUkycn5tBuAYXce8+iluk1wlBVdc
 S3ujzIIkgNCAcRROfmG5Yv57OG+o1WWYzZdfqeuJzNAFmjim/dCSH/sl9BaAPKnCKEq7jZ3Nb
 /c5FQHXo+JYQBTGiQYsmJnw11bM/Ez0Y4/rRRfPP9kMkcjAX6kJkbUrrdls+DSaYuLpz2khx6
 LdFpAW2wavKka0erkwe2WpNmgLtWEvE/irDE90BnLnjebLSP+cccVMV4z51f39V5aRSFkFUqy
 GEAJjFuCK5RaS+UhbnIVNTZAx5SFW4cKBwVS9BypCP3C9xK4qguObQK7ND/nnXofxHZCy54F4
 hAel9Jo49TD7QhL8bPEam3ODkIZoSrQbFz3J6VOxDpW24gSK0eij0rzNHEJv8CGH6hBmR0TZC
 6amVR86r8VeP2xiXrCZHgSCg5j+EYVl0+Q5mk6T6KjJtO7Rdxl6PGfJbjLuvNKMUZvyOFGijj
 5jEBrucNdI/iryIA6TUOb/TMYwmFbx/+SlShe6ta8QccywL9kvRkfTjIA3VOxILTIZMHKAapn
 bz/MWSW1xtw+3BHR0nUhvBatnqK9dFWSYAULF1nNm4xZd8oVihRKmrDk18a/ZSnC4Osti1S1L
 UFMDIaiRpDv4KzOhAHdNu5cA==

Am Sonntag, dem 08.09.2024 um 16:40 +0200 schrieb Greg KH:
> On Sun, Sep 08, 2024 at 04:27:49PM +0200, Bert Karwatzki wrote:
> > Am Sonntag, dem 08.09.2024 um 09:37 -0400 schrieb Sasha Levin:
> > > This is a note to let you know that I've just added the patch titled
> > >
> > >     wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_=
change
> > >
> > > to the 6.6-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-qu=
eue.git;a=3Dsummary
> > >
> > > The filename of the patch is:
> > >      wifi-mt76-mt7921-fix-null-pointer-access-in-mt7921_i.patch
> > > and it can be found in the queue-6.6 subdirectory.
> > >
> > > If you, or anyone else, feels it should not be added to the stable t=
ree,
> > > please let <stable@vger.kernel.org> know about it.
> > >
> > >
> > >
> > > commit 857d7854c40324bfc70a6d32c9eb0792bc7c0b56
> > > Author: Bert Karwatzki <spasswolf@web.de>
> > > Date:   Mon Aug 12 12:45:41 2024 +0200
> > >
> > >     wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_=
change
> > >
> > >     [ Upstream commit 479ffee68d59c599f8aed8fa2dcc8e13e7bd13c3 ]
> > >
> > >     When disabling wifi mt7921_ipv6_addr_change() is called as a not=
ifier.
> > >     At this point mvif->phy is already NULL so we cannot use it here=
.
> > >
> > >     Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > >     Signed-off-by: Felix Fietkau <nbd@nbd.name>
> > >     Signed-off-by: Kalle Valo <kvalo@kernel.org>
> > >     Link: https://patch.msgid.link/20240812104542.80760-1-spasswolf@=
web.de
> > >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> > >
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/driv=
ers/net/wireless/mediatek/mt76/mt7921/main.c
> > > index 6a5c2cae087d..6dec54431312 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > @@ -1095,7 +1095,7 @@ static void mt7921_ipv6_addr_change(struct iee=
e80211_hw *hw,
> > >  				    struct inet6_dev *idev)
> > >  {
> > >  	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> > > -	struct mt792x_dev *dev =3D mvif->phy->dev;
> > > +	struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
> > >  	struct inet6_ifaddr *ifa;
> > >  	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
> > >  	struct sk_buff *skb;
> >
> > The patch is only fixes a NULL pointer if the tree also contains this =
commit:=C2=A0
> >
> > commit 574e609c4e6a0843a9ed53de79e00da8fb3e7437
> > Author: Felix Fietkau <nbd@nbd.name>
> > Date:   Thu Jul 4 15:09:47 2024 +0200
> >
> >     wifi: mac80211: clear vif drv_priv after remove_interface when sto=
pping
> >
> >     Avoid reusing stale driver data when an interface is brought down =
and up
> >     again. In order to avoid having to duplicate the memset in every s=
ingle
> >     driver, do it here.
> >
> >     Signed-off-by: Felix Fietkau <nbd@nbd.name>
> >     Link: https://patch.msgid.link/20240704130947.48609-1-nbd@nbd.name
> >     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> >
> >
> > In trees which do not contain this the patch is not necessary.
>
> Ah, perhaps a Fixes: tag should have been used here then?
>
> Anyway, I'll go drop this commit from the 2 trees now, thanks.
>
> greg k-h

So
"Fixes: 09c4e6a (" wifi: mac80211: clear vif drv_priv after remove_interfa=
ce
when stopping")"
would be the correct tag?

Bert Karwatzki

