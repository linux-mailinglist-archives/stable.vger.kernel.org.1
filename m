Return-Path: <stable+bounces-124453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE6EA61519
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 16:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6C53B7DA6
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 15:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8275202972;
	Fri, 14 Mar 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sU+XJX8y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1783A8F7
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966699; cv=none; b=IiU4OuioOMLnUZ4iBPR/ifdYpDYTglAHlQm9zMMBeOUOMyiH49xom0yCPq/0ejjVmoI4bvjTGII9IJBfp5pC74abhiIjHvSA+sms08AaR88XMrA3slM7g3DOnZEduB6GfUQYVI5pRqn/ksFokZQBxQ+95C/qDvUo14bFnALnfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966699; c=relaxed/simple;
	bh=o5lWvEifxc0qjQ0Mf/yS+nQ6Yi9AnPndoKFhVA2M9Yw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MihnVEi8TxEneMIpWaAgD0OaI/RUxmVbT3gPClgx75RjhfqOz7QuGpwfn6SKx1UI4YPDmsyrZOQWYKlxFVEX44NbfuPy9ynNt61ArM3I+Irghs82O54wdltg8GVPucL2Ekvr4WET93R+C8vQ45R+LNhc4205lUWP9pWdYHChnhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sU+XJX8y; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3965c995151so1331472f8f.1
        for <stable@vger.kernel.org>; Fri, 14 Mar 2025 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741966695; x=1742571495; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rRs3uWiyY/mmy9tnZPMQQhl+KBtI48hCPbm64UgfZtU=;
        b=sU+XJX8y1OoRuisxvMZTDkl32849hc4q4EoUDxJZUcI0X3Q+EvJCN1cRjRushyEI7i
         sL+c6ZGrM0E1QWHIzqPvIYa3+Fa4TsxEfjbkDiDEfK+fVaFSyoNbZh74vb145KaEfmCP
         VzSjcUJaOWWURnMrg7QY20xdgnf0ARCMuc4xEXq+EssuQYyGpkNoBcOlQxFY6sbHIsie
         8auNDZF08eNULAcqj08hPfCXuAIp7o/jVz4bgMdi1k+1Ioi6LbQ6eT8CZvM/HNFWuDGl
         GmynQa9Va8V2R8yTjYXhf8AjlVK76L212Gv2lyFn1zztgBNWDV+TeMkXjjfh28S/Pm1e
         knZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741966695; x=1742571495;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRs3uWiyY/mmy9tnZPMQQhl+KBtI48hCPbm64UgfZtU=;
        b=I1hf+Xj5GC6LV6T2STAJhabdcJB2CMxxCjS8BaugnTC++PKW63YrvBDZ1u+4hLYcHH
         TmyYks1Sr2EQ4sxjMPal0LBdZPngm3ccEbNcSLzNlankKyyEd6sXwfwy1P+ofLT3b8v0
         SmWmsQfCtcPButpBr02k4NdlaMiAhnS8ZLevV8XnM/meyaqoBvpIsyhLPDwL0j5bypCj
         zPikh/BrzbuI2OcZb73H4c+XuOEPP/DTt16y6jzHlhEFq2mK5gWOR76NFJFC9Y12exVC
         ADomSi+NI9aMhOg+mN5gzGfEDOXTkE7UcMvyXSpCJSNnztsY2C1cl6HTLxQe14h78Iq4
         jVNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkPvkX1QzmgVS46yFplJRwgAuyWwi5FHsg4a6xgCXJZbpMR5O7jl5ZvFNfr+HEinEbqG2VLoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+sm1xElSJ52HdRljt8YpFBLZ8mnlP6ndXmtf2ZmagofQfqMn
	nwcpjSGxqwVdvaD5uvN5M5Wnp03z+kBV9ULzaRY8m7/YvCzCZqWXATFIq4i95Dc=
X-Gm-Gg: ASbGncsRuqmgLJUDQTocF1ZwOARNRQDZ+YgBdPz5/ti5aL66HpT+ue4B4UlZVDTCAij
	q99XwjfN9EuNF03jEOkrCkqi+doNXVw9rLA35bRdIrgfaT4ZMRnt2JSAcf5GrwS4G8FvRFzFtsP
	xY17mL7wuiZx8UnvtlYGGzK8Enlexs5MAVfu/pdwMGAo0+nQtlydiDDqueSIXlRxG6kIsJizNFI
	HxIzK7HnKnXMI7GbH/kbS53153/i5OeJyt01kbLKUK2J9U2RPNOBKrhNnAyVkp+MJdLsQlHildF
	kEgPDKDGijtAVE5Mrb6+O7BJKCt8GdYdV/4SYxb26hMdnrqGKFVar+uOy1kghS2FklHXhIkqkUY
	LHknC6ZfuYyk=
