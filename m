Return-Path: <stable+bounces-26859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6570872936
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 22:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB331F218D7
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 21:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0112AAF5;
	Tue,  5 Mar 2024 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDj8jKDj"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511041292D7
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673324; cv=none; b=m62kPNP+ZaBazUVzdm/F2uAObKYCh5bkCF1y+mpWmKZDt/3XbBvt/QRVws18uZ8RUu3K/8riuesGeD+c9xKIXDwc2abnTrhJ/mJ63DfGi0ws7Nppy/0v/UYrHGANrLxv54TSag1zHaAIkZTjOmqTwOeZR5E8FZyNfMMqnBksE0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673324; c=relaxed/simple;
	bh=q3qpCtpfaHgKL4O+ohs+zw2E99BCzpPBfbg0sK2q/Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHKUtTQPqbt+e4JGFFs4EAzKs/SgKnJNKPwMG5+lI/8Rd3KUYBMJThUmeOn+59Zvr7Xmj3YPrkaWLkSdsIrsx7PzJQfsB6M3bw7VQ15xAs09LPBdDsEBaMfk5lNJ8/v/Un2VdIyl5oiWgxvTXMl5gfqTgfFStvhfNi/PiUFCjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PDj8jKDj; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5131bec457eso167221e87.0
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 13:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709673320; x=1710278120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcLlYhRVUjayvEg2I+ONza/QYQQIRBBumX2Ta0R39NM=;
        b=PDj8jKDjILv/dXLC0/1HoGiF5UjOYb4vMlDo5zHW3PqWNxycCF7phjP+ZSQXWj77oS
         aLwtO9IwZfIYhRu7Z2H8obDl6U3bPR5ZVX1oGLEEZXKaUd8vGIcJ1EhqRC3YXTXpH94K
         7RNY0wZ0PsFHmFpYrGBHGq66dcMzfc0cGyy5tW28ytqh75mpZ2OKQUnwtSqFW+29K8QP
         fz6iayckSyS0Slrh+063h5+VQmi9iXxlYLza1KoyFnMaJW6n/ILUWzR/d6PEW2UZkjWj
         OxpFglpFEmikoj3ogH1sMTvSE9tjCPgLr9TWfoMA13jF+cdcQOCrwzHKozivhTR9Igo1
         /RUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709673320; x=1710278120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcLlYhRVUjayvEg2I+ONza/QYQQIRBBumX2Ta0R39NM=;
        b=J23PaFfN2mCvrW5m5OojPFnBCP/Fn5Gfo/35PfF7p1ZHCypvwNJ8Ix3mOeL/Z2N/in
         NZ/dWDu66vesBf2p6qeQRiUdXu/bTA+9fNLgOXIlPkpCyo6FN+ZfxJCYCrEF+P9+gMdg
         Jg/VDGwTFdCOg8BhCWviM10SbHn9q8ywD9uitDyVZ3RbBy7+kfS3xg+soYmoSsMlpc05
         OqF6fE8Mw89Kbyyd4wB7/KMIZet49VvoWc7CHAFvMMR5QRv18OYoTUoG+qnia2qO8uDZ
         lw4qoqenLvqzut0Do4bqwI+JUjz+fd3rGwVoU/yVMd70PoKLyd7hyPUNPtb+dvpxPExe
         2iPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVAQ7GlQzxDmVo74L3e7IfbPcJqx1wYZcOTi1JMvt8SH5Jx1EuDZyZuPcVk45fWZQZpmzkozfC8T6olmJ3YY+19r16qwgC
X-Gm-Message-State: AOJu0YwMN56GwPsWEd6UfdgxPLB4kDMkwCAVC3+fzK9nlCztHX0qmL71
	Ht+AXBhs0BiWF0BM+k2Wk6oaXr59QaRejT0lK5p/+Xk7Pat6iWm0GtvRlL0eRSM=
X-Google-Smtp-Source: AGHT+IHdbN7lKKMKvsDIF7x0cETyUnPKYUVcgnXel+Ffrs8Vy4TYbaQOKxKx/8wKuc6TZ8iFva4IWQ==
X-Received: by 2002:ac2:434c:0:b0:513:346a:5a16 with SMTP id o12-20020ac2434c000000b00513346a5a16mr1068589lfl.9.1709673320317;
        Tue, 05 Mar 2024 13:15:20 -0800 (PST)
Received: from [172.30.204.154] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id i10-20020a198c4a000000b0051330fe710dsm1994042lfj.169.2024.03.05.13.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 13:15:19 -0800 (PST)
Message-ID: <d655a4db-89a8-4b03-86b1-55258d37aa19@linaro.org>
Date: Tue, 5 Mar 2024 22:15:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom_scm: disable clocks if
 qcom_scm_bw_enable() fails
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/4/24 14:14, Gabor Juhos wrote:
> There are several functions which are calling qcom_scm_bw_enable()
> then returns immediately if the call fails and leaves the clocks
> enabled.
> 
> Change the code of these functions to disable clocks when the
> qcom_scm_bw_enable() call fails. This also fixes a possible dma
> buffer leak in the qcom_scm_pas_init_image() function.
> 
> Compile tested only due to lack of hardware with interconnect
> support.
> 
> Cc: stable@vger.kernel.org
> Fixes: 65b7ebda5028 ("firmware: qcom_scm: Add bw voting support to the SCM interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Taking a closer look, is there any argument against simply
putting the clk/bw en/dis calls in qcom_scm_call()?

Konrad

