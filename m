Return-Path: <stable+bounces-69737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21A2958B93
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 17:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F166B1C211FC
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885BA1BB6B8;
	Tue, 20 Aug 2024 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBZ7kqss"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FFC18FDA9;
	Tue, 20 Aug 2024 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168720; cv=none; b=fB6lGPVMICRpdqrtn412cCOJNgpQwc219VVjmb3xW2CODeIifZGIxifiRn9r20hybhUwHbvZ0T2mNLfX3Gm7703K6B1up7yqxAd0dZ4NQxUFrWhKpxegU2QUJ7YM4Jfk9gEvUgbhTdIAkOVU6TSpY3fytU0KiiY3RsXwsWMZ4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168720; c=relaxed/simple;
	bh=tjGK/8CsG4HQ9VR+w+On+tb2wpJykbsP0xTV1WhgcUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ptqz/usjjWfygGZaLx13goRwaeOSmWlvV14bfR6i/DjaX84q6V4kXYBAhif91GB8ZflzIPMsFlt6/a+pAsXr4EGq6ppkXLK3VWft4DyalHK3ijY/OJdgwGbXSt6WroHAFqwinUF6elMEZcxjg87ez6xcPxwipj+GfK/aebuzNRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBZ7kqss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734B6C4AF0B;
	Tue, 20 Aug 2024 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724168720;
	bh=tjGK/8CsG4HQ9VR+w+On+tb2wpJykbsP0xTV1WhgcUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBZ7kqssxYgMnkzqdhE1823JbYYXmlhrCyn1UGHBztaAHx9AhCIVVhipMuTSlgSnE
	 oGlwbHrza/C8zk1L6erWpBrDJe4jxTbRFx0+T+kX8c5mJYiKer0ZnDhQtmjuGu1mbX
	 XNgCdYW8DAt7os+eQ+v6ujKiUxf9IsJcvbOJ0zjudMdPGQ7oBT7Sg3jXO+P2EjlWgb
	 H7pLXVCURgDlwIPlLtdwhx1r0YApXHyWW7R4o5PEwk+E+sH5jcew/CpYrRPalx4XBP
	 vx9dO9sVd8zZP3law8I8j63sFiNvXYk+9FdVfzpSEzr7QmYlBGTGd2ZgMvOCv4UFAr
	 1snrZFWeBs6Gg==
Date: Tue, 20 Aug 2024 17:45:15 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: Block path traversal
Message-ID: <ZsS6CwZgEKfkxpfk@pollux>
References: <20240820-firmware-traversal-v1-1-8699ffaa9276@google.com>
 <ZsPf02GrdMiyZP8a@pollux>
 <CAG48ez3AEU+LD-i7Qwo3kreJ0zGQEZOnthFX++QTUOMxe3e40Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3AEU+LD-i7Qwo3kreJ0zGQEZOnthFX++QTUOMxe3e40Q@mail.gmail.com>

