Return-Path: <stable+bounces-139720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11882AA9839
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 18:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C2B17ABB0
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2355825CC62;
	Mon,  5 May 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="u+m3Xjz7"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5915AF6;
	Mon,  5 May 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460977; cv=none; b=DqrSUSzsYBRnHP+Izpbq5OUFnU+xQVCY6m9fh8AvKG7C/OFZkOwmKSLFN/YGT0kaAH/e4+cRD1fhr5MIN9wgMedhrg3sWW0okPylSmveOZUzU6Mkiy4kgZZsv0Nl2CKtut/ksARrBP/CgGR+sNImX3/BHO5E44sHsI71GBJ09O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460977; c=relaxed/simple;
	bh=SGQ85kR/Wu8LXeCpvn4jaojGos2dxjuusa3HPfu9zjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBeySHTonN8xoMe6XIe48DLayoEwG/Dpww4XFk4cMkVi1RDZxbshylGO6lT9ERtliOGi/FhyjoBJKqcdve8avwKKvqSWlIyI+aY00HFc6ZwgVs0HaR3mlXyawsnVRjnLqsXh2nbPZCxciXqmLfEWfJjBCrEYExxeDxhrux8JoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=u+m3Xjz7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=b0WW3d9I9jUVZTy7eDrM32r61wBGMgqX3tU0kL+chbA=; b=u+m3Xjz7BnOyt94vWcKjIobtow
	nGhnBEmWj0tpRuyq3tcj7c7CFHTGJasYGSpmP2+WM1na5tPYzrdHNML7aUPEVwIQFgzuI2VWz2oMc
	8AAkpBw/ABwZMYkYo6yTeVrQ/ydlvYgLMYcML8EgTBmhkn5GWO9x7XmC4PuXmch5mgMoGmaNDisrg
	Dntp+tdDnQsRwmRsKu4vT7MlC0HPIZFJE5e/XeEduUr44jlSc1MV3hYkID4aOGxv7hI7kiEvz3KOW
	kfsFzfbQ1F9D8blZ3EYDbLUpWyHUXNkanvzN5nL/ONfp+uU+zCTQOKiUiCE6PVGoC6McgOejeR4Rl
	napsIZXQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1uByH8-003uHO-Ps; Mon, 05 May 2025 16:02:39 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id B71E6BE2DE0; Mon, 05 May 2025 18:02:37 +0200 (CEST)
Date: Mon, 5 May 2025 18:02:37 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Moritz =?iso-8859-1?Q?M=FChlenhoff?= <jmm@inutil.org>,
	Yu Kuai <yukuai3@huawei.com>
Cc: Melvin Vermeeren <vermeeren@vermwa.re>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	1104460@bugs.debian.org, Coly Li <colyli@kernel.org>,
	Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
	regressions@lists.linux.dev
Subject: Re: [regression 6.1.y] discard/TRIM through RAID10 blocking (was:
 Re: Bug#1104460: linux-image-6.1.0-34-powerpc64le: Discard broken) with
 RAID10: BUG: kernel tried to execute user page (0) - exploit attempt?
Message-ID: <aBjhHUjtXRotZUVa@eldamar.lan>
References: <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBJH6Nsh-7Zj55nN@eldamar.lan>
 <aBilQxLZ4MA4Tg8e@pisco.westfalen.local>
 <aBjEf5R7X9GaJg2T@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBjEf5R7X9GaJg2T@eldamar.lan>
X-Debian-User: carnil

On Mon, May 05, 2025 at 04:00:31PM +0200, Salvatore Bonaccorso wrote:
> Hi Moritz,
> 
> On Mon, May 05, 2025 at 01:47:15PM +0200, Moritz Mühlenhoff wrote:
> > Am Wed, Apr 30, 2025 at 05:55:20PM +0200 schrieb Salvatore Bonaccorso:
> > > Hi
> > > 
> > > We got a regression report in Debian after the update from 6.1.133 to
> > > 6.1.135. Melvin is reporting that discard/trimm trhough a RAID10 array
> > > stalls idefintively. The full report is inlined below and originates
> > > from https://bugs.debian.org/1104460 .
> > 
> > JFTR, we ran into the same problem with a few Wikimedia servers running
> > 6.1.135 and RAID 10: The servers started to lock up once fstrim.service
> > got started. Full oops messages are available at
> > https://phabricator.wikimedia.org/P75746
> 
> Thanks for this aditional datapoints. Assuming you wont be able to
> thest the other stable series where the commit d05af90d6218
> ("md/raid10: fix missing discard IO accounting") went in, might you at
> least be able to test the 6.1.y branch with the commit reverted again
> and manually trigger the issue?
> 
> If needed I can provide a test Debian package of 6.1.135 (or 6.1.137)
> with the patch reverted. 

So one additional data point as several Debian users were reporting
back beeing affected: One user did upgrade to 6.12.25 (where the
commit was backported as well) and is not able to reproduce the issue
there.

This indicates we might miss some pre-requisites in the 6.1.y series?

user is trying now the 6.1.135 with patch reverted as well.

Regards,
Salvatore

