Return-Path: <stable+bounces-83280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E5B99787B
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 00:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782751F22EF9
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 22:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C5B19923C;
	Wed,  9 Oct 2024 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="vQc+eZKf"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2D16BE3A
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728512693; cv=none; b=jGelSjjZJ1bAo3kGiIx1tKJXL7bKYiZcSq23mBhzB0sDjfrXglZ2v9N8onnuRpnlNrewhS+UUBI3+N5ez6zd7xVM07tLTnsYOX73V57mE3Tgx2/HEPmsoHuhtn3Rk4tw1Ozve8sWGxTFDM8y7jeCYb3293znlpZycQujwVtIGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728512693; c=relaxed/simple;
	bh=CV3g2nWQg4V1StBeMoclFV5EtNfoIyaZhNwh/5bzpiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V5jlH2GukmZVliV9fqkcqMy/tRqf2mj3O04DctUIptAFlwJPu5/neccmNa7AcChXk+HDMQU1kkMcu0j4kgIEtVN3xYVkNlUBdok+iXnqivdbYjRiCj/tKdxe3xYFgssl67zTFC0lnGv9C8JnmFIs2WECMS0cAeytQTs/mvvZ+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=vQc+eZKf; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.100])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id D6E7D26760
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 22:24:43 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 01EF43E92F;
	Wed,  9 Oct 2024 22:24:36 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id ABCC64002D;
	Wed,  9 Oct 2024 22:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1728512674; bh=CV3g2nWQg4V1StBeMoclFV5EtNfoIyaZhNwh/5bzpiY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=vQc+eZKfG0emYicpJBUq2pN1P3DBBHapwogJIIwQGexUmy6coXd4FjfPRCFOKD9N0
	 zf2ktgMF2AAfO6K48cNcTqLd1GPIzh6CjLsMeNTodlKxgR5Tt6vIUgqhGF0IR4uF/E
	 c7VTg61AwYsZGbL/xRwPbigFjF3NrQZZme2xHy+0=
Received: from [198.18.0.1] (unknown [58.32.43.121])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id E9A8A40AD7;
	Wed,  9 Oct 2024 22:24:33 +0000 (UTC)
Message-ID: <eb978d27-5449-4242-a88d-7397c513c0d3@aosc.io>
Date: Thu, 10 Oct 2024 06:24:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 6.10 000/482] 6.10.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241008115648.280954295@linuxfoundation.org>
Content-Language: en-US
From: Kexy Biscuit <kexybiscuit@aosc.io>
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Queue-Id: ABCC64002D
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

On 10/8/2024 8:01 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.14 release.
> There are 482 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Building passed on amd64, arm64, loongarch64, ppc64el, and riscv64. 
Smoke testing passed on 9 amd64 and 1 arm64 test systems.

Tested-by: Kexy Biscuit <kexybiscuit@aosc.io>

https://github.com/AOSC-Dev/aosc-os-abbs/pull/8222
-- 
Best Regards,
Kexy Biscuit

