Return-Path: <stable+bounces-163591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16042B0C5A8
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAE13BF47C
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0202C2D9ED6;
	Mon, 21 Jul 2025 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fVs+uRwE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5A72D948B;
	Mon, 21 Jul 2025 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106267; cv=none; b=jCa6L+nZ9OFrlnGcFuU8JI++7JJxZmIRHMkSjf0rOoyaqQvvjUgeyW9PEHZLtj8+8CHkD7f/PjM4Hdxi9xZ8LSnyTnMoA/6B/B8ddUdbx14iMhI1SA8RZuBg1131fgFwpO9FXfbp2hrBZ6kRxoyzvRMMDaCSCe+xFlwpYGvF7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106267; c=relaxed/simple;
	bh=eiGB8w5AFCDLk22fqBiodKgxR3eZnsrhzTPgGdHxaLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG3ytyp36wggFgtpXU3v/1UBCYW6e9wnGBt/6VHf7odiMjIX6cg/gXBEhcmo1lxNzEo/yxE2VNsNg05puBtIquPcB88Hf1R7nasoX5+zZmA5nIaevWvGDP/ZCSMI8CVhaxCkRG04alNi5YjTeAAobWYc/2Q1OdXWHnzsQ8/8iCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fVs+uRwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1ED8C4CEED;
	Mon, 21 Jul 2025 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753106267;
	bh=eiGB8w5AFCDLk22fqBiodKgxR3eZnsrhzTPgGdHxaLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVs+uRwEG85nQaTWnPvvtQwr0f6nDwIy5DdSQTb1L/KqSprBUnMxD/+pv1uQyxJBS
	 r4TmUFRnTIO7iDGmUeNNOIVuAv4AFaXTDmO3c94qqEO0JOLI9zVl3YOwoX8vu3uN33
	 NrDjenCC8msYKDA+a0hN2XunZbbLCCKtgPIrMCgk=
Date: Mon, 21 Jul 2025 15:57:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Pratt <mcpratt@pm.me>
Cc: srini@kernel.org, linux-kernel@vger.kernel.org,
	INAGAKI Hiroshi <musashino.open@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvmem: layouts: u-boot-env: remove crc32 endianness
 conversion
Message-ID: <2025072109-ebony-squash-47a4@gregkh>
References: <20250712181729.6495-1-srini@kernel.org>
 <20250712181729.6495-2-srini@kernel.org>
 <2025071308-upfront-romp-fa1e@gregkh>
 <2025071313-zippy-boneless-da1c@gregkh>
 <6yT3MnzOOpHoCZDnlUg_fYGtTfoS8K5xz_WdIf0FH25ftxw1xyu-4OsYUWq5bS4gNQUI78Bde_lNW_fzyfBinGh0Y94Ts62LdORyj7R93yE=@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6yT3MnzOOpHoCZDnlUg_fYGtTfoS8K5xz_WdIf0FH25ftxw1xyu-4OsYUWq5bS4gNQUI78Bde_lNW_fzyfBinGh0Y94Ts62LdORyj7R93yE=@pm.me>

