Return-Path: <stable+bounces-2727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EE67F9841
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 05:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB92D1C203DE
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 04:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB29B53A2;
	Mon, 27 Nov 2023 04:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="io+j2SWs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CDAF0
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 20:22:31 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5c2ad6a5515so981671a12.2
        for <stable@vger.kernel.org>; Sun, 26 Nov 2023 20:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701058951; x=1701663751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bq2OIvsQw3yJDsb81W5Mt1xLnrV8cPqvxov47jnGU3E=;
        b=io+j2SWs86aMk6XiysZeovilUIPjZryrsq1a46QqFrJpxKwnJbR7T+YbzDNkAKlB0o
         KpXD+p/y2N0CBjnqhHtvJVecgRxVp+zWUDzD3sDpC9wT3BffrbGOFjgc8Xrl4ZV953NR
         Eso6ud4t9XfJnPT+gzLqif9QdJ8h5tAbgE8KraMuVZGsuFcV1hgedGM6EpV6REoQxyVh
         lLietStSols77gFL/fQ+SEpGW2IoXMRbV4eoDaI11GDgVSaRhjDYcb+3BYHSqQx63UHG
         lo7da2/GdnDCCByrOtaosOcTiWqz6J2MybZph2y2BFGjBW6IW15gyAzXUwURQXZHDsk/
         /CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701058951; x=1701663751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq2OIvsQw3yJDsb81W5Mt1xLnrV8cPqvxov47jnGU3E=;
        b=U0WFnpxsK74fpq98p9k4iBImtmLNrUJFkOiBm3mtxvULYiV45WvUnbJAMQHsflxBI0
         iw5ZnSQ0pyMVlhm5/b6Ud3+nxoL5iX4jR58peJla89uJqSBqkCbNLeYJi/TBPZAReO0a
         ZqCIU8dNBH9Uu4/2aFLLwiYqh2xDcvI9q/HZxyvGeqrTyO8VmXMDOKQBkimnKc2ZuL6p
         RWe34bHtA22juTKkZuOcAfo6/L4ZokMdTj+PA/vOFZYmRyZ/MYQq9ckhON1P4nummkWv
         MAsO6EsC4hg/649bLoYq7mj1wDJTpqJCmmVtAJMdCHYl46aQ0W6CWgo94SI3zinEo5U8
         /wgA==
X-Gm-Message-State: AOJu0Yx6KHarT0g2FqaxLQlXaT4EMAQrI0bpk5QXxYbTZYBa8yqF5B0m
	Xz12QIhgyWKI/342U1W19ER0OA==
X-Google-Smtp-Source: AGHT+IGFEXhRAOn5CY2zMCs3iQysk61vGPlq7O2TnXotwEs0JLtBXK4N+r7uWS6tnGuj48E/eqXnTQ==
X-Received: by 2002:a05:6a20:3d1b:b0:18b:556b:6d54 with SMTP id y27-20020a056a203d1b00b0018b556b6d54mr11551163pzi.55.1701058950813;
        Sun, 26 Nov 2023 20:22:30 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090a94c300b00285994cf711sm3853499pjw.33.2023.11.26.20.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 20:22:29 -0800 (PST)
Date: Mon, 27 Nov 2023 09:52:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] cpufreq: qcom-nvmem: Fix power domain scaling
Message-ID: <20231127042227.diyl2wlbo72ib6px@vireshk-i7>
References: <20231114-msm8909-cpufreq-v3-0-926097a6e5c1@kernkonzept.com>
 <20231123073901.meb7p4yzueg2lkou@vireshk-i7>
 <CAPDyKFrst+j89nPsrfAmkzGBLAwZ86WWQ_agnd6MHCfR+7FeFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrst+j89nPsrfAmkzGBLAwZ86WWQ_agnd6MHCfR+7FeFw@mail.gmail.com>
X-Spam-Level: *

On 23-11-23, 17:14, Ulf Hansson wrote:
> Assuming you are going to send these as fixes for 6.7-rc[n]?

Yes I will.

-- 
viresh

