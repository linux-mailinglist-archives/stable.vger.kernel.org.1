Return-Path: <stable+bounces-141757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A223BAABB5B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 09:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C69B5A0885
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D05420FAAB;
	Tue,  6 May 2025 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mSi1HaHN"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D922171F;
	Tue,  6 May 2025 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746511255; cv=none; b=huCXG6sfWZyoxKTaVjQ+E9fRUZx9Z/5+GrNgAMLlDGu1j0oiqA2JhANoywBXe6lA8sseJogwFUZ4m8i4JyJA+Lg5haV0Pj9OAtOJUXO83/83T1NqxGYNu145U2LsPadugliXOa+dUIhv3WmRvI8xSXZZiNZ5m6IlEU81qgN6ndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746511255; c=relaxed/simple;
	bh=GROdywZ8YBRec/AsJMZZfsoIODdMnN2FHFKBcooazy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEUbpjhjoAus0A/HKrTS0s4o3uk5zkXzKKOtmnS6Erfk2A+ZFf8TRlwuuGxeU/t1OJILR4yYnN0Upez9hdxFB8ug8iLYl6yMEOEq+ivQs7O8olIGWoM0/fsreJ9Ji3qHvsDXOlSheT7Z68LW8D5Q94LxPU4/PBZ4fx/MFvHfnHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mSi1HaHN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=0FNgazr5MCaOSM1jI/t90vOh6eJipsy8lWu0RtaYTUY=; b=mSi1HaHNSp8h4lKzvEQvG4FYqN
	I3V07E0JZTpLwCNJ0mdHKw/5Lzw3C8CTHfF44UeWa46co95AttuSwXC1eDP5YqYDIZRrxlvRmbIU0
	zhSVHQoRFFD49iglQMN4pVbHpa32n3fUuTbYNN5HVx8J8IXTfimM6GW5TIFPNEIt0T9WSaXLebKtO
	MvASGay82CcLLetqPVkIVrPDZlTisjP+GHCx3UGDZ6hRlGEei4jnXCqoT3BYPKcWVj7YG1ACdb4BA
	fDHuLYm5j9VxUUPreClMNGmex5NBSVDJBeqzNuUI4T14z7vUFu+Qwkyt74pPUSbcv1cq8t0IuuZlr
	OV2R4o7g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1uCBM3-004R2F-D0; Tue, 06 May 2025 06:00:36 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 3876EBE2DE0; Tue, 06 May 2025 08:00:34 +0200 (CEST)
Date: Tue, 6 May 2025 08:00:34 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Yu Kuai <yukuai1@huaweicloud.com>, 1104460@bugs.debian.org
Cc: Antoine =?iso-8859-1?Q?Beaupr=E9?= <anarcat@debian.org>,
	Moritz =?iso-8859-1?Q?M=FChlenhoff?= <jmm@inutil.org>,
	Melvin Vermeeren <vermeeren@vermwa.re>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Coly Li <colyli@kernel.org>, Sasha Levin <sashal@kernel.org>,
	stable <stable@vger.kernel.org>, regressions@lists.linux.dev,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: Bug#1104460: [regression 6.1.y] discard/TRIM through RAID10
 blocking
Message-ID: <aBmlgkHrbTYzwjj4@eldamar.lan>
References: <aBilQxLZ4MA4Tg8e@pisco.westfalen.local>
 <aBjEf5R7X9GaJg2T@eldamar.lan>
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBjhHUjtXRotZUVa@eldamar.lan>
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <875xiex56v.fsf@angela.anarc.at>
 <aBkhNwVVs_KwgQ1a@eldamar.lan>
 <87zffqvknw.fsf@angela.anarc.at>
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <4762cbe1-30a2-e5cd-52e1-f2de7714da1e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4762cbe1-30a2-e5cd-52e1-f2de7714da1e@huaweicloud.com>
X-Debian-User: carnil

Hi Yu,

Thanks for your followups.

