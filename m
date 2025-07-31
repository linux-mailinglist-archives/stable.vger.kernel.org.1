Return-Path: <stable+bounces-165644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7711EB17047
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 13:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AF81889035
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 11:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200F02C08A0;
	Thu, 31 Jul 2025 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imtu3gCT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA03285C91;
	Thu, 31 Jul 2025 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960843; cv=none; b=p7b0oNHA1wdQNq7XTuCSrnrYNopAXQKMDUJER0iztpPPYyEzwxbHzToziBV/fxwqci08DQL16n9Q9zrMkcdeHO233eISOBXkklnqtfC/tc2hWi+wpB/w/OU9+j6CZiTmLmOdpKgmtovDRopxnQDsbjC5zL4Ig685o1W7uhIbDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960843; c=relaxed/simple;
	bh=zNgxjaQ7TBbud4j44x9c2Copx9m2P7UDNyslxhRB+KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRZk7ZuX459qwog9wgQ1z5T9Ycr4A0G3a+nLplmdQISjMgCS/Znm9DkjzOC6TYOYgyFlal1qGdaiBGTyVLc8qC2LPhgF43rL9SLf87WhAocXVgHjRt/JoTv7sfI6xgRwnmbLTNUu5z9EDbvWukbBepPMBGHNfnrDE1rZeNX9mYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Imtu3gCT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4560d176f97so8321395e9.0;
        Thu, 31 Jul 2025 04:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753960840; x=1754565640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6PgXUv73S1mAGJQxOfImzqpGCJJWM1Hp3ObYIgxXfns=;
        b=Imtu3gCTKyJYPBwIadRdMHa7S7uC2eNZnOcnyNZ2W5L1mNYRi0y0BW0DfvhWvO8oI1
         MNjNxbSmWHTjQfHIV7nAJdecyNB2/hHD4blejCS5DzKHl6puaT2lNlTRLpGdzK6APsO1
         mAVwbgxKeNexE8iu6GIFqnTRXf+KjwtONihUh17Q3F8Mae7GUFJN10GD0UuCxCzG5AqQ
         t26Xon5s0AOaV6z7OAuxt0E/QB0kUxaqy06+a45m0WoBJ9KCG+p5a5R5AWa3tGPkWhSx
         9fUOnvFKM/s7y/X4rrfeEdHXySCXhHutbtR8B1S0aORrxZJcq6yOAGoITu194MQPna1x
         ctmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753960840; x=1754565640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PgXUv73S1mAGJQxOfImzqpGCJJWM1Hp3ObYIgxXfns=;
        b=G9P5UGHqSi9QaGCcegP3svOzmdwSaTbwIqRFCZgMjaFJppf1tnRJ1z+bibuQ4nHCP/
         cMHLM0P13NG0lNqpJsn1VvuyT0gQ/BnJvtCqJzq/VYkRy9b7DCG6a0m3RUv/iJ+HgXzH
         1vNHqTWUie4nPG/8z8of4p11FCeL9+FWNl/YhWOfelFBkJxrLpVOT5n+YpuZoa9Ef8zs
         USxGRjKWslQeklr0UrP9tbUpRipKLpuZsqgyYge2k1XqUL+Dl70vgD5N2kSRo7XHXCiu
         YDsMQ6C598p/8bjQztuoAJtUh+9t8MG9cCj5Wmu+CMlYtFwoyM5sOt6P+fYHIMcdBuqg
         PiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUnwc2eF/WnrfiEhXKKa/mH6Ce7iMPLT0eEVg1tP0Pviv/dscT0MvjuPMSUVvaK/I30QkdImSe@vger.kernel.org, AJvYcCUrPjALpChE8uV5OK/CShMATW5QBikj+h2Qs7V2wSJf5jQvdyPEPSvoyZv+86fQQQVkFJuRfnWIENnhpzad@vger.kernel.org, AJvYcCWc289Saa+/PCADQAF9t0bHiEjdXVAWbxOIhozgSPLtJFZujRXsQkdVrA+JjIYFAYhMXRZnpqbalnqIEU1Izeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhEhwLF5xMbavRIVN9woj02RfzbZn6iHwDzWLi3p8Ns4Ecu8Bo
	zf8yxF1zrYN+o9jO5AbrXRgvME/DsdQzrYSnqGIFTNx91I8n8JEWVuZ7
