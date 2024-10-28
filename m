Return-Path: <stable+bounces-88238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8019B2183
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 01:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8003A2812AA
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 00:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D72F1878;
	Mon, 28 Oct 2024 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="g2pnPtkt"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B9EAEB
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730074677; cv=none; b=jBcULh4CC/P9US0ry/1WH62U3OhI6gg7NL1aq3uktM/OftOmqaUd0BTUruzJXQWXWX4AZ69rzWsyryvMO953ncWMZJFO0ecCXUQqzHIJo4i2wAHNhWgkEY7wqUJofb3eVflNKachNedt42jZfiEgzPt1vznVQ35mANj7WPnS7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730074677; c=relaxed/simple;
	bh=TO3XgbjTPNGOf09TT6fFo03Ha9ptp5O3ug5xR1pjpYw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WucvAKhxfOy5lUL5qxtu7uGYns9u5Jy17y7GKJM19ucqsld6TJI+KqZ98G6X/7rIrS9QH16TipzCHQc3S1+99z0GxgaFQyjPLLAWYUt8bVaydA2W8Kv4rSRvKftmq0qQF3iCC1wE8GVnOAL/u8XZWOqQD24XShCRZ/12hwYYXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=g2pnPtkt; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id 4jPbtPjXgumtX5DS8tyyqp; Mon, 28 Oct 2024 00:17:48 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 5DS7tFFF5durn5DS7tGsiH; Mon, 28 Oct 2024 00:17:47 +0000
X-Authority-Analysis: v=2.4 cv=aNH2q69m c=1 sm=1 tr=0 ts=671ed82b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10
 a=uxgLTjTjiylkul1d-vUA:9 a=QEXdDO2ut3YA:10 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ct8wg4kLyMMfEQg5mOMY7RKn2GG8vdZ2NnPY3zDs58Y=; b=g2pnPtktSDLV7w0LvEuyzXDOVa
	Hk56yvw2tiUIcOwVf1i2Gg2/DertkMuZ9Hj+WBBB4Nu+ezmi65YX7i4Ji1vmdaI5Fwo1uLg0IpbbY
	j5Iwk/ENesWiyHO3kCdjf6kNbIuDHbYtou/3CzzwvhT4DQkwkJA4+e3vw1EAXF9dTFKDK4S/YdSKq
	PEgTs//zKwdL748SqmzOkuvYBoTOCq3bItaYke1E3SKdqiE4a0k2LKjxSHOpTR9iwAXJsysH6Zw+1
	nx2m6PkOEfNip1R7pQivJ4VAphdM0ftW42M2VLaryR4ty1AkYujn22ku0yWMbhkHmHLauXeW+In7T
	9F5JPkxQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:35924 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1t5DS6-001d97-0a;
	Sun, 27 Oct 2024 18:17:46 -0600
Subject: Re: [PATCH] riscv/entry: get correct syscall number from
 syscall_get_nr()
To: Thomas Gleixner <tglx@linutronix.de>,
 Celeste Liu <coelacanthushex@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
 Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
 "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <87ldya4nv0.ffs@tglx>
 <3dc10d89-6c0c-4654-95ed-dd6f19efbad4@gmail.com> <87a5ep4k0n.ffs@tglx>
 <2b1a96b1-dbc5-40ed-b1b6-2c82d3df9eb2@gmail.com> <877c9t43jw.ffs@tglx>
From: Ron Economos <re@w6rz.net>
Message-ID: <81afb4bf-084b-e061-8ce4-90b76da16256@w6rz.net>
Date: Sun, 27 Oct 2024 17:17:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <877c9t43jw.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1t5DS6-001d97-0a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:35924
X-Source-Auth: re@w6rz.net
X-Email-Count: 22
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfElW0iY1tI3nXGE0pTFy6wVLK6sw/y9wDk8EQUiuO6uyK3L20r/bQUYe16PaVa9TXS8sosNzJcwZEoVYEHl9YxLnoHlxTjI07mN4+0J7W3Cbsig9/Kwo
 0NQr895nBzHMkS0t9H1I4XAXcMF2R6jtY+SAu6OBZEAvBRJi+uQihNo2PHqTQ1bclpkB4A7W0vlP9g==

On 10/27/24 2:52 PM, Thomas Gleixner wrote:
> On Mon, Oct 28 2024 at 01:01, Celeste Liu wrote:
>> On 2024-10-27 23:56, Thomas Gleixner wrote:
>>> Equivalently you need to be able to modify orig_a0 for changing arg0,
>>> no?
>> Ok.
>>
>> Greg, could you accept a backport a new API parameter for
>> PTRACE_GETREGSET/PTRACE_SETREGSET to 4.19 LTS branch?
> Fix the problem properly and put a proper Fixes tag on it and worry
> about the backport later.
>
> Thanks,
>
>          tglx
>
I wouldn't worry about backporting to the 4.19 kernel. It's essentially 
prehistoric for RISC-V. There's no device tree support for any hardware. 
Also, 4.19 will be going EOL very soon (December 2024).

Ron


