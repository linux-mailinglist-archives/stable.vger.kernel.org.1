Return-Path: <stable+bounces-76011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7B6976E5C
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 18:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E5B1C238B6
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A2213AA5D;
	Thu, 12 Sep 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iyG5zw/s"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F32AE8E
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157033; cv=none; b=A2JdWqS6N0bmaKQFciOdWPmepAwrEd74wos1PE5yb4r9CjnAz3bJOWEyx282FCg1b9uI9OCb52euPQd+xzBCpTgIfCz5W+NdchSDe83hh2dIetBJY+1bmsd/sAN3dKgTr8Bl7ppB8zwK6ojBeqMHNb8go7dKrZ0PRt1aZwAS5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157033; c=relaxed/simple;
	bh=CrCjW0ic6Db+J3kjsTPKwgfDJbBARSVIXo7Ekp4qkxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuM85qdyqTWjgR3oRWPF9qpio25phP5dUPaMnm0Te2E9+1wJ3/8Wh1Skf39fT6PdrGnDOhK/Qhd79iX0d7sPM5hbh3iWg3VeGD7idkag9yDWLfBqvHhwQvb8Ycnj+ec14t5hgLlnZebPa+uOXIeRiwaY8BwozWAlpdkhH8P/Bzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iyG5zw/s; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4582fa01090so315901cf.0
        for <stable@vger.kernel.org>; Thu, 12 Sep 2024 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726157031; x=1726761831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrCjW0ic6Db+J3kjsTPKwgfDJbBARSVIXo7Ekp4qkxU=;
        b=iyG5zw/swZ2SxLcuhbOFs/Dap9n+IgEw11eDDj6pTWSoECIK8gQTLOa+BuA2R5/6Fa
         +kxUWCGgSGIrwnfjxT3kBdN6Eo+okVvGCCxdV8Y2idOVORdIvAav0wYZRVqstD0fuLop
         tSS6G/QjOc5HKiL0Tx14Ah6c2pucvt6BVpH7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726157031; x=1726761831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrCjW0ic6Db+J3kjsTPKwgfDJbBARSVIXo7Ekp4qkxU=;
        b=xP9pbOlbGEcV9tASfICJhq5C1mv6AKlsD8QRrbHzzJNvRso95LFhVh1Cvio3MJ/jAP
         lGCfDxn5mKB5pPmMpce99dRJilFcErklBdd+obGQFCM2p6huF0XYjlQYkfRfPlAX7rHp
         RrCSxmP8nG5MrbO070tknttg60WpNPS6IZRjMPTibOXovyE/7fCcKFIPmWBb5LwPZhGk
         QSrwBsXpD9NXQ5+LH8qljSEKnt8GlJIZrAoYfMBbHcmwXJIEy7UB7RXdHp06tlsCt0Tp
         TglcOfZKlVfHTcXiCX8ZbMWAMv52+Q6JX8lVOYU+Vyjk/3Ad/20iEip99GWSkreRDOOB
         4clw==
X-Forwarded-Encrypted: i=1; AJvYcCWkkyLkLbeqXrkNGVIPVhRDCw63r2B2Tz/mY1Zgp5EXnscCFSnECPm/+ZLHxaE1P1CpsUYZ9ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGRlAWBY+/0vOa0/9RejfDsgOqWVLgMzU+HeAvz8mt3gtZr/Kl
	EolAT7rPMYwhBeJgh7+6I6g86y/SOktSKDxmSMh1d884y38L4t+KumvjxMKst2tASfWsNMR8eZX
	ckO/U/X5PPOn+KFTn2Yml+p8Xtlh/sT12YcQ9
X-Google-Smtp-Source: AGHT+IFQu3yAL5DEk7oQCeXw0JvR4PFs6pcDDf5vf1OMase0DRLjYTPZIp+SdT/fDhzrb2YiYvR+LjfvMad1ROIciKA=
X-Received: by 2002:ac8:5845:0:b0:453:5f2f:d5d2 with SMTP id
 d75a77b69052e-45864403792mr2236481cf.1.1726157030402; Thu, 12 Sep 2024
 09:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALvjV29jozswRtmYxDur2TuEQ=1JSDrM+uWVHmghW3hG5Y9F+w@mail.gmail.com>
 <20240909080200.GAZt6reI9c98c9S_Xc@fat_crate.local> <ZuCGkjoxKxpnhEh6@google.com>
 <87jzfhayul.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87jzfhayul.fsf@minerva.mail-host-address-is-not-set>
From: Julius Werner <jwerner@chromium.org>
Date: Thu, 12 Sep 2024 09:03:34 -0700
Message-ID: <CAODwPW8P+jcF0erUph5XyWoyQgLFbZWxEM6Ygi_LFCCTLmH89Q@mail.gmail.com>
Subject: Re: [NOT A REGRESSION] firmware: framebuffer-coreboot: duplicate
 device name "simple-framebuffer.0"
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Brian Norris <briannorris@chromium.org>, Borislav Petkov <bp@alien8.de>, 
	Hugues Bruant <hugues.bruant@gmail.com>, stable@vger.kernel.org, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Tony Luck <tony.luck@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Julius Werner <jwerner@chromium.org>, chrome-platform@lists.linux.dev, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

> On Coreboot platforms, a system framebuffer may be provided to the Linux
> kernel by filling a LB_TAG_FRAMEBUFFER entry in the Coreboot table. But
> it seems SeaBIOS payload can also provide a VGA mode in the boot params.
>
> [...]
>
> To prevent the issue, make the framebuffer_core driver to disable sysfb
> if there is system framebuffer data in the Coreboot table. That way only
> this driver will register a device and sysfb would not attempt to do it
> (or remove its registered device if was already executed before).

I wonder if the priority should be the other way around? coreboot's
framebuffer is generally only valid when coreboot exits to the payload
(e.g. SeaBIOS). Only if the payload doesn't touch the display
controller or if there is no payload and coreboot directly hands off
to a kernel does the kernel driver for LB_TAG_FRAMEBUFFER make sense.
But if there is some other framebuffer information passed to the
kernel from a firmware component running after coreboot, most likely
that one is more up to date and the framebuffer described by the
coreboot table doesn't work anymore (because the payload usually
doesn't modify the coreboot tables again, even if it changes hardware
state). So if there are two drivers fighting over which firmware
framebuffer description is the correct one, the coreboot driver should
probably give way.

