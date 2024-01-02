Return-Path: <stable+bounces-9178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7CF821AFF
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 12:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CEE1F223C0
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 11:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4539EADE;
	Tue,  2 Jan 2024 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XryoqP6M"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DFE554
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7811db57cb4so697796485a.0
        for <stable@vger.kernel.org>; Tue, 02 Jan 2024 03:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704195128; x=1704799928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4CTXYQjDTx9MjNeWmQMbnj/JJ7KlKNb5ez8YnAlEmuU=;
        b=XryoqP6MDCAM1W1boSMn8ZBw8f+60nmm1oSpqP0kth0iGwh8i5ExfZgjnH1O9A1dqO
         H8jD6zUY6iOUe7pEuMt0M4MXSgAxbABixjJs5ByoVpRifB5O6qsiN9nHRQYMVDXhszCs
         aRJoUzFow+6QMg6R0KTpKWw+ZIxKWfPPBW1OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704195128; x=1704799928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CTXYQjDTx9MjNeWmQMbnj/JJ7KlKNb5ez8YnAlEmuU=;
        b=OCdfkONGY2DcChOSrXcnv50Pp9hZaxts3mhpBw7Dl0u8yLcEUjOUK1dh7M1gQweGzP
         2tOrmrCd9ZuMKv6sZnZi/ugCBrRpOnciq3muDK4XCKn/oY1T4oU5HqZujDE/cEnJb6nB
         xF4xMVtbAjeoDH+cwONI6LRJfILR2c28+XYRv28HIOHBbQrjWEURzd+Fu7AbuWOCKZk1
         E4UbcQcn3+LEonB4BuZHUfVY+Tgiu8b2zvYZG+Bz0Abdc1kJ3z1g7nsIM6iU4W6m3Vpe
         zSKczf/xxWoGp+NtImoKq147CR/pYqALZ5bZ633jekRBX7pWLPGGp7mN4LfrZn5XtOuD
         sU+w==
X-Gm-Message-State: AOJu0Yx1e2tw2/E/5r0IQzY7DeBYrKtqr/xoON0bw72qhblqwkUU8v8G
	6M/m/ZWnIfFJ2Q1mSAtkGNKOe6TrwqSY80gEQFu0rpcRXA==
X-Google-Smtp-Source: AGHT+IFawNil5W9TbiYgkDgyTiW77/pUrZGmdiJAi/XcvNXrMrch5AuWPx65MT9pc2zJXQKfLzwheA==
X-Received: by 2002:a05:620a:4309:b0:781:bd80:af82 with SMTP id u9-20020a05620a430900b00781bd80af82mr4522274qko.37.1704195127802;
        Tue, 02 Jan 2024 03:32:07 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id ay30-20020a05620a179e00b00781b2c3699bsm2049640qkb.132.2024.01.02.03.32.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 03:32:07 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4281f6400feso8628281cf.1
        for <stable@vger.kernel.org>; Tue, 02 Jan 2024 03:32:07 -0800 (PST)
X-Received: by 2002:a05:6214:2a85:b0:67f:67de:5d32 with SMTP id
 jr5-20020a0562142a8500b0067f67de5d32mr26610741qvb.41.1704195126792; Tue, 02
 Jan 2024 03:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222-rallybar-v2-1-5849d62a9514@chromium.org> <82bf432c-2a78-4b9c-88ab-ef4f0888e9aa@rowland.harvard.edu>
In-Reply-To: <82bf432c-2a78-4b9c-88ab-ef4f0888e9aa@rowland.harvard.edu>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 2 Jan 2024 12:31:53 +0100
X-Gmail-Original-Message-ID: <CANiDSCtd4-pQDdf03cBZz6deUe=b4ufiQ4WR=ddwjubOoxAQ1w@mail.gmail.com>
Message-ID: <CANiDSCtd4-pQDdf03cBZz6deUe=b4ufiQ4WR=ddwjubOoxAQ1w@mail.gmail.com>
Subject: Re: [PATCH v2] usb: core: Add quirk for Logitech Rallybar
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alan

On Sat, 23 Dec 2023 at 21:01, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Dec 22, 2023 at 10:55:49PM +0000, Ricardo Ribalda wrote:
> > Logitech Rallybar devices, despite behaving as UVC camera, they have a
> > different power management system than the rest of the other Logitech
> > cameras.
> >
> > USB_QUIRK_RESET_RESUME causes undesired USB disconnects, that make the
> > device unusable.
> >
> > These are the only two devices that have this behavior, and we do not
> > have the list of devices that require USB_QUIRK_RESET_RESUME, so lets
> > create a new lit for them that un-apply the USB_QUIRK_RESET_RESUME
> > quirk.
> >
> > Fixes: e387ef5c47dd ("usb: Add USB_QUIRK_RESET_RESUME for all Logitech UVC webcams")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
>
> Would it make more sense to do this inside the uvc driver instead of
> creating a new single-purpose list in the core?

I can try to move it to the uvc driver. But maybe it is better to keep it here:

The same vid:pid also has other functionality, not only uvc: Sync
agent interface, UPD Interface, ADB interface.
If we apply the quirk to the uvc driver, and the uvc driver is not
loaded, the other functionality will still be broken....

I expect to see more devices from Logitech not needing the
RESET_RESUME quirk... so this list will eventually grow.

Setting/useting RESET_RESUME in two different locations, can make the
code difficult to follow.

What do you think?

Regards!

