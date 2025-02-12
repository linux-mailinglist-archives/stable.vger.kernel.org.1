Return-Path: <stable+bounces-114976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D923A31A6E
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 01:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61ADD18842DC
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 00:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1C2259C;
	Wed, 12 Feb 2025 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMoxpFTI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C347B665
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319842; cv=none; b=dWliBsFwAceUIYloOFKy/bocvtdGCSHkrv/a8EkuCYDp8XUXEyoJOdV+HlS0gs92YrisT7FYNcjmNz3i33kUtUoyBq8nJB51LmupZnHJ1ZTOQgDiM25w5fI026qcT/Z3iaWbZzooioUlC3i+wrE8LeOWZO3H/YJuAOGGbMdqQS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319842; c=relaxed/simple;
	bh=MMNIfstKpT3Xv+vjrM+xLax3j160hMjGDMFsgx2aZZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKlwq7g9YpnkGSmyGUhDpujTZrqP5WaUvll8DLEeXYuIeDpNqOKbT3e4iOBDJyHfdB77uXA8MVytAzdh8O5yhsteUizRyrTiJoaF8twwgEcaAvvTZOxDRL5yDZH9bWz48JQ/HZhDuDwWvAK+ICEOFxdnNucmY62ZazOTOqvHlHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WMoxpFTI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38dcae0d6dcso2734988f8f.1
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 16:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739319839; x=1739924639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfGDmNVScHcIIXsQGynSfUjulJw6pyhwlJ38vLwzZWk=;
        b=WMoxpFTIr73AN2BB4dxNfqAYPuDXPgwIoKsUoQlE7yqaKEcwWyYWw6QSFK7DKwc3ub
         pnoa5I/kJUxdjrSj13jEfJrrE8eDbryizcfhPjsplswbje5dA4G+ShvRo2vf2tIz5DQq
         tMQRyE4iibPNhyQygG3cINM+ynyvrhSvvaKgkh9s7NHmyJyYDmKXQBMLcUjB+cgajm3X
         sLCO4J1mR2rmgC/bGWK9sxYTbtfI872QFEUbEC37096AeqCYe3Y5SNjvbjlymOmp+GGL
         IAebTvxfG7qppsOO9i/CmEbH5xvlld44vsJ6ai8lHoyRCBO/JO2y/7uGAeOtBt51GxvS
         ziMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319839; x=1739924639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfGDmNVScHcIIXsQGynSfUjulJw6pyhwlJ38vLwzZWk=;
        b=m4PMy1UTR1FNT9fKXTdgigI3wZ2QwJLY65xWNwLI75cZ7ywkfWaqsrPcqNa+pnt89b
         +hAisiqmcgwn6FFNVss6Dzu2UVzoFgtmdDLtwXV64HnlcWh+tuV1LmeZlWYpK0RUrevN
         WnQVSNlume5WTSdmX1IqvXG2qWq/+qgfKJw1L+jqvEmsur8xYSrsGrCSWiHEPlh1+YNx
         p02ZOOxkfGNxfAFkUsPPgBvAwhkVCrjwuPWq7nU+luj/X5H7kCX4b963Fc6/55gTa9JX
         qYkAQFH6tOdFDw8QwlzrfHqB/BUqvVFddfJglp57dLzkLtarrJ6wpYBOTMTeichqkY4p
         b6kg==
X-Forwarded-Encrypted: i=1; AJvYcCXVKUl2x9g0e1Sx4KXvt1KrF29Jsgr1Wv80oQqFBaOk48yVFiipTuPQu2fdUub2Y1r1whCVCRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy+1d/+j+XLKGG/FIMfsI6IOUCSlkzOmjKlH/J07town64bhgW
	EZIvHGEealFFy2H3N+6oxOwtLNeRaPmGR4noNVo3vzWfbs9+nRmGWZYq1ryXDPw=
