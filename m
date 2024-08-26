Return-Path: <stable+bounces-70148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F240595ECC4
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 11:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9821F21C36
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C66C13D2A9;
	Mon, 26 Aug 2024 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUn68kUK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67684A4D;
	Mon, 26 Aug 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663420; cv=none; b=UAGQvspTAUMX4QClihNKq7K9OY60S+Et5lB9JBNkjVWF/+rFOZmD8BlTlpffCcfw0+0RLEaW4uZeItwQDFjMnYcQx1IPtsH38N6JJlyu+yR56HtqYS3kxtzcMOkcqOgrjNoxknUvsfJe/Tv1pqgj7OAqe6TRfrhD9U6sXyCKQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663420; c=relaxed/simple;
	bh=2cv7ty4MNkVJoRAIsHo474qKehjbZ52h5f/tEaptmgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVSazDvHLSs49qcYzZlVLZcN7dX2IhiWZijzHM3d9LtXWoGaT/93dE7MLrwdMSEaAmtP1XsaO2h2iawyPMALKDPcFAExdJyNyxXWVKnleavUuYiXnckXGzeQH5k2v51Q4DRRF5+OS5jLfFwytBOygT6kHuoov0zPLyLGAri51hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUn68kUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B344C8CDC1;
	Mon, 26 Aug 2024 09:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724663419;
	bh=2cv7ty4MNkVJoRAIsHo474qKehjbZ52h5f/tEaptmgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUn68kUKaBqUp7KqTQn4FprqpYIlUQDE4JXIQpvH/5V67LwKPtxz9cbQe3ZY1DRNg
	 DkCa1+NsJMdL3pEo3W8ET+Swn5OfU7Qoz02okiXyol2rQrPXusiQatpTPoQG7ujAQ4
	 miqc829bu3UM56Bn7jO24CqvNBRrN7cKJTF0AZOOyYOaRz6QTNJcebu32LOLyfSLE2
	 41jSpjdTJFpv83kr+QLx/EbOEqhfqM4VVihkjTgoHzWpS1D2Jn6MiQZPygEb3gFhqc
	 Wc9vXO0qGJZ4hz4P84eVcduaI7AN1ihlN/m0o6+ZzNaTGb/K3DFZARBnSjCwUAtJ93
	 jzDuLVANQsNBg==
Date: Mon, 26 Aug 2024 11:10:15 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] firmware_loader: Block path traversal
Message-ID: <ZsxGd6KRzS8i11zZ@pollux>
References: <20240823-firmware-traversal-v2-1-880082882709@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-firmware-traversal-v2-1-880082882709@google.com>

On Fri, Aug 23, 2024 at 08:38:55PM +0200, Jann Horn wrote:
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
> Fix it by rejecting any firmware names containing ".." path components.
> 
> For what it's worth, I went looking and haven't found any USB device
> drivers that use the firmware loader dangerously.
> 
> Cc: stable@vger.kernel.org
> Fixes: abb139e75c2c ("firmware: teach the kernel to load firmware files directly from the filesystem")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Changes in v2:
> - describe fix in commit message (dakr)
> - write check more clearly and with comment in separate helper (dakr)
> - document new restriction in comment above request_firmware() (dakr)
> - warn when new restriction is triggered
> - Link to v1: https://lore.kernel.org/r/20240820-firmware-traversal-v1-1-8699ffaa9276@google.com
> ---
>  drivers/base/firmware_loader/main.c | 41 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index a03ee4b11134..dd47ce9a761f 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -849,6 +849,37 @@ static void fw_log_firmware_info(const struct firmware *fw, const char *name,
>  {}
>  #endif
>  
> +/*
> + * Reject firmware file names with ".." path components.
> + * There are drivers that construct firmware file names from device-supplied
> + * strings, and we don't want some device to be able to tell us "I would like to
> + * be sent my firmware from ../../../etc/shadow, please".
> + *
> + * Search for ".." surrounded by either '/' or start/end of string.
> + *
> + * This intentionally only looks at the firmware name, not at the firmware base
> + * directory or at symlink contents.
> + */
> +static bool name_contains_dotdot(const char *name)
> +{
> +	size_t name_len = strlen(name);
> +	size_t i;
> +
> +	if (name_len < 2)
> +		return false;
> +	for (i = 0; i < name_len - 1; i++) {
> +		/* do we see a ".." sequence? */
> +		if (name[i] != '.' || name[i+1] != '.')
> +			continue;
> +
> +		/* is it a path component? */
> +		if ((i == 0 || name[i-1] == '/') &&
> +		    (i == name_len - 2 || name[i+2] == '/'))
> +			return true;
> +	}
> +	return false;
> +}
> +
>  /* called from request_firmware() and request_firmware_work_func() */
>  static int
>  _request_firmware(const struct firmware **firmware_p, const char *name,
> @@ -869,6 +900,14 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  		goto out;
>  	}
>  
> +	if (name_contains_dotdot(name)) {
> +		dev_warn(device,
> +			 "Firmware load for '%s' refused, path contains '..' component",
> +			 name);

I think you're missing '\n' here.

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	ret = _request_firmware_prepare(&fw, name, device, buf, size,
>  					offset, opt_flags);
>  	if (ret <= 0) /* error or already assigned */
> @@ -946,6 +985,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>   *      @name will be used as $FIRMWARE in the uevent environment and
>   *      should be distinctive enough not to be confused with any other
>   *      firmware image for this or any other device.
> + *	It must not contain any ".." path components - "foo/bar..bin" is
> + *	allowed, but "foo/../bar.bin" is not.
>   *
>   *	Caller must hold the reference count of @device.
>   *
> 
> ---
> base-commit: b0da640826ba3b6506b4996a6b23a429235e6923
> change-id: 20240820-firmware-traversal-6df8501b0fe4
> -- 
> Jann Horn <jannh@google.com>
> 

