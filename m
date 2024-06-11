Return-Path: <stable+bounces-50164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F86903EA6
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 16:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730DE2822B8
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8AC17DE1E;
	Tue, 11 Jun 2024 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rmqmor8I"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D117DE02
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115963; cv=none; b=GZ2W6ZKRO0tc5OvHwCcA4oFRh14UIUojeYJNF30vp00nnJ0fcECWtTAqlvPoUfQbssSX6MGLc0q+UPxkb4IrklXoReydOfNbGmTZ6JaCcblrh2KoxhmVH+rRlPy8q+8PvCffmD26RxCG4riSjy/MjsiIOVUqmxIxR9rkNPE7ZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115963; c=relaxed/simple;
	bh=jTgcJ6I9f/rRMv8ZQvu6QHiOuSVE1U6c/CD+DvrI+aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5Y1J/zsYkW0Ni2iRc9jKwt61ZsAmkAcWifkv2Nd7lhGSIbUbTcHy3F2Qe5VFdsNZHwHqCjBv1nbL+lqq4g6t0c29rq3sQUvZeGZH9sAOUi53IxE9Cw22peEZe50V6/HczJXivfllpJz+1NpNxDnosNH959gppV24qN3/N18Tjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rmqmor8I; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6266ffdba8so473087366b.1
        for <stable@vger.kernel.org>; Tue, 11 Jun 2024 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718115960; x=1718720760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEIGYp+wGh2VjZ0I9sLID7yRBrttreOePBUNcFhAtA0=;
        b=Rmqmor8I6jAEFEwF831mIAawoeA/3BBfBS16C2z0mD1y0GfHvnXkb4Uw0t4RQ5pqYg
         LHrdBESI1u/818rvowDNiO5nQvoyrGiqOD0hS2ymM/J0D1hMfXV9XXhVLWdJ0nlUMviw
         Z0H9BjWRK8Hfu8wwpD6wK9DYPrM46XXH91yChEC5Ocbl5enkeKRvW/4khvRbEyi2UH7d
         Y4H9Ya6Ou0MhCxnmoKGewM5FdTXYaKOWQQ+oMyl37Sb22hzpswnLXv71gLvBX65wo7EI
         N27jHiE7DgIGhHsRaFnDEX392AFrPJw7CoWVZtrlLW3sNGA7lGJmXqBQ419pxJYdbB7W
         xa6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718115960; x=1718720760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEIGYp+wGh2VjZ0I9sLID7yRBrttreOePBUNcFhAtA0=;
        b=d0BSHsR1Nbx3jQf2zJEVHPE0i5vKazK9fJLGjbCxkmfCtWNIbEXmUPxymqKNG0HjiF
         s3l9G8MNIxtly4mLH3r2MND41Vl/6egkOy/GAbt0O7/bEkXPFJY9IfRlRaAkPPdgMvEf
         jv1Rd1U+7QwSH5DM/QgEdpMznXF0b26dejPsUKK0TkvG7a7FRSnDK0C1turxBRJDN6LH
         fXE29podEAXPUZhJuU6ik8qSElN68N+6B/HRNJPcQAhK/xofd9S48e06Nqarq6+PY6of
         aNkoW1bn+omcmwjKX6KIyyZqcWkz3fU5NuKYsDZkK3HatuRzoLidjMiLDf5ZBqbd5Bxu
         HySQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyAx69NFyuXrzEJuN8/3HCt937q2KIuef4YfdAC3qxGc5dSDyjXpihNd4nEHxA6hYlNGzM4tFIHkOejCrkGWT5W4aCJPmE
X-Gm-Message-State: AOJu0YxZKxblX7x0gjy+l+WT2nk4/RxU58g4LHb0yrfW6mGLXrm7kD21
	lOkB5fsIMhUD+3sBIiBK6SfnTRVnVgCUHCpL6K+Vu0O3/GbhwBpEtv6BZAG3GyY=
X-Google-Smtp-Source: AGHT+IH+rsh5Ih113GwCiPSGW2KUD3lICD/Laz7ogIuvQXHqM5nyY5Tw1tvqnk/4FjQ38ojd000sDw==
X-Received: by 2002:a17:906:68c5:b0:a6f:2d5c:5c8d with SMTP id a640c23a62f3a-a6f2d5c6342mr272886466b.30.1718115959823;
        Tue, 11 Jun 2024 07:25:59 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef83ac0c4sm518070666b.74.2024.06.11.07.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 07:25:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: x1e80100-crd: fix DAI used for headset recording
Date: Tue, 11 Jun 2024 16:25:55 +0200
Message-ID: <20240611142555.994675-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611142555.994675-1-krzysztof.kozlowski@linaro.org>
References: <20240611142555.994675-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SWR2 Soundwire instance has 1 output and 4 input ports, so for the
headset recording (via the WCD9385 codec and the TX macro codec) we want
to use the next DAI, not the first one (see qcom,dout-ports and
qcom,din-ports for soundwire@6d30000 node).

Original code was copied from other devices like SM8450 and SM8550.  On
the SM8450 this was a correct setting, however on the SM8550 this worked
probably only by coincidence, because the DTS defined no output ports on
SWR2 Soundwire.

This is a necessary fix for proper audio recording via analogue
microphones connected to WCD9385 codec (e.g. headset AMIC2).

Fixes: 4442a67eedc1 ("arm64: dts: qcom: x1e80100-crd: add sound card")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 12a4c4637baf..05e62d9f1cbc 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -102,7 +102,7 @@ cpu {
 			};
 
 			codec {
-				sound-dai = <&wcd938x 1>, <&swr2 0>, <&lpass_txmacro 0>;
+				sound-dai = <&wcd938x 1>, <&swr2 1>, <&lpass_txmacro 0>;
 			};
 
 			platform {
-- 
2.43.0


