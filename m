Return-Path: <stable+bounces-6635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A7811D4E
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 19:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2242B1F2147F
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 18:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9438061675;
	Wed, 13 Dec 2023 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tqRKP0Ma"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246D7E4
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 10:47:33 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bfd8d5c77so8443939e87.1
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 10:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702493251; x=1703098051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLN2dhkia1LQwK8gimJQPztmO5+yH/eFHely6bd0W6U=;
        b=tqRKP0Mauw7qtoq3BZxp0H8mtDNhWxs8X8mho6Wy7/XH3470ZAkRay6HHI5omvhKR6
         adY1GMCS7g+GUmADmn2ELCIQax4OFq3yjBMRA+b7IfH0mS4XMF4SJbLtfrhafn36hFgd
         njdndNDAZgflU0YdxeP0jDQl573MM4LI4VPZH4lSbZk2ePMkXHsyj8mIyafDv0TRIaWb
         37KhJbnsHQf8iaBg34fvDrXpmhGJ4hTF8vMGiUpTvH5RBF9QgkhRHLebDsIigj8qQTt+
         FmAhQI/R9ODUWc2RHRYr7oFmtSGaMcmfN8P8PAbGL0xOlqF3X5BNv11ukggtq/RO3zFY
         Cv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493251; x=1703098051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLN2dhkia1LQwK8gimJQPztmO5+yH/eFHely6bd0W6U=;
        b=K3VqEGP0AQP7yX4ewT8pTBbQwrt8LAkIradg5B4UazLmW8Bc3XEuPYbEkCboBsDk+v
         zPMiUJhmmEWhF0XW5vBOEZG7ZQC/B4kthT22oT1jYIrPckPRApi5bVqKkYNU5JgsRQDc
         xae1NpyzzBB4eskPxDmBR1GStgh4xcBNoSaZoatX1m1IZ7oyJ0/uuZRp+o+mHRAZF/70
         4SwhcndET5RRVN3ViwP1vEZMI2EJaGiImuU0aBvTrlaSoPWfW2wQcd5TW28ayOKzryIr
         xXNCprkrw4mI7UEIBofVAwb7ncHL6AAjBDzgFi/bN7dl7kL6cWJlwuUPoEGEz19B77jG
         L3dA==
X-Gm-Message-State: AOJu0YwKu/iOZktA6x2eyEdnT4q2wLdvGKj/BMqAS4E1YsuRgK188nTp
	/NEPLShlCyu/vMdAG1qTQIzl+A==
X-Google-Smtp-Source: AGHT+IEaqMvOYhvY8FE/3LLDRyRP+xGD4h1A37XVeFl3tBKn9LZnhoj+UYXbCVzinqUDMG8CZp6KHA==
X-Received: by 2002:a05:6512:21cf:b0:50b:e29b:2f01 with SMTP id d15-20020a05651221cf00b0050be29b2f01mr1775813lft.264.1702493251329;
        Wed, 13 Dec 2023 10:47:31 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f12-20020a19ae0c000000b0050bdf00f688sm1653687lfc.299.2023.12.13.10.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:47:31 -0800 (PST)
Message-ID: <56280966-834f-4410-b055-a314583a64e5@linaro.org>
Date: Wed, 13 Dec 2023 19:47:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>
References: <20231213173131.29436-1-johan+linaro@kernel.org>
 <20231213173131.29436-2-johan+linaro@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173131.29436-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/23 18:31, Johan Hovold wrote:
> The Qualcomm PDC interrupt controller binding expects two cells in
> interrupt specifiers.
> 
> Fixes: 9d038b2e62de ("ARM: dts: qcom: Add SDX55 platform and MTP board support")
> Cc: stable@vger.kernel.org      # 5.12
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

