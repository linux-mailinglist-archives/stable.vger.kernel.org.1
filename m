Return-Path: <stable+bounces-61857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB0493D0BF
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 12:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C70D1C21858
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1987A178CD9;
	Fri, 26 Jul 2024 10:00:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696FE178CC5;
	Fri, 26 Jul 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988028; cv=none; b=a6leQzghac2e0vVgZbtP2n82mMitmrQBfDk6du964ljcJ9ATkm1iU/0ck29zaHrPL0evGwOWyTsdW6c8AdhRkZreiAXo4XGFoobd2YqESpvir+f/2YSxA/P4IwXqmIzTMHM1RvkX1jtlpefVJmAfXZY2v2OK9hz9gnvDU5EgBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988028; c=relaxed/simple;
	bh=pmWoo3yBA/llgzDMtc0lskqiXHynYbPAWMHKegfYnYw=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=BLnBUpoEB+hFiPNhMjR0+3IFWE1XLnw99b2SsKQoxeCCkF158A2tI/QXjjZKRmOxBqp2AGxfABU8KLbq/+4d55h/M2s22/wU0hglBudRzUjiOpoRlM9d+i0V0svH7UrvocyCm6x83b23eNNMgWUKQCa1sLxit5GvQGWBAB8gkZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 5E9D33780BDB;
	Fri, 26 Jul 2024 10:00:25 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <2024072635-dose-ferment-53c8@gregkh>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <veJcp8NcM5qwkB_p0qsjQCFvZR5U4SqezKKMnUgM-khGFC4sCcvkodk-beWQ2a4qd3IxUYaLdGp9_GBwf3FLvkoU8f1MXjSk3gCsQOKnXZw=@protonmail.com>
 <2024072633-easel-erasure-18fa@gregkh>
 <vp205FIjWV7QqFTJ2-8mUjk6Y8nw6_9naNa31Puw1AvHK8EinlyR9vPiJdEtUgk0Aqz9xuMd62uJLq0F1ANI5OGyjiYOs3vxd0aFXtnGnJ4=@protonmail.com> <2024072635-dose-ferment-53c8@gregkh>
Date: Fri, 26 Jul 2024 11:00:25 +0100
Cc: "Jari Ruusu" <jariruusu@protonmail.com>, =?utf-8?q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, =?utf-8?q?stable=40vger=2Ekernel=2Eorg?= <stable@vger.kernel.org>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1399f9-66a37380-1-413a9280@15567367>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?5=2E10?= 00/59] 
 =?utf-8?q?5=2E10=2E223-rc1?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Friday, July 26, 2024 14:22 IST, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:

> On Fri, Jul 26, 2024 at 08:21:47AM +0000, Jari Ruusu wrote:
> > On Friday, July 26th, 2024 at 10:49, Greg Kroah-Hartman <gregkh@lin=
uxfoundation.org> wrote:
> > > On Fri, Jul 26, 2024 at 07:25:21AM +0000, Jari Ruusu wrote:
> > > > Fixes: upstream fd7eea27a3ae "Compiler Attributes: Add =5F=5Fun=
initialized macro"
> > > > Signed-off-by: Jari Ruusu jariruusu@protonmail.com
> > >=20
> > > Please submit this in a format in which we can apply it, thanks!
> >=20
> > Protonmail seems to involuntarily inject mime-poop to outgoing mail=
s.
> > Sorry about that. For the time being, the best I can do is to re-se=
nd
> > the patch as gzipped attachment.
>=20
> For obvious reasons, we can't take that either :(
>=20
> Also the "Fixes:" tag is not in the correct format, please fix that u=
p
> at the very least.
>=20
> thanks,
>=20
> greg k-h
>=20

KernelCI report for stable-rc/linux-5.10.y for this week.
Date: 2024-07-25

## Build failures:
No build failures seen for the stable-rc/linux-5.10.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-5.10.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


