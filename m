Return-Path: <stable+bounces-109252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B473A13935
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 12:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8B21889A29
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FA51DE3CB;
	Thu, 16 Jan 2025 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmI+zVYM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74A1DE3D7
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027345; cv=none; b=YnpbUY65YQwdZEAds9EYaP7CVe/8tpgMqWZz6sWBKDFCg5T0LOS2PMGuaW0yK4O3RQRygJjO/guY+9JUdQlOQh3hpNHRGpb95vzBaL5xHROAAND9mnGpEnhPirMPU+krn8Dx9vXcNinX9yD0jzjQNlYq5etgZwLu7FNlc9hL14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027345; c=relaxed/simple;
	bh=4rScqGobGnb4mpIlFYLwvBzWFz/YxIvFcWlI5EGHYXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OutQWfW+h1bn9FI7bMMLB/SbapdQvvR29DG9CFZ7hBF3hZRBS0j+fbjtriuv8Jo290RMvTVTqrxd+WVsB+QLNJ23hnwlRu5QBTbIXG9OcuD9LQchDyMfnRAjPKnOlq60dGFrOMLOtMngZosRT7Ww8X9WtLk07iV/7TRrE1iJ41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZmI+zVYM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43618283d48so4726365e9.1
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 03:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737027341; x=1737632141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+IL0+GOfzEC4aeJWJbSxSpruqaLU6cR4sD7yZTPtTI=;
        b=ZmI+zVYM2cDreQMpPos69d4v7gpYC+D0SXHp0k2o/i9y/0cOU1pN7IazeIhxhw988C
         tfeD6FaH7GanmGMAmcorD7SJaoFy1fg3D06ZL1HScpfTDbTa3917UusxbjVvG8axVoqz
         7TZc+H4WtunoUGhCVRhamX4UM8BWlUOElzhx8BEVS+ergM/Q1/OaWNdDlunyDUQtNvL6
         fhaMopIxof1U7aCZeOH/UnF7RT7RO1FURbc9LRYQqVDU+7KE9rl7NEV8CpdbB1DwIHEQ
         IdNn+6XJZTvOpwPHQ331SFecW/FxJuVWhEiTVQnSEHce/sAMXvVdPo68hZefoVa7Qe+N
         yniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737027341; x=1737632141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+IL0+GOfzEC4aeJWJbSxSpruqaLU6cR4sD7yZTPtTI=;
        b=ppRmtMrUvmBERcj7PU/HKojI7uW0aE8ZS9zMLMK1zVCYu8abjbz/u0FgSqxRbTTbMi
         w+hndOnWsBeBOERK83+mCKzqWazv41y89Phg7Xq+t2Jm6n++KMjYXb7musbGhdMFutqR
         QCQ2OCP5XZkOaBKHc5S0FekvJK3Xz9KqwQOx+Ow9kdWzbGv11qubvm0ULlLDlBWR9+wX
         9qr5f3fNvFYh1xKUS7SW52IxFNO4YRAZeRYELQMQ9WceAHip0mlO6P7w1MRDJXEoZwgm
         h9jYpylV4JQMgOmaTfX3adjK2tHiikmqXa7WMj1O+YjiALPPODE4z8SEiLiOh26TUVlI
         jFMg==
X-Forwarded-Encrypted: i=1; AJvYcCWEmmYcPDEBuxFEsloJUyZ/dzo4F63EoeO1xGHqxmz8rpOulLcI/dKIsBDdfELoht+OfCGBZUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfXgVfQW4oTZOIxykU0MmD8gfBgBYQx7F/vKynmSdRppizkG7G
	3/xeAJRgneCVVAA1jSiYw1D0SVvtL76+eaTpaV9Whm6czIhniRU+ey9tQzMU3VA=
X-Gm-Gg: ASbGncsxHcekAwUPeu16I7fCl5lVS8VnHKId4yeXGMIRqlvflPxHidvnE7L3A4nR4Bn
	oz8KAg+qvm2qud3HxsHhbJ+m9rwgqW4RLkmjOOXFRlMJU1R4s7t74toh3gNhcoUDEyAH5yKMYZi
	/R+oPjVm2kk44hmsOLZ9H1xBrYKXb9U9ehpZC0Fjf1XefsUBeHgIhgzH0AvDSvGoPV7+sCpC3zS
	vtsL0wdxET9kvJy0Odnwm2Di6+5dF6EJlJJLdpTvGXa6hpFmaObtMLwbiH5euSVWQ==
X-Google-Smtp-Source: AGHT+IGBydE7n4ukQMxeJC/IohCUHz/oBS4d62nahhto5e93jzlvZ4RUwir6qAgTxFQnHx/YuIXhKA==
X-Received: by 2002:a05:600c:3c85:b0:434:a1d3:a30f with SMTP id 5b1f17b1804b1-436e267736cmr270167985e9.6.1737027341348;
        Thu, 16 Jan 2025 03:35:41 -0800 (PST)
Received: from [192.168.68.163] ([145.224.65.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm20597123f8f.19.2025.01.16.03.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 03:35:41 -0800 (PST)
Message-ID: <6d3dd8f5-db23-402d-b7c0-d8264bb5a045@linaro.org>
Date: Thu, 16 Jan 2025 11:35:39 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf bench: Fix undefined behavior in cmpworker()
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 kan.liang@linux.intel.com, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chun-Ying Huang <chuang@cs.nycu.edu.tw>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
References: <20250116110842.4087530-1-visitorckw@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250116110842.4087530-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/01/2025 11:08 am, Kuan-Wei Chiu wrote:
> The comparison function cmpworker() violates the C standard's
> requirements for qsort() comparison functions, which mandate symmetry
> and transitivity:
> 
> Symmetry: If x < y, then y > x.
> Transitivity: If x < y and y < z, then x < z.
> 
> In its current implementation, cmpworker() incorrectly returns 0 when
> w1->tid < w2->tid, which breaks both symmetry and transitivity. This
> violation causes undefined behavior, potentially leading to issues such
> as memory corruption in glibc [1].
> 
> Fix the issue by returning -1 when w1->tid < w2->tid, ensuring
> compliance with the C standard and preventing undefined behavior.
> 
> Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
> Fixes: 121dd9ea0116 ("perf bench: Add epoll parallel epoll_wait benchmark")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v3:
> - Perform a full comparison for clarity, as suggested by James.
> 

Reviewed-by: James Clark <james.clark@linaro.org>


