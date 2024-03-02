Return-Path: <stable+bounces-25766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BC486EEFF
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 07:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E91F22EAD
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 06:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086747490;
	Sat,  2 Mar 2024 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="REkycxVW"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D72582;
	Sat,  2 Mar 2024 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709362398; cv=none; b=PO1OHvK6s83y63NsP5GXPTChBTQ3L/bXtCdl5k86woizyOxECnDKemUr2FDr4xc17sAkaJiGZQmTxWeqDkRYmmxlB+moJZwifPRtYAyj072EPluDzG5DUyFEnvmEc4GXnm/wRskuDNbON+yI57VuMInt4LxDh5gD26PW8IeWd10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709362398; c=relaxed/simple;
	bh=0rs6+GQt5umx5sMyKNERWJefIjI7xRNcTtnkXrdYJaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWyYQG5WaNd8CZm12H9Bi1nLQcBUlbcA82wp+J3GutEb9iVJmTUZSf7Hj0hTr7FaruTPpjkfcmvMAaQAoE5egx1eiXn+1s1C5uRXldfO5VZVukWh34ca/JZnGec7/XUX/v9rExFFFRebAiV0HYOgKs4lx0zu1O7n8wb4zsufdbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=REkycxVW; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=HNP3YLC7LPIGNCGjhQPhwVG+huwS5m34j2vMo+6A25E=;
	t=1709362396; x=1709794396; b=REkycxVWYefyXNEu4RWw9ggaS16NfRxa1riizLOpkeznwF9
	odc4OPmyyBS/DzaGhApDhqUh7ZMDJe0Rm8ZlawBZj1XQtYDu3HSHnbXNrhwS1PN8tRj8KgWdlykrL
	94AKCXtk16c4FUMSl7btQ1xdhFKFvoNhse55shzGG1riSSzvfGu1KSAUsK2Pn5ZE2F8EeeQ43KhnR
	6ALkqYI7QjWtnANS0ZlSHzwuRozvvPdWjWUnCZxCJNkQh1W4d/Lv2soWYfDxvXZO4zBZV14UMum9r
	KikOWmzU3wuhRW6YHtMy+QiQJmUwX4HraGo4HU3Sm+Il9UGEIEUueLBEtJY5VL1w==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rgJFB-0006SC-4z; Sat, 02 Mar 2024 07:53:13 +0100
Message-ID: <50f3ca53-40e3-41f2-8f7a-7ad07c681eea@leemhuis.info>
Date: Sat, 2 Mar 2024 07:53:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.5.0 broke XHCI URB submissions for count >512
Content-Language: en-US, de-DE
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: regressions@lists.linux.dev, Chris Yokum <linux-usb@mail.totalphase.com>,
 stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <949223224.833962.1709339266739.JavaMail.zimbra@totalphase.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <949223224.833962.1709339266739.JavaMail.zimbra@totalphase.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709362396;a8bd5998;
X-HE-SMSGID: 1rgJFB-0006SC-4z

[adding the people involved in developing and applying the culprit to
the list of recipients]

Hi! Thx for the report.

On 02.03.24 01:27, Chris Yokum wrote:
> We have found a regression bug, where more than 512 URBs cannot be
> reliably submitted to XHCI. URBs beyond that return 0x00 instead of
> valid data in the buffer.
> 
> Our software works reliably on kernel versions through 6.4.x and fails
> on versions 6.5, 6.6, 6.7, and 6.8.0-rc6. This was discovered when
> Ubuntu recently updated their latest kernel package to version 6.5.
> 
> The issue is limited to the XHCI driver and appears to be isolated to
> this specific commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb?h=v6.5&id=f5af638f0609af889f15c700c60b93c06cc76675 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb?h=v6.5&id=f5af638f0609af889f15c700c60b93c06cc76675>

FWIW, that's f5af638f0609af ("xhci: Fix transfer ring expansion size
calculation") [v6.5-rc1] from Mathias.

> Attached is a test program that demonstrates the problem. We used a few
> different USB-to-Serial adapters with no driver installed as a
> convenient way to reproduce. We check the TRB debug information before
> and after to verify the actual number of allocated TRBs.
> 
> With some adapters on unaffected kernels, the TRB map gets expanded
> correctly. This directly corresponds to correct functional behavior. On
> affected kernels, the TRB ring does not expand, and our functional tests
> also will fail.
> 
> We don't know exactly why this happens. Some adapters do work correctly,
> so there seems to also be some subtle problem that was being masked by
> the liberal expansion of the TRB ring in older kernels. We also saw on
> one system that the TRB expansion did work correctly with one particular
> adapter. However, on all systems at least two adapters did exhibit the
> problem and fail.
> 
> Would it be possible to resolve this regression for the 6.8 release and
> backport the fix to versions 6.5, 6.6, and 6.7?

6.5 is EOL at kernel.org, that's thus up to downstream distros. And with
a bit of luck it might be possible to fix this for 6.8, but it might be
too late for that already. We'll see.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