X-Google-Smtp-Source: AGHT+IFwuWplOyRsVTnwWP9hDzjpPB2Fz832AbMy5akm4Qo/B37yxprGTMiWIsI8eBrUb37930ldcw==
X-Received: by 2002:a05:6000:1a85:b0:390:f902:f961 with SMTP id ffacd0b85a97d-3971ef3a523mr3576489f8f.45.1741966695091;
        Fri, 14 Mar 2025 08:38:15 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([209.198.129.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdafsm5944388f8f.62.2025.03.14.08.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:38:14 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 0/2] Add dma-coherent for gs101 UFS dt node
Date: Fri, 14 Mar 2025 15:38:01 +0000
Message-Id: <20250314-ufs-dma-coherent-v1-0-bdf9f9be2919@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFlN1GcC/x3MTQqAIBBA4avErBsws9+rRAvRsWaRhVYE0t2Tl
 t/ivQSRAlOEsUgQ6ObIu8+oygLMqv1CyDYbpJCNqCuFl4toN41mXymQP3HohZOq7dpBWMjZEcj
 x8y+n+X0/4DkMHmIAAAA=
X-Change-ID: 20250314-ufs-dma-coherent-980f2467690d
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, kernel-team@android.com, 
 willmcvicker@google.com, Peter Griffin <peter.griffin@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=o5lWvEifxc0qjQ0Mf/yS+nQ6Yi9AnPndoKFhVA2M9Yw=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBn1E1kE5cKvQLvj5p+5qVAv9trKYfZ8ei16ff+B
 z9YeJd+wl+JAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ9RNZAAKCRDO6LjWAjRy
 uq9UD/47wDnkd+uHDPcz0khALhZQzKJVJn2IE2m2IexznRG9WHqTq0nvONALdAhgP6iOR95GzTk
 buhR+wkbwEMJCLy4Xu21/WQFe08H40eZtljBwKUa6pKYaMUyLWqk2D+J5tEE5Z5qeaHSFvgfl0I
 /VXX1NW+3uOnew10YZk1QuVJ7UtmIdESlUCL3VhcrMgi1IZR8BWB6e6MZ/ekOnsIwCX9nMUD5wk
 t6lBCkuDGVaXdkIbsQDsu541pAokWIm+96oMohVbZ3EU0BtGZk4CbKfauP73p3POtRatLI8qbUN
 vuKpMwVWaAZ2vtA07o9GDE9XnhBqsR9Aj2KeHcLapVHRZEAQW+FCEu1zbtDzN/l2YJ1UM1avBGp
 ANxs0cjpKjmpJXStyNKEOODbUwJgvHqrzIEAxGZz/nPP4+KqHcYutR4b3nkRgmv2Cr7BoZk1xF1
 XDyOJ3URvPRl66sqSx3fgQ8bMsH+gfSipoq2O09wr1ePpX+xU2aKTRkTh4TralInxmN0xDOyPUy
 M3sTmxXKXmvLZSkWGgC1+t9YmrGE0BhwlLRP7ZFZHYRT4FDGgeaPn4/N32S5YfddBHVxsHZHx+B
 lF84ISrushp9Fktak/z0TwJ6y//hZwsKDARvxSYb8LkhQ6VKF44q7NTSlMwJegIs9ZxjVHwKF1M
 hDyrOsEFbKuKWjw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

ufs-exynos driver enables the shareability option for gs101 which
means the descriptors need to be allocated as cacheable.

Fix the DT node and update bindings to add the dma-coherent property.

This fixes the UFS stability issues we have seen with the upstream
UFS driver.

Note this DT fix can go in independently of the other UFS fixes series
I sent recently [1], as the bootloader already leaves the sharability
bits enabled.

regards,

Peter

[1] https://lore.kernel.org/linux-scsi/20250226220414.343659-1-peter.griffin@linaro.org/

To: André Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Alim Akhtar <alim.akhtar@samsung.com>
To: Avri Altman <avri.altman@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
To: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: kernel-team@android.com
Cc: willmcvicker@google.com

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Peter Griffin (2):
      arm64: dts: exynos: gs101: ufs: add dma-coherent property
      scsi: ufs: dt-bindings: exynos: add dma-coherent property for gs101

 Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml | 2 ++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi                  | 1 +
 2 files changed, 3 insertions(+)
---
base-commit: b323d8e7bc03d27dec646bfdccb7d1a92411f189
change-id: 20250314-ufs-dma-coherent-980f2467690d

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>


