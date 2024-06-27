Return-Path: <stable+bounces-55928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E47B591A120
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 10:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0D51F22E0A
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382F78676;
	Thu, 27 Jun 2024 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="UhgkfjoX"
X-Original-To: stable@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99708137930;
	Thu, 27 Jun 2024 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475791; cv=none; b=Ts55XxiBX8UBJearhU1UZHOo95OzfWAhQJ650oKI7sxfmZOI9Vnmiqw2Pj/6lfegOSIvUl9Ja3QO/eJkj2VJNJwg0ljvl0sDKqnshbiAvi4XCMrk3NIhNpp+xNGI3CzMLD5Q7t+vmS4RGpONCr0u3SoY9kOcQSaAvobgLp6rUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475791; c=relaxed/simple;
	bh=4wqX6OAAhotGiMku/AG1t7B/YGfc5JqSZyFMKW/QnKU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Y93rnyZywGk1APcOrCay5yTTSGOGTAkrHxbbijBdD5gpfxK3UoZiiQ7C1026M84HAUrpflSjBCE9Ve8IriZDijZw8sPtHTwZFd7QzDnPYD/x8dBzNzJl+d/WDBGhkTXfZT/IBAvytknvYNgtIHXg4q954Cyn9F2KhXDPhMxBLhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=UhgkfjoX; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 45R89VNZ857280
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:09:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1719475771; bh=4wqX6OAAhotGiMku/AG1t7B/YGfc5JqSZyFMKW/QnKU=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=UhgkfjoXY97WOWqQYRrVNEqClvjsqERPojeO+w1hx2OGPhBWiEfba9JszUaSTcJVe
	 mwR0ZqC/Z8D/BfBgeqT3lsEs+MLrjtGvMKxKbNJ8cnvhaB41AZJZOo3yH4jVHdK/gL
	 cawFB5JhN2seAloN3wpKU9fG0+rI4OeddTjoS7Bk=
Received: from miraculix.mork.no ([IPv6:2a01:799:964:4b0a:9af7:269:d286:bcf0])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 45R89V4D3809957
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 10:09:31 +0200
Received: (nullmailer pid 2347208 invoked by uid 1000);
	Thu, 27 Jun 2024 08:09:31 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Fibocom FM350-GL
Organization: m
References: <20240626133223.2316555-1-bjorn@mork.no>
	<Zn0WSAHHQQr61-Og@hovoldconsulting.com>
Date: Thu, 27 Jun 2024 10:09:31 +0200
In-Reply-To: <Zn0WSAHHQQr61-Og@hovoldconsulting.com> (Johan Hovold's message
	of "Thu, 27 Jun 2024 09:35:36 +0200")
Message-ID: <87ed8i958k.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.3 at canardo
X-Virus-Status: Clean

Johan Hovold <johan@kernel.org> writes:
> On Wed, Jun 26, 2024 at 03:32:23PM +0200, Bj=C3=B8rn Mork wrote:
>> FM350-GL is 5G Sub-6 WWAN module which uses M.2 form factor interface.
>> It is based on Mediatek's MTK T700 CPU. The module supports PCIe Gen3
>> x1 and USB 2.0 and 3.0 interfaces.
>>=20
>> The manufacturer states that USB is "for debug" but it has been
>> confirmed to be fully functional, except for modem-control requests on
>> some of the interfaces.
>>=20
>> USB device composition is controlled by AT+GTUSBMODE=3D<mode> command.
>> Two values are currently supported for the <mode>:
>>=20
>> 40: RNDIS+AT+AP(GNSS)+META+DEBUG+NPT+ADB
>> 41: RNDIS+AT+AP(GNSS)+META+DEBUG+NPT+ADB+AP(LOG)+AP(META)(default value)
>
> The order here does not seem to match the usb-devices output below (e.g.
> with ADB as interface 3 and 5, respectively).=20
>
> Could you just update these two lines so we the interface mapping right?

Thanks, I didn't notice that.

This part was copied from the Fibocom AT+GTUSBMODE documentation and
seems to list supported functions independently of the resulting USB
interface order.

I'm afraid I can't verify the actual order since I don't have access to
this module myself, and there is no way to tell the AT, GNSS, META,
DEBUG, NPT and LOG functons from eacohother based on USB descriptors.

The best I can do is dropping these two lines. Is that better?



Bj=C3=B8rn

