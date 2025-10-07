Return-Path: <stable+bounces-183550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B04ACBC1EEA
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 17:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F95F34F7A1
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC5B374EA;
	Tue,  7 Oct 2025 15:30:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0821553AA
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851015; cv=none; b=ZPpGGwtFrF9f7k1m56otceMaLpPlNpITfSWcArDs4dy/YB5g5VnHIppmaJkDqdvFjkN0Rz40m2hjpX5EaQ49KrZNkVflN/MDWWi+2r1vRfgXusbKMe/9nbwiWKPsjnHTTE317H8c5bNgvE5O3bxq7Ik5T13BTK9ycQ/XMr1jBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851015; c=relaxed/simple;
	bh=PvFgMUdRmh+ltx6Gd+373JUk7VgYTSgcSGGQ8o1CRXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7wrPnKzzYcyPfcLRbeDPDLmoc9KeHAy3eN21b/QPyCbA/7eNUyQXpHJrJ2f8W7Oc1YV+MzUuUPlDHVCptwp3aCGFrneNAE46Gv21tqM2Re8oJe9BdR2XAX6ZW8wq3KzJwDz+9X+Kc+/ny+sAY7trdnPRmY3F78ddsAsIoVWfdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a01:cb04:321:d500:cc3c:7223:2381:4a2c] (2a01cb040321d500cc3c722323814a2c.ipv6.abo.wanadoo.fr [IPv6:2a01:cb04:321:d500:cc3c:7223:2381:4a2c])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id E5EC4404FF;
	Tue,  7 Oct 2025 15:23:18 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a01:cb04:321:d500:cc3c:7223:2381:4a2c) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a01:cb04:321:d500:cc3c:7223:2381:4a2c]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <3a44a61b-bd60-4dec-a5e6-8ad064203f2b@arnaud-lcm.com>
Date: Tue, 7 Oct 2025 17:23:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hid: fix I2C read buffer overflow in raw_event() for
 mcp2221
To: Greg KH <greg@kroah.com>, Romain Sioen <romain.sioen@microchip.com>
Cc: stable@vger.kernel.org, jikos@kernel.org,
 syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
References: <20251007130811.1001125-1-romain.sioen@microchip.com>
 <20251007130811.1001125-2-romain.sioen@microchip.com>
 <2025100751-ambiance-resubmit-c65e@gregkh>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <2025100751-ambiance-resubmit-c65e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <175985059927.16934.15288356930258486751@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 07/10/2025 15:16, Greg KH wrote:
> On Tue, Oct 07, 2025 at 03:08:11PM +0200, Romain Sioen wrote:
>> From: Arnaud Lecomte <contact@arnaud-lcm.com>
>>
>> [ Upstream commit b56cc41a3ae7323aa3c6165f93c32e020538b6d2 ]
>>
>> As reported by syzbot, mcp2221_raw_event lacked
>> validation of incoming I2C read data sizes, risking buffer
>> overflows in mcp->rxbuf during multi-part transfers.
>> As highlighted in the DS20005565B spec, p44, we have:
>> "The number of read-back data bytes to follow in this packet:
>> from 0 to a maximum of 60 bytes of read-back bytes."
>> This patch enforces we don't exceed this limit.
>>
>> Reported-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=52c1a7d3e5b361ccd346
>> Tested-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>> Link: https://patch.msgid.link/20250726220931.7126-1-contact@arnaud-lcm.com
>> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>> [romain.sioen@microchip.com: backport to stable, up to 6.12. Add "Fixes" tag]
> I don't see a fixes tag :(
Hey, I am the author of the patch. I can find the fixes tag if this 
looks good to you.
Thanks,

Arnaud

> And is this only for 6.12 and 6.16?
>
> thanks,
>
> greg k-h

