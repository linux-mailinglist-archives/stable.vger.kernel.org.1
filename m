Return-Path: <stable+bounces-135117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E96AFA96A3D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3AA3AE172
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B5B27D788;
	Tue, 22 Apr 2025 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOdimk3z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FE027CB21;
	Tue, 22 Apr 2025 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325467; cv=none; b=qRpTrew6t1McL4RiGHoCwjxMDW+CEHBELvF7jAStAii0c0nmHuBOknVyuw3ea656xrGuHEblyhqkjM/s/i40AhcY9w59V3UnVPhh9aFAQa7gMdFsCTHp95r1FRsGIdvXWmA2gMsjiJbnTG93e7lep1Hp1sHYphRTj8iYo20K40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325467; c=relaxed/simple;
	bh=5++CXGqJ/VRGShZi5qqauBF5iTQ2WTuZld6B+qr1T6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIvb/VmGjee0R1dP3jGzPVLA7JZHh4sUqU3mSks4Uv0WUwFCqXwrYShXcROuuunspJI+WT4vw3wyMg3I2dR5YKaJ3f/QoNja3eH4HCNzUTWYFtpp189FqQYdzh8ygZlaiAuNOaVhsKsE/EylARHlDk04EVIl5wiQcSizWWBpo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOdimk3z; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e8484bb895so1518485a12.0;
        Tue, 22 Apr 2025 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745325463; x=1745930263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oIMgdv9Fb6EE4MBN//FDgv2UuKNr/XbHStXHIMq6lj8=;
        b=TOdimk3zupNQ9ZPaftXPsIkizK82BV6paq5ESnIVvRMLdkG42YLTHRwz0+3NExbfVd
         +aV4G3unXFBv6kHhIokV02nCSEcs6XkT//PjTJEVpBVCoE2Z0Jz4aqIb9jWeOBtruK3z
         eUMjzyVfBwSsLtYpqqE0BHL4ZgNrSEk3zfol55BGqJsNGL0ZckKL5C27HkTS01fDy0Qb
         95d9mbBdz/iJSPsTHsQ2LcAgCvfhB+jXoCd9cwbi5aRK3cQLGUEvXIqjrC+OF5YaZ5gh
         6Ybu/4Ik8heH27ozd1zX5aqKNSykHRqqb+fZl6k7cHYgqLUZH6Ihin7y7QfcNzb9hFo9
         4KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745325463; x=1745930263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIMgdv9Fb6EE4MBN//FDgv2UuKNr/XbHStXHIMq6lj8=;
        b=bOzHjm5HsBFXUQVb3HzEX7MuTkxxBNo9LTF10qaL8WNM3LVV03b9qD4pm+4Htok1ff
         mjTv1RFxd5zId+p+sGmSWjB/wc95Qr+cfgU1O/u5lG/2VsaNYRdtqBY3opRY+jYrcfAh
         cmF+quN7Z711VKGjNsgd8Qeb45WDW+Y6kNm1VcbLZdZJEX4Q+TbQ2WGoR6h5vwNcL+0Q
         RXBu4BUyhuBdC4U1jNl4PiGGSD9sQ8dKyH6h+sr03vqvBfkyauffBdD1QYCDts3kZp6G
         RpqFGSg8l3II4mt6ysx/HeCZg3zkQQ2aGwmsBT0/U/ojNvWFlr2JsuLZQIf293jLgeSD
         XADA==
X-Forwarded-Encrypted: i=1; AJvYcCWIwG4HCXXVwF0BnAtXpn8Q15U0zN+BDLRRoushZ+ZUqndrV1Gs8ALC2Wfuf1ov4vOir7TpaoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkHNJKa2sMR0haOVYsCBGLeyUppEeokyqJKWY19FQInMAC9Kf9
	Mvk9e7prB2unm+QA+KWMqP06jXdDadooUUmSYfkU5yoUZMksCkvO01eCjQ69nYilyx8GsskwxiW
	F7nPc6f+YKAguMOOt+N58ZLw//Fw1KQ==
X-Gm-Gg: ASbGncv9n3p8RczfdnTFbmX340XatR9oL4q+E8rfzi7j6F6fns+CbrxtIPHmoKI+WaD
	9tnM5jq0f+ubhkjY16eaa4KVMZzsu1ryt7HQsg3Tb4JRxTFZJwv3SNow/IAQfr7Y2aD360Lqzwx
	Q081hVTN0yET26AEqP3fda
X-Google-Smtp-Source: AGHT+IE3W92cMWfYLvX8mMoKUzSc+00nckobxA9v4u1h3qiyahwGO9GOwnH82LPo7Wzub/aXdlUzfyxLiyoTIab5G7o=
X-Received: by 2002:a05:6402:3513:b0:5e0:803c:242a with SMTP id
 4fb4d7f45d1cf-5f62860d4afmr4778734a12.8.1745325462825; Tue, 22 Apr 2025
 05:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a0f1dae5eee091781711d3b4ebe812b9a1f8c944.camel@gmail.com> <2025042201-cinema-overpay-c3a3@gregkh>
