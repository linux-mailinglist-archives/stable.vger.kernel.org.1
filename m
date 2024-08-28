Return-Path: <stable+bounces-71443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB44F9633CD
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 23:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8487728516F
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 21:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABF61AC433;
	Wed, 28 Aug 2024 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L9OdHDn1"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ABF139578;
	Wed, 28 Aug 2024 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880378; cv=none; b=I8v8ts3aMEqD0BxxWoj4b4eQZNHeSnBfpZA4A3Poto6pnazsLdiDukcX77HIMwMrJRKhHneItKjwVbzoZ0LGJBfLsH5BZhphTFk4TRnV+UNNybYY0Gr4utIDf7TE+MlST8ycg3p4V1ZA262V97rsl9hMyFJ2q8LYIXZCBI959b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880378; c=relaxed/simple;
	bh=tIFBR5zZigwKAzTLvkfz3ziB0klPsIbKkC11BAvQVKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzpAEk+VMs6jN1hxi+XSbg3bWUVPffB7dmGtrNOznb9K4gfFQG/RwRUeDOtqChTnaceFAfmtlSSnLFOzbH2bopLwESKVs5SYnvKSr8eL5y4UF768AOWq31ph0m6TrPugZ5gjk0siyRKGg4uR1DQkV+QF68aE9hedUQB66HOdv2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L9OdHDn1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bHDIu89IQZJM8PA9F7hSbcqwWr6M4mep6IQVFex1qGI=; b=L9OdHDn1mcF9LexG892rggXu0t
	6mdlwj7x6jw7C3K+3w0vJhgYpbRpk5fwWWkD0ey9tj6TpVmA8fG6vbVhOryXRbHkSnGcWauiJ7343
	UTYYK4bVdlhzBdhUMePf32/OIdkp3RAm+v2KZmO41O30LiNWGS0oLorF2A4aJ4vYjEw8VvA+/fmbW
	w9DsMD94gakY7qqiOvUs0EL90K2/tAQWC2RLj6LiZgjIwwU273rW1/Z7s3UA4pXke8b7RkJfVOLKk
	zZXvUw3oTDQJQnyuDHg963e9OoBJkS4ZE3gl8y7MJ6mxJ1oUW2QFFXVgft3sHwgu4KXI8NCAK6Kwn
	1X7mKCWw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjQBA-0000000H3se-43lq;
	Wed, 28 Aug 2024 21:26:12 +0000
Date: Wed, 28 Aug 2024 14:26:12 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v3] firmware_loader: Block path traversal
Message-ID: <Zs-V9AZK5NkmoRSS@bombadil.infradead.org>
References: <20240828-firmware-traversal-v3-1-c76529c63b5f@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828-firmware-traversal-v3-1-c76529c63b5f@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Aug 28, 2024 at 01:45:48AM +0200, Jann Horn wrote:
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
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Fixes: abb139e75c2c ("firmware: teach the kernel to load firmware files directly from the filesystem")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---

Can you also extend tools/testing/selftests/firmware/ with a respective
test for this to ensure it works? With that:

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

