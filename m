Return-Path: <stable+bounces-187679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0DABEB048
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 19:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67971AE3D9D
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA602FFF83;
	Fri, 17 Oct 2025 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="crq1HVv8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2192FE577
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721068; cv=none; b=Zil5rtUY0Y33V/9xiixUesna0adUeZfNKKNsis8eVs5ZR/Xx9FdlURFd+p+MK0nqaOCJ0oT9RVIwGLo2AuiAT4bHdBpKOUQJEZYGX5iyKCVlLDrJmysFWmCWA36N+0oVygYln9Sa+AFdZVjCvGYInTV2KUKPRe+mt/3PzM9WfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721068; c=relaxed/simple;
	bh=aBjjIxnkY/FA3VjaRF/v5raEcuHOjy9Oe4kTong4tPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo6yBbWTDMwb+BCNlUYaBH0r7iV3ZXtuvOY3F1y1DXtgbeiFjvbxh8+Kw4pwPRZZkn/hexDKfmixWxSJCHE7JTlHxHV4lDrOy2fmRhvOmvP/0cisLXkpq3DCmnVEiNdRVIm4/RYm4LlBr7e8P5cWMG80hcW/m4SjId8Rxli3spg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=crq1HVv8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33d28dbced5so795661a91.2
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760721064; x=1761325864; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wBM/oeHMFZtatvJ+zW6/cnV/R+5GapNosgNZTWLHrZg=;
        b=crq1HVv8qH695bk3+v5Cz9kS/qrgPWdQ+zJLT3PY0JJ8YKP3aBkrnfiAeOjnylfV70
         a+MQaEhTO7ktQ710/nlibXmsxK9xO8J6PrMcSn6nefbYxkjIzUdwMKR9+6YTj/0hFfn1
         fxIM9WNbdM+YFxjwiu0xcEA9gfklIZ3MJm5MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760721064; x=1761325864;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBM/oeHMFZtatvJ+zW6/cnV/R+5GapNosgNZTWLHrZg=;
        b=H3qR8ECvy8dCr7QRuSTGq6QDmtWh5UIrTVGl0KE0Lwk6hf9U39xQP7CA1ibjWt5MxW
         B9no84InIjZnNML/zWf9v04c+yr/rWNdeCC9LGacwcnIo5DR6EBTzOaw67lJoKLTjbPG
         OE5huNAtnmTAF2Phbw35tiQ0oewacZMshHpjnR737uzWZy0YnY5RsmXklb+pW0O6Bwdx
         GWkHfzY64h2uXBrqOxnT++Ud6TBPOuhn+dqMkY7DpygMG/xzvBkv1xeDdBZ7L79JDvxH
         kpZT/CW92r/MXqsS+66MR0brmvLL3nN3evjO6Zv46mZZVWt+OcXPg/eujuGTv8cYEl13
         PfpA==
X-Forwarded-Encrypted: i=1; AJvYcCXzD72hfmrtQ96hyPuEKoquxE7JkEGWVL432st5HvmH++P+Jg6kbsKKnILI2vmynoRvGoXL4WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIOsi3tFfaZcMxB4ZhGlrsxqq45e1fHHfTpOLvgBVGAb2CtFzd
	bo/mIzJ8POZtpvqHK3DNgLF3Q8q0iG66mKIawwyhikwqqW11OH/FCLl5gpQg6/zTOd8hf61OhbC
	otdU=
X-Gm-Gg: ASbGncvN/PlqaX0Xu7ibTSyD3o8x38buljicpEtfEBXWIlOd2UV8yetvuzxXIknBqkd
	GDYctvDPUIy5eMg32c3CpO2HfgJvl4oRsYRmGIlqlK0k9Bj8xlrsGR4G3Kn/LXeAZVHg1lOoGdX
	bsVYjied69QhatmDv5bGCqbG7zxXLBjy3iyJy/mlsZZ8SD9fAJzPyGLk0/kMKkzNA6Dfp6v6yDU
	80IbrW/PpLycHSkQUTYfXucWKxqUvkRYdk6WOOfQBHcFBxSNNihROpaDapXQPV+cZ/BbesjH8tQ
	Bh/PVJhOE+oO7JE1DMuzvrHv2352k58i0XBkkrF0CVgGOEjFvyMZHufupJtPoxFH7ZcHT6EOMz3
	asWi21+g5ZsI5Lr+Kq2BGXpZVGA4bX4nay/kiKVEovdZN6IQH6cIUx1kTQKshxgYVJVORefrGG/
	6A8I5WY2+brKmPOhBJKkFgUyZ6ZB4A4v6bjyvPTa2lMiVQWfN/j0OsjsNKUgE=
