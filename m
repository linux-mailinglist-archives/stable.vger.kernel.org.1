Return-Path: <stable+bounces-211221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJA0BbUIcmmOagAAu9opvQ
	(envelope-from <stable+bounces-211221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 12:23:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBDE65EF1
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 12:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E074136AB7D
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 11:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77FC3A0B13;
	Thu, 22 Jan 2026 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="OnAPsgU3"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3F315D57;
	Thu, 22 Jan 2026 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080336; cv=none; b=evOVlkymsp/LAuOfcdrfdSkD3cUw+RrYJWoRjNc9BHXpMIv2aDnbzxeKZ6XhEw49ZX5W6z11OlMYkOvQdoSHnnwqpqov4ggWkv3sIWm4DXco8f2GuO2YKxTK/SLPJTDDZLLxh8UoAfZ+gGPmRWu5RPYEYK02HP6VDlyoAwxy22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080336; c=relaxed/simple;
	bh=hRXuCYHN7ovGIfo7rJT7PfMdc+cAUC02OO23HFnDmVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPyr1kIlToDUF9OHANjOpwqrloVYYj1GmY45gAZOaPeQb70tZL5ei6INGOw+cw3M210mvBN5mk7WkopW+HI9FbMXJZcKHHinX3JJpK4oSZvVFg3BbZFxpBo3VjwnmcjKDrSSKstf8izWNmwaD272e6fBFd5GnWn1ygfFYSI/cYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=OnAPsgU3; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7993010E062;
	Thu, 22 Jan 2026 12:12:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769080325;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=y3J50b0dbgAgqUxf1Y877OHDnXV/iiIJ6ak+93DtQsM=;
	b=OnAPsgU3G0RMGG8TtN+bGErxr6kVSz8xO3NVY5m6BVyFgzIHqKIKD3y+8VTyiw5gID8ofn
	HbTph4AVlffcXXeybYImBx/rQi1x5BnEr2U5lDL2rruFXWUUmMcZruoXDw+mQZDrDy+aF5
	gTcQL6NdzuFedrj5qOvGRxRJV/HyOJFIrSluQPSeDsdJQ08B5zFWAczhk5BAgT4VMlgTlx
	ATgxIE4vFeIHejUbZj0KzVzkuof2V9a3uXCdNuQ1dobz5fEBNPuwpfsGiGtpTvgsZoKpOP
	GNrt3iczYJyfruLz4ky4grXIuWlCBbyCBHrBJAyzJvgb6ECT1tlG5TWSy1iYbw==
Message-ID: <50626e29-4c86-4caf-8558-3f0288a8e22e@nabladev.com>
Date: Thu, 22 Jan 2026 12:11:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mfd: stpmic1: Attempt system shutdown twice in case
 PMIC is confused
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Pascal PAILLET-LME <p.paillet@st.com>, Paul Cercueil <paul@crapouillou.net>,
 Sean Nyekjaer <sean@geanix.com>, kernel@dh-electronics.com
References: <20260115173943.85764-1-marex@nabladev.com>
 <20260120171853.GH1354723@google.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260120171853.GH1354723@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nabladev.com,reject];
	TAGGED_FROM(0.00)[bounces-211221-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nabladev.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,nabladev.com:mid,nabladev.com:dkim]
X-Rspamd-Queue-Id: DCBDE65EF1
X-Rspamd-Action: no action

On 1/20/26 6:18 PM, Lee Jones wrote:

>> +++ b/drivers/mfd/stpmic1.c
>> @@ -121,9 +121,24 @@ static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
>>   static int stpmic1_power_off(struct sys_off_data *data)
>>   {
>>   	struct stpmic1 *ddata = data->cb_data;
>> -
>> -	regmap_update_bits(ddata->regmap, MAIN_CR,
>> -			   SOFTWARE_SWITCH_OFF, SOFTWARE_SWITCH_OFF);
>> +	int i, ret;
>> +
>> +	for (i = 0; i < 2; i++) {
> 
>    for (int retries = 0; retries < MAX_RETIRES; retries++)
> 
>> +		ret = regmap_update_bits(ddata->regmap, MAIN_CR, SOFTWARE_SWITCH_OFF,
>> +					 SOFTWARE_SWITCH_OFF);
>> +		if (!ret)
>> +			return NOTIFY_DONE;
>> +
>> +		/*
>> +		 * Attempt to shut down again, in case the first attempt failed.
>> +		 * The STPMIC1 might get confused and the first regmap_update_bits()
>> +		 * returns with -ETIMEDOUT / -110 . If that or similar transient
>> +		 * failure occurs, try to shut down again. If the second attempt
>> +		 * fails, there is some bigger problem, report it to user.
>> +		 */
>> +		if (i)
>> +			dev_err(ddata->dev, "Failed to access PMIC I2C bus (%d)\n", ret);
> 
> Users aren't going to care if this works on the first or second attempt.
> 
> I would only issue the error once we've given up.
> 
> No return error in the fail case?
> 
>    define NOTIFY_DONE             0x0000          /* Don't care */
> 
> Harsh!
That is the only option, because there may be additional shutdown 
notifiers and those should also be run.

The rest is fixed in V3.

