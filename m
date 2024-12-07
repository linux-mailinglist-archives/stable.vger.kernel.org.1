Return-Path: <stable+bounces-100048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EBB9E8030
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 14:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9BE1883BD7
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA7314264A;
	Sat,  7 Dec 2024 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JrsDp/L1"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282A101E6;
	Sat,  7 Dec 2024 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733579284; cv=none; b=A7kl6cuRcjfCqMLhfrUBEDDHrkGJwBKqv8WzT30psu1Jo/qxY5RCgIR1ZYZYVTWv3mq2xtMVMXBByus5AzpQF9S8/kDO3a9uhvg4C+Sd0YWzpzmC5yjdRHyyZMnXgb7eNz4QqJ/jfSp9UZIcEmiUgBIBr7PIMZBwHfJpbRfq190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733579284; c=relaxed/simple;
	bh=EKTHNldvqnHLe6deVmceXfJvLkXilUh5YM9I/kbHKg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFBzvaKBqVskjl6vnVAFarWOh7Wx7KSD7oIMnRyvEwhWTyjvqioC14APYKJogY0e2E3PAkcHn9EO3YmkAZ73QpVgXFnhOsjzZKdgJdBsltU0/U0TUwmNF/uCtvJFv4CzeDFNx3h60pU6ZW6fNZnLSvm6wDAmxPKhmR8qRQsd4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JrsDp/L1; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.100.64] (unknown [117.162.166.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 781813F136;
	Sat,  7 Dec 2024 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733579272;
	bh=zX7cgyIJFbIrCHNGs6SnLjArr8T2DSgA/ciCc+U74vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=JrsDp/L1TkCR1rH1Z6e6x0KSLo+P5aDbd0sFSBJwVWhu3TGVxf7cav61QEP3nRDiC
	 +g7fNmkKsqvVsBNIr8FBDS0iFPnSCzzGuyuMNlzTDyPdihXeX0E/Nx05fQbPRpmX58
	 rDK/lHudW5h0pgshO/7Dyqmz1IqCjG15xlmNykhKmaETuAVvllsvd0EHJr1sbC2PEV
	 A9nIkIlydwwuFruj7YtNOcHTdHLgoYxzkcyNi2Ld7L/2ARCszCaVCYc0Tl8FSoFEe5
	 tI4s5/bXanKudsfohDS9nzUJZwAACWfl4PUFkIoOvQTgSJ6mSpK9QGnlqgUk5ebV+Y
	 zv1gLv0i/y0vg==
Message-ID: <9f357628-ab2f-42ac-ad5e-694ace262b42@canonical.com>
Date: Sat, 7 Dec 2024 21:47:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [stable-kernel-only][5.15.y][5.10.y][PATCH] serial: sc16is7xx:
 the reg needs to shift in regmap_noinc
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-serial@vger.kernel.org,
 hvilleneuve@dimonoff.com
References: <20241207001225.203262-1-hui.wang@canonical.com>
 <2024120740-violet-breath-763f@gregkh>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <2024120740-violet-breath-763f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/7/24 14:31, Greg KH wrote:
> On Sat, Dec 07, 2024 at 08:12:25AM +0800, Hui Wang wrote:
>> Recently we found the fifo_read() and fifo_write() are broken in our
>> 5.15 and 5.4 kernels after cherry-pick the commit e635f652696e
>> ("serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions
>> for FIFO"), that is because the reg needs to shift if we don't
>> cherry-pick a prerequiste commit 3837a0379533 ("serial: sc16is7xx:
>> improve regmap debugfs by using one regmap per port").
>>
>> Here fix it by shifting the reg as regmap_volatile() does.
>>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   drivers/tty/serial/sc16is7xx.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
> Why not take the proper upstream commit instead?

The prerequisite commit 3837a0379533 will introduce significant change 
and significant conflict if backport it to 5.15.y/5.10.y, It is more 
likely to bring new regression.


>

