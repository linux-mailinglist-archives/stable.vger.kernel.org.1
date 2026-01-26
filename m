Return-Path: <stable+bounces-211560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBErHg9id2n8eQEAu9opvQ
	(envelope-from <stable+bounces-211560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:46:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEF4886DF
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A0AA303A243
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA733358C7;
	Mon, 26 Jan 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlZJipkJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D9531195A
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431299; cv=none; b=oDBGSCYW35iotz6N9rZEwq3ipALYeE5Ry0wD1p/OrDit8gpoAJ7TwrrMuqmyFNUu0n3F8GkoxQu8+CgtFWiB8WBnHvPKjG09kfhpc7s+FspU8XvuJqbClrIznzrKRWVESII+4tKNpSOmbgCEDlRpEgCKSbcdohZYkudLc7fD+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431299; c=relaxed/simple;
	bh=TtDt5bqLhmfPeg66JCoa1PxY2VKZg9bpDjYbry2EG2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ureZZQ4L3dolIoOk7K3HpB1BRCzmpEtKzMSA22Yf6AlalHv7YWzQqV0nF0m8AtB3WYkcz3oMzoM9+4Tv18Bf59lI92q/3wfQ/YHj+MrxTNZ6KCaMVAKa+G0NcoIK01k6+NGHmMz9qVMZRsa4ICesbYOFCPAkrH95w9+3eYkp+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlZJipkJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4359a16a400so4065335f8f.1
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 04:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769431296; x=1770036096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGkVRtj39ec/cXScWV7OP3CGW3GGq8UKBj+5Z3odKBc=;
        b=SlZJipkJOIN7WVWSGD5fHuWFZAifuaOysuN5g773D6hG1DU0cya6ZfxrgcMLAdEOdR
         OGDR04S7AcXVMtInN52FwLQCOYC5Q3Fd//qb94eMQqhuM1MFm+hsKP1t5FhYbS61dnp0
         onsEkNyK3GXBsg8RyD5gK18856sKU5OCqctTVFb4hX0gyVAU6na8F6tERNgN93+Q96vc
         T0UNWBAs5ZozIa/9dkuewGDyGtPXRjg/b82zsaNLeaA3Ilnuhb3qtnsp4F8hl3lTr2Ut
         hcbm2dCPh1OHMgFhhK71WdJhNHFadMAxL2Yv5fyjlWrCXySRRC7jeWv13rz8Zn7dD+u8
         BtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769431296; x=1770036096;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGkVRtj39ec/cXScWV7OP3CGW3GGq8UKBj+5Z3odKBc=;
        b=vg0WXeettOr2ey7R4LnM9aphQ16nMAFMowB9zqJwfIARvDij9ldo0P0rfpHOY1Lo2D
         hTVMrgTM6l6a+UFD5kGyQZOFPo3oImggDUAxmyb4l01937ng9wCNNuFuYINPPqH/1vAs
         PUrqL1SHj7JD8DuJm0kR2OWPQJS887GibXdulyGSOsSXmy4f1Z+4aCD9vUMQPxGLH+lU
         62W+peiOVOMpRr+FAPSR/tpd/UbBoR/OLdt6sWZWuBxRgeIqLQs+ORy2TQrM1bMVGj1v
         X7kkB89aYbKD+QhO/XK4OWPCqfwGGq4gDxb0OevxMermOK8fr/i3xSEfAr9ps0g9v1es
         vIHg==
X-Forwarded-Encrypted: i=1; AJvYcCXNSG6mVNgUr9djA4hST9Rxf+Ip7f4NoIO7YBvinTZWTGGaWz2zYwJLq8FQhv3kD6hj5xLCy3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiwd6pmS6v26xkEX+MF4ri3ZGjnd0IvUs31LjWufutgqdq2Qa1
	nzguAZOvoO+b9hbMJiu6J8bFz4ed2Rryr51CdLPY9/QoI+KVSCyar1J+Je3ZgC2sHX4=
X-Gm-Gg: AZuq6aJHDEKVo3cvp1rBWKTL31yTCV+6UNu8LhkACDmfxQzNY/6IiEPGQpk9DK2DOjw
	oYKsZ0g7XORNTeppXJlk14RCVmtf1n6xucyTSN+WnU1Vzk1MOpbauAsQ21XqU7JaXj7TWXF9vaN
	ndlbUOcvB5LTUQHkzrOiKA/Imlw1hwbDXAx/hX01uOCJeZ1OwbfUVCTgX5BFsQSDYYfYmjQiAi3
	TynGyW2XdD35nke2u+F3s3iPSh1+sVg4jf1eNKU/D04i6Wzaw9sMMpez/5VU2BH0uX5y8eagQLL
	7thUI9N3FBbgKn14Dw94j44iAbN0JbEZX7m76X7FC+kDXvjXecLgLXbEGioRxFbSik+3Vl4ZwKk
	RSjiIPzK0lXwc4BEuKhxxE2DjnxZDHAz7IcdldDiYvJm8Sa4JsPKqqZ2UCEHzPGPz5GTSG4ogaD
	sN53wqlJmOwmhJ2c2SXmaPLlrasxWrij+Za1RdkA3cCw0i5SQJ1vxp
X-Received: by 2002:a5d:5349:0:b0:435:a600:2601 with SMTP id ffacd0b85a97d-435ca1201f2mr5525322f8f.16.1769431296323;
        Mon, 26 Jan 2026 04:41:36 -0800 (PST)
Received: from [192.168.0.40] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02dd4sm29593878f8f.5.2026.01.26.04.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 04:41:35 -0800 (PST)
Message-ID: <eaf30b60-c0fb-4cf5-bc37-274faa187734@linaro.org>
Date: Mon, 26 Jan 2026 12:41:34 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] media: i2c: ov02c10: Keep power on and use reset
 for power management
