Return-Path: <stable+bounces-219628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHb5IeYAn2lAYgQAu9opvQ
	(envelope-from <stable+bounces-219628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:02:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D55AB1987A4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA3AB307B7E5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2903B960A;
	Wed, 25 Feb 2026 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCtwohfE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6E7081E
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772028048; cv=none; b=WnQH+/Nhci3ijBbIdEIF0CvHW4YcQP3j/IEBcs7lc4qU2eCprfAfd59siXTIgEUTJcelMAB+XYEwCZPq1lsg1Pj5gqWfA7cNTA3dIDp7OIBERcz2eVgOAdI7EFZ7Otz3TuxT77lF9GzlmkRAKqcHS7AvKXwjx3A/zuJERLdI0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772028048; c=relaxed/simple;
	bh=oXWq7ZKppyOqoUwMd00YgZ68r0g8MU/hDohRVD2+w2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YU0Hr2OrctHL/Pj6ej/gVoLXSOU+0kTE19e1gbgD40pwGH9/DGc1XOC/YV5ujEOZG0hERGEUOoXksT0t+Xjk9bcAgGV40GHKtGmMmgUdJczu+Gc+YBWQZ5FgREGUZgkCGtmmetkJi39YCU46qo/ZmMPQiMqErlQ/h//qpZp6mSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PCtwohfE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-480706554beso79690115e9.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 06:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772028046; x=1772632846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v83nX06CFNonzs3aaey88JZD1iHRYlh5Rsz4acoeN6I=;
        b=PCtwohfEdvCchQQCABCeY8lYDYrQzUvCap6M+pc/f5Xtd8yZ8XPRj658kB7HPnXrIg
         9l0uQfwKzEcMxwg4BKHWVjDH1x3+xNZh3LUXMjYvLR/6bE4cEFl1rUkLd1jpSTXReB19
         qmGazQrohP3AuHigkoudW4hJN48GmSKbc2Vk5ADAIzoPbMw26+KnkYJtiB/I6GyM9gnq
         JeWyJ9/Vlp+AKXr9MpcfhTnRWq1mPbkXFnDAvcpBZb1mfCzPr65HdkhO+kugQDm1rNNg
         YsVt/zqT2WC9rOPDz5TyP9IGMpGUTrpR6mGOp439w93duG/xsPpkJp+8ISrsTcFy5oKE
         CgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772028046; x=1772632846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v83nX06CFNonzs3aaey88JZD1iHRYlh5Rsz4acoeN6I=;
        b=v34QYswDg132u/yKzwZPbWaQVRjaidPky5gn6H4R+GbF3ZOMf8anj1zNplod3Fgv8r
         sP4qtsx4Em7cR+CoGsQ4ROMxEWmmh+iqxBA0kIG9ylYXyNQHprhnwrYmUNKHrPpyUtr+
         miHoc+qGaA3j5tuUiOTEc22HHRiyxZoja7U0WOOcyhTWnbfiusXxeLs+uPVik/IhcSKU
         wSOEGrQz7bggJmiOZcslVfQqV9iJWiV2+ZnXQtxhjK7oIM2EGBsx22tS0vkWVSDlUTyt
         f2e4fvRu5klwROFBYKCXidj8E6w0NfqOFuAle9/1zSFarhfRvslOD6dcMN+WsMxu37sh
         Pc9Q==
X-Gm-Message-State: AOJu0YyfBySj60QLC8EeX/tuyD56S1v18iNh1BG0bS0VcbRaUuwQDE2v
	adsY99V16R1z9SAuU0iMM4kMfQuD+9gLIeIp8SU8C34HEitOrMS82UrFUltCha4MAiR6A29M5xO
	pnFiutus=
X-Gm-Gg: ATEYQzzMKEIKigpSGLcM3Wc4tRhiOErkmd554Kgp9Lf/GFof/Ft5TVaXdUjEZB894YP
	kH03Eakx3Pb9R3WtWh9eLX+vAuzLyTWeppD1hSMPQP7GMFvNXFWv0OeJl7s/BTurCcYxnZzwJFx
	lZqwLzA98QninjqY2s/xSMYN46w+P1HGYB34D1Bid/77rCfZgx8OJE9Do+swDfCxoCw48lc47VU
	tvFpg68TpCL/H5CMbUH4ORN0p4ZMXcG/HtVdvjE0DxUVOd/S+8ct79aws2lh6bBdVeqCbwVtTsM
	Fid7rEPuSoltJZqAHro5WJjLMPWL/f81Ia1ePr18bMVkoBsDIhUw1foZI39vlIOm8U0/k04RrwF
	Dh2b9HOaycJZ99xy1y0ueuOpdgxc0v9Zzd4SRktoE2ikmByOxig7HYWbNS1bZJlqrEpNFcH8QmY
	xXV8OvZL1DefEJk8OttG3ivDZGhNObrZiH
X-Received: by 2002:a05:600c:3e1b:b0:483:703e:4ad9 with SMTP id 5b1f17b1804b1-483c219b659mr8852985e9.19.1772028045947;
        Wed, 25 Feb 2026 06:00:45 -0800 (PST)
Received: from [10.11.12.108] ([79.115.63.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c09897sm35367670f8f.17.2026.02.25.06.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 06:00:45 -0800 (PST)
Message-ID: <279baf9e-ef05-4217-9357-94d21bd93978@linaro.org>
Date: Wed, 25 Feb 2026 16:00:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: exynos-acpm: Drop fake 'const' on handle
 pointer
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
References: <20260224104203.42950-2-krzysztof.kozlowski@oss.qualcomm.com>
 <b083e950-f54a-44aa-b587-eec2cc10460b@linaro.org>
 <3e5001a6-ea3c-4304-8db3-bbe616eb4015@oss.qualcomm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <3e5001a6-ea3c-4304-8db3-bbe616eb4015@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-219628-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D55AB1987A4
X-Rspamd-Action: no action



On 2/25/26 12:48 PM, Krzysztof Kozlowski wrote:
> On 24/02/2026 13:57, Tudor Ambarus wrote:
>> Hi Krzysztof,
>>
>> On 2/24/26 12:42 PM, Krzysztof Kozlowski wrote:
>>> All the functions operating on the 'handle' pointer are claiming it is a
>>> pointer to const thus they should not modify the handle.  In fact that's
>>> a false statement, because first thing these functions do is drop the
>>> cast to const with container_of:
>>>
>>>   struct acpm_info *acpm = handle_to_acpm_info(handle);
>>>
>>> And with such cast the handle is easily writable with simple:
>>>
>>>   acpm->handle.ops.pmic_ops.read_reg = NULL;
>>>> The code is not correct logically, either, because functions like
>>> acpm_get_by_node() and acpm_handle_put() are meant to modify the handle
>>> reference counting, thus they must modify the handle.  Modification here
>>
>> You are right that casting away const via container_of to modify the
>> parent's reference count is incorrect, so dropping the const from the
>> handle argument makes sense.
>>
>> However, to address the underlying issue of the operations being
>> writable (e.g., acpm->handle.ops.pmic_ops.read_reg = NULL), I think we
>> should also decouple the ops from the handle struct and keep them strictly
>> constant in .rodata.
>>
>> How about we apply your fix for the signatures, and I follow up with
>> (or we include) a patch to do the following:
>>
>> struct acpm_handle {
>>         const struct acpm_ops *ops; // Changed from embedded struct to pointer
>> };
>>
>> static const struct acpm_ops exynos_acpm_driver_ops = {
>>         .dvfs_ops = {
>>                 .set_rate = acpm_dvfs_set_rate,
>>                 .get_rate = acpm_dvfs_get_rate,
>>         },
>>         .pmic_ops = {
>>                 .read_reg = acpm_pmic_read_reg,
>>                 .write_reg = acpm_pmic_write_reg,
>>                 // ... other ops
>>         },
>> };
>>
>> and in probe:
>> acpm->handle.ops = &exynos_acpm_driver_ops;
>>
>> This way, the handle safely reflects the mutability of its container,
>> but our function pointers remain fully protected.
> 
> Yes, this makes sense.
> 

Will you come with a follow up patch or do you want me to ACK this and do
the follow up patch myself? Both options are fine by mine.

Thanks!
ta

