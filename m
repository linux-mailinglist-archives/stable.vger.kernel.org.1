Return-Path: <stable+bounces-105419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4749F92B4
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 13:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3C616DC31
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 12:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C45211A3D;
	Fri, 20 Dec 2024 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf69NTK2"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DFD215198;
	Fri, 20 Dec 2024 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734699564; cv=none; b=FRq9v1FmCtxrohUbXaanVTzHkPrT2sShmunTLE4C7aJK1aHKm2A33DqfPQrpGZjqfZ68/K2TLohShUAFrxihEYxHVkenrbO1J7s566PZQEfvmpmGmYALzGmUcGjSAH9iyjaKef0D3kUoLiDs+QhBEJZmXRJQ3SkUW/q0TCgvaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734699564; c=relaxed/simple;
	bh=jTJ/JMKXSucUBqeFkPpkA07iTkHSmZAi5QcYaX6SJI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+NMLJN049xkyiFDnc3SClFVnawI6L9wcK4rgvlsaWWcB7QIVKj57OYoBgxCiJcYjfzNxbR4UOg4PbyyVnAZK6mvLdtwhbpFVM8x3fC/ozfjon3IQxWsdGdpePTpwHo0LyMDtGdqcpYiRKxzU1MCTUN4bXp39IxKBD0T6QZTM4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf69NTK2; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so1433445276.3;
        Fri, 20 Dec 2024 04:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734699562; x=1735304362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jTJ/JMKXSucUBqeFkPpkA07iTkHSmZAi5QcYaX6SJI8=;
        b=Xf69NTK20csqsJnEt4+6R7PkG8wvAsjob24Y+XD5WjEiJj5BCYAIoLamuHjo6b88oq
         tbO+tTo2amg/dGKcrSFs9wLEzxfWrC5owr/w1UNVmQuzaFOkGxTp5NFNKkZSkSj17vvN
         0Lw+TwMuxLIJT/kt8BrJgiPtdlqfSZ7bUosLXCpQkZsmQjkefbb6mFUATLCpdHWwHfNx
         dG/aMVDefOgUUQ4bbbr7LQYkoMDxVK+Z/Rg2KWqAJxHHtCxCrWJe/IiaMgG2zXRYpe9c
         OYM7t+9wlKPjC9efXph38agWTghlcQTm6OzOTIAJYSdxmTy2bE4KvEKEI9DhtEqtdsQk
         Jmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734699562; x=1735304362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTJ/JMKXSucUBqeFkPpkA07iTkHSmZAi5QcYaX6SJI8=;
        b=Thg0pOz/Yzza28LYA0t81dqDIEug3n6OwgUrrdDP9K4HpGxxxjYqFQ4vYumN+1mjL3
         G2fb1speU9NZYwaz8i9LkpLFBUF1np67cb0CcpnPngz1WvflihKQfT5EBbpLTrn6J7mB
         dU8tSIiGnWPXx1pRbrlH1e6JGLLuG3+71azgzICrbn8vOS6eKklIaokqwyExFjv66I+x
         V3Txn2P+Br+aQ/uSvq5nt6QT432bzezEuB7QIo0E2A2bkVv2xTA/z9892vNbKDst6DMc
         5z4eHAhGRF5GDrwlWenE3i/WuEUeulzKzl1zJP7tc1ILptqhDEpKeVmcswG6NETmD0Et
         3Bfg==
X-Forwarded-Encrypted: i=1; AJvYcCWxHw/lDVXP9Fyyf9o6YXgadrjOO0M1HnXzpp/+zPgVxM/SkdBwuddyN+EKrzX1jcDwQIB9jzGc@vger.kernel.org, AJvYcCXOyNMclFkR9kMPvtRaQvVhZId/qP7d8Zms8QqfsIdOdHRJr91Abf1kluuWXQNWNPbQusYUe4pYV9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGtQOsH0VXU24gRE6omV2xTuDkVc1GW/wvQYDJiJeDr7w9vacm
	4f/jA3X2SJWUS9b6E1gJqltZ6UtgA3fcFQRfaC67ZIOEP7KTyWECju5EdXty5D0DYHdsMCidLi/
	XVt8SR1JFhqNIrFDc+ajRiL41e/c=
X-Gm-Gg: ASbGnctBbNGaDWbkWMeEHYRm4oz/UMwRBZ9za91xcREB5CJz9v/VKQdTjlPDKpM564R
	cTnVGE8Gm49zqH4OvastlC6UyGD7s0hEOhR30m/E=
X-Google-Smtp-Source: AGHT+IFyI0GKoNm/A5apMfHH94BMKCqF+2X3lH6IUJd81Qz78jSPYD9c4nN71SB8WhjsuE0H5lept1+AV6JgdEKjaKU=
X-Received: by 2002:a05:6902:18ce:b0:e4e:723f:caca with SMTP id
 3f1490d57ef6-e538c202961mr1890740276.5.1734699561815; Fri, 20 Dec 2024
 04:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
From: Homura Akemi <a1134123566@gmail.com>
Date: Fri, 20 Dec 2024 20:59:11 +0800
Message-ID: <CAC7i41Mqhfc7JOcF2SH4Mb2xm-Y1sD3c9Osty0SGxv7buYQYjQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/28] usb: gadget: f_tcm: Enhance UASP driver
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicholas Bellinger <nab@linux-iscsi.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"

Hi Thinh,

On 2024-12-11 0:31 UTC, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
> 1) Fix Data Corruption
> ----------------------
>
> Properly increment the "len" base on the command requested length instead of
> the SG entry length.
>
> If you're using File backend, then you need to fix target_core_file. If you're
> using other backend such as Ramdisk, then you need a similar fix there.

I am trying to do some basic rw aging test with this serie on my gadget board.
When it comes to target_core_iblock, the rw code is less similar to the one in
target_core_file or ramdisk.
Could you just spend some extra time explaining what cause the Data
Corruption issue and how can this fix it ? So that I could perform
similar fix in
target_core_iblock on my own, so a full test could start soonner.

B.R.
H. Akemi

