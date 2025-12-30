Return-Path: <stable+bounces-204250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27283CEA33F
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 677933002D08
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA626056D;
	Tue, 30 Dec 2025 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ovRK+fkp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964E137923
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112962; cv=none; b=muvQV9tUU1n9PxI6Txg8wqDvTNa0z8s5gBArWhmb/rmEN/MrltIMfGoBr+x/9LwdRTOyjqRZ7IPZ0IHfF/S3EJftZrmNo137T8RPuzHQvOm957kffmK9GeYa1ptLWkYT20+wMlthUFExMHsFzElga9Nf1m7yzQo5NEiGTXQjJVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112962; c=relaxed/simple;
	bh=tcI5f57F7ym6jvYHz/Bcc/Mx2rq2d515wCZhg9iPIy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6S4D1bfZ5bkrDr2E3QRU3DLiY7eZo47U8PoNQ/UW/e744g+fULV24RXuZkhTSPh58s/rCIIZOvVS5PDTULhLIyj+K9hmH4R+/Z0X8xRl/tuWWPwe81M+ZSWlWtwfzmADjBkTMGnQVT5jQGcC21wkAuOn33e/g3WsLg2X6vkBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ovRK+fkp; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4f1b147eaa9so80415741cf.3
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 08:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1767112959; x=1767717759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANHVR9coAMge+WLBsY5cko52eRTlCq0nuigwEeNBZ6Y=;
        b=ovRK+fkpo4CQUQ/lpQa9B6K+13qEatIkq6NFGvkNGeeOqUD2omORY4AVq0k2uKeReD
         7gk66mZC8YweKMfi7GwrSRggz0O5/6toGYXlwbos5ZN0XDGS5KPhJSBfik/xjFY3W0Ba
         fwLBav0w/9PlRLEidu/AqiDxwMIs5ip9bL74O7IQCEyPZ7EMOOuK9fF63UlHgQ163FQx
         JMxvm6F9TO1gAVq2KrSYk/Oq9zwdNjv0U695NR8aip6qvL4I+S0su7qvw0ABCA8afuGz
         /0142ZhIOeKL2sZKMhd6UqYGlIu7KKvxbHvpdqbGA01wpqKGOVvI7lLz+4RueleTVu7x
         7KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767112959; x=1767717759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANHVR9coAMge+WLBsY5cko52eRTlCq0nuigwEeNBZ6Y=;
        b=m+hTKGhjaA55M4Gu5CQVW47VKvwBWdqDKmsxKJYNyV+vFCRTG8B3o25+groMen3um9
         wh8qMEArTzKGY6jb3VRv8mFh19mGxd5vwser9AMGg24kPxXiHd3Z2T/x1a0J30SpFN54
         PD/VhWVNyen45Cr0OkEstrOL10FK6i37ZDJrzRud90X3N08CMX6IupQgi20Erz5spnoK
         Br9lm9L05dpjtzijSELVZ7ej11N2UjO0eERJ77WYWBgil6NiP2b2HIs6npXDbI74ewEr
         RT481s45PiLu3NMmaVeURGyCelFAC3uCfNcax1TOXV2HFUyD89li8kKAhJzlj+Qnynmd
         FQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDP+babB6BSeKVhDQb9Mqx84a405/mxkQgnI0RWhHCjYkhdiPEmHy4K0bG27y5aO3ka2UImf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/omSQpzRSgZCruypBofxj4CvJn3UnRrplmWjUQy6jH62ZPFX
	OOLmu0RpXXohWHrloIC9iHEQvYhxEJ2Lh43ZWGQwVmepK8zhWefnP39j4DwW23g40A==
X-Gm-Gg: AY/fxX7i/02+v5g93T66liQzrg/2YTBod59hoL3sexoV1e0fqjQDI7tNZPM+74crarN
	vqKUYhPdFEx7LgZPCw9bLy2eiQA8ap7fVALUpebJZ5zNAckYR8p7ipT62nA7ZNxDBuBVHp96R2t
	Zv/vrqJYe5xCtYUQQM8zpNvjeuWEJ0sCHnfLaUy8L9TIY5jOjYDnjvryvm6w+r8k/LWKThgVyRY
	BE7LsfRNardFDaj6YM9D8kgUasIHBn2r6ouhOkBlU4pQ+z7cqIgcvD/VPsQEAzSW8CxdHts97t+
	HtDFvaIq3wzq1i4tFghFwSQFvbee6yJegYkYRD8TeXwux2qQnNZKrJkyAevHJpOkrxdG1SXiOKd
	uZna3Juksk4RRhxVALOUqOJJg9gV/JazLfVnt0r0i+loXO3gXS9JeOx/xqBDut7H0Pyp4kivQfH
	7XGjnmIT4cmH6E
X-Google-Smtp-Source: AGHT+IGZ10x43nQ+FLvBRMXbLZtKA3EXPyhDzZklnkmuT26qzuiftxIwaVESBYneQ9nQxbWfNF/N/w==
X-Received: by 2002:ac8:5746:0:b0:4ed:dab1:8109 with SMTP id d75a77b69052e-4f4abcf6a35mr445396981cf.17.1767112959383;
        Tue, 30 Dec 2025 08:42:39 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::7e72])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4c46e4aabsm198873001cf.16.2025.12.30.08.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:42:38 -0800 (PST)