X-Google-Smtp-Source: AGHT+IHKYNW+lzSgEoR/ftLOyWk4dENf+z842xkhdFHWXcXQluEhrxtoUMASXE6ncX8JmfeiyZU3fg==
X-Received: by 2002:a17:90b:3dc4:b0:332:8133:b377 with SMTP id 98e67ed59e1d1-33bcf87f8c3mr4875586a91.15.1760721064328;
        Fri, 17 Oct 2025 10:11:04 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33bb65222a6sm6105739a91.4.2025.10.17.10.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 10:11:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:11:01 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
Message-ID: <aPJ4pZFENCTx9yhy@google.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <CAJZ5v0iFa3_UFkA920Ogn0YAYLq4CjnAD_VjLsmxQxrfm5HEBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iFa3_UFkA920Ogn0YAYLq4CjnAD_VjLsmxQxrfm5HEBw@mail.gmail.com>

Hi Rafael,

On Fri, Oct 17, 2025 at 11:45:14AM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 17, 2025 at 1:28 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > PCI devices are created via pci_scan_slot() and similar, and are
> > promptly configured for runtime PM (pci_pm_init()). They are initially
> > prevented from suspending by way of pm_runtime_forbid(); however, it's
> > expected that user space may override this via sysfs [1].
> >
> > Now, sometime after initial scan, a PCI device receives its BAR
> > configuration (pci_assign_unassigned_bus_resources(), etc.).
> >
> > If a PCI device is allowed to suspend between pci_scan_slot() and
> > pci_assign_unassigned_bus_resources(), then pci-driver.c will
> > save/restore incorrect BAR configuration for the device, and the device
> > may cease to function.
> >
> > This behavior races with user space, since user space may enable runtime
> > PM [1] as soon as it sees the device, which may be before BAR
> > configuration.
> >
> > Prevent suspending in this intermediate state by holding a runtime PM
> > reference until the device is fully initialized and ready for probe().
> >
> > [1] echo auto > /sys/bus/pci/devices/.../power/control
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
> >  drivers/pci/bus.c | 7 +++++++
> >  drivers/pci/pci.c | 6 ++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index f26aec6ff588..227a8898acac 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/proc_fs.h>
> >  #include <linux/slab.h>
> >
> > @@ -375,6 +376,12 @@ void pci_bus_add_device(struct pci_dev *dev)
> >                 put_device(&pdev->dev);
> >         }
> >
> > +       /*
> > +        * Now that resources are assigned, drop the reference we grabbed in
> > +        * pci_pm_init().
> > +        */
> > +       pm_runtime_put_noidle(&dev->dev);
> > +
> >         if (!dn || of_device_is_available(dn))
> >                 pci_dev_allow_binding(dev);
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b14dd064006c..06a901214f2c 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3226,6 +3226,12 @@ void pci_pm_init(struct pci_dev *dev)
> >         pci_pm_power_up_and_verify_state(dev);
> >         pm_runtime_forbid(&dev->dev);
> >         pm_runtime_set_active(&dev->dev);
> > +       /*
> > +        * We cannot allow a device to suspend before its resources are
> > +        * configured. Otherwise, we may allow saving/restoring unexpected BAR
> > +        * configuration.
> > +        */
> > +       pm_runtime_get_noresume(&dev->dev);
> >         pm_runtime_enable(&dev->dev);
> 
> So runtime PM should not be enabled here, should it?

Hmm, I suppose not. Does that imply it would be a better solution to
simply defer pm_runtime_enable() to pci_bus_add_device() or some similar
point? I'll give that a shot, since that seems like a simpler and
cleaner solution.

Thanks,
Brian

> >  }
> >
> > --

