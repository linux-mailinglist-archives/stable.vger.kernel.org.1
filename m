Return-Path: <stable+bounces-169447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1268CB252E2
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 20:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26DC620F1A
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 18:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8B1276054;
	Wed, 13 Aug 2025 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="JrTh/BEB"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81388191F98
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109177; cv=none; b=Y5Zo+iR+Mf5KHt05wPJc1rJK4uBqJMnxIAuG8mHE2zq0FPsG7wZa3z6wCsBspDffABE0B+F3NSiYxSxwkWg1Ve0M/2Wm0+lNywcp2OTMuHjN0MoYDgqk1zUryQREnD5dpivtfyW3q6ozQ0+aXOv/b+YKQW4oTlfPwxpH2KlR9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109177; c=relaxed/simple;
	bh=iD0th0JPT9XvS0OT+NlKvnds6lV5srAjhD+Ek1vOBmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+BQUdlCbYQRG0435/c980zEdvfLxSNcLlVt4YzxdP/KKLpcOaiGbfuIDDc/IJx8RbMNUO6Hri6tPFXEcLZiV1cPj7c5Zvc7ArCqDDT2PDxfjtQjSPN1qY44+cvbrr8gjBlP8FuLtyMUWYrdoN6+HqOwJbAbuVH/JcwCxPKiXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=JrTh/BEB; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70a88de7d4fso1939076d6.0
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755109174; x=1755713974; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+EddfMazfmOOVzuGouJhvs/WQquMhL7Ov9e7tsnnf4w=;
        b=JrTh/BEBe+eiHnrv7LLDsDJb2uoDcogn6bVEFOZkiLtamoLTC4zqya6aCxRXxo2CeK
         fuvffVTHyrY4WmMib4X1WlXPTDkJ6/LgdQexz9JGXT+rR+n7r+Vu5RriCTX75oCU5DiI
         uVhSxEYaPH76f7RDrzpa5PYVweAuIfOm4LAy6C3cbK+/Qb5ydDNdPfCHupjhoGgv0UT5
         zIcr2rBw9S6Uxmp2AkXq0qVvo2bMk0dSjPZEKnuLWBVOzW6AqKRheeCCNlhu2dTKt5cB
         Ix77ohwiseXno+Ja2ctGi4YU3Lr8c/6GRl18hbUU4Z9uz/JdCRqRCe41eJzMm5Mzo5Q+
         UPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755109174; x=1755713974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EddfMazfmOOVzuGouJhvs/WQquMhL7Ov9e7tsnnf4w=;
        b=RkTv9WZX0ud6BVS06wjUikucwR2QWRrXcklGulvUyhBtaTXFOw01GkV01MLjb0vRCt
         tMPMd02ZMseGOH3IGpNQ72Gb3+HKUQ7HN5nuOcndLeeM2lTajLZEeMAiyz0CKE3cfoLY
         n7YzlzYevw8JdtSX7A+8n4fLXrtkUv5eVG4Imyrk1mVkF2DYX8iZ7t/Ad+B+uWy96pwg
         LTzeX2n1uVdn2GUZCoqbKc9w1o2wRYSGmGj+Uy8hpMgtb3WRTy0tYKdJQJV/ED3k1gkm
         3gSCWixT17YSrfQtnzleN1osCkxUKO3tjlY8I/i2PPjnhVGSJX1FEu/m/ywwsI8JqNKF
         6RlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcDbtjSDIjNgD3IjOr72l4ZKGkpBBly6ymnL3Ymn9QaW2qcF+FohrMZA83lVMPTs83afZ3P+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBjoMmbuvm4srMNHgW2K2Hz6fZ/vfNCkkqKAXpKYyj+UimwRVi
	ouPfL/y2w1AnYgsLn8F34kxRELDhPGAmBSoT6+0iDhClegndPfxTpHQZfXnM7P/A4Q==
