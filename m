Return-Path: <stable+bounces-105177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B81E9F6A68
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 16:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89459169BEB
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453701E9B09;
	Wed, 18 Dec 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="BsVe/Zc6"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0001DB363
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537117; cv=none; b=uawX1cug/BlFCBp6jOXoHlVu2828iRWZ44qrxtkdZSRBtuROSPF7HJSeLm5q5AJXJnJlR6rxOKSFd83q/g3iahWqJEGRhRV4DNchD7nB1+35VL/XOE55K+EuR1OgW3Il+W2ZKTZQsTtzT2t1wsreeqy1F3GREzAzQuRUrwI8tAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537117; c=relaxed/simple;
	bh=01My02vUg66FtKUMzjhDA/6I+cAw7h1WXAjdi947LXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2lNpQT2zn4uZcpReAeyNdaE85sliG67JSRx17Sec7j8TGMnwSl3EinHZ8U2ufqdGz8POkqrGVGfg/lQU2tVOBmnTuzvyrF4w/fP5/q0fanVk9WsYgoAF0J+qFNEBDca1rQBvD4qHalD0oAX7qlwOxMdivvIQ4W5fO7VA5/ZhXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=BsVe/Zc6; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dcf62a3768so17306456d6.0
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 07:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1734537114; x=1735141914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4whGDZV+puG0fV38p1mWf5yb5JAddh1OIYmWwZJ4M54=;
        b=BsVe/Zc60hIRbBS1hAELDUeqvREO4V/G/Ki24hMmwQrkl/cWKht9Hlg3Q8wJG/vva5
         i3M3T6IpN/XApudzME1juTst1DJyVvPXtOYQ0cwwLcvY1QEv5mMdns1VgYywUCkvVtjL
         3XO8aoAzdiFL8OqC1grBGtIK8214pgPwyYwbQFz1FAhIObZUDM15I8C6IaxP+2OfyJeO
         ejURswdg8+P5AfKWD1PGBn6tuROezlkB5lBcWDNLjw7HmHq8ZJAzcnxXjiasdARCPXb0
         CNS1V8EHaVvdtobVzk/evtaRCPtSClZUb+mxdBYSTEYTaPSW2W2SdSvamTIu7ziU5v8S
         Do0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734537114; x=1735141914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4whGDZV+puG0fV38p1mWf5yb5JAddh1OIYmWwZJ4M54=;
        b=s8zms3Ho5N2S6nJ0Dis05pxLdDgOD84HNnVrSeTA4ofHwt8Q3b44vut96OwabIemKK
         EI5nvfLPpGrr/oRo7SQFIP85Qgs6c60GtWnLqG7t3Iv/EF+EFiLCDFxUIvAytgDpVOxJ
         otMzX4/rZYOVZ0KNJrzAXGFG//BINvSIPkdrU8bsNrtVHRy9KSAfA+n2iJ2GtZNOrTRT
         JCzLTM7NdiAB1gEnjjR8Ae0JQR3IVS5hZZpFFOW22SZh77yMoajuWMkU2nXCUonKNkzX
         esHSHng+ZcKJCxWTT6NPHPFUm77gtAppyzFYnG2Dc2aHwF6OQPahIOtayF/GlWpgXs34
         fUVA==
X-Forwarded-Encrypted: i=1; AJvYcCUy6P9j2Q/MB6v1AfO43QBrS612/j0ayvO3nvWA1rs6uM+XulzmgyGRzsua80oMUyoLukoq6xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjqxI/VCjpn5Y++/xdp519E2GAS/bW9/hvc5Jf4md1rHm7APRH
	G9vlQvdMvzQ8T7jtuUCMFBQm+1QlgBXP7aE3qcKgf1q6Cfn6g1u6VTCDh9qdlA==
X-Gm-Gg: ASbGncsj/w/SMl2F3/L+h0+23/zmgrIC4sM95MFDrBYlhENuHopsPb5TE0hM48RkhUu
	PJBCFmdlaub+bv65C6zSvVfJBzWyb6uBkey0XpkOcDk+Netu6H+OMrKB4intzbcqLhfIw361hE4
	e9atFgrA5aIjQ0MSHy29Jx58Wq5dGgGF+JDfU73jR6JcH1aR7hdR0VDuugBBOlMNZ7fi1WAJOjS
	37cEjDu4fBSHtZa+60Fb6CPdx5LdkFUiFYdalUGdFhBcg8pzdB6sstclCw1tldSzeXyLJj58GI=
X-Google-Smtp-Source: AGHT+IEJk78hnxsyKnXbPQoanGIsRf0N5bA35Q8LGZ05dCUcZQlkeUQ7pZumcNCfZHjUcVagmkur0A==
X-Received: by 2002:a05:6214:1d0d:b0:6d8:b3a7:75a5 with SMTP id 6a1803df08f44-6dd092598b3mr55798746d6.42.1734537114549;
        Wed, 18 Dec 2024 07:51:54 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd26e5a9sm50785616d6.56.2024.12.18.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 07:51:53 -0800 (PST)
Date: Wed, 18 Dec 2024 10:51:49 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, quic_jjohnson@quicinc.com,
	kees@kernel.org, abdul.rahim@myyahoo.com,
	m.grzeschik@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, alim.akhtar@samsung.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
Message-ID: <eaa330e8-0510-445d-8aef-b39164169cb1@rowland.harvard.edu>
References: <CGME20241208152338epcas5p4fde427bb4467414417083221067ac7ab@epcas5p4.samsung.com>
 <20241208152322.1653-1-selvarasu.g@samsung.com>
 <2024121845-cactus-geology-8df3@gregkh>
 <9f16a8ac-1623-425e-a46e-41e4133218e5@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f16a8ac-1623-425e-a46e-41e4133218e5@samsung.com>

On Wed, Dec 18, 2024 at 03:51:50PM +0530, Selvarasu Ganesan wrote:
> The issue arises during the second time the "f_midi_bind" function is 
> called. The problem lies in the fact that the size of 
> "bulk_in_desc.wMaxPacketSize" is set to 1024 during the first call, 
> which exceeds the hardware capability of the dwc3 TX/RX FIFO 
> (ep->maxpacket_limit = 512).

Is this gadget supposed to be able to run at SuperSpeed?  I thought the 
dwc3 controller supported SuperSpeed operation.

The USB-3 spec requires that all SuperSpeed bulk endpoints must have a 
wMaxPacketSize of 1024 (see Table 9-24 on p.9-25 of the USB-3.1 
specification).

Alan Stern

