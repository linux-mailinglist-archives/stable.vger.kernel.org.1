Return-Path: <stable+bounces-108667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C266A1183A
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 05:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA23518895BB
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 04:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAF022F171;
	Wed, 15 Jan 2025 04:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyrZPtID"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC0122DC43;
	Wed, 15 Jan 2025 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913870; cv=none; b=ODNZ6x1wlm+AdXZfvyRE8ICh0sZTPlMDsXNHa2AcUpk2KNKp/QoDzyYF/fSMrm8woxhhn16sV/HtOdlENSo4vxQnnhhjm97lannvWu6XTozVkwUBDUqzWK5KeJAqOwIwO4B/MTDmrGCVQCxr9ZSufHvQTZwFuyMSPDqEAQ/Slyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913870; c=relaxed/simple;
	bh=Hrv8gMoqO0BrVz1tl3/c25HZPEWd0W/8W3pdH0QxPGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShyjtfpuV9ddCxJrlvDjaGDQOPktzOnZyGa67zlk+GGvjQtUk2Gfnm+DBdHi+AyLrVpNjNzs6gMVUNivYupxHh17DmrR0AuvHSLUTgJW1CDsbnt4fN8XcR0ul33dI444defj/By2bmaB7yNjlL0YPzNMp4sWaBL0YDmhUZP8BMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyrZPtID; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso85125166b.1;
        Tue, 14 Jan 2025 20:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736913867; x=1737518667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zyLGSlQ20YLW5Gv3AEQHS4rGBNB7Gh5nw6FdZ02MNFA=;
        b=kyrZPtIDTJ31YSctFPuDbS+464o4+LJAYAxgxsPdUu4T6UDMexr5eh5wRbinsqQxs7
         zOHPYYxccM/Ukljc52TVUOhwVwOdWC7UVuB1WPvwuOZvZxvja4eCmqkfgAjAA9eQ2ewW
         2hsfv+OQ+D/x0euiTsbOaxVhemwy0GbEgJy0Qh2A3MMPUNnUK6fWQLZpIX8baoal5yF8
         lDVBSarod+zBhUEkh1516bx6/UNYE8BTfRF//Zc1PEPZAOGxamhIJPZFlx42SGumXHf0
         mvGLnuXHLzIf3bNn8FptIyATjSeSiBePYZGYVIz1DK0mVajWo4B/J25DGZ8ToquUCvVq
         0hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736913867; x=1737518667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyLGSlQ20YLW5Gv3AEQHS4rGBNB7Gh5nw6FdZ02MNFA=;
        b=Wx4Pxq7OEtzqb7FBR9cB1L2/C26osCVGLAZD6h2NaSD0PdlTyYMj6VKNVMOTfaA6Vc
         EpbhmFuWlaVIOuP/4plk6BNlpi2iToEL1TS7Oxt9TFwnTHz8BwtSAjUuSfrF4cjUXhZe
         ax3Go4whm1LpI53nzOZTnBLtQwJORaOSposakbyPcGHYA5wMbIuQqJMRXflUg0xj60mH
         o3PuPjFsA7X/WyiLVgWwfukCp0FpnKkUuP60wkWkZYo1vEdUBJkZZvyKu2v2LAqln/1N
         SvmsvsfRfg8C+UsAezCnH/sQlA1BIDMgwCEcP1cuUHt9fyjgTRvi3EBlv9Rl8HVratAE
         G0ig==
X-Forwarded-Encrypted: i=1; AJvYcCVkJ/vWcB0wkfzLE7VKK8ViR3yNdMn58NQYpdaTsohs0+0L85/odKR/gWR8jQEp6vcdoGRhGnbMYWg5tXk=@vger.kernel.org, AJvYcCWtZqMnKxCL31Gu8maNx2XSu6RscoRgWswq7QQZZgOlJs28ZguIiib1g3Bx0UsINVJeOtx2zDHY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DLEKlGyzUv4b+VLj3B97SHSEdDFgh4GQWV5CQOCflTBBdC75
	egUlEC/Gg5+ODFfKRVqnbvOnnv7/BeUr0QzqfyY/JBRbZ4TbZOcK3JgpusvBDaX+kAXyBUCcXFI
	TsMX8E+Kp9VYaw9LUcC1WYddr1Nc=
X-Gm-Gg: ASbGncvFZc/BtbFWgiD0QJqM7qQGa7c/EG5I6njZUGv7rDI13JBN8UswPhtb57ZorGt
	nafYXXWuIZ28bAyJhT+nLyl/dN0q/StRY2BosFZM=
X-Google-Smtp-Source: AGHT+IEJzj2KsNd0OjxmQfpo3hsfbQzIae8XdE1ZR+CV3NLu7bQce0DUEm9z6J6yBj426GIx1w6Tr6uEkw1+BKxUE/8=
X-Received: by 2002:a17:907:1c09:b0:ab3:47cb:5327 with SMTP id
 a640c23a62f3a-ab347cb7ee0mr220603466b.5.1736913866766; Tue, 14 Jan 2025
 20:04:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112162338.39689-1-chenqiuji666@gmail.com> <2024111230-snowdrop-haven-3a54@gregkh>
In-Reply-To: <2024111230-snowdrop-haven-3a54@gregkh>
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Wed, 15 Jan 2025 12:04:16 +0800
X-Gm-Features: AbW1kvY45bWih72RGhOxDLiaY7dXbytHhNcB6WMbA_YpP-YT-Fze83etmjjyFPE
Message-ID: <CANgpojV8P7+LmDPNiJWezER6PK83Wj_QyX8iOKzfxO98WkSnDg@mail.gmail.com>
Subject: Re: [PATCH v2] cdx: Fix possible UAF error in driver_override_show()
To: Greg KH <greg@kroah.com>
Cc: nipun.gupta@amd.com, nikhil.agarwal@amd.com, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > ---
> >  drivers/cdx/cdx.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > index 07371cb653d3..4af1901c9d52 100644
> > --- a/drivers/cdx/cdx.c
> > +++ b/drivers/cdx/cdx.c
> > @@ -470,8 +470,12 @@ static ssize_t driver_override_show(struct device *dev,
> >                                   struct device_attribute *attr, char *buf)
> >  {
> >       struct cdx_device *cdx_dev = to_cdx_device(dev);
> > +     ssize_t len;
> >
> > -     return sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
> > +     device_lock(dev);
> > +     len = sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
> > +     device_unlock(dev);
>
> No, you should not need to lock a device in a sysfs callback like this,
> especially for just printing out a string.

This function is part of DEVICE_ATTR_RW, which includes both
driver_override_show() and driver_override_store(). These functions
can be executed concurrently in sysfs.

The driver_override_store() function uses driver_set_override() to
update the driver_override value, and driver_set_override() internally
locks the device (device_lock(dev)). If driver_override_show() reads
cdx_dev->driver_override without locking, it could potentially access
a freed pointer if driver_override_store() frees the string
concurrently. This could lead to printing a kernel address, which is a
security risk since DEVICE_ATTR can be read by all users.

Additionally, a similar pattern is used in drivers/amba/bus.c, as well
as many other bus drivers, where device_lock() is taken in the show
function, and it has been working without issues.

Regards,
Qiu-ji Chen

