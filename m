Return-Path: <stable+bounces-141841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDE1AAC973
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 17:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A227B92CF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F77283C9C;
	Tue,  6 May 2025 15:24:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from victorique.vermwa.re (victorique.vermwa.re [5.255.86.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9E3283C94
	for <stable@vger.kernel.org>; Tue,  6 May 2025 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.255.86.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746545060; cv=none; b=U1Tyc476W5cDStl4e+IkrlegUCYLYlDsfSW+a3BjVgnyiOYJzct1NvluqVLLdllB41CgUIB1GLajgSgub1Np3FSErgMvmM4lvE4OvrGfG36oDJ50zKWgV+qNi+LC5L/6JlA/VvLHNtEhn7yyqEmkysb87xjZU37tdIP22HIW0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746545060; c=relaxed/simple;
	bh=0mynB4iGh4NmJ0VBWm5ypjuurHH13dAj+fnzLZQA75s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puX1nl0uiLsU5l9gk/z0kwwfMhMacM5p0a+kl+2SGQW+OACFXe9D2sl66HDyuvxmZZ3eYdDuB15FPHMFYpBeVcQJQ7craEZpuCPf31Hu4qrolw4L/qf1SD+Xn8sWI9+W2y5WVVaSB6MSS8AQubqbpERVIoOjAQ3zd2/MpPDvXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vermwa.re; spf=pass smtp.mailfrom=vermwa.re; arc=none smtp.client-ip=5.255.86.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vermwa.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vermwa.re
Received: from victorique.vermwa.re (localhost [IPv6:::1])
	by victorique.vermwa.re (Postfix) with ESMTP id 5B47CA00BC;
	Tue,  6 May 2025 17:16:21 +0200 (CEST)
Received: from verm-r4e.localnet ([fd17:3171:f888:364d::1000])
	by victorique.vermwa.re with ESMTPSA
	id kPX4FMUnGmhu2wgAjH0QZw
	(envelope-from <vermeeren@vermwa.re>); Tue, 06 May 2025 17:16:21 +0200
From: Melvin Vermeeren <vermeeren@vermwa.re>
To: Yu Kuai <yukuai3@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Salvatore Bonaccorso <carnil@debian.org>
Cc: 1104460@bugs.debian.org, Coly Li <colyli@kernel.org>,
 Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
 regressions@lists.linux.dev
Subject:
 Re: [regression 6.1.y] discard/TRIM through RAID10 blocking (was: Re:
 Bug#1104460: linux-image-6.1.0-34-powerpc64le: Discard broken) with RAID10:
 BUG: kernel tried to execute user page (0) - exploit attempt?
Date: Tue, 06 May 2025 17:16:15 +0200
Message-ID: <4657023.LvFx2qVVIh@verm-r4e>
Organization: vermware
In-Reply-To: <aBJH6Nsh-7Zj55nN@eldamar.lan>
References:
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBJH6Nsh-7Zj55nN@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2375347.ElGaqSPkdT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2375347.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Melvin Vermeeren <vermeeren@vermwa.re>
Date: Tue, 06 May 2025 17:16:15 +0200
Message-ID: <4657023.LvFx2qVVIh@verm-r4e>
Organization: vermware
In-Reply-To: <aBJH6Nsh-7Zj55nN@eldamar.lan>
MIME-Version: 1.0

Hi Salvatore,

I had been unexpectedly busy the past week, caught up to all the mails just 
now. Many thanks to everyone involved and the additional information from 
several people, am happy to see it.

On Wednesday, 30 April 2025 17:55:20 Central European Summer Time Salvatore 
Bonaccorso wrote:
> Melvin, the same change went as well in other stable series, 6.6.88,
> 6.12.25, 6.14.4, can you test e.g. 6.12.25-1 in Debian as well from
> unstable to see if the regression is there as well?

Specifically for this, I did just now test this with Debian testing's 
6.12.25-1, albeit on amd64 instead of ppc64le, with an identical storage 
layout and can confirm the issue does *not* exist there.

This confirms what others already discovered by now, I agree with the findings 
and have nothing to add specifically.

Thanks again to all,

-- 
Melvin Vermeeren
Systems engineer
--nextPart2375347.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiu1YAh/qzdXye6Dmpy9idxbqnZYFAmgaJ78ACgkQpy9idxbq
nZZCSw//Tdvc2ZE1nRA2KU7URHqkRIaXInr3PJkPpxb1uAfogjZI9Gku31jX+4f5
j4BSv0i/RPBIOo+THXMrgwBPHEs4eMY8JDiuXkLS2jj7p7VQdDlBqZG06MxGArGg
VehqHf2dQVV7L0XdTb/kJfmT5HEUVikZKN+aDL+iBdFdw6x38ncimYiGbeaC3JKB
NwWuOnYoNokDsaGjX59cV84p8TnBTL+ev1K3ghVJ1gdT0bNC+cgH8hpwAZ+/5Mey
9jmX00mFizQSbx/goQk3SB4NzqlTSPn5k17WL/XNxHCVim4soelTfREUzTGSXKfz
9WCxJxJEPk3ejAq4Ncd3D4Nm8yKxmtI9egeXAXXz5Ys+DvEdCsBr4JrvhXttlqag
8Eyv/Nym/sTSo0zYvnAXK8+DIvByOnR2XlSuG3nObNxm3eSBIHCqA1xyI/1D+rgg
y6iYwCRiXEdMS3E12lp33+CoPCIhLjD52ESsx1ycxxgzA/3QdGfMZayZPyuWqV87
xQC9HJpGj1bM97hw6hBFe2qxqPCrbNiC7GymrFt3Q1A47+jfhttu7rHRxg6bxF/B
2reM9emRPT/np2wlAB3/9tc+xR4d97Cii4P7fruyBs0ntcHWzx3vCb4SdwQa6R/k
eTTwX41teU9hkQLIG5pPHg57HGmZHhVJJu7Plb88jKRXj9MDBQg=
=ogZ0
-----END PGP SIGNATURE-----

--nextPart2375347.ElGaqSPkdT--