On Tue, Aug 20, 2024 at 02:23:05AM +0200, Jann Horn wrote:
> On Tue, Aug 20, 2024 at 2:14 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > On Tue, Aug 20, 2024 at 01:18:54AM +0200, Jann Horn wrote:
> > > Most firmware names are hardcoded strings, or are constructed from fairly
> > > constrained format strings where the dynamic parts are just some hex
> > > numbers or such.
> > >
> > > However, there are a couple codepaths in the kernel where firmware file
> > > names contain string components that are passed through from a device or
> > > semi-privileged userspace; the ones I could find (not counting interfaces
> > > that require root privileges) are:
> > >
> > >  - lpfc_sli4_request_firmware_update() seems to construct the firmware
> > >    filename from "ModelName", a string that was previously parsed out of
> > >    some descriptor ("Vital Product Data") in lpfc_fill_vpd()
> > >  - nfp_net_fw_find() seems to construct a firmware filename from a model
> > >    name coming from nfp_hwinfo_lookup(pf->hwinfo, "nffw.partno"), which I
> > >    think parses some descriptor that was read from the device.
> > >    (But this case likely isn't exploitable because the format string looks
> > >    like "netronome/nic_%s", and there shouldn't be any *folders* starting
> > >    with "netronome/nic_". The previous case was different because there,
> > >    the "%s" is *at the start* of the format string.)
> > >  - module_flash_fw_schedule() is reachable from the
> > >    ETHTOOL_MSG_MODULE_FW_FLASH_ACT netlink command, which is marked as
> > >    GENL_UNS_ADMIN_PERM (meaning CAP_NET_ADMIN inside a user namespace is
> > >    enough to pass the privilege check), and takes a userspace-provided
> > >    firmware name.
> > >    (But I think to reach this case, you need to have CAP_NET_ADMIN over a
> > >    network namespace that a special kind of ethernet device is mapped into,
> > >    so I think this is not a viable attack path in practice.)
> > >
> > > For what it's worth, I went looking and haven't found any USB device
> > > drivers that use the firmware loader dangerously.
> >
> > Your commit message very well describes the status quo, but only implies the
> > problem, and skips how you intend to solve it.
> >
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: abb139e75c2c ("firmware: teach the kernel to load firmware files directly from the filesystem")
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > I wasn't sure whether to mark this one for stable or not - but I think
> > > since there seems to be at least one PCI device model which could
> > > trigger firmware loading with directory traversal, we should probably
> > > backport the fix?
> > > ---
> > >  drivers/base/firmware_loader/main.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> > > index a03ee4b11134..a32be64f3bf5 100644
> > > --- a/drivers/base/firmware_loader/main.c
> > > +++ b/drivers/base/firmware_loader/main.c
> > > @@ -864,7 +864,15 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
> > >       if (!firmware_p)
> > >               return -EINVAL;
> > >
> > > -     if (!name || name[0] == '\0') {
> > > +     /*
> > > +      * Reject firmware file names with "/../" sequences in them.
> > > +      * There are drivers that construct firmware file names from
> > > +      * device-supplied strings, and we don't want some device to be able
> > > +      * to tell us "I would like to be sent my firmware from
> > > +      * ../../../etc/shadow, please".
> > > +      */
> > > +     if (!name || name[0] == '\0' ||
> > > +         strstr(name, "/../") != NULL || strncmp(name, "../", 3) == 0) {
> >
> > Seems reasonable, but are there any API users that rely on that?
> 
> I tried grepping for in-kernel users and didn't find any, though I
> guess I could have missed something.

It's a bit hard to grep for, but I gave it a quick shot too and I can't find any
results for "../" in combination with "fw", "path", "bin", etc. either.

> I suppose slightly more likely than in-kernel users, there could be
> userspace code out there that intentionally uses netlink or sysfs
> interfaces to tell the kernel to load from firmware paths outside the
> firmware directory, though that would be kinda weird?

I agree it would be weird. Especially, since there is "firmware_class.path"
available to avoid such hacks.

> 
> > I guess we can't just check for strstr(name, "../"), because "foo.." is a valid
> > file name?
> 
> Yeah, that's the intent.
> 
> > Maybe it would be worth adding a comment and / or a small
> > helper function for that.
> 
> Yeah, I guess that might make it clearer.
> 
> > I also suggest to update the documentation of the firmware loader API to let
> > people know that going back the path isn't tolerated by this API.
> 
> In Documentation/driver-api/firmware/request_firmware.rst, correct?

I think that's reasonable, though it would also be nice to have it in the
documentation of the corresponding functions that take the argument.

Since all the request_firmware() derivates refer to request_firmware(), it's
probably enough to add it there.

> 
> > >               ret = -EINVAL;
> > >               goto out;
> > >       }
> > >
> > > ---
> > > base-commit: b0da640826ba3b6506b4996a6b23a429235e6923
> > > change-id: 20240820-firmware-traversal-6df8501b0fe4
> > > --
> > > Jann Horn <jannh@google.com>
> > >
> 

