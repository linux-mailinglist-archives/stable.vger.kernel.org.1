Return-Path: <stable+bounces-162983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A145B061CF
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9967C16DCE7
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BECF1925BC;
	Tue, 15 Jul 2025 14:36:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E21D5ADE
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590215; cv=none; b=j7Eya1v04JdbZ0EC1jQe84TFuomE4Wqoor+DtPvaGS3o79pK6D5aI9HjJBpy1ypxK4uKnTF+smyM6wJAcBnni/Rq/xEJDrqVlK4AuVR9erqeiVqoVxPYlDXmwn5HA4gVCdvNsByMar/E9lJYhYjGv4HdyADa34Jf3JmtWOV1t70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590215; c=relaxed/simple;
	bh=8VmRtZW1HYTBTvFWY9G1TDVX7HqJjugkdDxLJ5GNOj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMQAxkhl7YNFVZz/JumSIh0NAWr1bgLmfATy5u2B1JzU68oX2gsH9JZwK0oG71LcxTuagVihHqaYuKysP6Y9heWhIQrhqWTq8fdJpEdlBMEJzDb5vX5BHH7e+0mVRZr5S7eVb32kxqC71DRCGd+WmOK5k0h3acV+KnaROkPO1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=gladserv.com; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gladserv.com
Received: from [2a0c:e303:0:7000:1adb:f2ff:fe4f:84eb] (port=50574 helo=localhost)
	by bregans-0.gladserv.net with utf8esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(envelope-from <brett@gladserv.com>)
	id 1ubgm0-00967d-1t;
	Tue, 15 Jul 2025 14:36:48 +0000
Date: Tue, 15 Jul 2025 16:36:47 +0200
From: Brett Sheffield <bacs@librecast.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10 000/208] 5.10.240-rc1 review
Message-ID: <aHZnf9ZJrmrytZvk@karahi.gladserv.com>
References: <20250715130810.830580412@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
Organisation: Gladserv Limited.  Registered in Scotland with company number SC318051. Registered Office 272 Bath Street, Glasgow, G2 4JR, Scotland. VAT Registration Number 902 6097 39.

Hi Greg,

On 2025-07-15 15:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.240 release.
> There are 208 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.240-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

...

> Brett A C Sheffield (Librecast) <bacs@librecast.net>
>     Revert "ipv6: save dontfrag in cork"

Looking good. With this last patch applied, that regression is now fixed on all
stable kernels it affected.

 https://lore.kernel.org/stable/aElivdUXqd1OqgMY@karahi.gladserv.com/#r

I'll make a point of running our test suite over the stable RC kernels when I
can. That will give the network code paths (mainly IPv6 and multicast) a bit of
exercise and hopefully catch anything like this earlier.

CPU: AMD Ryzen 9 9950X
Boot: OK
130/130 Librecast tests passing

Tested-by: Brett A C Sheffield (Librecast) <bacs@librecast.net>

Cheers,


Brett
-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/

