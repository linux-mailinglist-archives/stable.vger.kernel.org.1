Return-Path: <stable+bounces-20453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D9C859739
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 14:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE97A28107D
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2E66BFBE;
	Sun, 18 Feb 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDg8q6aQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D76BFA4
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708264599; cv=none; b=UEtYijvAgJ6dbFH//lgQv1p2lFVKKvf3fk5LqtLx5qagOIw9RjdZ6l6rAZYbTNoVzO7u26xyG/LMfFnvaBtfic85mddmgivbKFv0GE3/4f8UqWEj2v0qAWRmVNnww7Tp93Q/EvDGqkvzRlupThxcE+/TP4OFmRbA1KAz4ChMClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708264599; c=relaxed/simple;
	bh=ci6508isWS3DLnsNXAok8Q9FDqHEGa3Yr+YBdNnPpMw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h1HIh3lWaCqvAfcxQqP4CqqAiTkFGcA1MM5oMIO+au8+P5EGIKBnaY1Al92cmlVmS3P+yUPrG7V2hmV3FnvMxcVDEQsRawWK6jab0Vmc6AfOXP5ZXgjGEuUVzmbebCS2pKhAxuQ6Sw3+JqX3L6wbovIub+VuVzUh2Trle9h7iHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YDg8q6aQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5120ecfd75cso4917017e87.0
        for <stable@vger.kernel.org>; Sun, 18 Feb 2024 05:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708264596; x=1708869396; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzBE6z8JZK5HKrVHvDR9HlvBapuvmsOASU8Mw6XD3AI=;
        b=YDg8q6aQ4a9ycWfJRvQ94Wa4XCGX4gxp8pxRcSZQXkkUfRwfqocrbhX5Qp+3zizYl0
         V6x5MzQO0Vrm3L3vZtxb4OIeJKliqjLjlh26GafwzOqDxh+kIPl2aGTnKjbKIKsBFuC6
         PvlHqynypzE6RnzUgbagjP34ktLHnKmCNB/3mNsDVjd9gLwpN8FcI6Kk3Uxl40JiOgug
         WkA3O+EDQq7gv4aZHmKzsXtogrKFXgiNtJgvDFj/S8SSjFtF/gjgq5ALS6FJkah3+S6U
         6taAF65v1iUJFUgyA23mZA5myeglLgxXQtKAs2Yoo9QdeJvQfwlSLh+PTJ48aYsYxQlV
         eOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708264596; x=1708869396;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzBE6z8JZK5HKrVHvDR9HlvBapuvmsOASU8Mw6XD3AI=;
        b=Xzc+Zsf7OkLLJByry6WtRfaL8pDnOhvh0OW24p+24Q9zX32P2Lnl6ajgpHXUM/yz01
         +dc6mhDiusw19QQUu7mw25jTogQDYhpH8vP2jj+0MHgb9+4g0Py2BUhcFAyYGm2gqJqX
         HAYbbqtRLTEWJ4bVfQWOYdxTqFLD0NK3cvRXRSmtnigj5WCC5crAE20gAeZk/SaoVUuv
         wE+yzbE7dCk7LUtuBMjROTPL0OZGg874QqqPJdf2sIAKG14LwxL7WeA7UN9if+VevQIN
         gnu6w4ZBYrhFrFsV4leHh9HVk9xZ9beWutJ94hXZgZKMkVU7k7s/qOscikKdm+Olm9O7
         NFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUG9f1wTKFrPy4A6HTGkA9asF9vnQhaKeSuf/VqqkVC3ZUWGjeJugTmk8q49x4Dbc5OozNdtKGj6ascqeZsEO69dhYOeZ/
X-Gm-Message-State: AOJu0YxKzHH1tbv8eVIDtVXhppMZMoSbYtMacT2ZN9FNqZMDV2Ya3qhL
	rFCCxmaPeJQSxKUan6lUMOaK9Bzb/AUAbm17cgX+J67XjJ24vZRhw0NMLFjXDqM=
