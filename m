Return-Path: <stable+bounces-238150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKylAie332lVYQAAu9opvQ
	(envelope-from <stable+bounces-238150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:04:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7254A406365
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFEAB30160E6
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64E327F75C;
	Wed, 15 Apr 2026 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TQGvhbpo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDDA31619B
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268920; cv=none; b=UQl4GL08VbkJYe9/k362pTkhW3Uyilnh6VVJjmVQNmk7ibNRt10P+wt7Vh4AVvKoxDWlSfe4w5odmkcPewldTuPPXKRkLtBQqmDK07a5QowRma0+ft+tQTM+oGEqSMOsZT52xaYHQEKyoLO4XXpeZWFEiObn/pS66nMItyRXlRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268920; c=relaxed/simple;
	bh=9OQwdJAaUqJEWEM4yhSQg/nq0hBQ795EFYvkQdzYMYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/mCozzexdOwURwzMl+rEpx66B5X08PYfP05noi1SrPbBoiXLCfsbhg83+F/3Bh7ictNVc3HqTo82EbPNZON4QzkVnI/DFB3SDHPyvEzRYGy8IfCjQTHDx4kkER6NMw9Pnzxfvf6V+ZZJIR0NdDNfVSAC6r1ygyIxDtPCzFhT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TQGvhbpo; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbdcb85067so5837921a34.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776268917; x=1776873717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D245EE3tu0Tw+g3J8OtImxCPrOp3WNwVc9jRN+bNI/w=;
        b=TQGvhbpo+iZh34S5ubWWgOD3k51t5b5dg4xXdHOrn0K8qR7WTthctxESrYg4JY9sce
         aKEl3dT9kOh88f6lF0yZIA1Dpml9UJXOO4Of2qhwkmkOMtvd9sayFeXwClPHXYb0qokA
         AxyDX8fARQ+FLekt4vWjtNnVy34PLZVpAfGdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776268917; x=1776873717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D245EE3tu0Tw+g3J8OtImxCPrOp3WNwVc9jRN+bNI/w=;
        b=CkA2WKGG5ybhOe6trpWxPUkQ0DRWayDe8Pngb42ni4xWVUrxSwfcbNXrswCsa5pXjd
         XqQVxNk0aKvWurGunaTwyjw2MPze9SaSRxBb/4o0se55uS02sqhhxG0FSGqMS9DvQInC
         U386pspSLoixZjUeJ0ia02fd2dPa+Nt5wK9PUVpBiHXXdrkuHAyoUtUE6ykjcp8z9sEn
         zRjBd1LMCxVYB7IlZus/FBVaeIfhwuISvfsEv710wrtIN7m8mWJGqJmczmGWXGMZ7tGK
         JoBYqgc8ltp2kKvbPs5uGPSmMVJqoLYwGmPeR4l/RYq5znFJurqZiejxaQgMmXajr76N
         8fKw==
X-Gm-Message-State: AOJu0YxvBuS/D0nsV1M0qtJP6zK7KKU1J5Al8Yx99i2Or+XPRnt/PB0v
	rKcMMxFwrRoyYn2NHyGNr2oxaX9QiRRryhUhGefcU84hImpc4XhKpTpOGmy5Gi4djZM=
X-Gm-Gg: AeBDiesIeRSOWf3g0QiRBrsGH2I58i8j2W/rXaT1jPWS5SUYwnBUlNFc6QTvszlmMPQ
	7D8nt2mb8Eec7FyRQfpUOKx6VrMnoLlyBqEkTS0/qSxQdGJJsPACd8y6KYBdXfoEarnqnnp4G23
	9/Gg7bfrYyyaxIn+hlXFI/GLrRR152+2fPFvjLnWrYUG3cRwbOSl+v605kESSbUSswhLUkyqy9m
	Ssx4WTHVjO8gZyzJ20cdM9AfsEoowcvmudc5ydGwqey3e6iS4SPtWaVG9lgLTp3r02RwNl9MLg9
	UaFVUa8kd/WC0EUTCLVD8Njp8TwzNhh9mqDyGZBMWg5iusqP+LVQdMVf8zVSYxX01RPr+kSIYF1
	jRpTjS/pjICZlY7lcPs4KkchLjyF1lmxyfNwj1dh7FBfM3XXWO5cjJjKxwoAgBYXiJO4AC2o3xY
	OEoy2RO31Rln7xahyhPz4nY09PGYMWqYY=
X-Received: by 2002:a05:6808:23d6:b0:475:be2f:e1d1 with SMTP id 5614622812f47-4789f20ff8amr11366587b6e.39.1776268913811;
        Wed, 15 Apr 2026 09:01:53 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4797a235f6bsm1063781b6e.4.2026.04.15.09.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 09:01:52 -0700 (PDT)
Message-ID: <75275f6e-8314-4dd6-a54e-95320c2224e2@linuxfoundation.org>
Date: Wed, 15 Apr 2026 10:01:51 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: vimc: fix reference leak on failed device
 registration
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260415154537.3451732-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260415154537.3451732-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-238150-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ideasonboard.com,kernel.org,collabora.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 7254A406365
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/26 09:45, Guangshuo Li wrote:
> When platform_device_register() fails in vimc_init(), the embedded
> struct device in vimc_pdev has already been initialized by
> device_initialize(), but the failure path returns the error without
> dropping the device reference for the current platform device:
> 
>    vimc_init()
>      -> platform_device_register(&vimc_pdev)
>         -> device_initialize(&vimc_pdev.dev)
>         -> setup_pdev_dma_masks(&vimc_pdev)
>         -> platform_device_add(&vimc_pdev)
> 
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() before returning the error.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.

Can you share your manual review?

Can other static analysis tools for example scripts/coccinelle support
your findings?

> 
> Fixes: 4babf057c143f ("media: vimc: allocate vimc_device dynamically")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/media/test-drivers/vimc/vimc-core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/test-drivers/vimc/vimc-core.c b/drivers/media/test-drivers/vimc/vimc-core.c
> index 15167e127461..fee0c7a09c4f 100644
> --- a/drivers/media/test-drivers/vimc/vimc-core.c
> +++ b/drivers/media/test-drivers/vimc/vimc-core.c
> @@ -421,6 +421,7 @@ static int __init vimc_init(void)
>   	if (ret) {
>   		dev_err(&vimc_pdev.dev,
>   			"platform device registration failed (err=%d)\n", ret);
> +		platform_device_put(&vimc_pdev);

Where does platform_device_get() happen when platform_device_register() fails?

thanks,
-- Shuah

