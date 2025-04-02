Return-Path: <stable+bounces-127430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE3FA795CC
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732963A93EB
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 19:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D711E1A32;
	Wed,  2 Apr 2025 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOjc2rcx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709661917C2;
	Wed,  2 Apr 2025 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621699; cv=none; b=EoWIE2x456trO/zQjCKKOkCxd9WonZcxOumgcXaG/QEnSgKdaf1hZ3tDPItk9fulNvXu/ZbuWYaKuoPY7s4ktOU8G3pIb33I0viSSFhYXGSJhpEAX4O4yRyKFwXVGPT7jhDmgZku6yAxqZDqTDQg37hVDYKPztUaN/kI8P859rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621699; c=relaxed/simple;
	bh=Y0CJoWpl3EeJ09Y6hm8dhwkjJsoPxwsv8MYXUF0IkkI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Wvz8DVEYc6/lQnd5G9DykGh5vNUA5R1DLQ8BXmB5KzwMl7Ov3AN/hf4ljk25h6tEvNLceu5/2wiFi5AMxQsFn9jPS408Jlyc95KVEJ9hGBpoXagEb5DDIZ4q9rcueb9Xuv6s70X8iESrEWhZqica9rVUuRKjuMV9O8KVoYtNnzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOjc2rcx; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dbf7d45853so29131a12.1;
        Wed, 02 Apr 2025 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743621695; x=1744226495; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding
         :disposition-notification-to:date:cc:to:from:subject:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0CJoWpl3EeJ09Y6hm8dhwkjJsoPxwsv8MYXUF0IkkI=;
        b=WOjc2rcxBDyJ9G7KHkNHm/9YEk0XTHn9nz+tXYMGxHeP3y8P/QiISyIa9jgpPaMCwA
         dAWBSquoHXjKn2qtPmIXD3ceFYtBPLDwaY5EpuT3d0UHKyy2mxtPqpMIszOSVzUMfHWv
         tRYD+Vi40gGj6+Spn6Lhu2Rt01TvD+doLAkzPtrIHCmXBtCZi7fAWSPl/Pq4+MG1gzYC
         ezrD8R5ws2XSRhI5uZsmrVA9ooV8XCjOmCynnB12u+RlyXNvupPFHwAHB7X8ecgPkVfw
         0ORvD549cAHb6lmyV3zg98nM9D4+2eKSenzpcrfXKnC8frzZWQ/YLHMyoCJwnudWHBuq
         polA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743621695; x=1744226495;
        h=mime-version:user-agent:content-transfer-encoding
         :disposition-notification-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0CJoWpl3EeJ09Y6hm8dhwkjJsoPxwsv8MYXUF0IkkI=;
        b=e1yJm+jEwdfTqtb5SP8kkaFUzfbCQdBZLoUIuUYWMDbSBr8T94gJoWdDA3Uzcoof8s
         6X6tn3SCg2Rwv+SyaacOWMcLnYE2hhueTNHlKHGUcCLM09WgUgK+7tMT9Bw0bUIAw+KI
         KNowcA8WHH560EgKrCd3q3Kg74a6cuRAJFFzPtbPfv2vqz2UePHYIqWfqo4dLrfvBOMg
         ru0J1P106njiFcRwVFRvO4YuhkWz2Z7HEOAWI9u9tD4DIAZ8+vW4OfD3rXCcIh6mRy9i
         h6sy7HBcsn3JagCKw5HjUvdfOqhiWbqFYm/FzXMbI9L+k96qAdRP+mRYYrvkK7YdZx9d
         iRbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs3zXxzzdzYZ3GWZp6RVxZnyirsBEBTtG0C7MtQJfYLX1Ov66gqYAjVqmft1JGpzJovBhdGD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqLxRDJpsLknUe+Gv5WxCUjXJ+w+69K8Y6zNmTa/z6FyHcUZbP
	8i9btQOJ+lZHuWXEyWWBzXq6MJPRBp7kWnxRbQc151yJpaSpF7rQmVnqWw==
X-Gm-Gg: ASbGncu2RKM7ECmuvuisgB0vi20KWJzcI+q1S4H/moUpkxMZgxIOrE9QYlkwcgco4v1
	D0tpVlfpp9779fudA5O3bekxgvP5zIMgGsQ18F1ivz+fiC5Gr0KhhtyHW9WBkovhQSrVVk9tqoB
	BleBJuMe2g9m6YHOz1tOZj0K1OR21fQOA0qrtsQQBvOT+FcGH+4oEP9NuwvlC1mdyH8pmpB3rau
	lzf0GD5cC5BwJI/vHgq0wtEsHlXzEgmDt6ZKnQaI5wWVdOlt/i9ycHYzpuDU6kKvYCT6IDuEfZ5
	Rf0LI46H/pM6WU6wDdYfFkgNxP9s9Wp7KCrQOI9Z5fsJFWpXCpnvMhtJ1soqk4G6g4YSU6cocHq
	GXSToTMjaKhFnX/75ZrlmTA==
