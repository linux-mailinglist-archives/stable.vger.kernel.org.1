Return-Path: <stable+bounces-95940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C59B9DFC03
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93337B21367
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3511F9F45;
	Mon,  2 Dec 2024 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="IBqYJqXD"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BC11F9EB0
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128628; cv=none; b=jVMN9oNbFcUKtuznBzxF2sfvlaVCvQYMMBQAwWRmT6G5ixPgnCtlDqHIp0mBDfjH//PPOt4+IHQUYKNWSCP3RQxZwkGSymmpDXYOYkuiSFSeTTEV57eytruQ4TT4qDS1yVwawdgotCrhiTr/i0o789mof6H+UnhSS2YKGsO3dqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128628; c=relaxed/simple;
	bh=9vqHlE4eKnkIwWvsC3JIbW/E7dhC9pzrKM+9c/98Xec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GckzhVNBd8eC/RxEmnx51oZtSYk8MLk6c4tR8kAGVF6j6Fxlp0t0s4Mosle5VeMJ2kXd4D3w80Vjg3sq/AklhPLfvB8rY3ICleHQzIT8r2PHQyplmbuPqgtmXJhHxSJAzZNQYFqE0ShziNRWWx/ZEmKtGs4YHNW+miuJKXUjv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=IBqYJqXD; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=IBqYJqXD;
	dkim-atps=neutral
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 2752E567
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 17:37:05 +0900 (JST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2156cb2c3d2so19467375ad.1
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 00:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1733128624; x=1733733424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VK2WqgJCuK3lJ9mOGj3N1dg4zBlFcV2FC4v/ogSdXlE=;
        b=IBqYJqXDFlFfwyjsYdNRswtezlYUnlRa4Cz9Lrvk5691b6kPtFRgGOrC01JZhew1+p
         xnCLF/QTwobpSvzTQ+PucfxfH2N0vrjtIusrOJ0miH45KqkyFBJ90lo2zDNUiaxfxwVr
         NNUggQ1qlSt2F80lIfbRRPTC98GTOuDMgRXza6x3uMszmhOqe8b/oY0g0ZfbZqIxnQjP
         8/fDJYH6dwzA7tzduAtEIHW8WPdQncPL4SDWNkECmuBkHr/MUVPpUTnD2sfU4EoHb2lN
         a77v+5xAKasA6gebeHQKwjm6mzyhn3/tF9bFbGIArAH+a1CiFTZ0O5fg0K+Ohwo4AoGG
         YdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733128624; x=1733733424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK2WqgJCuK3lJ9mOGj3N1dg4zBlFcV2FC4v/ogSdXlE=;
        b=NYCEq3CgHsJWvuUl0fJGREaa0biwqKC384anDIyZYoc6ahRRdu6ZUoX+/dsaWTORES
         Qbc9+KYEFgnLsSIojv1+XkvpG7wTbdXn11chKkilxRao9sWExjI9fX0I08bsTMbXCSI0
         6nJv67NJi/BMgQTGpUtuK+3Up46Eu+Ps0tfmnH7pWsCmMRczojXowcUb/hiuyU3Ii3RQ
         FnhS02atWJKTs0q99edqzIqvmFZRqFyZBSbTtd7AcqzUGree6iVLJq1xXeyU0HL7Bm0Q
         1EFd2tG7STMFU17uuwU5ApIr2A6Ur/x2ZGGomBPJZGX4ojwEAeu3m/uv98OCjrndlGPN
         Ltkg==
X-Forwarded-Encrypted: i=1; AJvYcCUBuc0UJLemuh83q5Ga8tPEpPsAGerkpFLbLdP/OBH+kjQri/Vdc4dTQcUObo7t/NJ5gDsjafw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGwDMzoOhUE78lEyXhIsl1VLZehb3eCdEsVryZb8p3KlLo6mKE
	I2hQTJjEIGsXXExgH3ggz539sMhDHn9NHD7OYcZYQ98vIg7n+LGfGE8Uq4BfvFaSUZgLa3dW4B/
	dnBrz9GI7epDhDg/Lc0GqAX+BS1PtM5Qf2AsCvN1efiwZXB+8wkhXDhstUFkHHh4=
X-Gm-Gg: ASbGncvIPfaFlT7+0aHRI0B4QxvoEAQfCM2ZOw8qC/5PL9uGigZIU/3a3dBWl/aiOIH
	2XCFpqWpJXmAHhB3Bv+yhFpH52MhAXOO1r/QI2KCKwfGzaaxnnDbX+j2iNM0IuJn13R/CWNrSgu
	JGMR7XU2b3QjV1tnwPDPXXYmWlfyAcXdV0uXNK4Cx1ieQ95v+efIYu8Ae9iuPY3QJAsutmvJWER
	PCoAnTUYz/ioy0/k2h8eJXmZhkJ21nGdgDNoCLZeGIRIj5uWZGjF6OfghZQMQXWLGYhogqFjk2Y
	ZvIEspA+ipIb0CT8NnT/ekJSNxxvzyxMtQ==
X-Received: by 2002:a17:902:f54c:b0:215:8695:ef91 with SMTP id d9443c01a7336-2158695f663mr63999705ad.6.1733128624194;
        Mon, 02 Dec 2024 00:37:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSWAE/y0IhIcwNvm6fI7kzoEX5JNN1BJNMR/5uOfQrwY1hGEgyeBr1D7ts6PKB0Bl8V884sQ==
X-Received: by 2002:a17:902:f54c:b0:215:8695:ef91 with SMTP id d9443c01a7336-2158695f663mr63999525ad.6.1733128623892;
        Mon, 02 Dec 2024 00:37:03 -0800 (PST)
Received: from localhost (178.101.200.35.bc.googleusercontent.com. [35.200.101.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2156e0bf55csm28960015ad.5.2024.12.02.00.37.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2024 00:37:03 -0800 (PST)
Date: Mon, 2 Dec 2024 17:36:51 +0900
From: 'Dominique MARTINET' <dominique.martinet@atmark-techno.com>
To: David Laight <David.Laight@aculab.com>
Cc: Oliver Neukum <oneukum@suse.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Greg Thelen <gthelen@google.com>,
	John Sperbeck <jsperbeck@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
Message-ID: <Z01xo_7lbjTVkLRt@atmark-techno.com>
References: <20241017071849.389636-1-oneukum@suse.com>
 <Z00udyMgW6XnAw6h@atmark-techno.com>
 <e53631b5108b4d0fb796da2a56bc137f@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e53631b5108b4d0fb796da2a56bc137f@AcuMS.aculab.com>


(Sorry for back-to-back replies, hadn't noticed this when I wrote the
previous mail)

David Laight wrote on Mon, Dec 02, 2024 at 08:17:59AM +0000:
> > So we hit the exact inverse problem with this patch: our device ships an
> > LTE modem which exposes a cdc-ethernet interface that had always been
> > named usb0, and with this patch it started being named eth1, breaking
> > too many hardcoded things expecting the name to be usb0 and making our
> > devices unable to connect to the internet after updating the kernel.
> 
> Erm does that mean your modem has a locally administered MAC address?
> It really shouldn't.

Unfortunately, that's what it gives us:
# ip a show dev eth1
4: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
    link/ether 02:80:72:78:15:10 brd ff:ff:ff:ff:ff:ff

# udevadm info /sys/class/net/eth1
P: /devices/platform/soc/2100000.bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1:1.0/net/eth1
E: DEVPATH=/devices/platform/soc/2100000.bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1:1.0/net/eth1
E: ID_BUS=usb
E: ID_MM_CANDIDATE=1
E: ID_MODEL=GTO
E: ID_MODEL_ENC=GTO
E: ID_MODEL_ID=00a0
E: ID_NET_NAME_MAC=enx028072781510
E: ID_REVISION=0307
E: ID_SERIAL=Gemalto_GTO_101578728002
E: ID_SERIAL_SHORT=101578728002
E: ID_TYPE=generic
E: ID_USB_DRIVER=cdc_ether
E: ID_USB_INTERFACES=:020600:0a0000:020201:
E: ID_USB_INTERFACE_NUM=00
E: ID_VENDOR=Gemalto
E: ID_VENDOR_ENC=Gemalto
E: ID_VENDOR_ID=1e2d
E: IFINDEX=4
E: INTERFACE=eth1
E: NM_UNMANAGED=1
E: SUBSYSTEM=net
E: USEC_INITIALIZED=23339186

(that mac is stable accross reboots)

afaiu, this modem generates a pointtopoint ethernet device and then
routes packets sent there to LTE.

I've just checked what my phone does when I do USB tethering and it's
pretty similar, the mac is also a local 02:xx mac (02:36:05) which is
also not in OUI lookup tables.
(the only difference is, I plugged it on my laptop which runs systemd,
so it got named enx023605xxxxxx and none of this matters..)

> > > +++ b/drivers/net/usb/usbnet.c
> > > @@ -1767,7 +1767,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
> > >  		// can rename the link if it knows better.
> > >  		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
> > >  		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
> > > -		     (net->dev_addr [0] & 0x02) == 0))
> > > +		     /* somebody touched it*/
> > > +		     !is_zero_ether_addr(net->dev_addr)))
> > 
> > ... or actually now I'm looking at it again, perhaps is the check just
> > backwards, or am I getting this wrong?
> > previous check was rename if (mac[0] & 0x2 == 0), which reads to me as
> > "nobody set the 2nd bit"
> > new check now renames if !is_zero, so renames if it was set, which is
> > the opposite?...
> 
> The 2nd bit (aka mac[0] & 2) is the 'locally administered' bit.
> The intention of the standard was that all manufacturers would get
> a valid 14-bit OUI and the EEPROM (or equivalent) would contain an
> addresses with that bit clear, such addresses should be globally unique.
> Alternatively the local network administrator could assign an address
> with that bit set, required by protocols like DECnet.
> 
> This has never actually been strictly true, a few manufacturers used
> 'locally administered addresses' (02:cf:1f:xx:xx:xx comes to mind)
> and systems typically allow any (non-broadcast) be set.
> 
> So basing any decision on whether a MAC address is local or global
> is always going to be confusing.

Thank you for the explanation, I now understand the old check better --
point to point devices that are a local MAC addresses (0x2 set) would
get to keep the usb0 name.

The new check however no longer cares about the address globality, and
just basically always renames the interface if the driver provided a
mac ?

If that is what was intended, I am fine with this, but I think these
local ppp usb interfaces are rather common in the cheap modem world.


> Linux will allocate a random (locally administered) address if none
> is found - usually due to a corrupt eeprom.

Thanks,
-- 
Dominique

