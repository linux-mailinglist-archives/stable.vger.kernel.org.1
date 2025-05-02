Return-Path: <stable+bounces-139470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3842BAA71B8
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 14:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4154A4AFA
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854E4252914;
	Fri,  2 May 2025 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qu+snUZf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F4241667
	for <stable@vger.kernel.org>; Fri,  2 May 2025 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188835; cv=none; b=ahnHGt2rlVOaBKdmPNp7vq7VjngHE1N11RVWnseJQBqZMUABfVoyArcpV539DrDjyLZgzbMm/6mfiBxaNj0yMMA6tb0VFSpYaTvWVl8v22P+lZNfpX06tw5NiU6ViK+r6ARjb7b+BUPSZcJDOhyhyILOtWc2vxxxRRFaObi8y00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188835; c=relaxed/simple;
	bh=4j0ke6M74LzeHhABdWPG4BsNF7G/ublzVqyQ3s3Ax4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Af/AV9i6b2q6vP+obVYROr/tqqJxeUeXWYsk9EhIO18FabHRJupAY4cuzSIjbTb7CzfAewlhKLkOzqZxFcNiPRDg4c87nxO+ZSyxPQCwpEbk2oOQJbsEeNmFWCMxNpSsgjr7IatIqY3AVmOjyZppB+QJN1NSfAq8UB7cKRnxLAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qu+snUZf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf680d351so16345015e9.0
        for <stable@vger.kernel.org>; Fri, 02 May 2025 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746188832; x=1746793632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiq8j9Pd47tWgmGC+T98j/M88SapfZV3x181EBl9QGk=;
        b=Qu+snUZfbjtoVHbcYIQkh66FZYcCBl7m5EF3ECu929XCegVlhLstjeSVuXsnOSmYPu
         uK3OrOwh9X1eM9ft7gxS+vycMgMzSh/yRCFtydnKZNhlCYg9GjpU+W0fJtmadP6ri8lY
         TX+XpboqoObN+oLy9oMPr/E0kjSbSh1l3ILCcVUCS0BBP1q3/2Ftsk042J6+LvdC/Stw
         jRUEbok951xF3NkH1LZ1vPc53qli4lt5pHLGAI9cKK/thS2W7PE4d7bBG6CL1HOE8uKt
         41bb76B8KJXkL03ezEXzv+/BxblbOxKjXTlTc/8J/qK5Rmw8JAoSGzrrpUCaX9BVgrDW
         13/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746188832; x=1746793632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiq8j9Pd47tWgmGC+T98j/M88SapfZV3x181EBl9QGk=;
        b=QGg1PkT9/qIhLmtTYI39mHUDPPnVRGrwh34P7mTVr6fAHI7z7Oqn86dPZiicaivNMn
         cc+/p7WMBTB8d0A46zptnYNIXIc35WY9N7FZeQ87dTM8wwpOcGp2JMRspCknHudR2DAN
         h+WFws690qK+szw+hlbxZCBT74AejwtgoOsdVeDmwllkgTCJ6+VTWMoKjzb2nGIJgj/P
         +trrR8csDXUaqgdwapR4zXiDXkgLgR4pmTkii1/R95Z8tdED3UPlhB54VPMyD60tKvKG
         7FpVefhGkycmUwBXYPhI6KljBxmZL6VOCLo3QVCmYbJEFUN4WgscxPQ0ZTrc5D2Q1vyi
         hqLA==
X-Forwarded-Encrypted: i=1; AJvYcCWwB271LEkjs4/mmqSun1fdp7hqgZfr87bJjitUKYb3t0s26Zm+dOYAtjk8v3+MyEV/oAk8Ahc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXWwfmOSidS7HR+DSxTJSjiETbuADaUX+fq8/p6CM32Hi1GLNj
	YPqM/rNoESzftI549lw94mXTYh68xOuqL2dQvjyXoPx9TxabguZvmcb9eOA/dGU=
X-Gm-Gg: ASbGncu0FhZo07UMo4ss/0m+CcbnvtVRdx5hXrZ+afY6CUVWU4xkeJjuDdXgaebFgOF
	ROzaGaE29b4XvDyJYeBacGJvQGcAsLlo+cQ/qKDIXY8laO5VtGswCkULazvqDFqn8kZqaoU0YKj
	AQsdldZkjT5BAm69WV0njxtgAWl7T8jLKCnsLMMud4e/hOEgAaY6xUiwySiUbq2FTlQoGSyFxrO
	l0n5hYhAetdcrD2mmD1d10lrgjNVck78VKcmd4rmZHvxBoMMjIxFbkn7co1Q/6yOeQq31XFiRob
	eanvXlxgXbHvuRtpx//t9aKDq3ZmrwrNFGDasbsdaTQ4lHijv+UVZWVNA5cFwyRB99mId0hrI5W
	OJjE4rw==
X-Google-Smtp-Source: AGHT+IGffAlOpctwFrMNNY2tP4nZNI3nScrTpOCK1t0L/nEK+69qoAbndAyafnHVDnbgh0OsuB9ujA==
X-Received: by 2002:a05:600c:15d3:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-441b72dc612mr34423725e9.12.1746188831814;
        Fri, 02 May 2025 05:27:11 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b17017sm2052074f8f.92.2025.05.02.05.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 05:27:11 -0700 (PDT)
Message-ID: <f9aacef3-eed2-4a0b-a543-b26342c4d3f1@linaro.org>
Date: Fri, 2 May 2025 13:27:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/23] media: iris: Remove deprecated property setting
 to firmware
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 20250417-topic-sm8x50-iris-v10-v7-0-f020cb1d0e98@linaro.org,
 20250424-qcs8300_iris-v5-0-f118f505c300@quicinc.com, stable@vger.kernel.org
References: <20250502-qcom-iris-hevc-vp9-v3-0-552158a10a7d@quicinc.com>
 <20250502-qcom-iris-hevc-vp9-v3-6-552158a10a7d@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250502-qcom-iris-hevc-vp9-v3-6-552158a10a7d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2025 20:13, Dikshita Agarwal wrote:
> HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER is deprecated and no longer
> supported on current firmware, remove setting the same to firmware.

What about older firmware - what's the effect there ?

> At the same time, remove the check for non-zero number of v4l2 controls
> as some SOC might not expose any capability which requires v4l2 control.

Please break up patches like this one patch removing your legacy 
functionality - assuming that makes sense another patch amending your 
non-zero number of v4l2 controls.

Generally any commit log or patch title that requires "do this and do 
that" should be broken up @ the and.

---
bod

