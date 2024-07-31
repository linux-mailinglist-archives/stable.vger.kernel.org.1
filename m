Return-Path: <stable+bounces-64770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971BE9430D9
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 15:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85081C21CF8
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C18B1B0119;
	Wed, 31 Jul 2024 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMrxPYkX"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181BB1B1519
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432604; cv=none; b=nHI+/PeFdN5fDqc2ZbFZr2JiD6OwGV9+Nf31EPXHCW1y9zFCsr9NT5dTwTx8pKpwcMBCOV1TqZu1pO6UDzlZ9caXYdyiJz/UPK4ci1GRbu26H/a6VzgGXtTh5L2DmrT2AfIcrElER0Jmc0rAWISsFh6rjNfAYJ+fYbzrnkMhL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432604; c=relaxed/simple;
	bh=TryEV3yA8sFKaSQ7T/iEgFWFIg2FZ89jJhsb0Zgqbi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDh3CifQv1Zy5YSaeahEWNi4eNrl0lfZZLQfJFtoYYDALybZXclzN+uqtvea33/W4HWXAHU6qFmug8MpkqHvxP6sY0oD8tYdbT5f1p27jOD7VBVhAGqIzBTe9D8TzOya2p0h3gMoMpiwgZxv3/TZsBz3H0z+pWtfMBwOzKpkTNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VMrxPYkX; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so91396121fa.2
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722432601; x=1723037401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LAEsWWHOaUu7e2ckya9k4oMqGrC/8Bo8kmjtXWGK3c=;
        b=VMrxPYkXxs9XESjVBGQTDo7FmU9D0B2r1wANyB2IgilvpkYxHRZtUxLOrH1ZqJpWgP
         mbpdW2X2OBo0VQdguq+2vdia2nXtPecspt2v/PlUknHAS7vCkChD9tPteDdw+Yei9PJk
         /2/MZqv3CjluyR1FJ1hQDZgfULzKuA+CxN86WJ5eJEDNrOGaxlWZkgI94HwzXjdpb+S3
         hCHFrI91NN4wsILGxELijBboCFAhIxuY9RXwRfV7kJWwryCxTpJS/PgVmIu/4gUyfDhV
         qgc5/7MAbjkD9vJmVNTJAbDtHbM+vSymCXzy0sxCo+mc6YPC62VlC7Zk4lNDBpyHhVzD
         OmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722432601; x=1723037401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LAEsWWHOaUu7e2ckya9k4oMqGrC/8Bo8kmjtXWGK3c=;
        b=jcDQFZSYS8tzMV4SQRcc55bA3Bo/HZYJA/cu4htzmFgWQRq7ynqBiqvUJRXGboa321
         MY5flaI/Bd3jTiaBlgiBtzuavRMpChdpSVZd1jQ++8waX3NXoxScDUYBEOzuMq0bLaRk
         LsOK8xwFylRBol7G9Y2tcg4n7Jru5KaXroA5peWKBaro2OUf+1jZBs+SfoYBfef08oBJ
         6mmW1HRDSf9RyOQuxACYuu1lTJweKLS0b9LMMKJrlGn9s7j4ebvbQaV/vkCKU5FCa/Ih
         Bp7OgZ9Rg5EW7XGCc2Tv4FSmL5MEmWTHjb5/Rp9ud3YM0O5BBmwgqJ59yar9GAFN9IWQ
         mKZA==
X-Forwarded-Encrypted: i=1; AJvYcCX4dHcL3aC0UbME/VAxWPIvYJRgRQVOVFgLdEP93JaYUE5qpOjuMpaGKMhuhiqjTVmzdsb5npihc0odGVM4Hi4tTQgQqYE+
X-Gm-Message-State: AOJu0YzhhukV7ymwpAXTtyKgsk1StGU9fJAhl+nuzic1rD38++YYowGY
	ZAL/yyONyTYxCxLhQ7bEXxvW4AabOiRBp+NaYF9te0zktcU3P175jRbpBaR5RP4=
X-Google-Smtp-Source: AGHT+IFhu3uk0FBLVkWyOnfiEusFw+fqZbcmDHLa23kO7nJ3nPVkV2aj02bD2oZHCvbGNofksWO2yQ==
X-Received: by 2002:a05:6512:b10:b0:52c:e556:b7e4 with SMTP id 2adb3069b0e04-5309b2707f5mr10695014e87.15.1722432601169;
        Wed, 31 Jul 2024 06:30:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd0a6esm2278743e87.65.2024.07.31.06.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:30:00 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:29:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, stable@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH V3 5/8] clk: qcom: clk-alpha-pll: Add support for Regera
 PLL ops
Message-ID: <5tzuitj6zeqpua45dzabpaaorx6q3x57eiipgrku6lttqhpkaw@zevn4bk6pi3u>
References: <20240731062916.2680823-1-quic_skakitap@quicinc.com>
 <20240731062916.2680823-6-quic_skakitap@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731062916.2680823-6-quic_skakitap@quicinc.com>

On Wed, Jul 31, 2024 at 11:59:13AM GMT, Satya Priya Kakitapalli wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Regera PLL ops are required to control the Regera PLL from clock
> controller drivers, hence add the Regera PLL ops and configure
> function.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 32 +++++++++++++++++++++++++++++++-
>  drivers/clk/qcom/clk-alpha-pll.h |  5 +++++
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

