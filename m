Return-Path: <stable+bounces-69655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C8A957A68
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 02:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE951F2369F
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 00:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866B15258;
	Tue, 20 Aug 2024 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W0rPNKTm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8F233C9
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 00:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724113428; cv=none; b=uZcSnLSMbEtytR5t432fluaJSoZbhZh1tGNEmHPv6bKG1CXQAe3bFosu6fJLZEM6g7z6nOk1vizTjwv3Y6tLWp7guBww6h8pXEDaav0Zg8Ycnwn7Twoel+WjBNhnrEd7GzulClncQkSJzF9LfMsBncXvfgpApaEfT0/yP7FnBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724113428; c=relaxed/simple;
	bh=l/MMPHrQQ3Q6NlKHsota4XpyjjpXMK+GqtUMgg5OfTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOse4PUp07Lu5z57eJPWuslBPVk1cYjvGHsvrbHie50qUcl2VPyRnT03NRkeRwyOe1oIPguFKb/Bd9+Ff2xNahENUNOeCw46uAXK5XKHtSqUN10fkk33peVxapShzOwBh10ZhPpZrOiPvW+l9PX7ISU4W9aHl6KN/M0KFSFgCvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W0rPNKTm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bec7c5af2aso1851a12.1
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 17:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724113424; x=1724718224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDpJg/25PU9Gi8OKDEDgpYXo+X7+J2DDq41pw8QS5Ps=;
        b=W0rPNKTms9qx5IWdF6JbXDAH3UiIdkSp94O7YphHOCJaKwgh6ASRYiC79B32BqC+Nb
         G2ZEc2JepSsH8IVnEQ9LHKL1vAwLwBLAro+ITEJGrYRkysry0al1sKi25239oRQPo7jv
         500NKvJQd0tSgb/cZ3wlNyByEKKqDSM+6nG8xkTrIZj8dyQLajIDL+tLHwbt17TIb+ho
         KfYYghW4hI/OElDPGilMw1qDS7nB91KCQxHyWFFUgIGjLMMaSZ++CJKmfeb3WEG4e3M2
         qvY3YAxhmN2pEH7cIqoUNKSX7Rs2hJ7ei50mjNANIaM0iTBIs6RFTvRm0eXi+255YzmC
         G73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724113424; x=1724718224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDpJg/25PU9Gi8OKDEDgpYXo+X7+J2DDq41pw8QS5Ps=;
        b=kI4vAn1sa2yGZFIrWX82zaq6kZjLly24mvxQoRUy4QXtZNIh9C8FFkGmIPkG5jr6gc
         39rTprsu8600964L6fzMoxfhpOs8LUe31O9GMrtoEkD2Yirhl8/l3plLRpxCDPb2xkVE
         n7Jj2XoqaTH8RV6Rvg023oaq7409ncakd3SnDS3xfwHBzNat5jp9rN0GrI6jbl7zroL4
         JJqZo4Q8qxeo40XucfJnOwYe0XrpIgvH+NlorZlhHVb33YjjT/d4vkEKg9hx7yn+29M9
         SOMxoThzlzoZxPriAbdt9JEkkY/VJGZZaltbemQxnLnPJ5XTWxQmoW1+Tcy3VV2HMi64
         9Zng==
X-Forwarded-Encrypted: i=1; AJvYcCWnasTUgiGheFCrCAJ3eXZ6sP9wE6/t8hoL13dKf2cHuPqHk+Q8wWvf2oUVgRj+YXT7z5YQH9dg+2Q2dnHnDhlcTsXCMhCV
X-Gm-Message-State: AOJu0YyqnmqUcYHV1ff6S0UPglOz8U7u/67up9+dUI2gwL/6Hlewgomf
	5z4u/MZTlq1nEfJXWsvXLXrgroFxkxWs+NNcD4OMJPoZuxG1pRD0beEPotvwGgbDGgNLBwm4l2F
	HfhKWAmDrKpwjz8Kl0mTWVpY5qFqrh6SQpRMH
X-Google-Smtp-Source: AGHT+IHtMUKxykGn/Yy7N6Kopmep5meMYD/5IrEs30rRItXIZZBc0NIGiKHY276e9D7ICho6QZpomOdP3KOlavCDVJQ=
X-Received: by 2002:a05:6402:27cd:b0:5b4:df4a:48bb with SMTP id
 4fb4d7f45d1cf-5bf0b77e3bemr54036a12.0.1724113423400; Mon, 19 Aug 2024
 17:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820-firmware-traversal-v1-1-8699ffaa9276@google.com> <ZsPf02GrdMiyZP8a@pollux>
