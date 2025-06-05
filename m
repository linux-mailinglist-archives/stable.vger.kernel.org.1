Return-Path: <stable+bounces-151537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CBCACEFF5
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 15:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F7E18855C7
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FB1226D09;
	Thu,  5 Jun 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hE37ZiDG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B55C224B0E
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128790; cv=none; b=YieywKk6k/LIExOX+OX0tL3ZmyaPkM8wp7Z+6FOZscN+y7itHRxteRl5X60WaiD5MmYiFXvqBVUrlBsUHRIqjZzA3oTLBcjF79O4Kzy4gfFDnX5NHFS9pe+8zDfMJxSaXYW/2OQhqucjvyeaECgGzS2saN/qbexOCMOErS/pNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128790; c=relaxed/simple;
	bh=zS8ecJYvpJitQ3UMbVXIWGqUkE6qbecokkfr7msuPkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E67QQtt1d9wMNRUCS7x9XhKc/rXkpt3S2o7ikRJX8Yji1jduT7cZ6ZoWWUFB7cv3DV+YNte9Jhpk4BKrud94GKkIpPPRNnpcJgcIWT6PEpGeVjgr2qDlMPl3dB9fD7L05vB9jJTFLpiQ+UJmYS7qm5uQQfRpm5KnaP6KBsW+GII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hE37ZiDG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a361b8a664so845021f8f.3
        for <stable@vger.kernel.org>; Thu, 05 Jun 2025 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749128786; x=1749733586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALKVA2fW4irMbGXjAfGWZNtggykUGJCgahiUtNxuSd8=;
        b=hE37ZiDGu7jX1TYfxpGeiiSGeyzR99Jeoii3ivurbeE99fHaO2Y8MtfLhAOunRy0yx
         8zhitREKYvNICRpKf5pBIXnSKK/uMZv8A86Fug9mOZr75VM+FMqwfnTTlIzg+sv+Y0DY
         l2iLsqKB6Ks/IpgoBpYHuAlC69QZ4sstmmeev89FMW9EXtNNqLR/b6js1POkgY8PqBL5
         mFHXIlrHZTVmbPrOaF7aFKFRDCkGdav8diIUirYvUMSNBjD8gQYF4nZeNbNU//gtjHHy
         6XLZabXNJgO1HWCLmX1laGZZoQEZZp0ZYSJg95TsAOzjlzIj8DVidL/ePleu3M1iDJ1i
         pL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749128786; x=1749733586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALKVA2fW4irMbGXjAfGWZNtggykUGJCgahiUtNxuSd8=;
        b=FO2ugQRnhwdYlTYhQiu+zWeR4iIy9KFUgDfnNHndLugSEX4mJea89SqHqdTev+LF2H
         LR6+O62tmlEtZOvv9mNeNz6hFe9iiOxUZX97aJ8Dz8Iy+O0x/9pJ7I00FXfGuTQCG8qD
         ivXtGm8yVpDuG66O6b+GIhwa0PC2c/P7QIf4ii9LmBz3R8IQR7cH1ajRuQG+wBn6SZVo
         vWCUjNaQcNjSG/lPqDTEF0a3RnUpWgn29SezHvFyiOX+6HLxyXGR8KKFTcfHHM9o3+vz
         wPe998eeXBXKwe9rjx53H11ztzmThGHhgF1Rx2ql1z5jpKfideH6GlIiVW30Rym4b3YD
         egZg==
X-Gm-Message-State: AOJu0YwsmU0pQMruatFnubkG+fKY32zKmVIWKfDThHYYI6ztg48nx6L+
	WSpqy+iRVai33scLJuvbtfeZkgNP3QEyH8x8+5dWFUmhctCAJpjtIJJp0fqggUyEvPg=
X-Gm-Gg: ASbGncv+6Kbgs9LanjFuUVZKCeSwIdRSijY5J8JPvmIslygF9dDZDBvSs+R8cnZbNPX
	hJdAlRfKli0XWuYfhuzojUgVTBzyJBRMxBptedOSiLBeZ7t8+jFc4IcbXPEozwuUF/h8AhMJTEd
	S1NBlxhGa8RLOnExBKlhwQMQqCwV9fxKemvRLPp5wAfHJES1NdXVHCJdlmM51jnFShkEQWM7FbL
	e5gwk+fvcTBPCBv3KcetdkxhNFviAcIKdVoC7xfKlKIyWijzVO3++4XhBJs3GFkB3nm+EWbfPvj
	8F2c+ux5/eI6rLjFw7xy/Z2HcyujWHVxHKrMdq6AXgJe9ZpVsNpBf2KA8NE8KJusQc1MZw==
X-Google-Smtp-Source: AGHT+IFlFSrl3XSTZnrLX3liutqht/hIRQLoBNZPN0qE0WMgTCPvfiUO9lKb3LhAK0eALpw01RUcqg==
X-Received: by 2002:a05:6000:1a87:b0:3a4:f7f3:2840 with SMTP id ffacd0b85a97d-3a51d8f60c3mr6177072f8f.1.1749128786358;
        Thu, 05 Jun 2025 06:06:26 -0700 (PDT)
Received: from [192.168.1.221] ([5.30.189.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f99248a7sm23764615e9.36.2025.06.05.06.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 06:06:25 -0700 (PDT)
Message-ID: <99d180ad-7e64-41fc-b470-62300a064bbf@linaro.org>
Date: Thu, 5 Jun 2025 16:06:22 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dmaengine: qcom_hidma: fix memory leak on probe
 failure
To: Qasim Ijaz <qasdev00@gmail.com>, Sinan Kaya <okaya@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250601224231.24317-1-qasdev00@gmail.com>
 <20250601224231.24317-2-qasdev00@gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250601224231.24317-2-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/2/25 01:42, Qasim Ijaz wrote:
> hidma_ll_init() is invoked to create and initialise a struct hidma_lldev
> object during hidma probe. During this a FIFO buffer is allocated, but
> if some failure occurs after (like hidma_ll_setup failure) we should
> clean up the FIFO.
> 
> Fixes: d1615ca2e085 ("dmaengine: qcom_hidma: implement lower level hardware interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

