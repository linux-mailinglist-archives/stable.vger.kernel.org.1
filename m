Return-Path: <stable+bounces-136886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CE7A9F0E9
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 14:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751DD3B3417
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 12:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B8526A090;
	Mon, 28 Apr 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/dOVDX9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B9E1DE2D8
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843946; cv=none; b=KmE2J5Bi7ShCS6IBhnt5D8/5DytOMDOOXreuXBLE1Xl6Wwt15CMbFJq7/cyDt4RcQan8LId6MJJ5CdN7LLNRt74in+Nt3MrkjHXl3kS+X6d9zBPY6THJ2NtMWH3CgtB1RXnZ34H+cIKJH9D3tlORYeTBkHLfqShkCjbyWqrtmz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843946; c=relaxed/simple;
	bh=5RTpoGxd0yln+rD+iVZT7mTbh5dja30gF/VvmJMuPCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0ZtyIzaZqTgfZuK5UhU/2qpq4/iNkeWsEWgnBevy8IlykjS2bp5flqWqUCodWnZXIqgTs6vc3pJiOn8pvAmv2LBiLKVUX76EW+F5B1E6qln8oYoVN0bb1uz8APihk/diiQmS5jDkm4G6bprcZnKM29sAUx3eKFuPZz9Kb/OLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U/dOVDX9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so3215458f8f.1
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745843943; x=1746448743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kajF+eLdT9ofXGeTd3YYf3HoPa+dzTPyEOJzZGW/Z3k=;
        b=U/dOVDX90X61jKy2N4cTdr2CnkzS3Dy9WHu8I7fD9N38vjtdThOlxKgPVAXJUzQslK
         E13uqbf4sX96mtBHnTxX1SRf0flQ0YWr9upe+IgvnkLYM9PyqKOVGlDgYyuio/EShr0l
         jH0s7pz2iYR09N5niQDUvKtmG3f+tawBTErbuQTM4h+YTtnM/+/DWf+TXoT1FcJbnLoH
         ltitcxRSY7eK6lT9vS21llzRSo05eYE4/4C6+a9uOZkqXrMcaWv1sso9W6IxToh74FHI
         Q5Db0MhSB7pYQI9xMOspOgkSI86h9/6kZBcHBk1gy6pzUKJoOIvF76bVRupCjeYcDumL
         jQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745843943; x=1746448743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kajF+eLdT9ofXGeTd3YYf3HoPa+dzTPyEOJzZGW/Z3k=;
        b=CplUNaiOuBjWVxqY7q67Fct/01vbv16OP5Akqs5CHYA/82+yVpx4jgBdJOf1VDN5o5
         Dxf5ajOOdkqi9FskOEwBgczfZjMWpqBlA4L8qGBLzjEnYKByPynfjjPzsPmJVWFuWo4X
         sGA8oeHPhi4lxknx37LWOZH+/VuV0caKLcH63RiOhuYGaMgJf1uDaCuZOq/Or10BTWVf
         UWaxI4OUUByLp1ThO/kVQ51fvlCGZ4OQPo3JubB8FypIoOLZWNziCTkF0Mq+jdlzXFau
         sabBTUSo/v/kzcivFU6gXWxmbp2NXVr9yTbbcm5hTD/9ZBngjUur1FLtGHKFoCNboEwm
         0aOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZi2btOfC8PfUKumeYZFYNCFaIRCy2ZaVLJ518BcOTMA1NhAlOxoBdjxaskIH9lA96gn9+bmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YytrFjP5fn0bc3g0KoSh6k/iheUaeTXckQGhISXWCLEd/ZHUWh4
	d5x3hIQVV7W286Gd8z3r4Vly2SWGvD4UH9yEIaxGUJDDMVi/P0lntTujxO1ZIhE=