X-Gm-Gg: ASbGncuZ8P9DLYOSpNuc793u8evgGqZeIEd4UCBLQLUvvmtTQ/oKiWrG+uQMaU/Uod8
	pUiTKWUpCQpfYTnEn7KvxTAQSlmi5QokLC39oKWVc4TtssJXB1mHNNbiuo7Qa5YerTopowAYEqE
	lxFBQpeknYUL2T6DqMKJCjOjUgiTTWesaR3jZEmq+f14GISMfCHDF5lj4EDySX+wTbs5TegNTIX
	lLbidanNqRoyIrJEZ1yHQWUDY4dGBLsbzxCIPq8Jj5/JFS/k/MsHL/JkxUf021k4MSJJB9aC5fL
	f2LwM0FaT9R82EnZIcQAT4Za3tls+eKOS4oFWY6HgF/anivWb/Z+1iiFb7p9Mt6qcvrz6tzgOu1
	p0Xw97VpRflYKvbFm3ZN1VVBhU4yd2qf924WKxzHU99GHpI6cb3edrbPtOTewBzvXqw==
X-Google-Smtp-Source: AGHT+IHKYi8hdhJJIgu/bCYBOlGTkEfmfhsKUWy4uhRFa7m1jaX30iy/xegLNRbs2iwR0T2ioiWIeA==
X-Received: by 2002:a05:6214:2307:b0:707:6c5:55ad with SMTP id 6a1803df08f44-70af5c0002emr4387246d6.12.1755109174206;
        Wed, 13 Aug 2025 11:19:34 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:349c:f507:d5eb:5d9e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5c1df31sm1233556d6.81.2025.08.13.11.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:19:33 -0700 (PDT)
Date: Wed, 13 Aug 2025 14:19:30 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Zenm Chen <zenmchen@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, pkshih@realtek.com,
	rtl8821cerfe2@gmail.com, stable@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, usbwifi2024@gmail.com
Subject: Re: [usb-storage] Re: [PATCH] USB: storage: Ignore driver CD mode
 for Realtek multi-mode Wi-Fi dongles
Message-ID: <03d4c721-f96d-4ace-b01e-c7adef150209@rowland.harvard.edu>
References: <ff043574-e479-4a56-86a4-feaa35877d1a@rowland.harvard.edu>
 <20250813175313.2585-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250813175313.2585-1-zenmchen@gmail.com>

On Thu, Aug 14, 2025 at 01:53:12AM +0800, Zenm Chen wrote:
> Alan Stern <stern@rowland.harvard.edu> 於 2025年8月14日 週四 上午12:58寫道：
> >
> > On Thu, Aug 14, 2025 at 12:24:15AM +0800, Zenm Chen wrote:
> > > Many Realtek USB Wi-Fi dongles released in recent years have two modes:
> > > one is driver CD mode which has Windows driver onboard, another one is
> > > Wi-Fi mode. Add the US_FL_IGNORE_DEVICE quirk for these multi-mode devices.
> > > Otherwise, usb_modeswitch may fail to switch them to Wi-Fi mode.
> >
> > There are several other entries like this already in the unusual_devs.h
> > file.  But I wonder if we really still need them.  Shouldn't the
> > usb_modeswitch program be smart enough by now to know how to handle
> > these things?
> 
> Hi Alan,
> 
> Thanks for your review and reply.
> 
> Without this patch applied, usb_modeswitch cannot switch my Mercury MW310UH
> into Wi-Fi mode [1].

Don't post a link to a video; it's not very helpful.  Instead, copy the 
output from the usb_modeswitch program and include it in an email 
message.

> I also ran into a similar problem like [2] with D-Link
> AX9U, so I believe this patch is needed.

Maybe it is and maybe not.  It depends on where the underlying problem 
is.  If the problem is in the device then yes, the patch probably is 
needed.  But if the problem is in usb_modeswitch then the patch probably 
is not needed.

> > In theory, someone might want to access the Windows driver on the
> > emulated CD.  With this quirk, they wouldn't be able to.
> >
> 
> Actually an emulated CD doesn't appear when I insert these 2 Wi-Fi dongles into
> my Linux PC, so users cannot access that Windows driver even if this patch is not 
> applied.

What does happen when you insert the WiFi dongle?  That is, what 
messages appear in the dmesg log?

Also, can you collect a usbmon trace showing what happens when the 
dongle is plugged in?

Alan Stern

