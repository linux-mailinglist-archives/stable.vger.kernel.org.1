Return-Path: <stable+bounces-111998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF10AA25606
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 10:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA36E18883D5
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D94A1FF605;
	Mon,  3 Feb 2025 09:39:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB42C1FF5F5
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575542; cv=none; b=b/clxg1cGKiIVPC9/gJPKfF70D/WfLuQnPgzqUhNz8TZXcyL43jZfDIVESGXMmBqWYC8BZiLeWWYKk1DUqODzXKRD47YjQElZ8Tb+9aC7JS/WwyLA9WpUOI2GuPqLgPUM6pJ6dN1oyYX6wvEV2w1EkkAVR/G0Zgwdyym71Nsgb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575542; c=relaxed/simple;
	bh=0nyPl/kSKHa4REQMrrkWsc4mikE3zQ4vW5XaIErpAfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DYFRjDV2UhPlz/djk7xDnUToRDy9PHJAq7CJRhGyqvbpbZLOfB+ignMdCEbNwW/0bYT+SE7/XDVZt4C/qjvquI9x55LwI2cwfki7/GdbfpWUdDkTvvRcF40PB4UKnGDnS9bGLolANQWSY9/h0w2kUOj+4a0zjidWicL6w0qPE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tesuv-0003us-Vp; Mon, 03 Feb 2025 10:38:58 +0100
Message-ID: <8e8bc70b7d55054738dec6628e184943f78d3c6c.camel@pengutronix.de>
Subject: Re: Patch "drm/etnaviv: Drop the offset in page manipulation" has
 been added to the 6.12-stable tree
From: Lucas Stach <l.stach@pengutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
 sui.jingfeng@linux.dev, Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Date: Mon, 03 Feb 2025 10:38:57 +0100
In-Reply-To: <2025020354-helpless-tiring-9fc5@gregkh>
References: <20250202043355.1913248-1-sashal@kernel.org>
	 <d8b6c3b4eda513277f19640c8f792c6d70b03f06.camel@pengutronix.de>
	 <2025020354-helpless-tiring-9fc5@gregkh>
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

Am Montag, dem 03.02.2025 um 10:29 +0100 schrieb Greg KH:
> On Mon, Feb 03, 2025 at 09:59:56AM +0100, Lucas Stach wrote:
> > Hi Sasha,
> >=20
> > Am Samstag, dem 01.02.2025 um 23:33 -0500 schrieb Sasha Levin:
> > > This is a note to let you know that I've just added the patch titled
> > >=20
> > >     drm/etnaviv: Drop the offset in page manipulation
> > >=20
> > > to the 6.12-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-que=
ue.git;a=3Dsummary
> > >=20
> > > The filename of the patch is:
> > >      drm-etnaviv-drop-the-offset-in-page-manipulation.patch
> > > and it can be found in the queue-6.12 subdirectory.
> > >=20
> > > If you, or anyone else, feels it should not be added to the stable tr=
ee,
> > > please let <stable@vger.kernel.org> know about it.
> > >=20
> > please drop this patch and all its dependencies from all stable queues.
> >=20
> > While the code makes certain assumptions that are corrected in this
> > patch, those assumptions are always true in all use-cases today. I
> > don't see a reason to introduce this kind of churn to the stable trees
> > to fix a theoretical issue.
>=20
> Maybe in the future, for "theoretical issues", please don't put a
> "Fixes:" tag on them?

Agreed. This tag slipped through when I applied this patch, I'll be
more careful next time.

Regards,
Lucas

