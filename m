Return-Path: <stable+bounces-61976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F893E032
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 18:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D946A2817F9
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E9118309B;
	Sat, 27 Jul 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=holm.dev header.i=@holm.dev header.b="qY10z66g"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC23812C46D
	for <stable@vger.kernel.org>; Sat, 27 Jul 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722098561; cv=none; b=OiVwgmVWWLY7I9sVeviSW/ZWFJr0k/BIkYdDXxpJqmVw0b+sPtnIMljESOBGHX30Kn2oQYYVB4w5MRAvlIemtKBVaoexhTEzQ+C8XTKJrD+DpFT/9CVepgLV+0patZ+2MzolmNwruSAxc7yl8GPAgIx3vQWQC1oeOk+TWlhY0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722098561; c=relaxed/simple;
	bh=rZYvDXk7Mm64t9NhlVIG66M2m/w1zbtHk8ruGARrrb0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=LjBM7hJQ5DBY8hZjS5ghQTy6WvHEzaYc8eSowfXcO2VKOAAB34EGQbAHnC2NNOx/dK0Jk803ot2SErXN/Cjx8Q8Xp8Bt0f68diVDxALXy1nLwtKuZcc34AFgT73v7+qZTYeH5UGKjViU8edidtFnqy67Uz+auEPmXbymG8hwe9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=holm.dev; spf=pass smtp.mailfrom=holm.dev; dkim=pass (2048-bit key) header.d=holm.dev header.i=@holm.dev header.b=qY10z66g; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=holm.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holm.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=holm.dev; s=key1;
	t=1722098556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ERo+ib5C51vd13NN4Kn+nQkU46nWU6y2/Q5sxE9C/Ws=;
	b=qY10z66gq/3dSwdZt9l4xmww+1PwPOzH4IOi8VoQJ9EHYpBSKjBQi7lM352BYvxQZYwqUD
	c+lmiwPzfYgLxxpE/e1pE/6bIeEOroKtj4jTURgPYmXlDHoHf/XNQ0A9fmPqzRBwOWSuLl
	2ykKNfRNw8cgFdW6qFRGmRXEAhIZNv1cp6xwS59umkgcjA1kkaoMogTeBURieqZpOQuo1J
	91nSYNIXPJkt1X5ZTZgo0vsJrotVbN1woO5UEhAyRFep7e5jaq6sYvt1dEctvgCrxILFIW
	sjc6Zb1P5yiH+B1TSCg7iv+eXSBAnH72caMrTU4xMOw3ff8Q/aSpksKmEqVnpw==
Date: Sat, 27 Jul 2024 16:42:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: kevin@holm.dev
Message-ID: <fd8ece71459cd79f669efcfd25e4ce38b80d4164@holm.dev>
TLS-Required: No
Subject: Re: [REGRESSION] No image on 4k display port displays connected
 through usb-c dock in kernel 6.10
To: "Linux regressions mailing list" <regressions@lists.linux.dev>, "Alex
 Deucher" <alexander.deucher@amd.com>, "Hersen Wu" <hersenxs.wu@amd.com>,
 "Wayne Lin" <wayne.lin@amd.com>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org, "LKML"
 <linux-kernel@vger.kernel.org>, "ML dri-devel"
 <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org
In-Reply-To: <9ca719e4-2790-4804-b2cb-4812899adfe8@leemhuis.info>
References: <d74a7768e957e6ce88c27a5bece0c64dff132e24@holm.dev>
 <9ca719e4-2790-4804-b2cb-4812899adfe8@leemhuis.info>
X-Migadu-Flow: FLOW_OUT

> [adding a few people and lists to the recipients]
>=20
>=20Hi! Thx for your rpeort.
>=20
>=20On 27.07.24 18:07, kevin@holm.dev wrote:
>=20
>=20>=20
>=20> Connecting two 4k displays with display port through a lenovo usb-c
> >=20
>=20>  dock (type 40AS) to a Lenovo P14s Gen 2 (type 21A0) results in no
> >=20
>=20>  image on the connected displays.
> >=20
>=20>=20=20
>=20>=20
>=20>  The CPU in the Lenovo P14s is a 'AMD Ryzen 7 PRO 5850U with Radeon
> >=20
>=20>  Graphics' and it has no discrete GPU.
> >=20
>=20>=20=20
>=20>=20
>=20>  I first noticed the issue with kernel version '6.10.0-arch1-2'
> >=20
>=20>  provided by arch linux. With the previous kernel version
> >=20
>=20>  '6.9.10.arch1-1' both connected displays worked normally. I report=
ed
> >=20
>=20>  the issue in the arch forums at
> >=20
>=20>  https://bbs.archlinux.org/viewtopic.php?id=3D297999 and was guided=
 to
> >=20
>=20>  do a bisection to find the commit that caused the problem. Through
> >=20
>=20>  testing I identified that the issue is not present in the latest
> >=20
>=20>  kernel directly compiled from the trovalds/linux git repository.
> >=20
>=20>=20=20
>=20>=20
>=20>  With git bisect I identified 4df96ba66760345471a85ef7bb29e1cd4e956=
057
> >=20
>=20
> That's 4df96ba6676034 ("drm/amd/display: Add timing pixel encoding for
>=20
>=20mst mode validation") [v6.10-rc1] from Hersen Wu.
>=20
>=20Did you try if reverting that commit is possible and might fix the pr=
oblem?

Reverting is not easily possible:

$ git checkout v6.10
[...]
HEAD is now at 0c3836482481 Linux 6.10

$ git revert 4df96ba66760345471a85ef7bb29e1cd4e956057
Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_=
dm/amdgpu_dm_mst_types.c
error: could not revert 4df96ba66760... drm/amd/display: Add timing pixel=
 encoding for mst mode validation

I do not know enough to try and solve the conflict myself without breakin=
g more things.

>=20
>=20>=20
>=20> as the first bad commit and fa57924c76d995e87ca3533ec60d1d5e55769a2=
7
> >=20
>=20
> That's fa57924c76d995 ("drm/amd/display: Refactor function
>=20
>=20dm_dp_mst_is_port_support_mode()") [v6.10-post] from Wayne Lin.
>=20
>=20>=20
>=20> as the first commit that fixed the problem again.
> >=20
>=20
> Hmm, the latter commit does not have a fixes tag and might or might not
>=20
>=20be to invasive to backport to 6.10. Let's see what the AMD developers=
 say.
>=20
>=20>=20
>=20> The initial commit only still shows an image on one of the connecte=
d
> >=20
>=20>  4k screens. I have not investigated further to find out at what po=
int
> >=20
>=20>  both displays stopped showing an image.
> >=20
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat=
)
>=20
>=20--
>=20
> Everything you wanna know about Linux kernel regression tracking:
>=20
>=20https://linux-regtracking.leemhuis.info/about/#tldr
>=20
>=20If I did something stupid, please tell me, as explained on that page.
>

