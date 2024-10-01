Return-Path: <stable+bounces-78487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBFE98BD42
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDA628351E
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12B11C3F1A;
	Tue,  1 Oct 2024 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJzsN71R"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075219B586
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788579; cv=none; b=tNNM5BPzpOXvljtu6qT9LTqv1hF10EZ7LZdUhDeodO5jLZ2sDi8VwYWwn7m4BNwnf6tX6mZGUPxPQ2bMARkHj7aMhufw12ExtTyNPbuS1DSzqRXMG/5i3O+nw1a5ZzA/Hw1dTRiNsSzZSwiaONbXsIR5dclebE7mDzeRP0teh2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788579; c=relaxed/simple;
	bh=SphjmvuLEZ6VwxhylU6m9PzzW6ctLAYwq0OeKfZwkn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJ+HVRZdkXuEBsq6iWXn/AJU9CpsLuKHHjf/F0MawJBw0c3ohggVo5NBMg/2eeGOxkmHAfTMBmIyZr/q+S5dDt6kR4O4F4qWEYcUCLKawqWMWSsAwGCBg2RdZlIMd4WEefkCO46W28AItrdpGseAM3zEC9kN0G6SXZrBu01t+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uJzsN71R; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so51117065e9.0
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727788576; x=1728393376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCUKSO7TqyiJ1z3fgZLfVcDRg4l4+3m0QHEoxBrdiKc=;
        b=uJzsN71RLk+hRNE1DChsljgAvYO1l6ymgxDQ6EKKyUBO3uU5vp/mxinl/5FbMPvWWg
         n5rv2WPLrSVLS3xRqGkN0oJUWKsKeSeYJqbhI5wGpOLNZGoTnLHKzrHSt0LA86e4NNjj
         ReudZG28bogvTwyVECGlYockdPMgWkw9hu02mjxVrXnY6H8Qg49lqEj64ElZNRjF9lsC
         Wbcs1lGkullpywVFQCKfyfPoWzDnn3wqELmgCJwXJkPYDcZn3XoZlWooOk2/PiT2+N0A
         OeDZbpl0Aea32tW79lUzSStT3/mGK4q/u1snF+KX+hJDsRjG1bZNaBNweArKWd6Nyt8t
         TRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727788576; x=1728393376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCUKSO7TqyiJ1z3fgZLfVcDRg4l4+3m0QHEoxBrdiKc=;
        b=V8KKzgA+LPpziAwIqmhmURn2sdjQqwlUv0BxAKadtrBYO9+KHoblrVjP4FvEYMFC7q
         ppzDNp/kfvWIvdM1FAS4Zfsof5UgG+7gMVW4x+8LMXGKtJRH8ALt1IONeRAXHc6iYkWc
         sz5QhljmI0vJ4530TU/eiDqABCEQHWGU/5Dts+av6K4VOHl2nSgBuHanPfvYmeUll0S4
         h3xdY/m4kKW8iXWhBb+Tot2xB7X3fCWuddP04oU5GlcJ6e/6fKlETEJTTJtkNhP0fHsQ
         CQ9QvByPSu8BilGEMiqEf1ByonpNXE5F9t2XNQqApF4HyhPB1R8d40XoWt7AvOPqV2Oj
         sTBg==
X-Forwarded-Encrypted: i=1; AJvYcCV2XapRV+ewCKf5pqzQeGm5Ar5JsY6CA0o3SM1o0NkWnCFqnw40PWhtYqIUsKS5EVdWJE+wa3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJCx7GcoHERMZlme0dZSELl1AgaXuJv5+tXjR6FnStbrcHUni
	rVaGW6z5/CeMYeA34d/ia0gSBB80nVSdTPTZRkgvXRAtnfIZnYNSyv2ApNdiHlj0N5AmiNsspIt
	H
X-Google-Smtp-Source: AGHT+IFYFLL73ccrBwBibPxyfq744YkCywyxiQlshKzXuKY6LgkOPSz6tl/XMMSWjgKaxCz9n+sJoA==
X-Received: by 2002:a05:600c:3b85:b0:42c:acb0:dda5 with SMTP id 5b1f17b1804b1-42f5840e782mr124390675e9.1.1727788576251;
        Tue, 01 Oct 2024 06:16:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7001:d575:d71f:f3b? ([2a01:e0a:982:cbb0:7001:d575:d71f:f3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddfc9sm180792055e9.5.2024.10.01.06.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 06:16:15 -0700 (PDT)
Message-ID: <8f61f1e1-6b41-4b1b-b00f-249901df320a@linaro.org>
Date: Tue, 1 Oct 2024 15:16:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spmi: pmic-arb: fix return path in
 for_each_available_child_of_node()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241001-spmi-pmic-arb-scoped-v1-1-5872bab34ed6@gmail.com>
Content-Language: en-GB
From: Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20241001-spmi-pmic-arb-scoped-v1-1-5872bab34ed6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 01/10/2024 à 14:55, Javier Carrasco a écrit :
> This loop requires explicit calls to of_node_put() upon early exits
> (break, goto, return) to decrement the child refcounter and avoid memory
> leaks if the child is not required out of the loop.
> 
> A more robust solution is using the scoped variant of the macro, which
> automatically calls of_node_put() when the child goes out of scope.
> 
> Cc: stable@vger.kernel.org
> Fixes: 979987371739 ("spmi: pmic-arb: Add multi bus support")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/spmi/spmi-pmic-arb.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index 9ba9495fcc4b..ea843159b745 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -1763,14 +1763,13 @@ static int spmi_pmic_arb_register_buses(struct spmi_pmic_arb *pmic_arb,
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *node = dev->of_node;
> -	struct device_node *child;
>   	int ret;
>   
>   	/* legacy mode doesn't provide child node for the bus */
>   	if (of_device_is_compatible(node, "qcom,spmi-pmic-arb"))
>   		return spmi_pmic_arb_bus_init(pdev, node, pmic_arb);
>   
> -	for_each_available_child_of_node(node, child) {
> +	for_each_available_child_of_node_scoped(node, child) {
>   		if (of_node_name_eq(child, "spmi")) {
>   			ret = spmi_pmic_arb_bus_init(pdev, child, pmic_arb);
>   			if (ret)
> 
> ---
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> change-id: 20241001-spmi-pmic-arb-scoped-a4b90179edef
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

