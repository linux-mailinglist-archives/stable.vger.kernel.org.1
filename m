Return-Path: <stable+bounces-15789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4366F83BE28
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 10:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF53C28B325
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 09:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BE11C6A6;
	Thu, 25 Jan 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTRTDKBo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEB01C696
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176793; cv=none; b=TiPj9o60zd9pBGdT3KcDuIjomgPkbAQADCsWp2wjFceT5yuEOL8wL3NV5s3rynhHU8AhEi62N7VHPUJUA5lKABGWBf65djuEZi7GFAIF5T6pkL9sYhOzObWggvgmhkQ9hUYSQgr8PuLpoTPO98foHZIpWnxES81Yb+hrbIfebRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176793; c=relaxed/simple;
	bh=ApUQmlkxa81ceXyof4WusvA21E0Fg32BgwslQHx9PRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOGfXeTmj7/l79CUwIWa6CjckctxUKR27UGg/TNo0N5oykHo0jrESwvH4hGhp5IB03/UIWYjHdSnAHF+BXOTozJDkNLUgAy8ljdrU02He6cVR9lIDhDN1iWVm440ChlLV+GqIZ7Jp7qhm02WWeaZkBn08Wdyp4ZBuz4QpRcz98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qTRTDKBo; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d2df857929so1797604241.3
        for <stable@vger.kernel.org>; Thu, 25 Jan 2024 01:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706176791; x=1706781591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejpu0N1U5cHhvf5maKcL218cl9a8A4V67n7tDOsobsg=;
        b=qTRTDKBoYEnBJVmGeAriqheOMCFgxFbGYja3wAvgRE5HN8iuDw8iMUAZAFgk1THjY8
         v8mseMujNwe4eKVXEMjrvoQ739+R0eooTNGGKDH3FViaoFRohnqL9iUif7FG5XaiVL0k
         hun1E7xOdKoUVkHnVKBeCV9KxqYVSQTLe3jGzBRCHM5mqifbTS5YestLbj4T5nKFufYy
         gadrWmmzpvSLjC8DeI7D9ZpcLwYmSUhpY2hSjZud5wUvLDCXDby9tX5oACrifV07jyBt
         C4S8ildnTdqMAVAaMHlA/mI4HMollFf0aClTVjxgkmei6GeCIamHJz0NQGOpmORq9ihD
         spXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176791; x=1706781591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejpu0N1U5cHhvf5maKcL218cl9a8A4V67n7tDOsobsg=;
        b=vacapdMb9yCvSw48+4t2i5uGRgRfFbqBVOPD1wq6ROJB0RzfeoylZDmKToQ2BqDlpW
         VABEDV+VhjpANLL+iAP2GyPXMW+o6W+7v4H+HEtRC2bc+5CM70fqn6sUxzfbmtWX6oKb
         Z/8S9ko/xd/evb/Yb5JaxllHDgj4gmsER7h3EtnO22AoBRfgqIQvJzBDTQuNS8HhGWRP
         R5iOw0jhbVvh/j3yxM+kD3PDPGsA8Z3Jja72BCv9+UCs/4TSJRRX8u3CFKNXrWIY8sFk
         +4MP5Y7rZrwkcLcDq8bnihQdGgOxPcEYF2lGkFSAbzw8f7Ch14c+/vAhw0G0z8V8sEa9
         qIqQ==
X-Gm-Message-State: AOJu0YwFntu/Yl461hc3GM1BnFj2BBv8QXRVdnO6T2jqsPJ2Y69rtOCA
	9gBmkozBCwTxLutKzAwRk2+sglOKc6shNjMiLCw5GUfamC3Hcb1Mzqf+g6BdZP8=
X-Google-Smtp-Source: AGHT+IGcTSAtyt5YyT/kCBTYuBr4kS+3tQLcpFk3BxLBOchKz3KQftdbjqQ7cAMcDL/VuYKBY/YQQQ==
X-Received: by 2002:a05:6102:3c96:b0:46b:1013:16d7 with SMTP id c22-20020a0561023c9600b0046b101316d7mr607038vsv.12.1706176791010;
        Thu, 25 Jan 2024 01:59:51 -0800 (PST)
Received: from [172.30.205.155] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id qm17-20020a056214569100b006879b82e6f0sm375625qvb.38.2024.01.25.01.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:59:50 -0800 (PST)
Message-ID: <d1cde782-c223-4400-a129-18e63a10a415@linaro.org>
Date: Thu, 25 Jan 2024 10:59:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm8550-mtp: correct WCD9385 TX port
 mapping
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240124164505.293202-1-krzysztof.kozlowski@linaro.org>
 <20240124164505.293202-2-krzysztof.kozlowski@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240124164505.293202-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/24/24 17:45, Krzysztof Kozlowski wrote:
> WCD9385 audio codec TX port mapping was copied form HDK8450, but in fact
> it is offset by one.  Correct it to fix recording via analogue
> microphones.
> 
> The change is based on QRD8550 and should be correct here as well, but
> was not tested on MTP8550.

Would this not be codec-and-not-board-specific, anyway?

> 
> Cc: <stable@vger.kernel.org>
> Fixes: a541667c86a9 ("arm64: dts: qcom: sm8550-mtp: add WCD9385 audio-codec")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

