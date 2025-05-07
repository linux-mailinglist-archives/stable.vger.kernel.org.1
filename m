Return-Path: <stable+bounces-142083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFE4AAE3ED
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 17:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA4D1C03990
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5B228A405;
	Wed,  7 May 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ix9Caeri"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5610014A639
	for <stable@vger.kernel.org>; Wed,  7 May 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630575; cv=none; b=cY0Y0fuRB7/i4A/EAd65jKaU68z9/T2l9VJhxZQ+XyFEyabQLb/Fy1/Ace7Kn0I+OW2KWDrdHVWf3kB9KpyyyDhGfEncfKYbqIJu3hTPDKSuBK7Z1RzPLxEoF5gcpVgCxxl2STpNY73MOs9IJEZzBg1eAF2yWp+/84/q/gmzQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630575; c=relaxed/simple;
	bh=rGwdD2sL/1x9KvXY/1Ekk6DKMc0m0UXZv2Ekf1BRjnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lf0tWVALor5jDar2PG1gwQ61bkgtaOjPtIrqjFTjQwVLtO8C48fjNSOtqCAPB4rx1ZUAYq+gFA21Fcb0yhDRf4cFW2iXvrbzcr0eMBwK6rrSq5P2m6kDLjEPOs/9djIQrIaNsHWKQNYgJWzeZXc+AAsveXoPkILarmgBfPXon/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ix9Caeri; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ede096d73so43345725e9.2
        for <stable@vger.kernel.org>; Wed, 07 May 2025 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746630570; x=1747235370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnGxO/UH5ZtoslCnotoWi6A0EHXwJ/OCE7nrpX3PLMY=;
        b=Ix9CaeriSAx19CJBPP6Jzx4tLiQ/f0K6bJWuJ1/35K96Gij1Eu2F9xtHSHMlk36vKQ
         GbZovms3ag/1WgKXTP/PMl4ktqPLekLPk711syDUf5IZDrYLMlitu7o4LCH9q5QhgLkD
         SLHQbHtEY/Q8kr9yhA1n66oz1y7URjFEIeMc2oebaE3imddo+d1AxbQLZ6SnYIq90cBZ
         bnCOVlT9zsDJSnoTz5GRZH4ZSKly9GsF2ZWca51/+BsMBVc39XmhlTeWNFIC+Wpe6147
         IxfAmWFIrxWiTKzYEFxiVhRG53kxHE19Hd4GMM+78gt2piVg+PB6sqHGvdxMuImV3Lcn
         KEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746630570; x=1747235370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnGxO/UH5ZtoslCnotoWi6A0EHXwJ/OCE7nrpX3PLMY=;
        b=DAJo62S+aci1wrsxDjFbHXCNzjU0o/uvpAYru3hXeDYLJn5oLHvYdU4+XYza2mUi6F
         JEdgz5QKdQmHBV0gVYB0lUz4qzWhM7U8aq2x0wRnAHTyYX98FZPK3djwo8YocJiQagby
         kMCgEKRpJIa6DdTtlIYk/vaIPC4FvYa4fQvHu3fEcspMoh0hKCe0gUhP1PytLnLSqAOM
         NZOrprQHbN///6duVxZsuWFcO5oHhAgw7omxjX6zMLbehXwYjuYYo1CIK3U8ZEkSgQ8M
         TdYyc/RSPpOklToJWmvVs2hnR+4vj59R+hXR83mn1z9PwlWzui4/40XJbiVFYuMY8jVR
         v2nw==
X-Forwarded-Encrypted: i=1; AJvYcCUeRBaavkX3D6puJOjxisCCG0FTYvjNETbhGq6SoXwZBpXUjWLme3uxJSZ36j6YgayRmO8iLYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXTWuie40goDNjETHrNvs2DQKt5nfj28xZxfnsZ2CUBCIYErNT
	ua9aBPA5SrasXq97crzHCHlaO7Q+jxggnjKn5vjeGyuNcN78XYGhNIdwgTwqnqM=
X-Gm-Gg: ASbGncsrmQxpX8oFpFM6PiACl6yZ34utGQZW54TZuSGvA0zJgMRT8ZraJK7e1fR6BR8
	DqtJC0L8TEcXd0pYF5Jn4YztZVShHZdMATApZBHiKkg9oNuzJlvF0yqb4CTZOl4ZA+KQGV314vh
	MDkUgKETmBg0V67WxMA3kOGpQA3hmvCfYRffQPpeiJA8U/nwkl6v9mTrmSklWthKHZbQgEQpDCn
	iV0l3JJnrOXBO1hUTaBTx9Ks9GeREIGrkF64oKOEiGuTV0pIx15h+wahlSiDkONQoczxRYYiS74
	BecISsoSZPoRdL/FXXutXE3Z5SU6YMPSMoNdSRwq8Rw6YhSVnuARcml7hmPVlUu64I6D9cvspKE
	SiGuSaA==
X-Google-Smtp-Source: AGHT+IFdOXDNLQbnntxisuU2JZEe9tB63IzkZJVxK0ls3MwqsOC6APZxiRH/YqCeXjmchonVq6rCWA==
X-Received: by 2002:a05:600c:1f1b:b0:43c:f597:d589 with SMTP id 5b1f17b1804b1-441d44e07bbmr32485765e9.27.1746630569703;
        Wed, 07 May 2025 08:09:29 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b1702dsm16875169f8f.88.2025.05.07.08.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 08:09:29 -0700 (PDT)
Message-ID: <bcc8251a-3bad-4eaa-8dc8-cc63619a6365@linaro.org>
Date: Wed, 7 May 2025 16:09:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/25] media: iris: Avoid updating frame size to
 firmware during reconfig
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org
References: <20250507-video-iris-hevc-vp9-v4-0-58db3660ac61@quicinc.com>
 <20250507-video-iris-hevc-vp9-v4-3-58db3660ac61@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250507-video-iris-hevc-vp9-v4-3-58db3660ac61@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/05/2025 08:39, Dikshita Agarwal wrote:
> During reconfig, the firmware sends the resolution aligned to 8 bytes.
> If the driver sends the same resolution back to the firmware the resolution
> will be aligned to 16 bytes not 8.
> 
> The alignment mismatch would then subsequently cause the firmware to
> send another redundant sequence change event.
> 
> Fix this by not setting the resolution property during reconfig.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3a19d7b9e08b ("media: iris: implement set properties to firmware during streamon")
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

