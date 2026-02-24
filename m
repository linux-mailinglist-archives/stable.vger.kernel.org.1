Return-Path: <stable+bounces-217913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPbPMyqgnWlrQwQAu9opvQ
	(envelope-from <stable+bounces-217913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:57:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 098491874D5
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E777B301617B
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF5539A806;
	Tue, 24 Feb 2026 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3AsRqnL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7707339A7F0
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937825; cv=none; b=G92CEueMVaqWV67RhXiJya6wZZWN8wz9ulCQKazCHoNIu3B43Rhmv7Xh5bX2MJpEjhZEncvVZFYTSqxf+g6TwiF4ID2irf/MmE+FZgT9fUe01ntKABsHB/Ti/1r8h4xMRVTnIySyofXBAvqnvhZkLOOZmpaaBPPCieu0XcdmwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937825; c=relaxed/simple;
	bh=cMsxTLX7mj6pDb8n0Mf1TuapNZXLi4VS8lS3vHRnAjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwIP31fRS3WvLDa/MnMFXVB+vP1gUOZHi8kVmRLpSXE4mwcJ775WNZLijV76VZmLsRIH4p3QY9YXdIQt+IHTYnSMz4Akk/gMcIA+3aeFr1jjgE0BhAnrT0hJcFplMSkqsTL/RmxRKdBjuKknRfVAoC/S9kYCOI839SvPTm/LC20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z3AsRqnL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-436e8758b91so3780068f8f.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 04:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771937823; x=1772542623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+4mGVj3G+psOD6BQM4z8xFWUBs0ualVLWXw/Lw/cGE=;
        b=z3AsRqnLxLYs5fN3g87J/g9lf+DVPFX0mvgmdvy5FP8/wwg4XJyWPK8cHHkZ7rKD3Z
         Z/6VUFpdla7FqxB66k4GF8uoFBNnfrVJyPhrheOzrFHqXPGWUCQfqrZyxjy3dEZhWrlj
         DcCsvQFHRNKQLKYhf0JwtH+IA28atLUDBm3UQs9FyxC28b7cvirooB9azd4NKrZe6c1G
         Wt6hvnBpibqrrWbZU+QHpjFezEXc+bfj0tis0auwG+U0xZzxtHNylWGcPoxTI2Nbxjpt
         Azvg5cqm8NIYaISWSyXNNZHxOVBFpWhTEDJy7G8ZJfzQMFRUq88cOUU1sRoXTVbVZaYD
         eTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771937823; x=1772542623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+4mGVj3G+psOD6BQM4z8xFWUBs0ualVLWXw/Lw/cGE=;
        b=xNiGhYPhBbfcX4DOfhaegeMKvKEC3P3lAecja7B8+Z60mH29iUtvseC7dRT9GHQcuO
         DAgvILAHeVF8xNka0wPA1ZMdzAx8kwh9YukCXxnU0KZ+nBSIcZw61vMagGm/NykIvCgz
         h5Sy5dmF98dbZT7330Q/X3azIk3pvMa40qNn1Pa4katT0cxMdQ2dKRVXPY1LQwOnJzsI
         atmihFI4GVG8md8VrNr3wydRD/6G5UiGzBX3nCozh7VxoP1s24z5DasA6mtXwRy75mfJ
         YElXRdqo3wUMfy06JPZ9IQn5YDw0/8gYDCXZ4FIrjq21nPdVIeexGMHoJ+HimU25loT6
         mj/Q==
X-Gm-Message-State: AOJu0Yw6NRQXJjVRV+CiS4XUbwT9wmrMakigQBWPeGDb16p5ATPu0Y1R
	9K3Kt1dC0zvec5UQypCi5+klkD3tR3EKbd1cVP+UUvvfgQkZhWavB1iYAOlABts1+3M=
X-Gm-Gg: ATEYQzwRroJA1O0zDKJcA1ohnUfqCESpM1EDrguKbM80igk9IUAnhqH/bPQzq7rX+d/
	KdR0RkNHeLHYODfRNV2WkAEUuj5JuFKNgqqfzgndFGnUGOln0L5mTx7NJRHYg9HtFDtkNtoRTYx
	GHIQF4DTB+2GuEQhx6PXz5OB91W5pRdXLoLe4h0/qziWuDMtl9/cyM67PWZ/FW8s9kdSUZza77d
	YpZg5v32uIrRO5Zc1N3yQ48YAhl+SZYtZB83lKBLZds2eLJHUn2IMpABVFHbsgWnR6jlK27ggDX
	hOHwEzQoPz5TEhTtvpNoEipZ5KBXWlR03RZWqxCgtU9Jh3X2JqPsh149HyYnoOl4hP16X1ik5ZO
	mqouygRLr5V34Z8o4Xi85BiZIbQ1FWMVbZsVEXsP0LMiKPDv4Ed+0hRN0fU2PCmm0p/aB+ZvJzu
	8fxcZghopOxpAVyt1I9AUXqG+azjVvq7z6
X-Received: by 2002:a05:6000:230b:b0:437:71cc:a246 with SMTP id ffacd0b85a97d-4396f153cd2mr24591474f8f.10.1771937822763;
        Tue, 24 Feb 2026 04:57:02 -0800 (PST)
Received: from [10.11.12.108] ([79.115.63.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4bf89sm25284611f8f.29.2026.02.24.04.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 04:57:02 -0800 (PST)
Message-ID: <b083e950-f54a-44aa-b587-eec2cc10460b@linaro.org>
Date: Tue, 24 Feb 2026 14:57:01 +0200
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
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260224104203.42950-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-217913-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 098491874D5
X-Rspamd-Action: no action

Hi Krzysztof,

On 2/24/26 12:42 PM, Krzysztof Kozlowski wrote:
> All the functions operating on the 'handle' pointer are claiming it is a
> pointer to const thus they should not modify the handle.  In fact that's
> a false statement, because first thing these functions do is drop the
> cast to const with container_of:
> 
>   struct acpm_info *acpm = handle_to_acpm_info(handle);
> 
> And with such cast the handle is easily writable with simple:
> 
>   acpm->handle.ops.pmic_ops.read_reg = NULL;
>> The code is not correct logically, either, because functions like
> acpm_get_by_node() and acpm_handle_put() are meant to modify the handle
> reference counting, thus they must modify the handle.  Modification here

You are right that casting away const via container_of to modify the
parent's reference count is incorrect, so dropping the const from the
handle argument makes sense.

However, to address the underlying issue of the operations being
writable (e.g., acpm->handle.ops.pmic_ops.read_reg = NULL), I think we
should also decouple the ops from the handle struct and keep them strictly
constant in .rodata.

How about we apply your fix for the signatures, and I follow up with
(or we include) a patch to do the following:

struct acpm_handle {
        const struct acpm_ops *ops; // Changed from embedded struct to pointer
};

static const struct acpm_ops exynos_acpm_driver_ops = {
        .dvfs_ops = {
                .set_rate = acpm_dvfs_set_rate,
                .get_rate = acpm_dvfs_get_rate,
        },
        .pmic_ops = {
                .read_reg = acpm_pmic_read_reg,
                .write_reg = acpm_pmic_write_reg,
                // ... other ops
        },
};

and in probe:
acpm->handle.ops = &exynos_acpm_driver_ops;

This way, the handle safely reflects the mutability of its container,
but our function pointers remain fully protected.

Cheers,
ta

