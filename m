Return-Path: <stable+bounces-28292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5501487D96F
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 10:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10171F215FF
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8169D107A9;
	Sat, 16 Mar 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7kFF8po"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F911CAF
	for <stable@vger.kernel.org>; Sat, 16 Mar 2024 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580893; cv=none; b=ZCps/T/ySrz7AhcDrmZBI7NTPgXRaIWq5HWviwvxyopK/sTT6rzIQoSjO6ZlwExvSoHMWd2DiXRd/UNsU0835N+lT/Yd9o9ZU4nZ6IkGpQJiXuZ31ozs8qUIrxHkCczBjYztdeV7n5PmYfcDZjihwrVhFHTLvJ4Qx8bzds8SEOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580893; c=relaxed/simple;
	bh=sLTVRNOzwPMihHikmp56U0+IVf8o7om+cHLEk8iqVvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmWFeKT61WcH86coVjYXTuoJqeJUIXEkJj6HzOodd+IfiC1FsRV2ILHO8d6BnQ/1UhtgVNGBA3OPJ4A8UpfgD7u4Wy9zK2rs1zhr6D5Tr9rQLcJDwDBkuonW0kd1yFEKqMcwmWtKP8/QycEKBd3UWZ44kGafsTjUXU8cRDl1g+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7kFF8po; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7814CC433C7;
	Sat, 16 Mar 2024 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710580892;
	bh=sLTVRNOzwPMihHikmp56U0+IVf8o7om+cHLEk8iqVvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7kFF8poLFXjhk3dcsohnXh0WLCjWuj3zxlPIw52430AHZ1+3CgtQh0//5mE7rRtR
	 HezbYnUUJnorqlu7/eswqV7KT+qtsWEO6xj3AyRGIzBEThSB25FCJwEMHsyue+zhzt
	 N6pE4Rpx9vhE2eCpMH7mtCjdTt3lJ64IwDbuci6rXCaat6I2SaUuqR2/WbSnzlaiSa
	 iumHJzUuEa6Ern3yxaJmTY7F5SBtRdIafHkP4tmsU+AI1WdpRD2QvEs7VZVfU2qPOk
	 Dr6mY9bJZX8XdPl6tc8dUxQI7lr89APDyDc8GCCybrn5on7Ml9WUg/OZ6Wyuncd0wU
	 SMauOIwJIUglw==
Date: Sat, 16 Mar 2024 05:21:30 -0400
From: Sasha Levin <sashal@kernel.org>
To: Lin Gui =?utf-8?B?KOahguaelyk=?= <Lin.Gui@mediatek.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Yongdong Zhang =?utf-8?B?KOW8oOawuOS4nCk=?= <Yongdong.Zhang@mediatek.com>,
	Bo Ye =?utf-8?B?KOWPtuazoik=?= <Bo.Ye@mediatek.com>,
	Qilin Tan =?utf-8?B?KOiwrem6kum6nyk=?= <Qilin.Tan@mediatek.com>
Subject: Re: backport a patch for Linux kernel-5.10 and 6.6 stable tree
Message-ID: <ZfVkmm5-Ja8ub-i8@sashalap>
References: <PSAPR03MB5653FFA63E972A80A6A2F4AF952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>

On Sat, Mar 16, 2024 at 08:16:30AM +0000, Lin Gui (桂林) wrote:
>Hi reviewers,
>
>I suggest to backport a commit to Linux kernel-5.10 and 6.6 stable tree.
>
>　　https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/core/mmc.c?h=v6.8&id=e4df56ad0bf3506c5189abb9be83f3bea05a4c4f

Why? What bug does this fix?

-- 
Thanks,
Sasha

