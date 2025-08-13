Return-Path: <stable+bounces-169305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B921B23DFC
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 03:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED2F58266A
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 01:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A651A9B58;
	Wed, 13 Aug 2025 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="+DUoT91g";
	dkim=pass (1024-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="jo1WD2we"
X-Original-To: stable@vger.kernel.org
Received: from tengu.nordisch.org (tengu.nordisch.org [138.201.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7542AB0;
	Wed, 13 Aug 2025 01:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.201.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755050294; cv=none; b=jnOhd9R2dew7aktuRoke7cJ1Sz0AGWjQPbmip2Df0aJRT3QdEea2Wxh/03l1zuH3WJiumWy1edewFtczBmPj+1oqZCMejgDKsOeC0jt2qc8VIOmX2F0huKPqe1pEj4TBdUkTaifichDoQ5CV769K71f2yw/k0QBVICn7DXCh2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755050294; c=relaxed/simple;
	bh=ww65egXf3xmsDOxMFn5xmo/qJKNvqQLX1E1u9iU3NYg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sTSzK3tC0mwTPlIRKP4uHwoOFedtfXZXNyIWk0toNISbSBi94GeAN9AuhVBt1Pg5H4fEbhIaKgqY++ZQKw8B8SJjovDuC8OHvaVOLeXZ5zVoa7yMfQjOPyqOuCKNFzgk23ikjCfFJGrQ9LocYFHQQ0XSIxH1aD+YkV1SW0IrtXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nordisch.org; spf=pass smtp.mailfrom=nordisch.org; dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b=+DUoT91g; dkim=pass (1024-bit key) header.d=nordisch.org header.i=@nordisch.org header.b=jo1WD2we; arc=none smtp.client-ip=138.201.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nordisch.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nordisch.org
Received: from [192.168.3.6] (fortress.wg.nordisch.org [192.168.3.6])
	by tengu.nordisch.org (Postfix) with ESMTPSA id 84F4C7B517E;
	Wed, 13 Aug 2025 03:58:07 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nordisch.org;
	s=tengu_ed25519; t=1755050287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4VxScubBaf06R30LUKX37cSRizUr+gJv+nQNsaCofo=;
	b=+DUoT91gS5E3LjJ8NHJKqlXSEO8MyEbrSSApsgrVH/xvMyHnTbg5JZNmRGiVLeLxrwL1Rv
	0T97s3rTms+q2gDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordisch.org;
	s=tengu_rsa; t=1755050287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4VxScubBaf06R30LUKX37cSRizUr+gJv+nQNsaCofo=;
	b=jo1WD2weP/FRXRoIC7VA5ppy8ZLQKtAekL8W6uBnMnwuYvK3mUjDJdabbZQ4NHJUBbQChn
	Sp067au4X9Js0ilJant/ROZ/vj7MaNVWVTseHbtYkgJsx/25gYK2pxobGhSZO8bNjqSfhy
	Q10mKUvTJGPAbgVsBa833CaYkMYcnRM=
Message-ID: <bea9aa71d198ba7def318e6701612dfe7358b693.camel@nordisch.org>
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
From: Marcus =?ISO-8859-1?Q?R=FCckert?= <kernel@nordisch.org>
To: =?UTF-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Jiri Slaby	
 <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, 	stern@rowland.harvard.edu,
 stable@vger.kernel.org, =?UTF-8?Q?=C5=81ukasz?= Bartosik
 <ukaszb@chromium.org>, Oliver Neukum <oneukum@suse.com>
Date: Wed, 13 Aug 2025 03:58:07 +0200
In-Reply-To: <20250813000248.36d9689e@foxbook>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
		<fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
		<5b039333-fc97-43b0-9d7a-287a9b313c34@linux.intel.com>
		<4fd2765f5454cbf57fbc3c2fe798999d1c4adccb.camel@nordisch.org>
	 <20250813000248.36d9689e@foxbook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-13 at 00:02 +0200, Micha=C5=82 Pecio wrote:
> On Tue, 12 Aug 2025 20:15:13 +0200, Marcus R=C3=BCckert wrote:
> > On Tue, 2025-08-12 at 13:48 +0300, Mathias Nyman wrote:
> > > > > [Wed Aug=C2=A0 6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0:
> > > > > xHCI
> > > > > host controller not responding, assume dead
> > > > > [Wed Aug=C2=A0 6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0:
> > > > > HC
> > > > > died; cleaning up=C2=A0=20
> > >=20
> > > Tear down xhci.=C2=A0=20
> >=20
> > so usb is not dead completely. I can connect my keyboard to the
> > charging cable of my mouse and it starts working again. but it
> > seems
> > all my devices hanging on that part of the usb tree are dead
> > (DAC/keyboard)
>=20
> You have multiple USB buses on multiple xHCI controllers. Controller
> responsible for bus 1 goes belly up and its devices are lost, but the
> rest keeps working.
>=20
> It would make sense to figure out what was this device on port 2 of
> bus 1 which triggered the failure. Your lsusb output shows no such
> device, so it was either disconnected, connected to another port or
> it malfunctioned and failed to enumerate at the time. Do you know?
>=20
> What's the output of these commands right now?
> =C2=A0 dmesg |grep 'usb 1-2'
> =C2=A0 dmesg |grep 'descriptor read'

dmesg |grep 'usb 1-2' ; dmesg |grep 'descriptor read'
[    2.686292] [    T787] usb 1-2: new full-speed USB device number 3
using xhci_hcd
[    3.054496] [    T787] usb 1-2: New USB device found, idVendor=3D31e3,
idProduct=3D1322, bcdDevice=3D 2.30
[    3.054499] [    T787] usb 1-2: New USB device strings: Mfr=3D1,
Product=3D2, SerialNumber=3D3
[    3.054500] [    T787] usb 1-2: Product: Wooting 60HE+
[    3.054501] [    T787] usb 1-2: Manufacturer: Wooting

the device is running firmware 2.11.0b-beta.3

> Do you have logs? Can you look at them to see if it was always
> "usb 1-2" causing trouble in the past?

looks like it according to=20
journalctl --since 2025-07-01 --grep "reset full-speed USB device
number"

Jul 24 15:56:34 kernel: usb 1-2: reset full-speed USB device number 14
using xhci_hcd
Jul 24 15:56:35 kernel: usb 1-2: reset full-speed USB device number 14
using xhci_hcd
Jul 24 15:56:36 kernel: usb 1-2: reset full-speed USB device number 14
using xhci_hcd
Jul 24 15:56:37 kernel: usb 1-2: reset full-speed USB device number 14
using xhci_hcd
Jul 31 19:53:02 kernel: usb 1-2: reset full-speed USB device number 50
using xhci_hcd
Jul 31 19:53:03 kernel: usb 1-2: reset full-speed USB device number 50
using xhci_hcd
Jul 31 19:53:04 kernel: usb 1-2: reset full-speed USB device number 50
using xhci_hcd
Jul 31 19:53:04 kernel: usb 1-2: reset full-speed USB device number 50
using xhci_hcd
Aug 06 16:51:34 kernel: usb 1-2: reset full-speed USB device number 12
using xhci_hcd
Aug 06 16:51:35 kernel: usb 1-2: reset full-speed USB device number 12
using xhci_hcd
Aug 06 16:51:36 kernel: usb 1-2: reset full-speed USB device number 12
using xhci_hcd
Aug 06 16:51:36 kernel: usb 1-2: reset full-speed USB device number 12
using xhci_hcd

> > lspci is here=20
> >=20
> > https://bugzilla.opensuse.org/show_bug.cgi?id=3D1247895#c3
> >=20
> > Mainboard is a ASUS ProArt X870E-CREATOR WIFI
>=20
> Thanks. Unfortunately I don't have this exact chipset, but it's
> an AMD chipset made by ASMedia, as suspected.

I will drop wooting a mail so they are in the loop.

   darix

--=20
Always remember:
  Never accept the world as it appears to be.
    Dare to see it for what it could be.
      The world can always use more heroes.