X-Google-Smtp-Source: AGHT+IGBiQXe9hCbSiSsX7aXyrK8He/iitn6PU0S3WxrJlhNJ9PbtND+70+T69ZJrfjblnmgLS5gqA==
X-Received: by 2002:ac2:529c:0:b0:512:b051:7b02 with SMTP id q28-20020ac2529c000000b00512b0517b02mr683047lfm.0.1708264596326;
        Sun, 18 Feb 2024 05:56:36 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651204c900b005119fdbac87sm548698lfq.289.2024.02.18.05.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 05:56:35 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 0/5] scsi: ufs: qcom: fix UFSDHCD support on MSM8996
 platform
Date: Sun, 18 Feb 2024 15:56:33 +0200
Message-Id: <20240218-msm8996-fix-ufs-v3-0-40aab49899a3@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJEM0mUC/3XNwQ6CMAyA4VchPTvTlW0MT76H8YCwwRJhZtNFQ
 3h3ByeN8fi36dcZognORDgUMwSTXHR+ylHuCmiHZuoNc11uICSBhDUb46jrWjHrnuxhI7MaG6M
 60enWQr66BZNXm3g65x5cvPvw2h4kvk7/W4kzZByriyQjK0F4vLqpCX7vQw8rlugD4OUvQBlQE
 iupW1JC6i9gWZY3wR8WmPAAAAA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Nitin Rawat <quic_nitirawa@quicinc.com>, Can Guo <quic_cang@quicinc.com>, 
 Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 devicetree@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ci6508isWS3DLnsNXAok8Q9FDqHEGa3Yr+YBdNnPpMw=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+olnkm17zmdWrXNdT4Gt0iyy2VKxvRaX+Cd6vBpbcLrF
 /tLZ2zoZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBE+g04GGYd1C4/JrzlOP/7
 7ToHWWfcdJ3/IX6Z4Afrx/OWhQuK7+pd07A28f+nKR6CjM8527W2bIh8Numf4L/bH52TZNUzpOR
 v+/4pEk0tYreTlf4gGp0ls9SS+3ROxVfTavGYJy/eOIW5BUtLpVfVOc6YMG3OLLfiJaWH5CYrf7
 oe1R7y7NFieeZKhYpD196oaN0q01bUDbCfxrpj1a2wX9re3947R193+/Wj3ciR6b/4ec8EnaMJV
 vMb/2TM28tqbibmE3CXmeGom6UBU/+MHlv2Rj3jYPnADXrmX+carts+SUem5aPytbQbr4XsPjUI
 bOtnaqi/9leVYQsH96HOWFsWy2+5L1R9pjLq3zp+aYcuAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

First several patches target fixing the UFS support on the Qualcomm
MSM8996 / APQ8096 platforms, broken by the commit b4e13e1ae95e ("scsi:
ufs: qcom: Add multiple frequency support for MAX_CORE_CLK_1US_CYCLES").
Last two patches clean up the UFS DT device on that platform to follow
the bindings on other MSM8969 platforms. If such breaking change is
unacceptable, they can be simply ignored, merging fixes only.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v3:
- dropped the patch conflicting with Yassine's patch that got accepted
- Cc stable on the UFS change (Manivannan)
- Fixed typos in the commit message (Manivannan)
- Link to v2: https://lore.kernel.org/r/20240213-msm8996-fix-ufs-v2-0-650758c26458@linaro.org

Changes in v2:
- Dropped patches adding RX_SYMBOL_1_CLK, MSM8996 uses single lane
  (Krzysztof).
- Link to v1: https://lore.kernel.org/r/20240209-msm8996-fix-ufs-v1-0-107b52e57420@linaro.org

---
Dmitry Baryshkov (5):
      scsi: ufs: qcom: provide default cycles_in_1us value
      arm64: dts: qcom: msm8996: specify UFS core_clk frequencies
      arm64: dts: qcom: msm8996: set GCC_UFS_ICE_CORE_CLK freq directly
      dt-bindings: ufs: qcom,ufs: drop source clock entries
      arm64: dts: qcom: msm8996: drop source clock entries from the UFS node

 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 12 +++++-------
 arch/arm64/boot/dts/qcom/msm8996.dtsi               |  8 +-------
 drivers/ufs/host/ufs-qcom.c                         |  6 ++++--
 3 files changed, 10 insertions(+), 16 deletions(-)
---
base-commit: 0035c3918a74a83f94158fbbd667e163bfd4a0d0
change-id: 20240209-msm8996-fix-ufs-f80ae6d4d8cf

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


