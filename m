Return-Path: <stable+bounces-83279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A573999786A
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 00:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B6B28468E
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 22:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A81D1E285F;
	Wed,  9 Oct 2024 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="XO7OcFtN"
X-Original-To: stable@vger.kernel.org
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6616BE3A
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.165.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728512620; cv=none; b=Ch4vUHf/ZDQsLpHwPzlDQQxjA5h9Jhrk+Ej2EjOhSYwtCfLb/eXUGJ1zFrvl/U4lmLT2kw25IwdKyxKlLP4vgYXj5nA7D3eGpvL6jdYm2ahcCGq5+VQuWPigxnlZ8Nx1vnonf1hxN5w/SjZcC4EiuQS5lGYPAsv2/HKPfQL1tas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728512620; c=relaxed/simple;
	bh=xdtrjw5L1jBok1aTN8MpZ9ljT6J6Oyo+W1g5dFZ12b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rg5fTicCSN+/xIIFMDNrEC9s5We9m2/xLS9WSNV9qDBDIOEyy8uYLmNpUCiUvAHR+C9wecOJN8YUD6rpcXqLupBOF9rwDqiE/+UFS4vdvV7/R5X5wYTXyenBq1XwmnB1/0LFfZPvCXGmHix6u5GLga4/luMeLWHurF6EW9YL9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=XO7OcFtN; arc=none smtp.client-ip=151.80.165.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 486683E8B0;
	Thu, 10 Oct 2024 00:23:30 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 239F7400D6;
	Wed,  9 Oct 2024 22:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1728512608; bh=xdtrjw5L1jBok1aTN8MpZ9ljT6J6Oyo+W1g5dFZ12b0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=XO7OcFtNV4+SOxzPbXyVDipRTe+F0XpujK9qs6UQWX5QD5CWFRNthhVV2eCGAYmTa
	 PhR3lufNlW7/V8FnWpqc4nHyHPW0EBqMO0kP2md8ncFafbxgnaMRf6jLjNEqChDQQX
	 p5xlug+tHks8X/qbC5VQl/uuQHxB+pQKTybCHwPU=
Received: from [198.18.0.1] (unknown [58.32.43.121])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 12D6B40AD7;
	Wed,  9 Oct 2024 22:23:26 +0000 (UTC)
Message-ID: <15482b01-e576-4a0d-94ad-dabd2b5baabf@aosc.io>
Date: Thu, 10 Oct 2024 06:23:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 6.11 000/558] 6.11.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241008115702.214071228@linuxfoundation.org>
Content-Language: en-US
From: Kexy Biscuit <kexybiscuit@aosc.io>
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Queue-Id: 239F7400D6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[aosc.io:email,mail20.mymailcheap.com:rdns,mail20.mymailcheap.com:helo];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]

On 10/8/2024 8:00 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.3 release.
> There are 558 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Building passed on amd64, arm64, loongarch64, ppc64el, and riscv64. 
Smoke testing passed on 9 amd64 and 1 arm64 test systems.

Tested-by: Kexy Biscuit <kexybiscuit@aosc.io>

https://github.com/AOSC-Dev/aosc-os-abbs/pull/7680
-- 
Best Regards,
Kexy Biscuit

