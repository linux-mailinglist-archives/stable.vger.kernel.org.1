Return-Path: <stable+bounces-227650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC63ISEMvmlQFwMAu9opvQ
	(envelope-from <stable+bounces-227650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 04:10:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA592E3033
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 04:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B663023DC0
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 03:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D902EE268;
	Sat, 21 Mar 2026 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="luXytzKY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44762D8DC3
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774062621; cv=none; b=ty4VvBJYkErvHTcjulBodGxUTPmMgC8DJ5egpLAbMm1GzdANLv4D2YsEWVNl0wGXw8HDbM+6ADt1t6WAEwtbcT60yZU11ibLjyxRx9+pP7UVXRLjbkN0kvXcE1FE9kFfWfADyD2Zna/AJ7S34AXCZhQCh8sVCIo1HHaRGNLoRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774062621; c=relaxed/simple;
	bh=KCouMn/Dg6hm0eYmov7z8hH1AZtJwHW0P50SCpJ5vto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otlfy51D+IZ9ddVI3G8VheYn2MWcH+SnV+x2lpE8na7d0ze1OhbcC+FUnJTGaLUJ4ZdVBjuYUTe5d2IyCks1p7rLO0TueWDI+fjoCRgeuAhNZFDMNEhDcwzNcT9by0RlUkoYMTs1ClzREJ+WQxKK813dzr3XfQXrtMQZBp4HUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=luXytzKY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8d7f22d405so385782166b.0
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 20:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774062617; x=1774667417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/RSF0E6FhLD8wutFoB7bxuZrdpYQYvN1Rthj0xeHEY=;
        b=luXytzKYbBHIHGf+XzHwq1Qi3CkLpHkutgILb3rNEBqGdZGfEHr9nQQxzyLgxK02pO
         +I5w1S8MBDixpnXKKhUCeIyQRQhR02RiiXMyj9/5Dj9bIxO01SHbaUIUi9Kh0N+LGwV9
         sZXA6/9BUdYb4gGLWg2/W/3KVl/VEJ2+HtsRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774062617; x=1774667417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8/RSF0E6FhLD8wutFoB7bxuZrdpYQYvN1Rthj0xeHEY=;
        b=raWX2qvBiZ+6EiUhXZln6TD9dOXUkTvEb1oOVGEQSAxSORU2JsnJOdDdwzOY+xUp8K
         bztPjlZmLW1THvSvjGGck4dO0To9KvPGV4C9UZZT0OMMjVyHax1v+E9Qz95tOIxfOYDr
         T0JD1/BSvSwvlr/LuDB+jVjwC3y8dgsW8i6qe2NsADPCRGvs/My5DPhR6+6WsZruEXki
         qddC10Ys9SNX8bv+tG79eThtcJbA07H++cnYa31nJqCxxozpiLn162v3zVNsG/zLt6TY
         kr5Yd7kAMGFD0u0mQM0r+je6sc3OeaMCFOIx0YJEfPwMXdObQpES15I4apiEo7KQzX81
         z0Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWbZUxEKqf8kUnrdtV73aMPnxvQUUQhy/mPhMAsA+SoTSh9R40VXWxPlTxt2XdFUY+OEmcSmPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/gnsAIuzIY79UvE+sB83iM1S26E5xW92q8tqrkc+GDRmDZ3V
	BikzngsvM3mAsvTEoRYF+KVFwljfUSI7uvQwSSj7+Se/BaXYV9RL01y+FSXDSufN+WLSZPXEkbT
	j/s4I1A==
X-Gm-Gg: ATEYQzx5uHQjm+x/Xu0JRBo3yG+UkEHtChYOAZNdLP+YMCkM12srbT1LNPqIBTITVt/
	N1VDpZxBiZC8V1V2jhnNX2AV+yp+WBfuyf39Ce5xElTW9DIUAXLajBL9ge6GFi7m7yWRWypamrP
	iqIeb7Rx3IxfrWMz34eaFD7Rv7Z+aYKljkpcNbbnyIUx79ImVfKGydq+ObsjXb7Dpt9s/RRij+R
	cNz1Ktj77gkJVF2g+NGvZBSJhRfX9p3gIdW6Baw0xCyfUe9MKCB0DCtLnB8i9s6uIWmzL0aQiLS
	ILo82qNI2wTJiwcJARcxKaZc+loA9rYdaw3cu8diB/ceidcNPqNeuzUo6GAKdVcL4VOm3NGicPD
	/8caw/o3yJ8Gib1Sl63R117UT8A7/iDkX1NI1ZjMN3ocJkt4RjZB1+Zcs4+EW/+vi8HkndL3CVf
	Kt4s5ZSDVkLLboZNe7eHlE03mi04SkyQjmhSiiLU2k6AwnBD+OVqBi9oU1iqbTpw==
X-Received: by 2002:a17:907:d307:b0:b97:d43d:d424 with SMTP id a640c23a62f3a-b982f52688emr400115366b.54.1774062617273;
        Fri, 20 Mar 2026 20:10:17 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f44034sm224457766b.4.2026.03.20.20.10.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 20:10:15 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso21144385e9.1
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 20:10:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUBNqLkwWacgTsfURgDZllIO12IK6HrvVRltRMlPu0T8452qBR2WRS63N3Dos1ly41ejwuDvU=@vger.kernel.org
X-Received: by 2002:a05:600c:8119:b0:485:345b:ccb1 with SMTP id
 5b1f17b1804b1-486ff031f5dmr63989995e9.27.1774062615176; Fri, 20 Mar 2026
 20:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com> <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 20 Mar 2026 20:10:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VsAi-K9WnkT996WExfividTRi-aVcyLVD4Aicif=D=dA@mail.gmail.com>
X-Gm-Features: AaiRm53JJySLwTXCCA6qh8x4Qo2JwYxEnfOViwtwDhVjyjDx4WswvOZrKm9fsCw
Message-ID: <CAD=FV=VsAi-K9WnkT996WExfividTRi-aVcyLVD4Aicif=D=dA@mail.gmail.com>
Subject: Re: [PATCH v2] device property: Make modifications of fwnode "flags"
 thread safe
To: Saravana Kannan <saravanak@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrew Lunn <andrew@lunn.ch>, 
	Daniel Scally <djrscally@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227650-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,linux.intel.com,sang-engineering.com,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DEA592E3033
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Thu, Mar 19, 2026 at 10:52=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Thu, Mar 19, 2026 at 10:25=E2=80=AFAM Saravana Kannan <saravanak@kerne=
l.org> wrote:
> >
> > On Tue, Mar 17, 2026 at 9:04=E2=80=AFAM Douglas Anderson <dianders@chro=
mium.org> wrote:
> > >
> > > In various places in the kernel, we modify the fwnode "flags" member
> > > by doing either:
> > >   fwnode->flags |=3D SOME_FLAG;
> > >   fwnode->flags &=3D ~SOME_FLAG;
> > >
> > > This type of modification is not thread-safe. If two threads are both
> > > mucking with the flags at the same time then one can clobber the
> > > other.
> > >
> > > While flags are often modified while under the "fwnode_link_lock",
> > > this is not universally true.
> > >
> > > Create some accessor functions for setting, clearing, and testing the
> > > FWNODE flags and move all users to these accessor functions. New
> > > accessor functions use set_bit() and clear_bit(), which are
> > > thread-safe.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Acked-by: Mark Brown <broonie@kernel.org>
> > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > While this patch is not known for sure to fix any specific issues, it
> > > seems possible that it could fix some rare problems. I'm currently
> > > trying to track down a hard-to-reproduce heisenbug and one (currently
> > > unproven) theory I had was that the fwnode flags could be getting
> > > messed up like this. Even if turns out not to fix my heisenbug,
> > > though, this seems like a worthwhile change to take.
> >
> > Reviewed-by: Saravana Kannan <saravanak@kernel.org>
>
> Thanks for the review!
>
>
> > Thanks Doug. Hope this isn't the cause of the hisenbug. If you report
> > it here, I might be able to take a look at it too (no promises).
>
> I don't _think_ it fixes my bug, but I'm still not 100% sure because
> the bug can take a day or so to reproduce and it appears to only
> reproduce on official kernels built by the builder. :( This makes it
> hard to say anything for certain and also hard for me to inject extra
> debug logic.

Just in case anyone out there was wracking their brains based on my
description of the bug...

I've made progress in getting the issue to reproduce even with debug
information added. With that, I've found that
device_links_driver_bound() is getting called where `dev->fwnode->dev`
is NULL. That prevents it from running the ever-important
__fw_devlink_pickup_dangling_consumers().

I can see that device_add() has started, but it just hasn't made it to
the `dev->fwnode->dev =3D dev;` line yet.  My printout next to that line
shows up _after_ my printout in device_links_driver_bound().

So obviously something can happen to cause the device to probe before
the call to bus_probe_device().

OK, I managed to get a stack crawl for when `dev->fwnode->dev =3D=3D
NULL`. It looks like this (FWIW, it's a 6.6 kernel but issue also
reproduces on our 6.12 kernel, and I see no reason it wouldn't
reproduce on mainline):

  Call trace:
  dump_backtrace+0xe8/0x108
  show_stack+0x18/0x28
  dump_stack_lvl+0x50/0x6c
  dump_stack+0x18/0x24
  device_links_driver_bound+0xa4/0x4b4
  driver_bound+0x48/0x1c4
  really_probe+0x244/0x374
  __driver_probe_device+0xa0/0x12c
  driver_probe_device+0x3c/0x218
  __driver_attach+0x110/0x1ec
  bus_for_each_dev+0x104/0x160
  driver_attach+0x24/0x34
  bus_add_driver+0x154/0x270
  driver_register+0x68/0x104
  __platform_driver_register+0x24/0x34
  init_module+0x20/0xfe4 [max77779_pmic_pinctrl
e09198e651272bc5df70245355346d6eb1ba3a8f]
  do_one_initcall+0xdc/0x360
  do_init_module+0x58/0x23c
  load_module+0xffc/0x1130
  __arm64_sys_finit_module+0x260/0x300
  invoke_syscall+0x58/0x114

It looks like what happens is that immediately after device_add()
calls bus_add_device() there's a possibility of another thread
inserting the module holding the device driver. That means that the
driver can start probing much earlier than we expect.

I've posted an RFC patch to fix this. If folks are interested, please revie=
w it:

https://lore.kernel.org/r/20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabc=
ead688d0d8c17@changeid

Given the stack crawl I got, I'm fairly certain that this will fix the
problem, but I'll also let reboot tests run over the weekend to
confirm.

-Doug

