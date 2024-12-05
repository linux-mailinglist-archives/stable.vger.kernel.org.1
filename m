Return-Path: <stable+bounces-98862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B119E60B0
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 23:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6908B280C00
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 22:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B54F1CEAC1;
	Thu,  5 Dec 2024 22:35:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102001CC89D
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733438131; cv=none; b=lSJsAkx+G3WoyyIWn+zosFTz8R9ziGx2HVGPv+nTYLr7naA+DXnJCtQ43264m8Uo5ErpAenZg/ImsqSAHqbDYvrOCTcMN/9dKUyzIFvbU2+q/VWKeYXJNsyvBpPybG+4L4brj9WKsY0fz9U+RVwPVMmJCP/XYqTsni6sDmkaRZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733438131; c=relaxed/simple;
	bh=2NOL9msOvgRoeaBxY0bns+dpAJnTLo16D65qGElnkpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pn/4hi5JdHI6duRk0zS+Gt+9uEjxx34Mrbs2leAV/YlmWnW15t++0mJZ8qnWsLxPouy4qKzBHLqSkhHwgRs0QSIB/DBzKAILGgIqYXfe0P9y9jblM2jG9POzRMdCbzz2Bm4jEFrX3IOgTYCw0MjcZnAC3+SwIjseUhtyM/RI01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2eecc01b5ebso1272460a91.1
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 14:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733438129; x=1734042929;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtEYOiTLjn6+EkNb1gp+QTu4LUIf3CrgnNhL4DA6X8E=;
        b=iegWqDCBBDB3sMwHkOtiAGXv9EICxE2v4B6Eq2idC3k4KT+hv0rzhozYm/OwSXGJGT
         vOA8GAkHdXMzwhW97c74hQcytvcxgnBqTBDpN+7tms9364yEsDjfkcPasMLSVQT4yity
         48seTOUu7icpkcKzwfyxfeI7uWl1NA+sEUjZH0JOkCQdXg0XmtyVIPkUaVRAW0ThwG8V
         r0yY2dDxUydewcRGR8L2Gsl0diPt6tGGtYU0UwOCbncdKZ4yvwtpolqK32KrFo9Jdoir
         KaBi6PzzBh8r3vZ5QsNOcSVayAziu7VrURXwKGxMAZhepuSMXVbvHgUQP372OJis1nQ2
         TonA==
X-Forwarded-Encrypted: i=1; AJvYcCUlEXwPyPxjk7wZd7aBtCIWvd9AmFXKbHzJvRF6L69TZly6DElwhc46DTogi03C9kdO8nOQheo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHyU7oJWB1+EM++gKqEuVRO5uWsYVA6BNr8XDeURtqkd6ep0nN
	lzowTf5wuRFyWMXV8sYIOB7W8MKTc9PdxM1yZs3kfnzfcV43NXuZMwcf+MKXW7I=
X-Gm-Gg: ASbGncsseprsthCiaFF9lIbYsc1z9MPWoPVBDSJ0OPfk1epwqXSYQv38dvM72QKlWMl
	B5E+Shkd6tVIBV/gm9ygaAoyjf9bGrzfO+CTpee+CEEgem8oQUupA0sgN0wvsJh7+uHflK3nKUI
	qAFCvvSlg45EQc87lX2qDJZWO+3q7SYLzvq2Kw/mAzbSTn9KwfosFKwZp9LGAUAsX/YGwJaJXTx
	JoxHO+Zjx+Sd3MMGAb0pGsLZOfVQpv31tTpHAYnmpdKJ1Pr
X-Google-Smtp-Source: AGHT+IGb+Gho/439wgyLRKr7+nVR6NWlx9kr/iI53YBtIOzs5C+yxoRN0cNAmYC6YxSr9ZD94jwklw==
X-Received: by 2002:a17:90b:5448:b0:2ef:2d9f:8e58 with SMTP id 98e67ed59e1d1-2ef6ab29c49mr1173721a91.34.1733438129083;
        Thu, 05 Dec 2024 14:35:29 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ff844csm3801590a91.8.2024.12.05.14.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 14:35:28 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>, Andreas Kemnade
 <andreas@kemnade.info>
Cc: rafael@kernel.org, zhipeng.wang_1@nxp.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix using cpufreq-dt as module
In-Reply-To: <20241125051302.6tmaog2ksfpk5m6u@vireshk-i7>
References: <20241103210251.762050-1-andreas@kemnade.info>
 <7httcmonip.fsf@baylibre.com> <20241104201424.2a42efdd@akair>
 <20241125051302.6tmaog2ksfpk5m6u@vireshk-i7>
Date: Thu, 05 Dec 2024 14:35:28 -0800
Message-ID: <7hplm5hi6n.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 04-11-24, 20:14, Andreas Kemnade wrote:
>> no clear idea how. What aliases should I add? The cpufreq-dt-platdev is
>> not a real driver, so I could not create mod_devicetable aliases to
>> match a given device. It constructs a device under certain conditions
>> depending on the board compatible, so no simple list of compatibles, it
>> contains allow and blocklists.
>> 
>> cpufreq-dt then binds to that device and that one can be built as a
>> module (which then made cpufreq-dt-platdev also a module, causing the
>> trouble). I do not see any benefit from having cpufreq-dt-platdev as a
>> module. ti-cpufreq has a similar role and is also just builtin.
>> It does itself no real work but provides a device cpufreq-dt then binds
>> to.
>> 
>> Handling module removal would probably need to be added and tested. I
>> feel not comfortable having such as a regression fix and for stable.
>
> Applied this patch for now (with some changes to commit log), as there is no
> clean way to fix this for now. Got reports from other folks too about it.

Oops, I thought I had replied to this earlier after detailed explanation
from Andreas, but I guess I didn't.

Thanks for applying.

Kevin


