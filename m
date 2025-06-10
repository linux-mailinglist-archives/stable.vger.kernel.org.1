Return-Path: <stable+bounces-152273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C05AD34A1
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 13:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A27A3AADBA
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1594028DF37;
	Tue, 10 Jun 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZf5KJZL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA45223DC6
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553859; cv=none; b=aUnvdXuXesmJ3eaFj8CaEUR6wxn0Am1PJGjoRy0WoOE+i4195kn1p4rkGgybygKybpIsDelxFIy7ErjdwbA4e5iu0ftRgITz3TNV95AgzQjxRYl/CcTFJDUETPczJOw6k7zhsfoEjRt30HaQqMWX7nDKijNiOdH2nLJd63T2bms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553859; c=relaxed/simple;
	bh=moz2wim/rfV0N0Eam+BybWtmQPf4KPqMQ/vPGwKbkWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRD4N1n28oPnKtEALRc728sQLihtVmZEPl7SHPjwm4Yd2SIvE1zKn1cHR0ozsjg2uysdFxZSg27ogWcYNdApmHRYjvLLg5TTQIrGd6tRlDvTQXZCmgCD2Dl1bd6tFB716eMmwP9IKRTWWcTzkzGlEqG3Hau+/ymKsAWEoWdL2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bZf5KJZL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45300c82c1cso9384245e9.3
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749553857; x=1750158657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/q/ZgTSjkrs+z+mH2vucvlcudnmZL89/lUFX5jLOims=;
        b=bZf5KJZLAlvtQ6h3Hx+hicQ12578idIoM4pQTxaGuMofgNp+6qd4JgVgp1W41wVFnM
         gmC+yVoo/u+tlh0lWhPjfyu5YdzRcHG0ePQiCDZUeolMoUEMY1fC7C/HZ1PhvKoas+qI
         gC4CLreXQgGl7hn4jSHWBh25786usgQHdXq3ZlhXtL3DsTXDCtnkMav+xrB4DJ6erWP9
         m6bI4LZE8YOXKy8wkDDQk7IVSQgEIUwNWdjevSkkdEsJqj4xq/dh9x35LeE9P3haEyFQ
         D5Mm6rMkpcab0DURPUbFrkk5IxxqdTiROmcvqzm8j1LaZCbNgj07hQXBa2v42wRw3oYu
         K2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749553857; x=1750158657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/q/ZgTSjkrs+z+mH2vucvlcudnmZL89/lUFX5jLOims=;
        b=YMU5NXKU7BOdZb5LvWZcHhJtGafk3CyaVQVlwV8CFDHBnDOFsd+Fcg0lFcP1n6u71N
         2NwcbtTT/zIZ0WxfV7wwce6WPHPFS9lEoc3yGuyBPJJlksXBUIcoh6rPchebcNjBnPPz
         38BKC+sTFTOVNsyG3GrVuaBMZ2IrYyVAJN9L4DLzY4lnOGCHabpT4dBriiK22dV05CcN
         lr1g9RMJhhpCGMo5fFwgoznJo6T5q7RXjBQq0vt0qOj7cw8iSiuKQ2LB4iMzNAWNQr6h
         vf43C2Dp7t0p1yudcq/Rg9k+kFiZtJTDlkx3acHuqSIylkUAh96ZF/u8Fc84OOFIPpTJ
         U4Uw==
X-Gm-Message-State: AOJu0Yw/yY427oVrumnwQxdNzvN7hIjhq0sLMs4DzAdYuzqkMVv2rI9p
	2VBwKHmfllseGlL+xwhU6jvn9uFGwRIeFtc9zp0pmX1+fGljwN2Zny62mkON/2gEgkA=
X-Gm-Gg: ASbGncvx1fC+mIKXys6vLmISzg9+nEzj3qF+Ptuy6xS+KpWyVWxTwhCL89xzVBdh74C
	xUFOXp6WVswRYAbwv1XjT1wV5cVwZSKmALPsZkkp9OrM1DZsTRklMzjoDWgaqcReNKdQqejIjcA
	IkHoso6ci8HWzqgzSJLSUwFp5O4WzoANGWNf/RChsfvsaLTT+y8yYyWiUhnueSR9DYT7dpbFgAv
	3ZOGbsE/ZA1isvy98hvgHRJ+q19n7y4D2BlwXFrKEe6G6hDBWK3w67ilUoileW0+wtFMQu4dYDA
	Pw22RSGXAHhAP76onsbqj+yrE66mv2+yCD7vJQkUZ21DebDUTexjmZ1wqWj6JItFp+sMpw52
X-Google-Smtp-Source: AGHT+IH5Y3x1Ki501vRLyJm67k0wpvTB1sBYw1TI/SnhFi6z5THD53vwm2fVgUQX/KBtW47aDeeIdQ==
X-Received: by 2002:a05:600c:5396:b0:441:b3eb:570a with SMTP id 5b1f17b1804b1-452013681efmr181694725e9.2.1749553856655;
        Tue, 10 Jun 2025 04:10:56 -0700 (PDT)
Received: from [192.168.0.251] ([79.115.63.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452f8f011c8sm134431845e9.3.2025.06.10.04.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 04:10:56 -0700 (PDT)
Message-ID: <2a6336cc-b5cc-4f8f-94a5-d0872a3c95fd@linaro.org>
Date: Tue, 10 Jun 2025 12:10:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: Fix pdev_resources_assignable() disparity
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Rio <rio@r26.me>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250610102101.6496-1-ilpo.jarvinen@linux.intel.com>
 <20250610102101.6496-3-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250610102101.6496-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/10/25 11:21 AM, Ilpo Järvinen wrote:
> The reporter was perhaps not happy 

No, no, very happy in fact. Thanks for all the help!
I figured out that I need to get familiar with the resource fitting and
assignment code, and PCI in general, before trying to fix the problem
with the downstream drivers. Which is something that I can't allocate
time for right now.

So even if I couldn't fix what's going on downstream, I'd like to thank
you for all the help and time!

Cheers,
ta

