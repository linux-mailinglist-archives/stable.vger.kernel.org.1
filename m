Return-Path: <stable+bounces-112007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A1DA257D4
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD313A917E
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 11:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADD6200BA9;
	Mon,  3 Feb 2025 11:15:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA14202C2F
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738581303; cv=none; b=diqgKmbG+pqEFP+rFQyprU5u1J569jCjLzme/zMnkg+5Zwc6Yxd4Gq94qhw/V6DIZdgixKn57K5taInQZOnE6s4omQ1pyAHZB4FaRWnFRItsgaJb5itsE8xA5xJzzk5O8xEJ1xPRDlE1Y4OuTt+oMJ4cXCy4Zg8d9yHlTFyA06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738581303; c=relaxed/simple;
	bh=hK/st9sAg7FJNpPevxj7qBdK0Jpxw5MjNuSQ8GD33z4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MnwcLUYeMAyEEEbZNPAMhLW/QZkOrOKjhcXnEObbJuxjB2l2HhZwX1HRH7wy1DiiJitOpW/ZyHzTT/qHqRtkKLzEgda0+7Kex+jIUD43lfMyDVxsJXjf7/xTPehdoNliI8Dr/UAQpOGmCH0yUVSV+Gq0yFxcRqRH3GrepuuCAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1teuPq-0006a1-H8; Mon, 03 Feb 2025 12:14:58 +0100
Message-ID: <ece27be6f18b700140eb338c018e291efd19f271.camel@pengutronix.de>
Subject: Re: Patch "drm/etnaviv: Drop the offset in page manipulation" has
 been added to the 6.12-stable tree
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, stable@vger.kernel.org, 
	stable-commits@vger.kernel.org
Cc: Russell King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>
Date: Mon, 03 Feb 2025 12:14:57 +0100
In-Reply-To: <2dfb1991-3030-4143-890b-83508d1b77e0@linux.dev>
References: <20250202043355.1913248-1-sashal@kernel.org>
	 <d8b6c3b4eda513277f19640c8f792c6d70b03f06.camel@pengutronix.de>
	 <2dfb1991-3030-4143-890b-83508d1b77e0@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Hi Sui,

Am Montag, dem 03.02.2025 um 18:53 +0800 schrieb Sui Jingfeng:
> Hi,
>=20
> On 2025/2/3 16:59, Lucas Stach wrote:
> > Hi Sasha,
> >=20
> > Am Samstag, dem 01.02.2025 um 23:33 -0500 schrieb Sasha Levin:
> > > This is a note to let you know that I've just added the patch titled
> > >=20
> > >      drm/etnaviv: Drop the offset in page manipulation
> > >=20
> > > to the 6.12-stable tree which can be found at:
> > >      http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-qu=
eue.git;a=3Dsummary
> > >=20
> > > The filename of the patch is:
> > >       drm-etnaviv-drop-the-offset-in-page-manipulation.patch
> > > and it can be found in the queue-6.12 subdirectory.
> > >=20
> > > If you, or anyone else, feels it should not be added to the stable tr=
ee,
> > > please let <stable@vger.kernel.org> know about it.
> > >=20
> > please drop this patch and all its dependencies from all stable queues.
> >=20
> > While the code makes certain assumptions that are corrected in this
> > patch, those assumptions are always true in all use-cases today.
>=20
> Those patches are harmless even we apply them, and after apply my pitch,
> it requires less CPU computation, right?
>=20
>=20
> > I don't see a reason
>=20
> I think, if 'sg->offset !=3D 0' could happen  or not is really matters he=
re.
> My argument was that the real data is stored at 'sg_dma_address(sg)', NOT
> the 'sg_dma_address(sg) - sg->offset'.
>=20
>=20
> As we can create a test that we store some kind of data at the middle of
> a BO by the CPU, then map this BO with the MMU and ask the GPU fetch the
> data.  Do we really have a way tell the GPU to skip the leading garbage
> data?
>=20
>=20
> > to introduce this kind of churn to the stable trees
>=20
>=20
> If I'm wrong or miss something, we can get them back, possibly with new
> features, additional description, and comments for use-cases. My argument
> just that we don't have good reasons to take the'sg->offset' into account
> for now.
>  =20
>=20
> > to fix a theoretical issue.
>=20
>=20
> The start PA of a buffer segment has been altered, but the corresponding
> VA is not.
>=20
> Maybe a approach has to guarantee correct in the theory first.

I'm aware that one could construct cases where things fall over with
the previous code. However, there is no such case in practice. I fully
agree that this issue should be fixed, which is obviously why I merged
the patch.

I do not agree to introduce churn into the stable trees and burden
myself and others to check the correctness of the backports (just
because patches do apply to the stable tree does not mean all their
prerequisites and underlying assumptions are met), to fix a theoretical
issue.

Regards,
Lucas

