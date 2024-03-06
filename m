Return-Path: <stable+bounces-27005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31525873B9E
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 17:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DEF1C24BC4
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 16:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC15413BAD4;
	Wed,  6 Mar 2024 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZE7iMA6z"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A013790B
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740992; cv=none; b=QKV8aOumaDWPXjPShZBKnG5QZwueG7p1bDq+/dqTfNzPOh9vSGn+1ELIiJOBuWt8k+XDJibH+F4gd8+H0mqxs3UoLEarQMpFQOonFWMTVHfGKskAaPeShev7wvZ9mNBk1bHcGtfqKvy5vkQAiwOx658YKZawPS2L1rzBuYSSmtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740992; c=relaxed/simple;
	bh=R9r772f34HXHijYnV2MOXV7FUE/0NkutRga5zVmy9a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ipq1bcMJLuKAfK128ou6LDAm7HmqM+HlXP8J9Oo2sxGJpiqylOCBSsBw4DDUgfkR3X+sODba84r9leUiRfmmsHoCJWlsVfG0jbtn7qD3MZ0Keq2UWeB5CBnU20Wuo7X8qCU3DkKX2huKp7W/0DOWRrgPws9s3u6q5C2CTkwlyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZE7iMA6z; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5135e8262e4so970588e87.0
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 08:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709740989; x=1710345789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9MfW84pQmInKasVchKxLCBjmSCiqOVONg69XqoBKCw=;
        b=ZE7iMA6zxC7PEFwvziX637n4cWYjjfWv0hAutTBML1bwBdziqpOB2dhe/WqZJe3erl
         TYJzSbpN5eQW+NvXdufQyHRE61Mzm5buhJnwwi6g1XxBmqx1z0MTCo8Hr/qf3KSwbi7W
         j3qWC6owpoKFDNL2P+nbr4wZ8z1oTbzDUXICv5vjs8+WplLINHULUVcUpULC7De9sFHL
         3cSFxuB50SqLyxQYjateuQI3cb/n9Mj38HKYjkA+26as46IpgBeUTBm0eINQw5niKkRj
         FrxaZGTO/4PCTFzNxM2dFwLjArRsAmflzq+JpP05QcOUFF4PbpxwvWsf4f9E1SyZGq/K
         02rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740989; x=1710345789;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9MfW84pQmInKasVchKxLCBjmSCiqOVONg69XqoBKCw=;
        b=lzgHAB40FxyU+WeVYPBbR82QarQ3ixtu2gKu39QEmtD+aB65lY/zs2VppLZSXe8dig
         OW3pa9wvDACBeU30HdoHGY0sXhr1ITJpx11pXZ9AivphL066MCogwFGsG7nWLeGIvkgf
         MNWIvo7uFCXq01ZJyG/vNh/cVzU56jdS7nLcXSe3AnDrlQ95563Y2G0m/GvKoiftTIG9
         AjfqqU+jkvVAym4lDeOlOdlkI2m8sAxfhwDZGmg0M0iFJu2tz38g1PlGTNZFUPgWsq2R
         ASXFHvkz44PtyYogRE1UIgyux0QBoQmxDX2/W+l7pM7Plev67o69BdfoeahU8ofQjvM6
         KOVw==
X-Forwarded-Encrypted: i=1; AJvYcCXQqZD6Hfx6Siae/jTHfUNRIGwfxLPhGdXgkP9TpPWAMARS3/g6yCn60IkmMF31s93oZ+Q6DKCjACGjcnDOqgMMqVIshd1D
X-Gm-Message-State: AOJu0Yytk2gGjeBPhPFKLqoKEK0cif1q+VPuicJ85n6B1IMpsIGWGPyq
	0HdHhcpsTbmGqArBUVqo5wL/W2maX4HJMm4Spja90zeNF/OTnOxou6GEAij5cQs=
X-Google-Smtp-Source: AGHT+IHOB2NN7QC1FZy5/GvqwVh+kS2gHxn4TnbcM7tZzRLNsrdlnJEIMaHR2HnCSghLIEkxdL2HwQ==
X-Received: by 2002:a05:6512:3d8d:b0:513:57fe:97b8 with SMTP id k13-20020a0565123d8d00b0051357fe97b8mr4013094lfv.26.1709740959029;
        Wed, 06 Mar 2024 08:02:39 -0800 (PST)
Received: from [87.246.221.128] (netpanel-87-246-221-128.pol.akademiki.lublin.pl. [87.246.221.128])
        by smtp.gmail.com with ESMTPSA id m13-20020a05651202ed00b005134c52debbsm1076665lfq.162.2024.03.06.08.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 08:02:38 -0800 (PST)
Message-ID: <2fdb87f5-3702-44d9-9ebe-974c4a53a77d@linaro.org>
Date: Wed, 6 Mar 2024 17:02:37 +0100
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
 Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
 <d655a4db-89a8-4b03-86b1-55258d37aa19@linaro.org>
 <20240305200306921-0800.eberman@hu-eberman-lv.qualcomm.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240305200306921-0800.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/24 05:10, Elliot Berman wrote:
> On Tue, Mar 05, 2024 at 10:15:19PM +0100, Konrad Dybcio wrote:
>>
>>
>> On 3/4/24 14:14, Gabor Juhos wrote:
>>> There are several functions which are calling qcom_scm_bw_enable()
>>> then returns immediately if the call fails and leaves the clocks
>>> enabled.
>>>
>>> Change the code of these functions to disable clocks when the
>>> qcom_scm_bw_enable() call fails. This also fixes a possible dma
>>> buffer leak in the qcom_scm_pas_init_image() function.
>>>
>>> Compile tested only due to lack of hardware with interconnect
>>> support.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 65b7ebda5028 ("firmware: qcom_scm: Add bw voting support to the SCM interface")
>>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>>> ---
>>
>> Taking a closer look, is there any argument against simply
>> putting the clk/bw en/dis calls in qcom_scm_call()?
> 
> We shouldn't do this because the clk/bw en/dis calls are only needed in
> few SCM calls.

Then the argument list could be expanded with `bool require_resources`,
or so still saving us a lot of boilerplate

Konrad

