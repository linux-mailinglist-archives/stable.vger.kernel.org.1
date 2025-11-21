Return-Path: <stable+bounces-196492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30FC7A40F
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5766A2E3AD
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A1034F476;
	Fri, 21 Nov 2025 14:44:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CD834F248
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736246; cv=none; b=AgdDDqmJNhur+lal9B3LILUXSr/pzhwY5TLGF4hBk8oeJDaBKrsbYIEM3eiXTqHGJRCoV2LfUNqPwaGeU6qantBrsLr/aYbrUpLdA9TezyzszmZB/MfkdXJ+COBTBIpLFw4hK1PjndU51k3i2/Wlr3c6CR6Xp2deVhFuZchY4Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736246; c=relaxed/simple;
	bh=9WhdmzrNR75SJj66Oi8EiDfi3N/BJfAMnQlT3rBdzKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lamB1NfGE6Tv+DB9l3mHtEpLWn6QPgEq/OJ1aw34U15dKo5fenl+vECxYQgFSihGk7iCbyqIk4OMbDXSFpYzSnMlsX8rwZ8Ga+EakZKgDyboicVQOOTL1QSzpFR1ikWw6u9XNp/UnMpoV4LXNbm71gNrw4xyRV0mQfdlFYd0ZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vMSMY-0004yx-Tc; Fri, 21 Nov 2025 15:43:50 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vMSMY-001bRQ-1C;
	Fri, 21 Nov 2025 15:43:50 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vMSMY-000000008Mu-1CTg;
	Fri, 21 Nov 2025 15:43:50 +0100
Message-ID: <6e9f1b4dceefe29ed10e81e0fbf0fc9155f33fd1.camel@pengutronix.de>
Subject: Re: [PATCH] platform/x86: intel: chtwc_int33fe: don't dereference
 swnode args
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Charles Keepax
 <ckeepax@opensource.cirrus.com>, 	platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, 	stable@vger.kernel.org, Hans de Goede
 <hansg@kernel.org>, Stephen Rothwell	 <sfr@canb.auug.org.au>
Date: Fri, 21 Nov 2025 15:43:50 +0100
In-Reply-To: <CAMRc=MdSai2EaQfAqjxdmLBdXPQVc8s4b5_sKDmuZV8gBCKp4g@mail.gmail.com>
References: <20251121-int33fe-swnode-fix-v1-1-713e7b7c6046@linaro.org>
	 <58fdb603-6d42-443d-8ae6-57aced9eb104@kernel.org>
	 <CAMRc=MdSai2EaQfAqjxdmLBdXPQVc8s4b5_sKDmuZV8gBCKp4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Hi Bartosz,

On Fr, 2025-11-21 at 14:50 +0100, Bartosz Golaszewski wrote:
> On Fri, Nov 21, 2025 at 2:40=E2=80=AFPM Hans de Goede <hansg@kernel.org> =
wrote:
> >=20
> > On 21-Nov-25 11:04 AM, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >=20
> > > Members of struct software_node_ref_args should not be dereferenced
> > > directly but set using the provided macros. Commit d7cdbbc93c56
> > > ("software node: allow referencing firmware nodes") changed the name =
of
> > > the software node member and caused a build failure. Remove all direc=
t
> > > dereferences of the ref struct as a fix.
> > >=20
> > > However, this driver also seems to abuse the software node interface =
by
> > > waiting for a node with an arbitrary name "intel-xhci-usb-sw" to appe=
ar
> > > in the system before setting up the reference for the I2C device, whi=
le
> > > the actual software node already exists in the intel-xhci-usb-role-sw=
itch
> > > module and should be used to set up a static reference. Add a FIXME f=
or
> > > a future improvement.
> > >=20
> > > Fixes: d7cdbbc93c56 ("software node: allow referencing firmware nodes=
")
> > > Fixes: 53c24c2932e5 ("platform/x86: intel_cht_int33fe: use inline ref=
erence properties")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Closes: https://lore.kernel.org/all/20251121111534.7cdbfe5c@canb.auug=
.org.au/
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > > This should go into the reset tree as a fix to the regression introdu=
ced
> > > by the reset-gpio driver rework.
> >=20
> > Thanks, patch looks good to me:
> >=20
> > Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> >=20
> > Also ack for merging this through the reset tree.
> >=20
> > Ilpo please do *not* pick this one up as it will be merged
> > through the reset tree.
> >=20
>=20
> Philipp: I'm afraid this too must go into an immutable branch shared
> with the GPIO tree or else Linus Torvalds will yell at me if by chance
> he pulls my changes first into mainline. Unless you plan to do your PR
> early into the merge window in which case I can wait until it's in his
> tree and submit mine. Let me know what your preference is.

The following changes since commit 5fc4e4cf7a2268b5f73700fd1e8d02159f2417d8=
:

  reset: gpio: use software nodes to setup the GPIO lookup (2025-11-20 16:5=
1:49 +0100)

are available in the Git repository at:

  https://git.pengutronix.de/git/pza/linux.git tags/reset-gpio-for-v6.19-2

for you to fetch changes up to 527250cd9092461f1beac3e4180a4481bffa01b5:

  platform/x86: intel: chtwc_int33fe: don't dereference swnode args (2025-1=
1-21 15:31:43 +0100)

----------------------------------------------------------------
Reset/GPIO/swnode changes for v6.19 (v2)

* Fix chtwc_int33fe build issue since commit d7cdbbc93c56 ("software
  node: allow referencing firmware nodes").

----------------------------------------------------------------
Bartosz Golaszewski (1):
      platform/x86: intel: chtwc_int33fe: don't dereference swnode args

 drivers/platform/x86/intel/chtwc_int33fe.c | 29 ++++++++++++++++++++------=
---
 1 file changed, 20 insertions(+), 9 deletions(-)

