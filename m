Return-Path: <stable+bounces-116553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98A1A37FFE
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4371896756
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2C521771E;
	Mon, 17 Feb 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDAbTs9q"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAE213252;
	Mon, 17 Feb 2025 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787510; cv=none; b=Aoj75RT/+6fDWeY3JmZKQnxdBHYNRUYWoPruc2ukegC1+ie7DcozPKwaOKJDvQ+8oPVLlUfbdO4J0un76uaSsFu+4Q67lBODZ1vl8eE6v0eFzIxeUbzzP5ddfsQ7QQAYsLOEqXSB/SiYojOLsmzOVARUSZDIzUw3MMuEumwBk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787510; c=relaxed/simple;
	bh=NHkvPRkzX6KO0As1z7FdzxvixSgW6+pIBFwhuAd5Z1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiRN6N1hcYhPRXfL3pw0pU9b5PMd+o8v6RGJSNxcezOJgqN/MgnwAV6fzgOtQZbzKb08ihmvN/gWwzB2gbBuofmC4Zj9qdSnzRi+jhS0cJHXKRin3IlIUzqXaFkrqouQlMrM7kGcxHsOPZAXxoslC/zt9AKt+kCfP71/DMI7d8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDAbTs9q; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso1337182e87.3;
        Mon, 17 Feb 2025 02:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739787507; x=1740392307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4wBwy34c1nxWRJz6fWTBvOC1Dgu5zjdXR6i/1OCebI=;
        b=MDAbTs9qRnDw2R/XOHnxGUUXHzVMMgGZApXUeP6qnsjNBTZhHIgC5QJuy9qKK7zjms
         ot4PiqLuTOxLh+hzZKDTl6736avrNStx7mb4LYibwN8q/LqeHjIitimQ4zMnqzvlkyUz
         KYLIaRdlLxweCaO1MkwPuBBzOIoHkg+6LXxUmwmHll4epqlILYDisz/flVJ9iuEJ2wni
         00auEQNphJWuDmOOpCB41okj/zOWBgSywn7ocO/uQDt6SfGkpE+cqAg/DWH4xOtsWTG/
         2tcRalKEb1v3jhNVIiVv/vFYCsYIWGvAyRHxMZaeJzb3WjZvFUsearkZDQFZv5wDvTZq
         g7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787507; x=1740392307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4wBwy34c1nxWRJz6fWTBvOC1Dgu5zjdXR6i/1OCebI=;
        b=FkMqKyoS+f1vNfzlr0X1rJCj10sGsKFyDdyZp1WhqsVO9z6PS7EIE27+ziwGsEyn7o
         YmBbIUkPngczs+GkclwPzX/5bMk+hHrdVM06zXBkkAH+BJTvTyvQ42MpML3HFaU+efNX
         zUopxnwN/QxKKzDQTmkug/gm6HqF8jCooE9lOP/NHZmgEaJ9oqZUqehd2o2fHImyr2xg
         DR3WsMMnn/z+fiJ2kfFOauDs2R3mQDfaSLbdLTsxVmEa7vdBLKNBzOjSuqas5DkxD2sf
         2XiQdBvUcyMQw83OhAon55E8zL6GHFXOzkwlO4kClA51BPoh8L3Ex8gidutOXVytCBU+
         UsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY7gGX959blYfZLu8FkD5WE5VAtsBp+sd6qRGpDbZIe97j1+SsXVnnHeE5O0fZle5N1bFiC0u6k2Gw@vger.kernel.org, AJvYcCWFxd0Rc89jvTZmewTCys0ac7+zwloDmyAsDhgZIN4xzkQrjgb9xZEkb7n2YELyZ8iMud2/DA9fDn1Dw5g=@vger.kernel.org, AJvYcCWg4pmvF9dGqgDB4pgKXZzk8JxJMB/+Z5cMWXVY1XbSpdenbYvnLO7yWnZ4S88CQ0ZWEOywvkgg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0yR6SwDoN6xHAAbI1edIOURijV5wt8fn6LO04CKmqdJvEjust
	o9kdL7FjiMu2eLR5qggEtMYqlofTRnyBIlP7cQLqbPySax7AOwWr
X-Gm-Gg: ASbGncsK2qMhwpiNDJbxKAjJ9+qpqTib/5uuiEURzVEZpJSGeUlA/2zAVIZkedtoano
	6e8juFKMXxOB32r639/m1l6EqY8N+gLTeaQN/iqTgyzF7CHVWJvySB8xyx7iPdykWhAAOmibRqf
	MW5rM6LVmgr22ITKt9817Ya1OFnw0kGONyFhhvnsKHm9mf94L+dfwTeTYuD3+LrhNWEj2lHzWx6
	pqGw35ELYSYby2G4n6FQqkrSuvJ2QBm3rOTcgYMDikipTDy4jUa2XwKKet6PnC8nvTBRHoGHk84
	86M1CBWXFZbwwpwRdrCt61TZ
X-Google-Smtp-Source: AGHT+IGkamt/nraIMqCVly88h59eTOO/oTl31TGvMUd3r87Yd/CiMCd3RMYYKsSUpM2ElB42ZrymDQ==
X-Received: by 2002:a05:6512:238a:b0:544:fd8:7911 with SMTP id 2adb3069b0e04-5452fe5809dmr3066757e87.21.1739787506807;
        Mon, 17 Feb 2025 02:18:26 -0800 (PST)
Received: from localhost (morra.ispras.ru. [83.149.199.253])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452a89b321sm1160154e87.24.2025.02.17.02.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:18:26 -0800 (PST)
Date: Mon, 17 Feb 2025 13:18:25 +0300
From: Fedor Pchelkin <boddah8794@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Pearson <mpearson@squebb.ca>, 
	stable@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] usb: typec: ucsi: increase timeout for PPM reset
 operations
Message-ID: <iuqvnem6m6okpxmto5uscj5bzgkrzszc3npcf23zus6luybhtd@mztr62veakdb>
References: <20250206184327.16308-1-boddah8794@gmail.com>
 <20250206184327.16308-3-boddah8794@gmail.com>
 <Z636e6Vdr4FC7HbQ@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z636e6Vdr4FC7HbQ@kuha.fi.intel.com>

On Thu, 13. Feb 15:58, Heikki Krogerus wrote:
> On Thu, Feb 06, 2025 at 09:43:15PM +0300, Fedor Pchelkin wrote:
> > It is observed that on some systems an initial PPM reset during the boot
> > phase can trigger a timeout:
> > 
> > [    6.482546] ucsi_acpi USBC000:00: failed to reset PPM!
> > [    6.482551] ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
> > 
> > Still, increasing the timeout value, albeit being the most straightforward
> > solution, eliminates the problem: the initial PPM reset may take up to
> > ~8000-10000ms on some Lenovo laptops. When it is reset after the above
> > period of time (or even if ucsi_reset_ppm() is not called overall), UCSI
> > works as expected.
> > 
> > Moreover, if the ucsi_acpi module is loaded/unloaded manually after the
> > system has booted, reading the CCI values and resetting the PPM works
> > perfectly, without any timeout. Thus it's only a boot-time issue.
> > 
> > The reason for this behavior is not clear but it may be the consequence
> > of some tricks that the firmware performs or be an actual firmware bug.
> > As a workaround, increase the timeout to avoid failing the UCSI
> > initialization prematurely.
> > 
> > Fixes: b1b59e16075f ("usb: typec: ucsi: Increase command completion timeout value")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Fedor Pchelkin <boddah8794@gmail.com>
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks for review!

Should I respin the series or it can be taken as is despite being
initially tagged an RFC material?

