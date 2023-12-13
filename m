Return-Path: <stable+bounces-6638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F900811DBB
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 19:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3D81F21AB3
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 18:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4383364CC4;
	Wed, 13 Dec 2023 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wL2/tvgl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887DDC9
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 10:58:46 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50be9e6427dso7778304e87.1
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 10:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702493925; x=1703098725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9DowOQy/Sxl1JmlMV31xqpgcOa6MjD1E5V4uWjGVTE=;
        b=wL2/tvglytQn4XXQaXnjOfyh7LNUVZusOBiktTp6SLSeVwa09JwgKbw/xGIobEJSuI
         SYF8wmOV7wOiFHCQTwGQxNxNqBdhmPXbUSmD9pKuZYhjOGRiRUrEBwZo8uRpXy4gpQP0
         SPf1xw+sUOqkdnyrSXS6kyPfjJkGRSv1cKV4KHUPyAplDuY9Ua7fX4v0H0lCOaiTyczx
         GcWNmNIaJNyj5I02IJd8s8rcZb7CV8dmjCDIc/rpT80ffz9LvJhFV9UmciSl0Zuc0N6Y
         zUBmD/BxvmQskVBb5f5HLd70erbUc0Cy1kTJqkhaZ4kebLSXH40qLbRr12haEtdlMwIb
         Sy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493925; x=1703098725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9DowOQy/Sxl1JmlMV31xqpgcOa6MjD1E5V4uWjGVTE=;
        b=Fmgnra5tHT0VwUGeNEOQKydUYgE0FYYpvVKnFXlPlife0GxsBCL9wuLNSujaM7LnRS
         UArn7U6bpgzPjYG3aKPVU43g09p/2CVZ/BG2LDdDXsL0JymVfbcdITf/OlmMHo4oQaCc
         Nv2LILCXtSRIBlv4AkHadvYlCE8ja+A89+LyXhwJ91r87sH1yMCfWVsKPShohNHfo0pp
         CrihiBa4G0AMZt7LJ73dgR0Z6VJSnWOQQl1riaQb56sOrVx1ZF/Rf+Khee9YpzhOopIA
         gPF+38k1Gg9WH+thitl3gtkXrqiNUX+bqAHsClCySpIdJJNcMViqB2DfS+Kj+bLUY0eJ
         +kBQ==
X-Gm-Message-State: AOJu0Yxg2ZWS85vOwhAM4gQy5maJ1ysyYab2pCWEhcjIMfBKuFt2AJZl
	EAze5bheWZTsJDm0lrRpE+dgy4lM0ZUbDtKf+rmgpvfs
X-Google-Smtp-Source: AGHT+IG9XuroAkQ9UfAcWZUQQ+IDHc4FOLDEE14HErVjpjowcti0RuDxYZzjAuJXvBGAJCWeEMO03Q==
X-Received: by 2002:a05:6512:39cc:b0:50b:ec63:8cf with SMTP id k12-20020a05651239cc00b0050bec6308cfmr5992226lfu.21.1702493924800;
        Wed, 13 Dec 2023 10:58:44 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651206c400b005009c4ba3f0sm1680336lff.72.2023.12.13.10.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:58:44 -0800 (PST)
Message-ID: <fcdf32a5-4efa-481f-9387-df94f08db7b1@linaro.org>
Date: Wed, 13 Dec 2023 19:58:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sdm845: fix USB SS wakeup
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231213173403.29544-1-johan+linaro@kernel.org>
 <20231213173403.29544-4-johan+linaro@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173403.29544-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/23 18:34, Johan Hovold wrote:
> The USB SS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states.
> 
> Fixes: ca4db2b538a1 ("arm64: dts: qcom: sdm845: Add USB-related nodes")
> Cc: stable@vger.kernel.org	# 4.20
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Matches ds

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