X-Google-Smtp-Source: AGHT+IFiQzV9o9e7nDkOOcJEinOSM0/JLY+RhChkW9DUoFCOY0jF5RPJcHwkT1do1xB278YUakWHmg==
X-Received: by 2002:a05:6402:1e8c:b0:5e0:36da:7ae4 with SMTP id 4fb4d7f45d1cf-5f03bfbf084mr1997409a12.1.1743621695196;
        Wed, 02 Apr 2025 12:21:35 -0700 (PDT)
Received: from [192.168.1.239] (89-64-31-184.dynamic.chello.pl. [89.64.31.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc17e0704sm8822861a12.66.2025.04.02.12.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 12:21:34 -0700 (PDT)
Message-ID: <a0f1dae5eee091781711d3b4ebe812b9a1f8c944.camel@gmail.com>
Subject: Request for backporting hid-pidff driver patches
From: tomasz.pakula.oficjalny@gmail.com
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: sashal@kernel.org, gregkh@linuxfoundation.org, oleg@makarenk.ooo
Date: Wed, 02 Apr 2025 21:21:31 +0200
Disposition-Notification-To: tomasz.pakula.oficjalny@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello

Recently AUTOSEL selected some of out patches to hid-pidff and
hid-universal-pidff. Though I looked over what was selected and
everything will be working, I'd like to keep the drivers up-to-date at
least going back to 6.12 as these kernels are widely used and leaving
said driers in an incomplete state, not up to upstream might lead to
some false positive bug reports to me and Oleg.

Here's the full list of the hid-pidff related patches from upstream. It
might look like a lot but some granular changes were recorded as the
driver was in need of an overhaul for at least 10 years. This mainly
touches just two files.

I tested it personally and all the patches apply cleanly on top of
current 6.12.y, 6.13.y and 6.14.y branches.

Thanks in advance!

e2fa0bdf08a7 HID: pidff: Fix set_device_control()
f98ecedbeca3 HID: pidff: Fix 90 degrees direction name North -> East
1a575044d516 HID: pidff: Compute INFINITE value instead of using hardcoded =
0xffff
0c6673e3d17b HID: pidff: Clamp effect playback LOOP_COUNT value
bbeface10511 HID: pidff: Rename two functions to align them with naming con=
vention
1bd55e79cbc0 HID: pidff: Remove redundant call to pidff_find_special_keys
9d4174dc4a23 HID: pidff: Support device error response from PID_BLOCK_LOAD
e19675c24774 HID: pidff: Comment and code style update
c385f61108d4 HID: hid-universal-pidff: Add Asetek wheelbases support
1f650dcec32d HID: pidff: Make sure to fetch pool before checking SIMULTANEO=
US_MAX
2c2afb50b50f MAINTAINERS: Update hid-universal-pidff entry
5d98079b2d01 HID: pidff: Factor out pool report fetch and remove excess dec=
laration
217551624569 HID: pidff: Use macros instead of hardcoded min/max values for=
 shorts
4eb9c2ee538b HID: pidff: Simplify pidff_rescale_signed
0d24d4b1da96 HID: pidff: Move all hid-pidff definitions to a dedicated head=
er
22a05462c3d0 HID: pidff: Fix null pointer dereference in pidff_find_fields
f7ebf0b11b9e HID: pidff: Factor out code for setting gain
8713107221a8 HID: pidff: Rescale time values to match field units
1c12f136891c HID: pidff: Define values used in pidff_find_special_fields
e4bdc80ef142 HID: pidff: Simplify pidff_upload_effect function
cb3fd788e3fa HID: pidff: Completely rework and fix pidff_reset function
abdbf8764f49 HID: pidff: Add PERIODIC_SINE_ONLY quirk
7d3adb9695ec MAINTAINERS: Add entry for hid-universal-pidff driver
f06bf8d94fff HID: Add hid-universal-pidff driver and supported device ids
ce52c0c939fc HID: pidff: Stop all effects before enabling actuators
3051bf5ec773 HID: pidff: Add FIX_WHEEL_DIRECTION quirk
36de0164bbaf HID: pidff: Add hid_pidff_init_with_quirks and export as GPL s=
ymbol
a4119108d253 HID: pidff: Add PERMISSIVE_CONTROL quirk
fc7c154e9bb3 HID: pidff: Add MISSING_PBO quirk and its detection
2d5c7ce5bf4c HID: pidff: Add MISSING_DELAY quirk and its detection
f538183e997a HID: pidff: Clamp PERIODIC effect period to device's logical r=
ange
8876fc1884f5 HID: pidff: Do not send effect envelope if it's empty
37e0591fe44d HID: pidff: Convert infinite length from Linux API to PID stan=
dard

Tomasz