In-Reply-To: <2025042201-cinema-overpay-c3a3@gregkh>
From: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Date: Tue, 22 Apr 2025 14:37:29 +0200
X-Gm-Features: ATxdqUFUX7t-c-fziSvIqTSdDurwIawhA_ikilv8c-a-84OT68iBEgyyFX-rITo
Message-ID: <CAFqprmxZXSt8R+dnD1byfvS19gPFCur0=rQzNovd0sO7P0JVJg@mail.gmail.com>
Subject: Re: Request for backporting hid-pidff driver patches
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, sashal@kernel.org, 
	oleg@makarenk.ooo
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Apr 2025 at 14:35, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 02, 2025 at 09:21:31PM +0200, tomasz.pakula.oficjalny@gmail.com wrote:
> > Hello
> >
> > Recently AUTOSEL selected some of out patches to hid-pidff and
> > hid-universal-pidff. Though I looked over what was selected and
> > everything will be working, I'd like to keep the drivers up-to-date at
> > least going back to 6.12 as these kernels are widely used and leaving
> > said driers in an incomplete state, not up to upstream might lead to
> > some false positive bug reports to me and Oleg.
> >
> > Here's the full list of the hid-pidff related patches from upstream. It
> > might look like a lot but some granular changes were recorded as the
> > driver was in need of an overhaul for at least 10 years. This mainly
> > touches just two files.
> >
> > I tested it personally and all the patches apply cleanly on top of
> > current 6.12.y, 6.13.y and 6.14.y branches.
> >
> > Thanks in advance!
> >
> > e2fa0bdf08a7 HID: pidff: Fix set_device_control()
> > f98ecedbeca3 HID: pidff: Fix 90 degrees direction name North -> East
> > 1a575044d516 HID: pidff: Compute INFINITE value instead of using hardcoded 0xffff
> > 0c6673e3d17b HID: pidff: Clamp effect playback LOOP_COUNT value
> > bbeface10511 HID: pidff: Rename two functions to align them with naming convention
> > 1bd55e79cbc0 HID: pidff: Remove redundant call to pidff_find_special_keys
> > 9d4174dc4a23 HID: pidff: Support device error response from PID_BLOCK_LOAD
> > e19675c24774 HID: pidff: Comment and code style update
> > c385f61108d4 HID: hid-universal-pidff: Add Asetek wheelbases support
> > 1f650dcec32d HID: pidff: Make sure to fetch pool before checking SIMULTANEOUS_MAX
> > 2c2afb50b50f MAINTAINERS: Update hid-universal-pidff entry
> > 5d98079b2d01 HID: pidff: Factor out pool report fetch and remove excess declaration
> > 217551624569 HID: pidff: Use macros instead of hardcoded min/max values for shorts
> > 4eb9c2ee538b HID: pidff: Simplify pidff_rescale_signed
> > 0d24d4b1da96 HID: pidff: Move all hid-pidff definitions to a dedicated header
> > 22a05462c3d0 HID: pidff: Fix null pointer dereference in pidff_find_fields
> > f7ebf0b11b9e HID: pidff: Factor out code for setting gain
> > 8713107221a8 HID: pidff: Rescale time values to match field units
> > 1c12f136891c HID: pidff: Define values used in pidff_find_special_fields
> > e4bdc80ef142 HID: pidff: Simplify pidff_upload_effect function
> > cb3fd788e3fa HID: pidff: Completely rework and fix pidff_reset function
> > abdbf8764f49 HID: pidff: Add PERIODIC_SINE_ONLY quirk
> > 7d3adb9695ec MAINTAINERS: Add entry for hid-universal-pidff driver
> > f06bf8d94fff HID: Add hid-universal-pidff driver and supported device ids
> > ce52c0c939fc HID: pidff: Stop all effects before enabling actuators
> > 3051bf5ec773 HID: pidff: Add FIX_WHEEL_DIRECTION quirk
> > 36de0164bbaf HID: pidff: Add hid_pidff_init_with_quirks and export as GPL symbol
> > a4119108d253 HID: pidff: Add PERMISSIVE_CONTROL quirk
> > fc7c154e9bb3 HID: pidff: Add MISSING_PBO quirk and its detection
> > 2d5c7ce5bf4c HID: pidff: Add MISSING_DELAY quirk and its detection
> > f538183e997a HID: pidff: Clamp PERIODIC effect period to device's logical range
> > 8876fc1884f5 HID: pidff: Do not send effect envelope if it's empty
> > 37e0591fe44d HID: pidff: Convert infinite length from Linux API to PID standard
>
> I think Sasha already got all of these, right?  If not, what ones do you
> want applied specifically?
>
> thanks,
>
> greg k-h

Yes, they are all in the stable trees now. Nothing more to add.

Tomasz

