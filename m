Return-Path: <stable+bounces-41729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DD38B5A39
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93901C214AE
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5099C6A00B;
	Mon, 29 Apr 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="MPlDlnsl"
X-Original-To: stable@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986A3C24
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397882; cv=none; b=lmdyy/MsyKZwavrHFDNcvytE9LksWmXZ83G5/DnOg3Y7hHjimi4/bDNAfWDe9vFkfQ/XLMJNllOyx4HiJ3PunkBlRlGsXoggF7emVnD7yWaKHgnzO2pJmzzYFMHDv8lbV+Dv+rqDSG7df5nRGei/qDPwSLfxQwJw8kfoMv5A8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397882; c=relaxed/simple;
	bh=9k5ld/GwZ2AT3TR7n1/edHWVlJA1vIgF9+4g32gG7pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeWY9qFSlnDUiLWhhNA9d8E0ognGG4TrlWbYHyclDxZ5/EUWDU47B6F4LXczuuWCVa4cBv5XnWotff2C81PxmvL0pTIoQYIwbuFDwskIX7VX/YGYo3ViVD81BM0nZoUvTxoBSq+uoUqD9z/kAzq+m+5NEY/WGtm7Cv4AHZtotSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=MPlDlnsl; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 8A3D1E14C5F38;
	Mon, 29 Apr 2024 16:37:46 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id wimbMRvNDApW; Mon, 29 Apr 2024 16:37:46 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 56027E14C5F3B;
	Mon, 29 Apr 2024 16:37:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 56027E14C5F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1714397866;
	bh=R6uTX/nTMrkOvIstwy3COhVyccmk2P7MxrzlrA70/40=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=MPlDlnslPaKrrlHgBOSKvlBms9CLkEBd+Z2STYuYqCQjVTknswG87ozg9e/5gPqB9
	 YyrLzVxNGJ9YvQgU1dXf1eJYcpGHjrGV+PmO8Wn082lzw+L0VTE+dQO1dHv+t8UEm4
	 mXV6z4YRKvcydc3rS7x5MKlds+p5xnk5OolTuwi+/XezX1PyN2356gUy0WkcdeR6eQ
	 D93QhTUwSkRU2AfMXk2Zh3dAnE3jLfrbraWHS6yz8jVCBuEtEFlvx3O9BhPsTXhgTy
	 D3zrbtyMAoPdgHZLLhiOyQKb4VZDa8Slr+qzayY7/9g0aqd5nLRPSYUG+PqI5SCmg+
	 u/Ya2+UClHP3g==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gCcDqkl9SPkR; Mon, 29 Apr 2024 16:37:46 +0300 (MSK)
Received: from [192.168.3.4] (unknown [136.169.209.36])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id DDEC0E14C5F38;
	Mon, 29 Apr 2024 16:37:45 +0300 (MSK)
Message-ID: <79ac00a0-4107-bf1a-00c2-07ade9a7791e@rosalinux.ru>
Date: Mon, 29 Apr 2024 16:37:43 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Serious regression on 6.1.x-stable caused by "bounds: support
 non-power-of-two CONFIG_NR_CPUS"
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?B?0JzQuNGF0LDQuNC7INCd0L7QstC+0YHQtdC70L7Qsg==?=
 <m.novosyolov@rosalinux.ru>
Cc: riel@surriel.com, mgorman@techsingularity.net, peterz@infradead.org,
 mingo@kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org,
 sashal@kernel.org, =?UTF-8?B?0JHQtdGC0YXQtdGAINCQ0LvQtdC60YHQsNC90LTRgA==?=
 <a.betkher@rosalinux.ru>
References: <1c978cf1-2934-4e66-e4b3-e81b04cb3571@rosalinux.ru>
 <Zi8MXbT9Ajbv74wK@casper.infradead.org>
 <134159708.2271149.1714363659210.JavaMail.zimbra@rosalinux.ru>
 <Zi-P2rrWZTlrpi3B@casper.infradead.org>
From: =?UTF-8?B?0JjQu9GM0YTQsNGCINCT0LDQv9GC0YDQsNGF0LzQsNC90L7Qsg==?=
 <i.gaptrakhmanov@rosalinux.ru>
In-Reply-To: <Zi-P2rrWZTlrpi3B@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

29.04.2024 15:17, Matthew Wilcox =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> CONFIG_NR_CPUS=3D8192
>
> Since you're using a power-of-two, this should have been a no-op.
> But bits_per() doesn't work the way I thought it did!
>
> #define bits_per(n)                             \
> (                                               \
>          __builtin_constant_p(n) ? (             \
>                  ((n) =3D=3D 0 || (n) =3D=3D 1)          \
>                          ? 1 : ilog2(n) + 1      \
>          ) :                                     \
>
> CONFIG_NR_CPUS is obviously a constant, and larger than 1, so we end up
> calling ilog2(n) + 1.  So we allocate one extra bit.
>
> I should have changed this to
> DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS - 1))
>
> Can you test that and report back?  I'll prepare a fix for mainline in
> the meantime.
Yes, this fix solved the problem

