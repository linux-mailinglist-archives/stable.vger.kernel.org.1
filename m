Return-Path: <stable+bounces-185612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB95BD88F3
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 11:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519B65411C0
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4062F549C;
	Tue, 14 Oct 2025 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sdz6dm7x"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB82ECD34
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435187; cv=none; b=jpSDDeCcZdL1Tst8xI+xk07b3szF+WvTnzcWe0iwiwm1Q2AHzd9ecRcFn+fakJpvZKFaRLH92ICCa40OhBWfgsd0bhaHilF86VPOXD027veQHUNjyHc8HWeR+PvhzHVnxlKJF3mo6cvSMr3EqeJIXKWzAkue8TSI+P7/t/9Sj04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435187; c=relaxed/simple;
	bh=l3LysOIyApMjrPfw785wmo0UxKg51Ii7YvKFAglf7l4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WkzYYYhn4BNKoXsPkqfrrrb9PKxDugdD8rTZ9HFd5AYy9lHY767HKjfl2WhB0neQeeC8ee/Qqx7ee3cZtwiIYooPJc2wlSFaFv55DiQcwHeHK71DVhPHL0zFsifvkvemMyZw3uBK9MulwM5VcmENq4QC04pdGmwJo+iGpMwRVGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sdz6dm7x; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42557c5cedcso2742089f8f.0
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760435183; x=1761039983; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2bKZTYq6/6Otgm4/JoAPAscRI3Nhvh8qLkW+Q3h459I=;
        b=Sdz6dm7xsfA7VZo9QkVy16mjLcHWRBxWOLN4j8B83SuCgECZjSHfjh4pXeB0P3kR1+
         wSHW9Zfi1jGqEe89w+iDWNNI7/JuLkSor4sbg+KYAWw0qtwhIvgjUQQHiCBlNJGxJ8Ib
         Rc+iR+lLdzp5XoOQBA7LmO4MF+RMDHqr36OVR1Z/1QQ5VynxNhAUPnVHQ/B7Kbo7m2qv
         mplIdc4NYGCpg2SzKcTscWZMr4GcQVfFNNAsIrm5eQJZvAuRbAxZrqBY1H6WF0IA+PfI
         j3vr6BWExjVnJn79Y4/W0Rru+lCni5FcAj+QYDazYekcN/fTJHDtHkbtJGCzAfU5PW8S
         U/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435183; x=1761039983;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bKZTYq6/6Otgm4/JoAPAscRI3Nhvh8qLkW+Q3h459I=;
        b=IGnAX9Joef86Y5ZofQZXYNLeTMCpV8swJrtahZY6Rgat5oslFmmIspwxKA+v98dXkh
         MxDJ9xzZ0zrXdXyFfLhUHiyLDZ6G+XJ2bfwtEJDMeVufC2lCcMWR4GXYsouPDmWvq86+
         OUlNvWfmqUGlNWqduiX8FhBiFwIirRC2RukzVBFGMj5ODroTdSenLoLgO2VcPXo0VTv9
         ZUR1Gc3OlLyN9OEbfInSnJo5DQZpaa5pL9Rb1CWy3yv4SMdc1/CpnQjKSGz6HOud00KP
         SwnXLE0KRlnvpPMCpFQrG8z5A9sg5q+L22BFWdLhRb9WyE/nUJ57sHJQXUrpvNMvXMTP
         CSVA==
X-Forwarded-Encrypted: i=1; AJvYcCWRamXCxseaL1A8CTPa53pVViStN7OCKEc8SIN7Bamrm6vwLvJ2r/pYYpgn61OpkQ4heHdTDsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzSZwt7iDcg2zKbsZ2DlC49Lc7ww5p35mpNXOAR0cADS/ZUZB+
	97q0Gu7xPFENmFKbXx+gbou6S0AmWNaTswYVx9rv/aJJo7jNVWGFApxm/DTyHByCaV8=
X-Gm-Gg: ASbGncv6fdsCUjBSAjgpVGgm/9kSLr0jMU9MEbRR44o/buTUPGI/qyvaM1ie01YlbOo
	ymATRf/jHhjda59/n/58/5bVgq+KaG0EDzo3xUGAJag6kQp/vmE8avz/S+k4LL4XoV0p19HoDFE
	J+XBxUgvfLV0gEwb8mh7i9BjAo9jPalYaulza4JmNU/JPnNk0mrMUm27AIB0+S7cR9psGZ+Cm3q
	ODpTYVTMJWoXJF1DxatwKRD0oofvLM/jMHaAj9QApqLR2xfigzxz/VtEOcCugCs8qdQNzef4J5I
	9BV8x4wtBdFDQr8gEl7ibB+3cgWWo0zuB44xsQWLoFTjiHDf9UOm6XO49KSDdm4YZ9rXjTABf5r
	wF0qzYgV0MCPWyRLiuC4/naoMpXfqwUiDKRRukfZIDCJ5Pd9gXUIOcA==
