Return-Path: <stable+bounces-70070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB7895D858
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 23:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2361E1F2294E
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 21:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC77C1C8235;
	Fri, 23 Aug 2024 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gQD+gpTF"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3641C6F7D;
	Fri, 23 Aug 2024 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447598; cv=none; b=ge8mzIfIf+ALNQprDZzJKwTJzU94/BjajVXjscVbmnG3KWcBkRUSb6+TE3sQGg3T5XdB9e2lrcSkPxELTuuAWreeNhc2ndARlO6mOMb45d1QKDCzz1VqH197i+2+FQlXgbh6Fb2qIpQs6M1CFs94rlRwYZ306FZnqFkQOcQVjus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447598; c=relaxed/simple;
	bh=1nEJx3outJ+wke5kcoDryNAAJEh2QSIqPPR40g836og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEInMvZ/qZXMKXLQqPqj4RmRoR9YtVsAZ0b+ioNqtd3vvlkg6qVABL5MJzK+2ariR3jO/6qMtzliBZabrAWZQqPFC4mm++dtlkTaxuXTTFKMpaW8wLT5zwpn2AGjy/xeCwJXoqVD4tNYHLKLMTxZqA88ga6qCbOy9vC5AyXl7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gQD+gpTF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rNQiKOG3WfAl8BLbmtekSaNfRZH3KyMD9Ikmqm2WXo8=; b=gQD+gpTFpwSYyZUQXcUv+bXDyh
	MmogKs3tLKfm7VUWrREvEvooEn24CJ1uamzcUqlRbT0hpzVjKa+YjY2Re9bNmJoQAHWXxd5fhm1g2
	Jri5dxBL2LMGrK0vTMvHa5Ov6Z587Pi/lP3Qmp1UD6/YfpUcKRDjZaN9rjzEw42mH63jGpCb/vo1L
	x3GrSfAJ6UWeOLBPbTZIJL5ihJElAjZ5+SeasjdNZ/RcQ+RM+tPZkFYTqbLoiOWaYigQIw00wjh+d
	t6mNV2ntun8Q37VGxzHnL1fTevN8iF5iGTMEAcYVkiad6m68wEEw1CeXEf3kd7JotZw7ENwuyv/VT
	3WlHGXWg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shbar-00000000gZm-3kwC;
	Fri, 23 Aug 2024 21:13:13 +0000
Date: Fri, 23 Aug 2024 14:13:13 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] firmware_loader: Block path traversal
Message-ID: <Zsj7afivXqOL1FXG@bombadil.infradead.org>
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
Sender: Luis Chamberlain <mcgrof@infradead.org>

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

I'm all for this, however a strong rejection outright for the first
kernel release is bound to end up with some angry user with some oddball
driver that had this for whatever stupid reason. Without a semantic
patch assessment to do this (I think its possible with coccinelle) I'd
suggest for now we leave the warning in place for one kernel release,
and for the one after we enforce this.

Linus might feel differently over it, and may want it right away. I'll
let him chime in.

  Luis

