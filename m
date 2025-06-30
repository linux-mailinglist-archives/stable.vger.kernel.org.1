Return-Path: <stable+bounces-158930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C0EAEDB14
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 13:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6855817893A
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7654423E354;
	Mon, 30 Jun 2025 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="csu2QSGk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YiJ2a1fg"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304425DD0C;
	Mon, 30 Jun 2025 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283159; cv=none; b=UDhtPNqiykNuy/8j77eaWDcod+u49isRBxvXuhrkNoywMDABt+NIBURiQtWcdxWR9CKA5mmPEd2OswFqh8oq2d7/+SUWCL2cIgNRy0sNrywhC4NkDEjTWVod+noWmvLNVGe4AD7KpDxajhbJ1NBw9uKR5N/0qrNWbxkIdrl2VUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283159; c=relaxed/simple;
	bh=JrmlR7cLmGq/tenetqwJwHO2uvIPQlOMEhSGW/+rgAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NuvwgyyidI9dyLCiuIUXfSvOSisSglIk/BLf/ELn4XsNkx2W5/3BFXD3TH27crBLIldzWZiUJ63zCTLimeXPsxJTGnla76kpw55EI9fMD33GXKoNgupMA7DojoCQPuogKTFBI1S0jSIh4hCQP//wBGcP0Ba1KvNSmyd6jN8Mhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=csu2QSGk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YiJ2a1fg; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C28B7A019A;
	Mon, 30 Jun 2025 07:32:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 30 Jun 2025 07:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751283154; x=1751369554; bh=oxMmJEyGhz
	TthN/fcdYjXuV9Dle9faFe4SUXcAQ8dVk=; b=csu2QSGkClyMxmuRwIW0PwP+li
	5gV1wqPMHqr/vTZyhDfR3pyk+JF0NtddP9i3ulCfqcC3h+XJxUzblBDK0ky3BuJU
	67aE63jbUhZCV3NFu6+Wu2kXiMkMJCLFxgepLyuMIFINbH/ZU6FMLEhLqsOuQClJ
	7rovYPb7fVJLrOQHnZTPjE0DGxqNY8yqqushnV+W9vfVpissJxLeTD2j6u4WuCzR
	pPQeTWjbDMjBPdm7mLkUmbpVbbJpQPqyTh4Tbl4PPdpVerHV2xuKZVsqFGSZgWwQ
	VujgOVsF2eW0wOCHEJBZAsvNuUmiELQINx1ORRyY+waHC+whPL7/hqk7xdKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751283154; x=1751369554; bh=oxMmJEyGhzTthN/fcdYjXuV9Dle9faFe4SU
	XcAQ8dVk=; b=YiJ2a1fg8eGUzNMgDfTwhXdw4q527o3pahzWBnnnHJsMBWBsltg
	nsvZ2XD76Z0XH3ezMJBg9ZjVZWSJwKmjPPKs9nu9w1Yf/JkXsd2ddLLTE2gpYHw3
	paa00xKoJBGEgFAazZXWLBCJJxtGeE+Jxxao15o7jJNYcLWrdKgVD1qYykAtGzxZ
	SNtVxThtzBqAP/nEyNnzwvrfbMu2TvZ/5f6jAmqGOO0h2btXNE+XbBNIS7YSIZzP
	XXrVQDeE2dcuQyzl25TwgepNF3rdcAs6iIWFDaJibvIoRMxSjZzX8g4Spdxg0cQz
	psoEBlSr4OT5xRuDiKVPvzMFn6Ydh+ixOpA==
X-ME-Sender: <xms:0XViaMPHzfnTDOUAxmeSp_X8Lg2AIpMsDqNr5v8ED07hdDo5FIp0GQ>
    <xme:0XViaC9c0ceDFpCq8eUOW_ZXwWdHrBryRO_FP-4Pnpu6usya189j81lWRbzdRuVvD
    cHD68s-vPqzZpo2hQ>
