Return-Path: <stable+bounces-105302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9999F7CC1
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 15:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA0716617B
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C79224B04;
	Thu, 19 Dec 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L57pPNhy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F377D38FAD
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734616993; cv=none; b=G9xri3L1tfLVxsdPvXEuILivRHMzhOTmuPJVXH6D7NawjaQVJ9L3G6hW6At1eW6Bn+/DHOuSyz2clbxYDOlzDCVVNNXhC5iEFfdB5EM3YKnVx02+S9vsvx0bA3gMcs/yR9Jj/+6FCDFgckSp6MqUfupouDKYydpSUgL/GL1TN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734616993; c=relaxed/simple;
	bh=yiGRUJwjsQCL3G6F2nEr7hcrvA4M3eBm6meSLftaLs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHyD9U4vPZa9/FAVURtvvlMHqnb5y4ZN3IOkXScIp66GSCliFj+O2Rgu99kwpoxgieY6Q5e3Pn/KqoI2kgr1pT3+zcHqOXPhF1ntoRlDgjPc2ZjIcgYotCVN6AsK68qYYVyuCS96JLNe3jsry1lkvJV1Bnm3fxDNoaA+2aPHtQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L57pPNhy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso9221975e9.2
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 06:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734616990; x=1735221790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXZUFqb9xwB8UfFG6y2CJGv6YTLp395j5ATjgKVbSgA=;
        b=L57pPNhyTkysZvRLILU1WXE8fDXilFGR3UJ32EqwLDqqQkrTnS3nw9E1WZI+JAn/tU
         +508f4KzxmjcFZWRWJFRb5xtRemjIzryZtAQQeirRYQ6mR998nFm4aklnNWg66PUmP4V
         /0WvROL/pNBSDZCxHr6lPMoUOfc8/68ZcIZwv841RA1ioPOzJS0Q6oMKfoJBn9OXD7dj
         70v3zNxO/qvdvlxafD3s/g7hdI7GaCepDj6pMulAMrrMuqD5erKUQJzFJp5/ICIEZheU
         9ri96ADGXrefzLaZfQIWxOtkAiPVMvpXkYJrAsC/yqoVOhe8b7pxO3ECXwaFb0kaynT7
         JPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734616990; x=1735221790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXZUFqb9xwB8UfFG6y2CJGv6YTLp395j5ATjgKVbSgA=;
        b=N+Hm5BOUBwuiOzpa1iC9YYz3qBH7BDulnZRlannm10ZxUu+dbllw54uVx9VUmZWlw3
         h5T+A9GttXqE1r/v1p5zTUexXGgIkLn4zFDYGI57HocpnR44fPDdmkxOGj88MP8eZaWy
         Ise3Zd2q3e5Rxl9WckjY5YmRj2L12THsWXdKBeJSQAtjGXoc+WpN4bb9C6JJpZNDj5RD
         nNbA5bCQgw1WRSwbXYLZOjxElp6YSScdzfAL4XX8SJhVfZhk/5vrd4LUJAPWozVJ6rEh
         iBwcxjIXlirGA6YBCqCufudnxGBH9pooNMMHTCcvrgzChX7p1mqNPdLdAvrF0Q3hGXU5
         pZeg==
X-Forwarded-Encrypted: i=1; AJvYcCWZFPphC0ueDzuamfyRFjqgQPuaINazJon6NfI3lCrUsxU8DMzXKMZAaHF4SqvkF+h4WVUx2sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgo9QSXUHdmZRxch3Fd6B2Yf+FoEPjyHp5gQBQbghjNF2sUv0o
	yctcQRF/I0mop0SjinUTO5YV1Fq+JNgFm0FUbCMKI0hzAXdfYg8cKAknz2C2lrE=
X-Gm-Gg: ASbGncvfp1ZM4Flhw0TuA9RaxtClrSiZOage9xg9ER4fdcSUc4MBhdMwtbOBSXckqbh
	x4zoAxUn3SpzyuQXgrj5fp3o1w4mcorga1VBXJpbMi3hl69HegQxxbCp6ga1g0kSDNx5FK80GHQ
	9ym9oF0gzbR01+wN3U3+O3Xj0LCZdbMayQVvKM6OBTp4zBoGNYhubiJvddelYdGQ3vmsbUy9MqX
	Ynhm93WX7WiSqO03gcgtN8+g1rB6BSvBPtV/l+0AsEygCb+jxJg20dOxh3/JaFBBn6B3g==
X-Google-Smtp-Source: AGHT+IGyI95U2ui92gYhnr7jJ7oUrNU3MvE2Krm7vhzjpIBY07DCVjBZHmYYbmYJ3aag0N+d2GREMg==
X-Received: by 2002:a05:600c:1c16:b0:434:ff25:19a0 with SMTP id 5b1f17b1804b1-436553ea696mr62377185e9.21.1734616990116;
        Thu, 19 Dec 2024 06:03:10 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b2a4sm52532425e9.27.2024.12.19.06.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 06:03:09 -0800 (PST)
Message-ID: <1153ebfe-eb98-4b8c-8fd4-914e7a3e063b@linaro.org>
Date: Thu, 19 Dec 2024 14:03:08 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] media: venc: destroy hfi session after m2m_ctx release
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241219033345.559196-1-senozhatsky@chromium.org>
 <20241219053734.588145-1-senozhatsky@chromium.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241219053734.588145-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/12/2024 05:37, Sergey Senozhatsky wrote:
> This partially reverts commit that made hfi_session_destroy()
> the first step of vdec/venc close().  The reason being is a
> regression report when, supposedly, encode/decoder is closed
> with still active streaming (no ->stop_streaming() call before
> close()) and pending pkts, so isr_thread cannot find instance
> and fails to process those pending pkts.  This was the idea
> behind the original patch - make it impossible to use instance
> under destruction, because this is racy, but apparently there
> are uses cases that depend on that unsafe pattern.  Return to
> the old (unsafe) behaviour for the time being (until a better
> fix is found).
> 
> Fixes: 45b1a1b348ec ("media: venus: sync with threaded IRQ during inst destruction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>   drivers/media/platform/qcom/venus/core.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 2d27c5167246..807487a1f536 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -506,18 +506,14 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
>   void venus_close_common(struct venus_inst *inst)
>   {
>   	/*
> -	 * First, remove the inst from the ->instances list, so that
> -	 * to_instance() will return NULL.
> -	 */
> -	hfi_session_destroy(inst);
> -	/*
> -	 * Second, make sure we don't have IRQ/IRQ-thread currently running
> +	 * Make sure we don't have IRQ/IRQ-thread currently running
>   	 * or pending execution, which would race with the inst destruction.
>   	 */
>   	synchronize_irq(inst->core->irq);
>   
>   	v4l2_m2m_ctx_release(inst->m2m_ctx);
>   	v4l2_m2m_release(inst->m2m_dev);
> +	hfi_session_destroy(inst);
>   	v4l2_fh_del(&inst->fh);
>   	v4l2_fh_exit(&inst->fh);
>   	v4l2_ctrl_handler_free(&inst->ctrl_handler);

Two questions:

1: Will this revert re-instantiate the original bug @

commit 45b1a1b348ec178a599323f1ce7d7932aea8c6d4
Author: Sergey Senozhatsky <senozhatsky@chromium.org>
Date:   Sat Oct 26 01:56:42 2024 +0900

     media: venus: sync with threaded IRQ during inst destruction


2: Why not balanced out the ordering of calls by moving
    hfi_session_create() in vdec_open_common() ? to match
    the ordering in venus_close_common();

---
bod

