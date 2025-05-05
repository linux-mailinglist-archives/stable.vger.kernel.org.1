Return-Path: <stable+bounces-139745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7814AA9DA7
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2085816CB0E
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 20:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B8925D213;
	Mon,  5 May 2025 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Z0CsbA+h"
X-Original-To: stable@vger.kernel.org
Received: from marcos.anarc.at (marcos.anarc.at [45.72.186.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F8229B0D
	for <stable@vger.kernel.org>; Mon,  5 May 2025 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.72.186.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478758; cv=none; b=f6aneU9QlS8pOglEi68xa6DOAAMpgBLl4KsJZpg0OZeZ61EEkyjjxQ7hJrxrA+7bEObkCxjtfDrnjUK5qRWq9EjeqZ/WH3CQnWgstl2qZ3FVkJEd7iY7vKkEZpzYTuWKaZJMm8BzEnF4h78HxZNMqlstdZoDsWvUo0mBiPP+jPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478758; c=relaxed/simple;
	bh=9nW6HtYmWyOs9REknxWLz+jZU6pQ/0GyddmKaiAE1FE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y3ZtDabW1Cw3ZQ7E5OR3gMnIwczdTjwksm/MKU1tE6ou9jVFC+L+cJhvX0siiyI/Eq2kd79fPgiA5C0pWc5isBEx4YwFiR58c0C1pg171012iX3boUQtTj39BJHkwCXB/6vcymUWG7VkFAjwn6DRA2HAEPI7beXwA163TOV1dlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Z0CsbA+h; arc=none smtp.client-ip=45.72.186.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DMARC-Filter: OpenDMARC Filter v1.4.2 marcos.anarc.at 88A4710E10E
Authentication-Results: marcos.anarc.at; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: marcos.anarc.at; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
	s=marcos-debian.anarcat.user; t=1746478755;
	bh=9nW6HtYmWyOs9REknxWLz+jZU6pQ/0GyddmKaiAE1FE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Z0CsbA+hHR/AcMAcGUtPMDNZTrbpgsR/8C50bYgqR30ehSh0glUiznfE7HUvuzgEP
	 v3BXjIkrXS7pQb2s9dUArUniuzClCV3mc1XS9heCnmWZiG5raENdsceQcsB7a+yEAn
	 NordgNwua9UP/bfZy5aAR2WCszH+qb2i5reJrek6Hx1lrYzFxYt46Q6aRB1y7ILC9M
	 EL543j9of2UN3j21T21pxxNU3j3tL6nkeObDVLFw3ayASHU9BvdUqZVVaBXQfUwhXf
	 8xcL7vIsoXgSE3+tIDFEji2rOeUSvU/NYH1NGJU1KNtLhkc9MJXKP0qFIHsQ4p9lW1
	 7pogLs6kf80fg==
Received: from angela.anarc.at (unknown [45.72.186.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256
	 client-signature ED25519)
	(Client CN "angela.anarc.at", Issuer "ca.anarc.at" (not verified))
	by marcos.anarc.at (Postfix) with ESMTPS id 88A4710E10E;
	Mon,  5 May 2025 16:59:15 -0400 (EDT)
Received: by angela.anarc.at (Postfix, from userid 1000)
	id 79408DFADB; Mon, 05 May 2025 16:59:15 -0400 (EDT)
From: =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To: Salvatore Bonaccorso <carnil@debian.org>, 1104460@bugs.debian.org
Cc: Moritz =?utf-8?Q?M=C3=BChlenhoff?= <jmm@inutil.org>, Yu Kuai
 <yukuai3@huawei.com>, Melvin
 Vermeeren <vermeeren@vermwa.re>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Coly Li <colyli@kernel.org>, Sasha Levin
 <sashal@kernel.org>, stable <stable@vger.kernel.org>,
 regressions@lists.linux.dev
Subject: Re: Bug#1104460: [regression 6.1.y] discard/TRIM through RAID10
 blocking (was: Re: Bug#1104460: linux-image-6.1.0-34-powerpc64le: Discard
 broken) with RAID10: BUG: kernel tried to execute user page (0) - exploit
 attempt?
In-Reply-To: <aBkhNwVVs_KwgQ1a@eldamar.lan>
Organization: Debian
References: <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBJH6Nsh-7Zj55nN@eldamar.lan> <aBilQxLZ4MA4Tg8e@pisco.westfalen.local>
 <aBjEf5R7X9GaJg2T@eldamar.lan>
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBjhHUjtXRotZUVa@eldamar.lan>
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <875xiex56v.fsf@angela.anarc.at> <aBkhNwVVs_KwgQ1a@eldamar.lan>
Date: Mon, 05 May 2025 16:59:15 -0400
Message-ID: <87zffqvknw.fsf@angela.anarc.at>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2025-05-05 22:36:07, Salvatore Bonaccorso wrote:
> Hi Antoine,
>
> On Mon, May 05, 2025 at 02:50:32PM -0400, Antoine Beaupr=C3=A9 wrote:
>> On 2025-05-05 18:02:37, Salvatore Bonaccorso wrote:
>> > On Mon, May 05, 2025 at 04:00:31PM +0200, Salvatore Bonaccorso wrote:
>> >> Hi Moritz,
>> >>=20
>> >> On Mon, May 05, 2025 at 01:47:15PM +0200, Moritz M=C3=BChlenhoff wrot=
e:
>> >> > Am Wed, Apr 30, 2025 at 05:55:20PM +0200 schrieb Salvatore Bonaccor=
so:
>> >> > > Hi
>> >> > >=20
>> >> > > We got a regression report in Debian after the update from 6.1.13=
3 to
>> >> > > 6.1.135. Melvin is reporting that discard/trimm trhough a RAID10 =
array
>> >> > > stalls idefintively. The full report is inlined below and origina=
tes
>> >> > > from https://bugs.debian.org/1104460 .
>> >> >=20
>> >> > JFTR, we ran into the same problem with a few Wikimedia servers run=
ning
>> >> > 6.1.135 and RAID 10: The servers started to lock up once fstrim.ser=
vice
>> >> > got started. Full oops messages are available at
>> >> > https://phabricator.wikimedia.org/P75746
>> >>=20
>> >> Thanks for this aditional datapoints. Assuming you wont be able to
>> >> thest the other stable series where the commit d05af90d6218
>> >> ("md/raid10: fix missing discard IO accounting") went in, might you at
>> >> least be able to test the 6.1.y branch with the commit reverted again
>> >> and manually trigger the issue?
>> >>=20
>> >> If needed I can provide a test Debian package of 6.1.135 (or 6.1.137)
>> >> with the patch reverted.=20
>> >
>> > So one additional data point as several Debian users were reporting
>> > back beeing affected: One user did upgrade to 6.12.25 (where the
>> > commit was backported as well) and is not able to reproduce the issue
>> > there.
>>=20
>> That would be me.
>>=20
>> I can reproduce the issue as outlined by Moritz above fairly reliably in
>> 6.1.135 (debian package 6.1.0-34-amd64). The reproducer is simple, on a
>> RAID-10 host:
>>=20
>>  1. reboot
>>  2. systemctl start fstrim.service
>>=20
>> We're tracking the issue internally in:
>>=20
>> https://gitlab.torproject.org/tpo/tpa/team/-/issues/42146
>>=20
>> I've managed to workaround the issue by upgrading to the Debian package
>> from testing/unstable (6.12.25), as Salvatore indicated above. There,
>> fstrim doesn't cause any crash and completes successfully. In stable, it
>> just hangs there forever. The kernel doesn't completely panic and the
>> machine is otherwise somewhat still functional: my existing SSH
>> connection keeps working, for example, but new ones fail. And an `apt
>> install` of another kernel hangs forever.
>
> So likely at least in 6.1.y there are missing pre-requisites causing
> the behaviour.
>
> If you can test 6.1.135-1 with the commit
> 4a05f7ae33716d996c5ce56478a36a3ede1d76f2 reverted then you can fetch
> built packages at:
>
> https://people.debian.org/~carnil/tmp/linux/1104460/

I can confirm this kernel does not crash when running fstrim.service,
which seems to confirm the bisect.

A.

--=20
Drowning people
Sometimes die
Fighting their rescuers.
                        - Octavia Butler

