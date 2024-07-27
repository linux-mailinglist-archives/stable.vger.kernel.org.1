Return-Path: <stable+bounces-61975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE60E93E022
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 18:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912542822D2
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F91862B8;
	Sat, 27 Jul 2024 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="JCxihUNI"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35431822F8;
	Sat, 27 Jul 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722097721; cv=none; b=J9bWI4qPeJE8NE0LTbD5gChxWnbyk+ezggtIoBAA49bwP9+JmQgItfrUTMHZQ5//ItCHpXMLiIHBw6EV7xnGpaujb/dlY3ioo+zEU2SVr6lzLFzbQ5TPweod9dtRKmymwEaExosnSwTjVt2WNmsj4VnMXqcJ708IQRfvBsHLw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722097721; c=relaxed/simple;
	bh=3f0zTor1mnvMTzO0DsCTtilH+K/71txNhBOAejZBYvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuunOKqMT+XJ4okVS3yLMQPqW8183kSM4D8gsSamLEtwQSm978n5veSqRSj8GMPa5DUg12UoUPJZZnwh9JNjFk5g5gQrliANgBwMmGLMIdqeZbTk/5ayUY9g4H9emSyMR/5xiYos7lm8OaSNJD7m/kPZKO6YUh/G2sUT8D701I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=JCxihUNI; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=6woDU4xkf0yXoBT9uAn0Jihe89Zin8AHAJkgz1oPFS4=;
	t=1722097718; x=1722529718; b=JCxihUNId6gqdqHylgpyn1eaWY4FHEAiGHcehJ3T48+i0wd
	QOBQUTNEs9jHwTI56r5RlWp7e+P8yvx2HjN9rpIxODcfIiaUg0Q71KEW5KHFISSsNCLbS0cyiaquF
	mADibR4jwNq6j7nf2Nc3MaG5evuHnBnT3Df4zV2W/f4LyrEnoAFexb/0RLPLtKfofxKZPWGduuCvQ
	4ov0Tcs3NZ8B0f1DwKp57o/8NgipkKD24dJLORnZutATtNU0UNfLrEVmTCyFt7aMwWnTmjb7pBJ4b
	VRkMM7CdhVoBNHG8RzHcXrkLGYyTFWWmbZHCTRnQIusIzYbUNU7zZlDQf14Cn6xQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sXkHV-00007W-6i; Sat, 27 Jul 2024 18:28:29 +0200
Message-ID: <9ca719e4-2790-4804-b2cb-4812899adfe8@leemhuis.info>
Date: Sat, 27 Jul 2024 18:28:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] No image on 4k display port displays connected
 through usb-c dock in kernel 6.10
To: kevin@holm.dev, Alex Deucher <alexander.deucher@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <d74a7768e957e6ce88c27a5bece0c64dff132e24@holm.dev>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US, de-DE
In-Reply-To: <d74a7768e957e6ce88c27a5bece0c64dff132e24@holm.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1722097718;5d878406;
X-HE-SMSGID: 1sXkHV-00007W-6i

[adding a few people and lists to the recipients]

Hi! Thx for your rpeort.

On 27.07.24 18:07, kevin@holm.dev wrote:
> Connecting two 4k displays with display port through a lenovo usb-c
> dock (type 40AS) to a Lenovo P14s Gen 2 (type 21A0) results in no
> image on the connected displays.
> 
> The CPU in the Lenovo P14s is a 'AMD Ryzen 7 PRO 5850U with Radeon
> Graphics' and it has no discrete GPU.
> 
> I first noticed the issue with kernel version '6.10.0-arch1-2'
> provided by arch linux. With the previous kernel version
> '6.9.10.arch1-1' both connected displays worked normally. I reported
> the issue in the arch forums at
> https://bbs.archlinux.org/viewtopic.php?id=297999 and was guided to
> do a bisection to find the commit that caused the problem. Through
> testing I identified that the issue is not present in the latest
> kernel directly compiled from the trovalds/linux git repository.
> 
> With git bisect I identified 4df96ba66760345471a85ef7bb29e1cd4e956057

That's 4df96ba6676034 ("drm/amd/display: Add timing pixel encoding for
mst mode validation") [v6.10-rc1] from Hersen Wu.

Did you try if reverting that commit is possible and might fix the problem?

> as the first bad commit and fa57924c76d995e87ca3533ec60d1d5e55769a27

That's fa57924c76d995 ("drm/amd/display: Refactor function
dm_dp_mst_is_port_support_mode()") [v6.10-post] from Wayne Lin.

> as the first commit that fixed the problem again.

Hmm, the latter commit does not have a fixes tag and might or might not
be to invasive to backport to 6.10. Let's see what the AMD developers say.

> The initial commit only still shows an image on one of the connected
> 4k screens. I have not investigated further to find out at what point
> both displays stopped showing an image.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

