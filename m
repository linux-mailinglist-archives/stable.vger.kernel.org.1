Return-Path: <stable+bounces-141810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5665AAC567
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F248175B2B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C29B16D9C2;
	Tue,  6 May 2025 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mF1iKxr1"
X-Original-To: stable@vger.kernel.org
Received: from marcos.anarc.at (marcos.anarc.at [45.72.186.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B528003E
	for <stable@vger.kernel.org>; Tue,  6 May 2025 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.72.186.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537143; cv=none; b=fugyeZXPFLckNz5ld7pikjaUzA2Vw1HxKhqKdrVnt+e43n718/KEjHH3AC/sXX7JA0M96kyxvsIlQpOn4YCwo7B7tWj5ueR6JsPZT80T/D4/tP7mmzObltRS14/T5SmOfHyfKQcGbGmqT256bkfx3JDsL0N3rAIsIV/FChvYYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537143; c=relaxed/simple;
	bh=KB0ujOeI5Dlu5Z/fNP55MDKjcYhVw1A47KC5iBzwZMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aiKSciZgQiM+nPrhpA9Tv5cCicR62vHF675X59pKbDoWKti64j+4fVPW4lH9JwCV9uLfGDLEL41YRJMqamRFLaboxwFzWwm2pBEQPEmCnP/x84hhBtDl0OcSQYeyfJSTMn1+5mPAkZllS/qAvC2g0HH+z3heak3o+864ByEXhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mF1iKxr1; arc=none smtp.client-ip=45.72.186.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DMARC-Filter: OpenDMARC Filter v1.4.2 marcos.anarc.at A57E010E047
Authentication-Results: marcos.anarc.at; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: marcos.anarc.at; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
	s=marcos-debian.anarcat.user; t=1746537139;
	bh=KB0ujOeI5Dlu5Z/fNP55MDKjcYhVw1A47KC5iBzwZMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mF1iKxr1giKhpnsxgYwGt9K6mbN/d4ettEDvyCTYA29VCnmsDvP7mLBOpa5SHXm29
	 h7sf8ikx37noSiZ/9a7vfh7HbCVBG/zpV7kidrj4ZU/yOr8vLme+XwgvoGab7uSOQT
	 VIbhygTJMCO6i/qYAGSsbuZktUiNPHulSiYzhjn2Co+zDXw9oHdwQAGl40ad8fkfnS
	 qQbMV+VsWq/bK10/CYg0Lm8amtTbEBnwwOTpv96b59SbaMACqTKD8fA2KuVKfN6rsV
	 35zljzqmXBIksGe6RekOdTuDn8q7FpX52CdxQbd8SMWx5Jzqrcky9EahXT4pB0j0sl
	 hRztdb5OKRzJA==
Received: from angela.anarc.at (unknown [45.72.186.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256
	 client-signature ED25519)
	(Client CN "angela.anarc.at", Issuer "ca.anarc.at" (not verified))
	by marcos.anarc.at (Postfix) with ESMTPS id A57E010E047;
	Tue,  6 May 2025 09:12:19 -0400 (EDT)
Received: by angela.anarc.at (Postfix, from userid 1000)
	id 5A0B2E01ED; Tue, 06 May 2025 09:12:19 -0400 (EDT)
From: =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To: Salvatore Bonaccorso <carnil@debian.org>, Yu Kuai
 <yukuai1@huaweicloud.com>, 1104460@bugs.debian.org
Cc: Moritz =?utf-8?Q?M=C3=BChlenhoff?= <jmm@inutil.org>, Melvin Vermeeren
 <vermeeren@vermwa.re>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Coly Li <colyli@kernel.org>, Sasha Levin <sashal@kernel.org>, stable
 <stable@vger.kernel.org>, regressions@lists.linux.dev, "yukuai (C)"
 <yukuai3@huawei.com>
Subject: Re: Bug#1104460: [regression 6.1.y] discard/TRIM through RAID10
 blocking
In-Reply-To: <aBmlgkHrbTYzwjj4@eldamar.lan>
Organization: Debian
References: <aBilQxLZ4MA4Tg8e@pisco.westfalen.local>
 <aBjEf5R7X9GaJg2T@eldamar.lan>
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBjhHUjtXRotZUVa@eldamar.lan>
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <875xiex56v.fsf@angela.anarc.at> <aBkhNwVVs_KwgQ1a@eldamar.lan>
 <87zffqvknw.fsf@angela.anarc.at>
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <4762cbe1-30a2-e5cd-52e1-f2de7714da1e@huaweicloud.com>
 <aBmlgkHrbTYzwjj4@eldamar.lan>
Date: Tue, 06 May 2025 09:12:19 -0400
Message-ID: <87wmatvq6k.fsf@angela.anarc.at>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2025-05-06 08:00:34, Salvatore Bonaccorso wrote:
> Hi Yu,
>
> Thanks for your followups.
>
> On Tue, May 06, 2025 at 09:25:50AM +0800, Yu Kuai wrote:
>> Hi,
>>=20
>> =E5=9C=A8 2025/05/06 4:59, Antoine Beaupr=C3=A9 =E5=86=99=E9=81=93:
>> > On 2025-05-05 22:36:07, Salvatore Bonaccorso wrote:
>> > > Hi Antoine,
>> > >=20
>> > > On Mon, May 05, 2025 at 02:50:32PM -0400, Antoine Beaupr=C3=A9 wrote:
>> > > > On 2025-05-05 18:02:37, Salvatore Bonaccorso wrote:
>> > > > > On Mon, May 05, 2025 at 04:00:31PM +0200, Salvatore Bonaccorso w=
rote:
>> > > > > > Hi Moritz,
>> > > > > >=20
>> > > > > > On Mon, May 05, 2025 at 01:47:15PM +0200, Moritz M=C3=BChlenho=
ff wrote:
>> > > > > > > Am Wed, Apr 30, 2025 at 05:55:20PM +0200 schrieb Salvatore B=
onaccorso:
>> > > > > > > > Hi
>> > > > > > > >=20
>> > > > > > > > We got a regression report in Debian after the update from=
 6.1.133 to
>> > > > > > > > 6.1.135. Melvin is reporting that discard/trimm trhough a =
RAID10 array
>> > > > > > > > stalls idefintively. The full report is inlined below and =
originates
>> > > > > > > > from https://bugs.debian.org/1104460 .
>> > > > > > >=20
>> > > > > > > JFTR, we ran into the same problem with a few Wikimedia serv=
ers running
>> > > > > > > 6.1.135 and RAID 10: The servers started to lock up once fst=
rim.service
>> > > > > > > got started. Full oops messages are available at
>> > > > > > > https://phabricator.wikimedia.org/P75746
>> > > > > >=20
>> > > > > > Thanks for this aditional datapoints. Assuming you wont be abl=
e to
>> > > > > > thest the other stable series where the commit d05af90d6218
>> > > > > > ("md/raid10: fix missing discard IO accounting") went in, migh=
t you at
>> > > > > > least be able to test the 6.1.y branch with the commit reverte=
d again
>> > > > > > and manually trigger the issue?
>> > > > > >=20
>> > > > > > If needed I can provide a test Debian package of 6.1.135 (or 6=
.1.137)
>> > > > > > with the patch reverted.
>> > > > >=20
>> > > > > So one additional data point as several Debian users were report=
ing
>> > > > > back beeing affected: One user did upgrade to 6.12.25 (where the
>> > > > > commit was backported as well) and is not able to reproduce the =
issue
>> > > > > there.
>> > > >=20
>> > > > That would be me.
>> > > >=20
>> > > > I can reproduce the issue as outlined by Moritz above fairly relia=
bly in
>> > > > 6.1.135 (debian package 6.1.0-34-amd64). The reproducer is simple,=
 on a
>> > > > RAID-10 host:
>> > > >=20
>> > > >   1. reboot
>> > > >   2. systemctl start fstrim.service
>> > > >=20
>> > > > We're tracking the issue internally in:
>> > > >=20
>> > > > https://gitlab.torproject.org/tpo/tpa/team/-/issues/42146
>> > > >=20
>> > > > I've managed to workaround the issue by upgrading to the Debian pa=
ckage
>> > > > from testing/unstable (6.12.25), as Salvatore indicated above. The=
re,
>> > > > fstrim doesn't cause any crash and completes successfully. In stab=
le, it
>> > > > just hangs there forever. The kernel doesn't completely panic and =
the
>> > > > machine is otherwise somewhat still functional: my existing SSH
>> > > > connection keeps working, for example, but new ones fail. And an `=
apt
>> > > > install` of another kernel hangs forever.
>> > >=20
>> > > So likely at least in 6.1.y there are missing pre-requisites causing
>> > > the behaviour.
>> > >=20
>> > > If you can test 6.1.135-1 with the commit
>> > > 4a05f7ae33716d996c5ce56478a36a3ede1d76f2 reverted then you can fetch
>> > > built packages at:
>> > >=20
>> > > https://people.debian.org/~carnil/tmp/linux/1104460/
>>=20
>> Can you also test with 4a05f7ae33716d996c5ce56478a36a3ede1d76f2 not
>> reverted, and also cherry-pick c567c86b90d4715081adfe5eb812141a5b6b4883?
>
> Thank you.
>
> Antoine, Moritz,
> https://people.debian.org/~carnil/tmp/linux/1104460-2/ contains a
> build with 4a05f7ae33716d996c5ce56478a36a3ede1d76f2 *not* reverted and
> with c567c86b90d4715081adfe5eb812141a5b6b4883 cherry-picked, can you
> test this one as well?

I tested this one, and could succesfully run fstrim.service without
problems.

A.

--=20
L'ennui avec la grande famille humaine, c'est que tout le monde veut
en =C3=AAtre le p=C3=A8re.
                        - Mafalda

