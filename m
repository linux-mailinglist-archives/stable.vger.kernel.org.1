Return-Path: <stable+bounces-26688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A439871157
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 00:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2683628408F
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 23:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FB87D3E8;
	Mon,  4 Mar 2024 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=totalphase-com.20230601.gappssmtp.com header.i=@totalphase-com.20230601.gappssmtp.com header.b="1IQr9FDy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8EB7D3E1
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596268; cv=none; b=BepFPUPP7wkmMOutBUXhuqiJfODOgMe1F4Z8fLCpURZNdL4erD1t6DgacmIbTq+oLJqagao1N+aUym319Itx06cGKKdUNK7+a2wYfFoFaVZ/CThf2kDnNVLUN2+Ikkmrq18TrjtYUialKhIVMtgzqlwaczD3MZW6eFiM7c3uC5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596268; c=relaxed/simple;
	bh=lZBdGXN3sDOALNhqG18J8ZzeUVL9c1fKKZLxSYGTO8Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sSzNdUf5xMzI9GBGMz98jr1naZ2JFUy2Xxgr1WiUPSjhFbhhT/IizsrJdavG+yyzfP4TdMEecRT6HXB4UWebd5aUJ07zkGzeHFujtYUv69HK2KlZPW1mSTiGicjOisk8OjD/0aJb4QpptdmXroSKQx8R3vfpeMnBU23mzKHO94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.totalphase.com; spf=pass smtp.mailfrom=totalphase.com; dkim=pass (2048-bit key) header.d=totalphase-com.20230601.gappssmtp.com header.i=@totalphase-com.20230601.gappssmtp.com header.b=1IQr9FDy; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.totalphase.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=totalphase.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-68ffddd89d1so19422826d6.0
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 15:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=totalphase-com.20230601.gappssmtp.com; s=20230601; t=1709596262; x=1710201062; darn=vger.kernel.org;
        h=thread-index:thread-topic:content-transfer-encoding:mime-version
         :subject:references:in-reply-to:message-id:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wHZdIg82gQhhliIHQKfVKh00PcHpYfuwKdT2lavfKEM=;
        b=1IQr9FDykymMeDFnRnOzzdMQuCxarYdSBUj5+rUUiex8Mel+ZhTC6qwccMTpDB6r6r
         CpuAUdTKSClHX4LD5T0lsUgd+eHaLIGdn5PNGosPBOTDsBga5XK2a7q3qGSInnZQd3Fw
         Sc7qVZHiQPkF3gHs6/8v7WSrTD/7cTLdiKzaV7MYvTwHMMI5be7h3zkM2gLY/0ubJ1sJ
         BiIHify2qAtjnVhYXKRVPSDXqj4Jl3qHbnwp3nIRj+g6jt9UATTvv3KWKA6dTa/DhVQY
         eBv3QMRp1zqjTpFLArd2hnSwr4JJqt1cxr/v3d6uG46Fl0/NVqLsuXM+3gqZ3tx45Mlo
         UtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709596262; x=1710201062;
        h=thread-index:thread-topic:content-transfer-encoding:mime-version
         :subject:references:in-reply-to:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHZdIg82gQhhliIHQKfVKh00PcHpYfuwKdT2lavfKEM=;
        b=RdJsM3ijDOVsy5rLYTCI9Av3IEhebwNrJ5Es+dyM0oy4+XZ4QML8uOy5hrFdgO0Nka
         zuQKGMvyrLkFznAiNe4BLXaDwoqL/+Y6DWsFVebhjbzMa5FtiMZp8o/8E5zwvGh7JVJF
         8w5+oBbUnD3gD/Ihb5WiuEajOliDR0PoonWSv83s6l4h3EcivRZBqWSO+9LKFirbx3Bj
         JQ6Z8MmMBJDQ2vMNLjBQzxu/H9tqohX4aCxrIZLzrzc1DOrFgdogyTb91V1PkJSc8e7a
         H5WESuTbxlTK0gD2ZFa6soRlYZJGlOBdxpYSh0PqXF2LP+XPL8flQC1sGQeCwpRCMmWI
         ilSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcmWGqFONs/kuTIoplamofPEdhboIF6VmMJhDz1leseyk3D9zjdhO9+fofcTczGLAM7JpicaQwtrZ/3QcQxxLLgtZ48Bfn
