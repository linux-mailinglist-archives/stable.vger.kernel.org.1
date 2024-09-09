Return-Path: <stable+bounces-74083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9DC9721F9
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 20:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B861F24D75
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FCA189906;
	Mon,  9 Sep 2024 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theune.cc header.i=@theune.cc header.b="kcMuRO+E"
X-Original-To: stable@vger.kernel.org
Received: from mail.theune.cc (mail.theune.cc [212.122.41.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FAB1898F1;
	Mon,  9 Sep 2024 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907123; cv=none; b=radkIBhZUroF6Pe4HfMGzmc9c8RZtjWjHQWOBfseAtK1+aI1girl50CedckAFkdmpTGTnuXsc/w40xms3CXvimb0ZLHwdZLqg1doRqS/8QBwpUfgdvmygFcqehDKwhqhuo2mCZ8Lb6CG269y2a2OhHnPuOzFE8AYQy6Eewmk3Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907123; c=relaxed/simple;
	bh=b0qFVgnkFadnBp83rb8wKhiucFe/QPV1vNclNvc/6nA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WA3JEmTST/vGYF1cYCWlZivBtSmFE4HoiNF28sdmlBdnJ8OMsYk+iZDO+3BV0oC4/ICb3F4kXslJsq3ZgxMpG5LRSwgj8M7rWA8ihkDRrIBHqeRyP4QQaSKaguFoIl+qBv+aMqu6GDKYNG2vZ6ed9cFwvDgVMMbyavrqEp9EiAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=theune.cc; spf=pass smtp.mailfrom=theune.cc; dkim=pass (1024-bit key) header.d=theune.cc header.i=@theune.cc header.b=kcMuRO+E; arc=none smtp.client-ip=212.122.41.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=theune.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theune.cc
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theune.cc; s=mail;
	t=1725907110; bh=b0qFVgnkFadnBp83rb8wKhiucFe/QPV1vNclNvc/6nA=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=kcMuRO+EFkoZW4ZiKmnF95t4CB47QsKce0/StC8hEROdxLBVSAJ2DUfbnTUl41lPv
	 HkLc0KzNfL6DTv5PqoiUyoaPu2ACD6B6f21SA4GIEXXZc4ob6LRCXTGSa7CGYdTo1o
	 mSxvKDc0NKLyIQwIfzn+stA16gHuBiCrPFeLhTzQ=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Follow-up to "net: drop bad gso csum_start and offset in
 virtio_net_hdr" - backport for 5.15 needed
From: Christian Theune <christian@theune.cc>
In-Reply-To: <66df3fb5a228e_3d03029498@willemb.c.googlers.com.notmuch>
Date: Mon, 9 Sep 2024 20:38:09 +0200
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Willem de Bruijn <willemb@google.com>,
 regressions@lists.linux.dev,
 stable@vger.kernel.org,
 netdev@vger.kernel.org,
 mathieu.tortuyaux@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B75F6BF-0E0E-4BCC-8557-95A5D8D80038@theune.cc>
References: <89503333-86C5-4E1E-8CD8-3B882864334A@theune.cc>
 <2024090309-affair-smitten-1e62@gregkh>
 <CA+FuTSdqnNq1sPMOUZAtH+zZy+Fx-z3pL-DUBcVbhc0DZmRWGQ@mail.gmail.com>
 <2024090952-grope-carol-537b@gregkh>
 <66df3fb5a228e_3d03029498@willemb.c.googlers.com.notmuch>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

I can contribute live testing and can quickly reproduce the issue.

If anything is there that should be tested for apart from verifying the =
fix, I=E2=80=99d be happy to try.

Christian

> On 9. Sep 2024, at 20:34, Willem de Bruijn =
<willemdebruijn.kernel@gmail.com> wrote:
>=20
> Greg KH wrote:
>> On Mon, Sep 09, 2024 at 12:05:17AM -0400, Willem de Bruijn wrote:
>>> On Tue, Sep 3, 2024 at 4:03=E2=80=AFAM Greg KH =
<gregkh@linuxfoundation.org> wrote:
>>>>=20
>>>> On Tue, Sep 03, 2024 at 09:37:30AM +0200, Christian Theune wrote:
>>>>> Hi,
>>>>>=20
>>>>> the issue was so far handled in =
https://lore.kernel.org/regressions/ZsyMzW-4ee_U8NoX@eldamar.lan/T/#m390d6=
ef7b733149949fb329ae1abffec5cefb99b and =
https://bugzilla.kernel.org/show_bug.cgi?id=3D219129
>>>>>=20
>>>>> I haven=E2=80=99t seen any communication whether a backport for =
5.15 is already in progress, so I thought I=E2=80=99d follow up here.
>>>>=20
>>>> Someone needs to send a working set of patches to apply.
>>>=20
>>> The following stack of patches applies cleanly to 5.15.166
>>> (original SHA1s, git log order, so inverse of order to apply):
>>>=20
>>> 89add40066f9e net: drop bad gso csum_start and offset in =
virtio_net_hdr
>>> 9840036786d9 gso: fix dodgy bit handling for GSO_UDP_L4
>>> fc8b2a619469 net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
>>>=20
>>> All three are already present in 6.1.109
>>>=20
>>> Please let me know if I should send that stack using git send-email,
>>> or whether this is sufficient into to backport.
>>=20
>> I just tried it, they do not apply cleanly here for me at all :(
>>=20
>>> The third commit has one Fixes referencing them:
>>>=20
>>> 1382e3b6a350 net: change maximum number of UDP segments to 128
>>>=20
>>> This simple -2/+2 line patch unfortunately cannot be backported
>>> without conflicts without backporting non-stable feature changes.
>>> There is a backport to 6.1.y, but that also won't apply cleanly to
>>> 5.15.166 without backporting a feature (e2a4392b61f6 "udp: introduce
>>> udp->udp_flags"), which itself does not apply cleanly.
>>>=20
>>> So simplest is probably to fix up this commit and send it using git
>>> send-email. I can do that as part of the stack with the above 3
>>> patches, or stand-alone if the above can be cherry-picked by SHA1.
>>=20
>> Please send me a set of working, and tested, patches and we will be =
glad
>> to consider it.
>=20
> Done:
>=20
> =
https://lore.kernel.org/stable/20240909182506.270136-1-willemdebruijn.kern=
el@gmail.com/T/#m0086f42d20bfc4d6226a8cf379590032edfbbe21
>=20
> The following worked fine for me. I hope I did not overlook anything.
> Compile tested only. But as said, the same patches have landed in
> 6.1-stable.
>=20
> git fetch linux-stable linux-5.15.y
> git checkout linux-stable/linux-5.15.y
> git cherry-pick fc8b2a619469
> git cherry-pick 9840036786d9
> git cherry-pick 89add40066f9e
> make defconfig
> make -j 64
>=20
> Unfortunately, the key commit itself has a bug report against it. I am
> working on that right now.
>=20
> But as the existing patch that it refers to in its Fixes has landed in
> all stable kernels and is causing reports, it is a backporting case of
> damned if we do, damned if we don't.
>=20
> I intend to have a fix ready ASAP for netdev-net/main. If all stable
> branches have all backports, it should apply cleanly everywhere. Just
> not ready to be included in this series from the start.


Liebe Gr=C3=BC=C3=9Fe,
Christian

-- =20
Christian Theune - A97C62CE - 0179 7808366
@theuni - christian@theune.cc