X-ME-Received: <xmr:0XViaDTSquGai8Nx7b9NNP8SwyqlVSdkD_vpYj2GVUehx16ylo8TmLjkIDBzhjsQ0SqSuHv-DBE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfggtgesghdtreertddtjeenucfhrhhomheptehlhihsshgrucft
    ohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepgfehhffgke
    ekleejveeftdegtdetieduieeifedvheehleetgeekvefgudehuedvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhspdhnsggp
    rhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhioh
    drlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopeihvghhvgiikhgv
    lhhshhgssehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvggrshdrnhhovghvvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhimhdrlhhinhgusggvrhhgvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepmhhitghhrggvlhdrjhgrmhgvthesihhnthgvlh
    drtghomhdprhgtphhtthhopehrrghjrghtrdhkhhgrnhguvghlfigrlhesihhnthgvlhdr
    tghomhdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhuphgvrhhmudeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfigvshhtvghrihes
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0XViaEukabNgbE45KuY_Dw6mme3I0NhnKdROnZ2GQODuRKSiqcCHJw>
    <xmx:0XViaEca_gh47sr9P5vqa3swavqttcmg-GR1jbuSe5raivaazb8sUQ>
    <xmx:0XViaI2WJ2xFaT8AgCu0SxP3dJkVO-4cSDjCL8PSu8uBqCHPSOoSIw>
    <xmx:0XViaI9ZtyAvIHts0MssvTOkAxEwbOxGDdxSl2s_OPuBsfA0m0oldw>
    <xmx:0nViaBDb-wnrmph_UwUpRwy-__9ybQWQoEd9542yttoAigqp-H9f2-90>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 07:32:33 -0400 (EDT)
Received: by sf.qyliss.net (Postfix, from userid 1000)
	id D269C26678DCF; Mon, 30 Jun 2025 13:32:31 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: regressions@lists.linux.dev
Cc: mario.limonciello@amd.com, andreas.noever@gmail.com,
 michael.jamet@intel.com, westeri@kernel.org, YehezkelShB@gmail.com,
 rajat.khandelwal@intel.com, mika.westerberg@linux.intel.com,
 linux-usb@vger.kernel.org, kim.lindberger@gmail.com, linux@lunaa.ch, Sasha
 Levin <sashal@kernel.org>, stable@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Mario Limonciello <superm1@kernel.org>
Subject: Re: [REGRESSION] thunderbolt: Fix a logic error in wake on connect
In-Reply-To: <cavyeum32dd7kxj65argtem6xh2575oq3gcv3svd3ubnvdc6cr@6nv7ieimfc5e>
References: <20250411151446.4121877-1-superm1@kernel.org>
 <cavyeum32dd7kxj65argtem6xh2575oq3gcv3svd3ubnvdc6cr@6nv7ieimfc5e>
Date: Mon, 30 Jun 2025 13:32:27 +0200
Message-ID: <87v7odo46s.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alyssa Ross <hi@alyssa.is> writes:

> On Fri, Apr 11, 2025 at 10:14:44AM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> commit a5cfc9d65879c ("thunderbolt: Add wake on connect/disconnect
>> on USB4 ports") introduced a sysfs file to control wake up policy
>> for a given USB4 port that defaulted to disabled.
>>
>> However when testing commit 4bfeea6ec1c02 ("thunderbolt: Use wake
>> on connect and disconnect over suspend") I found that it was working
>> even without making changes to the power/wakeup file (which defaults
>> to disabled). This is because of a logic error doing a bitwise or
>> of the wake-on-connect flag with device_may_wakeup() which should
>> have been a logical AND.
>>
>> Adjust the logic so that policy is only applied when wakeup is
>> actually enabled.
>>
>> Fixes: a5cfc9d65879c ("thunderbolt: Add wake on connect/disconnect on US=
B4 ports")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Hi! There have been a couple of reports of a Thunderbolt regression in
> recent stable kernels, and one reporter has now bisected it to this
> change:
>
>  =E2=80=A2 https://bugzilla.kernel.org/show_bug.cgi?id=3D220284
>  =E2=80=A2 https://github.com/NixOS/nixpkgs/issues/420730
>
> Both reporters are CCed, and say it starts working after the module is
> reloaded.
>
> Link: https://lore.kernel.org/r/bug-220284-208809@https.bugzilla.kernel.o=
rg%2F/
> (for regzbot)

Apparently[1] fixed by the first linked patch below, which is currently in
the Thunderbolt tree waiting to be pulled into the USB tree.

#regzbot monitor: https://lore.kernel.org/linux-usb/20250619213840.2388646-=
1-superm1@kernel.org/
#regzbot monitor: https://lore.kernel.org/linux-usb/20250626154009.GK282438=
0@black.fi.intel.com/

[1]: https://github.com/NixOS/nixpkgs/issues/420730#issuecomment-3018563631

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaGJ1ywAKCRBbRZGEIw/w
oiguAQCD0+DyZKWZ/DT6JDF6WXi8cVaX1sacdj2IQCj2Zfxu/wEAi2OPNEpEvxZx
tgHo3hWI+2KnGFcpNcksmna1mhv82wE=
=cA20
-----END PGP SIGNATURE-----
--=-=-=--

