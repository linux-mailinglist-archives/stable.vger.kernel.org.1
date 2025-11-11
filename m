Return-Path: <stable+bounces-194480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE05C4E1BE
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18639189814F
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 13:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D08A331217;
	Tue, 11 Nov 2025 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="mZhid9DW"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C42BE03B
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867784; cv=none; b=XVgQoWDuyfYEqSsyjjckAXcpfPD7MLtpTLbFG/3gwPvcnEDDAbJBYx7AX3cNdevsFUnf0JJ4q+HWzqFm5tYQ/7Hqlj/AF2dGbhdt0AkQDVk20NCJqAvvi3kLyzC13eeu4wYmvG8gtjQb1YMZ5Xd1bmd2yykE7Q2altcoDkfWdsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867784; c=relaxed/simple;
	bh=bu//jfiuAwMhl+hkQrkBg3mYTFbqBMdLLj9zyIwZ0fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ug/fK/CEpK9VQlnq/jrXTEiM8yQf7n26uQd/AtpaeB22sglU4ixhjyRcA2HH4Tx+ZSVdUwGN6DiJx22i3EvWwssrtneEPa1xxe1C/lDa1oNYPgNjeB/CTnLpUy0OQI+ZB4eoHeAPR624BJkSw14qiRWYzsETv/6gjbL6RjYgd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=mZhid9DW; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-43323851d03so16204055ab.0
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 05:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1762867782; x=1763472582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMgbmudOUGCxAICCM0T13uChNu/ksfI0OswL7+Y1Lgg=;
        b=mZhid9DWFhRxX5ffaNaH0fc7kzh4zWxQqRzfwYPDnCrdvFivEhfZ7mJEs5gHUdfuL9
         cfBSSsz60oytkuhTqYdyg3mLUn0m8of4Lz7UDp+edC265r2nv3YWcm9/BURPBk0T2u3V
         XdOcj7xpNMLS+RakTqetzrx4/ou0qptvXAh2VK56JGjG1Cu2OxEi+N8p0XbB5tdjzTzL
         oqpZkFlYzmlhYpHK0nwX+GuxVvex80rs8BhGhv+v4ehXDMSXF1QgyAYJlnxF+O6/PLOR
         V4X5nz6MXYzBdWNXM4IbR+OVr/ZgjppqkuNrYG4JhTVHaUeyIzkQtsH89HaWf1BMx2XO
         4S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762867782; x=1763472582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMgbmudOUGCxAICCM0T13uChNu/ksfI0OswL7+Y1Lgg=;
        b=TfSKgh6qDcVwAWOaupcx3+xdXoKNF40reQTU6de0noXv2qZArk6hyCUKaQ9Wi28p8s
         5i9dTDgpB/Amaxh1szGJ/MBV4K0zt6YtvS5MZ1aMEMqxUggw8Mr/PrTcPLd9NwHdZIev
         LCfiw/b7fGxVG9zD394nQ+Gfhp6EQTWDanUti4aAkYN4ZrsKPyJq1kLOeixF/yyKKblJ
         /VpBIHbPxjqhr/bYMrciX1D9xwu0Zo3dIlthce/PB+Tc2EUu9vQ+GqouHUN4X/GxvSMB
         spX2XNd4ciCfTRKkNEgep48HfiMPGrRS/nFdIhsQFw+jy44oyXq42nR+oWKC4y1Lwwii
         DPGA==
X-Gm-Message-State: AOJu0YzaxcGNoVVXNqLnaiZ0AxxvtyDVmTluLUEy8am8HVPt/2uEK1AZ
	VyJhinQe/p704mvMR1sldYkQQj4i5d3ZzoKAe563nIhN41/2+sUwc253sxs2AmH4hplVb+5akYU
	+r4ArxEohtmri
X-Gm-Gg: ASbGncsv02RB3ztAVhVX+PuzfHwS2jb/qGgsiNIJMhm5TpHX53vDpFRlKxhE6mx3kBt
	h8D0l/2ht/kIlLUpTC86muCkp7fFuzKVQWkQJRAMYfl8mUG1/r146JfqOTFfzf5xYiDpqSEtvSq
	QfmQKc+ngMtnS6U20VXxPIyE6rB6oMlJDw6todzJCaVYtX9XF99uiQTxGUuXzU1WLpJjYHnlZfV
	eD0pMt8/pQJmNwm7YqDEjKoHStleNuHQeO22AG3MFSTCTwVgPst79tiaptj6AwyxLhcQaJlBWRf
	+ngTLzoAYaNbiCLtSF+PgqR1wMmPOIxr1QgBRk1E3nAQsTAhlv1OM90zeIF0tl1sebEBLrS12qt
	oWTzCVh3Jsc/fnC6H7g5jcUgeQ8tOHh43pbpP/IyC0Lau1xzfRQTUx7ojukjMn0cLB2o/egVFH8
	m1fn/SucJhNmId0jE=
X-Google-Smtp-Source: AGHT+IFtI399GCPHo3UIXPA8nkctB8TO+xlVxynLrsqyE1KKUsZzDqNEKh0oyIwjxAJ4OEJBYNsBiw==
X-Received: by 2002:a05:6e02:3081:b0:433:3315:e9ee with SMTP id e9e14a558f8ab-43367deab79mr197235215ab.10.1762867781812;
        Tue, 11 Nov 2025 05:29:41 -0800 (PST)
Received: from [192.168.5.95] ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b74698ad28sm6131101173.56.2025.11.11.05.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 05:29:41 -0800 (PST)
Message-ID: <13999fda-8c3b-488e-b14d-12fadb76f9cb@sladewatkins.com>
Date: Tue, 11 Nov 2025 08:29:39 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251111004536.460310036@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2025 7:32 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.

6.17.8-rc1 built and run on x86_64 test system with no errors or 
regressions:

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