X-Gm-Message-State: AOJu0YypMldUkAA/OE5vlpRjpW+aq5iz6BOUZ+8uzs0cEbPrrbIL7cQF
	SKM01+tNxeQziWc9nZqv+UdhiqFIjEUDv8XqG3FaziNoVlJUBB2mexOqkWxpctWo2d1Sj+r1pJ5
	x/bhfwKAJn67NkAvOc+DBtllCr0u0ClO3
X-Google-Smtp-Source: AGHT+IGjrnpWm32tjepbwSg4ok414e9vCSPGJ/gCDRSDlPlb+tNcp7BCav1jwGVFW7lOL9uJ2BNP02koL33o
X-Received: by 2002:a0c:e114:0:b0:690:5f74:81a7 with SMTP id w20-20020a0ce114000000b006905f7481a7mr390876qvk.45.1709596261870;
        Mon, 04 Mar 2024 15:51:01 -0800 (PST)
Received: from postfix.totalphase.com ([65.19.189.126])
        by smtp-relay.gmail.com with ESMTPS id ke25-20020a056214301900b0068f732494easm562457qvb.42.2024.03.04.15.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 15:51:01 -0800 (PST)
X-Relaying-Domain: totalphase.com
Date: Mon, 4 Mar 2024 15:50:58 -0800 (PST)
From: Chris Yokum <linux-usb@mail.totalphase.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Chris Yokum <linux-usb@mail.totalphase.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	stable <stable@vger.kernel.org>, 
	linux-usb <linux-usb@vger.kernel.org>, 
	Niklas Neronin <niklas.neronin@linux.intel.com>
Message-ID: <717413307.861315.1709596258844.JavaMail.zimbra@totalphase.com>
In-Reply-To: <3a560c60-ffa2-a511-98d3-d29ef807b213@linux.intel.com>
References: <949223224.833962.1709339266739.JavaMail.zimbra@totalphase.com> <50f3ca53-40e3-41f2-8f7a-7ad07c681eea@leemhuis.info> <2024030246-wife-detoxify-08c0@gregkh> <278587422.841245.1709394906640.JavaMail.zimbra@totalphase.com> <a6a04009-c3fe-e50d-d792-d075a14ff825@linux.intel.com> <3a560c60-ffa2-a511-98d3-d29ef807b213@linux.intel.com>
Subject: Re: 6.5.0 broke XHCI URB submissions for count >512
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Thread-Topic: 6.5.0 broke XHCI URB submissions for count >512
Thread-Index: VuTzduXODhc7IqP5hozJk2GPpe5bnA==

Hello Mathias,

Yes! This fixed the problem. I've checked with our repro case as well as our functional tests.

I'll email you the repro code directly, you can compare the unpatched and patched kernel behavior.

Best regards,
Chris


----- Original Message -----
From: "Mathias Nyman" <mathias.nyman@linux.intel.com>
To: "Chris Yokum" <linux-usb@mail.totalphase.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Linux regressions mailing list" <regressions@lists.linux.dev>, "stable" <stable@vger.kernel.org>, "linux-usb" <linux-usb@vger.kernel.org>, "Niklas Neronin" <niklas.neronin@linux.intel.com>
Sent: Monday, March 4, 2024 7:53:03 AM
Subject: Re: 6.5.0 broke XHCI URB submissions for count >512

On 4.3.2024 13.57, Mathias Nyman wrote:
> On 2.3.2024 17.55, Chris Yokum wrote:
>>>> We have found a regression bug, where more than 512 URBs cannot be
>>>> reliably submitted to XHCI. URBs beyond that return 0x00 instead of
>>>> valid data in the buffer.
>>>
>>> FWIW, that's f5af638f0609af ("xhci: Fix transfer ring expansion size
>>> calculation") [v6.5-rc1] from Mathias.
>>>
> 
> Ok, I see, this could be the empty ring exception check in xhci-ring.c:
> 
> It could falsely assume ring is empty when it in fact is filled up in one
> go by queuing several small urbs.

Does this help?

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 6a29ebd6682d..52278afea94b 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -332,7 +332,13 @@ static unsigned int xhci_ring_expansion_needed(struct xhci_hcd *xhci, struct xhc
         /* how many trbs will be queued past the enqueue segment? */
         trbs_past_seg = enq_used + num_trbs - (TRBS_PER_SEGMENT - 1);
  
-       if (trbs_past_seg <= 0)
+       /*
+        * Consider expanding the ring already if num_trbs fills the current
+        * segment (i.e. trbs_past_seg == 0), not only when num_trbs goes into
+        * the next segment. Avoids confusing full ring with special empty ring
+        * case below
+        */
+       if (trbs_past_seg < 0)
                 return 0;

Thanks
Mathias

