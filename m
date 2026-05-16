Return-Path: <stable+bounces-248987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFkJBr9CCGpNgwMAu9opvQ
	(envelope-from <stable+bounces-248987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 12:11:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAE055B0EE
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 12:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE63E3010BB9
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 10:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9373D3CF3;
	Sat, 16 May 2026 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="BAX+a1Sf"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CDA405C46;
	Sat, 16 May 2026 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778926255; cv=none; b=lO9XjxdmouSMNvzxfWEHTBeNPr/4fYleHVinPoUrvNZ07uYOQed8j33TbleS+P1Dwh4gYBROR6RXJmBRAZbaDydVrhWKcp499RJS9l/xHDv98Qdfbx1cjJyRUvofm/QoTIXBTcSw9m2XMfVEySzCDW+GtK7t+Y9o+i6+BZ7MLEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778926255; c=relaxed/simple;
	bh=7wnIojVr9TnHw4xpU/gYsVgLqdfgCzoKF9H5UJo6j5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUCzAaCb8jiGKb4hDoaBJReAbKNZL+HzqnjpXqkBihIT4x6YTZ/0qYxWHiP5s/Hnvm/bkHVUh6yl1AmY5WEw1b7KotMGC6bTjFO7CJRRi3USkewpMnqbv/4kCpWMeJxKGmm8uieyInnI+WsloIf77XXpN0VYdZrrCO/hZ1E/OEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=BAX+a1Sf; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gHfw46fCXz496p;
	Sat, 16 May 2026 12:10:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778926244;
	bh=7wnIojVr9TnHw4xpU/gYsVgLqdfgCzoKF9H5UJo6j5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BAX+a1SfTKx3a1vzc8L9QrNEJS2H9gS7LwNO+kNkeqFecNpBuJtO/CJVJH9pxNy2r
	 mTzIGs+LaL6EIpi8w82IrFjXgpYCD9SG7GdgCg1E7+p5MKDcAMK1BwTdDwU8hsQ5Tk
	 ZbYFukW3z7MVPhnxvW7b2ZnqfbDwnRePFttJCMEfbpRjHPXxxFg5KFPaOFxCw3tZ1u
	 1ms6sgpPb0HcNtF+0rWFRjrQvFso9JJ9U8UWbZ7ys9iTOMeZWj1atUt/JhLS/t5cmU
	 EP/ngtCstv8Nm1GA3MFsTDqVFvRbbq/YBbEnuOXz5HV3XwZv5WvvEBAXXTS45ODvjB
	 7ZOtpJhmRq7Qg==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gHfw45vFPz7xLx;
	Sat, 16 May 2026 12:10:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gHfw34fwhz8tYs;
	Sat, 16 May 2026 12:10:43 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 7382261829;
	Sat, 16 May 2026 12:10:42 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <999d967b-331c-468b-b5ab-1ed7d35c8b05@leemhuis.info>
Date: Sat, 16 May 2026 12:10:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "nfc: nxp-nci: remove interrupt trigger type"
To: David Heidelberg <david@ixit.cz>, Carl Lee <carl.lee@amd.com>
Cc: oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, brgl@kernel.org, Sasha Levin <sashal@kernel.org>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Jakub Kicinski <kuba@kernel.org>, Mark Pearson <mpearson@squebb.ca>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260511082611.12721-1-bartosz.golaszewski@oss.qualcomm.com>
 <366cef36-d3cb-485f-a71a-dea347e8531b@ixit.cz>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <366cef36-d3cb-485f-a71a-dea347e8531b@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177892624304.87246.771635449133262671@mxe9fb.netcup.net>
X-NC-CID: 7j6E55DFeOfLwJGzrUYjF8WQnCdzICCgtv9X2CperLqHSIg89bY=
X-Rspamd-Queue-Id: 6AAE055B0EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-248987-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[leemhuis.info];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,amd.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/15/26 21:28, David Heidelberg wrote:
>
> do you see any better solution than just reverting it? In case no, I'll
> accept the revert.

FWIW, Mark hit the issue as well on a few Lenovo machines and prefers
reverting, too:
https://lore.kernel.org/all/c1f80da1-9bf8-41c3-b645-3ae95e116add@app.fastmail.com/

> On 11/05/2026 10:26, Bartosz Golaszewski wrote:
>> This commit causes an infinite interrupt storm on Lenovo T14s (at least
>> the AMD Ryzen 7 variant)

Side note: wondering if it would be wise to specific the generation of
the T14s, but I guess it won't make much of a difference. Adding a
link/closes tag to above thread would be nice, too.

Ciao, Thorsten

>> which requires blacklisting of this driver.
>> Neither firmware updates nor the proposed solution[1] seem to help. This
>> reverts the change due to an unfixed regression. The problem is present
>> since v6.19.6 stable kernel.
>>
>> [1] https://lore.kernel.org/all/20260311-nfc-nxp-nci-i2c-restore-irq-
>> trigger-fallback-v1-1-9e20714411d7@amd.com/
>>
>> Cc: stable@vger.kernel.org # v6.19, v7.0
>> Fixes: 941270962861 ("nfc: nxp-nci: remove interrupt trigger type")
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> ---
>>   drivers/nfc/nxp-nci/i2c.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
>> index b3d34433bd14..e99e1f381028 100644
>> --- a/drivers/nfc/nxp-nci/i2c.c
>> +++ b/drivers/nfc/nxp-nci/i2c.c
>> @@ -305,7 +305,7 @@ static int nxp_nci_i2c_probe(struct i2c_client
>> *client)
>>         r = request_threaded_irq(client->irq, NULL,
>>                    nxp_nci_i2c_irq_thread_fn,
>> -                 IRQF_ONESHOT,
>> +                 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>>                    NXP_NCI_I2C_DRIVER_NAME, phy);
>>       if (r < 0)
>>           nfc_err(&client->dev, "Unable to register IRQ handler\n");
> 