On Wed, Jul 16, 2025 at 09:24:10PM +0000, Michael Pratt wrote:
> Hi Greg and Srinivas,
> 
> Sorry for the delayed response.
> 
> On Sunday, July 13th, 2025 at 11:42, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > 
> > 
> > On Sun, Jul 13, 2025 at 05:41:45PM +0200, Greg KH wrote:
> > 
> > > On Sat, Jul 12, 2025 at 07:17:26PM +0100, srini@kernel.org wrote:
> > > 
> > > > From: "Michael C. Pratt" mcpratt@pm.me
> > > > 
> > > > On 11 Oct 2022, it was reported that the crc32 verification
> > > > of the u-boot environment failed only on big-endian systems
> > > > for the u-boot-env nvmem layout driver with the following error.
> > > > 
> > > > Invalid calculated CRC32: 0x88cd6f09 (expected: 0x096fcd88)
> > > > 
> > > > This problem has been present since the driver was introduced,
> > > > and before it was made into a layout driver.
> > > > 
> > > > The suggested fix at the time was to use further endianness
> > > > conversion macros in order to have both the stored and calculated
> > > > crc32 values to compare always represented in the system's endianness.
> > > > This was not accepted due to sparse warnings
> > > > and some disagreement on how to handle the situation.
> > > > Later on in a newer revision of the patch, it was proposed to use
> > > > cpu_to_le32() for both values to compare instead of le32_to_cpu()
> > > > and store the values as __le32 type to remove compilation errors.
> > > > 
> > > > The necessity of this is based on the assumption that the use of crc32()
> > > > requires endianness conversion because the algorithm uses little-endian,
> > > > however, this does not prove to be the case and the issue is unrelated.
> > > > 
> > > > Upon inspecting the current kernel code,
> > > > there already is an existing use of le32_to_cpu() in this driver,
> > > > which suggests there already is special handling for big-endian systems,
> > > > however, it is big-endian systems that have the problem.
> > > > 
> > > > This, being the only functional difference between architectures
> > > > in the driver combined with the fact that the suggested fix
> > > > was to use the exact same endianness conversion for the values
> > > > brings up the possibility that it was not necessary to begin with,
> > > > as the same endianness conversion for two values expected to be the same
> > > > is expected to be equivalent to no conversion at all.
> > > > 
> > > > After inspecting the u-boot environment of devices of both endianness
> > > > and trying to remove the existing endianness conversion,
> > > > the problem is resolved in an equivalent way as the other suggested fixes.
> > > > 
> > > > Ultimately, it seems that u-boot is agnostic to endianness
> > > > at least for the purpose of environment variables.
> > > > In other words, u-boot reads and writes the stored crc32 value
> > > > with the same endianness that the crc32 value is calculated with
> > > > in whichever endianness a certain architecture runs on.
> > > > 
> > > > Therefore, the u-boot-env driver does not need to convert endianness.
> > > > Remove the usage of endianness macros in the u-boot-env driver,
> > > > and change the type of local variables to maintain the same return type.
> > > > 
> > > > If there is a special situation in the case of endianness,
> > > > it would be a corner case and should be handled by a unique "compatible".
> > > > 
> > > > Even though it is not necessary to use endianness conversion macros here,
> > > > it may be useful to use them in the future for consistent error printing.
> > > > 
> > > > Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
> > > 
> > > Note, this is a 6.1 commit id, but:
> > > 
> > > > Reported-by: INAGAKI Hiroshi musashino.open@gmail.com
> > > > Link: https://lore.kernel.org/all/20221011024928.1807-1-musashino.open@gmail.com
> > > > Cc: stable@vger.kernel.org # 6.12.x
> > > > Cc: stable@vger.kernel.org # 6.6.x: f4cf4e5: Revert "nvmem: add new config option"
> > > > Cc: stable@vger.kernel.org # 6.6.x: 7f38b70: of: device: Export of_device_make_bus_id()
> > > > Cc: stable@vger.kernel.org # 6.6.x: 4a1a402: nvmem: Move of_nvmem_layout_get_container() in another header
> > > > Cc: stable@vger.kernel.org # 6.6.x: fc29fd8: nvmem: core: Rework layouts to become regular devices
> > > > Cc: stable@vger.kernel.org # 6.6.x: 0331c61: nvmem: core: Expose cells through sysfs
> > > > Cc: stable@vger.kernel.org # 6.6.x: 401df0d: nvmem: layouts: refactor .add_cells() callback arguments
> > > > Cc: stable@vger.kernel.org # 6.6.x: 6d0ca4a: nvmem: layouts: store owner from modules with nvmem_layout_driver_register()
> > > > Cc: stable@vger.kernel.org # 6.6.x: 5f15811: nvmem: layouts: add U-Boot env layout
> > > > Cc: stable@vger.kernel.org # 6.6.x
> > > 
> > > That's a load of (short) git ids for just 6.6.y? What about 6.1.y?
> > 
> 
> Sorry for the short tags, I wrongly assumed that what Github provides
> would not clobber with other commits.
> 
> > 
> > And really, ALL of those commits are needed for this very tiny patch?
> 
> Yes... if we would like to backport to 6.6, (almost) all of them are necessary.
> There was a lot of development between 6.6 and 6.12 in this area...
> 
> This is a long-standing problem since 6.1, but the code is now
> completely rewritten into a different file, as a "layout driver"
> instead of a "cell module" if that makes sense...
> 
> In order to backport to 6.6, we would have to backport
> the rewriting of the code to the new layout driver form,
> which is commit 5f1581128 ("nvmem: layouts: add U-Boot env layout").
> 
> Commit 5f1581128 depends on commit 401df0d4f, which strictly depends on
> commit fc29fd821, and lightly depends (merge conflict) on commit 0331c6119.
> 
> Commit fc29fd821 strictly depends on both commit 4a1a40233 and 7f38b7004 for functionality.
> 
> I additionally included commit 6d0ca4a2a as it seems to improve function for all layout drivers,
> and I additionally included commit f4cf4e5db simply because we also backport it,
> not thinking that an extra one would be a problem.
> 
> In summary, the exact set of commits I presented for backporting is well tested,
> but one or two are indeed not strictly necessary as you pointed out.
> 
> > Reverting a config option? sysfs apis being added? Huh?
> 
> If you prefer, you can skip backporting commits f4cf4e5db and 0331c6119,
> although, skipping the latter would make you have to resolve the merge conflict.
> 
> If backporting to 6.6 is no longer appropriate in your opinion,
> please at least backport to 6.12 which is very easy.

I think that's already done, right?

If not, I'm still confused, can you send patch series for the different
stable branches showing what you want applied where?

thanks,

greg k-h