X-Gm-Gg: ASbGncunkGuIo8QD7LmrxedoOhp/x1lplQtHJjqcHTg+i90gI65yhV6TVEAH6STQD4u
	ylrMF/ESHJiGEoZ2fDnvyhyjhOiHu8R3nPkn4I9MdUdS2SdH7Oi3vwl6BCKO1mGi4SKYk5TkPwJ
	V5eDwrBsbS1W23NGMGAiLYdpTH5/tVb7RCuDQ8A43kO0NA/LZqzTYweZWIWs+bYlEQhZutCo6fK
	ZVKO0vF/zY3XBsg0aORw0kvggzH0GU/LiNAMcYJm2x0XGW+uyJrGJQUZogYYZMK6FX839+GK0dP
	1fsFa6Egtzr0e78kGdmZP0Ouac7m9tAubKZKXf8dpB3i0gabPvn+W6sSUw==
X-Google-Smtp-Source: AGHT+IFu89sJVtv0ICMn6U0AgL7LBis+tuWkq5wW4VledUbDa+V9LIa1AQ9mV/LDKZLoabTxS2lvoA==
X-Received: by 2002:a5d:5f50:0:b0:38d:cbc2:29c3 with SMTP id ffacd0b85a97d-38dea28d03bmr739530f8f.33.1739319838684;
        Tue, 11 Feb 2025 16:23:58 -0800 (PST)
Received: from [192.168.0.156] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcf35b15bsm12517006f8f.64.2025.02.11.16.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 16:23:58 -0800 (PST)
Message-ID: <8d05999a-b623-4a3e-b611-3f917cb46b82@linaro.org>
Date: Wed, 12 Feb 2025 00:23:56 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Venus driver fixes to avoid possible OOB accesses
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Tomasz Figa
 <tfiga@chromium.org>, Hans Verkuil <hans.verkuil@cisco.com>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250207-venus_oob_2-v4-0-522da0b68b22@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250207-venus_oob_2-v4-0-522da0b68b22@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2025 08:24, Vikash Garodia wrote:
> This series primarily adds check at relevant places in venus driver
> where there are possible OOB accesses due to unexpected payload from
> venus firmware. The patches describes the specific OOB possibility.
> 
> Please review and share your feedback.
> 
> Validated on sc7180(v4), rb5(v6) and db410c(v1).
> 
> Changes in v4:
> - fix an uninitialize variable(media ci)
> - Link to v3: https://lore.kernel.org/r/20250128-venus_oob_2-v3-0-0144ecee68d8@quicinc.com
> 
> Changes in v3:
> - update the packet parsing logic in hfi_parser. The utility parsing api
>    now returns the size of data parsed, accordingly the parser adjust the
>    remaining bytes, taking care of OOB scenario as well (Bryan)
> - Link to v2:
>    https://lore.kernel.org/r/20241128-venus_oob_2-v2-0-483ae0a464b8@quicinc.com
> 
> Changes in v2:
> - init_codec to always update with latest payload from firmware
>    (Dmitry/Bryan)
> - Rewrite the logic of packet parsing to consider payload size for
>    different packet type (Bryan)
> - Consider reading sfr data till available space (Dmitry)
> - Add reviewed-by tags
> - Link to v1:
>    https://lore.kernel.org/all/20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com/
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
> Vikash Garodia (4):
>        media: venus: hfi_parser: add check to avoid out of bound access
>        media: venus: hfi_parser: refactor hfi packet parsing logic
>        media: venus: hfi: add check to handle incorrect queue size
>        media: venus: hfi: add a check to handle OOB in sfr region
> 
>   drivers/media/platform/qcom/venus/hfi_parser.c | 96 +++++++++++++++++++-------
>   drivers/media/platform/qcom/venus/hfi_venus.c  | 15 +++-
>   2 files changed, 83 insertions(+), 28 deletions(-)
> ---
> base-commit: c7ccf3683ac9746b263b0502255f5ce47f64fe0a
> change-id: 20241115-venus_oob_2-21708239176a
> 
> Best regards,

I think this series is ready for merge.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

