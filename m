Return-Path: <stable+bounces-244214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFKHIyoZ+mmWJQMAu9opvQ
	(envelope-from <stable+bounces-244214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 18:22:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F8B4D12D3
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 18:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 782F13006005
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DC748A2CC;
	Tue,  5 May 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="FZn1cz7S"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D533806AC
	for <stable@vger.kernel.org>; Tue,  5 May 2026 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998116; cv=none; b=dW0EdnUOLXQdd95dJSbRvTqIB1BJDFvStfWL/20xEBFIEOwYlcDP2PMRERpMQkvMUlKGD4XXOB3b7Pdo5IA2I7B7k9joawxp8gLyqkcHgGF/xVNtZ99e/YEHB7NK199hiJvwdM0Pem/9/GOBAKgTgq6xbKmf8ymbsnCvTNovrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998116; c=relaxed/simple;
	bh=MhVhqytDBsoXqrV7yikqRH2U/UkDGacf8smarcWqBEc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Im5IcAqp8u0OgJ4dLuS1B9Ve6CfaPgbvUyJev8EbmJR4TcvQ0yebBUaD25PuqsdVR/dtQh0PV2vZvAl0CJWpxwl1aOTC+oRiEbimXDqWbPrScnrJbGaQdQ3U4N2Mk9ieQ/Q53YtNUmIU4sQh+sZHrw1FbvaoLqCJNsQ69Y2VLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=FZn1cz7S; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so6954975eec.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1777998113; x=1778602913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AV/YmfGA78g8SATWPQgqplca6ENgzk/z9se3dsK0CGU=;
        b=FZn1cz7SvlGEETLWUcGy+QBY1LRaOujalecHshojAwoL2v5m+RKUrBUWRX1ZAMa0vo
         yk1lHtLNEmEVw8RjVuct+co/TuMyAkkzDKl12AH6wQSto+kUHuzk6XuBCp4oPFmOZsIt
         EO19/kJ1LT6dzPC9OZmcfZVL8W5ks3Hv5Khmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777998113; x=1778602913;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AV/YmfGA78g8SATWPQgqplca6ENgzk/z9se3dsK0CGU=;
        b=NIBs892wfYr6kVCJ+gd5A1PPAVsJh//oaz2l+fSy0YDKBWLk/eY+y7OtYRpeDurs2V
         ciNazg8K0I64mXe7AyjPFF2rCVpT0HWoPBNDPlojnSX0eYHuU6EVjWD1o6U+fjnS9xHW
         qkFMPLqV2GfcBFe1OOcEbTmbeTCxNsoHzD+u4ArqT3DJ86d9FWdkiH3HEgPLxGTFdrR2
         WY+qtEkD3LQNfwKJGa7mglVvtKRh9hZDDJCKt2GG2nYoiCPGU9WhSrolRkoG6Uh4N5x9
         zpkuDjNCAFXo8wF5BTdr5xbIWCc0XDmtphWXmb54gyhlBKIp7/GTbMdm8jCc5NS4nDDU
         avGA==
X-Forwarded-Encrypted: i=1; AFNElJ+Cvl+rgr12FZHuxWNgPFhgBsjB1twlNjm26Z6TIkyf7Tzp9mLEh3eMq7ZmzgqoiKag3bVisH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDrO24XSeyEg282DbbJMMkndlHG77fqammn+OdP3p6szizHwrH
	1F/Q9sTcObMdX8bQOMCMxrrdAkwYSIj3fx6pANhZua4GvdhI+8n7nBFsNUveqJSCQQY=
X-Gm-Gg: AeBDiev7KeLwU8aVeFBUcGdGVL0g/tkhIeuXi1ETWwcwkw+yxoTbgbh36dU4Z8SGUCo
	Jv1AqPEh7Kb/fucKeLxkIGWXBAsgN26zK30zkpIoKHLIB7jKIZph4+u5uXfoRb1jTxmwkpkxV8J
	27paq8tS6KVrzlF3R3LNmYiLuXYSB+6O6jA7UP/g9LY3LuKqdyxQxA0yfLG4n25LKMq2d64ERtF
	gckmAZ9+1whX0P+giEd/1cUrn+I2c+0pxq4Zx/to5hl+ml/rn5Wai5Uzm4SeGjEH0InjQ6Fevgl
	x627O1kmk5EH9MQT7aDGY1DWdWlTegaWgfg7Vg3biGpsc+jT5zQZnSQ/rxJ+intZ2ETkuwLwjbX
	giJkLOohJ0P490OLi/fTK30ndrUrJl9U8h0GPS6TioSU2lT7fZjrH1qFbv2nkIBapKnNbLaTpVf
	yTNL7ntE0IxGF5x8+tNhXmd4UXbMoj6Q15449onl/dUzlsSuATen5RcTB11Pa9f8WMZREsSM5f3
	mdlnsJjEA6qCCGU55L8xI40rdWrnID8r1qfoCmSk7lL4hGWmsSbbXykRTmpmsdMaSmonWbOsrM1
	/c7Ju1eNCZp4/sw=
X-Received: by 2002:a05:7301:3d06:b0:2c1:7793:7bbb with SMTP id 5a478bee46e88-2f409cb094fmr1796691eec.27.1777998113220;
        Tue, 05 May 2026 09:21:53 -0700 (PDT)
Received: from [10.10.10.191] ([184.3.231.126])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b2casm21012701eec.14.2026.05.05.09.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 09:21:52 -0700 (PDT)
From: Kris Bahnsen <kris@embeddedts.com>
X-Google-Original-From: Kris Bahnsen <kris@embeddedTS.com>
Message-ID: <c49600c3-a78d-4d74-82bd-7f95328388a5@embeddedTS.com>
Date: Tue, 5 May 2026 09:21:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org,
 Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260430173739.3843425-1-kris@embeddedTS.com>
 <aflcL6y_ugHV5p8s@google.com>
Content-Language: en-US
In-Reply-To: <aflcL6y_ugHV5p8s@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 91F8B4D12D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[embeddedts.com,none];
	R_DKIM_ALLOW(-0.20)[embeddedts.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244214-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[embeddedts.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kris@embeddedts.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Dmitry,

On 5/4/26 8:01 PM, Dmitry Torokhov wrote:
> Hi Kris,
> 
> On Thu, Apr 30, 2026 at 05:37:38PM +0000, Kris Bahnsen wrote:
>> The workaround for XPT2046 clears the command register, giving the
>> touchscreen controller a NOP. The change incorrectly re-uses the
>> req->scratch variable which is used as rx_buf for xfer[5], so by
>> the time xfer[6] occurs, the contents of req->scratch may not be
>> 0. It was found that the touchscreen controller can end up in
>> a completely unresponsive state due to it being given a command
>> the driver does not expect.
>>
>> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
>> transmit all 0 bits and use the scratch variable for the rx_buf for
>> both the 1 byte command to and 2 byte response from the controller.
>>
>> This change was tested on real TSC2046 and ADS7843 controllers,
>> but not the XPT2046 the workaround was originally created for.
>> Confirming that the original modification to clear the command
>> register does not impact either real controller.
>>
>> Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Mark Featherston <mark@embeddedTS.com>
>> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
>> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
>> ---
>>
>> V1 -> V2: Don't use rx_buf when clearing command reg
>> V2 -> V3: Modify original 2 xfer command to eliminate dev_err()
>>           output on xfer with len and NULL buffers
>>
>>  drivers/input/touchscreen/ads7846.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>> index 4b39f7212d35c..488bcc8393293 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -403,8 +403,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
>>  	spi_message_add_tail(&req->xfer[5], &req->msg);
>>  
>>  	/* clear the command register */
>> -	req->scratch = 0;
>> -	req->xfer[6].tx_buf = &req->scratch;
>> +	req->xfer[6].rx_buf = &req->scratch;
> 
> Sashiko (I believe correctly) pointed out that by doing this "scratch"
> is now write only and this may cause DMA from the device stomp on
> message status and other unrelated data that shares the same cacheline
> with scracth. While it was already a problem before now it is even more
> likely.
> 
> Since scratch is now write-only I believe moving it below "sample"
> forces it into separate cacheline and fixes this problem. Could you
> please try making this change?

Apologies, I'm not quite certain I understand what you mean by
"moving it below sample." Do you mean relocating the xfer[6] block
immediately below the xfer[3] block like so? If yes, I can get this
tested and a v4 patch together. If not, can you please clarify?


diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4b39f7212d35..6d57865ff505 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -390,6 +390,11 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
        req->xfer[3].len = 2;
        spi_message_add_tail(&req->xfer[3], &req->msg);
 
+       /* clear the command register */
+       req->xfer[6].rx_buf = &req->scratch;
+       req->xfer[6].len = 1;
+       spi_message_add_tail(&req->xfer[6], &req->msg);
+
        /* REVISIT:  take a few more samples, and compare ... */
 
        /* converter in low power mode & enable PENIRQ */
@@ -402,12 +407,6 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
        req->xfer[5].len = 2;
        spi_message_add_tail(&req->xfer[5], &req->msg);
 
-       /* clear the command register */
-       req->scratch = 0;
-       req->xfer[6].tx_buf = &req->scratch;
-       req->xfer[6].len = 1;
-       spi_message_add_tail(&req->xfer[6], &req->msg);
-
        req->xfer[7].rx_buf = &req->scratch;
        req->xfer[7].len = 2;
        CS_CHANGE(req->xfer[7]);

> 
> Thanks.
> 

-- 
Kris Bahnsen
Software Engineer
embeddedTS