To: Saikiran B <bjsaikiran@gmail.com>, Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 rfoss@kernel.org, todor.too@gmail.com, vladimir.zapolskiy@linaro.org,
 hansg@kernel.org, sakari.ailus@linux.intel.com, mchehab@kernel.org,
 stable@vger.kernel.org
References: <20260125171745.484806-1-bjsaikiran@gmail.com>
 <20260126061528.63785-1-bjsaikiran@gmail.com>
 <20260126061528.63785-2-bjsaikiran@gmail.com>
 <ef6cf6c5-3b5d-45f2-af67-0567262a4561@linaro.org>
 <CAAFDt1spRkj7kySCa8P=jehQHbYVT2j+nxLira1vwYkiCJ7LDw@mail.gmail.com>
 <b699fcf5-5cb0-41eb-b9de-e5c6e98aefaa@linaro.org>
 <IlpLwcSSsQ89AZYFUkWtRcUkztg6PClgkVOyWG0StiDOUCE93t7KlF9q18JPi3GutJ1OQWj_2igjYq1OD8FLZg==@protonmail.internalid>
 <CAAFDt1tjiEXbuChcY73+NYxPW=rB83P4Bks1TPGsHTTqoSzOuw@mail.gmail.com>
 <ed1421d9-f094-4306-ae6d-e07b3a72f82b@kernel.org>
 <CAAFDt1ukAdXwADuFVoZrs6Ay2fB_sq6LMW5FCnsjqUL7V62mfg@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <CAAFDt1ukAdXwADuFVoZrs6Ay2fB_sq6LMW5FCnsjqUL7V62mfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linaro.org,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211560-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan.odonoghue@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: 0DEF4886DF
X-Rspamd-Action: no action

On 26/01/2026 12:24, Saikiran B wrote:
> Yes, I implemented your suggested sequence in power_on():
> 
> Assert XSHUTDOWN (Reset GPIO = 1)

+5 milliseconds

> Enable Regulators
> Enable Clock
> Wait 2ms+
> Release XSHUTDOWN (Reset GPIO = 0)
> 
> Even with this sequence, the brownout prevents detection if the
> off-time was ~2.3s (I got this 2.3s number by conducting extensive
> stress tests on the platform starting from 50ms to 3s. At 2.3s the
> success rate was 100%. Anything below 2.3s, the sensor entered a
> brownout state atleast once.)
> 
> Thanks & Regards,
> Saikiran

?

---
bod

