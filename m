Return-Path: <stable+bounces-27149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D84876665
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 15:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8BE282BF0
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C28EBB;
	Fri,  8 Mar 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VMwJ+zar"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AC0173;
	Fri,  8 Mar 2024 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709908469; cv=none; b=kz6x/pSk0pV4oW7ojJ/FzPWEFJTB8m7EwWjRb+5sujOJGxCQ9Q67yhUQPjSuH2Nj80A25WlRMlr9olEbRp8lo9FOBTGCxwfrecPAvnir/1dUJh6ymUrv4QmPSt4/Jty74GPnu7L7EoeO83QViS09PsdJBLBNRWnWGfUb3EP1Egg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709908469; c=relaxed/simple;
	bh=iR2HDRYdl3kEYPLqKR2vIC9j8WLlVsgpS+eB1ICs/2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slvVRx3U8R/jDMDpBPA3GsjKRZqf4cCT1dBZPm6BWDXX5xU080iN1a4W6TFfVZ1IQPGIuqHGkuI1kV8psXfESSMZLsYxXWr5z3pUBJKfIXrJnXIiHJPBeucnK/2J9PW25Eth0b5kVqfYAjVN1P1je7b4oCQnKMK1NzL6Oebw4Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VMwJ+zar; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SvCqnE1sc6/yLfNTVKRPKG7Xabu6+CcefkiE3L8kYbE=; b=VMwJ+zaruZzA2E9dp4mWe+qfWV
	XBJbPsDud128dPJmdBX93J3WBfQqb1vw9y41GCIfMLFQRl+/gI0QDQUWwHCJM+chnX1fgnNzWneX2
	KciUh2W7FtMvbzUinb3P9ie5RGdCQwc8gATTGE7kZiKvn/SsVzK9nplDjGF5XDKWjrrNbu6Bl9O5T
	5Ld0LzoxAf5yhdxX5xfl195VzB+WTv2H7bHcbaIMBmIuQpewJoTplzo9rqxz9YlW4ocfxwkOMq/qp
	Ji3PdVMG8NwWJqEQk6ZX4ejWKSgmBl2F45bFqECjgxMuXjkfWybcV7e5v/AXTaBO75XEICw8dsB/Z
	lVUbXneA==;
Received: from [177.62.247.190] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ribIg-007oYz-H9; Fri, 08 Mar 2024 15:34:18 +0100
Message-ID: <cac3f811-189f-be7f-e5fa-12ee6ca8a62a@igalia.com>
Date: Fri, 8 Mar 2024 11:34:13 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] usb: dwc3: Properly set system wakeup
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: John Youn <John.Youn@synopsys.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 John Schoenick <johns@valvesoftware.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Vivek Dasmohapatra <vivek@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <667cfda7009b502e08462c8fb3f65841d103cc0a.1709865476.git.Thinh.Nguyen@synopsys.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <667cfda7009b502e08462c8fb3f65841d103cc0a.1709865476.git.Thinh.Nguyen@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2024 23:40, Thinh Nguyen wrote:
> If the device is configured for system wakeup, then make sure that the
> xHCI driver knows about it and make sure to permit wakeup only at the
> appropriate time.
> 
> For host mode, if the controller goes through the dwc3 code path, then a
> child xHCI platform device is created. Make sure the platform device
> also inherits the wakeup setting for xHCI to enable remote wakeup.
> 
> For device mode, make sure to disable system wakeup if no gadget driver
> is bound. We may experience unwanted system wakeup due to the wakeup
> signal from the controller PMU detecting connection/disconnection when
> in low power (D3). E.g. In the case of Steam Deck, the PCI PME prevents
> the system staying in suspend.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Closes: https://lore.kernel.org/linux-usb/70a7692d-647c-9be7-00a6-06fc60f77294@igalia.com/T/#mf00d6669c2eff7b308d1162acd1d66c09f0853c7
> Fixes: d07e8819a03d ("usb: dwc3: add xHCI Host support")
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

[CCing some interested parties here from Deck development teams]

Hi Thinh, thanks a bunch for the fix, and all the support and attention
on this issue - much appreciated!

I've tested this fix on top of v6.8-rc7, in the Steam Deck, and it
manages to resolve the sleep problems we have on device mode.
So, feel free to add:

Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck


Should we try to get it included last minute on v6.8, or better to make
use of the merge window opening next week?
Cheers,


Guilherme

