Return-Path: <stable+bounces-6375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A16080DF3E
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 00:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0D41C21542
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 23:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7188056465;
	Mon, 11 Dec 2023 23:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leolam.fr header.i=@leolam.fr header.b="DSXtCrNj"
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 15:08:31 PST
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19C19A
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 15:08:31 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Spy8t0dkDzMpnPZ;
	Mon, 11 Dec 2023 23:08:30 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Spy8s4wRMz3Y;
	Tue, 12 Dec 2023 00:08:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leolam.fr;
	s=20210220; t=1702336109;
	bh=m3b3nxVRX2biRr2Uwdj41jC/fd1yuuw+9n+7YMtDu84=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=DSXtCrNjBTCI01rVxQCgYPCFHBJ1Q8OCoDAfCUTPwD6LZILf/Ovtub1IUc1xxRyRz
	 x4znnTjUC6+uOiK9kCBsUSbCpcwWgGOoe+wwl6ltAZ+urq5+0zcVW5NWh+VgeUMohW
	 vNOg40yNRzx71moBjYOOMNjPFEkUQjQqYmbe52PA=
Message-ID: <1e10a75c59ffb6151e10ec5df38e6b5d1d1d1b34.camel@leolam.fr>
Subject: Re: [PATCH] wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi
 (6.6.x)
From: =?ISO-8859-1?Q?L=E9o?= Lam <leo@leolam.fr>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, johannes.berg@intel.com
In-Reply-To: <2023121147-estrogen-reviver-afb4@gregkh>
References: <20231210213930.61378-1-leo@leolam.fr>
	 <2023121135-unwilling-exception-0bcc@gregkh>
	 <2023121147-estrogen-reviver-afb4@gregkh>
Autocrypt: addr=leo@leolam.fr; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Dec 2023 23:07:38 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.50.2 
X-Infomaniak-Routing: alpha

On Mon, 2023-12-11 at 13:45 +0100, Greg KH wrote:
> On Mon, Dec 11, 2023 at 07:47:32AM +0100, Greg KH wrote:
> > On Sun, Dec 10, 2023 at 09:39:30PM +0000, L=C3=A9o Lam wrote:
> > > Commit 4a7e92551618f3737b305f62451353ee05662f57 ("wifi: cfg80211: fix
> > > CQM for non-range use" on 6.6.x) causes nl80211_set_cqm_rssi not to
> > > release the wdev lock in some situations.
> > >=20
> > > Of course, the ensuing deadlock causes userland network managers to
> > > break pretty badly, and on typical systems this also causes lockups o=
n
> > > on suspend, poweroff and reboot. See [1], [2], [3] for example report=
s.
> > >=20
> > > The upstream commit, 7e7efdda6adb385fbdfd6f819d76bc68c923c394
> > > ("wifi: cfg80211: fix CQM for non-range use"), does not trigger this
> > > issue because the wdev lock does not exist there.
> > >=20
> > > Fix the deadlock by releasing the lock before returning.
> > >=20
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D218247
> > > [2] https://bbs.archlinux.org/viewtopic.php?id=3D290976
> > > [3] https://lore.kernel.org/all/87sf4belmm.fsf@turtle.gmx.de/
> > >=20
> > > Fixes: 4a7e92551618 ("wifi: cfg80211: fix CQM for non-range use")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: L=C3=A9o Lam <leo@leolam.fr>
> > > ---
> > >  net/wireless/nl80211.c | 18 ++++++++++++------
> > >  1 file changed, 12 insertions(+), 6 deletions(-)
> >=20
> > So this is only for the 6.6.y tree?  If so, you should at least cc: the
> > other wireless developers involved in the original fix, right?
> >=20
> > And what commit actually fixed this issue upstream, why not take that
> > instead?
>=20
> I've reverted the offending commit in the last 6.1.y and 6.6.y release,
> so can you send this as a patch series, first one being the original
> backport, and the second one this one, AFTER it has been tested?
>=20

Last night I didn't have the time to do more than just make sure the
patch built fine, but it seems that several people on the Manjaro forum
have since reported that it does fix their issue (when applied on top of
the 6.6.5 tree) [1].

I will re-apply commit 7e7efdda6adb ("wifi: cfg80211: fix CQM for non-
range use") with this patch on top of the latest 6.6.y version and
verify that the deadlock is still fixed.


[1]https://lore.kernel.org/stable/43a1aa34-5109-41ad-88e7-19ba6101dad3@manj=
aro.org/

--=20
Thanks,
Leo


