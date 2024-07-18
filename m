Return-Path: <stable+bounces-60521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7067393490F
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 09:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C0A283627
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 07:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEFA770FB;
	Thu, 18 Jul 2024 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZuH3d+J7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C89770E5
	for <stable@vger.kernel.org>; Thu, 18 Jul 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288552; cv=none; b=GGLpwgu2p3pFRsm7RljeLnPUo/kE7MdSKUDEcx60oz1qwkkZya0TJ0LxQGTA4cg7RK0bsSiS6nLjai4u1TRglEtdafmf0JRMV4+4s4+YrzgEknWdhsS74U1r+B+rhClmILD5Z1msEfnEYv4LuZ9il+07MmNDHM4ywrfopxvHras=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288552; c=relaxed/simple;
	bh=crZJmCqK87jwljEupGaNu7UvUqSuBB8l1HzWelVei2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5N5clEEneqUx3ZKTqVSHLtmhyeDH7oD3nyJMem38FLSioyy1lUs1SZFN/tzTG9p+5TsTaMVswLbEZwYpWegX9NbHoR/2nLQQynq4beEIkRpiW4r0DSjAYHVO2Xc/Bh3KI46bWyignp73jMkOAWqKOtMTe2zNuS0BFszoI8kUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZuH3d+J7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77c349bb81so43298566b.3
        for <stable@vger.kernel.org>; Thu, 18 Jul 2024 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721288549; x=1721893349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZX287HaqyP7vcUJ0qc5XZL5lWkyJafdbelVz1ASHFps=;
        b=ZuH3d+J71ypVm9H3vUvAZmuqdbwzkhBoNmVfnf8te1EuU6oJog8Zy2aNbi9S7QOUe+
         uXXDXEDNIwbPLPA+plv1MNiNWXO5IiOICBiOsCZLaHsWoTWSupHvX4A0N4Y/KHwnG/kf
         k6EHsXyuHWmk8ur/gEqVfpXMqFAuiUnSpPCfPNK8aWxW1jBIZ7+wII9B9PB+yV90R7a4
         x8wqkYHGUqUA3+UP8dlXSHcxFdcNvs+RxrPlwf+6A3q0Ggccec3jCUSXf8dXlG+ALgbu
         k29lh3C3evrEhfD5Yd7Mb6onXIi69JlAUOO/wCVkXfp9yzWNnPAb9AIvCZprvEXwo75g
         rt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721288549; x=1721893349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX287HaqyP7vcUJ0qc5XZL5lWkyJafdbelVz1ASHFps=;
        b=V4NS8dS7oJ7Mpqyo28bO+JWAzhMh6++8yUen0OW2QDdxBVJZmdYc2DyAdvZliu3+Pg
         ibwt5EnEd9v1ogu5um+uFB4PALtri2qlmKBZPY4SaX3ZHxN4sYwGtCA3xc+tQHaEMNSI
         aK8QN2ZAFyCKMJHVe1saTh/nJ4d8Pt9e9kCciXolEjfzXJn03NWSUeYy+yBqwjPGS9Wo
         YBom/xu1qJj0eECwJ575KdCnJkTKHQq0X6ZU4vpGcCwr2dW0aM83R75H4fyX9gkCOnvD
         8V+sd6TyBEMN1vwQ08KhIh35pkRp5d1/2VpiRr5shRDHYObokPwZHORaK4lQX+mOa1yY
         Nfaw==
X-Forwarded-Encrypted: i=1; AJvYcCURymBuen7rhyWYOeJSX27h/kPyeirFpX6Tcy/ZY2nqB7zSzBZ1c6OFGxAoT1TT73bhQIQyJHkW2m4UGKVxf6a0hf+r3mzA
X-Gm-Message-State: AOJu0YxWjWCWMJ4XULHTAr47Y49oTJazZDVFR9MLp2DeOSa6zKIRv05+
	iHWxtogrGJ2LMcZD5okqvLKXjnYrG/OamQf5dVH7wWNBOLphhQGYGVrr2H5VPmc=
X-Google-Smtp-Source: AGHT+IEWjQawmcXV1ywfjT5eUOoTbnv2DLE4PcXWO7RcnvTtWMyUSEg1A/4wLFF5qysl0PAozkvpcg==
X-Received: by 2002:a17:906:408b:b0:a72:4b31:13b5 with SMTP id a640c23a62f3a-a7a0130ce00mr266533066b.54.1721288549115;
        Thu, 18 Jul 2024 00:42:29 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b8366sm521156466b.61.2024.07.18.00.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 00:42:28 -0700 (PDT)
Message-ID: <1c5b3f7f-95b6-4efb-aa16-11571b87c6c6@linaro.org>
Date: Thu, 18 Jul 2024 09:42:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: cmd-db: Map shared memory as WC, not WB
To: Pavan Kondeti <quic_pkondeti@quicinc.com>,
 Maulik Shah <quic_mkshah@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, stephan@gerhold.net,
 swboyd@chromium.org, dianders@chromium.org, robdclark@gmail.com,
 nikita@trvn.ru, quic_eberman@quicinc.com, quic_lsrao@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, stable@vger.kernel.org
References: <20240718-cmd_db_uncached-v2-1-f6cf53164c90@quicinc.com>
 <a49113a2-d7f8-4b77-81c7-22855809cee8@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <a49113a2-d7f8-4b77-81c7-22855809cee8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Pavan,

> 
> Thanks Maulik for sharing the patch. It works as expected. Feel free to
> use

Can I ask how you're testing this?

Kind regards,
> 
> Tested-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> 
> Thanks,
> Pavan

-- 
// Caleb (they/them)

