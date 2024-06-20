Return-Path: <stable+bounces-54768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBED9111AE
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 21:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18297289637
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21AB3FB2C;
	Thu, 20 Jun 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID9rkr4M"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565724B26;
	Thu, 20 Jun 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910052; cv=none; b=E5FbvbIsZhGPTg6+mOC3BkQc7kKLFvwh55+0hgOa+0ZhBMdSTeIBlIhUg5xNvMyjepNbyacgIaJfrRxd7OCCE3dlWyRGqxkX5KtQSdCLpXW6s/hx8JolSV080JSOpqzKXLNmsvGMGnhiXbBAQ9gt+T+FhukxMzD8FV17lwiNN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910052; c=relaxed/simple;
	bh=lfvgxczR5/qk6zthHHFAgmMi+9NrXVi8m5IfPXhpsK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVm/sVYBpM0p4CrYT9nbS2p2nNu3GQ4iyU2AeiiTJp5jTiPgb43BHMIwHOvqc+F6Qy7aZHT961niwFW7QAyynVO4BYWX9hSv7mtdXl2IaMeqBS/m+Jin2N1fHPRKlGQ31FqZzJJUOeEgYh6XbedBnfORtuwx2QtnIbuyhg9Bi9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID9rkr4M; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a63359aaacaso185316566b.1;
        Thu, 20 Jun 2024 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718910049; x=1719514849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsxQYin5JojAxp6enhq9SBRWoC/pFwUM1omQr9TXbXg=;
        b=ID9rkr4MYdMgCSIomVqngdN1gUKUa/x+0TzHvjFkHlO8w2dBNmBbG685KOofrpmBTv
         qNnzjQjX1QJL/40Te9Y1QONPwIeHF1X9Dehr8+UGYZg4+lqQUajq4O+CB4zZVSAgw1T5
         dhIRRKc/ZXNj/TUqSPaNBQ6IdvgddHijXCcviYL1G7ilZNGGEmHuvwBrha1kLhEfsk7P
         fkmUJHoxxF7XzCyHbQ7mzzFHYXoryr444PnX477307tuDcezmIbvozytu88Po052jmKk
         J+aOJNEJ6r3kKZN4b+V8vOyQIQLNMEMLjcerSz6QPyuydU2BNNPx5wg3R4iT5h6/2vUX
         Ppkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718910049; x=1719514849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsxQYin5JojAxp6enhq9SBRWoC/pFwUM1omQr9TXbXg=;
        b=pJkCGCKEQ6bJ4DrQSwQp7CbrWsDBg1/sYEbpSh7xk2OShwfczCq+ZmlrYvy5lMu3qO
         OAEeh7hnDMe8KP/F/8pkWNLYOs60NM9mzdfkjeqUNCsuzRWpwj8vTUKvzUdgYA5KaEft
         XgfSIasGxRjJwZy1uY77Uq9NFyF1WNrGQ97rBpEV1C3uUh/dnOjtd8X+HDecymuoE9eT
         IVsZlTJXcnXD722kVdcc78MjQGHWaGTQ2K5qgi8GhynkhxNm+xsym2yf1EC+r7Plk/8N
         c2EdWwHaGC+V2jBDEhWxuCXDfcgngeJGKnCGoDXORpMEBJ5etTPJSSxJanphrGRwDK/m
         cFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcHTaiKpkBAKezbTrjrbUga4v5KMAUY+TYPZDjgUYTBbkKbhkaQrBaGxKS/LQ680SJBM7+bhtROJh21QetVwIVpP0Q5ejQB8437Jr27gcQmjiDKI5qiNkcqXLHvg+0I+higNxtWxioauz7/WqEX69PywAhiaKctnTOq4tWDqPZ
X-Gm-Message-State: AOJu0YzSgkg0yRGzzF+cMFfgzEV/l75KwvdMyX2HngmbyGVolDqrJDa8
	NakKYP8zX+oB2N6FgV8hWa+TucztQmpAQPDV9W9Qs9rtdQR8eE6Q
X-Google-Smtp-Source: AGHT+IEsaHPa7oPhZt6UNr4ZreNLGXyKk5qeWjcJ2EyTCeovJYLkdVnc8RPPNkK6wg/LQESENHd5vQ==
X-Received: by 2002:a17:906:1515:b0:a6f:e36:abae with SMTP id a640c23a62f3a-a6fab6451ffmr387881566b.42.1718910048904;
        Thu, 20 Jun 2024 12:00:48 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:a810:a6b8:d8d0:6594? (2a02-a466-68ed-1-a810-a6b8-d8d0-6594.fixed6.kpn.net. [2a02:a466:68ed:1:a810:a6b8:d8d0:6594])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf54942dsm958266b.137.2024.06.20.12.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:00:48 -0700 (PDT)
Message-ID: <1a4925bd-558d-4169-b4e6-f37fb33ae0b9@gmail.com>
Date: Thu, 20 Jun 2024 21:00:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "usb: gadget: u_ether: Re-attach netif
 device to mirror detachment"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ferry Toth <ftoth@exalondelft.nl>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>, Kees Cook
 <kees@kernel.org>, Linyu Yuan <quic_linyyuan@quicinc.com>,
 Justin Stitt <justinstitt@google.com>,
 Richard Acayan <mailingradian@gmail.com>,
 Hardik Gajjar <hgajjar@de.adit-jv.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>,
 s.hauer@pengutronix.de, jonathanh@nvidia.com, paul@crapouillou.net,
 quic_eserrao@quicinc.com, erosca@de.adit-jv.com, regressions@leemhuis.info,
 stable@vger.kernel.org
References: <20240606210436.54100-1-ftoth@exalondelft.nl>
 <20240606210436.54100-2-ftoth@exalondelft.nl>
 <2024062009-unison-coauthor-46a0@gregkh>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <2024062009-unison-coauthor-46a0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

Op 20-06-2024 om 19:35 schreef Greg Kroah-Hartman:
> On Thu, Jun 06, 2024 at 11:02:31PM +0200, Ferry Toth wrote:
>> This reverts commit 76c945730cdffb572c7767073cc6515fd3f646b4.
>>
>> Prerequisite revert for the reverting of the original commit f49449fbc21e.
>>
>> Fixes: 76c945730cdf ("usb: gadget: u_ether: Re-attach netif device to mirror detachment")
>> Fixes: f49449fbc21e ("usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach")
>> Reported-by: Ferry Toth <fntoth@gmail.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/usb/gadget/function/u_ether.c | 2 --
>>   1 file changed, 2 deletions(-)
> 
> You have to sign-off on your changes, otherwise the tools will reject
> them (as will I).  Please fix up for both of these and resend.

Oops, I knew that. Just didn't notice SoB wasn't auto added.
I'll that up, sorry.

> thanks,
> 
> greg k-h