Date: Tue, 30 Dec 2025 11:42:35 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Shengwen Xiao <atzlinux@sina.com>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
Message-ID: <73d472ea-e660-474c-b319-b0e8758406c0@rowland.harvard.edu>
References: <20251230080014.3934590-1-chenhuacai@loongson.cn>
 <2025123049-cadillac-straggler-d2fb@gregkh>
 <DFBMNYF0U5PK.24YOAUZFZ0ESB@cknow-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFBMNYF0U5PK.24YOAUZFZ0ESB@cknow-tech.com>

On Tue, Dec 30, 2025 at 03:40:27PM +0100, Diederik de Haas wrote:
> On Tue Dec 30, 2025 at 9:15 AM CET, Greg Kroah-Hartman wrote:
> > On Tue, Dec 30, 2025 at 04:00:14PM +0800, Huacai Chen wrote:
> >> Commit 9beeee6584b9aa4f ("USB: EHCI: log a warning if ehci-hcd is not
> >> loaded first") said that ehci-hcd should be loaded before ohci-hcd and
> >> uhci-hcd. However, commit 05c92da0c52494ca ("usb: ohci/uhci - add soft
> >> dependencies on ehci_pci") only makes ohci-pci/uhci-pci depend on ehci-
> >> pci, which is not enough and we may still see the warnings in boot log.
> >> So fix it by also making ohci-hcd/uhci-hcd depend on ehci-hcd.
> >> 
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Shengwen Xiao <atzlinux@sina.com>
> >> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >> ---
> >>  drivers/usb/host/ohci-hcd.c | 1 +
> >>  drivers/usb/host/uhci-hcd.c | 1 +
> >>  2 files changed, 2 insertions(+)
> >> 
> >> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> >> index 9c7f3008646e..549c965b7fbe 100644
> >> --- a/drivers/usb/host/ohci-hcd.c
> >> +++ b/drivers/usb/host/ohci-hcd.c
> >> @@ -1355,4 +1355,5 @@ static void __exit ohci_hcd_mod_exit(void)
> >>  	clear_bit(USB_OHCI_LOADED, &usb_hcds_loaded);
> >>  }
> >>  module_exit(ohci_hcd_mod_exit);
> >> +MODULE_SOFTDEP("pre: ehci_hcd");
> >
> > Ick, no, this way lies madness.  I hate the "softdep" stuff, it's
> > usually a sign that something is wrong elsewhere.
> >
> > And don't add this _just_ to fix a warning message in a boot log, if you
> > don't like that message, then build the module into your kernel, right?
> >
> > And I really should just go revert 05c92da0c524 ("usb: ohci/uhci - add
> > soft dependencies on ehci_pci") as well, that feels wrong too.
> 
> FWIW, I've been seeing this warning on several of my Rockchip based
> devices as well. I thought I had already mentioned that on some ML, but
> couldn't find it on lore.k.o ... turns out I reported it on my 'own' ML:
> https://lists.sr.ht/~diederik/pine64-discuss/%3CDD65LB64HB7K.15ZYRTB98X8G2@cknow.org%3E
> (and likely on #linux-rockchip IRC channel)
> 
> Most of it is just my research notes, but the last post also had this:
> 
> ```
> I checked the last 20 boots on my devices to see that warning (or not).
> Device				Number of times that warning showed up
> Rock64 (rk3328)			16x
> RockPro64 (rk3399)		11x
> Quartz64 Model A (rk3566)	 7x
> Quartz64 Model B (rk3566)	14x
> PineTab2 (rk3566)		17x
> NanoPi R5S (rk3568)		13x
> Rock 5B (rk3588)		12x
> ```
> 
> While I generally don't like seeing warning messages, it often also
> resulted in USB2 ports not working. Maybe even every time, but I only
> notice it when I actually tried to use one of the USB2 ports.
> 
> The first post mentioned what I 'assume' to be the problem:
> ```
> CONFIG_USB_XHCI_HCD=m
> CONFIG_USB_EHCI_HCD=m
> CONFIG_USB_OHCI_HCD=m
> ```
> 
> So I guess USB_EHCI_HCD doesn't work with '=m'.

Not true, it really does work with "=m".

And in fact, your systems should work even if the modules are loaded in 
the wrong order.  The issue is that doing so can cause a brief 
interruption in the existing USB connections when the ehci-pci module is 
loaded.

If your systems don't use PCI for these host controllers then I don't 
know how they would behave.  The issue is: How does the hardware route 
low-speed and full-speed USB connections to the different types of 
controller?

On PCI systems, when ehci-pci isn't loaded, the hardware routes all 
connections directly to the companion UHCI or OHCI controller.  When 
ehci-pci is loaded, the hardware routes connections to the EHCI 
controller, and when the driver sees that a connection isn't running at 
high speed (480 Mb/s), it tells the hardware to switch the connection 
over to the companion.

So if a low-speed (1.5 Mb/s) or full-speed (12 Mb/s) device is connected 
before ehci-pci loads, its connection will get routed to the companion 
controller.  Then when ehci-pci loads, the connection will be switched 
over to the EHCI controller, which will cause the existing connection to 
be dropped.  Then the connection will be routed back to the companion 
controller, but it will be perceived as a new connection, resulting in a 
brief interruption in service.  For many devices this won't matter, but 
for some it might.  The only way to avoid the problem is to load 
ehci-pci before uhci-pci and ohci-pci.

(A similar problem can occur with high-speed-capable devices.  When 
initially attached to the companion controller, they are forced to 
connect at full speed.  But when the connection is changed to the EHCI 
controller, they are able to run at high speed -- and again, the result 
is a new connection, causing service to be interrupted and then start up 
fresh but running much faster.)

Alan Stern