X-Gm-Gg: ASbGncv3DtzOOQMH71EI8SwLAdj8eKx8KgBEDgwyD8onCP4NdriNFPWb8oTLwlIKcOn
	ANRPCH7cv4B1oarL3JnNWkb0NzZwWsvHnLBsAwuE/4yN2o1ptEErB38S/654dwYRlRVfrfJo5YF
	PRtDpcuotO0zMgBv6CHtFwbu8PWHg0Kc2OGMvRa6gA9v+jf6EEhwXGrBBxz04u3WXiaf4ydpFJg
	6SGbN6eFTnWRVZO2Tx9Xw4EMX6krr/mNJkqhyvcRsx/Mrup7Idyd44ZywaDj2abJ60RNH+WZwSa
	xz+H8o4EZMSq5bB7RhBT5ITfkC3Ro2p1goOmcvFok1ROzEgoeXDNHPwZHp8AeiY7jQuvmJt1RqM
	+KK8vEBQyTBk=
X-Google-Smtp-Source: AGHT+IEeqx4K9BWXdT4VY6xg8XMPQHp8/WZzEgNP4KjzB6LHms+5O/siDoMF3flNzQ8RkuD2rcanjA==
X-Received: by 2002:a05:600c:4f47:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-458a4fc790amr11885665e9.19.1753960840007;
        Thu, 31 Jul 2025 04:20:40 -0700 (PDT)
Received: from pc ([165.51.119.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfeaesm67301915e9.16.2025.07.31.04.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:20:39 -0700 (PDT)
Date: Thu, 31 Jul 2025 12:20:36 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH V3] Bluetooth: bfusb: Fix use-after-free and memory leak
 in device lifecycle
Message-ID: <aItRhGyTWNCJmXFA@pc>
References: <aIrSp18mz3GS67a1@pc>
 <2025073101-upon-lilac-9d22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025073101-upon-lilac-9d22@gregkh>

Hello Greg,

Thanks for your feedback.

On Thu, Jul 31, 2025 at 06:32:35AM +0200, Greg KH wrote:
> On Thu, Jul 31, 2025 at 03:19:19AM +0100, Salah Triki wrote:
> > The driver stores a reference to the `usb_device` structure (`udev`)
> > in its private data (`data->udev`), which can persist beyond the
> > immediate context of the `bfusb_probe()` function.
> > 
> > Without proper reference count management, this can lead to two issues:
> > 
> > 1. A `use-after-free` scenario if `udev` is accessed after its main
> >    reference count drops to zero (e.g., if the device is disconnected
> >    and the `data` structure is still active).
> 
> How can that happen as during the probe/remove cycle, the reference
> count is always properly incremetned.
> 
> > 2. A `memory leak` if `udev`'s reference count is not properly
> >    decremented during driver disconnect, preventing the `usb_device`
> >    object from being freed.
> 
> There is no leak here at all, sorry.
> 

I understand your concern about the existence of a memory leak or 
use-after-free scenario in the driver's current context.

My intention with this patch is to ensure the driver adheres to best
practices for managing `usb_device` structure references, as outlined in
the kernel's documentation. The `usb_get_dev()` function is explicitly
designed for use when a driver stores a reference to a `usb_device`
structure in its private data, which is the case here with `data->udev`.

As the documentation for `usb_get_dev()` states:

``Each live reference to a device should be refcounted. Drivers for USB
interfaces should normally record such references in their probe()
methods, when they bind to an interface, and release them by calling
usb_put_dev(), in their disconnect() methods.``

By following this recommendation, adding `usb_get_dev(udev)` in
`bfusb_probe()` and `usb_put_dev(data->udev)` in `bfusb_disconnect()`
ensures the `udev` structure's lifetime is explicitly managed by the driver
as long as it's being referenced. This proactively prevents potential
issues that could arise in future scenarios, even if a specific problem
hasn't been observed or reported yet.

> > To correctly manage the `udev` lifetime, explicitly increment its
> > reference count with `usb_get_dev(udev)` when storing it in the
> > driver's private data. Correspondingly, decrement the reference count
> > with `usb_put_dev(data->udev)` in the `bfusb_disconnect()` callback.
> > 
> > This ensures `udev` remains valid while referenced by the driver's
> > private data and is properly released when no longer needed.
> 
> How was this tested?
> 
> I'm not saying the change is wrong, just that I don't think it's
> actually a leak, or fix of anything real.
> 
> Or do you have a workload that shows this is needed?  If so, what is the
> crash reported?
> 

While I don't have a specific workload that reproduces a current crash or
memory leak, this patch aims to enhance the driver's robustness by
aligning its behavior with the established conventions for managing
`usb_device` object references. It's a preventive measure to ensure the
driver correctly handles the lifetime of the `usb_device` object it
references, even in scenarios of unexpected disconnection or re-enumeration
that might otherwise have unforeseen consequences.

Please let me know if you have any further questions.

Regards,

Salah Triki

