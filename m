Return-Path: <stable+bounces-89839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B39BCECF
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 15:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D89B21182
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEDD1D9A54;
	Tue,  5 Nov 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DKA2vlAR"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496621D88D0
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815977; cv=none; b=E2ejlINVeX3WCNxxagbbUOunR9PiNwHXaIRTMVrYD6EoOHYz3Sf19NJ+/l0tmH+b7m+xz8Kwh3JEQrawuA5BKxtSPfWGolmGSIqhhN/Bmw58rZSwB2WFcksSqisMAagGy88lxKgpWNoDcWzKUx5xP4+k3D5NjCBBUmW76iblxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815977; c=relaxed/simple;
	bh=hUkwBIFaHgKGdSZE77G6VlJhtFjXldaYVov83tYixZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgJfU2Sisi3K9U8jsLpJpml0ocv11bO9rd3p7f6YneWsQ39nD60Jys53nk0qgqQUIBihFIa5iIhiV3c/9hsNSjsUiZolajOWv4hr5LtbNXiVyQOcLAr1kmj5I0+mjmhSshaAzr08SEuuR3/oweAFz42bvssOW6lIUsyiZ4HbbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DKA2vlAR; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a4e5401636so19546085ab.3
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 06:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730815975; x=1731420775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d8Xdl2YqDUk9A0/HsJ2W90hRe4mWgrUkpYm3OC0EsMw=;
        b=DKA2vlARsMc9tmPYM0La6HZfNKpvmRr0/gZOBQwHIJ1FWV9UvXcUgJhSbytE+2lB8j
         HC+Km7XMVQsPU4aI975HqsKrH3M9jVu45aL4FpVwJKOfsf/QRZZgeKVjyxTR1ZsoA/PS
         0fg7Sl9tavPOaWB4clvUdFOuerTl079hnGsbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730815975; x=1731420775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8Xdl2YqDUk9A0/HsJ2W90hRe4mWgrUkpYm3OC0EsMw=;
        b=HpmY4sE8T1jpOmLyvqSdBAss3PNnTwqwJld6ymvnwhQnR4nK82Q5gu85pX//CDYurd
         f9wnfATpun90z4TPjNojH/NCndS295Mgy5pQfFhlIVGVn3s/uU+iVTgFFJxT2H8n9tv8
         bMiRAugEZCLkHAi0mPCBO7y6SUuGbtWUYaam6YBthuX24e9JGdD2W5LIOgoDv822DTZr
         jA6eSjdkdD8qgCicQYNnbMwhuYPc/o5+g5LMzAUiLRaoWO41mICL28bzwfH5jOg2gT3q
         Z69yqJGsTB69YiBtn8Afogl1djyEYvJhnN8ACgGoB8iVVZXHSVtBG2Ox44iF7fLa0eiA
         lTeg==
X-Forwarded-Encrypted: i=1; AJvYcCXrJCIM8UeujtY9ej3SrmfSg1Z2ZHHmKadb6aBhjvQrhF6Mq3gzmT2tOVDH7EW5b9N+AxT9CwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXSDMEERwAoSc/VK13bIMaksmXmtU5t9cHNdURcPGFWGA/D/0g
	3xKwP4qQStm9rYPpVbMCZgtkMSPQ7gVlxnNBLHDClI1s2cCDZerEEwotRVotXrPyOpdQx/UJCBw
	=
X-Google-Smtp-Source: AGHT+IHXtPNCMao09Zabh5nb2STD39JOYxQJneSFxCTV/ROl/eSqvQgLEs640+hOX9VqfQCfuIe0fg==
X-Received: by 2002:a05:6e02:1d9d:b0:3a3:632e:f009 with SMTP id e9e14a558f8ab-3a6b03b2302mr128306255ab.26.1730815975177;
        Tue, 05 Nov 2024 06:12:55 -0800 (PST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45298646sm9124046a12.18.2024.11.05.06.12.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 06:12:53 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3596174a12.2
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 06:12:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQ0lHXmaFPa3px95GACmchOBqHpoMwpuhAzRp/iQeVepaZDAE8JVFjVfYbWdXBMQlJhPA3FDw=@vger.kernel.org
X-Received: by 2002:a17:90b:2803:b0:2e0:7560:9338 with SMTP id
 98e67ed59e1d1-2e94c517581mr23012661a91.25.1730815972500; Tue, 05 Nov 2024
 06:12:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105-uvc-crashrmmod-v4-0-410e548f097a@chromium.org>
In-Reply-To: <20241105-uvc-crashrmmod-v4-0-410e548f097a@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 5 Nov 2024 15:12:39 +0100
X-Gmail-Original-Message-ID: <CANiDSCvC1T40ozrjsEfTQnnvE83YeSbELaO04027FR=FkpwD7A@mail.gmail.com>
Message-ID: <CANiDSCvC1T40ozrjsEfTQnnvE83YeSbELaO04027FR=FkpwD7A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] uvc: Fix OOPs after rmmod if gpio unit is used
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	stable@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi

Please ignore this version. I screwed it up when I prepared the set.

Sorry about that

On Tue, 5 Nov 2024 at 15:06, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Changes in v4: Thanks Laurent.
> - Remove refcounted cleaup to support devres.
> - Link to v3: https://lore.kernel.org/r/20241105-uvc-crashrmmod-v3-1-c0959c8906d3@chromium.org
>
> Changes in v3: Thanks Sakari.
> - Rename variable to initialized.
> - Other CodeStyle.
> - Link to v2: https://lore.kernel.org/r/20241105-uvc-crashrmmod-v2-1-547ce6a6962e@chromium.org
>
> Changes in v2: Thanks to Laurent.
> - The main structure is not allocated with devres so there is a small
>   period of time where we can get an irq with the structure free. Do not
>   use devres for the IRQ.
> - Link to v1: https://lore.kernel.org/r/20241031-uvc-crashrmmod-v1-1-059fe593b1e6@chromium.org
>
> ---
> Ricardo Ribalda (2):
>       media: uvcvideo: Remove refcounted cleanup
>       media: uvcvideo: Fix crash during unbind if gpio unit is in use
>
>  drivers/media/usb/uvc/uvc_driver.c | 30 ++++++++----------------------
>  drivers/media/usb/uvc/uvcvideo.h   |  1 -
>  2 files changed, 8 insertions(+), 23 deletions(-)
> ---
> base-commit: c7ccf3683ac9746b263b0502255f5ce47f64fe0a
> change-id: 20241031-uvc-crashrmmod-666de3fc9141
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
>


-- 
Ricardo Ribalda

