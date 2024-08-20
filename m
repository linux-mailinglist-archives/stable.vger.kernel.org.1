Return-Path: <stable+bounces-69654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F89D957A5B
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 02:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBC1B224AD
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 00:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06924C70;
	Tue, 20 Aug 2024 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XP2DqSav"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4628FD;
	Tue, 20 Aug 2024 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724112947; cv=none; b=NmXdIU8tcPEKRcKc5GQcrX2tw5kUvpqBJHZ5qggg3MvKn+cGXIG8yAlNEplg02qj/O0y/+bgMKdDekVFQjeJfrp6VtMcoGrmJtyHTC36yVy3VtDeX4CYbDtcucVsVsfRY6EACODeza/PhuHN5xlqynn/ft23qUVbOcr9D8FYU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724112947; c=relaxed/simple;
	bh=ZhFtTfirgz3DC5PC/82DyClMEaRswpHr2PJJKZJnIdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAwWXoeQreknPGxHKpCxKuoxB50LhHAnoksVXowkxMim4MPKsiH9df8Y2AG7UQiMfeECxBvj6rjtWzZznYkjOdLwZvKWvwFD1U4EMkjaKv83cVcGDgYdSsDpXSVAMc6b74g/rMHmhOFl6OGBxVskRX4wnrhd3IqnNhgiYAF4Qy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XP2DqSav; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Wa+cNo3cMGy3we7u2qdW4EcPbREpLmZxSIdLNPhDvo=; b=XP2DqSavIBXSg0MPLm1di5waiG
	fuAb38umQ+rVmG6tvmTVq1AfxF6pG9vdmxnZ/iJtI9ggQ1wSWQ4+TQbBpf+9D0YiV0Y5ZsnAQ0uV6
	dDZl++g1ZFbVlB7scMOD+wFnvzGg8+aVgpYEV0Gxd+pbynQyeDbxJcsxiMBjvGHD2rquc3N9N2ill
	AlTUyQnBji9fHX4IVz61Iyp862m8MJuY8w5B1DVFD/o330O3mt8vIownJG4fItLtd+rTj28Q1Gsym
	cKZjVr9+PkDaW7Ywl+lSBMcrnkbabFLHcsfRpWYPC70VhC5dHT/qabN03nyTcOn8KLp82dCKtQFnz
	/qVvd4nQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgCXH-00000003IuO-36Or;
	Tue, 20 Aug 2024 00:15:43 +0000
Date: Mon, 19 Aug 2024 17:15:43 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Jann Horn <jannh@google.com>, Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: Block path traversal
Message-ID: <ZsPgLxDc7NiL7W8_@bombadil.infradead.org>
References: <20240820-firmware-traversal-v1-1-8699ffaa9276@google.com>
 <ZsPf02GrdMiyZP8a@pollux>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsPf02GrdMiyZP8a@pollux>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Aug 20, 2024 at 02:14:11AM +0200, Danilo Krummrich wrote:
> On Tue, Aug 20, 2024 at 01:18:54AM +0200, Jann Horn wrote:
> > Most firmware names are hardcoded strings, or are constructed from fairly
> > constrained format strings where the dynamic parts are just some hex
> > numbers or such.
> > 
> > However, there are a couple codepaths in the kernel where firmware file
> > names contain string components that are passed through from a device or
> > semi-privileged userspace; the ones I could find (not counting interfaces
> > that require root privileges) are:
> > 
> >  - lpfc_sli4_request_firmware_update() seems to construct the firmware
> >    filename from "ModelName", a string that was previously parsed out of
> >    some descriptor ("Vital Product Data") in lpfc_fill_vpd()
> >  - nfp_net_fw_find() seems to construct a firmware filename from a model
> >    name coming from nfp_hwinfo_lookup(pf->hwinfo, "nffw.partno"), which I
> >    think parses some descriptor that was read from the device.
> >    (But this case likely isn't exploitable because the format string looks
> >    like "netronome/nic_%s", and there shouldn't be any *folders* starting
> >    with "netronome/nic_". The previous case was different because there,
> >    the "%s" is *at the start* of the format string.)
> >  - module_flash_fw_schedule() is reachable from the
> >    ETHTOOL_MSG_MODULE_FW_FLASH_ACT netlink command, which is marked as
> >    GENL_UNS_ADMIN_PERM (meaning CAP_NET_ADMIN inside a user namespace is
> >    enough to pass the privilege check), and takes a userspace-provided
> >    firmware name.
> >    (But I think to reach this case, you need to have CAP_NET_ADMIN over a
> >    network namespace that a special kind of ethernet device is mapped into,
> >    so I think this is not a viable attack path in practice.)
> > 
> > For what it's worth, I went looking and haven't found any USB device
> > drivers that use the firmware loader dangerously.
> 
> Your commit message very well describes the status quo, but only implies the
> problem, and skips how you intend to solve it.
> 
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: abb139e75c2c ("firmware: teach the kernel to load firmware files directly from the filesystem")
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
> > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> > index a03ee4b11134..a32be64f3bf5 100644
> > --- a/drivers/base/firmware_loader/main.c
> > +++ b/drivers/base/firmware_loader/main.c
> > @@ -864,7 +864,15 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
> >  	if (!firmware_p)
> >  		return -EINVAL;
> >  
> > -	if (!name || name[0] == '\0') {
> > +	/*
> > +	 * Reject firmware file names with "/../" sequences in them.
> > +	 * There are drivers that construct firmware file names from
> > +	 * device-supplied strings, and we don't want some device to be able
> > +	 * to tell us "I would like to be sent my firmware from
> > +	 * ../../../etc/shadow, please".
> > +	 */
> > +	if (!name || name[0] == '\0' ||
> > +	    strstr(name, "/../") != NULL || strncmp(name, "../", 3) == 0) {
> 
> Seems reasonable, but are there any API users that rely on that?

If so, then those all need to be fixed otherwise you will get terrible
user experiences by just upgrading the kernel.

  Luis