X-Gm-Gg: ASbGnct+OVVsMAfh6CmgHh85LvPSHMdmK4rV27t2Z6n8yUTHpWwnVLUjB1ueDkbv1TO
	y8RYXQSCjD/Wh8JfXc3RszQRMkkH+BfRjtsYlZzRhJDtav182dFgYGFk2ap6jQR76GYS6ZJFwVN
	3d6r4Ho3e7nupQjHAKAXLRyWDrTIBwtLCyluyWOR5gKF/kV9b+ZigFtqjbCAhV2WPMo5Hjj7f3E
	hBSCbe3WXkCoT4IYhKC5HuDv0SjCnqQQtt2Yt76wnoXWDXxBf8mmja/U3XhLG4xGrVQMk6CXeN5
	GxAwbCbNWS664RVFgi/qxMFxavyBboJjSYyBAk4OXL05rg==
X-Google-Smtp-Source: AGHT+IEZDN+foaMYfgyt9eU6rOly8IkdyLaoYyUZbXxe0vM6gzcu4bTy/soXgGRLxAd0ZxJ3sOA5TQ==
X-Received: by 2002:a05:6000:1a88:b0:39c:1258:2dc9 with SMTP id ffacd0b85a97d-3a074fa73c6mr7995850f8f.58.1745843943130;
        Mon, 28 Apr 2025 05:39:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073e5cffasm11177664f8f.96.2025.04.28.05.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 05:39:02 -0700 (PDT)
Date: Mon, 28 Apr 2025 15:38:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Stefan Schmidt <stefan.schmidt@linaro.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	20250417-topic-sm8x50-iris-v10-v7-0-f020cb1d0e98@linaro.org,
	20250424-qcs8300_iris-v5-0-f118f505c300@quicinc.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 14/23] media: iris: Fix NULL pointer dereference
Message-ID: <02824759-c468-4907-b0cd-554c28cc4de1@stanley.mountain>
References: <20250428-qcom-iris-hevc-vp9-v2-0-3a6013ecb8a5@quicinc.com>
 <20250428-qcom-iris-hevc-vp9-v2-14-3a6013ecb8a5@quicinc.com>
 <7f37ec27-0221-4bb2-91f9-182244014b5a@stanley.mountain>
 <7ef2daa2-a6fa-2285-6619-b2f25baabc55@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef2daa2-a6fa-2285-6619-b2f25baabc55@quicinc.com>

On Mon, Apr 28, 2025 at 05:40:01PM +0530, Dikshita Agarwal wrote:
> 
> 
> On 4/28/2025 3:10 PM, Dan Carpenter wrote:
> > On Mon, Apr 28, 2025 at 02:59:02PM +0530, Dikshita Agarwal wrote:
> >> A warning reported by smatch indicated a possible null pointer
> >> dereference where one of the arguments to API
> >> "iris_hfi_gen2_handle_system_error" could sometimes be null.
> >>
> >> To fix this, add a check to validate that the argument passed is not
> >> null before accessing its members.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: fb583a214337 ("media: iris: introduce host firmware interface with necessary hooks")
> >> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> >> Closes: https://lore.kernel.org/linux-media/634cc9b8-f099-4b54-8556-d879fb2b5169@stanley.mountain/
> >> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> >> ---
> >>  drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
> >> index 1ed798d31a3f..cba71b5db943 100644
> >> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
> >> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
> >> @@ -267,7 +267,8 @@ static int iris_hfi_gen2_handle_system_error(struct iris_core *core,
> >>  {
> >>  	struct iris_inst *instance;
> >>  
> >> -	dev_err(core->dev, "received system error of type %#x\n", pkt->type);
> >> +	if (pkt)
> >> +		dev_err(core->dev, "received system error of type %#x\n", pkt->type);
> > 
> > I feel like it would be better to do:
> > 
> > 	dev_err(core->dev, "received system error of type %#x\n", pkt ? pkt->type: -1);
> we don't need to print anything if pkt is NULL.

Okay, fine by me then.

regards,
dan carpenter


