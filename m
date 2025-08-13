Return-Path: <stable+bounces-169356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3F6B2450F
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 11:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4C6582262
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC71E2EF654;
	Wed, 13 Aug 2025 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="ALYPG8CE";
	dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="DsNCninU"
X-Original-To: stable@vger.kernel.org
Received: from tengu.nordisch.org (tengu.nordisch.org [138.201.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ADE2BE03C;
	Wed, 13 Aug 2025 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.201.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076450; cv=none; b=gyV4HMEO39HoMovFC2o3/EgqR+2Yx/xXo4iDze9F9JlipCVFVCgRh/2GOTNiIqD/LQZDAFHZUeT7xxx/fYBKfwMUM3PJw2mjsLj3HC6MMVo+3zVVfUywU9jWE7nLkUoD+rL7GbCoLxkJXteuF/qPu2ylHqOC0zjDVKy8w4E00ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076450; c=relaxed/simple;
	bh=KjbjAVn3Gb9G9bz5c2OJqKKSt9TVDIEL6NRHOoZeZgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AHT09Kzz/J/Ez87bCLYSBNBtSypBscH3Sht02b1Tq360PfJmvf/AGr7ySVFC868SZ5cjJ2S5Yg5NFTa67+reb1LWBqfuZs/d8Vi+DbkHd7Mo+jk9hrUExcBMj3pwfZtCrJY+/9VSwdmqeGOdlvuD8uxGyUtjRr5joLJWu4rVIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nordisch.org; spf=pass smtp.mailfrom=nordisch.org; dkim=pass (1024-bit key) header.d=nordisch.org header.i=@nordisch.org header.b=ALYPG8CE; dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b=DsNCninU; arc=none smtp.client-ip=138.201.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nordisch.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nordisch.org
Received: from [192.168.3.6] (fortress.wg.nordisch.org [192.168.3.6])
	by tengu.nordisch.org (Postfix) with ESMTPSA id 31ECA7B517E;
	Wed, 13 Aug 2025 11:14:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordisch.org;
	s=tengu_rsa; t=1755076445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CaejoTVD43Ah3sy14LUZJseEZ4zHH3xUVzztahkh+Y=;
	b=ALYPG8CE9xQsU+c9vyRvulNIcmOjfvnJxKBMf2yMQu973nXxozheaOCTj5HF3bN8AaNhql
	mLXt1tKgLLsBOE4OLQF8pOMw0u+QiM/UUdANkg7eQCUFoAULX7OpIAIY3e/Jtt5//nBCFC
	x0JV6D+S+itD95KEvL7mQJMtfXdhw/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nordisch.org;
	s=tengu_ed25519; t=1755076445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CaejoTVD43Ah3sy14LUZJseEZ4zHH3xUVzztahkh+Y=;
	b=DsNCninU1qPWBkEpb2x0JO0eq7mwdZFBmoek0J+juu4QzMJOKIFIbHaXKg6BZdITq+PSvi
	aa3eGvfXbgdiBgBQ==
Message-ID: <746fdb857648d048fd210fb9dc3b27067da71dff.camel@nordisch.org>
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
From: Marcus =?ISO-8859-1?Q?R=FCckert?= <kernel@nordisch.org>
To: =?UTF-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Jiri Slaby	
 <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, 	stern@rowland.harvard.edu,
 stable@vger.kernel.org, =?UTF-8?Q?=C5=81ukasz?= Bartosik
 <ukaszb@chromium.org>, Oliver Neukum <oneukum@suse.com>
Date: Wed, 13 Aug 2025 11:14:04 +0200
In-Reply-To: <20250813084252.4dcd1dc5@foxbook>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
		<fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
		<5b039333-fc97-43b0-9d7a-287a9b313c34@linux.intel.com>
		<4fd2765f5454cbf57fbc3c2fe798999d1c4adccb.camel@nordisch.org>
		<20250813000248.36d9689e@foxbook>
		<bea9aa71d198ba7def318e6701612dfe7358b693.camel@nordisch.org>
	 <20250813084252.4dcd1dc5@foxbook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-13 at 08:42 +0200, Micha=C5=82 Pecio wrote:
> On Wed, 13 Aug 2025 03:58:07 +0200, Marcus R=C3=BCckert wrote:
> > dmesg |grep 'usb 1-2' ; dmesg |grep 'descriptor read'
> > [=C2=A0=C2=A0=C2=A0 2.686292] [=C2=A0=C2=A0=C2=A0 T787] usb 1-2: new fu=
ll-speed USB device number
> > 3
> > using xhci_hcd
> > [=C2=A0=C2=A0=C2=A0 3.054496] [=C2=A0=C2=A0=C2=A0 T787] usb 1-2: New US=
B device found,
> > idVendor=3D31e3,
> > idProduct=3D1322, bcdDevice=3D 2.30
> > [=C2=A0=C2=A0=C2=A0 3.054499] [=C2=A0=C2=A0=C2=A0 T787] usb 1-2: New US=
B device strings: Mfr=3D1,
> > Product=3D2, SerialNumber=3D3
> > [=C2=A0=C2=A0=C2=A0 3.054500] [=C2=A0=C2=A0=C2=A0 T787] usb 1-2: Produc=
t: Wooting 60HE+
> > [=C2=A0=C2=A0=C2=A0 3.054501] [=C2=A0=C2=A0=C2=A0 T787] usb 1-2: Manufa=
cturer: Wooting
>=20
> OK, so you had a keyboard in this port during the last boot. Is this
> keyboard always connected to the same port? There is no bus 1 port 2
> device on your earlier lsusb output, so it was either not connected
> there or not detected due to malfunction.

yes it is always connected to that port. the setup is quite static.

> So this port was getting reset in the past. Can you also check:
> - how many of those resets were followed by "HC died"
> - if all "HC died" events were caused by resets of port usb 1-2
> =C2=A0 (or some other port)

Jul 24 15:56:34 kernel: usb 1-2: reset full-speed USB device number 14
using xhci_hcd
Jul 24 15:56:35 kernel: usb 1-2: reset full-speed USB device number 14
using xhci_hcd
Jul 24 15:56:36 kernel: usb 1-2: reset full-speed USB device number 14
using xhci_hcd
Jul 24 15:56:37 kernel: usb 1-2: reset full-speed USB device number 14
using xhci_hcd
Jul 24 15:57:56 kernel: xhci_hcd 0000:0e:00.0: HC died; cleaning up
Jul 31 19:53:02 kernel: usb 1-2: reset full-speed USB device number 50
using xhci_hcd
Jul 31 19:53:03 kernel: usb 1-2: reset full-speed USB device number 50
using xhci_hcd
Jul 31 19:53:04 kernel: usb 1-2: reset full-speed USB device number 50
using xhci_hcd
Jul 31 19:53:04 kernel: usb 1-2: reset full-speed USB device number 50
using xhci_hcd
Jul 31 19:55:05 kernel: xhci_hcd 0000:0e:00.0: HC died; cleaning up
Aug 06 16:51:34 kernel: usb 1-2: reset full-speed USB device number 12
using xhci_hcd
Aug 06 16:51:35 kernel: usb 1-2: reset full-speed USB device number 12
using xhci_hcd
Aug 06 16:51:36 kernel: usb 1-2: reset full-speed USB device number 12
using xhci_hcd
Aug 06 16:51:36 kernel: usb 1-2: reset full-speed USB device number 12
using xhci_hcd
Aug 06 16:52:50 kernel: xhci_hcd 0000:0e:00.0: HC died; cleaning up


all HC died events were connected to reset full-speed.

> And for the record, what exactly was the original problem which you
> reported to Suse and believe to be caused by a kernel upgrade? Was it
> "HC died" and loss of multiple devices, or just the keyborad failing
> to work and spamming "reset USB device numebr x", or something else?

The spamming I wouldnt have noticed. but the loss of the other devices
from the "HC died" I did notice. So I asked Jiri if the recent kernel
updates included USB changes and we started debugging :)

   darix

--=20
Always remember:
  Never accept the world as it appears to be.
    Dare to see it for what it could be.
      The world can always use more heroes.