X-Google-Smtp-Source: AGHT+IEUB3DwM5KbLo0YAJy95OK5FzaMYTEWXQtizciZwE/s3oqnbKLTxn0r/kkXbHky5tXVsGFBvg==
X-Received: by 2002:a05:6000:2305:b0:3ea:c360:ff88 with SMTP id ffacd0b85a97d-4266e7dffe5mr15539748f8f.31.1760435183185;
        Tue, 14 Oct 2025 02:46:23 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8b31sm22866442f8f.54.2025.10.14.02.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:46:20 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH RESEND v3 0/3] phy: qcom: edp: Add missing ref clock to
 x1e80100
Date: Tue, 14 Oct 2025 12:46:02 +0300
Message-Id: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANob7mgC/42NPQvCMBRF/4pk9kmaUhudHOzqoKM4pPloH7ZJT
 aRYSv+7IYs4KQ8e3HvhnJkE7VEHsl/NxOsRAzobQ75eEdkK22hAFTNhlBW0zCkM7QQP6XrQagC
 hFPQYAtoGvDayu0Mhas7iGa5LEilD7PGVDFdyri7V6UhusW8xPJ2fknjM0vq3Y8yAwtaUXBgtV
 C3NoUMrvNs43yT4yD7AHc1/A1kEKs5lVlOp4v8CLsvyBsfdUy0oAQAA
X-Change-ID: 20250730-phy-qcom-edp-add-missing-refclk-5ab82828f8e7
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=l3LysOIyApMjrPfw785wmo0UxKg51Ii7YvKFAglf7l4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7hvgVAHgN7NhN1/gnFmV/M7oRWvD9UaYEhDcp
 EFbt/WOLzOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO4b4AAKCRAbX0TJAJUV
 VjPUD/4vUoPpHoZQWjDPWDIax0TPyCIZXxnvSmDbXKi4MhCqrcHcqwDOearqPMQ8sxSM7QmlQ2b
 KGS0+yeAvLVpGGIfMzL8PbjdspuFBqqa7HRvq26iaynnnb3XzBwtY82XMW05SAVh1mA8c3frW+v
 TyrcvmlnC9nUqZlQPiaheoyJ3+KPOKIL/IHSBSonTKoWTEhFTIzQT08A+MlJKAEatGZ8Rw1j6O5
 bT0eISB85t7O7wRCXnUsvw+3dVF5dCQA/EW7KR4XnYcAAikYMTTi2F+QM7hPnP36UWs44pSaq/u
 CiLbgozuozyDaM8SZwSEyiPC/mbRyIuOpWYeyeAj7zE9b9QE4wtFZYqUiXLFpkcTu+vTjuHKx/J
 9Cx8cSdYudTX3X2dT3KQgvqPuM1+mFkpeYnibSDgQqLYs4cC2/NyoqabG5B0Ba60cWZjoaWLw+Q
 qOnjtM5NFKVKHHsFOP9hUOYgBI7CkHoQRG47iXJ50lmvCUqR31nrSRkYGPOwAZ5AqsFUlDZG4K6
 pWnso6ZqhODJmEFSympcsTLFII5/A+1PMhzlDp4v++C2h/kbeks3HH0UfGyTSPcWQ0goKvw2Dpa
 B8lZPdjzvzgIKMyx8lnE6jsr7wqd60+pO+J9TJpzPASUa52RGX7eDdrtisyyrZ8hW5qDG7+2EFB
 CTJZTSy9WL91a8w==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

According to documentation, the DP PHY on x1e80100 has another clock
called ref.

The current X Elite devices supported upstream work fine without this
clock, because the boot firmware leaves this clock enabled. But we should
not rely on that. Also, when it comes to power management, this clock
needs to be also disabled on suspend. So even though this change breaks
the ABI, it is needed in order to make we disable this clock on runtime
PM, when that is going to be enabled in the driver.

So rework the driver to allow different number of clocks, fix the
dt-bindings schema and add the clock to the DT node as well.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v3 (resend)
- picked-up Krzysztof's R-b tag for bindings patch

Changes in v3:
- Use dev_err_probe() on clocks parsing failure.
- Explain why the ABI break is necessary.
- Drop the extra 'clk' suffix from the clock name. So ref instead of
  refclk.
- Link to v2: https://lore.kernel.org/r/20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org

Changes in v2:
- Fix schema by adding the minItems, as suggested by Krzysztof.
- Use devm_clk_bulk_get_all, as suggested by Konrad.
- Rephrase the commit messages to reflect the flexible number of clocks.
- Link to v1: https://lore.kernel.org/r/20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org

---
Abel Vesa (3):
      dt-bindings: phy: qcom-edp: Add missing clock for X Elite
      phy: qcom: edp: Make the number of clocks flexible
      arm64: dts: qcom: Add missing TCSR ref clock to the DP PHYs

 .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 28 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 12 ++++++----
 drivers/phy/qualcomm/phy-qcom-edp.c                | 16 ++++++-------
 3 files changed, 43 insertions(+), 13 deletions(-)
---
base-commit: 52ba76324a9d7c39830c850999210a36ef023cde
change-id: 20250730-phy-qcom-edp-add-missing-refclk-5ab82828f8e7

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


