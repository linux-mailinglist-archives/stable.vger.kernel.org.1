Return-Path: <stable+bounces-70075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F81995DA2F
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 02:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FF328209B
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 00:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3037C625;
	Sat, 24 Aug 2024 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SulSZrph"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2317161;
	Sat, 24 Aug 2024 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458493; cv=none; b=uuTMEvIrwRJxxxLV2Ae1NMc0+dsdA5FIwpuuEVzSMjwWuYGAKs69SiSXiEyGn7Po7FvCzwVhIU9kTKPTRNpJC7I1GNMurtsKVDlEXJGKPRALVpjVEVg2VaZwCBPTSihGb86M5Yip7XDzE6jTO9xbHbviUxtww/wOrxd0W1Mm3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458493; c=relaxed/simple;
	bh=xOPjGge/Ya7kLxZ4Tct5scvKiHZs0n9DIsbK5p39oqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atr2thr+UxJixqaACsgbLQbMYsFj98P3sKd3GpCAncl6IftHYGjuD1xZ9rcm4Ggffxbj16LvDuvo5Im+WKwgMY0plSJTozsV03B/MyNvGcpfO2c8iJLAZh3M5zmhzZIEmp/IxfwjVuS4+BWJNjFVPSFdV4ER9BqBGLDQfhj+C0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SulSZrph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFE9C32786;
	Sat, 24 Aug 2024 00:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724458492;
	bh=xOPjGge/Ya7kLxZ4Tct5scvKiHZs0n9DIsbK5p39oqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SulSZrphM7hp/usEKgKXExL/nn3uf3Yb6EpIKshkS358NK95Rb4l2Dx8oD/11uhmx
	 4BxKwC2MygDwDvJhj2rL9rqNnwAnV7AN1iJSaNd0rCIDKVN1VTnpXVJobL+CEE/yGi
	 lQDpyrNZQuhRVS2nDle6laZaoPq+yK6Nk9pZzoZOG/YrazdVMgGqRdyg07Uk48TPQ8
	 Ekj9sSwZl45dvd4+v274vYp0qOagAPRXJRGb2469Yzl/b/yU+helktfmkc4wnBhrSb
	 u3vmgQatM0Skr2MfN0eqIqTV6TttiRje5NZYS2dgYoRLKPIgfGkY3FrWj7pmexisjx
	 ZYksrdHZPfGHg==
Date: Sat, 24 Aug 2024 02:14:47 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] firmware_loader: Block path traversal
Message-ID: <Zskl9-0VKnixHA9X@pollux>
References: <20240823-firmware-traversal-v2-1-880082882709@google.com>
 <Zsj7afivXqOL1FXG@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsj7afivXqOL1FXG@bombadil.infradead.org>

On Fri, Aug 23, 2024 at 02:13:13PM -0700, Luis Chamberlain wrote:
> On Fri, Aug 23, 2024 at 08:38:55PM +0200, Jann Horn wrote:
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
> > Fix it by rejecting any firmware names containing ".." path components.
> > 
> > For what it's worth, I went looking and haven't found any USB device
> > drivers that use the firmware loader dangerously.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: abb139e75c2c ("firmware: teach the kernel to load firmware files directly from the filesystem")
> > Signed-off-by: Jann Horn <jannh@google.com>
> 
> I'm all for this, however a strong rejection outright for the first
> kernel release is bound to end up with some angry user with some oddball
> driver that had this for whatever stupid reason. Without a semantic
> patch assessment to do this (I think its possible with coccinelle) I'd

I don't think we can fully validate it, there are lots of cases, where path
names are passed through large call stacks, concatenated with other strings,
selected from arrays, etc.

So, if we want to be extra careful, we should indeed just warn for now.

> suggest for now we leave the warning in place for one kernel release,
> and for the one after we enforce this.

I'd expect it to take a bit longer until someone recognizes when drivers for
embedded stuff hit this, but that's probably fine, hopefully some vendor
discovers it before it goes to end users. :)

> 
> Linus might feel differently over it, and may want it right away. I'll
> let him chime in.
> 
>   Luis
> 

