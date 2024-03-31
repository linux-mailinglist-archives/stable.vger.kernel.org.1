Return-Path: <stable+bounces-33853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B707892EC1
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 08:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0267F2823A3
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 06:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950556FB0;
	Sun, 31 Mar 2024 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="SB3C9SEn"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96AE2905;
	Sun, 31 Mar 2024 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711867541; cv=none; b=MqaRrx7ASv25UMjl7vvn+7/EhaUhfJn6LsEQa8w/pg+NNq7gtiBVHjBulyDBN+ZUzAvWtgLo9oaOuxClP6fTiuXyw5Oi0hIMVVxDS1bv9Fiy3Jqkivz/0/fPDnMTZrejGFOHo7wd3m8lSrcydchW9tsDsmCX5bA2efH6EiRV1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711867541; c=relaxed/simple;
	bh=+Fwxr9NjtvbTfYy+SiiOTyuQTe+kw9EwSP2i1/tPczQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7fmYO5oqtgqiB8sUcZgDxqvL3DoPyj9knAhzmrz3o4I4qcv7BFr+hUeb7AfDGdO7tLSHKDUpcmTqJBDNXt9QOm/Vn2Ag+6z7FigKCXDpXX4YQAAwCLm/xbui1N5PDbg9B29J2/yxTe5SJtoZIb+eBxpxexdmGHPBq+l8uSk740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=SB3C9SEn; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=t0aIxVdYdjtcyYzEcCkkyNAwoLxcYyQCEwarqr5YlAY=;
	t=1711867538; x=1712299538; b=SB3C9SEnwRXEAoyep2sB/1bS3HaOid4U3mOKe/KybV+XyIp
	6aZAqLPcEUGhGXOXa2IBVRThNAGZ4MBWfSG9i10qFvypQI0pCiRQRllowd2hbfYNj9fkV33mSEyOa
	eprRvJa44M1jOaYzd99spzcQGq1N1vpdpo68iKmioIaaB0AcLJ+KXEKoY9wp9pmgiAROTO+DXLYqM
	EqbVmQXcqA4vtakDqajiEUcDriiGMxn5SqNbc5Fy3O7veBrEZsfsU2Ju76Cjr24BGyKQDRpnPgn55
	uNNhdMaeTFF6HYVCiJ3o587S/nTezkMhbVw4Zw752Ie5fxxESamqtycm19Kyv1Hg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rqowc-00044B-SC; Sun, 31 Mar 2024 08:45:30 +0200
Message-ID: <e9e23151-66b4-4d4f-bf55-4b598515467c@leemhuis.info>
Date: Sun, 31 Mar 2024 08:45:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] external monitor+Dell dock in 6.8
To: Andrei Gaponenko <beamflash@quaintcat.com>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev
References: <22aa3878-62c7-9a2c-cfcc-303f373871f6@quaintcat.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <22aa3878-62c7-9a2c-cfcc-303f373871f6@quaintcat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711867538;0b40867c;
X-HE-SMSGID: 1rqowc-00044B-SC

Hi! Thx for reporting your problem!

On 31.03.24 07:59, Andrei Gaponenko wrote:
> 
> I noticed a regression with the mailine kernel pre-compiled by EPEL.
>
> I have just tried linux-6.9-rc1.tar.gz from kernel.org, and it still
> misbehaves.
> 
> The default setup: a laptop is connected to a dock, Dell WD22TB4, via
> a USB-C cable.  The dock is connected to an external monitor via a
> Display Port cable.  With a "good" kernel everything works.  With a
> "broken" kernel, the external monitor is still correctly identified by
> the system, and is shown as enabled in plasma systemsettings. The
> system also behaves like the monitor is working, for example, one can
> move the mouse pointer off the laptop screen.  However the external
> monitor screen stays black, and it eventually goes to sleep.
> 
> Everything worked with EPEL mainline kernels up to and including
> kernel-ml-6.7.9-1.el9.elrepo.x86_64
> 
> The breakage is observed in
> 
> kernel-ml-6.8.1-1.el9.elrepo.x86_64
> kernel-ml-6.8.2-1.el9.elrepo.x86_64
> linux-6.9-rc1.tar.gz from kernel.org (with olddefconfig)
> 
> Other tests: using an HDMI cable instead of the Display Port cable
> between the monitor and the dock does not change things, black screen
> with the newer kernels.
> 
> Using a small HDMI-to-USB-C adapter instead of the dock results in a
> working system, even with the newer kernels.  So the breakage appears
> to be specific to the Dell WD22TB4 dock.

Does you laptop offer a HDMI or DP connector? Have you tried if that
that works any better? If it does not, then the DRM developers might be
willing to look into this.

Anyway: could you try to bisect the problem as described in
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

I strongly suspect that this will be needed to get this resolved: this
could be caused by various subsystems, so no developer might be willing
to look into this without a bisection result. :-/

Ciao, Thorsten

> Operating System: AlmaLinux 9.3 (Shamrock Pampas Cat)
> 
> uname -mi: x86_64 x86_64
> 
> Laptop: Dell Precision 5470/02RK6V
> 
> lsusb |grep dock
> Bus 003 Device 007: ID 413c:b06e Dell Computer Corp. Dell dock
> Bus 003 Device 008: ID 413c:b06f Dell Computer Corp. Dell dock
> Bus 003 Device 006: ID 0bda:5413 Realtek Semiconductor Corp. Dell dock
> Bus 003 Device 005: ID 0bda:5487 Realtek Semiconductor Corp. Dell dock
> Bus 002 Device 004: ID 0bda:0413 Realtek Semiconductor Corp. Dell dock
> Bus 002 Device 003: ID 0bda:0487 Realtek Semiconductor Corp. Dell dock
> 
> dmesg and kernel config are attached to 
> https://bugzilla.kernel.org/show_bug.cgi?id=218663
> 
> #regzbot introduced: v6.7.9..v6.8.1
> 
> Andrei
> 
> 

