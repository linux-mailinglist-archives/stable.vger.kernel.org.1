Return-Path: <stable+bounces-69738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BEE958B9B
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 17:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BAC1C21F03
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FFD1922CE;
	Tue, 20 Aug 2024 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocOGto70"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC518C931;
	Tue, 20 Aug 2024 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168822; cv=none; b=sS71aZaxdMFkKKl33kXMAEj37JU1588D60t1zepsC/+jZwpyo0ksnsw59vcWWcs1cKLR0k3kttlkiCRlJk6RsxiHmCqDOF9pxopWg9oPOYUgqX49Eex6tLKSrwUe2FxVyfXcmXw4jre8KVuAtL5N9cqn8orkPQbqlqKX7+cluXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168822; c=relaxed/simple;
	bh=IDCFtySrwbnv4E55yXteca9TnXCHSbzzWC2n2UfPzu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deWSL5OqGuuMKOh3le3f5vBpur3rV9dud1MUUdECmjPk5iKH4ukXgNaSoLHt6GDOnviqMhKh1+2fqfhDTIOk/4ju5ptSuHb0BdazQgRq/umv6INqmTftBueLgmvJ+pMSDIMO/6KMGT41I9tIGuZj3+hiv0QIM2Pfnos78d1W9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocOGto70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD755C4AF0B;
	Tue, 20 Aug 2024 15:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724168821;
	bh=IDCFtySrwbnv4E55yXteca9TnXCHSbzzWC2n2UfPzu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocOGto704Dx5ZBAbFcMVTxIcMj6CnFc8fJggMBT5AmvDoJ96XAipA97fEQg0jAUPk
	 sZYAOXy2JJZNESQyRtDjmieVvPTXe3VoZ/P8khZd8dJbSAvQKdoQqcxvyV+BgiwppV
	 2rCo8nyO+x/rcYjCA6ELqZW9wakZvlguSTp2sI4k1wufPYkiwaLgY9NXk8vsVBTENb
	 6v9O/xG6M72EMz46A9pgyn2OJ51fgo8yJs6FQYKfxdIUGWmoghc69UAVNQHS+LKebY
	 /R9cHUF3WYtepP8yv3TOae/2zOkcthhSDFWBBQ6XtvxsqFuoRJhYoX0nAUu7Y9GpEs
	 BxZFELUBfuMSw==
Date: Tue, 20 Aug 2024 17:46:57 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: Block path traversal
Message-ID: <ZsS6ceikJ0pQJY1T@pollux>
References: <20240820-firmware-traversal-v1-1-8699ffaa9276@google.com>
 <ZsPf02GrdMiyZP8a@pollux>
 <CAG48ez3AEU+LD-i7Qwo3kreJ0zGQEZOnthFX++QTUOMxe3e40Q@mail.gmail.com>
 <CAG48ez3nUfUS3Ec=tMS91w20N2vY-D+_c_k19-=5hs0-_MLmfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3nUfUS3Ec=tMS91w20N2vY-D+_c_k19-=5hs0-_MLmfA@mail.gmail.com>

