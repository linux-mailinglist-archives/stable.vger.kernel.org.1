Return-Path: <stable+bounces-148319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080EBAC957D
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 20:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BDD1677D1
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 18:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64F925CC57;
	Fri, 30 May 2025 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Rfp3/mBz"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E51A2396
	for <stable@vger.kernel.org>; Fri, 30 May 2025 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628567; cv=none; b=aJ1S7Kox6WBM1uzTI7H9f6w7vnJH+hQTJMruBP6PGxqQqyyVaF3hvYBVdPSTPx5ox/Pq34w3BXuVMUPwwVHe+rgIAUIKKO65QHyiRjKMK4c/N5ole3YOhFgiiVXWnygbApUB/fXDNS3UK9InEc9T5ZY/GnylExKgjXaaC+4MqHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628567; c=relaxed/simple;
	bh=NP0MMzyd6VF/3wnKqWKh2UqZC7e5i0BQVhfGIt2+OUw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m91HsgyD1MCP9NVbjjxxCa8psQ3F7pSutv1BP3ekN4OzF/ePxweGoZD2M1rOAHdyFEkiV2iJlr6r7UeRbut1GSw0sTeZzIgP0waObXNG8dif6YgGGiQE8CNqsSGF5mWNxK0h8bmFKB4A347C9jRSexDaWsqdjoBUiepU1/9TS20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Rfp3/mBz; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1748628561; x=1749233361; i=spasswolf@web.de;
	bh=NP0MMzyd6VF/3wnKqWKh2UqZC7e5i0BQVhfGIt2+OUw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Rfp3/mBzQ2JyM2HO6lIZlkcqv2UjVLpFztLy21er910zjnWo+QiqusmkgQsAP80i
	 goKkk1UBngfcwupYL01TTODW1YwZtQd/RUXDnJKJ7n/k+IbFQR2ozuf2xp11neptO
	 LBD1pFp8lpSBAJfd+5dIbsOONt0myuBKi5JYIP99BZpOC5Qnj1ZzqiOMnc1k9xpoA
	 Rcgl1VADidxNMaVW6A4vSwgUkf9yLJoJ4y2UqCwiwSvQjll4o9lk3iET0+GcmK44F
	 vUE0OgZcCqp5LmCs9Z4/4+wkXowUdMa5zyYDZvv+zGn7+kq9e/UTrWgTXbvgZrGK1
	 aTaseNVF9QM3qCMS/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MY5bV-1uNyZQ1dKH-00OwZP; Fri, 30
 May 2025 20:09:21 +0200
Message-ID: <855f2a49184cce5dd3ab375e8b40a8a492e6c610.camel@web.de>
Subject: Re: FAILED: patch "[PATCH] x86/mm/init: Handle the special case of
 device private pages" failed to apply to 5.15-stable tree
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: airlied@gmail.com, akpm@linux-foundation.org, alexander.deucher@amd.com,
 	brgerst@gmail.com, christian.koenig@amd.com, hch@lst.de, hpa@zytor.com, 
	jgross@suse.com, mingo@kernel.org, pierre-eric.pelloux-prayer@amd.com, 
	simona@ffwll.ch, torvalds@linux-foundation.org, stable@vger.kernel.org, 
	spasswolf@web.de
Date: Fri, 30 May 2025 20:09:19 +0200
In-Reply-To: <db802f71-7eed-46b1-afcc-aa926f1a1bd4@nvidia.com>
References: <2025052750-fondness-revocable-a23b@gregkh>
	 <0c1d51d3-7f25-4a7e-b97e-dc2177d6bfb6@nvidia.com>
	 <300d265c-ff6c-4e01-a841-e8925e5d6d3b@nvidia.com>
	 <2025053035-prison-lagged-0a17@gregkh>
	 <db802f71-7eed-46b1-afcc-aa926f1a1bd4@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B+U+U0vM3TfYnFQNLED8NZnn/rsIIFY9PWc/xKr9X6Cvd2WZwrC
 TYFCLk0mElRAifzqQYTPySRQ0CpD+t9AXVBI+XM4dJt8RzzlsV6oL3Hkh01HKQa5Q/z9kvs
 kUqcW7ofmSoqxJq4O1trn/h7Du7V7xGvRT5FfOIEGeX6XgcwRqvSf6ShFpoOraJy5/M1XMF
 iamlkljbaZjwnebKZtYTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A7U1Ak4t1I0=;7j9P1+zGr66kT+fWURR+YWZhnEQ
 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
 kZDGy5k2xEkcnqAhz49w==

Am Freitag, dem 30.05.2025 um 22:08 +1000 schrieb Balbir Singh:
> On 5/30/25 21:59, Greg KH wrote:
> > On Fri, May 30, 2025 at 07:54:32PM +1000, Balbir Singh wrote:
> > > On 5/28/25 08:59, Balbir Singh wrote:
> > > > On 5/28/25 02:55, gregkh@linuxfoundation.org wrote:
> > > > >=20
> > > > > The patch below does not apply to the 5.15-stable tree.
> > > > > If someone wants it applied there, or to any other stable or lon=
gterm
> > > > > tree, then please email the backport, including the original git=
 commit
> > > > > id to <stable@vger.kernel.org>.
> > > > >=20
> > > > > To reproduce the conflict and resubmit, you may use the followin=
g commands:
> > > > >=20
> > > > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable=
/linux.git/ linux-5.15.y
> > > > > git checkout FETCH_HEAD
> > > > > git cherry-pick -x 7170130e4c72ce0caa0cb42a1627c635cc262821
> > > > > # <resolve conflicts, build, test, etc.>
> > > > > git commit -s
> > > > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20=
25052750-fondness-revocable-a23b@gregkh' --subject-prefix 'PATCH 5.15.y' H=
EAD^..
> > > > >=20
> > > > > Possible dependencies:
> > > > >=20
> > > > >=20
> > > >=20
> > > > We only need it if 7ffb791423c7 gets backported. I can take a look=
 and see if we need the patch and why the application of the patch failed
> > > >=20
> > > > Balbir
> > > >=20
> > >=20
> > > Hi, Greg
> > >=20
> > > FYI: I was able to cherry pick 7170130e4c72ce0caa0cb42a1627c635cc262=
821 on top of
> > > 5.15.y (5.15.184) on my machine
> > >=20
> > > I ran the steps below
> > >=20
> > > > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable=
/linux.git/ linux-5.15.y
> > > > > git checkout FETCH_HEAD
> > > > > git cherry-pick -x 7170130e4c72ce0caa0cb42a1627c635cc262821
> > >=20
> > > I saw no conflicts. Am I missing something?
> >=20
> > Did you test build it as the instructions above asked you to do?
> >=20
> > Try it and see what happens :)
>=20
> I stopped after cherry-pick, I thought the patch failed to apply as in c=
herry-pick failed :)
> So I did not try and build it.=20
>=20
> Balbir Singh

The member pagemap in struct mhp_params was introduced in v5.19-rc1 so the=
 build fails
for v5.15.*.

Bert Karwatzki

