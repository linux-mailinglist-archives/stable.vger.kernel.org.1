Return-Path: <stable+bounces-161782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3276DB031D4
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 17:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8106D17C034
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AD327A914;
	Sun, 13 Jul 2025 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="11JyN7ja"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0951E9B29;
	Sun, 13 Jul 2025 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752421309; cv=none; b=Q/7hvzItgmsHyBDXC0zac9KGdzqUUhDhWI8j9TJ6aSCWbXqhvsgPvhLOKVyBBV8G6vJ8/m83w0okBWdFjQI2UiytCKQVyuk8Qw+hn5GWVrrUURQ6dXA3Rnoe/4MdgKz5QbQL4dryoSQqAjiPmgS6Bc7Z/nfr1+MJBmn9QNqvpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752421309; c=relaxed/simple;
	bh=8aYlZ85zPEDarVjaxlfqx/WOc4Pio6fy0Bz9vlgLZXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yby5kmqOTIV1iFKQ/+wHQrWAQE+Kv3uR8uhUbHeNXYR5pXVokwVqn+7ggpJd3HV9U24EJIfKJZwth1Ib/zxmPzBphomnMCtm/7CrojxDmM2ZwCHXlP72ttMJu/DxInuZsZG8o/MkGs+ETurJvl3eCveDP/M+xE4ITw+DCMjM6i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=11JyN7ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B21C4CEE3;
	Sun, 13 Jul 2025 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752421309;
	bh=8aYlZ85zPEDarVjaxlfqx/WOc4Pio6fy0Bz9vlgLZXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=11JyN7jaHhLVjhziQLkVyu7DMkGaWWXyU2MbTui6Qa0F5cJdQMU7mAY0DdqxC83bx
	 nFbV2utAOM+WCCzNndT53bf6tkc+3BNA5SYn3EH5Mha9uJhlnZAoOKxvxtgnHCvoba
	 49wxXNz2AltVX12DeKwYU44jmnFZgUhvj0crbPyM=
Date: Sun, 13 Jul 2025 17:41:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: srini@kernel.org
Cc: linux-kernel@vger.kernel.org, "Michael C. Pratt" <mcpratt@pm.me>,
	INAGAKI Hiroshi <musashino.open@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvmem: layouts: u-boot-env: remove crc32 endianness
 conversion
Message-ID: <2025071308-upfront-romp-fa1e@gregkh>
References: <20250712181729.6495-1-srini@kernel.org>
 <20250712181729.6495-2-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712181729.6495-2-srini@kernel.org>

On Sat, Jul 12, 2025 at 07:17:26PM +0100, srini@kernel.org wrote:
> From: "Michael C. Pratt" <mcpratt@pm.me>
> 
> On 11 Oct 2022, it was reported that the crc32 verification
> of the u-boot environment failed only on big-endian systems
> for the u-boot-env nvmem layout driver with the following error.
> 
>   Invalid calculated CRC32: 0x88cd6f09 (expected: 0x096fcd88)
> 
> This problem has been present since the driver was introduced,
> and before it was made into a layout driver.
> 
> The suggested fix at the time was to use further endianness
> conversion macros in order to have both the stored and calculated
> crc32 values to compare always represented in the system's endianness.
> This was not accepted due to sparse warnings
> and some disagreement on how to handle the situation.
> Later on in a newer revision of the patch, it was proposed to use
> cpu_to_le32() for both values to compare instead of le32_to_cpu()
> and store the values as __le32 type to remove compilation errors.
> 
> The necessity of this is based on the assumption that the use of crc32()
> requires endianness conversion because the algorithm uses little-endian,
> however, this does not prove to be the case and the issue is unrelated.
> 
> Upon inspecting the current kernel code,
> there already is an existing use of le32_to_cpu() in this driver,
> which suggests there already is special handling for big-endian systems,
> however, it is big-endian systems that have the problem.
> 
> This, being the only functional difference between architectures
> in the driver combined with the fact that the suggested fix
> was to use the exact same endianness conversion for the values
> brings up the possibility that it was not necessary to begin with,
> as the same endianness conversion for two values expected to be the same
> is expected to be equivalent to no conversion at all.
> 
> After inspecting the u-boot environment of devices of both endianness
> and trying to remove the existing endianness conversion,
> the problem is resolved in an equivalent way as the other suggested fixes.
> 
> Ultimately, it seems that u-boot is agnostic to endianness
> at least for the purpose of environment variables.
> In other words, u-boot reads and writes the stored crc32 value
> with the same endianness that the crc32 value is calculated with
> in whichever endianness a certain architecture runs on.
> 
> Therefore, the u-boot-env driver does not need to convert endianness.
> Remove the usage of endianness macros in the u-boot-env driver,
> and change the type of local variables to maintain the same return type.
> 
> If there is a special situation in the case of endianness,
> it would be a corner case and should be handled by a unique "compatible".
> 
> Even though it is not necessary to use endianness conversion macros here,
> it may be useful to use them in the future for consistent error printing.
> 
> Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")

Note, this is a 6.1 commit id, but:

> Reported-by: INAGAKI Hiroshi <musashino.open@gmail.com>
> Link: https://lore.kernel.org/all/20221011024928.1807-1-musashino.open@gmail.com
> Cc: stable@vger.kernel.org # 6.12.x
> Cc: stable@vger.kernel.org # 6.6.x: f4cf4e5: Revert "nvmem: add new config option"
> Cc: stable@vger.kernel.org # 6.6.x: 7f38b70: of: device: Export of_device_make_bus_id()
> Cc: stable@vger.kernel.org # 6.6.x: 4a1a402: nvmem: Move of_nvmem_layout_get_container() in another header
> Cc: stable@vger.kernel.org # 6.6.x: fc29fd8: nvmem: core: Rework layouts to become regular devices
> Cc: stable@vger.kernel.org # 6.6.x: 0331c61: nvmem: core: Expose cells through sysfs
> Cc: stable@vger.kernel.org # 6.6.x: 401df0d: nvmem: layouts: refactor .add_cells() callback arguments
> Cc: stable@vger.kernel.org # 6.6.x: 6d0ca4a: nvmem: layouts: store owner from modules with nvmem_layout_driver_register()
> Cc: stable@vger.kernel.org # 6.6.x: 5f15811: nvmem: layouts: add U-Boot env layout
> Cc: stable@vger.kernel.org # 6.6.x

That's a load of (short) git ids for just 6.6.y?  What about 6.1.y?

thanks,

greg k-h