On Tue, Aug 20, 2024 at 02:42:46AM +0200, Jann Horn wrote:
> On Tue, Aug 20, 2024 at 2:23 AM Jann Horn <jannh@google.com> wrote:
> > On Tue, Aug 20, 2024 at 2:14 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > On Tue, Aug 20, 2024 at 01:18:54AM +0200, Jann Horn wrote:
> > > > Most firmware names are hardcoded strings, or are constructed from fairly
> > > > constrained format strings where the dynamic parts are just some hex
> > > > numbers or such.
> > > >
> > > > However, there are a couple codepaths in the kernel where firmware file
> > > > names contain string components that are passed through from a device or
> > > > semi-privileged userspace; the ones I could find (not counting interfaces
> > > > that require root privileges) are:
> > > >
> > > >  - lpfc_sli4_request_firmware_update() seems to construct the firmware
> > > >    filename from "ModelName", a string that was previously parsed out of
> > > >    some descriptor ("Vital Product Data") in lpfc_fill_vpd()
> > > >  - nfp_net_fw_find() seems to construct a firmware filename from a model
> > > >    name coming from nfp_hwinfo_lookup(pf->hwinfo, "nffw.partno"), which I
> > > >    think parses some descriptor that was read from the device.
> > > >    (But this case likely isn't exploitable because the format string looks
> > > >    like "netronome/nic_%s", and there shouldn't be any *folders* starting
> > > >    with "netronome/nic_". The previous case was different because there,
> > > >    the "%s" is *at the start* of the format string.)
> > > >  - module_flash_fw_schedule() is reachable from the
> > > >    ETHTOOL_MSG_MODULE_FW_FLASH_ACT netlink command, which is marked as
> > > >    GENL_UNS_ADMIN_PERM (meaning CAP_NET_ADMIN inside a user namespace is
> > > >    enough to pass the privilege check), and takes a userspace-provided
> > > >    firmware name.
> > > >    (But I think to reach this case, you need to have CAP_NET_ADMIN over a
> > > >    network namespace that a special kind of ethernet device is mapped into,
> > > >    so I think this is not a viable attack path in practice.)
> > > >
> > > > For what it's worth, I went looking and haven't found any USB device
> > > > drivers that use the firmware loader dangerously.
> > >
> > > Your commit message very well describes the status quo, but only implies the
> > > problem, and skips how you intend to solve it.
> > >
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: abb139e75c2c ("firmware: teach the kernel to load firmware files directly from the filesystem")
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > ---
> > > > I wasn't sure whether to mark this one for stable or not - but I think
> > > > since there seems to be at least one PCI device model which could
> > > > trigger firmware loading with directory traversal, we should probably
> > > > backport the fix?
> > > > ---
> > > >  drivers/base/firmware_loader/main.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> > > > index a03ee4b11134..a32be64f3bf5 100644
> > > > --- a/drivers/base/firmware_loader/main.c
> > > > +++ b/drivers/base/firmware_loader/main.c
> > > > @@ -864,7 +864,15 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
> > > >       if (!firmware_p)
> > > >               return -EINVAL;
> > > >
> > > > -     if (!name || name[0] == '\0') {
> > > > +     /*
> > > > +      * Reject firmware file names with "/../" sequences in them.
> > > > +      * There are drivers that construct firmware file names from
> > > > +      * device-supplied strings, and we don't want some device to be able
> > > > +      * to tell us "I would like to be sent my firmware from
> > > > +      * ../../../etc/shadow, please".
> > > > +      */
> > > > +     if (!name || name[0] == '\0' ||
> > > > +         strstr(name, "/../") != NULL || strncmp(name, "../", 3) == 0) {
> > >
> > > Seems reasonable, but are there any API users that rely on that?
> >
> > I tried grepping for in-kernel users and didn't find any, though I
> > guess I could have missed something.
> > I suppose slightly more likely than in-kernel users, there could be
> > userspace code out there that intentionally uses netlink or sysfs
> > interfaces to tell the kernel to load from firmware paths outside the
> > firmware directory, though that would be kinda weird?
> 
> I guess if we are seriously concerned that someone might rely on that,
> there are several things we could do to mitigate it, ordered by
> increasing level of how annoying it would be to implement and how much
> it would nerf the check:

To me option 1 sounds sufficient and reasonable.

> 
> 1. add a pr_warn() specifically for this case, so if it does break,
> users know what's wrong and can complain - I think I should probably
> do that in v2 anyway
> 2. add a module parameter to disable the check, so if it does break,
> users can immediately work around the issue
> 3. make the whole thing just a warning for now, and revisit it in a
> year or so to enable enforcement
> 
> My preference would be to implement number 1 but not 2/3, but if you
> think that's not enough to merge it, I could implement 2 or 3...
> 