On Tue, May 06, 2025 at 09:25:50AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/05/06 4:59, Antoine Beaupré 写道:
> > On 2025-05-05 22:36:07, Salvatore Bonaccorso wrote:
> > > Hi Antoine,
> > > 
> > > On Mon, May 05, 2025 at 02:50:32PM -0400, Antoine Beaupré wrote:
> > > > On 2025-05-05 18:02:37, Salvatore Bonaccorso wrote:
> > > > > On Mon, May 05, 2025 at 04:00:31PM +0200, Salvatore Bonaccorso wrote:
> > > > > > Hi Moritz,
> > > > > > 
> > > > > > On Mon, May 05, 2025 at 01:47:15PM +0200, Moritz Mühlenhoff wrote:
> > > > > > > Am Wed, Apr 30, 2025 at 05:55:20PM +0200 schrieb Salvatore Bonaccorso:
> > > > > > > > Hi
> > > > > > > > 
> > > > > > > > We got a regression report in Debian after the update from 6.1.133 to
> > > > > > > > 6.1.135. Melvin is reporting that discard/trimm trhough a RAID10 array
> > > > > > > > stalls idefintively. The full report is inlined below and originates
> > > > > > > > from https://bugs.debian.org/1104460 .
> > > > > > > 
> > > > > > > JFTR, we ran into the same problem with a few Wikimedia servers running
> > > > > > > 6.1.135 and RAID 10: The servers started to lock up once fstrim.service
> > > > > > > got started. Full oops messages are available at
> > > > > > > https://phabricator.wikimedia.org/P75746
> > > > > > 
> > > > > > Thanks for this aditional datapoints. Assuming you wont be able to
> > > > > > thest the other stable series where the commit d05af90d6218
> > > > > > ("md/raid10: fix missing discard IO accounting") went in, might you at
> > > > > > least be able to test the 6.1.y branch with the commit reverted again
> > > > > > and manually trigger the issue?
> > > > > > 
> > > > > > If needed I can provide a test Debian package of 6.1.135 (or 6.1.137)
> > > > > > with the patch reverted.
> > > > > 
> > > > > So one additional data point as several Debian users were reporting
> > > > > back beeing affected: One user did upgrade to 6.12.25 (where the
> > > > > commit was backported as well) and is not able to reproduce the issue
> > > > > there.
> > > > 
> > > > That would be me.
> > > > 
> > > > I can reproduce the issue as outlined by Moritz above fairly reliably in
> > > > 6.1.135 (debian package 6.1.0-34-amd64). The reproducer is simple, on a
> > > > RAID-10 host:
> > > > 
> > > >   1. reboot
> > > >   2. systemctl start fstrim.service
> > > > 
> > > > We're tracking the issue internally in:
> > > > 
> > > > https://gitlab.torproject.org/tpo/tpa/team/-/issues/42146
> > > > 
> > > > I've managed to workaround the issue by upgrading to the Debian package
> > > > from testing/unstable (6.12.25), as Salvatore indicated above. There,
> > > > fstrim doesn't cause any crash and completes successfully. In stable, it
> > > > just hangs there forever. The kernel doesn't completely panic and the
> > > > machine is otherwise somewhat still functional: my existing SSH
> > > > connection keeps working, for example, but new ones fail. And an `apt
> > > > install` of another kernel hangs forever.
> > > 
> > > So likely at least in 6.1.y there are missing pre-requisites causing
> > > the behaviour.
> > > 
> > > If you can test 6.1.135-1 with the commit
> > > 4a05f7ae33716d996c5ce56478a36a3ede1d76f2 reverted then you can fetch
> > > built packages at:
> > > 
> > > https://people.debian.org/~carnil/tmp/linux/1104460/
> 
> Can you also test with 4a05f7ae33716d996c5ce56478a36a3ede1d76f2 not
> reverted, and also cherry-pick c567c86b90d4715081adfe5eb812141a5b6b4883?

Thank you.

Antoine, Moritz,
https://people.debian.org/~carnil/tmp/linux/1104460-2/ contains a
build with 4a05f7ae33716d996c5ce56478a36a3ede1d76f2 *not* reverted and
with c567c86b90d4715081adfe5eb812141a5b6b4883 cherry-picked, can you
test this one as well?

Regards,
Salvatore

