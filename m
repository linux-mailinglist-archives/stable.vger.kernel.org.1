Return-Path: <stable+bounces-113958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5504FA298FE
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 19:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712CB3A291F
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 18:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323101FF7BB;
	Wed,  5 Feb 2025 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ApoHtq05"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366391FDE08
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779934; cv=none; b=s3DwF/X4G63o9IWBIfvF4MDMLBNUklVIryQMfZcwlBkxOVXIqIF7q0j2RyOTYNqtSYTEtp5LcKHzb2LZ+HigCm4Tkiv8aqnDWTddI8QtvTym095vvhpOF79dHJxAtkAKoCaapDtJg7FxKcPDg6c3plOdUsCjm538GEaUUHXxZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779934; c=relaxed/simple;
	bh=tH6lLMrQ/gj5po0e0sG6QtkzB5Kxsj+lFXBtzxF6SIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVU+DfWHhIng3jzASnt9CUlwLNSZ2WN4MZ6XCAg7t0K8s5tGGVXPA55Zo8RLugqfcrZhgQj+qG9Rr56/X297qFbdxmQ2uN85jhm7OTTiOznqnqBBjYbEcvXmu90hXr3JDoec4Q1VoJMPjODZhbfXDcRJ3/4X/Ad8iUefZC6drnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ApoHtq05; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467a37a2a53so1415781cf.2
        for <stable@vger.kernel.org>; Wed, 05 Feb 2025 10:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1738779931; x=1739384731; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mCzyuBHVhuQj4Umta0/LqBnv3QQgsYQwEwtnRHH8YVM=;
        b=ApoHtq05eDSi3/wXc75BudIKOhgeXgT1Xwxx8EmX68Z5uBqUh6n0Y9gWB1QCVhW6wq
         A8VBkj/2FprcxeVdJeGhCCnvScm3cxnb54oBxswBBV3pldZMNUOG5HlNmhbhnzDcQkVV
         cXtDk+f2jbYrtzQCSwDZnE8A5gU4QCAjwCdmPJ23DE9ZEx0rGXr1EDdApJ8pLtg43le+
         prPEqM3x5t+NJwYSL8OiavFy5GraKuVwYtzR0KUMhCAylKfDG2c//13dRTFJxNN4JtXY
         tQYysHfbOz3ZHZTp9dkNEKGusz80rxP4X3X1ymePPG5r0uKql6aXqyNj77M3cQQ4ZhGH
         bbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738779931; x=1739384731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCzyuBHVhuQj4Umta0/LqBnv3QQgsYQwEwtnRHH8YVM=;
        b=o8nbrVZKcTZB1mP8XOzJu9NeZ0RwwzrHqJWwVj5Qh7lcjL9+CIyaOrvmoCXUslB/al
         UTserjGr9KRj4zKl9nG39RhLh2/CVI2Ru7SnqQVM2oYZbGKUUfXf0xjNs98z1z0dFAAa
         uVsGRTunZbZ8BYcFkA7urr71I7AHDaCz9SLChwr2Zc1mkkm1v8gJLCpZbbDHmdBnieS0
         HCZo8/xL+gyf5rsiAWwIWjvXuINaWfWbqqz+1Tb/frLlqPgQoMvtuj2Mo0LzWZoxMyyF
         Du0ZPU7CkdfSwILYLMy/41ilctiKHfp0pMsqZn4RqkhPgDOXUFPmaTxE2/mOeKbJJmt0
         sZow==
X-Forwarded-Encrypted: i=1; AJvYcCVAeNEv1MbQ2MZffspXOILc4bSLYkoYLsC5s/jNDaJQMIEXLteQEqNwURQnnbUC75CqFYUzZF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjp2hE5RvwCDfjwL1vH0TRJcUb1YpwVBzOYsZazhKlzmfhp+s9
	H+kG7LK94E99kA07O1/0c0LZsuwPNu2R4zzj01M462kek+K76v3APu2ktFNzyw==
X-Gm-Gg: ASbGncv/VkWYaPpVIhKxoCnpjFWj4T5jIbuCxhqp4g1LchAEXX9Q3ndMMz7FIRdvbeZ
	ye+WV4/GNvrZz+sysLJMFveHoaJfVvV/HJrJT+mQw9PA8z7dG9k1mQotfuAOAgCfLokUQb8SASQ
	4TahCICkIueMv1bvo8kYjBodiGw8bplE9JA3DCZcK0ILoNnXryzrKr+ZRTyznCm//GLymNQyj16
	hxUuJg3zWq8EoBDc7Df0mZah0eD6jfp1RWXDtzE12Cw6JKUFOIpI20nnSEXno5fTtRNdtEVaGob
	nN/yx+P5nvnqyoWnDcsjSenVhIGOINogaHq2XgtwGAyk70JUtanX8YiXiZzgZcPRj+HZMi2TLcs
	FymtEBH8a
