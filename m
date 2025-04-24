Return-Path: <stable+bounces-136523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB70A9A2C9
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 09:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F313BF6D8
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 07:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B1A3FF1;
	Thu, 24 Apr 2025 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbFclHgN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E6D79F5
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478168; cv=none; b=aK8MEE/Vd8skQRxxrj0O+mGjGdPuK2o6XOi1jJc+0M0JEHq+hSHGPuOU1NdogR7qNidCS7z4DB+qh+r1PIfddo+b9qQXieikMpWbhJmr8csxjfCn/H/6FJJkuLFp3o5y+DParkByY4v0CZkGzQjTwif3MDfZJtqUKkuvFnUW0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478168; c=relaxed/simple;
	bh=CsVdIY8q46bTxLPbuwJ8cUP2eUiwXdsgC6RMjJcwonY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TI/0HymAjBcUzoOYnIXb5P/Uhy9gTCwarp398k/qXMgASEI+9xSrEFsf/8SBnPZ2SeRzOgiX0/bf/Vgpq8s/TFYRzig6vlyEGtbc1EnRgAHbzWDrXX3gicM4CiH7iaQyWY2FJ6Fo4aEhfgTEGw4NMeB2zQLruLblXgAbE+aTLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PbFclHgN; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac345bd8e13so98026366b.0
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 00:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745478164; x=1746082964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=atZ0zH+QTHFPwFIGyoJZTZ335IopbqtcRNNIDzNruC4=;
        b=PbFclHgNjB6RXMecnfIP+Z73qquzU3VIwvxcMjTs4FsrIcbOh/LblRF3NUS4LZfc5y
         ZpCZ8iSj72X1+S7rKtKjYOgzEwam5ASSq7FmFQsu6+NEUUwFI3PDrHuua6eXGQ1eENHH
         +gUZzwTVtO4p4o8zLhYjoXOqoCTIZjdwq43dKKMkroVaj5O7OTlYMIiWPClNx9icGA/O
         6M8yEnilRKLdmNngmnbBLtndXiezGTt++7R6Yf9ACl4E41Uq90JqzIU/pNtYPgrLHSUd
         3DH5g+7z9OR2JE8v1AsfAXbLN5xHzWveov22VvaN38zQrDfdX6aZNyzEC6IK+/wLUwPR
         s2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745478164; x=1746082964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atZ0zH+QTHFPwFIGyoJZTZ335IopbqtcRNNIDzNruC4=;
        b=s06QXC/68PfUNB9UhINnlU9whtpkVSgaZlLVSeA+JfpoxCFHRl5uvu3oKuUCNCu3G7
         vDjG4K+w0eb+p1dd48Ldt8y7TFBFecrDOwfaz2mgW9PwA2y6eXbxZGhI+RPXMF5MDljC
         EKxWXXY1b8PW/WauyDMChoP5xPCg4xXpCtOrTmWUxjFyY9/y0cQFpBy/3f1eAHiJK2KK
         D35AQn8dPj9u5CnX1W46SCTG+OrAmiHO1mg5Ht1eBOGnWO9hknO2zZQ9Yv/RlAp+mMFa
         J0P5O/mC2oTvuCMgpRWDMSn0qDIDd2KK6xp9UTcvF9O1JNAsgwPxHN+fuwpcd4gkRSg6
         h15A==
X-Forwarded-Encrypted: i=1; AJvYcCWmYKtBBJuHZoAyG19/QshXVs6M7nRzHthydojL5nElkxIp3IxMwrXBQ4a7d7ggZFqENbHw93w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9v5IWlLk0o5Tq2oT919wMqP/MfaVUhTpEL3flsaeZjuh7Eyi
	HtL4ORWrief5VUCajzksL/XbMgbQW438LHjipDRcIGeyoyA8xYaLxlGigYEEJ7Q=
X-Gm-Gg: ASbGnctaxy9pf6ihsEngys+QSDkqdW4isbjJJka69uzeRmKYOnNauitM3SqqGWknF1+
	4dWTcNCDxiBnkkBL1r/MR1Rk2xWJzL1dQr4cdJYLZY3fBsWAr4NQ0+wRB3DNV06IUHAQgqq8k3X
	6KZ7PzJDw2KBAX0BbexeXBOD6QL5r/w00SyAeOscymGgQ1k9NB5ARqf/NZT/6beknQirCCgPNr6
	2MtFR+nbceXxjoA8wNCgrItfToi0/dgX1lw3RwKVkXMnz6l1B6lJqlilS0TJrJczFLiQxw165X+
	iqJxNpYCNFL/pBofAzCQiNsPhbJ/LerWvRASdA==
X-Google-Smtp-Source: AGHT+IHRRXGrXUDu3+rG3nESpdOVayw7JgdtjaocMACREgykhsz0BZozqMiy2x1NiHc65DNK79egqw==
X-Received: by 2002:a17:907:97c1:b0:ac7:95b5:f5d1 with SMTP id a640c23a62f3a-ace57494ecemr146858866b.42.1745478163982;
        Thu, 24 Apr 2025 00:02:43 -0700 (PDT)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace598f6b97sm57765866b.75.2025.04.24.00.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:02:43 -0700 (PDT)
Date: Thu, 24 Apr 2025 10:02:40 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Marek Vasut <marex@denx.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] rpmsg: qcom_smd: Fix uninitialized return variable in
 __qcom_smd_send()
Message-ID: <aAniEGwKKRUieo5G@linaro.org>
References: <CA+G9fYs+z4-aCriaGHnrU=5A14cQskg=TMxzQ5MKxvjq_zCX6g@mail.gmail.com>
 <aAkhvV0nSbrsef1P@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAkhvV0nSbrsef1P@stanley.mountain>

On 25-04-23 20:22:05, Dan Carpenter wrote:
> The "ret" variable isn't initialized if we don't enter the loop.  For
> example,  if "channel->state" is not SMD_CHANNEL_OPENED.
> 
> Fixes: 33e3820dda88 ("rpmsg: smd: Use spinlock in tx path")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

