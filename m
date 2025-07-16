Return-Path: <stable+bounces-163088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8322B07205
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 11:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0747B17CA57
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3B32EF646;
	Wed, 16 Jul 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Al71AiLa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF02701CE;
	Wed, 16 Jul 2025 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658928; cv=none; b=EXKsG7VCYs30OyBQgWT6ki0DOdpgf4KmgT+ya3tG4CMhJ6KUHA7wa5BhJKOOaT9L8OVgkRX7FK38IZ1//z7x3FLyiXnlwsq4UcysA3HUiBqG2slCWGfxvKUVdmIMM3nxQfVfM5LMz3patAdfKLoMhysbiyh2eulWFQBYYbBeOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658928; c=relaxed/simple;
	bh=sn26vG9Lu7xSLIkMBif0HOVxMMvKjr4ApngzjQSu0Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R54nduzIvV4naAgbrevCOEX+R/gv1VVuN27DO/akd+Y38hTHMn71cD6TfBbAqQpwUEWoEq85ic5Ono/o+tKOhmE7iTtKOuUOzoSkPfbWZcaCp0xE0U6gRPeiXudPkBCg1eT8HwmtHmW23sYCDei8f0r58nTIfPm8X5uClfv91xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Al71AiLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65AEC4CEF0;
	Wed, 16 Jul 2025 09:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752658928;
	bh=sn26vG9Lu7xSLIkMBif0HOVxMMvKjr4ApngzjQSu0Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Al71AiLaI/dpXeER9zPwY30mq0qNyAGHefX0OEvfJFBjNNKE4WmSEyVWgKckjuIVC
	 srJxfiYeO+d6AoPSqqK6HyCsZuIUkokJaMZ1L3/VDbN92IJPTYtZvbQ1X5e5mXJ6Z+
	 tUP2o9EwGzHBHGUOnow0nKfE+XNRyt5NwOIaF+Bk=
Date: Wed, 16 Jul 2025 11:42:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Michael C. Pratt" <mcpratt@pm.me>,
	INAGAKI Hiroshi <musashino.open@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvmem: layouts: u-boot-env: remove crc32 endianness
 conversion
Message-ID: <2025071656-heap-student-9163@gregkh>
References: <20250712181729.6495-1-srini@kernel.org>
 <20250712181729.6495-2-srini@kernel.org>
 <2025071308-upfront-romp-fa1e@gregkh>
 <2025071313-zippy-boneless-da1c@gregkh>
 <b25f83e8-7e5d-44f8-9f16-909cb005aadd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b25f83e8-7e5d-44f8-9f16-909cb005aadd@kernel.org>

On Tue, Jul 15, 2025 at 04:44:00PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 7/13/25 4:42 PM, Greg KH wrote:
> > On Sun, Jul 13, 2025 at 05:41:45PM +0200, Greg KH wrote:
> >> On Sat, Jul 12, 2025 at 07:17:26PM +0100, srini@kernel.org wrote:
> >>> From: "Michael C. Pratt" <mcpratt@pm.me>
> >>>
> >>> On 11 Oct 2022, it was reported that the crc32 verification
> >>> of the u-boot environment failed only on big-endian systems
> >>> for the u-boot-env nvmem layout driver with the following error.
> >>>
> >>>   Invalid calculated CRC32: 0x88cd6f09 (expected: 0x096fcd88)
> >>>
> >>> This problem has been present since the driver was introduced,
> >>> and before it was made into a layout driver.
> >>>
> >>> The suggested fix at the time was to use further endianness
> >>> conversion macros in order to have both the stored and calculated
> >>> crc32 values to compare always represented in the system's endianness.
> >>> This was not accepted due to sparse warnings
> >>> and some disagreement on how to handle the situation.
> >>> Later on in a newer revision of the patch, it was proposed to use
> >>> cpu_to_le32() for both values to compare instead of le32_to_cpu()
> >>> and store the values as __le32 type to remove compilation errors.
> >>>
> >>> The necessity of this is based on the assumption that the use of crc32()
> >>> requires endianness conversion because the algorithm uses little-endian,
> >>> however, this does not prove to be the case and the issue is unrelated.
> >>>
> >>> Upon inspecting the current kernel code,
> >>> there already is an existing use of le32_to_cpu() in this driver,
> >>> which suggests there already is special handling for big-endian systems,
> >>> however, it is big-endian systems that have the problem.
> >>>
> >>> This, being the only functional difference between architectures
> >>> in the driver combined with the fact that the suggested fix
> >>> was to use the exact same endianness conversion for the values
> >>> brings up the possibility that it was not necessary to begin with,
> >>> as the same endianness conversion for two values expected to be the same
> >>> is expected to be equivalent to no conversion at all.
> >>>
> >>> After inspecting the u-boot environment of devices of both endianness
> >>> and trying to remove the existing endianness conversion,
> >>> the problem is resolved in an equivalent way as the other suggested fixes.
> >>>
> >>> Ultimately, it seems that u-boot is agnostic to endianness
> >>> at least for the purpose of environment variables.
> >>> In other words, u-boot reads and writes the stored crc32 value
> >>> with the same endianness that the crc32 value is calculated with
> >>> in whichever endianness a certain architecture runs on.
> >>>
> >>> Therefore, the u-boot-env driver does not need to convert endianness.
> >>> Remove the usage of endianness macros in the u-boot-env driver,
> >>> and change the type of local variables to maintain the same return type.
> >>>
> >>> If there is a special situation in the case of endianness,
> >>> it would be a corner case and should be handled by a unique "compatible".
> >>>
> >>> Even though it is not necessary to use endianness conversion macros here,
> >>> it may be useful to use them in the future for consistent error printing.
> >>>
> >>> Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
> >>
> >> Note, this is a 6.1 commit id, but:
> >>
> >>> Reported-by: INAGAKI Hiroshi <musashino.open@gmail.com>
> >>> Link: https://lore.kernel.org/all/20221011024928.1807-1-musashino.open@gmail.com
> >>> Cc: stable@vger.kernel.org # 6.12.x
> >>> Cc: stable@vger.kernel.org # 6.6.x: f4cf4e5: Revert "nvmem: add new config option"
> >>> Cc: stable@vger.kernel.org # 6.6.x: 7f38b70: of: device: Export of_device_make_bus_id()
> >>> Cc: stable@vger.kernel.org # 6.6.x: 4a1a402: nvmem: Move of_nvmem_layout_get_container() in another header
> >>> Cc: stable@vger.kernel.org # 6.6.x: fc29fd8: nvmem: core: Rework layouts to become regular devices
> >>> Cc: stable@vger.kernel.org # 6.6.x: 0331c61: nvmem: core: Expose cells through sysfs
> >>> Cc: stable@vger.kernel.org # 6.6.x: 401df0d: nvmem: layouts: refactor .add_cells() callback arguments
> >>> Cc: stable@vger.kernel.org # 6.6.x: 6d0ca4a: nvmem: layouts: store owner from modules with nvmem_layout_driver_register()
> >>> Cc: stable@vger.kernel.org # 6.6.x: 5f15811: nvmem: layouts: add U-Boot env layout
> >>> Cc: stable@vger.kernel.org # 6.6.x
> >>
> >> That's a load of (short) git ids for just 6.6.y?  What about 6.1.y?
> > 
> > And really, ALL of those commits are needed for this very tiny patch?
> May be not, AFAIU  Fixes: d5542923f200 ("nvmem: add driver handling
> U-Boot environment variables") should be enough.

Great, can you fix this up and resend?

thanks,

greg k-h

