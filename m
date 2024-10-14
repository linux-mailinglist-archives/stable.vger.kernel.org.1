Return-Path: <stable+bounces-83734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0B899C037
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 08:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC21B2318A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8213C670;
	Mon, 14 Oct 2024 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="z51YFBRP"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8536B;
	Mon, 14 Oct 2024 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888345; cv=none; b=duNsipHlHlK7uGusfETpU+i6BfLL8vIAW1JIx+OkM9tB/OSDnOm9Zx7p3jD8+Szob7BUpxNQXfQdI8njwPyyTqaJYd3p+e5sdX4r6L6Z+g8GEfrh38hhghfWiiHiGbCRqECEaDuDtCT7e37gygpn7/LmsUoOJ2rFytVcCSa5MK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888345; c=relaxed/simple;
	bh=5+7U5NsPCJJ1SeC7sthTmtpMjLOa80ghowv7qWW2nio=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=A/ZIxf8snGIdlT/bMVHXHhaXxMK95Hsls5nfeFC22NBEfnjVJ+NblYoakPDmg+ZYeA+gLfg7Y1IcotcA8RDAc5344mZih0oZgVM4TG8aWuAfL//1jC5BpeL3ZnScnJVIJvX6BB+eEz2EkKOEdm1ul1WXYXr4exGrLDaeTcU+KzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=z51YFBRP; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=zfAhj9c9aib/1i6GUjRiuU0PI8OaiFSyn9NGekauN9U=; t=1728888344;
	x=1729320344; b=z51YFBRPPSV94xmfSo3YYSTUZXPMBj7XiTLKwkuRv3VTRWqmBxL+FkPlnpPU1
	CTonKWpOAoamBjrOWNDM8JSF6uwqJCzQNpKfagb1dSoRMgsqjkafKPaHPcFm8L4QTRBgoSmUf3Amt
	juoBmTKV4Z7Mg8IQWUmbEqqYvs/JNPEZ3YI99UW5b/f3DqNX9zV+DMO+yMjwnmEi+fEXYJOOVRN3v
	JAC80aXMBTheZQved93S1CLKvwKfEck3k+MpHrpJU8X1A4AVa5Avb5WkxDMncwz4Xxp64Y0C2hryy
	hHILJ7jWS3rRqbXTrDYtu9FhQdSqXCw2AI8x2Zqdt/lKyyWOWA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t0Epj-0000HP-9Q; Mon, 14 Oct 2024 08:45:35 +0200
Message-ID: <06bab5c5-e9fd-4741-bab7-6b199cfac18a@leemhuis.info>
Date: Mon, 14 Oct 2024 08:45:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bad commit backported on the v5.15.y branch ?
To: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
References: <AM9P192MB1316ABE1A8E1D41C4243F596D7792@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Sasha Levin <sashal@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Joel GUITTET <jguittet.opensource@witekio.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
In-Reply-To: <AM9P192MB1316ABE1A8E1D41C4243F596D7792@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1728888344;2a23363c;
X-HE-SMSGID: 1t0Epj-0000HP-9Q

On 11.10.24 10:48, Joel GUITTET wrote:
> 
> I faced some issue related to scaling frequency on ZynqMP device
> using v5.15.167 kernel. As an exemple setting the scaling frequency
> below show it's not properly set:
> 
> cat /sys/devices/system/cpu/cpufreq/policy0/
> scaling_available_frequencies 299999 399999 599999 1199999
> 
> echo 399999 > /sys/devices/system/cpu/cpufreq/policy0/
> scaling_setspeed
> 
> cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq 399999
> 
> cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq 299999
> ====> Should be 399999
> 
> After analysis of this issue with the help of Xilinx, it appears
> that a commit was backported on the 5.15.y branch, but probably it
> should not, or not as is. The commit is
> 9117fc44fd3a9538261e530ba5a022dfc9519620 modifying drivers/clk/
> zynqmp/divider.c.

FWIW, that is 1fe15be1fb6135 ("drivers: clk: zynqmp: update divider
round rate logic") [v6.8-rc1].

> Is anybody reading this message able to answer why it was
> backported ?

Looks like because it fixes a bug. I CCed the original author and those
that handled the patch, maybe they can help us out and tell us what's
the best strategy forward here.

> The information I have until now is that it is intended
> recent kernel version. Dependencies for this modification is
> currently under clarification with Xilinx (maybe another commit to
> backport).
> 
> By the way, reverting this commit fix the issue shown above.
Does 6.12-rc work fine for you? Because if not, we should fix the
problem there.

Ciao, Thorsten

