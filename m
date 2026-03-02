Return-Path: <stable+bounces-222727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNHKL6gFpmkzJAAAu9opvQ
	(envelope-from <stable+bounces-222727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 22:48:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 427D21E40E0
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 22:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EA6C34AA8AE
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 21:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033D83A4502;
	Mon,  2 Mar 2026 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BbEOyWiL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F523A331C
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485719; cv=none; b=ZCavqxuIdZ2P5XfFQgoAEKVo3Gmd9q8tEjQ+9/7Y2agoIWSEtRwRZ3JScVX8HTaW71qFsZqPBS45YcLKoo4odUFh+IfjMYsbWdh1i+WCElPaI6Fzq4ycH74iEVNWuKxm7c/QhsdYLJol9UPhS5mGyQI0OtscmOod4oFlazhUy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485719; c=relaxed/simple;
	bh=ysqoOf9ZbQhxBgmZKS87lN56YFBpubtILCQz9oFd870=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTW592PEq6RVocZ3K64l+Nt+gAHbizO97oC09iPJD1TjcobQ4tRpSlWFw3JBK8zAfA/sgv9IhO1MOMYFhLph51tRtSTLvYwoBdyvTZuln+IfL+rPOdHNALD2dI0dMYCWwD03a/9uqieBqVnjYzBPHTxZ/S42Uvmo2OcUk7r8tQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BbEOyWiL; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40ee196dd78so80697fac.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 13:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772485717; x=1773090517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygs76HGOCOFE6AYrjp/vjGX4ajg9/UeAQcATp86xukg=;
        b=BbEOyWiL9SXlmWDMeMM5M+soTjtWRORY/y6PFxBR8mAbyTdowDrltBKFMoPmkiuk/W
         jvy/LH5imbkFNhPwx1RajehBEbVtqjERQT4ekeq4Bv/+MqR8mPDJ9ozhzAytxNnWxlas
         6by3TdtcLfbfmBJ6VQfCDIsr5XMAavFGnyzcjeh477Wa1fPtKp2VnUCsl9bm92npKYki
         AMy7XLHaWcPphN9JeIQATtBmlna9l64iLqNccb0XSNqJhdb3XTHki3hASlybup9u1xAd
         Zm2GdEKhycX6fH+dnaGRB32KIIqgyuSSLSuOld8OI8lj8QfKjUixFV6PX1dFjcJBU+3B
         zyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772485717; x=1773090517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygs76HGOCOFE6AYrjp/vjGX4ajg9/UeAQcATp86xukg=;
        b=PmNfn4IxwVOfwqlI0ka/0r/5SCbCzJ/UF5fnwDVf/GfkKRQJK6Yzrcq6ETZkw4lK0w
         dKG72xsHeLtcEnBLAIomsb5mxr0xgd9nbeNumSx7eHmmzoRYKXjosvBjnva/Dx7zZe/t
         LmCeAykgrWALOjVLQ3zni9fOxHBvpEtwbhKvE49IXE+nBBNC/DWdVZStna9N0NVqhnm1
         XQhZ+Lf4qADx0M2s9LTh6P0fD9OnPGD9myCxBVqx0Xk1KUReB3oPhJr0gIecipGgIhmB
         KgerID+ZDrEQzJ3fVkYPV5WBXNltaljqEzIM4q5sGEdDK5fFV645232RZDRXpKL/4urC
         etyw==
X-Gm-Message-State: AOJu0YykmPBdtnSUw99qC/MJTfrXRGZHqPLZduZkoNABJXWAeI/Wm3SS
	7aJSB9xjVtadWKgQYYeo1YSZBpMQKg/wrQ8eEsJyYc5PNp73INcW0kRaNc9h7hlV/7M=
X-Gm-Gg: ATEYQzwJKZRYogOBeJZqJ+Xy7/Vr3FzWCRqWqwIzA2N5v1N+XaqzwRWEB7SMfsWfWXx
	tcEoCfdnSSm3+iDoZPzO4dP3xhSE9NXiQAXh6cEfHGCCqlnbrea2C05USM78+KoMtyvMsV16XEb
	pJj7g2Sf1qgva1z3pisgp+GC6C7mDX7vb1sWDtb/lv3HCsq0xeo+rkkmUwu5Ji19hRXNeJO2ZTX
	/ilmbD9TJBHMsMmxpCxLpNLROLZzfydSo+ZzdSv9BnBHVgfFmy1tkj3Ore3341PSVaLVUIEMUaJ
	JI7Cz1+8Q82LAMjHZb1xa/LhG1HwbiZoMoQipNJ8kjVth0keLu1AkE5Qk/ko4a+NnXlHA163Qhx
	Y57nee9ZXbwih1++uj/2OrG2wC9fypcCLQgB3C5RNh1bQUYT378Zsqpszl6Em+DAs25XYldY89G
	je6dCmQDmnrdgAvoMgHcc1uZs7Q/yx8kthY5OMD5VyZFkcATiPBW/lbW8WTM7bXEDdefrTRd+I2
	od5uinXHF+0yv/7dmto
X-Received: by 2002:a05:6871:7c07:b0:404:1abd:9798 with SMTP id 586e51a60fabf-416277931b0mr8215565fac.11.1772485717267;
        Mon, 02 Mar 2026 13:08:37 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cff1aacsm12342960fac.9.2026.03.02.13.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 13:08:36 -0800 (PST)
Message-ID: <02f9fd38-8062-4000-9198-723b98036c29@kernel.dk>
Date: Mon, 2 Mar 2026 14:08:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "io_uring/filetable: clamp alloc_hint to the
 configured alloc range" failed to apply to 6.1-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, io-uring@vger.kernel.org
References: <20260301014717.1711200-1-sashal@kernel.org>
 <eb41b6f9-08f4-4972-99d4-3340571830bc@kernel.dk>
 <8e84b6c3-e62d-4aef-90b7-a7a0e63d8a17@kernel.dk> <aaX2F5LGPcqaDXum@laps>
 <531cfe07-2a07-4bd2-be07-9cd78890e04f@kernel.dk> <aaX6AzNtFQ32exUW@laps>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aaX6AzNtFQ32exUW@laps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 427D21E40E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-222727-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 1:58 PM, Sasha Levin wrote:
> On Mon, Mar 02, 2026 at 01:45:51PM -0700, Jens Axboe wrote:
>> On 3/2/26 1:41 PM, Sasha Levin wrote:
>>> On Mon, Mar 02, 2026 at 01:38:37PM -0700, Jens Axboe wrote:
>>>> On 3/1/26 6:15 AM, Jens Axboe wrote:
>>>>> On 2/28/26 6:47 PM, Sasha Levin wrote:
>>>>>> The patch below does not apply to the 6.1-stable tree.
>>>>>> If someone wants it applied there, or to any other stable or longterm
>>>>>> tree, then please email the backport, including the original git commit
>>>>>> id to <stable@vger.kernel.org>.
>>>>>
>>>>> And this one also picks cleanly into 6.1-stable. Not sure what is
>>>>> going on at your end?
>>>>
>>>> Are these and the other "FAILED" false positives getting applied or
>>>> not? I didn't hear anything back on any of them.
>>>
>>> Appologies for all of this. There's an explanation of what happened here:
>>> https://lore.kernel.org/all/aaWWE5uQqz_eG69i@laps/
>>>
>>> These should be part of the -rc2 I did earlier today.
>>
>> Gotcha, yeah it's not easy to know when you don't hear back, either
>> as a reply or as a new "added to stable" email. For those of us that
>> do take stable seriously, I 100% need to know if something is landing
>> or not.
> 
> You're right (and thanks for all the backports!). I had a plan to
> review all of these again after the release, but I should have sent
> something out first.

Sounds good, it was more of a note for the future, should something like
this happen again.

-- 
Jens Axboe