In-Reply-To: <ZsPf02GrdMiyZP8a@pollux>
From: Jann Horn <jannh@google.com>
Date: Tue, 20 Aug 2024 02:23:05 +0200
Message-ID: <CAG48ez3AEU+LD-i7Qwo3kreJ0zGQEZOnthFX++QTUOMxe3e40Q@mail.gmail.com>
Subject: Re: [PATCH] firmware_loader: Block path traversal
To: Danilo Krummrich <dakr@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:14=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
> On Tue, Aug 20, 2024 at 01:18:54AM +0200, Jann Horn wrote:
> > Most firmware names are hardcoded strings, or are constructed from fair=
ly
> > constrained format strings where the dynamic parts are just some hex
> > numbers or such.
> >
> > However, there are a couple codepaths in the kernel where firmware file
> > names contain string components that are passed through from a device o=
r
> > semi-privileged userspace; the ones I could find (not counting interfac=
es
> > that require root privileges) are:
> >
> >  - lpfc_sli4_request_firmware_update() seems to construct the firmware
> >    filename from "ModelName", a string that was previously parsed out o=
f
> >    some descriptor ("Vital Product Data") in lpfc_fill_vpd()
> >  - nfp_net_fw_find() seems to construct a firmware filename from a mode=
l
> >    name coming from nfp_hwinfo_lookup(pf->hwinfo, "nffw.partno"), which=
 I
> >    think parses some descriptor that was read from the device.
> >    (But this case likely isn't exploitable because the format string lo=
oks
> >    like "netronome/nic_%s", and there shouldn't be any *folders* starti=
ng
> >    with "netronome/nic_". The previous case was different because there=
,
> >    the "%s" is *at the start* of the format string.)
> >  - module_flash_fw_schedule() is reachable from the
> >    ETHTOOL_MSG_MODULE_FW_FLASH_ACT netlink command, which is marked as
> >    GENL_UNS_ADMIN_PERM (meaning CAP_NET_ADMIN inside a user namespace i=
s
> >    enough to pass the privilege check), and takes a userspace-provided
> >    firmware name.
> >    (But I think to reach this case, you need to have CAP_NET_ADMIN over=
 a
> >    network namespace that a special kind of ethernet device is mapped i=
nto,
> >    so I think this is not a viable attack path in practice.)
> >
> > For what it's worth, I went looking and haven't found any USB device
> > drivers that use the firmware loader dangerously.
>
> Your commit message very well describes the status quo, but only implies =
the
> problem, and skips how you intend to solve it.
>
> >
> > Cc: stable@vger.kernel.org
> > Fixes: abb139e75c2c ("firmware: teach the kernel to load firmware files=
 directly from the filesystem")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I wasn't sure whether to mark this one for stable or not - but I think
> > since there seems to be at least one PCI device model which could
> > trigger firmware loading with directory traversal, we should probably
> > backport the fix?
> > ---
> >  drivers/base/firmware_loader/main.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmwar=
e_loader/main.c
> > index a03ee4b11134..a32be64f3bf5 100644
> > --- a/drivers/base/firmware_loader/main.c
> > +++ b/drivers/base/firmware_loader/main.c
> > @@ -864,7 +864,15 @@ _request_firmware(const struct firmware **firmware=
_p, const char *name,
> >       if (!firmware_p)
> >               return -EINVAL;
> >
> > -     if (!name || name[0] =3D=3D '\0') {
> > +     /*
> > +      * Reject firmware file names with "/../" sequences in them.
> > +      * There are drivers that construct firmware file names from
> > +      * device-supplied strings, and we don't want some device to be a=
ble
> > +      * to tell us "I would like to be sent my firmware from
> > +      * ../../../etc/shadow, please".
> > +      */
> > +     if (!name || name[0] =3D=3D '\0' ||
> > +         strstr(name, "/../") !=3D NULL || strncmp(name, "../", 3) =3D=
=3D 0) {
>
> Seems reasonable, but are there any API users that rely on that?

I tried grepping for in-kernel users and didn't find any, though I
guess I could have missed something.
I suppose slightly more likely than in-kernel users, there could be
userspace code out there that intentionally uses netlink or sysfs
interfaces to tell the kernel to load from firmware paths outside the
firmware directory, though that would be kinda weird?

> I guess we can't just check for strstr(name, "../"), because "foo.." is a=
 valid
> file name?

Yeah, that's the intent.

> Maybe it would be worth adding a comment and / or a small
> helper function for that.

Yeah, I guess that might make it clearer.

> I also suggest to update the documentation of the firmware loader API to =
let
> people know that going back the path isn't tolerated by this API.

In Documentation/driver-api/firmware/request_firmware.rst, correct?

> >               ret =3D -EINVAL;
> >               goto out;
> >       }
> >
> > ---
> > base-commit: b0da640826ba3b6506b4996a6b23a429235e6923
> > change-id: 20240820-firmware-traversal-6df8501b0fe4
> > --
> > Jann Horn <jannh@google.com>
> >

