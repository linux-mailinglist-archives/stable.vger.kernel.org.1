Return-Path: <stable+bounces-99922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F189E7446
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8292A16BEC1
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A129020E707;
	Fri,  6 Dec 2024 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bN76madY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890220E339
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499188; cv=none; b=RUBCFKOe5W+H37OO/Ape6jC0b/xvKd+ly7Al9u277WNEndy4W6BgmqhVIVNDRiHXgQd9y/nZc9OjabO69ocPkoL8q62N7A5/ISNATLsSWLPX1M9WAlInSuWtA2Gw0e5whij5awNAXwAj69UZUbLJs6MLUfB6+iLqElb0oMw52EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499188; c=relaxed/simple;
	bh=YbzJyTv/oTBDHS1yAIVmtG9Pfe0m29H12bVn1RFZ3Ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2cL9VSswop9SaxFgDN6qBYI9Blu5Cf3A4wYWdEQkhI5lQRPj/N831E2YFMGFBYLJLdK2OuAt31MgtA5vEvXXx0OCZSgObFaA4/tnzR4g+abNhDUAX+osKlNmRWtbizIhQcvSjQqO5Tf/9GuLw2nlsBiP4RjkqT8FMIZdFNd19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bN76madY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4349fe119a8so2668835e9.3
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 07:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499184; x=1734103984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxLilH9bLiMPjJPMsLhe62iLYudDtWX7jg4MWEe1Wys=;
        b=bN76madYN2Mt9+A1/zPPgWsPI9Uq+WLlbRMGdptdTuZnMoX9sWq6CAL8yAiNkVdmT+
         u6+/25U11u7Or9z4moUpgTqdYfg4z5XLalLucgn0GiMQsvWjZZdPzqYdnHFxY/zB/fjl
         BY/4RIX9oAfPyQmWhu3c2ffqx8K5eqqjQdCLC31ADvYzeA5oFQsjAQXbQNNQy2uuSiHf
         f421/GXXGx1ym7U0URSZ1P/OMuMfD9z9JcXPbNrkYFrvw5BUK+uU1dCqzjBmIO4EHw7c
         SrcsAxkbD/TY5xrnTD9IvsOOW5KpeIjoriroF/2hMiHJDE5XVG2chTiC1J/KYE8/fNZO
         4LGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499184; x=1734103984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxLilH9bLiMPjJPMsLhe62iLYudDtWX7jg4MWEe1Wys=;
        b=lC8JT4owX1Wxpdxxbiszj6+h5exYrzfKGDB/apAzSAyJPTyeJmavTBPMwwAkyIJ41H
         ZO4sWfIsG8AS79QNfdnGHj72XS4ucYOSocDexK8vkTUTtoTZeMh1NJy7M6IDu5gLNfxZ
         M0QaWYTlOD4T2VXitZYsefVznM4L1sMibG5WhPbfU5VjHbix9dASDWvEFrf7KESUo3H7
         5kQxolaP79R4fypP9kobMPulnaj/ZyEbYjhe7MJXQyIUmGQq7PlN9Jy4ePLCQziKdAIf
         mFib5A2taTAd1aeVkc2VvmjfHtiTckysBQpyQJIb4o0qJXV58n7tmaRKqqinOgIj9vAk
         zt5w==
X-Forwarded-Encrypted: i=1; AJvYcCWqroRq9TwWnawnBbs0vuOBo21YH7JlMzSkTlJ4xoO16rBiOvfCyGdcUgWxbfxUW5Z0wxZfCA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNqn12Hjj+/PT2zAQ5KFBwRnZ0tcAuveeY/DjI4uhelTu2PU6k
	LukxqUt7GbSW9gCaqWcybTOAjEm1++tnGb1xc9TM0Z92U+o3NzMnpH+XB6zHgTo=
