Return-Path: <stable+bounces-43495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8938C0E34
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 12:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3346F1F231A3
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D97912EBE7;
	Thu,  9 May 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="irByPIf7"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F120C12DDA4;
	Thu,  9 May 2024 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715250697; cv=none; b=sCD2uRPHR82KWPqLGEKZ7hJQGe7WUlt1jQmJtoyn60Yfg93XN3eRMSZNv9d6mBNsG1Wj4Rd6l+kvzJXKvch22C4znVBRC2zSL2yKt+LeoVJogmPuiLXRDLPas7yeId6eCZvQOyLjZaqRd2AFN3ID0S9jpdNZc3EuQbsPMb4hVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715250697; c=relaxed/simple;
	bh=KoMm0YU3T88+9AC2ELVkihs99CbEDDgkFpX6P120Ppc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qPBYkj5DR/vAkRpZzyJEgfxNhKNrt+JvTY826k+jB8X20xzpM6YbkHbzNxVRQm/AnHa9afia+gFoM8wRPmyfmIeb39WZ8m2JuGtFygGaqq1FYSRBCfJpDE+K5k0WOAHBmZ73deRna0utN1c3zeOYtGRQ9jLzFQxDoPPntq2lBJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=irByPIf7; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Reply-To:Subject:From:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=/EtjPJ49eLErfTct4IwKUEDvnMD7g5S++qk8eNGdasU=;
	t=1715250695; x=1715682695; b=irByPIf7KQfKaSvKLNsAO5ws/qH4Tm7aEJZ2uN3wepdh3cg
	weocolkOnaFeQxTaWgClob8fL0klHKjmKRfuHL9ZYq41TUHfAHxvsbKwmEX8DNGzcVb69121hAU0L
	yQGghK8Y/5jJI46At+J0+O2e7H9EZJ9gmN5EgUgxh2I5iL+d+G/nIlYVc1w9coTV6lo0J6u1QWTp5
	FTYo+G9FQA+zQy9U/gF2qPjN6tOjJZpkG0IYTVNKVXS+MyuuTPsl5cVnYZX//yHOdzvTcldXuYlYT
	BKwlyW2TWqIpASAY8XgsKZ19KHTigUJ0d3Jm8/tQv/uYyDuQBhtQOCfoLVHWveQw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s513e-0006hG-9J; Thu, 09 May 2024 12:31:26 +0200
Message-ID: <ba0bc464-a06a-4c54-945a-202dca2c4e49@leemhuis.info>
Date: Thu, 9 May 2024 12:31:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Subject: Re: [REGRESSION] v6.9-rc7: nouveau: init failed, no display output
 from kernel; successfully bisected
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
To: lyude@redhat.com
Cc: kherbst@redhat.com, dakr@redhat.com, airlied@redhat.com,
 stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Dan Moulding <dan@danm.net>, nouveau@lists.freedesktop.org
References: <20240506182331.8076-1-dan@danm.net>
Content-Language: en-US, de-DE
In-Reply-To: <20240506182331.8076-1-dan@danm.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715250695;dede88c9;
X-HE-SMSGID: 1s513e-0006hG-9J

On 06.05.24 20:23, Dan Moulding wrote:
> After upgrading to rc7 from rc6 on a system with NVIDIA GP104 using
> the nouveau driver, I get no display output from the kernel (only the
> output from GRUB shows on the primary display). Nonetheless, I was
> able to SSH to the system and get the kernel log from dmesg. I found
> errors from nouveau in it. Grepping it for nouveau gives me this:
> 
> [    0.367379] nouveau 0000:01:00.0: NVIDIA GP104 (134000a1)
> [    0.474499] nouveau 0000:01:00.0: bios: version 86.04.50.80.13
> [    0.474620] nouveau 0000:01:00.0: pmu: firmware unavailable
> [    0.474977] nouveau 0000:01:00.0: fb: 8192 MiB GDDR5
> [    0.484371] nouveau 0000:01:00.0: sec2(acr): mbox 00000001 00000000
> [    0.484377] nouveau 0000:01:00.0: sec2(acr):load: boot failed: -5
> [    0.484379] nouveau 0000:01:00.0: acr: init failed, -5
> [    0.484466] nouveau 0000:01:00.0: init failed with -5
> [    0.484468] nouveau: DRM-master:00000000:00000080: init failed with -5
> [    0.484470] nouveau 0000:01:00.0: DRM-master: Device allocation failed: -5
> [    0.485078] nouveau 0000:01:00.0: probe with driver nouveau failed with error -50
> 
> I bisected between v6.9-rc6 and v6.9-rc7 and that identified commit
> 52a6947bf576 ("drm/nouveau/firmware: Fix SG_DEBUG error with
> nvkm_firmware_ctor()") as the first bad commit.

Lyude, that's a commit of yours.

Given that 6.9 is due a quick question: I assume there is no easy fix
for this in sight? Or is a quick revert something that might be
appropriate to prevent this from entering 6.9?

Ciao, Thorsten

> I then rebuilt
> v6.9-rc7 with just that commit reverted and the problem does not
> occur.
> 
> Please let me know if there are any additional details I can provide
> that would be helpful, or if I should reproduce the failure with
> additional debugging options enabled, etc.
> 
> Cheers,
> 
> -- Dan

