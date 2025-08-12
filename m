Return-Path: <stable+bounces-168062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C02B23342
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E10189A3B0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817172ED17F;
	Tue, 12 Aug 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="Y5PT4Pq7";
	dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="xCU+db1m"
X-Original-To: stable@vger.kernel.org
Received: from tengu.nordisch.org (tengu.nordisch.org [138.201.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D12DFA3E;
	Tue, 12 Aug 2025 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.201.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022911; cv=none; b=EUmBAav43MrgGojJnvBTOzTuRMQwzWgerONGScUWADUzOps2GnEG11sLV6uDiol6FzhLB4ATIbEA5bED32PhH/yzWQkQQf7Mn7AA3bq0kxKjwoD9RlUGgBmXppxIoogc2ZMTQBI1JV3o7I+tiXziX8M1/XfwYw2PLe+BgrlnufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022911; c=relaxed/simple;
	bh=Nm3nZAnFCwJNQ4VDBSZgNPO9vR8bsr/ulE20lACILKg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IxaRBziGUCRziOCFnfsk5E8fla9qTMRKx/KmLe5OuW5DCcQ/rbBwZoUcnGegHc9Hp8Zp3FfbvCjWYag6Yd75GK5HYxYQoJjey2vYd0/r6v6FaK6voYXfeSdwrtp0vsjB3p10q6TJKN8EFzbVqkkPCdK/JwfVldWrahDCj6jx/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nordisch.org; spf=pass smtp.mailfrom=nordisch.org; dkim=pass (1024-bit key) header.d=nordisch.org header.i=@nordisch.org header.b=Y5PT4Pq7; dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b=xCU+db1m; arc=none smtp.client-ip=138.201.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nordisch.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nordisch.org
Received: from [192.168.3.6] (fortress.wg.nordisch.org [192.168.3.6])
	by tengu.nordisch.org (Postfix) with ESMTPSA id 99AC675AA93;
	Tue, 12 Aug 2025 20:15:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordisch.org;
	s=tengu_rsa; t=1755022513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvzejOOAm8yKhKoXy3UatE5OCUk6/FfOEd6OdReBm8M=;
	b=Y5PT4Pq7UBAe4mTFXLvkGL6Gq05n3Np9r96vTD0t1H0s7bzZVsM97bLQUexLBPcyD0bcuv
	P5PP4Zuj+Vc3HQjhyjsusyOBn2AI1eEAXwtoSDzjcEji9MHtwUtDYoc4FlH0jfD6qcW5gr
	zd6CSbJifXcW7p8m/gqqtdv1hcOsVjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nordisch.org;
	s=tengu_ed25519; t=1755022513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvzejOOAm8yKhKoXy3UatE5OCUk6/FfOEd6OdReBm8M=;
	b=xCU+db1moJJLw9ckcBB3oyUp59bnkjA1v8rhRfuW54eUuNDd6wBR2AC/EeM5n9F4HMCUFd
	ear0bEvJGOc/woBA==
Message-ID: <4fd2765f5454cbf57fbc3c2fe798999d1c4adccb.camel@nordisch.org>
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
From: Marcus =?ISO-8859-1?Q?R=FCckert?= <kernel@nordisch.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>, Jiri Slaby
	 <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu, 
	stable@vger.kernel.org, =?UTF-8?Q?=C5=81ukasz?= Bartosik
 <ukaszb@chromium.org>,  Oliver Neukum <oneukum@suse.com>,
 =?UTF-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Date: Tue, 12 Aug 2025 20:15:13 +0200
In-Reply-To: <5b039333-fc97-43b0-9d7a-287a9b313c34@linux.intel.com>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
	 <fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
	 <5b039333-fc97-43b0-9d7a-287a9b313c34@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-12 at 13:48 +0300, Mathias Nyman wrote:
> > > [Wed Aug=C2=A0 6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0: xHC=
I
> > > host controller not responding, assume dead
> > > [Wed Aug=C2=A0 6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0: HC
> > > died; cleaning up
>=20
> Tear down xhci.

so usb is not dead completely. I can connect my keyboard to the
charging cable of my mouse and it starts working again. but it seems
all my devices hanging on that part of the usb tree are dead
(DAC/keyboard)

lspci is here=20

https://bugzilla.opensuse.org/show_bug.cgi?id=3D1247895#c3

Mainboard is a ASUS ProArt X870E-CREATOR WIFI

> >=20
> > Any ideas? What would you need to debug this?
>=20
> Could be that this patch reveals some underlying race in xhci re-
> enumeration path.

possible.

> Could also be related to ep0 max packet size setting as this is a
> full-speed device.
> (max packet size is unknown until host reads first 8 bytes of
> descriptor, then adjusts
> it on the fly with an evaluate context command)
>=20
> Appreciated if this could be reproduced with as few usb devices as
> possible, and with
> xhci tracing and dynamic debug enabled:

sadly this is not really reproducible on command. sometimes it happens
after only a few hours. sometimes it happens after a day or 2.

> mount -t debugfs none /sys/kernel/debug
> echo 'module xhci_hcd =3Dp' >/sys/kernel/debug/dynamic_debug/control
> echo 'module usbcore =3Dp' >/sys/kernel/debug/dynamic_debug/control
> echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
> echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable
> echo 1 > /sys/kernel/debug/tracing/tracing_on

Running with this now.=20

> < Reproduce issue >
> Send output of dmesg
> Send content of /sys/kernel/debug/tracing/trace

Will do once it happened again.

   darix

--=20
Always remember:
  Never accept the world as it appears to be.
    Dare to see it for what it could be.
      The world can always use more heroes.



