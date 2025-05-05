Return-Path: <stable+bounces-139732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DACAA9C0E
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 20:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1A217D7F7
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6E7264A6D;
	Mon,  5 May 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Nbs7xpWb"
X-Original-To: stable@vger.kernel.org
Received: from marcos.anarc.at (marcos.anarc.at [45.72.186.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A711FBC91
	for <stable@vger.kernel.org>; Mon,  5 May 2025 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.72.186.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471418; cv=none; b=WbGRmkAXK1IlHpApPMsOU5n/2INqJn2ZYJz0b91IdfhFC3H4jM2JHdf5JcnS1pfhIb4cXCsBd2JxNVlPcyMQznkE8T7DgF4KxCUZ/PKkVhb4pCZpOU/I8rp7yUCy/m4GpZcO2I2cZ91sSqwCdX9f6TLm+XHYYI9OxMnDTKGz82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471418; c=relaxed/simple;
	bh=Jm8cDvKJr3JykJz/Epe9saSS+BZhewWt6hrNq2l89DQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V8264twlPAiorhsLKhJTkl8j3YciKrBN4Wpu4K80iNe6EzZNvjJF9gFUUg/5c+HC/EHZ7njK4uEjjLRc8L9VI/qItmG8yiU7ximy4vI+HvHuuIzKRP3kGDvByii1kezy+L1O3EMwWTTRZ9qMePhG/tnDN+/lvc1ELXVy6NgM0q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Nbs7xpWb; arc=none smtp.client-ip=45.72.186.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DMARC-Filter: OpenDMARC Filter v1.4.2 marcos.anarc.at 35AD710E047
Authentication-Results: marcos.anarc.at; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: marcos.anarc.at; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
	s=marcos-debian.anarcat.user; t=1746471033;
	bh=Jm8cDvKJr3JykJz/Epe9saSS+BZhewWt6hrNq2l89DQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Nbs7xpWbpEHbuw5f+J32NNOT1ZP0daHCHlliPzWeeju5gL8xNI5Nwi6RsTmCQ5/5Y
	 Y4z103TRG63GwjWkB6ZGYBndljgx6rUj+fSc0Z5c+0Gq6wNm752WBLmow4sr1DMXeR
	 FjCQXuQkqNPrt3DTPDzzrvIGAb7sYOQJ0hDmxbBgzYko7lroyej6bK27Uq7adykMYl
	 buV3MtUhaVllwqAW0/pUCrLhLPMMgvPn6Kl6psI3cSD8VRVISQW+XZQ81wYCx1B8KK
	 gQTeMfW/eHkeS1o6jPVu1bqNLQqNSbfCxiQCIjOX0B7JbHreDo8t/sGOXcGnfRSyiV
	 XcCCxxd1SWNjg==
Received: from angela.anarc.at (unknown [45.72.186.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256
	 client-signature ED25519)
	(Client CN "angela.anarc.at", Issuer "ca.anarc.at" (not verified))
	by marcos.anarc.at (Postfix) with ESMTPS id 35AD710E047;
	Mon,  5 May 2025 14:50:33 -0400 (EDT)
Received: by angela.anarc.at (Postfix, from userid 1000)
	id C3E7CDFADB; Mon, 05 May 2025 14:50:32 -0400 (EDT)
From: =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To: Salvatore Bonaccorso <carnil@debian.org>, 1104460@bugs.debian.org,
 Moritz =?utf-8?Q?M=C3=BChlenhoff?= <jmm@inutil.org>, Yu Kuai
 <yukuai3@huawei.com>
Cc: Melvin Vermeeren <vermeeren@vermwa.re>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, 1104460@bugs.debian.org, Coly Li
 <colyli@kernel.org>, Sasha Levin <sashal@kernel.org>, stable
 <stable@vger.kernel.org>, regressions@lists.linux.dev
Subject: Re: Bug#1104460: [regression 6.1.y] discard/TRIM through RAID10
 blocking (was: Re: Bug#1104460: linux-image-6.1.0-34-powerpc64le: Discard
 broken) with RAID10: BUG: kernel tried to execute user page (0) - exploit
 attempt?
In-Reply-To: <aBjhHUjtXRotZUVa@eldamar.lan>
Organization: Debian
References: <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBJH6Nsh-7Zj55nN@eldamar.lan> <aBilQxLZ4MA4Tg8e@pisco.westfalen.local>
 <aBjEf5R7X9GaJg2T@eldamar.lan>
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBjhHUjtXRotZUVa@eldamar.lan>
Date: Mon, 05 May 2025 14:50:32 -0400
Message-ID: <875xiex56v.fsf@angela.anarc.at>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2025-05-05 18:02:37, Salvatore Bonaccorso wrote:
> On Mon, May 05, 2025 at 04:00:31PM +0200, Salvatore Bonaccorso wrote:
>> Hi Moritz,
>>=20
>> On Mon, May 05, 2025 at 01:47:15PM +0200, Moritz M=C3=BChlenhoff wrote:
>> > Am Wed, Apr 30, 2025 at 05:55:20PM +0200 schrieb Salvatore Bonaccorso:
>> > > Hi
>> > >=20
>> > > We got a regression report in Debian after the update from 6.1.133 to
>> > > 6.1.135. Melvin is reporting that discard/trimm trhough a RAID10 arr=
ay
>> > > stalls idefintively. The full report is inlined below and originates
>> > > from https://bugs.debian.org/1104460 .
>> >=20
>> > JFTR, we ran into the same problem with a few Wikimedia servers running
>> > 6.1.135 and RAID 10: The servers started to lock up once fstrim.service
>> > got started. Full oops messages are available at
>> > https://phabricator.wikimedia.org/P75746
>>=20
>> Thanks for this aditional datapoints. Assuming you wont be able to
>> thest the other stable series where the commit d05af90d6218
>> ("md/raid10: fix missing discard IO accounting") went in, might you at
>> least be able to test the 6.1.y branch with the commit reverted again
>> and manually trigger the issue?
>>=20
>> If needed I can provide a test Debian package of 6.1.135 (or 6.1.137)
>> with the patch reverted.=20
>
> So one additional data point as several Debian users were reporting
> back beeing affected: One user did upgrade to 6.12.25 (where the
> commit was backported as well) and is not able to reproduce the issue
> there.

That would be me.

I can reproduce the issue as outlined by Moritz above fairly reliably in
6.1.135 (debian package 6.1.0-34-amd64). The reproducer is simple, on a
RAID-10 host:

 1. reboot
 2. systemctl start fstrim.service

We're tracking the issue internally in:

https://gitlab.torproject.org/tpo/tpa/team/-/issues/42146

I've managed to workaround the issue by upgrading to the Debian package
from testing/unstable (6.12.25), as Salvatore indicated above. There,
fstrim doesn't cause any crash and completes successfully. In stable, it
just hangs there forever. The kernel doesn't completely panic and the
machine is otherwise somewhat still functional: my existing SSH
connection keeps working, for example, but new ones fail. And an `apt
install` of another kernel hangs forever.

> This indicates we might miss some pre-requisites in the 6.1.y series?
>
> user is trying now the 6.1.135 with patch reverted as well.

I am embarrassed to say I couldn't figure out how to build a Debian
package of the Linux kernel at the moment. I would be happy to test a
built package, that said. I got stock in various snags: the
`debian/bin/test-patches` script seem to require a flavor (worked around
with `-f amd64`) and in the end the build failed with:

[...]

  ld -r -m elf_x86_64 -z noexecstack --no-warn-rwx-segments --build-id=3Dsh=
a1  -T scripts/module.lds -o virt/lib/irqbypass.ko virt/lib/irqbypass.o vir=
t/lib/irqbypass.mod.o;  true
debian/bin/buildcheck.py debian/build/build_amd64_none_amd64 amd64 none amd=
64
Can't read ABI reference.  ABI not checked!
make[2]: Leaving directory '/home/anarcat/dist/linux-6.1.135'
/usr/bin/make -f debian/rules.real build_kbuild ABINAME=3D'6.1.0-0.a.test' =
ARCH=3D'amd64' DESTDIR=3D'/home/anarcat/dist/linux-6.1.135/debian/linux-kbu=
ild-6.1' DH_OPTIONS=3D'-plinux-kbuild-6.1' KERNEL_ARCH=3D'x86' PACKAGE_NAME=
=3D'linux-kbuild-6.1' SOURCEVERSION=3D'6.1.135-1a~test' SOURCE_BASENAME=3D'=
linux' SOURCE_SUFFIX=3D'' UPSTREAMVERSION=3D'6.1' VERSION=3D'6.1'
make[2]: Entering directory '/home/anarcat/dist/linux-6.1.135'
mkdir -p debian/build/build-tools/headers-tools
/usr/bin/make ARCH=3Dx86 O=3Ddebian/build/build-tools/headers-tools \
	INSTALL_HDR_PATH=3D/home/anarcat/dist/linux-6.1.135/debian/build/build-too=
ls \
	headers_install
make[3]: Entering directory '/home/anarcat/dist/linux-6.1.135'
***
*** Configuration file ".config" not found!
***
*** Please run some configurator (e.g. "make oldconfig" or
*** "make menuconfig" or "make xconfig").
***
/home/anarcat/dist/linux-6.1.135/Makefile:792: include/config/auto.conf.cmd=
: No such file or directory
make[4]: *** [/home/anarcat/dist/linux-6.1.135/Makefile:801: .config] Error=
 1
make[3]: *** [Makefile:250: __sub-make] Error 2
make[3]: Leaving directory '/home/anarcat/dist/linux-6.1.135'
make[2]: *** [debian/rules.real:530: debian/stamps/build-tools-headers] Err=
or 2
make[2]: Leaving directory '/home/anarcat/dist/linux-6.1.135'
make[1]: *** [debian/rules.gen:1471: build-arch_amd64_real_kbuild] Error 2
make[1]: Leaving directory '/home/anarcat/dist/linux-6.1.135'
make: *** [debian/rules:40: build-arch] Error 2
dpkg-buildpackage: error: debian/rules binary subprocess returned exit stat=
us 2

It's been a while since I compiled linux, amazingly... It might be
because I'm trying to compile the Debian 12 kernel on Debian 13. Here
are the steps I took:

curl -o 4a05f7ae33716d996c5ce56478a36a3ede1d76f2.patch https://git.kernel.o=
rg/pub/scm/linux/kernel/git/stable/linux.git/patch/?id=3D4a05f7ae33716d996c=
5ce56478a36a3ede1d76f2
# (reverse the patch)
sudo apt-get build-dep linux
apt source -t bookworm-security linux
./debian/bin/test-patches -f amd64 ../4a05f7ae33716d996c5ce56478a36a3ede1d7=
6f2.patch

a.

--=20
Life is like riding a bicycle. To keep your balance you must keep moving.
                       - Albert Einstein

