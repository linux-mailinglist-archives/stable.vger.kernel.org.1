Return-Path: <stable+bounces-43112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C7E8BCE86
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 14:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A15DB27FBE
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D636EB4C;
	Mon,  6 May 2024 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Jf4OPnNW"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C11DFED;
	Mon,  6 May 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000037; cv=none; b=EKF64fSjGABhHfLZYSM8AxtgSCZNfvmpRvrFhopuaH0haOG6Rt5ZRdvY0M1dHZQIMOP/9eyJ3i+fv6lH1YOUFBBckAucAP/P4xqPGZvAUnHJ1I20h4yIIsmkH1qQXrn369IcpiE6BbST3Q7uF7SsNA2gbIi7Xk310U5I+gylN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000037; c=relaxed/simple;
	bh=h6+1hH9XhB0KBa+l0UP+x9Z2CVunxoz4CdhoOgwxd9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqKJY78efZvW2+EdbiBxy9hb2G5r1hOnXuE0Mm5P4hcfuPPDIguZjJGEUOl5dBvBneus2voBrXEjn8T8gkXE8UTdkYpIEm0xPgXcShTrNiyok88PrIXg6dmGFJq8/1vuKjYWObjLri9ZgBQtkILGIoGKU/kCeZv5WX+yowXbFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Jf4OPnNW; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=L2wtA2YuCrZO8hkF8jTn5doWGyXyq5qsyaLqIFOiMDE=;
	t=1715000035; x=1715432035; b=Jf4OPnNWpX72o12uPG0V4EK5KjohoYTNftxAJwT5eXzoGZh
	1kHaKK2hzrUnj5g3d2rjJZRvX3pXVrBlqDsXc3Y2gv7KjUpLyxFNWwKLOd5EP2KY6b1ZVKq7rGRJD
	3a2+ga1OCDs1peCwE2JX4EO/JjehOy7h4JNJat50i/XXtNIkjGeyPWC3FJhRyBebmsZsQv/IXo41O
	VMaexExfYe22o3i0Q6nnvlQQP0iS2Xl17eYz+u9T1h95WB+C2OihHK82VbZEPDNIqEc3HucPDVz40
	ishO4tes+WVGZLMj7wLnftABWCXze/0phK3KuNBfqmfmEocPgNqI5CIPJM1Az5Lw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s3xqr-0007SB-42; Mon, 06 May 2024 14:53:53 +0200
Message-ID: <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
Date: Mon, 6 May 2024 14:53:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Thunderbolt Host Reset Change Causes eGPU
 Disconnection from 6.8.7=>6.8.8
To: Gia <giacomo.gio@gmail.com>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, kernel@micha.zone,
 Mario Limonciello <mario.limonciello@amd.com>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715000035;3ab4d83a;
X-HE-SMSGID: 1s3xqr-0007SB-42

[CCing Mario, who asked for the two suspected commits to be backported]

On 06.05.24 14:24, Gia wrote:
> Hello, from 6.8.7=>6.8.8 I run into a similar problem with my Caldigit
> TS3 Plus Thunderbolt 3 dock.
> 
> After the update I see this message on boot "xHCI host controller not
> responding, assume dead" and the dock is not working anymore. Kernel
> 6.8.7 works great.

Thx for the report. Could you make the kernel log (journalctl -k/dmesg)
accessible somewhere?

And have you looked into the other stuff that Mario suggested in the
other thread? See the following mail and the reply to it for details:

https://lore.kernel.org/all/1eb96465-0a81-4187-b8e7-607d85617d5f@gmail.com/T/#u

Ciao, Thorsten

P.S.: To be sure the issue doesn't fall through the cracks unnoticed,
I'm adding it to regzbot, the Linux kernel regression tracking bot:

#regzbot ^introduced v6.8.7..v6.8.8
#regzbot title thunderbolt: TB3 dock problems, xHCI host controller not
responding, assume dead

