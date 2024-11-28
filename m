Return-Path: <stable+bounces-95729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5199E9DBA88
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 16:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A5D1622D4
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D71BCA19;
	Thu, 28 Nov 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkUF91ZK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFBC1B85E1
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807996; cv=none; b=hV02mZ4aloBF36Mnjw8LxM1wcK8CLuw/1/K12iRySY9ZDYIUNG+1GwEsg4iAtO1RR1ir3dkYnPw0lwjKleyw5EAi7b1HB77lzo6x1yBLr6Nry/WcmBaXT9VH6Jx3VfLfLPwL3xwrUOKVUNJ6vRSW2K1bnqAwRpwbTtCqYX50yf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807996; c=relaxed/simple;
	bh=dx3goeI8+PmUxdVOKxTaj371TsZOSoYSr4uocxe6Z8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSU4W1heTYBe4v4gP5gjrgeHsXHWB0ILh4ai2w3HrBWNq1/5mzra+/s1UebIf6E5KJPmk5E8a44cmy/p49bppmS+zM73d3Ar4VfN9gznROM1eEEcOGRLwEc5WUAN5roNByZLixi++Syv/FXh5+yNOXeCBlWvT0o6nxDyvh2XbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LkUF91ZK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-382325b0508so486513f8f.3
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 07:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732807993; x=1733412793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b10DWlFGhowRIZrTbsC3lQ8oGfF6ijd4eqGNQhzz/3w=;
        b=LkUF91ZKeuFzUv5JTlDdnEcfthD2KjEJ1gExOnRfYGGBY9pcHNgz2ovMtF/XqwhDw6
         57yUVpE7HYdml7SHWtRW/ALP5h4EXZM5o6b7CQVx++GxrAZbVnnommoNrkVf7lvcqZrU
         gfZgVdvIdxIA9L+75Dnkgl9yU+9JXP+ttb3UPitb1tPx5CR0ogUzH4k5+yh6LmAWSXkR
         xpo1QuMZQ5AJ8SrH3YH05gmKQXrGJ+mN5oH6eDUR60lmV1S+8cGoIpTYXbNDELQCn4yi
         cfRb+ys6OgkJz3oeF8afeCwUHpBK1iJ3mSCvFag9GfWdM0m46MZGKlZ/w+ojaUcTbGk2
         cjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732807993; x=1733412793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b10DWlFGhowRIZrTbsC3lQ8oGfF6ijd4eqGNQhzz/3w=;
        b=Qu+coWC0uKXQzh1JyhZ+tkI6vBjcLzd0/x8Ah+9c3DriCwbZ/zNKrFZ2tln4oDUgdQ
         Bep+T4CrK5PHO8bd1wN2SS5TO5ieYYZR/ZmRl9sBLRtcpFhNRuDOT6ZmapP/iGd1Uv8L
         2bn+Ftp5jNozf6YytKFujt4DGzDM2gqv6+Gq0snVeO+ebJy/6j2+nG6mM7UbP808FC1c
         ygI0+89/36n7rTflhdxLi1yj/BbG9LAxydoVmskAO4M9xbMlVFkNLXwDkXoVqhjW7IXG
         Q84YDopGcJG/fRRykEpF2/rvkM60UvblmodlTttXj59C//j9m5kn3puzDNjjH5rJ/yCu
         +Fzg==
X-Forwarded-Encrypted: i=1; AJvYcCX688NDjruDqaidatyGjZwOPFIUijqdWqa7tGTWqH0AS2WmohVqZbrP+QMy75wiDako6x05epw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwNYzFvkJopyk4UyQ75Z7rjzPETnkdZcbIieJGwX/3Yddn4Rz+
	EczVKcTgr0LMofb/dY1Uw1aGJyl5SC0Yrs6+unW2NjN//26lpz8elkVRPld9nIU=
X-Gm-Gg: ASbGncuaImIne4nGNDiF0a3oi5/g9VWm9hWrGXRhHO/kQNElaMXEyAh9SCbTXeMV3wL
	ofuGR8fR/tZH+sbpGTNW7CI7qVfGJcSV/tdefnQOpCfumNK1xCMNudBgtwgpb+CUp1uqxnwMzbd
	brk1e0AUQnwbMIyVHr6TZjgFgMGnGmqAOpx2wID4NEG9V2U7p8EdyZumf6ONo7q8b4NLPx/Oeq1
	q0ZkN/lxvH/OPV6u7BmbFP0VDz8i24cq4pY8kEnHmYTyoUccuz/2M3ATTmfb7k=
X-Google-Smtp-Source: AGHT+IHhe6rWMKeZvorX4t+eGWKL0ZIgBhqqLgt6DS02uIjaCP6eA7/zHMLPK/b/0LdU32MW3mQTLw==
X-Received: by 2002:a05:6000:4818:b0:382:5af:e990 with SMTP id ffacd0b85a97d-385c6ee221amr6272363f8f.49.1732807993306;
        Thu, 28 Nov 2024 07:33:13 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a4bbsm1923305f8f.48.2024.11.28.07.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 07:33:12 -0800 (PST)
Message-ID: <0d74695a-b28b-4cc6-884d-6756f58f8be4@linaro.org>
Date: Thu, 28 Nov 2024 15:33:11 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] media: venus: hfi_parser: add check to avoid out
 of bound access
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Tomasz Figa
 <tfiga@chromium.org>, Hans Verkuil <hans.verkuil@cisco.com>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241128-venus_oob_2-v2-0-483ae0a464b8@quicinc.com>
 <20241128-venus_oob_2-v2-1-483ae0a464b8@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241128-venus_oob_2-v2-1-483ae0a464b8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/11/2024 05:05, Vikash Garodia wrote:
> There is a possibility that init_codecs is invoked multiple times during
> manipulated payload from video firmware. In such case, if codecs_count
> can get incremented to value more than MAX_CODEC_NUM, there can be OOB
> access. Reset the count so that it always starts from beginning.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>   drivers/media/platform/qcom/venus/hfi_parser.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
> index 3df241dc3a118bcdeb2c28a6ffdb907b644d5653..1cc17f3dc8948160ea6c3015d2c03e475b8aa29e 100644
> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
> @@ -17,6 +17,7 @@ typedef void (*func)(struct hfi_plat_caps *cap, const void *data,
>   static void init_codecs(struct venus_core *core)
>   {
>   	struct hfi_plat_caps *caps = core->caps, *cap;
> +	core->codecs_count = 0;
>   	unsigned long bit;
>   
>   	if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) > MAX_CODEC_NUM)
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

