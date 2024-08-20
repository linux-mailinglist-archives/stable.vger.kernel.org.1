Return-Path: <stable+bounces-69653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03B7957A59
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 02:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8392836C3
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 00:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138EB1849;
	Tue, 20 Aug 2024 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flMuUXjJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0701256D;
	Tue, 20 Aug 2024 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724112856; cv=none; b=Q4KMRiHD7Dgmt8KcdXjZ4lv6DFZkKZO8y6SqIq5LVE1dS0tygp0TFK4rggP72wE7h/sx/d7X4AdFuX783GkObwu1oaM6GnTIB4MmxXMnUIc4MBGJl0FuxTboSkSUyGRuAIrDG/Crr28INUahnH4/Dotm6GzXhW40OpVjXsYg+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724112856; c=relaxed/simple;
	bh=3njF1pZnLVbCy2/o8ipe4+1j6JMuc1yt4Emn046rVvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZL8uLR865IxaBvrRHC4E2+VmoX09YOr417/tgVzw1C6HLGSOJ1HGy85FhxpeZrqSvm10KAYYhyGvjnNIcDO87S6hmmu54n/+uSoKU4RSEZDCKkaqJJR9+p+H6HWXYezISYb6w9gxkFASozIbOQLcy2ewsBVbfXDVmIK68ECUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flMuUXjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88BDC32782;
	Tue, 20 Aug 2024 00:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724112856;
	bh=3njF1pZnLVbCy2/o8ipe4+1j6JMuc1yt4Emn046rVvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flMuUXjJ5ICiPQPp8SAzfa417Dq9AI+9jTcF1Httip6wMaIkWqBsr0tMd0shvhJ/B
	 fu3oX2VAZFkTck39jeyN20x8SPA61Wc4nvdmyY69+FO+j24abKQs5PAiL33NtRPV35
	 2bvNqVlgJavJrEWn+FWy7GB99L2K+V2IMomWQiVR88l9vCo2AmJeMGMFhY1wCj2fcm
	 BX3AJ0ubX8dNLHQJOJI3hTr2hDm10fRO71CN6hq6MEddppqQphuzwyKiH8xM5LUgUE
	 lgpdNbTI3lz3AcnZE6Uiw9Wr0Xygl3sGkNfUPXy/uV09zFQpxsNvnaC3gyqPsGL3rG
	 VLzDxubn9mb5A==
Date: Tue, 20 Aug 2024 02:14:11 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: Block path traversal
Message-ID: <ZsPf02GrdMiyZP8a@pollux>
References: <20240820-firmware-traversal-v1-1-8699ffaa9276@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820-firmware-traversal-v1-1-8699ffaa9276@google.com>

On Tue, Aug 20, 2024 at 01:18:54AM +0200, Jann Horn wrote:
> Most firmware names are hardcoded strings, or are constructed from fairly
> constrained format strings where the dynamic parts are just some hex
> numbers or such.
> 
> However, there are a couple codepaths in the kernel where firmware file
> names contain string components that are passed through from a device or
> semi-privileged userspace; the ones I could find (not counting interfaces
> that require root privileges) are:
> 
>  - lpfc_sli4_request_firmware_update() seems to construct the firmware
>    filename from "ModelName", a string that was previously parsed out of
>    some descriptor ("Vital Product Data") in lpfc_fill_vpd()
>  - nfp_net_fw_find() seems to construct a firmware filename from a model
>    name coming from nfp_hwinfo_lookup(pf->hwinfo, "nffw.partno"), which I
>    think parses some descriptor that was read from the device.
>    (But this case likely isn't exploitable because the format string looks
>    like "netronome/nic_%s", and there shouldn't be any *folders* starting
>    with "netronome/nic_". The previous case was different because there,
>    the "%s" is *at the start* of the format string.)
>  - module_flash_fw_schedule() is reachable from the
>    ETHTOOL_MSG_MODULE_FW_FLASH_ACT netlink command, which is marked as
>    GENL_UNS_ADMIN_PERM (meaning CAP_NET_ADMIN inside a user namespace is
>    enough to pass the privilege check), and takes a userspace-provided
>    firmware name.
>    (But I think to reach this case, you need to have CAP_NET_ADMIN over a
>    network namespace that a special kind of ethernet device is mapped into,
>    so I think this is not a viable attack path in practice.)
> 
> For what it's worth, I went looking and haven't found any USB device
> drivers that use the firmware loader dangerously.

Your commit message very well describes the status quo, but only implies the
problem, and skips how you intend to solve it.

> 
> Cc: stable@vger.kernel.org
> Fixes: abb139e75c2c ("firmware: teach the kernel to load firmware files directly from the filesystem")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I wasn't sure whether to mark this one for stable or not - but I think
> since there seems to be at least one PCI device model which could
> trigger firmware loading with directory traversal, we should probably
> backport the fix?
> ---
>  drivers/base/firmware_loader/main.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index a03ee4b11134..a32be64f3bf5 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -864,7 +864,15 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  	if (!firmware_p)
>  		return -EINVAL;
>  
> -	if (!name || name[0] == '\0') {
> +	/*
> +	 * Reject firmware file names with "/../" sequences in them.
> +	 * There are drivers that construct firmware file names from
> +	 * device-supplied strings, and we don't want some device to be able
> +	 * to tell us "I would like to be sent my firmware from
> +	 * ../../../etc/shadow, please".
> +	 */
> +	if (!name || name[0] == '\0' ||
> +	    strstr(name, "/../") != NULL || strncmp(name, "../", 3) == 0) {

Seems reasonable, but are there any API users that rely on that?

I guess we can't just check for strstr(name, "../"), because "foo.." is a valid
file name? Maybe it would be worth adding a comment and / or a small
helper function for that.

I also suggest to update the documentation of the firmware loader API to let
people know that going back the path isn't tolerated by this API.

>  		ret = -EINVAL;
>  		goto out;
>  	}
> 
> ---
> base-commit: b0da640826ba3b6506b4996a6b23a429235e6923
> change-id: 20240820-firmware-traversal-6df8501b0fe4
> -- 
> Jann Horn <jannh@google.com>
> 

