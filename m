Return-Path: <stable+bounces-183584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E69FBC3844
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 08:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07251351C17
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 06:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BB52EB846;
	Wed,  8 Oct 2025 06:50:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E50E52F99
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759906235; cv=none; b=qqJJ1BVBRiz90W5UHljREy/GIVCKUpXeFptox4bh/fnvu7Z+dG7C+3wH66/s06rT99g9Iq1Vtjrod76GJDTzjMvxZq7S9QNGU5Typkz7NVbkzRYdwrJTnzEzpud1Qa9StKxkd0fuaUGLHLRFq5b/e1OyBB4avGMq3cmu9o7YId8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759906235; c=relaxed/simple;
	bh=RBHpAChoreK7EQYj+MYvijmVHgVf3Rs/uxDEg4zSl+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkKp0k+W8HYkXVMPq80Vnv+ozoHKRLNj3Ce6j8VVHx1dnpKsbUn942x3IQbelyyLVLKr+NQ4VUvKC0mBxe4FlfV2an2ecV6fgB76ZXLTz8TypPntztFULtiHOYWgkkEeEtjKmESLws3S7gmrVd+oh8xQwq+pIsnHhJHG4pZ6uO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [192.168.6.152] (unknown [54.239.6.187])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 96256405FF;
	Wed,  8 Oct 2025 06:50:30 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 54.239.6.187) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[192.168.6.152]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <1eea8c34-8c96-4e0b-a255-8679f6d4ae00@arnaud-lcm.com>
Date: Wed, 8 Oct 2025 08:50:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hid: fix I2C read buffer overflow in raw_event() for
 mcp2221
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Romain Sioen <romain.sioen@microchip.com>, stable@vger.kernel.org,
 jikos@kernel.org, syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
References: <20251007130811.1001125-1-romain.sioen@microchip.com>
 <20251007130811.1001125-2-romain.sioen@microchip.com>
 <2025100751-ambiance-resubmit-c65e@gregkh>
 <3a44a61b-bd60-4dec-a5e6-8ad064203f2b@arnaud-lcm.com>
 <2025100716-rockfish-panda-9c4b@gregkh>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <2025100716-rockfish-panda-9c4b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <175990623104.25477.3404627467543023694@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 07/10/2025 17:26, Greg KH wrote:
> On Tue, Oct 07, 2025 at 05:23:17PM +0200, Lecomte, Arnaud wrote:
>> On 07/10/2025 15:16, Greg KH wrote:
>>> On Tue, Oct 07, 2025 at 03:08:11PM +0200, Romain Sioen wrote:
>>>> From: Arnaud Lecomte <contact@arnaud-lcm.com>
>>>>
>>>> [ Upstream commit b56cc41a3ae7323aa3c6165f93c32e020538b6d2 ]
>>>>
>>>> As reported by syzbot, mcp2221_raw_event lacked
>>>> validation of incoming I2C read data sizes, risking buffer
>>>> overflows in mcp->rxbuf during multi-part transfers.
>>>> As highlighted in the DS20005565B spec, p44, we have:
>>>> "The number of read-back data bytes to follow in this packet:
>>>> from 0 to a maximum of 60 bytes of read-back bytes."
>>>> This patch enforces we don't exceed this limit.
>>>>
>>>> Reported-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=52c1a7d3e5b361ccd346
>>>> Tested-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
>>>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>>>> Link: https://patch.msgid.link/20250726220931.7126-1-contact@arnaud-lcm.com
>>>> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>>>> [romain.sioen@microchip.com: backport to stable, up to 6.12. Add "Fixes" tag]
>>> I don't see a fixes tag :(
>> Hey, I am the author of the patch. I can find the fixes tag if this looks
>> good to you.
> There's no need for a fixes tag, just let us know where you want this
> backported to.
The ones, you already did the back-port to, seems good enough for me,
Thanks Greg :)
> thanks,
>
> greg k-h
Arnaud