X-Google-Smtp-Source: AGHT+IHbLHNE3cQEhE10HA2TKNk7wuNggVxGPfO7kUIpeSaRqAIv7hAuT4QUnco0X4ZYtMz7WP94AA==
X-Received: by 2002:a05:622a:50:b0:46f:cc2e:3b54 with SMTP id d75a77b69052e-4702818e2e4mr39924271cf.12.1738779931018;
        Wed, 05 Feb 2025 10:25:31 -0800 (PST)
Received: from rowland.harvard.edu (nat-65-112-8-21.harvard-secure.wrls.harvard.edu. [65.112.8.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0ce770sm72153931cf.19.2025.02.05.10.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:25:30 -0800 (PST)
Date: Wed, 5 Feb 2025 13:25:27 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Mingcong Bai <jeffbai@aosc.io>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup
 sources
Message-ID: <6363c5ba-c576-42a8-8a09-31d55768618c@rowland.harvard.edu>
References: <20250131100630.342995-1-chenhuacai@loongson.cn>
 <2f583e59-5322-4cac-aaaf-02163084c32c@rowland.harvard.edu>
 <CAAhV-H7Dt1bEo8qcwfVfcjTOgXSKW71D19k3+418J6CtV3pVsQ@mail.gmail.com>
 <fbe4a6c4-f8ba-4b5b-b20f-9a2598934c42@rowland.harvard.edu>
 <61fecc0b-d5ac-4fcb-aca7-aa84d8219493@rowland.harvard.edu>
 <2a8d65f4-6832-49c5-9d61-f8c0d0552ed4@aosc.io>
 <06c81c97-7e5f-412b-b6af-04368dd644c9@rowland.harvard.edu>
 <6838de5f-2984-4722-9ee5-c4c62d13911b@aosc.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6838de5f-2984-4722-9ee5-c4c62d13911b@aosc.io>

On Wed, Feb 05, 2025 at 01:59:24PM +0800, Mingcong Bai wrote:
> 在 2025/2/4 00:15, Alan Stern 写道:
> > What sort of USB controller does the X200s have?  Is the controller
> > enabled for wakeup?
> > 
> > What happens with runtime suspend rather than S3 suspend?
> 
> It has the Intel Corporation 82801I (ICH9 Family) USB UCHI/USB2 EHCI

UHCI, not UCHI.

> controller with PCI IDs 17aa:20f0/17aa:20f1. The hub is a Genesys Logic,
> Inc. Hub with an ID of 05e3:0610 - this is an xHCI hub.

There is no such thing as an xHCI hub -- xHCI is a host controller 
technology, not a hub technology.  Perhaps you mean that it is a USB-3 
hub.

> Sorry but the record here is going to get a bit messy... But let's start
> with a kernel with Huacai's patch.
> 
> === Kernel + Huacai's Patch ===
> 
> 1. If I plug in the external keyboard via the hub,
> /sys/bus/usb/devices/usb1,

/sys/bus/usb/devices/usb1 is the root hub, which is an emulated device 
that is closely tied to the host controller.  The external Genesys Logic 
hub is /sys/bus/usb/devices/1-1.

>  power/state is set to enabled. For the hub,

You mean power/wakeup, not power/state.  In fact, there is no 
power/state file for USB devices in sysfs.

> corresponding to usb1/1-1, power/wakeup is set to disabled.
> 
> 2. If I plug the keyboard directly into the chassis, usb1/power/wakeup is
> set to disabled, but usb1/1-1/power/wakeup is set to enabled.

Why is usb1/power/wakeup set to disabled?  Doesn't Huacai's patch set it 
to enabled?

Is 1-1 the keyboard device?  That is, did you plug the keyboard into the 
port that the Genesys Logic hub was using previously?

> The system wakes up via external keyboard plugged directly into the chassis
> **or** the hub either way, regardless if I used S3 or runtime suspend (which
> I assume to be echo freeze > /sys/power/state).

No.  Runtime suspend has no relation to /sys/power.  It is controlled by 
/sys/bus/usb/devices/.../power/control.  If you write "auto" to this 
file for the device and for all the hubs above it (including the root 
hub) then they will be put into runtime suspend a few seconds after you 
stop using them, assuming no other USB devices are plugged into the same 
hubs.

> === Kernel w/o Huacai's Patch ===
> 
> The controller where I plugged in the USB hub, /sys/bus/usb/devices/usb1 and

/sys/bus/usb/devices/usb1 is the root hub, not the controller.  The two 
are related but they are not the same thing.  The controller is the 
parent device of the root hub; it lies under /sys/bus/pci/devices/.

> the hub, corresponding to usb1/1-1, their power/wakeup entries are both set
> to disabled. Same for when I have the patch applied.
> 
> However, if I plug the external keyboard into the chassis, it would fail to
> wakeup regardless of S3/runtime suspend (freeze). If I plug the external
> keyboard via that USB Hub though, it would wake up the machine. The findings
> are consistent between S3/freeze.

This means there's something different between the way the keyboard 
sends its wakeup signal and the way the Genesys Logic hub sends its 
wakeup signal.

Can you post the output from "lsusb -t" for this system?

Also, can you enable dynamic debugging for usbcore by doing:

	echo module usbcore =p >/sys/kernel/debug/dynamic_debug/control

and then post the dmesg log for a suspend/resume cycle?

Alan Stern

