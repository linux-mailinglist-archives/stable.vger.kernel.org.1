Return-Path: <stable+bounces-67713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC1A952427
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 22:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDA21C209CD
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EE51EB4A5;
	Wed, 14 Aug 2024 20:42:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B21C822A;
	Wed, 14 Aug 2024 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668158; cv=none; b=n1aZgsO94R9n5hjT7J13nG0eyaqYotPe8CzF1IJBdrsChcfvR+riYyg8s7LPRscdsTBb8lqfOkW6GjYyAWN4OzBeC7pa3r3GKZXHUYH/Sukxbl5+ulusUDeB8yUq8NmaSthav8eTiPUHljtj5KxKUR8xzpIq+RDMPQ5lGp12ids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668158; c=relaxed/simple;
	bh=cy+Uj5YrfZw9WjaKbMCWzQAmFBIl0nEA1MIelRBOvZw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VOqhqCNPm8wkUvYUoJXCjG1rmBf0iG6FDv7Z7dKy/RkuhEr21dbRD8AvnHyszPUSihf9rAOjnobzEjdvZ0ls7K9jeUsxMiz9l0dnsQOquqigXFnYhMmILpFtKyiEwEBV5syp8B+kjNcTm/FK/XYAzgKKeUKbaCQ0UzXAP4QwCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.78.237) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 14 Aug
 2024 23:42:02 +0300
Subject: Re: [PATCH] usb: dwc3: ep0: Don't reset resource alloc flag
 (including ep0)
To: Michael Grzeschik <m.grzeschik@pengutronix.de>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20240814-dwc3hwep0reset-v1-1-087b0d26f3d0@pengutronix.de>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <c0e06e73-f6d1-1943-fc83-2cf742280398@omp.ru>
Date: Wed, 14 Aug 2024 23:42:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240814-dwc3hwep0reset-v1-1-087b0d26f3d0@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 08/14/2024 20:30:35
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187071 [Aug 14 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 25 0.3.25
 b7c690e6d00d8b8ffd6ab65fbc992e4b6fdb4186
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.237 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.237 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.237
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/14/2024 20:35:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/14/2024 6:43:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 8/14/24 8:39 PM, Michael Grzeschik wrote:

> The DWC3_EP_RESOURCE_ALLOCATED flag ensures that the resource of an
> endpoint is only assigned once. Unless the endpoint is reset, don't
> clear this flag. Otherwise we may set endpoint resource again, which
> prevents the driver from initiate transfer after handling a STALL or
> endpoint halt to the control endpoint.
> 
> Commit f2e0eee47038 (usb: dwc3: ep0: Don't reset resource alloc flag)

   You forgot the double quotes around the summary, the same as you
do in the Fixes tag.

> was fixing the initial issue, but did this only for physical ep1. Since
> the function dwc3_ep0_stall_and_restart is resetting the flags for both
> physical endpoints, this also has to be done for ep0.
> 
> Cc: stable@vger.kernel.org
> Fixes: b311048c174d ("usb: dwc3: gadget: Rewrite endpoint allocation flow")
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/usb/dwc3/ep0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index d96ffbe520397..c9533a99e47c8 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -232,7 +232,8 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>  	/* stall is always issued on EP0 */
>  	dep = dwc->eps[0];
>  	__dwc3_gadget_ep_set_halt(dep, 1, false);
> -	dep->flags = DWC3_EP_ENABLED;
> +	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;

   No ~ afer &=?

[...]

MBR, Sergey