X-Gm-Gg: ASbGncuuaxzZrJkKBi2HFvdLP5tYlCjBNxbz2QrtPhWcVac7TVt/ZRgeht8hHQVKdyo
	UDvCeptQgfPjmdRDSHI8UjU2sJUJ1/EwI7OZiR+RYPGoNGXU5dj0lB9rqBy4xmHdLxiklBh8N2a
	j9IGUkzRKMZX1wZo9E7K7hkdarWw6eb/odfQzgfmAXDzAd5RcMeXR0YqG+T7rJrT37XDuHU8F41
	1vfGA7RPqoMvqn+dU5bax4eVqIzYZUVVoCuU9vN2ivPzGKflhFbhmfoyanaRS2mQA==
X-Google-Smtp-Source: AGHT+IG/VAhXZnoGXOnDEIW9ftM2ZM2FPS1lrP1HyDeJwJANTrBVm2ZrnFq5fp7A4yZz4UPekl0OCw==
X-Received: by 2002:a05:600c:1386:b0:434:9cb7:7321 with SMTP id 5b1f17b1804b1-434ddea7919mr12495145e9.1.1733499184662;
        Fri, 06 Dec 2024 07:33:04 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm61158035e9.29.2024.12.06.07.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:33:04 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 06 Dec 2024 16:32:32 +0100
Subject: [PATCH 08/19] arm64: dts: qcom: sm8550: Fix CDSP memory length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-dts-qcom-cdsp-mpss-base-address-v1-8-2f349e4d5a63@linaro.org>
References: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org>
In-Reply-To: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YbzJyTv/oTBDHS1yAIVmtG9Pfe0m29H12bVn1RFZ3Ek=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnUxkUIN3YPoGxYSFq4JGa3HxEIGuSgtmACqK/L
 OD+p4WDwKeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1MZFAAKCRDBN2bmhouD
 16KeD/9IAl8RjhKYTokeVJApO7vVrOAknRXcqnRh3B/yrWo6v9hvKoSHu6wiDzYpbegm4llFygG
 8R3ITsRh6PwR4o1GprrcpwEnvMDxYvrBcQH0lNFWXabtzBz7CNoTAb5qpQzF2gJDtf2zrUvz0oB
 RoThUOAa0dQB3F/vwOd4/3xiCcsf9iJnf6TEmFNKuxWUxWCdvpjs+otoHrb6RSykxdTGIMDBYtN
 PnDq3QKLkQVa+2+gSOpxljnzhX1Cw2Sv4RQZMcLRVwb1SFffvybMHkoBEq+Kk1ts3CJfP8OCN/g
 HD17zdMM8JPayOaHkFp1i81TfG3hvPl09Og4CfZg5BzsRzIluOt4M8uZIuRIlsyv+PFM5OpLex0
 LvTk9XTJ99cxSXtQIkaOHCyBNkZ7B/7c1Vcx4I4rx87/Qi7sJAs8/n0DMatDNIhhXO5IV69OB54
 eHaX563uCb+Opjno/QafhUaVxseqDM1OOWWrta3sL/5eKHpDk7I/oebAp5Anqt0RNiE2YQjzGiY
 WLSibPLiNlAdm3JewEvegYFLYei/U5dTx5buoT1N+rjW6+/SGxKe99InGv88CvsbeZ258hW4SAB
 BObuU2cIuDdkAe4JOMf5wVQYI3Vq3vdhxuCsCyXL8vOdXn19/rDjuUfII5GE16DClRNtiqDPzw+
 HIxYQnXMeKz21qQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
copied from older DTS, but it does not look accurate at all.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: d0c061e366ed ("arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index f454015c5b90c7d792c01bf85256812857d79c64..541b88eb5f5300ef9e20220305ff638db9b2e46b 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -4716,7 +4716,7 @@ nsp_noc: interconnect@320c0000 {
 
 		remoteproc_cdsp: remoteproc@32300000 {
 			compatible = "qcom,sm8550-cdsp-pas";
-			reg = <0x0 0x32300000 0x0 0x1400000>;
+			reg = <0x0 0x32300000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0


