Return-Path: <stable+bounces-134755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1283A9497C
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 22:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F8616F9F9
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 20:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18DF19F116;
	Sun, 20 Apr 2025 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FDPSiAXC"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CDB13C3CD;
	Sun, 20 Apr 2025 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745179514; cv=none; b=jRhr3962O+o+L+wYQczrTvOrA/ZzUlX+s4KDrUfFRhbRU+7IHkICIQdwnPj/+t+VaS8HkNpOfr9YttrdyWXKEccRVvLNE+IIYM17vaLgupxqycEsuntFYiQyEBq1RA33nSjYs2Q/K1heP1q4ETPnh2MhMi2hvaRhqIl767FTBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745179514; c=relaxed/simple;
	bh=C0wHC3EhX4JvIIGou4EHZrhXRR4ydQXe7xB3MTKMaQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hs1tbsobl8nlxB3uF+Je7qYKs82IZ9nHr74asp7GMPjI/1Nm+JAIggveUrGuo5qJSIDtNi+/DqGXIbR/g/DHUVJtioSZ6id6ixe9q83tQAq9IZh+Dyd8IbAMw4l+IzCSfF9a/c89BRdkrY3bL755zXaayQ+DpRHIkZjBwlOc4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FDPSiAXC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vwQi6RSR2dzipHxzDAJCgvAk8VXSUrxo3Y6Y36Y9CBE=;
	t=1745179513; x=1746389113; b=FDPSiAXCMYUUaF+BaQRx7kg/chvSnqUzRjl8vWrktmbgmqc
	IDXnjntZNwqnuBD6nu2RQyVHap8Ov7ZMXFtJzb1GlOSlXavmvpiDwk02gepsQ8YjRtjk2h92LtisC
	Kyp58c2Gt4GZDAz4iuQcFYn9rLTePf54QHhYx2kG0Bw7JVay3+yB0Ufw4xHZ6/Fr9OC+jjbiOhzyZ
	usnlE7yMOPi0unCSGhyfwwzhhceHPU1aDiacUGnEcgbDFwl7xLVlfB9P8t9xRsw+QBuai0fM4p9Am
	ZAokPSwbx1edYg2+R6QwuLuisauG4wqyW6iJS7X2uoMUKJGOnkjo/MRkOagelLTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u6aTP-00000007oWT-0spT;
	Sun, 20 Apr 2025 21:37:03 +0200
Message-ID: <4ade9e6f4f5238ae7ac5eed483cf0f2cee1a81a1.camel@sipsolutions.net>
Subject: Re: Patch "wifi: mac80211: Update skb's control block key in
 ieee80211_tx_dequeue()" has been added to the 6.14-stable tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>, stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org
Date: Sun, 20 Apr 2025 21:37:02 +0200
In-Reply-To: <aAVJuPUEZrTDy7L1@pilgrim>
References: <20250420150053.1781606-1-sashal@kernel.org>
	 <aAVJuPUEZrTDy7L1@pilgrim>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-04-20 at 21:23 +0200, Remi Pommarel wrote:
> Hello,
>=20
> On Sun, Apr 20, 2025 at 11:00:53AM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> >=20
> >     wifi: mac80211: Update skb's control block key in ieee80211_tx_dequ=
eue()
> >=20
> > to the 6.14-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue=
.git;a=3Dsummary
> >=20
> > The filename of the patch is:
> >      wifi-mac80211-update-skb-s-control-block-key-in-ieee.patch
> > and it can be found in the queue-6.14 subdirectory.
> >=20
> > If you, or anyone else, feels it should not be added to the stable tree=
,
> > please let <stable@vger.kernel.org> know about it.
> >=20
>=20
> Not sure this patch should go to stable. @Johannes haven't you revert
> it in your tree ?

Indeed, I did, since there was a regression and we hadn't figured out in
time why. I'm just back from travel so I have no idea what happened in
the meantime :)

johannes

