Return-Path: <stable+bounces-163201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164C7B07F84
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 23:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD9EA478BF
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 21:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D1228B3E2;
	Wed, 16 Jul 2025 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="LhzylmnZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E12B2877CB
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701066; cv=none; b=QZGMVa6gQRHH+T7fQs6BCOFbVhrOKXxOsE+Wbr0GB6jZWZXoltPBYoZJxpMVMoyhLuvh1ur72gIsKB/kteS18c8TR9epoQGAOwj/lUQjEnFAaQeWnUcvaCorfVMM5IEkn10P2QICgL8fo9Dizvqw8wgTgv/CY7pCWpzDw5v8qZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701066; c=relaxed/simple;
	bh=V+iLwfX00J966HttAsqtKkZ6U4Yq0rm9/6bnC1j41F0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxbeM8ec0oe36ggKRkIxSmWNjTq5uAoP8msgz+Fv+F0q7xMacoZO8y+J2coNK88+RLlgBDecFFIbRyOZvnjpKHEnraFT4FaEE3NuKvCd/60uKIoxeEGK8WlOB3XbVbd59XLPqcI+N3g457VtIe9hjNvqgURvneUcqYMSz4obeHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=LhzylmnZ; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1752701056; x=1752960256;
	bh=V+iLwfX00J966HttAsqtKkZ6U4Yq0rm9/6bnC1j41F0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LhzylmnZq7h65AHkTihn7P3DDMHz2KrQ9FsejMaf/C53AD8wNO3+HW+j/+7BpN7Wp
	 XH9vT31UqQmqr9IRU8RXsA72MR4FlK9Yvjo6TOI4tIl4h13PYcaKLw35w4Z9dKTt2f
	 oGEuA8UIRTgRjuis25p1tZmSD1m3QLlYXqgtmqjxEygJ9tpuIdXJ/YMSmR7lfqlDds
	 7GkFEpSVgeoetAgcKUJarmoBnYNWos6/k2KK0J7VWwQ0GGdMLJ65B7PwZKMwY8lrrJ
	 mVa8BOAUfX5f1gTxjUiRl5WMivN1Q7z0N5/RjKYWuVWyasL/x6JAOKz3cp9VUzkrxU
	 IY+FQBx2Te2yg==
Date: Wed, 16 Jul 2025 21:24:10 +0000
To: Greg KH <gregkh@linuxfoundation.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: srini@kernel.org, linux-kernel@vger.kernel.org, INAGAKI Hiroshi <musashino.open@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvmem: layouts: u-boot-env: remove crc32 endianness conversion
Message-ID: <6yT3MnzOOpHoCZDnlUg_fYGtTfoS8K5xz_WdIf0FH25ftxw1xyu-4OsYUWq5bS4gNQUI78Bde_lNW_fzyfBinGh0Y94Ts62LdORyj7R93yE=@pm.me>
In-Reply-To: <2025071313-zippy-boneless-da1c@gregkh>
References: <20250712181729.6495-1-srini@kernel.org> <20250712181729.6495-2-srini@kernel.org> <2025071308-upfront-romp-fa1e@gregkh> <2025071313-zippy-boneless-da1c@gregkh>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: 0344252f937c5ec51f8a0d07f64ee2fc5599ce56
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg and Srinivas,

Sorry for the delayed response.

On Sunday, July 13th, 2025 at 11:42, Greg KH <gregkh@linuxfoundation.org> w=
rote:

