Return-Path: <stable+bounces-152762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF66AADC59E
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 11:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C47C189385B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A489A290DBC;
	Tue, 17 Jun 2025 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RF8fAesh"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA32220F34
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150963; cv=none; b=TeW/i+w2W3gtKfwLhN6JrHievShg1RhhyRxuji3NH76IE++mH9rkAlyJRdMH+XMst+1MB2FKSh4COVnQR3+2tsVd2PPFYmKXMUi0qAZaMxhSK02HjVXN583rZihoXVO4+AG7abT0MizHrfbR17LlahbDY9PH/iJ15lN38gZYlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150963; c=relaxed/simple;
	bh=hZpp8NilOYk4lk2aLMATM3rJ4jK41OW6tkT22EaNR68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QF+Ri2jlulc9Ce2tKmXHLODFJciBVlPyFGqWw0/BMoGJAHS2ofhK3PskYqW54JTlJzsHDp1QSTnUkAHSRGGT9CGAonpN8ytJIUtqxseqAs0rl6zFu1yHxJ7v7NV26jSJsyRGRAp8eZ/9F6q+p6LaQZmwNW2EfV9AgXIus6NvHt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RF8fAesh; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553bcf41429so270048e87.3
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750150959; x=1750755759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p6FSyDeLV5tNzI8jmBk6dfrtvJpCsYW4RkOqJj3Og0s=;
        b=RF8fAeshrVI5aNgHBrI+v4jsYBHw1T9TD5djqPMGUlFm9/QOZIFOQsBrO2Yn0hX3Rl
         roiEWZIuHYWaCHMhuc63tY1pv7QaKRKspyOfCvs/XRavK0914EP2W3ngmawnWJitf9PH
         30kvNGLLToIcYLnzQVXR8Rgf1/Nse8O9ZnJIA/dxdfzHtj1T/9mlZU6A5ZydQdCs4eQF
         AXFxgEO3j4vOGd9utqYFz5N7Ci8+9d+OmEgP3n626UqRTba28hHEZvCtBquVP4dlLXHh
         niTU0CZ7vOiPlN29KE7H8PdX6ArvIUsVaQGbdJOyAZ9YAcjuS87uWp2JlI5hnG0XzblK
         kW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750150959; x=1750755759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6FSyDeLV5tNzI8jmBk6dfrtvJpCsYW4RkOqJj3Og0s=;
        b=oSRyNTvcocshW4hG5LyezDfYi8XbTWv7vB9ISDTQyVahbHaslEMxBoasoZ3A2pAEkB
         1bxdnDuaUOvNRokqQsf6QyWHxv5ULbrJ5xVITSVVLdo1OCHdDfllc4rTJz/1PK7XP8LK
         cz5AvDKhxJ7piWmkkieH7clpB0sZs2SdR+Q16xF3ejQCyABub5SpSt2JLADIhUv9cliI
         mJQzba2VGc0Fxor3gFzgdJblz0u6Zh7SoYb2LGUSGiUDO+zfHMYWdX0/8UmNSP4vXuIM
         PFacn2eIBNpJ+yR4HCkNjY5nsRqcDfp6/HIwGT/QaG9oqCn8Vv4WfbaQ/424AouvtXfk
         z/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWac3PVN6pSTWufPxSr98I5yClkskw9o+No+XBRzEv/vXAPKDBcgdXXmzxTBTdARAuNhtz/peU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3abe98UyHV/mg+M0D7Pq/QvewjlL36rXv4JgsF8vCVD182Nm
	+BO3jOcSwbIdMd8VUiggB64xn0HfuoUCt4DQ4JSm84G40rG/9TwRfppYsN5wKVa7S1I=
X-Gm-Gg: ASbGncuc4YrrgbDlHfNHsCtEV6/g/V9M2XXODCr9Gljrnfp0M3fdzYErwGnmjCDPyee
	k1frTWL8sg4IDbo6lEdoxd2Ka5ViFz9loBCayZyQxbp654ZV8gGCh1xV/8UeeUy21ytWfscgO8K
	6/9qZAGhQwfy6SInt6CWLRIhWh+ZcauOJgUnY9hE2FtpvM6w64QA8MRuImnpKN84lDFzEB9SLU7
	2/4OmIMbokfrMOdXSCYiT+8xkHaHp4yZoJR9Jo3n5l1jVxCsPSbDc3T2aV/wBZSaojzR3q0bj3e
	KxQsfMXj6qB41tLRxT5hR//zof/tKTA7wlOzQRqXTNwUQHH7yLOyLVsqGFGEraTr2kS35Dsed+C
	IU2mvIYKqYfjtZRQgT+cyX/MDmztms/HWizlrIGB+
X-Google-Smtp-Source: AGHT+IEv7meiVd5tMWXL+doCxvXY8Z6vYW1YGEvunNjM0gGLHZU0DJ0LcAS77/p7fgnwyjuHi+JcZw==
X-Received: by 2002:a05:6512:691:b0:553:2a11:9cce with SMTP id 2adb3069b0e04-553b6f4cc69mr1044756e87.14.1750150958516;
        Tue, 17 Jun 2025 02:02:38 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac120167sm1823733e87.20.2025.06.17.02.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:02:38 -0700 (PDT)
Message-ID: <3b2f1bba-6dde-4f7d-ad87-219306e37829@linaro.org>
Date: Tue, 17 Jun 2025 12:02:37 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: qcom: camss: csiphy-3ph: Fix inadvertent
 dropping of SDM660/SDM670 phy init
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Depeng Shao <quic_depengs@quicinc.com>,
 Hans Verkuil <hans.verkuil@cisco.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250612-linux-next-25-05-30-daily-reviews-v1-0-88ba033a9a03@linaro.org>
 <20250612-linux-next-25-05-30-daily-reviews-v1-1-88ba033a9a03@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20250612-linux-next-25-05-30-daily-reviews-v1-1-88ba033a9a03@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/25 11:07, Bryan O'Donoghue wrote:
> The moving of init sequence hook from gen2() to subdev_init() doesn't
> account for gen1 devices such as SDM660 and SDM670. The switch should find
> the right offset for gen2 PHYs only, not reject gen1. Remove the default
> error case to restore gen1 CSIPHY support.
> 
> Cc: stable@vger.kernel.org
> Fixes: fbce0ca24c3a ("media: qcom: camss: csiphy-3ph: Move CSIPHY variables to data field inside csiphy struct")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

