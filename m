Return-Path: <stable+bounces-194945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00831C63583
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 10:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E51133804C4
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 09:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FF4328628;
	Mon, 17 Nov 2025 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="z9YWdbBP"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8927326D51;
	Mon, 17 Nov 2025 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372537; cv=none; b=RBiX2OmaPp0w1y/WiSOhgzLtqGq3G3hTPv4In0iZZ58+xz1OuRcIB/AT4kBYtY5hvqIAoGCV4U+Tpiqprdwk3TolOOor8odqpjtHuReGtHCb6DjNZRhfc2zSFuhF45hSxCet0phq15wB1qKyDPyl7G2VI5Wi4gZw7x1y4CuMVI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372537; c=relaxed/simple;
	bh=+lDX5repbVwAgSSpxEPe8Ggrw67h+ua6KeXvVwqhAvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KH1tx5K7KVoguyWAnL0sledbZrLkGaON1XiRI1pRzn/1xgVvt79DPS/vJ2AtkDn1VROJzc+qRh7eqPWyrndU6KVX9wzMtRMb9fpbpmBNQQ7243fRJ31OnPHnAoxT7XpZBrVwZIn8OCIxA6hkAP7morLQLNavbHT/76+mFoZp86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=z9YWdbBP; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=5FRGOs0emlTmc51RdE5KM9BmjBcn2zfRmynLjSXyid8=; t=1763372535;
	x=1763804535; b=z9YWdbBPsUG40dPREbc9ZGK05KxKpl3FiicJ/d3rtuvj9HY4II4FtovqWZ1FV
	VSHJ2FYYfLCqkJmlzEZlorPL3DpN3c6/SPZchvS2zVM3Ajgi+IyISeQYPZ7yfuxBw7vpReW/CtekP
	lRx/lrjrqG03d7JDqF87fCRzlD/fNJIe0L6lwXk2MKGN9m+egD4DJSLsHLWg4gucyjJV1YvemeMUN
	FAwZKhWfnbYmcXAEAgHj1/1yp+Iao7DSwovW4bCmRj3ThMzeM8eEgWe9KMVKXm2AVPvPWTc6nAG+R
	3bCD4eVo3RMyOUt/HyZm7D/h+vLIouG00SJ5wmMnFyugfV/r6A==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vKvkM-005HvH-0f;
	Mon, 17 Nov 2025 10:42:06 +0100
Message-ID: <1b59d3c2-1ed0-40df-a3ba-cca2316e866b@leemhuis.info>
Date: Mon, 17 Nov 2025 10:42:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Bluetooth adapter provided by `btusb` not recognized
 since v6.13.2
To: incogcyberpunk@proton.me, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "marcel@holtmann.org" <marcel@holtmann.org>,
 "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>
References: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1763372535;dec64b74;
X-HE-SMSGID: 1vKvkM-005HvH-0f

On 11/17/25 02:30, incogcyberpunk@proton.me wrote:
> 
> #regzbot introduced: v6.13.1..v6.13.2
> 
> Distro: Arch Linux 
> Kernel: since v6.13.2

Lo! Thx for the report. It's unlikely that any developer will look into
this report[1] as 6.13.y is ancient by kernel development standards and
EOL for quite a while.

Please check if the latest stable version is still affected; if it is,
ideally try latest mainline (6.18-rc6), too. If that is as well, it
would be great if you could bisect between 6.13.1 and 6.13.2.

Ciao, Thorsten

[1] see also:
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/

> The bluetooth adapter would be recognized and the bluetooth worked
> flawlessly till v6.13.1 , but since the v6.13.2 , the bluetooth adapter
> doesn't get recognized by the bluetooth service and therefore the
> bluetooth functionality doesn't work . 
> 
> I suspect the bluetooth's driver failing to load at the kernel-level. 
> 
>   * The output of |bluetoothctl|​ :
> 
> $: bluetoothctl
> Agent registered
> [bluetoothctl]> list
> [bluetoothctl]> devices
> No default controller available
> [bluetoothctl]>
> 
>   * The output of |systemctl status bluetooth.service|​ :
> 
> ● bluetooth.service - Bluetooth service
>      Loaded: loaded (/usr/lib/systemd/system/bluetooth.service; enabled;
> preset: disabled)
>      Active: active (running) since Sat 2025-11-15 22:57:00 +0545; 1 day
> 8h ago
>  Invocation: bddf190655fd4a4290d41cde594f2efa
>        Docs: man:bluetoothd(8)
>    Main PID: 617 (bluetoothd)
>      Status: "Running"
>       Tasks: 1 (limit: 18701)
>      Memory: 2.8M (peak: 3.8M)
>         CPU: 38ms
>      CGroup: /system.slice/bluetooth.service
>              └─617 /usr/lib/bluetooth/bluetoothd
> 
> Nov 15 22:57:00 Incog systemd[1]: Starting Bluetooth service...
> Nov 15 22:57:00 Incog bluetoothd[617]: Bluetooth daemon 5.84
> Nov 15 22:57:00 Incog systemd[1]: Started Bluetooth service.
> Nov 15 22:57:00 Incog bluetoothd[617]: Starting SDP server
> Nov 15 22:57:00 Incog bluetoothd[617]: Bluetooth management interface
> 1.23 initialized
> 
>   * The output of |lspci|​ is attached below . 
> 
>   * The logs for |journalctl -b|​ for both v6.13.1 and v6.13.2 are
>     attached below. 
> 
> 
> Regards,
> IncogCyberpunk
> 