>=20
>=20
> On Sun, Jul 13, 2025 at 05:41:45PM +0200, Greg KH wrote:
>=20
> > On Sat, Jul 12, 2025 at 07:17:26PM +0100, srini@kernel.org wrote:
> >=20
> > > From: "Michael C. Pratt" mcpratt@pm.me
> > >=20
> > > On 11 Oct 2022, it was reported that the crc32 verification
> > > of the u-boot environment failed only on big-endian systems
> > > for the u-boot-env nvmem layout driver with the following error.
> > >=20
> > > Invalid calculated CRC32: 0x88cd6f09 (expected: 0x096fcd88)
> > >=20
> > > This problem has been present since the driver was introduced,
> > > and before it was made into a layout driver.
> > >=20
> > > The suggested fix at the time was to use further endianness
> > > conversion macros in order to have both the stored and calculated
> > > crc32 values to compare always represented in the system's endianness=
.
> > > This was not accepted due to sparse warnings
> > > and some disagreement on how to handle the situation.
> > > Later on in a newer revision of the patch, it was proposed to use
> > > cpu_to_le32() for both values to compare instead of le32_to_cpu()
> > > and store the values as __le32 type to remove compilation errors.
> > >=20
> > > The necessity of this is based on the assumption that the use of crc3=
2()
> > > requires endianness conversion because the algorithm uses little-endi=
an,
> > > however, this does not prove to be the case and the issue is unrelate=
d.
> > >=20
> > > Upon inspecting the current kernel code,
> > > there already is an existing use of le32_to_cpu() in this driver,
> > > which suggests there already is special handling for big-endian syste=
ms,
> > > however, it is big-endian systems that have the problem.
> > >=20
> > > This, being the only functional difference between architectures
> > > in the driver combined with the fact that the suggested fix
> > > was to use the exact same endianness conversion for the values
> > > brings up the possibility that it was not necessary to begin with,
> > > as the same endianness conversion for two values expected to be the s=
ame
> > > is expected to be equivalent to no conversion at all.
> > >=20
> > > After inspecting the u-boot environment of devices of both endianness
> > > and trying to remove the existing endianness conversion,
> > > the problem is resolved in an equivalent way as the other suggested f=
ixes.
> > >=20
> > > Ultimately, it seems that u-boot is agnostic to endianness
> > > at least for the purpose of environment variables.
> > > In other words, u-boot reads and writes the stored crc32 value
> > > with the same endianness that the crc32 value is calculated with
> > > in whichever endianness a certain architecture runs on.
> > >=20
> > > Therefore, the u-boot-env driver does not need to convert endianness.
> > > Remove the usage of endianness macros in the u-boot-env driver,
> > > and change the type of local variables to maintain the same return ty=
pe.
> > >=20
> > > If there is a special situation in the case of endianness,
> > > it would be a corner case and should be handled by a unique "compatib=
le".
> > >=20
> > > Even though it is not necessary to use endianness conversion macros h=
ere,
> > > it may be useful to use them in the future for consistent error print=
ing.
> > >=20
> > > Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment v=
ariables")
> >=20
> > Note, this is a 6.1 commit id, but:
> >=20
> > > Reported-by: INAGAKI Hiroshi musashino.open@gmail.com
> > > Link: https://lore.kernel.org/all/20221011024928.1807-1-musashino.ope=
n@gmail.com
> > > Cc: stable@vger.kernel.org # 6.12.x
> > > Cc: stable@vger.kernel.org # 6.6.x: f4cf4e5: Revert "nvmem: add new c=
onfig option"
> > > Cc: stable@vger.kernel.org # 6.6.x: 7f38b70: of: device: Export of_de=
vice_make_bus_id()
> > > Cc: stable@vger.kernel.org # 6.6.x: 4a1a402: nvmem: Move of_nvmem_lay=
out_get_container() in another header
> > > Cc: stable@vger.kernel.org # 6.6.x: fc29fd8: nvmem: core: Rework layo=
uts to become regular devices
> > > Cc: stable@vger.kernel.org # 6.6.x: 0331c61: nvmem: core: Expose cell=
s through sysfs
> > > Cc: stable@vger.kernel.org # 6.6.x: 401df0d: nvmem: layouts: refactor=
 .add_cells() callback arguments
> > > Cc: stable@vger.kernel.org # 6.6.x: 6d0ca4a: nvmem: layouts: store ow=
ner from modules with nvmem_layout_driver_register()
> > > Cc: stable@vger.kernel.org # 6.6.x: 5f15811: nvmem: layouts: add U-Bo=
ot env layout
> > > Cc: stable@vger.kernel.org # 6.6.x
> >=20
> > That's a load of (short) git ids for just 6.6.y? What about 6.1.y?
>=20

Sorry for the short tags, I wrongly assumed that what Github provides
would not clobber with other commits.

>=20
> And really, ALL of those commits are needed for this very tiny patch?

Yes... if we would like to backport to 6.6, (almost) all of them are necess=
ary.
There was a lot of development between 6.6 and 6.12 in this area...

This is a long-standing problem since 6.1, but the code is now
completely rewritten into a different file, as a "layout driver"
instead of a "cell module" if that makes sense...

In order to backport to 6.6, we would have to backport
the rewriting of the code to the new layout driver form,
which is commit 5f1581128 ("nvmem: layouts: add U-Boot env layout").

Commit 5f1581128 depends on commit 401df0d4f, which strictly depends on
commit fc29fd821, and lightly depends (merge conflict) on commit 0331c6119.

Commit fc29fd821 strictly depends on both commit 4a1a40233 and 7f38b7004 fo=
r functionality.

I additionally included commit 6d0ca4a2a as it seems to improve function fo=
r all layout drivers,
and I additionally included commit f4cf4e5db simply because we also backpor=
t it,
not thinking that an extra one would be a problem.

In summary, the exact set of commits I presented for backporting is well te=
sted,
but one or two are indeed not strictly necessary as you pointed out.

> Reverting a config option? sysfs apis being added? Huh?

If you prefer, you can skip backporting commits f4cf4e5db and 0331c6119,
although, skipping the latter would make you have to resolve the merge conf=
lict.

If backporting to 6.6 is no longer appropriate in your opinion,
please at least backport to 6.12 which is very easy.

Perhaps this would be a better set of tags for example:

# 6.12.x
# 6.6.x: 7f38b7004: of: device: Export of_device_make_bus_id()
# 6.6.x: 4a1a40233: nvmem: Move of_nvmem_layout_get_container() in another =
header
# 6.6.x: fc29fd821: nvmem: core: Rework layouts to become regular devices
# 6.6.x: 401df0d4f: nvmem: layouts: refactor .add_cells() callback argument=
s
# 6.6.x: 6d0ca4a2a: nvmem: layouts: store owner from modules with nvmem_lay=
out_driver_register()
# 6.6.x: 5f1581128: nvmem: layouts: add U-Boot env layout
# 6.6.x


>=20
> confused,

Sorry for the confusion, thanks.

--
MCP

