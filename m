Return-Path: <stable+bounces-95939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DB89DFBD0
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3D7162A3E
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1A61F9AA9;
	Mon,  2 Dec 2024 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="jKCt5r5A"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE51D6DDC
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127864; cv=none; b=Nc8f2ktVo7qJk6aXSXDvvq8fJJbbknLnrCo0XYDp57WA+tc+4Z0IjB4XkTBFgVJAsXEpuS8Fz0jRRlxeeRixX450CBWN2vyWVSuOmVfaQFk56HniUTI20JpGw1BQMzO7u2l9w6uO6440IZlDLU0N3/sL3leKsx8t+8ahxGF7hoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127864; c=relaxed/simple;
	bh=/ZHSv0vZid3O406LMuPtfLpuD5C4UcF09GoLOSYaEhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbURdiFdTGXCZOLtPlAbdxgY8h5iQ8uIeXEup4xd//WeRbeXGkC/ZDqtzoJ2W+RyH781T5225/7zt29/Qt14OacPq3MKEcSfJPiPBxr0Dtai1VyJDbC8vWT+ERyEdX4W6GoYxI0p3YB6JBt22Uik1NKBcXdtU+KXgK+kfwPUlWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=jKCt5r5A; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=jKCt5r5A;
	dkim-atps=neutral
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 31F9E4CD
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 17:24:21 +0900 (JST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7254237c888so3517825b3a.1
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 00:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1733127860; x=1733732660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/h3ksscezU2AFx7jalcVKwx+o7bQGfGeG3iipVTlMA=;
        b=jKCt5r5AFfYI74IP8XwOTK2CMfU8hOSNjY7X7/cvZaWjm1XGRAvYigD5FD8lwey2QW
         URc9wQkuVYouyGB79vLX4Nu3wmxwx5amiDv/16jRPypDwrlMXb6raxO1qPiZFyS2b0nm
         cEfoK5obQRBIwKE6pDXupk35qugxTyoCYFIQKI5GbHnv+8ouIG4SD/il0NQFoigumX8N
         //RB7lhTWbdSMPwtuTUlt5b7jH+Wit+bcupfg18Qg3gUxA3CVijfQ0OSjJe4cPCWszD6
         rS5fGukYNah9qn6Ar/vU0PB8HdUhygmnb4Xvcqkl1imE/98k5WKu8E0LKmEbhrIrsJ1z
         igCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733127860; x=1733732660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/h3ksscezU2AFx7jalcVKwx+o7bQGfGeG3iipVTlMA=;
        b=U2Bs1bcJUEkoL0mS2W/J76DumMhBYEVCfVr+tI3dtpTpjAyhyeI3w6DAX98Eb8C8+8
         dYAQAchht8FwOO9VM1uBQx5VDmm/gjQwQFiFykCbbafidJlIgi/iCtocdekuTwDfGtvS
         fHlyQtUdavusbXJO9U9puDY16GGwu5xF82dWNz19Bf8ho5V33usYdDQ0Safz6iI9jzUs
         eVP1PMemqr1UX9K6zXogredm80ATikNxhozIED/0TyBlws7VrHSr0wcL89B8pgLJDU2U
         EEJ30a1/QWbLSMFBd1YumKmQAAq+PwLghDY+CcVxcnwF0IU/qmlTjGpgPWNU7IJlHh6L
         n9NA==
X-Forwarded-Encrypted: i=1; AJvYcCWcV07paP4Zb3vVeFzAWPJXSp4Kz544mcizFKZlGX3mV7SRC9vl9oezCaRQ1MvtwqdHWDH1dt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4a54346NYCAriAbo2GDBx4seGlclVZX5V/siUgTp9TJER+OIM
	BC3SrkClNfsbiFEtsSbr4E27OdO6EqiDREI944zkK1sbsOjF/6LPZekFlcvzjfNXNHOJl0vDoST
	fVKOJKji3nmIqCITKShEKVN7/M1MJCyX8RG8i1LI6mEyLh0EuioBksQk=
X-Gm-Gg: ASbGncuU60Ap2Hy5CpoBGIbQrfJPpCeAtZGk/4J2fwLJOI2rV3FFND4NzBXSneHjGi7
	WRXlKnT77gZb1wXdSEH6+04L1jO0coZlnWK9v5EZQgyW3cXyJvSKX62W+skaEwumPtMVXQCKIgM
	EKytRvRLUDX1otEFgySW9hZrU7GTscd76iM0ADfrBLeINHZU5/UFnpf73BEwMXiw9Wla5kAyogA
	6hL70p5dpTNNeMRAHtsCN5m01AmpFQjvVVI5RtPkjI5h/wW2HsUR7sMCmYBSvZzR9zr63mFsYJV
	88RUVFc2CVZKznL0kT7ddg3vqhi56Ro=
X-Received: by 2002:a17:902:f64f:b0:20c:a0a5:a181 with SMTP id d9443c01a7336-21501381b6fmr305187005ad.19.1733127860199;
        Mon, 02 Dec 2024 00:24:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF67NsKV2/CWe50pDLshUkUs6WDDf2ByoBORdWZB1Kq2UVOK27KewyrPjxmWntBKQjczEsiyA==
X-Received: by 2002:a17:902:f64f:b0:20c:a0a5:a181 with SMTP id d9443c01a7336-21501381b6fmr305186825ad.19.1733127859875;
        Mon, 02 Dec 2024 00:24:19 -0800 (PST)
Received: from localhost (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21584fbbb9esm19347595ad.153.2024.12.02.00.24.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2024 00:24:19 -0800 (PST)
Date: Mon, 2 Dec 2024 17:24:08 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.com>, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Greg Thelen <gthelen@google.com>,
	John Sperbeck <jsperbeck@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
Message-ID: <Z01uqI7hUNyCGFcw@atmark-techno.com>
References: <20241017071849.389636-1-oneukum@suse.com>
 <Z00udyMgW6XnAw6h@atmark-techno.com>
 <2024120259-diaphragm-unspoken-5fe0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024120259-diaphragm-unspoken-5fe0@gregkh>

Greg Kroah-Hartman wrote on Mon, Dec 02, 2024 at 07:29:52AM +0100:
> On Mon, Dec 02, 2024 at 12:50:15PM +0900, Dominique MARTINET wrote:
> > So we hit the exact inverse problem with this patch: our device ships an
> > LTE modem which exposes a cdc-ethernet interface that had always been
> > named usb0, and with this patch it started being named eth1, breaking
> > too many hardcoded things expecting the name to be usb0 and making our
> > devices unable to connect to the internet after updating the kernel.
> > 
> > 
> > Long term we'll probably add an udev rule or something to make the name
> > explicit in userspace and not risk this happening again, but perhaps
> > there's a better way to keep the old behavior?
> > 
> > (In particular this hit all stable kernels last month so I'm sure we
> > won't be the only ones getting annoyed with this... Perhaps reverting
> > both patches for stable branches might make sense if no better way
> > forward is found -- I've added stable@ in cc for heads up/opinions)
> 
> Device names have NEVER been stable.  They move around and can change on
> every boot, let alone almost always changing between kernel versions.
> That's why we created udev, to solve this issue.

Yes, I agree and we will add an udev rule to enforce the name for later
updates (I really am just a messenger here as "the kernel guy", after
having been asked why did this change), and I have no problem with this
behavior changing on master whatever the direction this takes
(... assuming the check was written as intended)

Now you're saying this I guess the main reason we were affected is that
alpine never made the "stable network interface name" systemd-udev
switch, so for most people that interface will just be named
enx028072781510 anyway and most people will probably not notice this...
(But then again these don't use the "new" name either, so they just
don't care)


With that said, and while I agree the names can change, I still think
there's some hierarchy here -- the X part of ethX/usbX can change on
every boot and I have zero problem with that, but I wouldn't expect the
"type" part to change so easily, and I would have assume stable kernels
would want to at least try to preserve these unless there is a good
reason not to.
The two commits here (8a7d12d674ac ("net: usb: usbnet: fix name
regression") and bab8eb0dd4cb ("usbnet: modern method to get random
MAC") before it) are just cleanup I see no problem reverting them for
stable kernels if they cause any sort of issue, regardless of how
userspace "should" work.


> But how is changing the MAC address changing the device naming here?
> How are they linked to suddenly causing the names to switch around?

That's also something I'd like to understand :)

Apparently, usbnet had a rule that said that if a device is ethernet,
and either (it's not point-to-point) or (mac[0] & 0x2 == 0) then we
would rename it to ethX instad of the usbX name.

commit 8a7d12d674ac ("net: usb: usbnet: fix name regression") made it so
the last part of the check would rename it to ethX if the mac has been
set by any driver, so my understanding is that all drivers that used to
set the mac to something that avoided the 0x2 would now get renamed?...
But as you can see above from the stable device name I gave, the mac
address does start with 02, so I don't understand why it hadn't been
renamed before or what this rules mean and why it's here...?

The commit message mentions commit bab8eb0dd4cb ("usbnet: modern method
to get random MAC") which changed the timing usbnet would set a random
mac, but in my case the mac does come from the hardware (it's stable
across reboots), so I guess I wasn't affected by that commit but the new
one trying to make it better for people with a random mac made it worse
for my case?


Anyway, as said above we'll try to figure something for udev, and this
will hopefully be a heads up for anyone else falling here doing a web
search.
(Our users are rather adverse to changes so I don't see myself enabling
static interface names anytime soon, but time will tell how that turns
out...)

Cheers,
-- 
Dominique

