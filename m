Return-Path: <stable+bounces-110326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F25A1AA51
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 20:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBD616895B
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0673D19D060;
	Thu, 23 Jan 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JMcoJ/Pg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29383192B69
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660501; cv=none; b=SONDc/4xEAJSqc1O87EfBlPszZ4iVxj6t5VAZpYmfSMQ0TLDLe6+zMY2RWKWPzySiNv9BffuwZMhYDtG+X+s1Gpu9K9pNCnRksT+fIjNZ1QSsuZpYcgKqDKyvf1WaAw8l//p0Pj7Lw/q9xZ+I7lgxqbd6ATjPN6q8gXFjQMgaGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660501; c=relaxed/simple;
	bh=zuLzbHGlNaVAXq6vPQ5Q6FydJO9jqhGmAg11BhVz9kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tz69fEZmvm0ZXGhRv4GA0U+7AG5NZ2fvL+8e+CjGQdgwOk0WjHEchHSmb7iNAUuV5xPNuqXWbxaDxl60L+Ff7Cz/Ki8gr+gOi6TbqphLGNUxMcwHHLcUc3IDc972rrCMQ+jTztsmJ2EfwFlIHpFmBobltpCvsN1Q4YtOlMf+8Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JMcoJ/Pg; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4679eacf2c5so12848711cf.0
        for <stable@vger.kernel.org>; Thu, 23 Jan 2025 11:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737660496; x=1738265296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zuLzbHGlNaVAXq6vPQ5Q6FydJO9jqhGmAg11BhVz9kU=;
        b=JMcoJ/PgwFATpOaSzQgsSKTvSrL22YCvDst8F6+ynjDewGatEOtqAHaKbBYrGaiSx1
         d9LYH8gKpOvQV2vHtDEfuOKuaMK0qhjBp9MzRXJvLn4BzPiTXO0cMCP8AC72CWpIRNoY
         AMaUGgpunXNenM0A8RANDWfBwweWu5GW61cakaIYfEgQr5gsco5EIQunVKsesqaxT6OS
         F1Z5ZNYkDPRJX9jgWvPSeiZBgEkyAmB7CgkcACSvrZVW08bI3R95ub/3M7lBsmO7h7/U
         3C4bjOyIRgcE7jdq+cL+LCYTvFCK5xYGG0lfK3lweX1iNA7pnsN5Z/U6lhTt+ygCsn2e
         GGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737660496; x=1738265296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuLzbHGlNaVAXq6vPQ5Q6FydJO9jqhGmAg11BhVz9kU=;
        b=gFOkl0JvbnTwyW2saHH4umesXfFdERqIxxOGZhJqpc9WEN9Yf3X1y8A/3QuOpwedsL
         JsNjnjiErbV/IT/uGxmwssQb+nkCjKNdlCA5Sowh60E5krN8itcYk4KlRsQ2CslIzjlo
         S7VAMGze1aCPaBRy/+WBkOPm5PFujAzKz6y+matiE2lC4JNqwJQ7NDDTuFSl/eWYUGBK
         R624EDdYiUabhs7AGouYjlVblL7JQxZyHYUBbWfaXfF22SQ9gXZY0nayG8LEDgw7Idwd
         5REchPxTKzgDJj6ASy44CWeWtWBHtyFTC91LP/eR+u59OeE3i5MGYpsEFPdYhxg+0E0D
         Pn4Q==
X-Gm-Message-State: AOJu0YzKUr+EaNC//HfX9X5fXTd/mVV/crSP7FKddrjfRAM+UcszR1Xt
	rgQmxAExsXUjq3TBD9YD6h36IXRxtfoCihSdQODdNU5Ofa1XsB9AYWBSPiCTk58=
X-Gm-Gg: ASbGncvroJDj5MmK7QytRY9aasrBc3CfFPrIKm++LOnVTIGCrtR82E0D8osXGl516Vj
	RDdO3jq/rvNDRfc/CH/agkBg8269gTim3FwWNQftcMu74v/uDXYapY+u+L5fC31g1bgbUtI+E4y
	tfSFxQs+T7LxxkGwbk3SfqKt3pLxBzcJBAhewq0MUJP6ddNFzrFE0u1Cok1CtTCjxotkvX+eiXX
	vDJCvYDidBhk4JBPrAjbx/J49kfVSRtVhXOQYFGTWDhV1aiE3TDsSgqR9+QZP1L2xfuK75n/Ahk
	W64/0iOssAGHqZYDVBTRP2IL/3IcKXMDhm15ONw/hkQW1GdT
X-Google-Smtp-Source: AGHT+IHWuxy8lfcXRYEhJrnCbOsrkKR5OyVH+rveZqlHizJec8u1DneLTp+thr6+Zyl0btizwNn75A==
X-Received: by 2002:ac8:7d50:0:b0:46c:7276:eda6 with SMTP id d75a77b69052e-46e12a252cemr349090251cf.7.1737660494476;
        Thu, 23 Jan 2025 11:28:14 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e666d0e3fsm2188611cf.0.2025.01.23.11.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 11:28:13 -0800 (PST)
Message-ID: <bb204680-2c60-4928-8c3b-e87b1dfa39e7@baylibre.com>
Date: Thu, 23 Jan 2025 14:28:12 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: Ensure callbacks exist before calling them
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250123172709.391349-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20250123172709.391349-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-01-23 12:27, Uwe Kleine-König wrote:
> If one of the waveform functions is called for a chip that only supports
> .apply(), we want that an error code is returned and not a NULL pointer
> exception.
>
> Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for waveforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>

