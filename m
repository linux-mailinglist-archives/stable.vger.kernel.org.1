Return-Path: <stable+bounces-78215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA83A9894F8
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 13:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E7E283AA1
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D2216A94F;
	Sun, 29 Sep 2024 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="TwqOwaKw"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FA24A0F
	for <stable@vger.kernel.org>; Sun, 29 Sep 2024 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727607946; cv=none; b=SxDb40V/cg8tuawtt5ngiyzAcNVMgt1P+g8aO69kug2LswrQZt2EMSOZ+Sf+mm1eyGfbFSsnP7auNc0PU1UpA6hAF9qdMTTXMHncJbJoab9jBMOPZ5a9l5hYJceCBk8wSt4MhKXoPw9QXE0irMaHJJHD+WBOaHf8FsFmQKu+pPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727607946; c=relaxed/simple;
	bh=Wa4sGCPiQhu7PhYi79e4R9U2IuXmFJCzwm4dhAcnmf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mp7RW/y+d47eKjkIm5sr/CTgnTGQEwJqPzemSfG6DwZF9xYYCtBgoDSH4f1b3AGNsXN2YAF9dSF6DPrc4VsETAWIwDKeJaFNtlgHXVho75h5Vy4WvJXzofSNUmTvklfp6+NztcJT6DFHHG+VViquuVjU/kPYiL/QJxxoGV3wmbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=TwqOwaKw; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id DD9962000E
	for <stable@vger.kernel.org>; Sun, 29 Sep 2024 11:05:42 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 876843E8AB;
	Sun, 29 Sep 2024 13:05:35 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 7E63E40099;
	Sun, 29 Sep 2024 11:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1727607933; bh=Wa4sGCPiQhu7PhYi79e4R9U2IuXmFJCzwm4dhAcnmf4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=TwqOwaKwNxUBq6r1dWkS3EEQWaj4k/85hiWpk1d7gOyI6vH42/HYnC8MiS9nGdxjl
	 WVwXaBe+UA//T74/HDJeORiGU+nvhCNHNhjwxcxFQzems9RyO1lreKMMCjH+VVAkM4
	 ZakgxOOOVanEPx8TfnBVCjA2/JGCIEXKofVqoAKU=
Received: from [198.18.0.1] (unknown [58.32.43.121])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 70072405C6;
	Sun, 29 Sep 2024 11:05:32 +0000 (UTC)
Message-ID: <cc23ee43-7b27-4db9-b529-081a262d1cf4@aosc.io>
Date: Sun, 29 Sep 2024 19:05:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 6.6 00/54] 6.6.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20240927121719.714627278@linuxfoundation.org>
Content-Language: en-US
From: Kexy Biscuit <kexybiscuit@aosc.io>
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7E63E40099
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 9/27/2024 8:22 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.53 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.53-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Building passed on amd64, arm64, loongarch64, ppc64el, and riscv64. 
Smoke testing passed on 9 amd64 and 1 arm64 test systems.

Tested-by: Kexy Biscuit <kexybiscuit@aosc.io>

https://github.com/AOSC-Dev/aosc-os-abbs/pull/8114

-- 
Best Regards,
Kexy Biscuit

